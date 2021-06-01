# frozen_string_literal: true

describe Schema do
  let(:schema) { described_class.to_definition }
  let(:idl) { File.read(File.join(APP_ROOT, 'app/graphql/schema.idl')) }

  it 'has performed rake graphql:schema:dump' do
    expect(schema).to(eq(idl))
  end
end
