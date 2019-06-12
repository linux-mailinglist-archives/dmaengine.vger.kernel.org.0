Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82A41A66
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 04:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405026AbfFLCcw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 22:32:52 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:21118
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404957AbfFLCcw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Jun 2019 22:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czVDxJ0zf8mPj6zoTY55KvKQNA0Z7prW1b4S5CPyVgg=;
 b=FGGM+m7Mve3Gix62H81vFM30aQN8PciGEnUPQtUBfiAc7gOMvzYXSRq6WIcVOrPR0zN9BLCMlSzuLQb4WK2FXCMmp5a9pW3AKAfOQ8T7+9gIn405gEWYG03vWKRioXba8E7XkQff0kkC09SdnApqZgPZWUPNF9JK6AFBSGCMB7Y=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6717.eurprd04.prod.outlook.com (20.179.235.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Wed, 12 Jun 2019 02:32:46 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a13e:6f61:e9e6:16d7]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a13e:6f61:e9e6:16d7%7]) with mapi id 15.20.1943.026; Wed, 12 Jun 2019
 02:32:46 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 10/15] dma: imx-sdma: add i.mx6ul/6sx compatible name
Thread-Topic: [PATCH v5 10/15] dma: imx-sdma: add i.mx6ul/6sx compatible name
Thread-Index: AQHVH2TUbTkL7+9S6kqyltkWYzddn6aXDQ2AgADJhYA=
Date:   Wed, 12 Jun 2019 02:32:46 +0000
Message-ID: <1560335783.21664.6.camel@nxp.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
         <20190610081753.11422-11-yibin.gong@nxp.com> <20190611223507.GA25722@bogus>
In-Reply-To: <20190611223507.GA25722@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae661d44-0e4e-4c0c-9394-08d6eede4184
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6717;
x-ms-traffictypediagnostic: VE1PR04MB6717:
x-microsoft-antispam-prvs: <VE1PR04MB671780A9155EB4CA11E4A01789EC0@VE1PR04MB6717.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(54906003)(25786009)(102836004)(2906002)(50226002)(66066001)(478600001)(6486002)(14454004)(6916009)(2501003)(53546011)(6506007)(4326008)(6116002)(3846002)(4744005)(7736002)(6512007)(99286004)(76176011)(53936002)(91956017)(66476007)(64756008)(66446008)(305945005)(66556008)(76116006)(73956011)(86362001)(66946007)(446003)(71200400001)(8936002)(71190400001)(8676002)(229853002)(11346002)(476003)(2616005)(6436002)(256004)(2351001)(5660300002)(81156014)(36756003)(316002)(103116003)(26005)(1730700003)(186003)(81166006)(6246003)(68736007)(7416002)(5640700003)(486006)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6717;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: elcSp7V6Y5RQ3Z0SliXk9WYBx1omOdFOo/8aNfCztwSHf1D/3ZZYrNfcv6nyhnjdFuHc99F859lwHxvSwphu9uhOFX7B9/Z+M6bvZimk2eaEFmB2//S40Vej8w3+xf5SZjLiP/ypMJT+ScAnbmJLJcjXV3cXuZ3f+7dOnr8yTWjaOt14/6Q4Aj2GXPhfy7UVMwQYt9DsK1nkarDYbPAqQHgD0nUjN5/EU9MmOZf7yQoOT38YhsY71m1BevS2dgphq6Lcj2bHAIW5ZKEXDAqWQQv7AKS0dh6uADo79w6tM8aNiOQXTFT3XcAgH7TsMjRoXf0mub/SqW6cHfr0ab+I+tK0fsD0m8/2Mbw1vBI7EH7fE+BvVf2rNI8U7Eg1w3oZxO6BWK6hfzP25Cef44GU/z9eDiDeCfiyB0eZk9Bm3so=
Content-Type: text/plain; charset="utf-8"
Content-ID: <804F0C69EA776E4583B6B19240044F3A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae661d44-0e4e-4c0c-9394-08d6eede4184
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 02:32:46.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6717
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNi0xMSBhdCAyMjozNSArMDAwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIE1v
biwgMTAgSnVuIDIwMTkgMTY6MTc6NDggKzA4MDAsIHlpYmluLmdvbmdAbnhwLmNvbSB3cm90ZToN
Cj4gPiANCj4gPiBGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+ID4gDQo+
ID4gQWRkIGkubXg2dWwgYW5kIGkubXg2c3ggY29tcGF0aWJsZSBuYW1lIGluIGJpbmRpbmcgZG9j
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiDCoERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEv
ZnNsLWlteC1zZG1hLnR4dCB8IDIgKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykNCj4gPiANCj4gUGxlYXNlIGFkZCBBY2tlZC1ieS9SZXZpZXdlZC1ieSB0YWdzIHdoZW4g
cG9zdGluZyBuZXcgdmVyc2lvbnMuDQo+IEhvd2V2ZXIsDQo+IHRoZXJlJ3Mgbm8gbmVlZCB0byBy
ZXBvc3QgcGF0Y2hlcyAqb25seSogdG8gYWRkIHRoZSB0YWdzLiBUaGUNCj4gdXBzdHJlYW0NCj4g
bWFpbnRhaW5lciB3aWxsIGRvIHRoYXQgZm9yIGFja3MgcmVjZWl2ZWQgb24gdGhlIHZlcnNpb24g
dGhleSBhcHBseS4NCj4gDQoNCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBw
bGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQpTb3JyeSBSb2IuLi5JIG1pc3MgeW91
ciBtYWlsIHdpdGggJ1Jldmlld2VkLWJ5JyBpbiB2MiBiZWNhdXNlIGl0IHNsaXANCmludG8gJ3Vu
ayBFbWFpbCcgZm9sZGVyLiBXaWxsIGFkZCB5b3VyIHRhZyBpbiB2NiBpZiBjb21tZW50cyByZWNl
aXZlZA0KZnJvbSB2NQ==
