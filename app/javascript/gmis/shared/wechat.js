const defaultShare = {
  title: 'Gmis 全球机器智能峰会!',
  desc: 'Gmis 全球机器智能峰会!',
  link: 'http://gmis.jiqizhixin.com',
  imgUrl: 'http://olgabnvpe.bkt.clouddn.com/gmis-share-icon.jpg'
};

const wechat = shareInfo => {
  const share = { ...defaultShare, ...shareInfo };

  wx.config({
    ...wxDefaultConfig,
    jsApiList: [
      'onMenuShareTimeline',
      'onMenuShareQQ',
      'onMenuShareWeibo',
      'onMenuShareAppMessage',
      'onMenuShareQZone'
    ]
  });
  wx.ready(() => {
    wx.onMenuShareTimeline(share);
    wx.onMenuShareQQ(share);
    wx.onMenuShareWeibo(share);
    wx.onMenuShareAppMessage(share);
    wx.onMenuShareQZone(share);
  });
};

export default wechat;
