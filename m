Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C66024797
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfEUFlw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 01:41:52 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:4613
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbfEUFlw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 01:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjW6d4NH7HfreHyJrWhVSe7vszRzXmyQLn7JhAqtYIw=;
 b=Q7SviENjL0M2SOpEKQTLOEvsEzbkpF6y9GD/NO/lvRwgW7JaaVzxzTZENtMUSzjeuMTySVFsJJbNZkLbaudHoT/DuP0If8KEskeqhACn3cfPnT1otj8jKy2zQchlSaKnqTc6zO4flJdSYj7m6DZE7dLROk4MLGKBcHCwY8ImH2U=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3214.eurprd04.prod.outlook.com (10.170.227.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 05:41:46 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 05:41:46 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: Re: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma
 not work on i.mx8mm
Thread-Topic: Re: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma
 not work on i.mx8mm
Thread-Index: AdUPltdtzINQOtdfTGCZR5rwJ5SHbw==
Date:   Tue, 21 May 2019 05:41:46 +0000
Message-ID: <VI1PR04MB4543DEEC702531ED69616B8C89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abce53c9-6e82-4f12-b498-08d6ddaf0344
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3214;
x-ms-traffictypediagnostic: VI1PR04MB3214:
x-microsoft-antispam-prvs: <VI1PR04MB3214673A46A46795F386F20B89070@VI1PR04MB3214.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(13464003)(66066001)(86362001)(25786009)(6916009)(305945005)(7696005)(54906003)(7736002)(8676002)(66946007)(26005)(66446008)(4326008)(6436002)(186003)(73956011)(33656002)(66476007)(64756008)(66556008)(76116006)(55016002)(229853002)(478600001)(476003)(9686003)(8936002)(68736007)(71190400001)(71200400001)(7416002)(256004)(5660300002)(6246003)(99286004)(316002)(14454004)(52536014)(2906002)(3846002)(74316002)(53936002)(81166006)(6506007)(53546011)(81156014)(486006)(102836004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3214;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qC3GzvuOMWdyy5mTcZ3r4qLZOuXq5jLr/RHd/eTAOKQSoA8R/TW5yTvjHRMYrVcUgGom5oXq/PSAYnh0/w0CYS89ZgSjtWYosQQu35nprDlg1aLBlJouIUbNNWvI2cLbMQ/lQFWUPPX6L+OCADWv4odm+suHE61qAVN5AhmrpdZZiwQ7UqodfappmnpKCUu/4VRvYNIWA9WD6wlxPVT/9awhA9ROsq0uBJyXvbW+yepLge1R7L0NNWDvNVwywSuxH07J678wtmTmA6O/gJxoOUMza2q55dLg0UZj/pVVDx6qSwjYhz3Uj4bXVIkYXCDiX29tyqANs81gEWvOHk4bUOP7WjWZpYsd21CZ6VwfEyDFislUnPDKAeEhFYcbL3r0gT0YFVkxrYC/jI3dsXfy4q7MeTgLOVJ77YHr0oT7ITQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abce53c9-6e82-4f12-b498-08d6ddaf0344
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 05:41:46.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3214
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0NeaciDIx5pelIDEzOjEzDQo+IA0KPiBPbiAyMS0w
NS0xOSwgMDQ6NTgsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj4gPiA+
IFNlbnQ6IDIwMTnlubQ15pyIMjHml6UgMTI6MTgNCj4gPiA+DQo+ID4gPiBPbiAwNy0wNS0xOSwg
MDk6MTYsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gPiA+IEJlY2F1c2UgdGhlIG51bWJlciBvZiBl
Y3NwaTEgcnggZXZlbnQgb24gaS5teDhtbSBpcyAwLCB0aGUNCj4gPiA+ID4gY29uZGl0aW9uIGNo
ZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBjaGFubmVsDQo+ID4gPiA+
IGVuYWJsZWQsIHdoaWNoIGNhdXNlZA0KPiA+ID4gPiBlY3NwaTEgcnggd29ya3MgZmFpbGVkLiBB
Y3R1YWxseSwgbm8gbmVlZCB0byBjaGVjayBldmVudF9pZDAsDQo+ID4gPiA+IGNoZWNraW5nDQo+
ID4gPiA+IGV2ZW50X2lkMSBpcyBlbm91Z2ggZm9yIERFVl8yX0RFViBjYXNlIGJlY2F1c2UgaXQn
cyBzbyBsdWNreSB0aGF0DQo+ID4gPiA+IGV2ZW50X2lkMSBuZXZlciBiZSAwLg0KPiA+ID4NCj4g
PiA+IFdlbGwgaXMgdGhhdCBieSBjaGFuY2Ugb3IgZGVzaWduIHRoYXQgZXZlbnRfaWQxIHdpbGwg
YmUgbmV2ZXIgMD8NCj4gPiA+DQo+ID4gVGhhdCdzIGJ5IGNoYW5jZS4gREVWXzJfREVWIGlzIGp1
c3QgZm9yIEF1ZGlvIGNhc2UgYW5kIG5vbi16ZXJvIGZvcg0KPiBldmVudF9pZDEgb24gY3VycmVu
dCBpLk1YIGZhbWlseS4NCj4gDQo+IFRoZW4gaXQgd29udCBiZSBmZ29vZCB0byByZWx5IG9uIGNo
YW5jZSA6KQ0KWWVzLCBJIGtuZXcgdGhhdC4gTWF5IEkgY3JlYXRlIGFub3RoZXIgaW5kZXBlbmRl
bnQgcGF0Y2ggZm9yIGV2ZW50X2lkMSBzaW5jZSB0aGF0J3MgcG90ZW50aWFsIGlzc3VlIGlzIG5v
dCByZWxhdGVkIHdpdGggdGhpcyBlY3NwaSBwYXRjaCBzZXQ/DQo+IA0KPiAtLQ0KPiB+Vmlub2QN
Cg==
