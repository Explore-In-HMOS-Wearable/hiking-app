import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  ColorMetrics
} from '@kit.ArkUI';
import CalorieTracker from '../components/CalorieTracker';
import HeartRateComponent from '../components/HeartRateComponent';

@Entry
@Component
export struct TrackProgress {
  textTimerController: TextTimerController = new TextTimerController()
  bottomOptions: ArcButtonOptions = new ArcButtonOptions({})
  format: string = 'mm:ss.SS'
  elapsedTime: number = 0
  clicked: boolean = true

  aboutToAppear(): void {
    this.bottomOptions = new ArcButtonOptions({
      label: 'Finish',
      fontColor: ColorMetrics.resourceColor(Color.Brown),
      status: ArcButtonStatus.NORMAL,
      backgroundColor: ColorMetrics.resourceColor(Color.Pink),
      styleMode: ArcButtonStyleMode.CUSTOM,
      position: ArcButtonPosition.BOTTOM_EDGE
    })
  }

  build() {
    NavDestination() {

      Flex({ justifyContent: FlexAlign.Center, wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
        this.Timer()
        Row() {
          HeartRateComponent()
          CalorieTracker()
        }

        Row({ space: 20 }) {
          if (this.clicked) {
            Image($r('app.media.pause')).fillColor(Color.Yellow).width('10%').onClick(() => {
              this.textTimerController.pause()
              this.clicked = false
            })
          } else {
            Image($r('app.media.play')).fillColor(Color.Yellow).width('10%').onClick(() => {
              this.textTimerController.start()
              this.clicked = true
            })
          }
          Image($r('app.media.reset')).fillColor(Color.Yellow).width('10%').onClick(() => {
            this.textTimerController.reset()
            this.clicked = false
          })
        }

        ArcButton({ options: this.bottomOptions }).margin({ top: 15 })
      }
      .backgroundColor(Color.White)
      .width('466px')
      .height('466px')
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }

  @Builder
  Timer() {
    TextTimer({ isCountDown: false, controller: this.textTimerController })
      .format(this.format)
      .fontColor(Color.Brown)
      .margin({ top: 30, bottom: 2 })
      .fontSize(35)
      .onTimer((utc: number, elapsedTime: number) => {
        this.elapsedTime = elapsedTime
      })
      .onAppear(() => {
        this.textTimerController.start()
      })
  }
}

