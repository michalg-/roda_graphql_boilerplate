# frozen_string_literal: true
describe 'QueryType#test' do
  subject(:response) { execute_schema('query/base') }

  it { expect(response['data']['test']).to(eq('ok')) }
end
