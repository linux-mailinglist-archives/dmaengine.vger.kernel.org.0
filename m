Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76C47825
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2019 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfFQCOm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jun 2019 22:14:42 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:21870
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfFQCOm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 16 Jun 2019 22:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NphQt7Hbr1DpnpxSJyikDLw4PleNIGyYOAK6f267kf4=;
 b=LvUsfVGRRpfYPiLTKIMIUdbfZ2sJOdUBt+goqKSqS8Ho+aRH9MsbCdDMYQMJwjW0FixNzpq9ww9/kc4Dnj8H6uDIomqBJS/e75OIxmemeSzZcF5si85r92VRefjoalYVdMgiPICFyyQ+LcouySMajnnno9Ygh80qFwQ6SE/6hkU=
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (20.179.247.83) by
 AM6PR04MB4743.eurprd04.prod.outlook.com (20.177.32.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Mon, 17 Jun 2019 02:14:34 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::7907:11c9:4eaa:4ea4]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::7907:11c9:4eaa:4ea4%3]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 02:14:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "m.olbrich@pengutronix.de" <m.olbrich@pengutronix.de>,
        "thesven73@gmail.com" <thesven73@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
Thread-Topic: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
Thread-Index: AQHVIoyD1XkewTwW3U6Cbo4mPhim06aa+IgAgAArvYCAAE8sgIAEM14A
Date:   Mon, 17 Jun 2019 02:14:34 +0000
Message-ID: <1560766686.30149.36.camel@nxp.com>
References: <20190614083959.37944-1-yibin.gong@nxp.com>
         <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
         <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com>
         <20190614180913.d66bbjrnw3gxt663@pengutronix.de>
