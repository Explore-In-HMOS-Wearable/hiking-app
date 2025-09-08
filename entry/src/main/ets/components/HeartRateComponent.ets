@Component
export default struct HeartRateComponent {
  @State heartRate: string = '--';
  private intervalId: number | undefined = undefined;

  generateTwoDigitHeartRate(): string {
    const randomNum = Math.floor(80 + Math.random() * 41);
    return randomNum.toString();
  }

  aboutToAppear() {
    this.intervalId = setInterval(() => {
      this.heartRate = this.generateTwoDigitHeartRate();
    }, 2000);
  }

  aboutToDisappear() {
    if (this.intervalId !== undefined) {
      clearInterval(this.intervalId);
      this.intervalId = undefined;
    }
  }

  build() {
    Column() {
      Text('Current Heart Rate:')
        .fontSize(10)
        .fontColor(Color.Brown)
      Text(this.heartRate)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Brown)
    }.padding(20)
  }
}
