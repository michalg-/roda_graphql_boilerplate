# frozen_string_literal: true
describe Types::MutationType do
  describe 'test' do
    subject(:response) do
      execute_schema(
        'mutation/test',
        variables: {
          test: test,
        }
      )
    end

    context 'when test is positive' do
      let(:test) { 'positive' }

      it { expect(response['data']['test']['testResponse']).to(eq('positive')) }
    end

    context 'when test is negative' do
      let(:test) { 'negative' }

      it { expect(response['data']['test']['errors'][0]['message']).to(eq('Test is negative')) }
    end
  end
end
