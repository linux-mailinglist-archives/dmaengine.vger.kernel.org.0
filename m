Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D795DAF41F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2019 04:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfIKCB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 22:01:59 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:19589
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfIKCB6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Sep 2019 22:01:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4ln6zmrgDT7C/Ix2aNrXX1P3dT9yl5gWQj4fY5zW/Mukc5XwJeSIgDI8xDQwkxFiuec5W2UHgyFkPnfK03/n6GG4tJYJpNge51BbA4Ru2KhgdqgkxVj1PCNgLBg9VKVONT65p+JUF9pVdJDG5N67TNmbKrYI/cUMUnbbJFdzcqauKJC5lPrH0s26HHUGfEfNs4+AyOaPmwr0OEOn+9tlIZFT+be4hX8Zi9ungohv66Nw7zgTyCJzv/1ijaPWAyNk9FZanb22T+bAeEdSmUcvsCMQuqTGmNbg/TpDsSfCdacnu/u6oA+DKDN2/ZHMnd2Dik6ynkzC8HsDAengLO2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpqnW1r5qIhZCcUglWluhH5vchA9a79Z7HlTrZUwzxE=;
 b=Y2si9Z6NZigBhAn6/7Npm5RihfuNFHkeN7NB6lWooCfaCuR4FFKsU1GvoFuUEglA4zi+KuPeRTA6vT3D3Dh4DADq/8SF+762RY/oAo4WtSnWm3+1MFD407VaAbDJQQ4fiW7Wh/F7fu9RdeiYF1hGZJFCkyLqPwGR3OMqIIZt10rLBYZvbaPVH9kXjm7tbpdfcjtToIgitlNhrziTlVB3VameO8M6Fs/2HbgV33gQ6urH0ctNN09BpqxZvM61OZZR4sdcA7JJnkl5eBxL6tQ9NMnPCxBLv0rxXfAw4McjOJDvewD17jNt5sjHe56+ecBu6NNK8uS9VhPmKEHv5AGX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpqnW1r5qIhZCcUglWluhH5vchA9a79Z7HlTrZUwzxE=;
 b=MInN1zLFheZc3rhxDPvWUK3rW0Z6Ab5CruRy3/xigbduUytR3ue9o4oXhJR6zDhvf3ZWxFOqh3o+bFY1xEvh2Ry6efnVM4AzdAcuw0pCIEAI1xsrosUelWoVENv68uZxJEvM5d6gDEKkZN01WOyEukqmr2A0OW17jwQc3p/BbOc=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5360.eurprd04.prod.outlook.com (20.178.120.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Wed, 11 Sep 2019 02:01:51 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e158:ee7a:cebe:5b3e]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e158:ee7a:cebe:5b3e%7]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 02:01:51 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Topic: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Index: AQHVIdHlJeIOycgBm02VgX87ZyLFMqarFPIAgHsuGRA=
Date:   Wed, 11 Sep 2019 02:01:50 +0000
Message-ID: <VI1PR04MB443142772665BB29B909DFF4EDB10@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190613101341.21169-1-peng.ma@nxp.com>
 <20190613101341.21169-2-peng.ma@nxp.com> <20190624164556.GD2962@vkoul-mobl>
