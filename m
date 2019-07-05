Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD74E5FF61
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 04:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfGECC5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jul 2019 22:02:57 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:44676
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfGECC5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 4 Jul 2019 22:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwYYW5jA8cmmW5WbGVaf8ZM9/irshHrXUXkxUt1pkCY=;
 b=DtAwDjddTNy2z5ycfByxi8zIUHV7QH+uejwHfQGZkzKHDXel2C36/0YNNuIDYkshaa9jE4tn107WBdY60flyGoxeroWemz+w45IBv2yPJHIOsn3zoglwiCaK7mE9wlzvp3f/11yW2MafyW7kEKuXhkOf53TvGwPj89gGS+a5SGg=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB4173.eurprd04.prod.outlook.com (52.133.15.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 02:02:53 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e8aa:b70a:82ad:9309]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e8aa:b70a:82ad:9309%7]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 02:02:53 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     =?utf-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Andy Tang <andy.tang@nxp.com>
Subject: RE: [EXT] [BUG BISECT] Net boot fails on VF50 after "dmaengine:
 fsl-edma: support little endian for edma driver"
Thread-Topic: [EXT] [BUG BISECT] Net boot fails on VF50 after "dmaengine:
 fsl-edma: support little endian for edma driver"
Thread-Index: AQHVMM97bioibA225kez47O1R7Lss6a5tHCwgACryoCAAOi/UA==
Date:   Fri, 5 Jul 2019 02:02:53 +0000
Message-ID: <VI1PR04MB4431B489B4DCAB40A326D479EDF50@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
 <VI1PR04MB44316904F765E93CC1DFA0EDEDFA0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <CAOMZO5BFim2tWxH3nKV08Y1C2-rB7kr8_9v=Qgj+6AXa30-ExQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BFim2tWxH3nKV08Y1C2-rB7kr8_9v=Qgj+6AXa30-ExQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d17d5fe4-8275-4683-5468-08d700ece445
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4173;
x-ms-traffictypediagnostic: VI1PR04MB4173:
x-microsoft-antispam-prvs: <VI1PR04MB417358B5CFDD4757F7CEF685EDF50@VI1PR04MB4173.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(13464003)(229853002)(6116002)(14454004)(66446008)(54906003)(86362001)(478600001)(52536014)(66476007)(6246003)(55016002)(73956011)(316002)(9686003)(102836004)(66556008)(66946007)(76116006)(5660300002)(64756008)(6506007)(4744005)(33656002)(53936002)(66066001)(3846002)(7696005)(6436002)(26005)(4326008)(99286004)(11346002)(25786009)(81166006)(8676002)(81156014)(8936002)(486006)(446003)(66574012)(6916009)(2906002)(7736002)(44832011)(476003)(76176011)(256004)(74316002)(186003)(305945005)(1411001)(68736007)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4173;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Amf7NrOcXaKCe1bqw4VLbrBfVUEc9UzxfnrQsyd3FkHJqidNFwrh9Bj5NzH642dkF0DHVBg1i7/QVqtiO1jSpzk+WIlDM8nQ0or4BnP1vzgOvz29jY91pXfAC1id5qG15zmj+kD8U+30JwxPdloSiNrWIF0w0BexxaYtoDNrtv3+CKKYtTo8TYi5DU3oJWQx4+23+CvrHsuHh/SZlpe24dW0lFyn9Ee6Q2BWNQxBrvJ1jMw1m+JwlfHsYLd5cx9hPuWye0souNMexVMbeAo+u6AbmJbYYJgHTAUJf6bqFpprQAhvl6evoQM6fXvbspOSdFBAFSss41wbYIWQkuCzVpQGgZOII6yqVm3OsbtMVI9uJTwB8ZuPBRuIYZFRWdHnFmGCv18FrqArLpglFrHSkwbROJokstNOlrVRS9mRyCU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17d5fe4-8275-4683-5468-08d700ece445
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 02:02:53.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.ma@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4173
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgRmFiaW8sDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgc3VnZ2VzdGlvbiwgSSB3aWxs
IGRvIHNvbWUgY2hhbmdlcyB0aGVuIHRvDQpTZW5kIHVwc3RyZWFtIHJldmlldy4NCg0KQmVzdCBS
ZWdhcmRzLA0KUGVuZw0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPlNlbnQ6IDIwMTnlubQ35pyINOaXpSAyMDow
Nw0KPlRvOiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+Q2M6IEtyenlzenRvZiBLb3rFgm93
c2tpIDxrLmtvemxvd3NraS5rQGdtYWlsLmNvbT47IFZpbm9kIEtvdWwNCj48dmtvdWxAa2VybmVs
Lm9yZz47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgTGVvDQo+TGkg
PGxlb3lhbmcubGlAbnhwLmNvbT47IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+U3Vi
amVjdDogUmU6IFtFWFRdIFtCVUcgQklTRUNUXSBOZXQgYm9vdCBmYWlscyBvbiBWRjUwIGFmdGVy
ICJkbWFlbmdpbmU6DQo+ZnNsLWVkbWE6IHN1cHBvcnQgbGl0dGxlIGVuZGlhbiBmb3IgZWRtYSBk
cml2ZXIiDQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+SGkgUGVuZywNCj4NCj5PbiBXZWQs
IEp1bCAzLCAyMDE5IGF0IDExOjEwIFBNIFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4gd3JvdGU6
DQo+DQo+PiBTbyB3ZSBuZWVkIHRoaXMgcGF0Y2gsIEkgbWFrZSBzb21lIGNoYW5nZXMsUGxlYXNl
IGhlbHAgbWUgdG8gdGVzdA0KPmF0dGF0Y2htZW50IG9uIFZGNTAgYm9hcmQsDQo+DQo+WW91IG5l
ZWQgdG8gY2hhbmdlIHRoZSBTdWJqZWN0IHRvIHNvbWV0aGluZyBsaWtlOg0KPg0KPlN1YmplY3Q6
IFtQQVRDSF0gZG1hZW5naW5lOiBmc2wtZWRtYTogQWRkIHN1cHBvcnQgZm9yIExTMTAyOEENCj4N
Cj5BbHNvLCBpbiB0aGUgY29tbWl0IGxvZywgcGxlYXNlIGNoYW5nZSAiT3VyIHBsYXRmb3JtcyIg
dG8gIkxTMTAyOEEiDQo+DQo+UGxlYXNlIHJlbW92ZSB0aGlzIHBhcnQ6ICJDdXJyZW50IGVETUEg
ZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgTGl0dGxlIGVuZGlhbiINCj4NCj4sd2hpY2ggaXMgbm90
IGNvcnJlY3QuDQo=
