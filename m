Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEDC27444
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2019 04:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfEWCJA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 22:09:00 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:64142
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727854AbfEWCJA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 22:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwZgzs/4aZwNfCjdz+/ne/jbJMPxd4bUOyyhLYXEmVI=;
 b=nP+EimQWUqrXt5cXHaVpbVhy9ZH0Qhzk9/N8pJLoVsYEIZArUpMWK+JjZhixjfAkEwKt6YzZUk4IbDXAjv9uQ73WmK9LUTo7ME0k2MXH+Ydx6ljp8vfknOuWbPlf42I7KMpJ5FFL9oECyA8N7GB96CvUPqYnmsYB2ECqIlrFaq0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6094.eurprd04.prod.outlook.com (20.179.25.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 23 May 2019 02:08:55 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 02:08:54 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v4 10/14] dma: imx-sdma: add i.mx6ul/6sx
 compatible name
Thread-Topic: [EXT] Re: [PATCH v4 10/14] dma: imx-sdma: add i.mx6ul/6sx
 compatible name
Thread-Index: AQHVEIU1vbltRMJezUidB/k1RHkv66Z3Kd0AgADL88A=
Date:   Thu, 23 May 2019 02:08:54 +0000
Message-ID: <VI1PR04MB4543BE5BB829A2BFDA48824789010@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
 <1558548188-1155-11-git-send-email-yibin.gong@nxp.com>
 <20190522135128.GA24987@bogus>
In-Reply-To: <20190522135128.GA24987@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 817b28b3-d63c-44eb-92dc-08d6df239bc7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6094;
x-ms-traffictypediagnostic: VI1PR04MB6094:
x-microsoft-antispam-prvs: <VI1PR04MB6094D46D8E2A38D25049248E89010@VI1PR04MB6094.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(13464003)(189003)(199004)(446003)(476003)(11346002)(4744005)(71190400001)(71200400001)(52536014)(5660300002)(2906002)(486006)(186003)(68736007)(66446008)(64756008)(66556008)(66476007)(66946007)(73956011)(6116002)(26005)(3846002)(7736002)(76116006)(305945005)(81156014)(81166006)(86362001)(66066001)(6916009)(316002)(74316002)(8676002)(8936002)(33656002)(7416002)(54906003)(76176011)(7696005)(229853002)(25786009)(102836004)(256004)(14444005)(4326008)(99286004)(53936002)(55016002)(9686003)(478600001)(6436002)(6506007)(6246003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6094;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3K3cPhbNnzwtDRRdVPWB7LqwrE1SytmzdbFbuVWzSXwQZk3Y7rA0D2XnHHotVTwx3+sRL6VDKWi/xQHHiF6yFOFhIZT9Wd/aljoL8Lx5wOsbGuPHmU5mqHJO63/04mu916C8MXbmFOZklhC+ZuvCV8veFV2h9d2TCHgTZNUqRTRO0642CtdTdz5ibtYipB/riCr8VKtr1VkNBDp102UhasX3I5J4Xvra1cki0WLom6AyaUt/UsqL+Rikl+XKAckrNigKNMyLr9/kV9jCuaBDR6vIHIIIeu1Iop1OeyKgwAnK2AgeUJ9LGAJYrr3a0xbKyuZEo2flSHijZx4vyygD+sxrFhKNJt4szoidsugeYeiY8AUvUU8XZJsI2H4l2PuFKpp1D+XGfLH/uC2XXYdCxB49FYJ8VGstqB2hL0HBwPg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817b28b3-d63c-44eb-92dc-08d6df239bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 02:08:54.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6094
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgUm9iLA0KCVRoYW5rIHlvdSBmb3IgeW91ciByZW1pbmRpbmcsIEkgaGF2ZSBhZGRlZCBBY2tl
ZC1ieSB0YWdzIGdvdHRlbiBmcm9tIE1hcmsgYW5kIFZpbm9kIGluIHY0IHBhdGNoIHNldCwgYnV0
IHRoZXJlIGlzIHN0aWxsIG9uZSB1cGRhdGUgKA0KcmVtb3ZlIGNoZWNraW5nICdldmVudF9pZDEn
IHplcm8gYXMgJ2V2ZW50X2lkMCcuKSBmb3IgVmlub2QncyBjb25jZXJuLCBzbyBJIHNlbnQgbmV3
IHY0Lg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOo11MIyMsjVIDIxOjUxPiANCj4gT24gV2Vk
LCAyMiBNYXkgMjAxOSAxMDowMDozOCArMDAwMCwgUm9iaW4gR29uZyB3cm90ZToNCj4gPiBBZGQg
aS5teDZ1bCBhbmQgaS5teDZzeCBjb21wYXRpYmxlIG5hbWUgaW4gYmluZGluZyBkb2MuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1z
ZG1hLnR4dCB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+IA0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5n
IG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRj
aGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdp
bGwgZG8gdGhhdCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0K
PiANCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5
IGFuZCB3aGF0IGNoYW5nZWQuDQo=
