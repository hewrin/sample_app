require 'test_helper'


class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:Faris)
  end    

  test "login wtih invalid information" do 
    get login_path #visit login path
    assert_template 'sessions/new' #verify that new session form renders properly
    post login_path, session: { email: "", password: ""} #post to session path with invalid path
    assert_template 'sessions/new' #verify browser redirects to session form 
    assert_not flash.empty?         #and will show flash message
    get root_path #go to another page to check to make surre flash message dissappear
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, session: {email: @user.email, password: 'password'}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 #tests to see if there is zero login path links
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    #simulate a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count:0
    assert_select "a[href=?]", user_path(@user), count:0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
