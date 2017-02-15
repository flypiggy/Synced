const address = () => {
  const map = new BMap.Map('js-gmis-map', {
    enableMapClick: false
  });

  map.centerAndZoom(new BMap.Point(116.529436,39.959994), 15);
  map.setCurrentCity('北京');

  const marker = new BMap.Marker(new BMap.Point(116.511131, 39.961078));
  map.addOverlay(marker);

  const label = new BMap.Label('898创新空间(东北门)', { offset: new BMap.Size(-80, -50) });
  label.setStyle({
    color: 'black',
    fontSize: '16px',
    padding: '8px 20px',
    border: 'none',
    boxShadow: '1px 0 5px rgba(0, 0, 0, 0.2)'
  });
  marker.setLabel(label);
}

export default address;
