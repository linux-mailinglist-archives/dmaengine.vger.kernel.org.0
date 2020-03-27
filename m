Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD502194F5F
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2020 04:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgC0DCa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Mar 2020 23:02:30 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:35424
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgC0DCa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Mar 2020 23:02:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZs0tKL2Vgx7ryQLkzsXr0s8vuneAy8nwPbxtaARJEHDoF/qZlllu3sWPKFBBxtI6XZlWuU5Lh7f52FPb3Wd6FhAOUvWTiKlguHer0Ch8vpzN+bBcpVWExrMNRmLxW0fJkBfUbjpK/qy1eQZSmeqA3VNI03pUsKLsBIuQuj94Z3xDMdsIEQsi4BDoZWgFdIB03+3oDTZIMxj9WZytj4HjSOEy/oGidUq5HjQXk8OyVM29pcI+poFHTqCOJKORc5l3Z77qy8Xk5qOvWnoVHQutPUpMLrx2ySeqUOJMOFQ3dYjMCvBGZNNHUeu/3RRrscHCYwEfgyaMJ5JBj/sDMdp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKV8ueVgJMRQ6+oNZVpnxaWmUmeFI/S/QicWTdl2sXc=;
 b=lN5Zx2TBP6iirhUlP9FiTrvBuNpMA6WgwinSArF4bnWXSbvtltIjXo2tguC9NBxE7VrSi4JPjEnRfi7qg9XGp77Y9Xj90kdPHgbzHvymDXVvtkhS0FqDVNpIsItR/DO8ht2uu88gW+NHiWaKEF2+4vm+Dtnabd+JZYNaTjKlD6nKKgwU3vEGNBa5GpOvkQsxMDHsAYfhDfhqubfmS/TTGYqcliII2osv7qVGBYApRLsYl57a7/v9MTTcV4Cp+ODSZ3EmtrkHkzX/G6EQ2dB+JARdNAFmpCxaa2RwUEKEhBNcvQ7Y6yZ8aPloYojmGaQJeZQil+SwfOAY6hpgAu4iWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKV8ueVgJMRQ6+oNZVpnxaWmUmeFI/S/QicWTdl2sXc=;
 b=qV23y+95ofYQ4JlenhSwOXlXRD7yyO20jMjRHJr4D2bxbYkZUdZHkVj+NRldC+/7wA999oY4VtQ5n86hCU5w9TbZ0NEKlC1gKLNUztNSpcKzjIX36/AFdX5JYTtWM9WNTYt0myFqQpK9Fx2tZeyNJZqerqRzcKl3inalA5WJUkA=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB6239.eurprd04.prod.outlook.com (20.179.27.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Fri, 27 Mar 2020 03:02:12 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::154e:421d:dd21:3fc3]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::154e:421d:dd21:3fc3%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 03:02:12 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus level
Thread-Topic: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus level
Thread-Index: AQHWAplYl7UuTU7KbUCxzHoPeZdbk6haSTvAgAF1v8A=
Date:   Fri, 27 Mar 2020 03:02:12 +0000
Message-ID: <VI1PR04MB5040FFADA4F780422E208AC390CC0@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <20200325113407.26996-1-ulf.hansson@linaro.org>
 <VI1PR04MB504097B40CE0B804FA60D67A90CF0@VI1PR04MB5040.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB504097B40CE0B804FA60D67A90CF0@VI1PR04MB5040.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92d242ab-616a-4374-fa72-08d7d1fb3f78
