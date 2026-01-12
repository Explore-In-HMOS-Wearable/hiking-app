export class ActivityModel {
  index: number;
  img: Resource;
  name: String;

  constructor(index: number, img: Resource, name: string) {
    this.index = index;
    this.img = img;
    this.name = name;
  }
}

const data: ActivityModel[] = [
  new ActivityModel(0, $r('app.media.running'), 'Running'),
  new ActivityModel(1, $r('app.media.trekking'), 'Trekking'),
  new ActivityModel(3, $r('app.media.cycling'), 'Cycling'),
  new ActivityModel(4, $r('app.media.jogging'), 'Jogging')

];


export { data }