# frozen_string_literal: true
describe Types::QueryType do
  describe 'test' do
    subject(:response) { execute_schema('query/base') }

    it { expect(response['data']['test']).to(eq('ok')) }
  end
end
