import { map, mapCommon, MapComponent } from '@kit.MapKit';
import { LocationService } from '../services/LocationService';

@Component
export struct Location {
  private mapController?: map.MapComponentController;
  @State mapReady: boolean = false;
  @Consume('NavPathStack') pageStack: NavPathStack;
  @State mapOptions: mapCommon.MapOptions = {
    position: {
      target: { latitude: 38.447967, longitude: 27.179380 },
      zoom: 13
    }
  };
  @State myLocationMarker: mapCommon.MarkerOptions = {
    position: { latitude: 38.447967, longitude: 27.179380 },
    title: 'Current loc',
    clickable: true,
    anchorU: 0.5,
    anchorV: 1,
    alpha: 1
  };

  async aboutToAppear() {
    const uiContext: UIContext = this.getUIContext();
    const location = await LocationService.getCurrentLocationSafe(uiContext);
    this.mapOptions = {
      position: { target: location, zoom: 17 }
    };

    this.myLocationMarker.position = location;
    this.mapReady = true;
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      NavDestination() {
        Stack() {
          if (this.mapReady) {
            MapComponent({
              mapOptions: this.mapOptions,
              mapCallback: async (err, ctrl) => {
                if (!err && ctrl) {
                  this.mapController = ctrl;
                  await Promise.resolve(ctrl.setMyLocationEnabled(true));
                  await Promise.resolve(ctrl.moveCamera({
                    target: this.myLocationMarker.position,
                    zoom: 17
                  }));
                  await ctrl.addMarker(this.myLocationMarker);
                }
              }
            })
              .width('100%')
              .height('100%');
          } else {
            Text('Map loading...').padding(20).fontSize(18);
          }
          Button('More Info')
            .fontSize(12)
            .backgroundColor(Color.Pink)
            .fontColor(Color.Brown)
            .margin({
              top: 150
            })
            .onClick(() => {
              this.pageStack.pushPathByName('TrackProgress', null);
            })
        }
      }
      .hideTitleBar(true)
      .hideBackButton(true)
      .backgroundColor(Color.White)
    }
  }
}