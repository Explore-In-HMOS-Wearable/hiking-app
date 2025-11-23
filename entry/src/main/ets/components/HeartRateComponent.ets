import { cryptoFramework } from '@kit.CryptoArchitectureKit';

@Component
export default struct HeartRateComponent {
  @State heartRate: string = '--';
  private intervalId: number | undefined = undefined;

  async generateTwoDigitHeartRate(): Promise<string> {
    try {
      let rand = cryptoFramework.createRandom();
      let seed = new Uint8Array([1, 2, 3]);
      rand.setSeed({ data: seed });

      let randOutput = await rand.generateRandom(1);
      let byteVal = randOutput.data?.[0] ?? 0;

      let heartRate = 80 + (byteVal % 41);
      return heartRate.toString();
    } catch (e) {
      console.error('Heart rate generation failed:', e);
      return this.heartRate;
    }
  }

  aboutToAppear() {
    this.intervalId = setInterval(async () => {
      const newRate = await this.generateTwoDigitHeartRate();
      this.heartRate = newRate;
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
