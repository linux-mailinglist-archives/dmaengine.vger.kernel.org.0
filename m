Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55234991C
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 08:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFRGpC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 02:45:02 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:28163
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728869AbfFRGpC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jun 2019 02:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXTXVLwOQccmH5Thz0oDuh3qFF1mw7M4vpWaXyEDF/Q=;
 b=kBXT/GS9//Js7lmSeOJp4Q9Cj6Rc8uIoi4II688xJ6IT1Eh03UVHl0or9EKhJEujqslI0gLXJS2lT4czvfNCshoWIaZfgUAqNMqH59elhcsGysCSIBSeSdUDl4z4WNx2ytZvWD+7fW7z1ppo7KSJm3BzOcUiE0kTp/95L4ApbGE=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6671.eurprd04.prod.outlook.com (20.179.235.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 05:50:39 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 05:50:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "thesven73@gmail.com" <thesven73@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
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
Thread-Index: AQHVIoyD1XkewTwW3U6Cbo4mPhim06aa+IgAgAArvYCABH8JAIAAOHoAgAGZugA=
Date:   Tue, 18 Jun 2019 05:50:39 +0000
Message-ID: <1560866050.26847.2.camel@nxp.com>
References: <20190614083959.37944-1-yibin.gong@nxp.com>
         <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
         <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com>
         <1560765934.30149.26.camel@nxp.com>
         <CAGngYiU_kxRXbk1vSzV+hBZ=SQdxe2h7TXj3dbK6Q=YyXcDr0g@mail.gmail.com>
