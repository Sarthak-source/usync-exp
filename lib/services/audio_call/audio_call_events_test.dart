
import 'package:test/test.dart';
import 'package:usync/services/audio_call/audio_call_events.dart';
import 'package:usync/services/audio_call/call_details.dart';

void main() {
  test('Create user Event', () async {
    var expected = "usync.gossip.abc.initcall";
    var result = AudioCallEvents.userEvent(AudioCallEvents.initCall, "abc");
    expect(result, expected);
  });

  test('Create user connection Event', () async {
    var expected = "usync.gossip.abc->def.callrequest";

    var result = AudioCallEvents.userConnectionEvent(
        AudioCallEvents.callRequest, "abc", "def");
    expect(result, expected);

    var callDetails = CallDetails(conversationId: "abc", caller: "abc", callee: "def");

    result = AudioCallEvents.userConnectionEvent(
        AudioCallEvents.callRequest, callDetails);
    expect(result, expected);

    expected = "usync.gossip.def->abc.callrequest";
    result = AudioCallEvents.userConnectionEvent(
        AudioCallEvents.callRequest, callDetails.fromCallee());
    expect(result, expected);
  });
}
