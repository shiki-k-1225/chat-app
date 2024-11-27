require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do  # "s"は削除しました
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに偏移する
    visit root_path

    # ログインしていない場合、サインインページに偏移していることを確認する
    expect(page).to have_current_path(new_user_session_path)  # スペルミスを修正しました
  end

  it 'ログインに成功し、トップページに偏移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # サインインページへ移動する
    visit new_user_session_path

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    # ログインボタンをクリックする
    click_button 'Log in'

    # トップページに偏移していることを確認する
    expect(page).to have_current_path(root_path)
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # トップページに偏移する
    visit root_path

    # ログインしていない場合、サインインページに偏移していることを確認する
    expect(page).to have_current_path(new_user_session_path)

    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: 'test'
    fill_in 'user_password', with: 'test'

    # ログインボタンをクリックする
    click_button('Log in')

    # サインインページに戻ってきていることを確認する
    expect(page).to have_current_path(new_user_session_path)
  end
end
