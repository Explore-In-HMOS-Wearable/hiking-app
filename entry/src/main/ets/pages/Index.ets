import { data, ActivityModel } from '../viewModel/ActivityModel'
import { ArcList, router, ArcListItem, ComponentContent } from '@kit.ArkUI';
import { ActivityViewModel } from '../viewModel/ActivityViewmodel';


@Builder
function header() {
  Column() {
    Text('All Activities')
      .fontSize(12)
      .fontWeight(FontWeight.Bold)
  }
}

@Entry
@Component
export struct ActivityItem {
  @State isSelected: boolean = false;
  private viewModel = ActivityViewModel;
  context: UIContext = this.getUIContext()
  header: ComponentContent<object> = new ComponentContent(this.context, wrapBuilder(header))

  build() {
    Flex() {
      Row() {
        Column() {
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
                      right:10
                    })
                    .onClick(() => {
                      router.pushUrl({ url: 'pages/Location' });
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
                  router.pushUrl({ url: 'pages/Location' });
                })
              }
            }, (item: string, index: number) => item)
          }
        }
      }
    }.width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}