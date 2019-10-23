Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B04E11DC
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 07:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbfJWF4T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 01:56:19 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:32685
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbfJWF4T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 01:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0+4nejTfmiQgU1HJ/l31N0uBKLF3gL7MlxAYXIEq4/KKWs9lKupHjiOmCnsvaLhqeS984yZoB7Ibim7hKQFx3C+acl1RlXE+JgVmXPFrlfRL/c+BVm3xULB3OLkwRDNYtDFmbkqwdGsVr8qf+NF5HbtuEIscozrplEC8K74lq5XQqfMKGON4NU3KB+gZGgSt2Q/an3lIAjQzz48twA7I6Z+qnBdo8gVd6g1WJvyGo5p79bJ69Ku6fWGqo7LMLFKWostySaVB9uec+RzJI02jTj5bXT8CV/eRXa4sw3FAFmOXVNkQbNbrtBQN9CByBY/+Wbn6ji6q2wPNQI7aNkOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvmfVbpP8z9zHsOS41N1PhFSOYATxLqbP6qWWyCz/Jc=;
 b=OHVr8meKiM1cf3y6cVob2YHNCJ+HvZtHajIlX6eoNf7cbdWkiWm+a8cY6usema9BJrSWQHgFT9NbwLEMD/yp+pFG8dpRwBCykuWIF9INozERt5JqmA/Ln9kFLseUdaU7TZeL5rs6E2MNbc0p5cx5rlZqhA2Y31Ym3XVUOOJjeHhPIVyJmwxcVxCLXAoCFkUBXK/cO88KLyeJoTqurMMTVeLmEdm0H7/4aoIFDKr0mJ1rsfnPfzpo/8YfHTMnl96+Y6JCa7DBLRKsEwNiQKyPCvx6TO/WnS+Pc6NxsAr5XWV+7I+94RGHfYrz07oktKb71vIo6NopLSud7Pwjf8kTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvmfVbpP8z9zHsOS41N1PhFSOYATxLqbP6qWWyCz/Jc=;
 b=b4lF43Kb7Qag+KDAqdZOZHSoQVXtqYk8udo37RnHjzrNc5BscbTSExp0SxiS8CR3XFowlMhyCmxqETQCoh0xpRve17HSlLF1Mn2wiMMXCH5i/tEvbifrUCykLgZmH/CalRBegQ7EMrH6MH0lhvqB4JgE1mEt4jGcRD7SLsksqiQ=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB4557.eurprd04.prod.outlook.com (20.177.56.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 05:56:14 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb%6]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 05:56:14 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [next, v2] dmaengine: fsl-dpaa2-qdma: export the
 symbols
Thread-Topic: [EXT] Re: [next, v2] dmaengine: fsl-dpaa2-qdma: export the
 symbols
Thread-Index: AQHViV+/ULN5mRIKtk2reoe4slbMB6dnrVaAgAAM8LA=
Date:   Wed, 23 Oct 2019 05:56:14 +0000
Message-ID: <VI1PR04MB443123073362B13FE8C6F181ED6B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20191023045617.22764-1-peng.ma@nxp.com>
 <20191023050927.GP2654@vkoul-mobl>
