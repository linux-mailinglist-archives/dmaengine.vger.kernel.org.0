Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C2DC7A5
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2019 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634210AbfJROmQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Oct 2019 10:42:16 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:57154
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2634209AbfJROmQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Oct 2019 10:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTf0m4ucVqhxJyXJO/0exttXQXB1qGBLYaWe13jb3yTlnRjMawJUnkF7+9jIVEfUHuUNt/az3QnJmwHEpqR5uVfQcGRIR1L9jATyVE6ba6bfASeYrkEQSu4Krr/RUshlKZf67ERFnd3kEj+qyospNH8dA2KmA3jS+llYaEoBVHh7BgFr3x4TSpTfYOvo3/8wGZn4hkARY+8UyxRnPMdp2JoveeZj4IQSsZO8Ui2v75nvE7JiVZgJx6x3XauRxaXLcJv7v6kmZoz5/2+ceaxlrp8BOmipdPYdeqwscSMFjyGoHZZa6bzursoA0I44jqmN1p7o/cSRfmE0QecaPRDwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d45jBOeqBbKymE2IdKuXiniRWOk1mMm2BRHWF5SS6I=;
 b=jwr+5fj0bw+oky+LUs5WaxqTK5mmTQNWU3agutemeCHqYlBbqUp9BvpJ7LuzMgLW6ZFU0/D0EI2xQFYZwRMUJwR2Fr15nBEHhlqL5UNqKALKKr+SupWWp0EFfr8/LTiYbGtcTx+8mL2Xx4QggabUFV+AOpVMlirnzi2B5uTPUtox+RA7dvRvabTT5V9iMMr0TwvmxaF5cHdg7LlwF2DpH7Ejlx5SEHE/CPZvASKoVWdD4Y3HD2Ixi54BGv7ZqmhoyKU5hSjrQtSF+R/2qYut6TgjKh82LdBbTybX891qD6mUWhzh+JkJ+Q6ynbY7dmN+nYGtSfTx8p8awdI1xdC2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d45jBOeqBbKymE2IdKuXiniRWOk1mMm2BRHWF5SS6I=;
 b=BU0oYx0FFL1qKQy0/+X6dDB9pKjrjJ4INsBquM8U9AaK/YCX0O4E4DRo2B96ULAzqRANABQVHat/KXFzSvSZq/yWV9AVaSXar/08no+Ik5gcvt7bK9pjydaF11G3h1VO0CLGkZjXR2FPsEYrtTil/AlRrha1MfoIDxP4N5Cfp8g=
