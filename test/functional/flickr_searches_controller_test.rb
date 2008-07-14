require 'test_helper'

class FlickrSearchesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:flickr_searches)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_flickr_search
    assert_difference('FlickrSearch.count') do
      post :create, :flickr_search => { }
    end

    assert_redirected_to flickr_search_path(assigns(:flickr_search))
  end

  def test_should_show_flickr_search
    get :show, :id => flickr_searches(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => flickr_searches(:one).id
    assert_response :success
  end

  def test_should_update_flickr_search
    put :update, :id => flickr_searches(:one).id, :flickr_search => { }
    assert_redirected_to flickr_search_path(assigns(:flickr_search))
  end

  def test_should_destroy_flickr_search
    assert_difference('FlickrSearch.count', -1) do
      delete :destroy, :id => flickr_searches(:one).id
    end

    assert_redirected_to flickr_searches_path
  end
end
