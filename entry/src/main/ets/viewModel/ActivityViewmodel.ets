import { ActivityModel } from './ActivityModel';


class ActivityViewModel {
  private allData: ActivityModel[] = []
  private _sharedImageIndex: Resource = ($r('app.media.cycling'));

  get sharedImageIndex(): Resource {
    return this._sharedImageIndex;
  }

  set sharedImageIndex(newIndex: Resource) {
    this._sharedImageIndex = newIndex;
  }

  searchCurrency(query: string): ActivityModel[] {
    if (!query || query.trim() === '') {
      return this.allData;
    }

    const searchQuery = query.toLowerCase().trim();

    return this.allData.filter(activity =>
    activity.name.toLowerCase().includes(searchQuery)
    );
  }
}

let activityViewModel = new ActivityViewModel();

export { activityViewModel as ActivityViewModel }