import { data, ActivityModel } from '../viewModel/ActivityModel'
import { ArcList, ArcListItem, ComponentContent } from '@kit.ArkUI';
import { Location } from './Location';
import { TrackProgress } from './TrackProgress';

@Builder
function header() {
  Text('All Activities')
    .fontSize(12)
    .fontWeight(FontWeight.Bold)
}

@Entry
@Component
export struct ActivityItem {
  context: UIContext = this.getUIContext()
  header: ComponentContent<object> = new ComponentContent(this.context, wrapBuilder(header))
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  @Builder
  PagesMap(name: string) {
    if (name === 'Location') {
      Location()
    } else if (name === 'TrackProgress') {
      TrackProgress()
    }
  }

  build() {
    Navigation(this.pageStack) {
      ArcList({ header: this.header }) {
        ForEach(data, (imageData: ActivityModel) => {
          ArcListItem() {
            Row() {
              Image(imageData.img)
                .width(40)
                .height(40)
                .objectFit(ImageFit.Contain)
                .fillColor(Color.Yellow)
                .padding({
                  right: 10
                })
                .onClick(() => {
                  this.pageStack.pushPathByName('Location', null);
                })
              Blank(3)
              Text(imageData.name.toString())
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .width('60%')
                .textAlign(TextAlign.Start)
                .fontSize(12)
                .fontColor(Color.Brown)
            }
            .backgroundColor(Color.Pink)
            .borderRadius(25)
            .margin(5)
            .width('85%')
            .padding({
              top: 3,
              bottom: 3,
              left: 4,
              right: 3
            })
            .onClick(() => {
              this.pageStack.pushPathByName('Location', null);
            })
          }
        }, (item: string, index: number) => item)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .navDestination(this.PagesMap)
    .hideBackButton(true)
    .ignoreLayoutSafeArea()
  }
}