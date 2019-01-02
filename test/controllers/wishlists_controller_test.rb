require 'test_helper'

class WishlistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wishlist = wishlists(:one)
  end

  test "should get index" do
    get wishlists_url
    assert_response :success
  end

  test "should get new" do
    get new_wishlist_url
    assert_response :success
  end

  test "should create wishlist" do
    assert_difference('Wishlist.count') do
      post wishlists_url, params: { wishlist: { author_id: @wishlist.author_id, expected_release: @wishlist.expected_release, image_url: @wishlist.image_url, martinus_url: @wishlist.martinus_url, name: @wishlist.name, note: @wishlist.note, pages: @wishlist.pages, price: @wishlist.price, publish_year: @wishlist.publish_year, publisher_id: @wishlist.publisher_id, user_id_id: @wishlist.user_id_id } }
    end

    assert_redirected_to wishlist_url(Wishlist.last)
  end

  test "should show wishlist" do
    get wishlist_url(@wishlist)
    assert_response :success
  end

  test "should get edit" do
    get edit_wishlist_url(@wishlist)
    assert_response :success
  end

  test "should update wishlist" do
    patch wishlist_url(@wishlist), params: { wishlist: { author_id: @wishlist.author_id, expected_release: @wishlist.expected_release, image_url: @wishlist.image_url, martinus_url: @wishlist.martinus_url, name: @wishlist.name, note: @wishlist.note, pages: @wishlist.pages, price: @wishlist.price, publish_year: @wishlist.publish_year, publisher_id: @wishlist.publisher_id, user_id_id: @wishlist.user_id_id } }
    assert_redirected_to wishlist_url(@wishlist)
  end

  test "should destroy wishlist" do
    assert_difference('Wishlist.count', -1) do
      delete wishlist_url(@wishlist)
    end

    assert_redirected_to wishlists_url
  end
end