Received: from DB7PR04MB4425.eurprd04.prod.outlook.com (52.135.140.156) by
 DB7PR04MB3979.eurprd04.prod.outlook.com (52.134.107.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 18 Oct 2019 14:42:12 +0000
Received: from DB7PR04MB4425.eurprd04.prod.outlook.com
 ([fe80::c068:28ec:7f2f:4a5e]) by DB7PR04MB4425.eurprd04.prod.outlook.com
 ([fe80::c068:28ec:7f2f:4a5e%6]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 14:42:12 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        =?utf-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dmaengine: fsl-edma: Add eDMA support for QorIQ
 LS1028A platform
Thread-Topic: [EXT] Re: [PATCH] dmaengine: fsl-edma: Add eDMA support for
 QorIQ LS1028A platform
Thread-Index: AQHVhLtWQPtc6yR4Rkmk/ITG0gU0sqdgdkiAgAAAQmCAAAPyAIAAAD1Q
Date:   Fri, 18 Oct 2019 14:42:12 +0000
Message-ID: <DB7PR04MB442531FC495F99A80011E392ED6C0@DB7PR04MB4425.eurprd04.prod.outlook.com>
References: <20191017070923.6705-1-peng.ma@nxp.com>
 <CAOMZO5AK+wv0vAfqv7PC-gYF32MSD9nMqFCuRmLxMN6dYZdvGA@mail.gmail.com>
 <DB7PR04MB4425E937B423C39F0F45FCEDED6C0@DB7PR04MB4425.eurprd04.prod.outlook.com>
 <CAOMZO5DrJ=T1CZE4bb5bQngrcjDAxMWck-ru25Ew5oeA62L0kA@mail.gmail.com>
In-Reply-To: <CAOMZO5DrJ=T1CZE4bb5bQngrcjDAxMWck-ru25Ew5oeA62L0kA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f303bab3-d974-40cc-1e6a-08d753d95c8b
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR04MB3979:|DB7PR04MB3979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB39794D062147A7AD952CBF12ED6C0@DB7PR04MB3979.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(13464003)(189003)(199004)(5660300002)(6436002)(66066001)(54906003)(305945005)(86362001)(99286004)(71190400001)(71200400001)(66446008)(64756008)(66476007)(66946007)(66556008)(7736002)(186003)(74316002)(26005)(4744005)(76116006)(76176011)(316002)(52536014)(3846002)(6116002)(6506007)(229853002)(14454004)(256004)(7696005)(9686003)(6916009)(102836004)(8676002)(44832011)(33656002)(8936002)(446003)(25786009)(486006)(478600001)(11346002)(476003)(6246003)(81156014)(4326008)(81166006)(55016002)(1411001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3979;H:DB7PR04MB4425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6LKx07Cu6pSFnC9DDThaynZqHT0nv46uPQhNIG3MIAZ5lQz3/BxzFqI0t9vyw2wwfKg/O0kBQusWHrzhjcGn702vwd2tKATNreURrxRCty0Yh8jzVfAszphvyWNcPCVe/awUTIbj7y/KgjtRTbLwxbImxjRa4ac6QzEoAF7/etD/NhfaBSlfh3lKLwz3fl5uslQiBBDat/CmeyMrV3bpaW2TtQxEG45ObvWRp+y+PHVWw0eysJjFNCq3L23VrLzxMfbwOxDpLFq1f2ecNiA9NBLmtqkExiNNJ77iXUrL0+GcCL4Iv8XMKoY1EwRLn2PKyCxkORtlCNJxFcKxBEP8/0o4y/Ewx5vi5EmpMYNxDNtJ1PXtLS7UqC6HDOdcAOaEqpxreiOeitOWy2w3Cs5S70CHHx/0NjrT55dQSoGods=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f303bab3-d974-40cc-1e6a-08d753d95c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 14:42:12.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 813EwoQfUSBDLF3OrcOQNHb0l2B43j8MI/mEiRSH9zhTUpJugzcGlCfi7gNsIMBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3979
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgRmFiaW8sDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZhYmlvIEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj5TZW50OiAyMDE55bm0MTDmnIgxOOaXpSAyMjo0
MA0KPlRvOiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+Q2M6IFZpbm9kIDx2a291bEBrZXJu
ZWwub3JnPjsgRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBMZW8NCj5M
aSA8bGVveWFuZy5saUBueHAuY29tPjsgS3J6eXN6dG9mIEtvesWCb3dza2kgPGsua296bG93c2tp
LmtAZ21haWwuY29tPjsNCj5GYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBk
bWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz4NCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSF0gZG1hZW5naW5l
OiBmc2wtZWRtYTogQWRkIGVETUEgc3VwcG9ydCBmb3INCj5Rb3JJUSBMUzEwMjhBIHBsYXRmb3Jt
DQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+SGkgUGVuZywNCj4NCj5PbiBGcmksIE9jdCAx
OCwgMjAxOSBhdCAxMToyOCBBTSBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+IHdyb3RlOg0KPj4N
Cj4+IEhpIEZhYmlvLA0KPj4NCj4+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCj4+IERvIHlv
dSBtZWFuIEkgZXhwbGFpbiAiT3VyIHBsYXRmb3JtcyIgaGVyZSBvciBpbiBwYXRjaD8NCj4NCj5J
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gc2VuZCBhIHYyIHdpdGggYW4gaW1wcm92ZWQgY29tbWl0IGxv
Zywgd2hpY2ggZXhwbGFpbnMNCj53aGF0ICJPdXIgcGxhdGZvcm1zIiBtZWFuLg0KPg0KPlRoYW5r
cw0KW1BlbmcgTWFdIEdvZCBpdCAsdGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpQZW5nDQo=
