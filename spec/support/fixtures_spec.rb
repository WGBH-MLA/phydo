require_relative 'fixtures'

describe Fixtures do

  before(:all) do
    @tmp_dir = File.join(File.dirname(__FILE__), 'fixtures_tmp')
    FileUtils.mkdir_p(@tmp_dir)
    # Write a sample fixture
    File.open(File.join(@tmp_dir, 'foo.txt'), 'w') { |f| f.write("bar") }
    Fixtures.base_path = @tmp_dir
  end

  after(:all) do
    FileUtils.remove_entry_secure(@tmp_dir)
    Fixtures.base_path = nil
  end

  describe '.read' do
    it 'returns the contents of a fixture file' do
      expect(Fixtures.read('foo.txt')).to eq 'bar'
    end
  end

  describe '.open' do

    subject { Fixtures.open('foo.txt') }

    it 'returns a File object for the fixture file' do
      expect(subject).to be_a File
      expect(File.basename(subject.path)).to eq 'foo.txt'
    end

    it 'raises an error if the fixture file does not exist' do
      expect { Fixtures.open('bogus') }.to raise_error Fixtures::NotFound
    end
  end

end