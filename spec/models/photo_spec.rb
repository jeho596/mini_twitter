require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe 'validations' do
    let(:params) { { url: 'img/user' } }
    subject { user.create_photo(params).valid? }

    it { expect(subject).to be true }

    context 'url' do
      context 'The url must be present' do
        let(:params) { { url: '' } }

        it { expect(subject).to be false }
      end
    end
  end

end
