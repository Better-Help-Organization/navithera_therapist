// chat_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/chat_models.dart';

part 'chat_remote_data_source.g.dart';

@RestApi()
abstract class ChatRemoteDataSource {
  factory ChatRemoteDataSource(Dio dio) = _ChatRemoteDataSource;

  @GET('/therapist/me/chats')
  Future<ChatListResponse> getChatThreads({
    @Query('page') int? page,
    @Query('take') int? take,
    @Query('fields')
    String? fields =
        'id,updatedAt,unreadCount,groupName,'
            'client.id,client.firstName,client.lastName,client.avatar,'
            'group.id,group.firstName,group.lastName,group.avatar,'
            'therapist.id,therapist.firstName,therapist.lastName,therapist.avatar,'
            'lastMessage.id,lastMessage.content,lastMessage.createdAt,lastMessage.isRead',
    @Query('sort') String? sort,
    @Query('filters') String? filters, // Add this parameter
  });

  @POST('/chat')
  Future<dynamic> createChat(@Body() Map<String, dynamic> request);

  @GET('/chat/{id}/messages')
  Future<ChatMessageResponse> getChatMessages(
    @Path('id') String chatId, {
    @Query('page') int? page,
    @Query('take') int? take,
    @Query('sort') String? sort,
    @Query('fields')
    String? fields =
        'id,content,createdAt,updatedAt',
            // 'therapist.id,therapist.firstName,therapist.avatar'
            // 'client.id,client.firstName,client.avatar',
  });

  @POST('/chat/{id}/messages')
  Future<MessageSendResponse> sendMessage(
    @Path('id') String chatId,
    @Body() Map<String, dynamic> message,
  );

  @PATCH('/chat/{id}/read')
  Future<dynamic> markAsRead(@Path('id') String chatId);

  @POST('/chat')
  Future<GroupChatCreateResponse> createGroupChat(
    @Body() Map<String, dynamic> request,
  );

  @GET('/client/{id}')
  Future<ClientInfoResponse> getClientInfo(@Path('id') String clientId);

  @GET('/therapist/me/sessions')
  Future<SessionListResponse> getClientSessions({
    @Query('filters') String? filters,
    @Query('page') int? page,
    @Query('take') int? take,
    @Query('sort') String? sort,
    @Query('fields')
    String? fields = 'id,createdAt,schedule,duration,type,note,therapist.id',
  });

  @PATCH('/session/{id}')
  Future<SessionUpdateResponse> updateSessionNote(
    @Path('id') String sessionId,
    @Path('id') String therapistId,
    @Body() Map<String, dynamic> updateData,
  );

  @DELETE('/messages/{id}')
  Future<dynamic> deleteMessage(@Path('id') String messageId);

  // Add these methods to the ChatRemoteDataSource interface in chat_remote_data_source.dart

  @GET('/therapist/me/sessions')
  Future<GroupSessionNoteResponse> getGroupSessionNote({
    @Query('filters') String? filters,
    @Query('fields')
    String? fields = 'id,paymentPeriod,therapist.id,'
    'clientNotes.id,clientNotes.note,clientNotes.updatedAt,clientNotes.createdAt,'
    'clientNotes.client.id,clientNotes.client.firstName,clientNotes.client.lastName,clientNotes.client.avatar'
  });

  @PATCH('/session/group-notes/{id}')
  Future<SessionGroupNoteUpdateResponse> updateGroupSessionNote(
    @Path('id') String sessionId,
    @Body() Map<String, dynamic> updateData,
  );
}

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return ChatRemoteDataSource(dio);
});
