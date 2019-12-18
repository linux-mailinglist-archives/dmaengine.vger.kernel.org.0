Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70389124112
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 09:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLRIIl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Dec 2019 03:08:41 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:49292
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfLRIIk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Dec 2019 03:08:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhT+9cnbck736rc9yuZlt9wINmtukkXelVaDAJdqsHkgiS9Ga4qfV7zCGUZo+MKG7CcSaMXgUQHR3D8cF7g3WcWnZ1vhZ/7PHZWHcDIQWuSlj9Os/5Nyl/F1nMBKWcqHwueY9nDvcd9wPXhYjr3Z/+yRHwJcgEvrKbCpgzyFOmuUskOiZ99Yv9G5/hPvojV+laIU7w25awsPZDje18nmBi+N9Szb8Hv5DGrrVwmROBbY2VapTt9My5/Ys323yDWYFQ2581ZgoCiHBUY4uU/DdvxH6jWiUwd51mgCGKAiO8kGHOWZEkfgFW446r5nFH0dvaLOuNDFCntlp6Rz24luWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovEfgZslOqMtGobrUV+zTs5YM/9ptDygbKOIgAaUPZk=;
 b=mtoNEUs1QwuW/N0XoWMXH1SPde+rcPAsfN+lNYB1VXckWgcxNRz3wVGnTGM1nOFEEvRlU5FSQrWKhCTO6D91GMkrUc9GBPnv2CrSdU86CzkWI7KtKmPa2angwc9p+5vQT7DWaX1GsRjMgN9jlmHv3CHU0j/bHBGp55uYDB10nTS6mJQnau+yhrhmANU49l8rxmHE/hpAeRC2Q3enDPEFBZv0s5ERmzjfHx3RCtSwkH0foF/f/jUQDBTb8GkGs/uu1TWZfjuM+lhqCM3MS+64PCQYnFd3qeTyVeMI+sN/ObEG3aelWqEAKlVqCu/gs7/cqQbPSa0zFB0ajz7J7OkCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovEfgZslOqMtGobrUV+zTs5YM/9ptDygbKOIgAaUPZk=;
 b=XwGFKd5ihe3BLqdilQb7VytBG2DAh561Bx9H0SOtOH/NuV7lq48PQSXOTLY8kSDQjSx9bAV3Ltv4ntBXxSgh1VlSjgIfZ9KLgXasI+Is3onziRFvkbvLcTfoBVXCCzWN/S1eRnJd/iZ8ZHaN2f3IRIPkGGLygmQYBRm+TWanY2k=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB6782.eurprd04.prod.outlook.com (52.133.247.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 08:08:35 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 08:08:35 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for
 QorIQ LS1028A platform
Thread-Topic: [EXT] Re: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for
 QorIQ LS1028A platform
Thread-Index: AQHVsJ2TZ/jVyH6lNkyvcDWZa1lfcae/dvcAgAAYxuA=
Date:   Wed, 18 Dec 2019 08:08:35 +0000
Message-ID: <VI1PR04MB44311BE955B863C73DF4CD4CED530@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20191212033714.4090-1-peng.ma@nxp.com>
 <20191218062636.GS2536@vkoul-mobl>
In-Reply-To: <20191218062636.GS2536@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43863002-ee19-4a06-85eb-08d783917b57
x-ms-traffictypediagnostic: VI1PR04MB6782:|VI1PR04MB6782:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB678262FAD473F12BD71499E5ED530@VI1PR04MB6782.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(13464003)(55016002)(52536014)(6916009)(54906003)(76116006)(44832011)(186003)(66946007)(66476007)(66556008)(2906002)(26005)(64756008)(66446008)(71200400001)(316002)(86362001)(5660300002)(6506007)(7696005)(8936002)(8676002)(81156014)(81166006)(9686003)(4326008)(478600001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6782;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4C64x9MMWxzJszRg4jdXeAY1gjM58i0yvH5t/ggP3jEH9LGinveAUPcmds5kPcgymf9847Dyy0A1+9ylvovC6QT5B5VYnSwqTxzEvsWsmsfcD4tH2htFbux/gJy2m3dzTB+sixrTuFtGAGyEhQfmnxKezgaKBx14rrGYI4P/8Ma8DL8QMELPQ62V0hp3G1iOdh78Ef6hdF6i27PwUM+onG2hSCNbC124QigBs9PxyvRpH/HIILEihVOloNya0Xav/srXnzTuo40LqNuq6P+Pf+mLStTRsBWQ8aH/+8TVEh7MLSpU42X+ftnavQkYo4/fZ2Jo8sf1aWxzMRAZBOqfZ3vumlJCUSwrfIImHJCWM49tbba/PfGWajjVcwKod1gqUf0hPUAAdD7Pujc6b33KMyCLNRLWbLP3W/4/oj7U5JIUnnOycM4KHAIzaGAEGGhHSB+7qLtsa/9nul94pKlDOukfcKm/Ebq9QR0q2DA8wGLOHatW6xGoEZvoe6lpjx1
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43863002-ee19-4a06-85eb-08d783917b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 08:08:35.8276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxNTmkDT/bDJ3atPyEJdM2wOWc+eHpviQO7eEFr/qD1swRudYPqYBWEK+c0Sn3Pu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6782
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqMTLUwjE4yNUgMTQ6MjcNCj5UbzogUGVuZyBNYSA8
cGVuZy5tYUBueHAuY29tPg0KPkNjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8NCj5MaSA8bGVveWFuZy5saUBueHAuY29t
PjsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBSb2JpbiBHb25nDQo+PHlpYmluLmdvbmdAbnhw
LmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+U3ViamVjdDogW0VYVF0gUmU6IFt2NSAxLzNdIGRtYWVuZ2lu
ZTogZnNsLWVkbWE6IEFkZCBlRE1BIHN1cHBvcnQgZm9yIFFvcklRDQo+TFMxMDI4QSBwbGF0Zm9y
bQ0KPg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0KPk9uIDEyLTEyLTE5LCAwMzozOCwgUGVuZyBN
YSB3cm90ZToNCj4+IE91ciBwbGF0Zm9ybXMoc3VjaCBhcyBMUzEwMjFBLCBMUzEwMTJBLCBMUzEw
NDNBLCBMUzEwNDZBLCBMUzEwMjhBKQ0KPj4gd2l0aCBiZWxvdyByZWdpc3RlcnMoQ0hDRkcwIC0g
Q0hDRkcxNSkgb2YgZURNQSBhcyBmb2xsb3dzOg0KPj4gKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKg0KPj4gfCAgICAgT2Zmc2V0ICAg
fCAgICAgIE9USEVSUyAgICAgICAgICAgICAgICAgIHwNCj5MUzEwMjhBICAgICAgICAgICAgICAg
ICB8DQo+PiB8LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS18DQo+PiB8ICAgICAweDAgICAgICB8ICAgICAgICBDSENGRzAgICAgICB8ICAg
ICAgICAgICBDSENGRzMgICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0t
LS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgICAweDEgICAgICB8ICAgICAg
ICBDSENGRzEgICAgICB8ICAgICAgICAgICBDSENGRzIgICAgICB8DQo+PiB8LS0tLS0tLS0tLS0t
LS18LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAg
ICAweDIgICAgICB8ICAgICAgICBDSENGRzIgICAgICB8ICAgICAgICAgICBDSENGRzEgICAgICB8
DQo+PiB8LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18DQo+PiB8ICAgICAweDMgICAgICB8ICAgICAgICBDSENGRzMgICAgICB8ICAgICAg
ICAgICBDSENGRzAgICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0t
LS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgICAuLi4gICAgICB8ICAgICAgICAu
Li4uLi4gICAgICB8ICAgICAgICAgICAuLi4uLi4gICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS18
LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgICAw
eEMgICAgICB8ICAgICAgICBDSENGRzEyICAgICB8ICAgICAgICAgICBDSENGRzE1ICAgICB8DQo+
PiB8LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS18DQo+PiB8ICAgICAweEQgICAgICB8ICAgICAgICBDSENGRzEzICAgICB8ICAgICAgICAg
ICBDSENGRzE0ICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS18
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgICAweEUgICAgICB8ICAgICAgICBDSENG
RzE0ICAgICB8ICAgICAgICAgICBDSENGRzEzICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS18LS0t
LS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgICAweEYg
ICAgICB8ICAgICAgICBDSENGRzE1ICAgICB8ICAgICAgICAgICBDSENGRzEyICAgICB8DQo+PiAq
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0qDQo+Pg0KPj4gVGhpcyBwYXRjaCBpcyB0byBpbXByb3ZlIGVkbWEgZHJpdmVyIHRvIGZpdCBM
UzEwMjhBIHBsYXRmb3JtLg0KPg0KSGkgVmlub2QNCg0KPkFwcGxpZWQgdGhpcyBhbmQgcGF0Y2gg
MywgdGhhbmtzDQo+DQpbUGVuZyBNYV0gTWFueSB0aGFua3MuDQoNCj5CdHcgcGxzIHNlbmQgYmlu
ZGluZ3MgYXMgcGF0Y2gxIGFuZCBkcml2ZXIgY2hhbmdlcyBhcyBwYXRjaDIuDQpbUGVuZyBNYV0g
SSBkb24ndCB1bmRlcnN0YW5kIHRoaXMgc2VudGVuY2UsIFBsZWFzZSBnaXZlIG1lIG1vcmUgaW5m
b3JtYXRpb24uDQpBcyBJIGtub3cgcGF0Y2gxIGlzIGRyaXZlciBjaGFuZ2VzLCBwYXRjaDIgaXMg
ZHRzIGNoYW5nZXMsIHBhdGNoMyBpcyBiaW5kaW5nIGNoYW5nZXMuDQpZb3UgYWNjZXB0ZWQgcGF0
Y2gxIGFuZCBwYXRjaDMsIEkgYW0gcHV6emxlZCBmb3IgcGF0Y2gyIGFuZCB5b3VyIGNvbW1lbnRz
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpQZW5nDQo+LS0NCj5+Vmlub2QNCg==
