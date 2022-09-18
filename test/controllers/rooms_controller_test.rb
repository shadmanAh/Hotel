require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:one)
  end

  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_room_url
    assert_response :success
  end

  test "should create room" do
    assert_difference("Room.count") do
      post rooms_url, params: { room: { bed: @room.bed, book: @room.book, capacity: @room.capacity, check-in: @room.check-in, check-out: @room.check-out, description: @room.description, hostel_id: @room.hostel_id, price: @room.price, short-description: @room.short-description, size: @room.size, title: @room.title, view: @room.view } }
    end

    assert_redirected_to room_url(Room.last)
  end

  test "should show room" do
    get room_url(@room)
    assert_response :success
  end

  test "should get edit" do
    get edit_room_url(@room)
    assert_response :success
  end

  test "should update room" do
    patch room_url(@room), params: { room: { bed: @room.bed, book: @room.book, capacity: @room.capacity, check-in: @room.check-in, check-out: @room.check-out, description: @room.description, hostel_id: @room.hostel_id, price: @room.price, short-description: @room.short-description, size: @room.size, title: @room.title, view: @room.view } }
    assert_redirected_to room_url(@room)
  end

  test "should destroy room" do
    assert_difference("Room.count", -1) do
      delete room_url(@room)
    end

    assert_redirected_to rooms_url
  end
end
