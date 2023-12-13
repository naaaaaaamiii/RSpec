require 'rails_helper'
# spec/rails_helper.rbを読み込んでいる(設定を行うファイル)
RSpec.describe 'Bookモデルのテスト', type: :model do
  # Bookモデルのテストを行う。Bookモデルのファイルはspec/modelにあるからそこにあるよってタグ付けしてる。
  # 規定のディレクトリ以外の場所にファイルがあるときrspec-railsの用意するヘルパーをexampleの中で使えるようにするための記述
  describe 'バリデーションのテスト' do
    subject { book.valid? }

    let(:user) { create(:user) }
    let!(:book) { build(:book, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        book.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        book.body = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        book.body = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        book.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
