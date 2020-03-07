import 'package:flutter_taipei/assets.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/model/speaker.dart';
import 'package:flutter_taipei/model/timeline_item.dart';
import 'package:flutter_taipei/strings.dart';

final List<TimelineModel> agendas = [
  TimelineModel(content: kAgenda1),
  TimelineModel(content: kAgenda2),
  TimelineModel(
      speaker: Speaker(
          name: kSpeakerName1,
          photo: kSpeaker1Photo,
          introduction: kSpeakerIntro1,
          talkTopic: kSpeakerTopic1,
      topicIntro: kSpeakerTopicIntro1)),
  TimelineModel(content: kAgenda4),
  TimelineModel(
      speaker: Speaker(
          name: kSpeakerName2,
          photo: kSpeaker2Photo,
          introduction: kSpeakerIntro2,
          talkTopic: kSpeakerTopic2,
          topicIntro: kSpeakerTopicIntro2)),
  TimelineModel(content: kAgenda6),
  TimelineModel(content: kAgenda7),
  TimelineModel(content: kAgenda8),
];


final List<String> times = [
  "18:30",
  "19:00",
  "19:10",
  "19:40",
  "20:10",
  "20:40",
  "21:00",
  "21:30",
];

//TODO
final List<LighteningTalk> lighteningTalks = [

  LighteningTalk(orderNumber: "1", speakerName: "多拉A夢", topic: "Flutter心路歷程"),
  LighteningTalk(orderNumber: "2", speakerName: "大雄", topic: "接觸Flutter"),
  LighteningTalk(orderNumber: "3", speakerName: "瑞貝卡", topic: "Flutter 專案"),
  LighteningTalk(orderNumber: "4", speakerName: "小袋", topic: "Flutter 好夥伴"),

];