Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013BB477DA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2019 04:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfFQCCH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jun 2019 22:02:07 -0400
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:15195
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfFQCCH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 16 Jun 2019 22:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17/We5wOOLgdC2f17qJYMkg69Vx0v4OWfd6xLFHnyqE=;
 b=CVtcM6JCxl7LT5lbXXEWRqsJVCDOrMlaUrambAgkEWMNPHOGdiDwv2QqN8Is/y1MWcW9kSp94DUjfVrL4nMfsB3kK64lYR+n4gWnn+Lwg4aPn0BfITiXJ95rOnNkGJ2D09uOj3qc3/NnBJEKIZrMO2egbBbf45Jm1U+GZwLUhgE=
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (20.179.247.83) by
 AM6PR04MB6408.eurprd04.prod.outlook.com (20.179.244.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 17 Jun 2019 02:02:03 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::7907:11c9:4eaa:4ea4]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::7907:11c9:4eaa:4ea4%3]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 02:02:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "thesven73@gmail.com" <thesven73@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "m.olbrich@pengutronix.de" <m.olbrich@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
Thread-Topic: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
Thread-Index: AQHVIoyD1XkewTwW3U6Cbo4mPhim06aa+IgAgAArvYCABH8JAA==
Date:   Mon, 17 Jun 2019 02:02:02 +0000
Message-ID: <1560765934.30149.26.camel@nxp.com>
References: <20190614083959.37944-1-yibin.gong@nxp.com>
         <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
         <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com>