In-Reply-To: <20190624164556.GD2962@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65521a4e-fb16-49e6-840f-08d7365c030d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5360;
x-ms-traffictypediagnostic: VI1PR04MB5360:|VI1PR04MB5360:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB53602C0D6332869DCD2DE5FEEDB10@VI1PR04MB5360.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(13464003)(966005)(446003)(4326008)(26005)(476003)(66946007)(2906002)(64756008)(66446008)(14454004)(256004)(99286004)(33656002)(71200400001)(7696005)(14444005)(71190400001)(478600001)(52536014)(6116002)(3846002)(86362001)(5660300002)(8936002)(81166006)(81156014)(8676002)(305945005)(7736002)(11346002)(74316002)(486006)(55016002)(66556008)(6306002)(9686003)(66476007)(76116006)(6246003)(316002)(66066001)(54906003)(25786009)(6916009)(44832011)(229853002)(186003)(76176011)(6506007)(102836004)(53936002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5360;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GQVJH+ENLcnRm6iWF2qVv/N6xAh3zolC+HOyXf8amXNn7Ge6JMciQ9dRJBSmFYFg+xm69TA2woHwa/oGmljzTEKMIPD17VaWtw1QQpHKgslru6BJfwf8lDtp4Xu4a1Kj6f+WBtAq3O06g5P7rAw1/wFVqI9lkpK43TPpyw3/H2cKLfO//r3nnQiAL5OrjD5FaBqYXPWL9AtXJnRLnDLLciKuAIK5g8u1vO6HMucdpZm/yM/dPUBZIziNTENEoGkLVR8TnuikaXC3EWl88mt8qHJ8GH9rygR0ZyqDMQQAogZDwFZgjC2DIf12NnLt12tzSxDg8D4tKeVQyfCIz4Gp2vFdMgQheXEE2VrEK26apq8DbDc9EmAoilMFRhjAUULkNnfu50zXju7w/XT9bZrL88XfGs3eWvTtNZ9VH++MWY4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65521a4e-fb16-49e6-840f-08d7365c030d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 02:01:51.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7x/ERACtXb4Vx+R0PhvaOFhAbj7RCVaLrFIYA4TydoEXgMOZYKN2ZSr4Q6CGiDh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5360
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNCkkgc2VuZCB0aG9zZSBzZXJpZXMgcGF0Y2hzKFY1KSBvbiBKdW5lIDI1LCAy
MDE5LiBJIGhhdmVuJ3QgcmVjZWl2ZWQgYW55IGNvbW1lbnRzIHlldC4gVGhlaXIgY3VycmVudCBz
dGF0ZQ0KaXMgIk5vdCBBcHBsaWNhYmxlIiwgc28gcGxlYXNlIGxldCBtZSBrbm93IHdoYXQgSSBu
ZWVkIHRvIGRvIG5leHQuDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGNvbW1lbnRzLg0KDQpQ
YXRjaCBsaW5rOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTAxNTAzNS8N
Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEwMTUwMzMvDQoNCkJlc3QgUmVn
YXJkcywNClBlbmcNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtv
dWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqNtTCMjXI1SAwOjQ2DQo+VG86IFBl
bmcgTWEgPHBlbmcubWFAbnhwLmNvbT4NCj5DYzogZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBM
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFtFWFRdIFJlOiBbVjQgMi8y
XSBkbWFlbmdpbmU6IGZzbC1kcGFhMi1xZG1hOiBBZGQgTlhQIGRwYWEyIHFETUENCj5jb250cm9s
bGVyIGRyaXZlciBmb3IgTGF5ZXJzY2FwZSBTb0NzDQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+
DQo+T24gMTMtMDYtMTksIDEwOjEzLCBQZW5nIE1hIHdyb3RlOg0KPj4gRFBQQTIoRGF0YSBQYXRo
IEFjY2VsZXJhdGlvbiBBcmNoaXRlY3R1cmUgMikgcURNQSBzdXBwb3J0cyBjaGFubmVsDQo+PiB2
aXJ0dWFsaXphdGlvbiBieSBhbGxvd2luZyBETUENCj4NCj50eXBvIHZpcnR1YWxpemF0aW9uDQo+
DQo+PiBqb2JzIHRvIGJlIGVucXVldWVkIGludG8gZGlmZmVyZW50IGZyYW1lIHF1ZXVlcy4NCj4+
IENvcmUgY2FuIGluaXRpYXRlIGEgRE1BIHRyYW5zYWN0aW9uIGJ5IHByZXBhcmluZyBhIGZyYW1l
DQo+PiBkZXNjcmlwdG9yKEZEKSBmb3IgZWFjaCBETUEgam9iIGFuZCBlbnF1ZXVpbmcgdGhpcyBq
b2IgdG8gYSBmcmFtZQ0KPj4gcXVldWUuIHRocm91Z2ggYSBoYXJkd2FyZSBwb3J0YWwuIFRoZSBx
RE1BDQo+ICAgICAgICAgICAgICBeXl4NCj53aHkgdGhpcyBmdWxsIHN0b3A/DQo+DQo+PiArc3Rh
dGljIHN0cnVjdCBkcGFhMl9xZG1hX2NvbXAgKg0KPj4gK2RwYWEyX3FkbWFfcmVxdWVzdF9kZXNj
KHN0cnVjdCBkcGFhMl9xZG1hX2NoYW4gKmRwYWEyX2NoYW4pIHsNCj4+ICsgICAgIHN0cnVjdCBk
cGFhMl9xZG1hX2NvbXAgKmNvbXBfdGVtcCA9IE5VTEw7DQo+PiArICAgICB1bnNpZ25lZCBsb25n
IGZsYWdzOw0KPj4gKw0KPj4gKyAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmRwYWEyX2NoYW4tPnF1
ZXVlX2xvY2ssIGZsYWdzKTsNCj4+ICsgICAgIGlmIChsaXN0X2VtcHR5KCZkcGFhMl9jaGFuLT5j
b21wX2ZyZWUpKSB7DQo+PiArICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRw
YWEyX2NoYW4tPnF1ZXVlX2xvY2ssIGZsYWdzKTsNCj4+ICsgICAgICAgICAgICAgY29tcF90ZW1w
ID0ga3phbGxvYyhzaXplb2YoKmNvbXBfdGVtcCksIEdGUF9OT1dBSVQpOw0KPj4gKyAgICAgICAg
ICAgICBpZiAoIWNvbXBfdGVtcCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsN
Cj4+ICsgICAgICAgICAgICAgY29tcF90ZW1wLT5mZF92aXJ0X2FkZHIgPQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIGRtYV9wb29sX2FsbG9jKGRwYWEyX2NoYW4tPmZkX3Bvb2wsDQo+R0ZQX05P
V0FJVCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmY29tcF90ZW1w
LT5mZF9idXNfYWRkcik7DQo+PiArICAgICAgICAgICAgIGlmICghY29tcF90ZW1wLT5mZF92aXJ0
X2FkZHIpDQo+PiArICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfY29tcDsNCj4+ICsNCj4+
ICsgICAgICAgICAgICAgY29tcF90ZW1wLT5mbF92aXJ0X2FkZHIgPQ0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgIGRtYV9wb29sX2FsbG9jKGRwYWEyX2NoYW4tPmZsX3Bvb2wsDQo+R0ZQX05PV0FJ
VCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmY29tcF90ZW1wLT5m
bF9idXNfYWRkcik7DQo+PiArICAgICAgICAgICAgIGlmICghY29tcF90ZW1wLT5mbF92aXJ0X2Fk
ZHIpDQo+PiArICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfZmRfdmlydDsNCj4+ICsNCj4+
ICsgICAgICAgICAgICAgY29tcF90ZW1wLT5kZXNjX3ZpcnRfYWRkciA9DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgZG1hX3Bvb2xfYWxsb2MoZHBhYTJfY2hhbi0+c2RkX3Bvb2wsDQo+R0ZQX05P
V0FJVCwNCj4+ICsNCj4mY29tcF90ZW1wLT5kZXNjX2J1c19hZGRyKTsNCj4+ICsgICAgICAgICAg
ICAgaWYgKCFjb21wX3RlbXAtPmRlc2NfdmlydF9hZGRyKQ0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXJyX2ZsX3ZpcnQ7DQo+PiArDQo+PiArICAgICAgICAgICAgIGNvbXBfdGVtcC0+
cWNoYW4gPSBkcGFhMl9jaGFuOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gY29tcF90ZW1wOw0K
Pj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgY29tcF90ZW1wID0gbGlzdF9maXJzdF9lbnRyeSgm
ZHBhYTJfY2hhbi0+Y29tcF9mcmVlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgZHBhYTJfcWRtYV9jb21wLCBsaXN0KTsNCj4+ICsgICAgIGxpc3RfZGVsKCZj
b21wX3RlbXAtPmxpc3QpOw0KPj4gKyAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHBhYTJf
Y2hhbi0+cXVldWVfbG9jaywgZmxhZ3MpOw0KPj4gKw0KPj4gKyAgICAgY29tcF90ZW1wLT5xY2hh
biA9IGRwYWEyX2NoYW47DQo+PiArDQo+PiArICAgICByZXR1cm4gY29tcF90ZW1wOw0KPj4gKw0K
Pj4gK2Vycl9mbF92aXJ0Og0KPg0KPm5vIGVyciBsb2dzPyBob3cgd2lsbCB5b3Uga25vdyB3aGF0
IHdlbnQgd3Jvbmc/DQo+DQo+PiArc3RhdGljIGVudW0NCj4+ICtkbWFfc3RhdHVzIGRwYWEyX3Fk
bWFfdHhfc3RhdHVzKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRtYV9jb29raWVfdCBjb29raWUsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgZG1hX3R4X3N0YXRlICp0eHN0YXRlKSB7DQo+PiArICAgICByZXR1
cm4gZG1hX2Nvb2tpZV9zdGF0dXMoY2hhbiwgY29va2llLCB0eHN0YXRlKTsNCj4NCj53aHkgbm90
IHNldCBkbWFfY29va2llX3N0YXR1cyBhcyB0aGlzIGNhbGxiYWNrPw0KPg0KPj4gK3N0YXRpYyBp
bnQgX19jb2xkIGRwYWEyX3FkbWFfc2V0dXAoc3RydWN0IGZzbF9tY19kZXZpY2UgKmxzX2Rldikg
ew0KPj4gKyAgICAgc3RydWN0IGRwYWEyX3FkbWFfcHJpdl9wZXJfcHJpbyAqcHByaXY7DQo+PiAr
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmbHNfZGV2LT5kZXY7DQo+PiArICAgICBzdHJ1Y3Qg
ZHBhYTJfcWRtYV9wcml2ICpwcml2Ow0KPj4gKyAgICAgdTggcHJpb19kZWYgPSBEUERNQUlfUFJJ
T19OVU07DQo+PiArICAgICBpbnQgZXJyID0gLUVJTlZBTDsNCj4+ICsgICAgIGludCBpOw0KPj4g
Kw0KPj4gKyAgICAgcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPj4gKw0KPj4gKyAgICAg
cHJpdi0+ZGV2ID0gZGV2Ow0KPj4gKyAgICAgcHJpdi0+ZHBxZG1hX2lkID0gbHNfZGV2LT5vYmpf
ZGVzYy5pZDsNCj4+ICsNCj4+ICsgICAgIC8qIEdldCB0aGUgaGFuZGxlIGZvciB0aGUgRFBETUFJ
IHRoaXMgaW50ZXJmYWNlIGlzIGFzc29jaWF0ZSB3aXRoICovDQo+PiArICAgICBlcnIgPSBkcGRt
YWlfb3Blbihwcml2LT5tY19pbywgMCwgcHJpdi0+ZHBxZG1hX2lkLA0KPiZsc19kZXYtPm1jX2hh
bmRsZSk7DQo+PiArICAgICBpZiAoZXJyKSB7DQo+PiArICAgICAgICAgICAgIGRldl9lcnIoZGV2
LCAiZHBkbWFpX29wZW4oKSBmYWlsZWRcbiIpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gZXJy
Ow0KPj4gKyAgICAgfQ0KPj4gKyAgICAgZGV2X2luZm8oZGV2LCAiT3BlbmVkIGRwZG1haSBvYmpl
Y3Qgc3VjY2Vzc2Z1bGx5XG4iKTsNCj4NCj50aGlzIGlzIG5vaXNlIGluIGtlcm5lbCwgY29uc2lk
ZXIgZGVidWcgbGV2ZWwNCj4NCj4+ICtzdGF0aWMgaW50IF9fY29sZCBkcGFhMl9kcGRtYWlfYmlu
ZChzdHJ1Y3QgZHBhYTJfcWRtYV9wcml2ICpwcml2KSB7DQo+PiArICAgICBpbnQgZXJyOw0KPj4g
KyAgICAgaW50IGksIG51bTsNCj4+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHByaXYtPmRl
djsNCj4+ICsgICAgIHN0cnVjdCBkcGFhMl9xZG1hX3ByaXZfcGVyX3ByaW8gKnBwcml2Ow0KPj4g
KyAgICAgc3RydWN0IGRwZG1haV9yeF9xdWV1ZV9jZmcgcnhfcXVldWVfY2ZnOw0KPj4gKyAgICAg
c3RydWN0IGZzbF9tY19kZXZpY2UgKmxzX2RldiA9IHRvX2ZzbF9tY19kZXZpY2UoZGV2KTsNCj4N
Cj50aGUgb3JkZXIgaXMgcmV2ZXJzZSB0aGFuIHVzZWQgaW4gb3RoZXIgZm4sIHBsZWFzZSBzdGlj
ayB0byBvbmUgc3R5bGUhDQo+LS0NCj5+Vmlub2QNCg==