In-Reply-To: <CAGngYiU_kxRXbk1vSzV+hBZ=SQdxe2h7TXj3dbK6Q=YyXcDr0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c064ad8b-c6d1-407e-21ab-08d6f3b0e4b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6671;
x-ms-traffictypediagnostic: VE1PR04MB6671:
x-microsoft-antispam-prvs: <VE1PR04MB6671B9B8EDF34EF7400C2C6B89EA0@VE1PR04MB6671.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(5660300002)(76116006)(103116003)(6512007)(6436002)(25786009)(8676002)(81156014)(50226002)(5640700003)(2501003)(81166006)(53936002)(76176011)(229853002)(2351001)(102836004)(6486002)(316002)(7416002)(54906003)(53546011)(1361003)(6916009)(6506007)(8936002)(99286004)(14454004)(478600001)(1411001)(186003)(2616005)(476003)(68736007)(446003)(11346002)(26005)(486006)(6246003)(4326008)(6116002)(3846002)(66556008)(64756008)(36756003)(256004)(66446008)(66066001)(66946007)(7736002)(305945005)(66476007)(2906002)(86362001)(73956011)(71190400001)(71200400001)(91956017)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6671;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZNGI54MFTYZ7waBbMS7a1lwumeQtu9+xNC4ZfFoDhXgnoBOk16bz4+PIGqb5vcMoHZzUIuPBaumLhhlKQ3KXOrpIbnzFnhKphoVlVsXj0s3G9JM6b3X9bd0AnvegvDCOi1geQiFCJVCFN8YdffuTtNlBMVLvB7AFzmnNKhwlpLt/szV2wsLtl4SYvYd6qdz4NOTBsRxBSaY/TJItQXezeckwKWOEc27lNBURU3hPJBMrGuuFP8fHBR9dEYYbGlimd+5A4VT2p8f6HMGWx5miOHE0Es7kzuAV6iw4rhuoXhAkQqreOyDPn4Sqw0r7DyI18MrJKA9lEAIAiQcqqM80X/XxrsJUdxRjJc+lneyqM4K8DW6t7l+7CEtgG6hbqzp/93cwwV4qplA3T9kNdibeXbiiYnQR3tzyXXpgB59HNaQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6115E413E08DFC479D99A3D37A990FD0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c064ad8b-c6d1-407e-21ab-08d6f3b0e4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 05:50:39.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6671
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNi0xNyBhdCAwOToyNyAtMDQwMCwgU3ZlbiBWYW4gQXNicm9lY2sgd3JvdGU6DQo+
IEhlbGxvIFJvYmluLA0KPiANCj4gT24gU3VuLCBKdW4gMTYsIDIwMTkgYXQgMTA6MDIgUE0gUm9i
aW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBU
aGUgZGVmYXVsdCBpbXggZGVmY29uZmlnIGFuZCBkdHMgc2hvdWxkIGJlIG9rLCBiZWNhdXNlIGZp
cm13YXJlDQo+ID4gbG9hZA0KPiA+IGlzIGRlbGF5ZWQgYWZ0ZXIgcm9vdGZzIG1vdW50ZWQgd2hl
cmUgZmlybXdhcmUgbG9jYXRlZCBpbiBhbmQNCj4gPiBiZWZvcmUNCj4gPiB0aGF0LCBzb21lIGRy
aXZlciB3aGljaCB1c2Ugc2RtYSBzdWNoIGFzIHNwaS91YXJ0L2F1ZGlvIG1heSBoYXZlDQo+ID4g
YWxyZWFkeSBlbmFibGUgc2RtYSBjbG9jayB3aGljaCBtZWFucyBjaGFubmVsMCBpbnRlcnJ1cHQg
Y291bGQgYmUNCj4gPiBjbGVhcmVkIGltbWVkaWF0ZWx5IHdpdGhvdXQgaW50ZXJydXB0IHN0b3Jt
LiBUaGF0J3Mgd2h5IEkgY2FuJ3QNCj4gPiByZXByb2R1Y2UgeW91ciBpc3N1ZSBhdCBmaXJzdCwg
YnV0IGNhdGNoIGl0IG9uY2UgSSBzeW5jIHdpdGggeW91cg0KPiA+IGRpcmVjdGx5IGZpcm13YXJl
IGxvYWQgZGVmY29uZmlnLiBTbyBzZWVtcyBub3QgdmVyeSBtdXN0IHRvIENDDQo+ID4gc3RhYmxl
DQo+ID4gdHJlZT8NCj4gQXMgZmFyIGFzIEkga25vdywgdGhlIGJ1Zy9jcmFzaCBkb2VzIG5vdCBo
YXBwZW4gaWYgeW91J3JlIGxvYWRpbmcgdGhlDQo+IHNkbWEgZmlybXdhcmUgZnJvbSBhIGZpbGVz
eXN0ZW0uIFNvIHRoZSB2YXN0IG1ham9yaXR5IG9mIHVzZXJzIHdvdWxkDQo+IG5ldmVyIHNlZSB0
aGUgY3Jhc2guDQo+IA0KPiBJIGFncmVlIHRoYXQgdGhpcyBpcyBub3QgYSBoaWdoLXByaW9yaXR5
IGJ1Z2ZpeC4gQnV0IGl0J3Mgd29ydGh3aGlsZQ0KPiBmb3IgdGhlDQo+IHN0YWJsZSB0cmVlcyB0
byBoYXZlIGl0Lg0KPiANCj4gPiANCj4gPiBZZXMsIGJ1dCBNaWNoYWVsJ3MgcGF0Y2ggaXMgdGhl
IHJpZ2h0IGRpcmVjdGlvbiwgYXQgbGVhc3QgaXQgZml4IFJUDQo+ID4gY2FzZSBhbmQgbWVhbmlu
Z2xlc3MgY2hhbm5lbDAgaW50ZXJydXB0IHN0b3JtIGNvbWluZyBiZWZvcmUNCj4gPiBjbGVhcmlu
Zw0KPiA+IGNoYW5uZWwwIGludGVycnVwdCBzdGF0dXMgaW4gc2RtYV9ydW5fY2hhbm5lbDAoKS4g
Tm93LCB0aGlzIHBhdGNoDQo+ID4gY291bGQNCj4gPiBmaXggaXRzIG1pbm9yIHNpZGUtZWZmZWN0
Lg0KPiBJJ20gbm90IHN1Z2dlc3RpbmcgdGhhdCB3ZSBzaG91bGQgcmV2ZXJ0IG9yIGNoYW5nZSBN
aWNoYWVsJ3MgcGF0Y2guDQo+IEp1c3QNCj4gdGhhdCBpdCB3b3VsZCBiZSBnb29kIGZvciB0aGUg
djIgcGF0Y2ggdG8gY29udGFpbjoNCj4gDQo+IEZpeGVzOiAxZDA2OWJmYTNjNzggKCJkbWFlbmdp
bmU6IGlteC1zZG1hOiBhY2sgY2hhbm5lbCAwIElSUSBpbiB0aGUNCj4gaW50ZXJydXB0IGhhbmRs
ZXIiKQ0KPiANCj4gVGhpcyBzaG91bGQgYWxsb3cgc3RhYmxlIG1haW50YWluZXJzIHRvIHB1bGwg
aW4geW91ciBwYXRjaCBpZiBhbmQNCj4gb25seSBpZg0KPiB0aGVpciByZWxlYXNlIGFscmVhZHkg
Y29udGFpbnMgMWQwNjliZmEzYzc4Lg0KT2theSwgd291bGQgYWRkIEZpeGVzIHRhZyBpbnRvIHYy
Lg0K
