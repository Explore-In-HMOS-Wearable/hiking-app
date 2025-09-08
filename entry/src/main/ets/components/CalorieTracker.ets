@Component
export default struct CalorieTracker {
  @State calories: number = 0;
  private intervalId: number | undefined = undefined;

  generateIncrement(): number {
    return Math.floor(5 + Math.random() * 6);
  }

  aboutToAppear() {
    this.intervalId = setInterval(() => {
      const increment = this.generateIncrement();
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
