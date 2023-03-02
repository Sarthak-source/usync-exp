import 'package:flutter_module/services/audio_call_events.dart';
import 'package:flutter_module/services/call_details.dart';
import 'package:test/test.dart';

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