In-Reply-To: <20190614180913.d66bbjrnw3gxt663@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 901edfa2-f197-4d7d-f8b6-08d6f2c98a96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4743;
x-ms-traffictypediagnostic: AM6PR04MB4743:
x-microsoft-antispam-prvs: <AM6PR04MB4743C2031B6815E1B7DA920489EB0@AM6PR04MB4743.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6486002)(7736002)(305945005)(5660300002)(4326008)(36756003)(71190400001)(71200400001)(6436002)(229853002)(110136005)(54906003)(2501003)(2906002)(476003)(2616005)(316002)(486006)(68736007)(11346002)(50226002)(8936002)(446003)(81166006)(81156014)(14444005)(256004)(478600001)(53546011)(6506007)(53936002)(26005)(8676002)(99286004)(76116006)(86362001)(14454004)(91956017)(66476007)(66556008)(66946007)(186003)(103116003)(64756008)(7416002)(102836004)(66446008)(76176011)(6116002)(6246003)(66066001)(3846002)(6512007)(25786009)(73956011)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4743;H:AM6PR04MB6630.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 67RMrzt1mLpZcdc069gAY8yT5QOV4HFFv4WFzKF7JykMFEXbevJnE1KDigASRJTyJHW0BrkQ4sVOnVc2dJ/dYKTVdYqhufZXH5qACa4irE7yalODu/W0LWsuxqnrB6MAHvJfs/PEZBz7RrkCveWpHxiQEhPoJ83GFLAI7Qo1R63+3nKe93kJDUwpiBZVMWxUJA8dA/p81TFLMhJ0wnCeKMbSOQnuWb/TSg2GZAGuQlrrNaHjfe9pESzdR/B8yIHzWj5SfX3zHXAbGRlY8MUIm/IoBYfqXulDN5GhBp32OvwDO93lnocUJZzGe8gZio6iLcHbD+x0DKTsQn2qZkkU760qvDdUyRh7XFHsmgkrfBj1dfDl2KzSy+JKn/oD1vzFCxbbD2+e020s+jfHsUh+LjsH9+asawjOjjXT8VzRRR8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA34CC396A31349A0561AABF6B06693@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901edfa2-f197-4d7d-f8b6-08d6f2c98a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 02:14:34.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4743
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNi0xNCBhdCAxODowOSArMDAwMCwgTWljaGFlbCBPbGJyaWNoIHdyb3RlOg0KPiBP
biBGcmksIEp1biAxNCwgMjAxOSBhdCAwOToyNTo1MUFNIC0wNDAwLCBTdmVuIFZhbiBBc2Jyb2Vj
ayB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIEp1biAxNCwgMjAxOSBhdCA2OjQ5IEFNIEZhYmlv
IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBBY2NvcmRpbmcgdG8gdGhlIG9yaWdpbmFsIHJlcG9ydCBmcm9tIFN2ZW4gdGhlIGlz
c3VlIHN0YXJ0ZWQgdG8NCj4gPiA+IGhhcHBlbg0KPiA+ID4gb24gNS4wLCBzbyBpdCB3b3VsZCBi
ZSBnb29kIHRvIGFkZCBhIEZpeGVzIHRhZyBhbmQgQ2Mgc3RhYmxlIHNvDQo+ID4gPiB0aGF0DQo+
ID4gPiB0aGlzIGZpeCBjb3VsZCBiZSBiYWNrcG9ydGVkIHRvIDUuMC81LjEgc3RhYmxlIHRyZWVz
Lg0KPiA+IEdvb2QgY2F0Y2ggIQ0KPiA+IA0KPiA+IEhvd2V2ZXIsIHRoZSBpc3N1ZSBpcyBoaWdo
bHkgdGltaW5nLWRlcGVuZGVudC4gSXQgd2lsbCBjb21lIGFuZCBnbw0KPiA+IGRlcGVuZGluZw0K
PiA+IG9uIHRoZSBrZXJuZWwgdmVyc2lvbiwgZGV2aWNldHJlZSBhbmQgZGVmY29uZmlnLiBJZiBp
dCB3b3JrcyBmb3IgbWUNCj4gPiBvbg0KPiA+IDQuMTksIHRoYXQNCj4gPiBkb2Vzbid0IG1lYW4g
dGhlIGJ1ZyBpcyBnb25lIG9uIDQuMTkuDQo+ID4gDQo+ID4gTG9va2luZyBhdCB0aGUgY29tbWl0
IGhpc3RvcnksIEkgdGhpbmsgdGhlIGNvbW1pdCBiZWxvdyBwb3NzaWJseQ0KPiA+IGludHJvZHVj
ZWQgdGhlDQo+ID4gaXNzdWUuIFVudGlsIHRoaXMgY29tbWl0LCBzZG1hX3J1bl9jaGFubmVsKCkg
d291bGQgd2FpdCBvbiB0aGUNCj4gPiBpbnRlcnJ1cHQNCj4gPiBiZWZvcmUgcHJvY2VlZGluZy4g
SXQgaGFzIGJlZW4gdGhlcmUgc2luY2UgNC44Og0KPiA+IA0KPiA+IEZpeGVzOiAxZDA2OWJmYTNj
NzggKCJkbWFlbmdpbmU6IGlteC1zZG1hOiBhY2sgY2hhbm5lbCAwIElSUSBpbiB0aGUNCj4gPiBp
bnRlcnJ1cHQgaGFuZGxlciIpDQo+IEkgdGhpbmsgdGhpcyBpcyBjb3JyZWN0LiBTdGFydGluZyB3
aXRoIHRoaXMgY29tbWl0LCB0aGUgaW50ZXJydXB0DQo+IHN0YXR1cyBmcg0KPiBjaGFubmVsIDAg
aXMgbm8gbG9uZ2VyIGNsZWFyZWQgaW4gc2RtYV9ydW5fY2hhbm5lbDAoKSBhbmQNCj4gc2RtYV9p
bnRfaGFuZGxlcigpIGlzIGFsd2F5cyBjYWxsZWQgZm9yIGNoYW5uZWwgMC4NCj4gRHVyaW5nIGZp
cm13YXJlIGxvYWRpbmcgdGhlIGludGVycnVwdHMgYXJlIGVuYWJsZWQgYWdhaW4ganVzdCBiZWZv
cmUNCj4gdGhlDQo+IGNsb2NrcyBhcmUgZGlzYWJsZWQuIFRoZSBpbnRlcnJ1cHQgaXMgcGVuZGlu
ZyBhdCB0aGlzIG1vbWVudCBzbyBvbiBhDQo+IHNpbmdsZQ0KPiBjb3JlIHN5c3RlbSBJIHRoaW5r
IHRoaXMgd2lsbCBhbHdheXMgd29yayBhcyBleHBlY3RlZC4gSWYgdGhlDQo+IGZpcm13YXJlDQo+
IGxvYWRpbmcgYW5kIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBydW4gb24gZGlmZmVyZW50IGNvcmVz
IHRoZW4gdGhpcyBpcw0KPiByYWN5Lg0KPiBNYXliZSBzb21ldGhpbmcgZWxzZSBjaGFuZ2VkIHRv
IG1ha2UgdGhpcyBtb3JlIGxpa2VseT8NCj4gDQo+IFdpdGggdGhpcyBuZXcgY2hhbmdlIHNkbWFf
aW50X2hhbmRsZXIoKSBpcyBubyBsb25nZXIgY2FsbGVkIGZvcg0KPiBjaGFubmVsIDANCj4gcmln
aHQsIHNvIHlvdSBzaG91bGQgYWxzbyByZW1vdmUgdGhlIHNwZWNpYWwgaGFuZGxpbmcgdGhlcmUu
DQpXaGF0J3MgJ3NwZWNpYWwgaGFuZGxpbmcnIHNob3VsZCBiZSByZW1vdmVkIGhlcmU/IERvIHlv
dSBtZWFuIHB1dCBiZWxvdw0KcGllY2VzIG9mIHlvdXIgcGF0Y2ggYmFjaz8NCsKgc3RhdGljIGlu
dCBzZG1hX2xvYWRfc2NyaXB0KHN0cnVjdCBzZG1hX2VuZ2luZSAqc2RtYSwgdm9pZCAqYnVmLCBp
bnQNCnNpemUsDQpAQCAtNzI3LDkgKzcyMCw5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBzZG1hX2lu
dF9oYW5kbGVyKGludCBpcnEsIHZvaWQNCipkZXZfaWQpDQrCoMKgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgbG9uZyBzdGF0Ow0KwqANCsKgwqDCoMKgwqDCoMKgwqBzdGF0ID0gcmVhZGxfcmVsYXhlZChz
ZG1hLT5yZWdzICsgU0RNQV9IX0lOVFIpOw0KLcKgwqDCoMKgwqDCoMKgLyogbm90IGludGVyZXN0
ZWQgaW4gY2hhbm5lbCAwIGludGVycnVwdHMgKi8NCi3CoMKgwqDCoMKgwqDCoHN0YXQgJj0gfjE7
DQrCoMKgwqDCoMKgwqDCoMKgd3JpdGVsX3JlbGF4ZWQoc3RhdCwgc2RtYS0+cmVncyArIFNETUFf
SF9JTlRSKTsNCivCoMKgwqDCoMKgwqDCoC8qIGNoYW5uZWwgMCBpcyBzcGVjaWFsIGFuZCBub3Qg
aGFuZGxlZCBoZXJlLCBzZWUNCnJ1bl9jaGFubmVsMCgpICovDQorwqDCoMKgwqDCoMKgwqBzdGF0
ICY9IH4xOw0KDQo+IA0KPiBNaWNoYWVsDQo+IA==