In-Reply-To: <20191023050927.GP2654@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1614be9-fb54-4835-7cb2-08d7577db6e6
x-ms-traffictypediagnostic: VI1PR04MB4557:|VI1PR04MB4557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4557747CE604C5281CCCA48FED6B0@VI1PR04MB4557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(13464003)(189003)(199004)(33656002)(256004)(25786009)(9686003)(316002)(55016002)(52536014)(229853002)(54906003)(6116002)(6436002)(14444005)(3846002)(6246003)(4326008)(76176011)(7696005)(6916009)(478600001)(71200400001)(71190400001)(5660300002)(6506007)(186003)(102836004)(99286004)(2906002)(14454004)(26005)(74316002)(66066001)(86362001)(76116006)(486006)(446003)(66946007)(8676002)(44832011)(7736002)(8936002)(66556008)(66476007)(66446008)(476003)(305945005)(81156014)(81166006)(11346002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4557;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oJ2miAMYIHwHpgjVheelCcYDB47abUmCyBoICtnepYt1YGmQPvj7SlYiT19tKLjoQLjSR7dRdniUrRhKsbwXujJRumd8dq99Aq9+/RC+FdZPa243p4HEu0ElnqMesPTai+2zMIADwDTkq+KFsqCnv9wVslJtEGmSaQIBypFq/7AvT+6TtK1yCLRAe4p8wH4hFd7xV6vlmVkXGr3ahloX0StfFVhfu6KUl+dual/lMmof3iiHxYL5K67BHLNvC7oZgVQhdw4K7BDU0605EEiN51Uw/kgayJ9eqBnZQIhnsdpZHeEYyruozMK8tXNUFO/Ulix7XlEgGuBr3Va6gckgm0CxLnxdCtlnZYu4Y7NxrV4Nlx7oRZ2D7oHgC70ogDICcoTsHsiZyZNXHXOPCKOgNbsm2IvVdi1QILhN1g5U6ixnyfLOQg0wju1FgqpwIZw5
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1614be9-fb54-4835-7cb2-08d7577db6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 05:56:14.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vP3Q+QvLc9B3YdzbzYISIu7TY+eBkIFcCnCbF50DKdr5GPJnu3aB5uTNhFc2PRuD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4557
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqMTDUwjIzyNUgMTM6MDkNCj5UbzogUGVuZyBNYSA8
cGVuZy5tYUBueHAuY29tPg0KPkNjOiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IExlbyBMaSA8
bGVveWFuZy5saUBueHAuY29tPjsNCj5hbmRlcnMucm94ZWxsQGxpbmFyby5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPlN1Ympl
Y3Q6IFtFWFRdIFJlOiBbbmV4dCwgdjJdIGRtYWVuZ2luZTogZnNsLWRwYWEyLXFkbWE6IGV4cG9y
dCB0aGUgc3ltYm9scw0KPg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0KPk9uIDIzLTEwLTE5LCAx
Mjo1NiwgUGVuZyBNYSB3cm90ZToNCj4+IFRoZSBzeW1ib2xzIHdlcmUgbm90IGV4cG9ydGVkIGxl
YWRpbmcgdG8gZXJyb3I6DQo+Pg0KPj4gV0FSTklORzogbW9kcG9zdDogbWlzc2luZyBNT0RVTEVf
TElDRU5TRSgpIGluDQo+ZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBkbWFpLm8NCj4+IHNl
ZSBpbmNsdWRlL2xpbnV4L21vZHVsZS5oIGZvciBtb3JlIGluZm9ybWF0aW9uDQo+PiBHWklQICAg
IGFyY2gvYXJtNjQvYm9vdC9JbWFnZS5neg0KPj4gRVJST1I6ICJkcGRtYWlfZW5hYmxlIiBbZHJp
dmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10NCj51bmRlZmluZWQhDQo+PiBF
UlJPUjogImRwZG1haV9zZXRfcnhfcXVldWUiDQo+W2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1h
L2RwYWEyLXFkbWEua29dIHVuZGVmaW5lZCENCj4+IEVSUk9SOiAiZHBkbWFpX2dldF90eF9xdWV1
ZSINCj5bZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10gdW5kZWZpbmVk
IQ0KPj4gRVJST1I6ICJkcGRtYWlfZ2V0X3J4X3F1ZXVlIg0KPltkcml2ZXJzL2RtYS9mc2wtZHBh
YTItcWRtYS9kcGFhMi1xZG1hLmtvXSB1bmRlZmluZWQhDQo+PiBFUlJPUjogImRwZG1haV9nZXRf
YXR0cmlidXRlcyINCj5bZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10g
dW5kZWZpbmVkIQ0KPj4gRVJST1I6ICJkcGRtYWlfb3BlbiIgW2RyaXZlcnMvZG1hL2ZzbC1kcGFh
Mi1xZG1hL2RwYWEyLXFkbWEua29dDQo+dW5kZWZpbmVkIQ0KPj4gRVJST1I6ICJkcGRtYWlfY2xv
c2UiIFtkcml2ZXJzL2RtYS9mc2wtZHBhYTItcWRtYS9kcGFhMi1xZG1hLmtvXQ0KPnVuZGVmaW5l
ZCENCj4+IEVSUk9SOiAiZHBkbWFpX2Rpc2FibGUiIFtkcml2ZXJzL2RtYS9mc2wtZHBhYTItcWRt
YS9kcGFhMi1xZG1hLmtvXQ0KPnVuZGVmaW5lZCENCj4+IEVSUk9SOiAiZHBkbWFpX3Jlc2V0IiBb
ZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10NCj51bmRlZmluZWQhDQo+
PiBXQVJOSU5HOiAiSFlQRVJWSVNPUl9wbGF0Zm9ybV9vcCIgW3ZtbGludXhdIGlzIGEgc3RhdGlj
DQo+RVhQT1JUX1NZTUJPTF9HUEwNCj4+IG1ha2VbMl06ICoqKiBbX19tb2Rwb3N0XSBFcnJvciAx
DQo+PiBtYWtlWzFdOiAqKiogW21vZHVsZXNdIEVycm9yIDINCj4+IG1ha2VbMV06ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQo+PiBtYWtlOiAqKiogW3N1Yi1tYWtlXSBFcnJv
ciAyDQo+Pg0KPj4gU28gZXhwb3J0IGl0Lg0KPg0KPkFwcGxpZWQsIHRoYW5rcw0KW1BlbmcgTWFd
IEdvdCBpdC4NClRoYW5rcywNClBlbmcNCj4NCj4tLQ0KPn5WaW5vZA0K