x-ms-traffictypediagnostic: VI1PR04MB6239:
x-microsoft-antispam-prvs: <VI1PR04MB62392D664D6763984D4BDE6090CC0@VI1PR04MB6239.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5040.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(186003)(86362001)(52536014)(2906002)(81166006)(55016002)(8676002)(9686003)(81156014)(26005)(71200400001)(5660300002)(478600001)(64756008)(6506007)(316002)(76116006)(8936002)(66946007)(66446008)(7696005)(110136005)(33656002)(66556008)(54906003)(66476007)(7416002)(53546011)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjzIuvV7dZ2DIIwprs9qEich3EdiyaCM9afHKrAPI594BLBZk4xFuWVZqHqgn5kYFmW3doP0E4Ah/1LtvLdrBvxD8LKEHaF3hpj6+Sskh9BWzKy3R8uYEGIb0Qru45lAkr8cYpOu7+4ZUzSLXLgYaHgca8jh41avqfNJ8hPF4XqDpVPOVHvP55qoD22K6LlARNVl19QRjPLZw/j/YliQDywg75/NVMHI827/DXwj9p/ZHYC4P3qomyunxjxDU/F8ZA0UgCe/bxGiP6+YhDBwAvreZFoCf2rObHww9l/Oibnb6EG+bASYxS1jtXyNYgbJ74Y51B47gtZPEE4g0S9cuvewPuk+mQGPJFa/OBzFiXSiiu+42W4xWu1I5To0gyvuz8syNrOdeGlhp5yGkMMAjhzJpz5R7qZ9pz7PqCXLuIk8j+OECQBiw7wGW6AL4lNh
x-ms-exchange-antispam-messagedata: cnRkwjY2S4coJYfXm/ZBaQ4G4SXpLTAKW1pfRTRXiJGDKNghWA5CrS/glokHnWnlgp4ShYydnAwmC8EDOGXd5Aqq7yAfhEos8MdJ7GlrnGYID9W+P4LNb/9N/4buTaXg5h/dF6dyodiq3cB1c01uqg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d242ab-616a-4374-fa72-08d7d1fb3f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 03:02:12.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JpINlg3j7pNbEoi4iFq2IYfaPhs49FZR1CKxvoOzbwapW/ad9XHFRbDmYDIHpzcCZIT8Orz8sphyQIqO+Q4yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6239
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJPVUdIIENIRU4NCj4gU2Vu
dDogMjAyMMTqM9TCMjbI1SAxMjo0MQ0KPiBUbzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxp
bmFyby5vcmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPjsgUmFmYWVsIEogLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47DQo+IFJ1c3NlbGwgS2luZyA8bGludXhA
YXJtbGludXgub3JnLnVrPjsgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3Jn
PjsNCj4gVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47IEx1ZG92aWMgQmFycmUgPGx1ZG92
aWMuYmFycmVAc3QuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMC8yXSBh
bWJhL3BsYXRmb3JtOiBJbml0aWFsaXplIGRtYV9wYXJtcyBhdCB0aGUgYnVzIGxldmVsDQo+IA0K
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ID4gU2VudDogMjAyMMTqM9TCMjXI1SAxOTozNA0KPiA+
IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgUmFm
YWVsIEogLg0KPiA+IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiA+IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ow0KPiA+IFJ1c3NlbGwgS2luZyA8bGludXhAYXJt
bGludXgub3JnLnVrPjsgTGludXMgV2FsbGVpag0KPiA+IDxsaW51cy53YWxsZWlqQGxpbmFyby5v
cmc+OyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgQk9VR0ggQ0hFTg0KPiA+IDxoYWli
by5jaGVuQG54cC5jb20+OyBMdWRvdmljIEJhcnJlIDxsdWRvdmljLmJhcnJlQHN0LmNvbT47DQo+
ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbWFlbmdpbmVAdmdlci5r
ZXJuZWwub3JnOyBVbGYNCj4gPiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+
IFN1YmplY3Q6IFtQQVRDSCAwLzJdIGFtYmEvcGxhdGZvcm06IEluaXRpYWxpemUgZG1hX3Bhcm1z
IGF0IHRoZSBidXMNCj4gPiBsZXZlbA0KPiA+DQo+ID4gSXQncyBjdXJyZW50bHkgdGhlIGFtYmEv
cGxhdGZvcm0gZHJpdmVyJ3MgcmVzcG9uc2liaWxpdHkgdG8gaW5pdGlhbGl6ZQ0KPiA+IHRoZSBw
b2ludGVyLCBkbWFfcGFybXMsIGZvciBpdHMgY29ycmVzcG9uZGluZyBzdHJ1Y3QgZGV2aWNlLiBU
aGUNCj4gPiBiZW5lZml0IHdpdGggdGhpcyBhcHByb2FjaCBhbGxvd3MgdXMgdG8gYXZvaWQgdGhl
IGluaXRpYWxpemF0aW9uIGFuZA0KPiA+IHRvIG5vdCB3YXN0ZSBtZW1vcnkgZm9yIHRoZSBzdHJ1
Y3QgZGV2aWNlX2RtYV9wYXJhbWV0ZXJzLCBhcyB0aGlzIGNhbg0KPiA+IGJlIGRlY2lkZWQgb24g
YSBjYXNlIGJ5IGNhc2UgYmFzaXMuDQo+ID4NCj4gPiBIb3dldmVyLCBpdCBoYXMgdHVybmVkIG91
dCB0aGF0IHRoaXMgYXBwcm9hY2ggaXMgbm90IHZlcnkgcHJhY3RpY2FsLg0KPiA+IE5vdCBvbmx5
IGRvZXMgaXQgbGVhZCB0byBvcGVuIGNvZGluZywgYnV0IGFsc28gdG8gcmVhbCBlcnJvcnMuIElu
DQo+ID4gcHJpbmNpcGxlIGNhbGxlcnMgb2YNCj4gPiBkbWFfc2V0X21heF9zZWdfc2l6ZSgpIGRv
ZXNuJ3QgY2hlY2sgdGhlIGVycm9yIGNvZGUsIGJ1dCBqdXN0IGFzc3VtZXMNCj4gPiBpdCBzdWNj
ZWVkcy4NCj4gPg0KPiA+IEZvciB0aGVzZSByZWFzb25zLCB0aGlzIHNlcmllcyBpbml0aWFsaXpl
cyB0aGUgZG1hX3Bhcm1zIGZyb20gdGhlDQo+ID4gYW1iYS9wbGF0Zm9ybSBidXMgYXQgdGhlIGRl
dmljZSByZWdpc3RyYXRpb24gcG9pbnQuIFRoaXMgYWxzbyBmb2xsb3dzDQo+ID4gdGhlIHdheSB0
aGUgUENJIGRldmljZXMgYXJlIGJlaW5nIG1hbmFnZWQsIHNlZSBwY2lfZGV2aWNlX2FkZCgpLg0K
PiA+DQo+ID4gSWYgaXQgdHVybnMgb3V0IHRoYXQgdGhpcyBpcyBhbiBhY2NlcHRhYmxlIHNvbHV0
aW9uLCB3ZSBwcm9iYWJseSBhbHNvDQo+ID4gd2FudCB0aGUgY2hhbmdlcyBmb3Igc3RhYmxlLCBi
dXQgSSBhbSBub3Qgc3VyZSBpZiBpdCBhcHBsaWVzIHdpdGhvdXQgY29uZmxpY3RzLg0KPiA+DQo+
ID4gVGhlIHNlcmllcyBpcyBiYXNlZCBvbiB2NS42LXJjNy4NCj4gPg0KPiANCj4gSGkgVWxmLA0K
PiANCj4gU2luY2UgaS5NWFFNIFNNTVUgcmVsYXRlZCBjb2RlIHN0aWxsIG5vdCB1cHN0cmVhbSB5
ZXQsIHNvIEkgYXBwbHkgeW91cg0KPiBwYXRjaGVzIG9uIG91ciBpbnRlcm5hbCBMaW51eCBicmFu
Y2ggYmFzZWQgb24gdjUuNC4yNCwgYW5kIGZpbmQgaXQgZG8gbm90IHdvcmsNCj4gb24gbXkgc2lk
ZS4gTWF5YmUgZm9yIHBsYXRmb3JtIGNvcmUgZHJpdmVycywgdGhlcmUgaXMgYSBnYXAgYmV0d2Vl
biB2NS40LjI0DQo+IGFuZCB2NS42LXJjNyB3aGljaCBoYXMgdGhlIGltcGFjdC4NCj4gSSB3aWxs
IHRyeSB0byBwdXQgb3VyIFNNTVUgcmVsYXRlZCBjb2RlIGludG8gdjUuNi1yYzcsIHRoZW4gZG8g
dGhlIHRlc3QgYWdhaW4uDQo+IA0KPiANCg0KSGkgVWxmLA0KDQpPbiB0aGUgbGF0ZXN0IExpbnV4
LW5leHQgYnJhbmNoLCB0aGUgdG9wIGNvbW1pdCA4OTI5NWM1OWMxZjA2M2I1MzNkMDcxY2E0OWQw
ZmEwYzA3ODNjYTZmICh0YWc6IG5leHQtMjAyMDAzMjYpLCBhZnRlciBhZGQgeW91ciB0d28gcGF0
Y2hlcywgSSBqdXN0IGFkZCB0aGUgc2ltcGxlIGRlYnVnIGNvZGUgYXMgZm9sbG93aW5nIGluIHRo
ZSAvZHJpdmVyL21tYy9jb3JlL3F1ZXVlLmMsIGJ1dCBzZWVtcyBzdGlsbCBub3Qgd29yayBhcyBv
dXIgZXhwZWN0LCBsb2dpY2FsbHksIGl0IHNob3VsZCB3b3JrLCBzbyBjYW4geW91IG9yIGFueW9u
ZSB0ZXN0IG9uIG90aGVyIHBsYXRmb3JtPyBUaGlzIHNlZW1zIHdlaXJkLg0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvY29yZS9xdWV1ZS5jIGIvZHJpdmVycy9tbWMvY29yZS9xdWV1ZS5jDQpp
bmRleCAyNWJlZTNkYWY5ZTIuLmYwOTEyODBmN2ZmYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1j
L2NvcmUvcXVldWUuYw0KKysrIGIvZHJpdmVycy9tbWMvY29yZS9xdWV1ZS5jDQpAQCAtNDAzLDYg
KzQwMywxMyBAQCBzdGF0aWMgdm9pZCBtbWNfc2V0dXBfcXVldWUoc3RydWN0IG1tY19xdWV1ZSAq
bXEsIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCiAgICAgICAgICAgICAgICBibGtfcXVldWVfbWF4
X3NlZ21lbnRfc2l6ZShtcS0+cXVldWUsDQogICAgICAgICAgICAgICAgICAgICAgICByb3VuZF9k
b3duKGhvc3QtPm1heF9zZWdfc2l6ZSwgYmxvY2tfc2l6ZSkpOw0KDQorICAgICAgIHByX2Vycigi
IyMjIyMjIHRoZSBtYXggc2VnbWVudCBzaXplIGlzICVkXG4iLCBxdWV1ZV9tYXhfc2VnbWVudF9z
aXplKG1xLT5xdWV1ZSkpOw0KKyAgICAgICBpZiAoaG9zdC0+cGFyZW50LT5kbWFfcGFybXMpIHsN
CisgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCIjIyMjIyMjIyMgdGhlIGRtYSBwYXJtcyBo
YXMgdmFsdWVcbiIpOw0KKyAgICAgICB9IGVsc2UgaWYgKCEoaG9zdC0+cGFyZW50LT5kbWFfcGFy
bXMpKSB7DQorICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiIyMjIyMjIyMgdGhlIGRtYSBw
YXJtcyBpcyB6ZXJvISFcbiIpOw0KKyAgICAgICB9DQorDQogICAgICAgIGRtYV9zZXRfbWF4X3Nl
Z19zaXplKG1tY19kZXYoaG9zdCksIHF1ZXVlX21heF9zZWdtZW50X3NpemUobXEtPnF1ZXVlKSk7
DQoNCiAgICAgICAgSU5JVF9XT1JLKCZtcS0+cmVjb3Zlcnlfd29yaywgbW1jX21xX3JlY292ZXJ5
X2hhbmRsZXIpOw0KDQpIZXJlIGlzIHRoZSBsb2cgSSBnb3Qgd2hlbiBzeXN0ZW0gcnVuLCBldmVu
IGFmdGVyIHlvdXIgcGF0Y2gsIHRoZSBkZXYtPmRtYV9wYXJtcyBpcyBzdGlsbCBOVUxMLiANClsg
ICAgMC45ODk4NTNdIG1tYzA6IG5ldyBIUzQwMCBNTUMgY2FyZCBhdCBhZGRyZXNzIDAwMDENClsg
ICAgMC45OTU3MDhdIHNkaGNpLWVzZGhjLWlteCAzMGI1MDAwMC5tbWM6IEdvdCBDRCBHUElPDQpb
ICAgIDAuOTk5Mzc0XSAjIyMjIyMgdGhlIG1heCBzZWdtZW50IHNpemUgaXMgNjUwMjQNClsgICAg
MS4wMDg1OTRdICMjIyMjIyMjIHRoZSBkbWEgcGFybXMgaXMgemVybyEhDQpbICAgIDEuMDEyODc1
XSBtbWNibGswOiBtbWMwOjAwMDEgSUIyOTMyIDI5LjIgR2lCDQpbICAgIDEuMDE3NTY5XSAjIyMj
IyMgdGhlIG1heCBzZWdtZW50IHNpemUgaXMgNjUwMjQNClsgICAgMS4wMjIxOTVdICMjIyMjIyMj
IHRoZSBkbWEgcGFybXMgaXMgemVybyEhDQpbICAgIDEuMDI2NDc5XSBtbWNibGswYm9vdDA6IG1t
YzA6MDAwMSBJQjI5MzIgcGFydGl0aW9uIDEgNC4wMCBNaUINClsgICAgMS4wMzI1NDFdICMjIyMj
IyB0aGUgbWF4IHNlZ21lbnQgc2l6ZSBpcyA2NTAyNA0KWyAgICAxLjAzNTE5OF0gbW1jMTogU0RI
Q0kgY29udHJvbGxlciBvbiAzMGI1MDAwMC5tbWMgWzMwYjUwMDAwLm1tY10gdXNpbmcgQURNQQ0K
WyAgICAxLjAzNzE2OV0gIyMjIyMjIyMgdGhlIGRtYSBwYXJtcyBpcyB6ZXJvISENClsgICAgMS4w
NDg0OTNdIG1tY2JsazBib290MTogbW1jMDowMDAxIElCMjkzMiBwYXJ0aXRpb24gMiA0LjAwIE1p
Qg0KWyAgICAxLjA1NDUzMV0gbW1jYmxrMHJwbWI6IG1tYzA6MDAwMSBJQjI5MzIgcGFydGl0aW9u
IDMgNC4wMCBNaUIsIGNoYXJkZXYgKDIzNDowKQ0KDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4g
QmVzdCBSZWdhcmRzDQo+IEhhaWJvIENoZW4NCj4gDQo+ID4gS2luZCByZWdhcmRzDQo+ID4gVWxm
IEhhbnNzb24NCj4gPg0KPiA+IFVsZiBIYW5zc29uICgyKToNCj4gPiAgIGRyaXZlciBjb3JlOiBw
bGF0Zm9ybTogSW5pdGlhbGl6ZSBkbWFfcGFybXMgZm9yIHBsYXRmb3JtIGRldmljZXMNCj4gPiAg
IGFtYmE6IEluaXRpYWxpemUgZG1hX3Bhcm1zIGZvciBhbWJhIGRldmljZXMNCj4gPg0KPiA+ICBk
cml2ZXJzL2FtYmEvYnVzLmMgICAgICAgICAgICAgIHwgMiArKw0KPiA+ICBkcml2ZXJzL2Jhc2Uv
cGxhdGZvcm0uYyAgICAgICAgIHwgMSArDQo+ID4gIGluY2x1ZGUvbGludXgvYW1iYS9idXMuaCAg
ICAgICAgfCAxICsNCj4gPiAgaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kZXZpY2UuaCB8IDEgKw0K
PiA+ICA0IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gLS0NCj4gPiAy
LjIwLjENCg0K
