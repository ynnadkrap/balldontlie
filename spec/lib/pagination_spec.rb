# frozen_string_literal: true

describe 'Pagination' do
  let!(:klass) { Class.new { include Pagination }.new }

  describe 'per_page' do
    context 'when no page size is specified' do
      it 'returns the default page size' do
        expect(klass.per_page(nil)).to eq Pagination::DEFAULT_PAGE_SIZE
      end
    end

    context 'when a page size larger than max is specified' do
      it 'returns the max page size' do
        expect(klass.per_page(9999)).to eq Pagination::MAX_PAGE_SIZE
      end
    end

    context 'when page size is specified and smaller than max' do
      it 'returns the specified page size' do
        expect(klass.per_page('50')).to eq 50
      end
    end
  end
end
