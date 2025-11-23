import { cryptoFramework } from '@kit.CryptoArchitectureKit';

@Component
export default struct CalorieTracker {
  @State calories: number = 0;
  private intervalId: number | undefined = undefined;

  async generateIncrement(): Promise<number> {
    let rand = cryptoFramework.createRandom();
    let seed = new Uint8Array([1, 2, 3]);
    rand.setSeed({ data: seed });

    let randOutput = await rand.generateRandom(1);
    let byteVal = randOutput.data?.[0] ?? 0;

    let increment = 5 + (byteVal % 6);
    return increment;
  }

  aboutToAppear() {
    this.intervalId = setInterval(async () => {
      const increment = await this.generateIncrement();
      this.calories += increment;
    }, 8000);
  }

  aboutToDisappear() {
    if (this.intervalId !== undefined) {
      clearInterval(this.intervalId);
      this.intervalId = undefined;
    }
  }

  build() {
    Column() {
      Text('Calories Burned:')
        .fontSize(10)
        .fontColor(Color.Brown)
      Text(this.calories.toString())
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Brown)
    }.padding(20)
  }
}
