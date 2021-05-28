# frozen_string_literal: true

describe('GraphqlRequest', type: :request) do
  let(:query) { IO.read('./spec/graphql_queries/query/base.graphql') }
  describe 'POST /graphql' do
    subject { post('/graphql', query: query) }

    it 'calls Schema' do
      expect(Schema).to(
        receive(:execute).with(
          query,
          variables: nil,
          context: {},
          operation_name: nil
        )
      )

      subject
    end

    it 'returns ok' do
      expect(json_response).to(eq('data' => { 'test' => 'ok' }))
    end
  end
end
