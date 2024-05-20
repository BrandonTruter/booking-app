# frozen_string_literal: true

RSpec.shared_examples 'there must be a Set-Cookie in Header' do
  it 'returns a Set-Cookie Header' do
    subject
    expect(response.headers.keys).to include('Set-Cookie')
  end
end
