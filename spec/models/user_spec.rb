require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:attributes) do 
      {
        username: 'Josue',
        password: 'asdf',
        password_confirmation: 'asdf',
        full_name: 'Son Goku'
      }
    end

    subject { User.create(attributes).valid? }

    it { expect(subject).to be true }

    context 'username' do
      context 'is invalid when length is less than 2' do
        let(:attributes) do 
          {
            username: 'J',
            password: 'asdf',
            password_confirmation: 'asdf',
            full_name: 'Son Goku'
          }
        end

        it { expect(subject).to be false }
      end

      context 'is invalid when length is more than 10' do
        let(:attributes) do 
          {
            username: 'JosueHernandez',
            password: 'asdf',
            password_confirmation: 'asdf',
            full_name: 'Son Goku'
          }
        end

        it { expect(subject).to be false }
      end

      context 'is invalid if not unique' do
        before do
          User.create(attributes)
        end

        it { expect(subject).to be false }
      end
    end

    context 'password' do
      context 'is invalid when length is less than 4' do
        let(:attributes) do 
          {
            username: 'Josue',
            password: 'asd',
            password_confirmation: 'asd',
            full_name: 'Son Goku'
          }
        end

        it { expect(subject).to be false }
      end
    end
  end
end