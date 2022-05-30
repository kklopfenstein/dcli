# frozen_string_literal: true

RSpec.describe Dcli do
  it 'has a version number' do
    expect(Dcli::VERSION).not_to be nil
  end

  describe '#run' do
    subject { described_class.run(argv, output: stdout) }

    let(:argv) { [command_name, arguments].flatten }
    let(:stdout) { double('stdout') }

    context 'executes command successfully' do
      let(:command_name) { 'command-name' }
      let(:arguments) { ['--arg', 'value'] }
      let(:options) do
        {
          command: command_name,
          arg: 'value'
        }
      end
      let(:options_parser) do
        options_parser = double('option_parser')
        allow(options_parser).to receive(:options).and_return(options)
        options_parser
      end
      let(:command_instance) do
        double('command_instance')
      end
      let(:command) do
        command = double('command')
        allow(command).to receive(:new).and_return(command_instance)
        command
      end

      before do
        allow(stdout).to receive(:puts)
        allow(Dcli::Options).to receive(:new).and_return(options_parser)
        allow(Dcli::Commands).to receive(:command_for_name).with(command_name).and_return(command)
      end

      it 'executes command and returns success' do
        expect(command_instance).to receive(:execute).with(stdout)
        expect(subject).to eq(0)
      end
    end
  end
end
