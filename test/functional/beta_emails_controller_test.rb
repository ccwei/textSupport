require 'test_helper'

class BetaEmailsControllerTest < ActionController::TestCase
  setup do
    @beta_email = beta_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beta_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beta_email" do
    assert_difference('BetaEmail.count') do
      post :create, beta_email: @beta_email.attributes
    end

    assert_redirected_to beta_email_path(assigns(:beta_email))
  end

  test "should show beta_email" do
    get :show, id: @beta_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @beta_email
    assert_response :success
  end

  test "should update beta_email" do
    put :update, id: @beta_email, beta_email: @beta_email.attributes
    assert_redirected_to beta_email_path(assigns(:beta_email))
  end

  test "should destroy beta_email" do
    assert_difference('BetaEmail.count', -1) do
      delete :destroy, id: @beta_email
    end

    assert_redirected_to beta_emails_path
  end
end