In-Reply-To: <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57135007-5153-4bab-9c60-08d6f2c7cabd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6408;
x-ms-traffictypediagnostic: AM6PR04MB6408:
x-microsoft-antispam-prvs: <AM6PR04MB6408702471E270A9A7ABD5CA89EB0@AM6PR04MB6408.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(25786009)(6436002)(6486002)(186003)(50226002)(66476007)(66556008)(66446008)(26005)(66946007)(66066001)(446003)(91956017)(76116006)(73956011)(2616005)(476003)(11346002)(71190400001)(71200400001)(2501003)(103116003)(7736002)(4326008)(36756003)(256004)(64756008)(7416002)(99286004)(102836004)(53546011)(5660300002)(6506007)(486006)(86362001)(478600001)(68736007)(81166006)(110136005)(53936002)(316002)(54906003)(3846002)(81156014)(8676002)(229853002)(2906002)(6116002)(6246003)(76176011)(8936002)(6512007)(14454004)(305945005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6408;H:AM6PR04MB6630.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tx7hCjqjNw7zA4h6uIoVV/IF/g2EwlqiTvV9xviUisPupD9x5W2YdMI4vc2BhEmV37p7A0OZyhzqpitKQC/6BX89DAiEPvtqMnoYD9sgKRhEOFofFWlwe7Ap6gHbY4+TpQw8lQVS2i1mpCa2SqsROFwj8HYx7VbG+URxZ1ohjZZqBNHFzCze3Vu2vPBwyNgMUJ5kj2j50JuHjIxevM66n3/JlufD7lrmYPaQS4ulfYVYWwqlKueQ8WS2PP18eAp2IeNVJ7D+TIBCOlp6Kko5UetRnfWx0Di8Pq3pkAshcH1pByD/K8IPS1l9F2X2zXXJ5brEhvAsSxzbVjuBKdO2UBjTIA9LzgeJK3bzZn5NZS36ap6FdyhZNnrjsJlgoesH35d5Nk4fWM8KlbkB0i3GKs9EgHKBZKINBpR0yvr2eQg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <113012975CEC184DAA739606D58E3443@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57135007-5153-4bab-9c60-08d6f2c7cabd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 02:02:03.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6408
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNi0xNCBhdCAxMzoyNSArMDAwMCwgU3ZlbiBWYW4gQXNicm9lY2sgd3JvdGU6DQo+
IE9uIEZyaSwgSnVuIDE0LCAyMDE5IGF0IDY6NDkgQU0gRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBBY2NvcmRpbmcgdG8gdGhlIG9y
aWdpbmFsIHJlcG9ydCBmcm9tIFN2ZW4gdGhlIGlzc3VlIHN0YXJ0ZWQgdG8NCj4gPiBoYXBwZW4N
Cj4gPiBvbiA1LjAsIHNvIGl0IHdvdWxkIGJlIGdvb2QgdG8gYWRkIGEgRml4ZXMgdGFnIGFuZCBD
YyBzdGFibGUgc28NCj4gPiB0aGF0DQo+ID4gdGhpcyBmaXggY291bGQgYmUgYmFja3BvcnRlZCB0
byA1LjAvNS4xIHN0YWJsZSB0cmVlcy4NCj4gR29vZCBjYXRjaCAhDQo+IA0KPiBIb3dldmVyLCB0
aGUgaXNzdWUgaXMgaGlnaGx5IHRpbWluZy1kZXBlbmRlbnQuIEl0IHdpbGwgY29tZSBhbmQgZ28N
Cj4gZGVwZW5kaW5nDQo+IG9uIHRoZSBrZXJuZWwgdmVyc2lvbiwgZGV2aWNldHJlZSBhbmQgZGVm
Y29uZmlnLiBJZiBpdCB3b3JrcyBmb3IgbWUNCj4gb24NCj4gNC4xOSwgdGhhdA0KPiBkb2Vzbid0
IG1lYW4gdGhlIGJ1ZyBpcyBnb25lIG9uIDQuMTkuDQpUaGUgZGVmYXVsdCBpbXggZGVmY29uZmln
IGFuZCBkdHMgc2hvdWxkIGJlIG9rLCBiZWNhdXNlIGZpcm13YXJlIGxvYWQNCmlzIGRlbGF5ZWQg
YWZ0ZXIgcm9vdGZzIG1vdW50ZWQgd2hlcmUgZmlybXdhcmUgbG9jYXRlZCBpbiBhbmQgYmVmb3Jl
DQp0aGF0LCBzb21lIGRyaXZlciB3aGljaCB1c2Ugc2RtYSBzdWNoIGFzIHNwaS91YXJ0L2F1ZGlv
IG1heSBoYXZlDQphbHJlYWR5IGVuYWJsZSBzZG1hIGNsb2NrIHdoaWNoIG1lYW5zIGNoYW5uZWww
IGludGVycnVwdCBjb3VsZCBiZQ0KY2xlYXJlZCBpbW1lZGlhdGVseSB3aXRob3V0IGludGVycnVw
dCBzdG9ybS4gVGhhdCdzIHdoeSBJIGNhbid0DQpyZXByb2R1Y2UgeW91ciBpc3N1ZSBhdCBmaXJz
dCwgYnV0IGNhdGNoIGl0IG9uY2UgSSBzeW5jIHdpdGggeW91cg0KZGlyZWN0bHkgZmlybXdhcmUg
bG9hZCBkZWZjb25maWcuIFNvIHNlZW1zIG5vdCB2ZXJ5IG11c3QgdG8gQ0Mgc3RhYmxlDQp0cmVl
Pw0KPiANCj4gTG9va2luZyBhdCB0aGUgY29tbWl0IGhpc3RvcnksIEkgdGhpbmsgdGhlIGNvbW1p
dCBiZWxvdyBwb3NzaWJseQ0KPiBpbnRyb2R1Y2VkIHRoZQ0KPiBpc3N1ZS4gVW50aWwgdGhpcyBj
b21taXQsIHNkbWFfcnVuX2NoYW5uZWwoKSB3b3VsZCB3YWl0IG9uIHRoZQ0KPiBpbnRlcnJ1cHQN
Cj4gYmVmb3JlIHByb2NlZWRpbmcuIEl0IGhhcyBiZWVuIHRoZXJlIHNpbmNlIDQuODoNCj4gDQo+
IEZpeGVzOiAxZDA2OWJmYTNjNzggKCJkbWFlbmdpbmU6IGlteC1zZG1hOiBhY2sgY2hhbm5lbCAw
IElSUSBpbiB0aGUNCj4gaW50ZXJydXB0IGhhbmRsZXIiKQ0KWWVzLCBidXQgTWljaGFlbCdzIHBh
dGNoIGlzIHRoZSByaWdodCBkaXJlY3Rpb24sIGF0IGxlYXN0IGl0IGZpeCBSVA0KY2FzZSBhbmQg
bWVhbmluZ2xlc3MgY2hhbm5lbDAgaW50ZXJydXB0IHN0b3JtIGNvbWluZyBiZWZvcmUgY2xlYXJp
bmcNCmNoYW5uZWwwIGludGVycnVwdCBzdGF0dXMgaW4gc2RtYV9ydW5fY2hhbm5lbDAoKS4gTm93
LCB0aGlzIHBhdGNoIGNvdWxkDQpmaXggaXRzIG1pbm9yIHNpZGUtZWZmZWN0Lg0KPiANCj4gQnV0
IG15IGtub3dsZWRnZSBvZiBpbXgtc2RtYSBpcyBub24tZXhpc3RlbnQsIHNvIEkgaW52aXRlIHRo
ZSBtb3JlDQo+IGtub3dsZWRnZWFibGUNCj4gcGVvcGxlIGluIHRoaXMgdGhyZWFkIHRvIHRha2Ug
YSBsb29rIGF0IHRoaXMgY29tbWl0Lg0KPiANCj4gW0FkZGluZyBNaWNoYWVsIE9sYnJpY2ggdG8g
dGhlIHRocmVhZF0=
