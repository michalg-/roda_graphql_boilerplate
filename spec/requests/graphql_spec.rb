# frozen_string_literal: true

describe('GraphqlRequest', type: :request) do
  let(:query) { IO.read('./spec/graphql_queries/query/base.graphql') }

  describe 'POST /graphql' do
    subject(:request) { post('/graphql', query: query) }

    it 'calls Schema' do
      allow(Schema).to(receive(:execute))

      request

      expect(Schema).to(
        have_received(:execute).with(
          query,
          variables: nil,
          context: {},
          operation_name: nil
        )
      )
    end

    it 'returns ok' do
      expect(json_response).to(eq('data' => { 'test' => 'ok' }))
    end
  end
end
