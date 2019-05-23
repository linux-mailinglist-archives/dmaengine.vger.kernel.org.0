Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB99A27451
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2019 04:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfEWCSQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 22:18:16 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:1038
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfEWCSQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 22:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqaTJtux+lWdFM11IqGkLWvFA0WYDpmJrHnerLDRBDM=;
 b=b34BiZjoVGaBlPYGbxFxemSo51casMzvJCTilprkEdeJFES5LvENPZSFBD30/GNDStplaHqce2BJ5JVdHyhEd1oRFvMV7+gPAUohfD33nAUrLvDfNog26FE8AUesWoopv0Uzj/rj5zy9lnDCl515zMtFpyFcW6Aq1ESGGncXXcg=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5807.eurprd04.prod.outlook.com (20.178.204.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 23 May 2019 02:18:10 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 02:18:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE:Re: [PATCH v4 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: Re: [PATCH v4 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AdURDIuPRlx991CcRFGr8aoDaMhF+Q==
Date:   Thu, 23 May 2019 02:18:10 +0000
Message-ID: <VI1PR04MB45434A8AB7BC8B3DADBFCD5D89010@VI1PR04MB4543.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3b08190-7cb3-4b82-2466-08d6df24e6f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5807;
x-ms-traffictypediagnostic: VI1PR04MB5807:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB58070808651E8B5314FC837C89010@VI1PR04MB5807.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(13464003)(8936002)(99286004)(476003)(14454004)(110136005)(81166006)(33656002)(45080400002)(54906003)(478600001)(6116002)(966005)(71200400001)(71190400001)(3846002)(486006)(68736007)(64756008)(66556008)(66446008)(73956011)(66946007)(76116006)(66476007)(316002)(9686003)(55016002)(6306002)(6436002)(53936002)(2501003)(7696005)(6506007)(4326008)(7416002)(74316002)(102836004)(81156014)(26005)(2906002)(25786009)(14444005)(186003)(86362001)(256004)(5660300002)(52536014)(8676002)(305945005)(2201001)(66066001)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5807;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DO1Ogv0ky5Ioo2TomolfMJFyqfZHQ1D0MfgzNqmn9ZBQY9nntGB81m98nrEWqnYKDdACTsxgjfyvWbJMe6/uOs3jqIzVWVqVBuGv/xnpqsE6+60tbb1bZbOU8nyWWghypg9Dw5wpx8iQb8rgsB51Z7lZywDiP9rTzdx/7r92DhGwUkMtAX9G0r43vJihRbAs4JX7F1LkFtWevBZQR8v75qvw40nm7KYnW5CGRwPySECgtzj2MzgccB+5ZGBOvmbNjCguYnpUlP/xlLyTa3DZYQpDUw8CLtN9HxRGFJuCwtI8+2TYwAZeHWrTzyrpWLIVGffdJ7ju6XJybz/3dKKSFbU1DKxIW+7znx1YFOBOuQwJOwywHIoUZpvW7/hOh7qePIsIMqHuVpbGer5sizgR3e/KpjY1bJtll8B3bjMCy00=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b08190-7cb3-4b82-2466-08d6df24e6f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 02:18:10.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5807
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAxOeW5tDXmnIgyMuaXpSAxODoxMA0KPiBIaSBS
b2JpbiwNCj4gDQo+IEFtIE1pdHR3b2NoLCBkZW4gMjIuMDUuMjAxOSwgMDk6NTkgKzAwMDAgc2No
cmllYiBSb2JpbiBHb25nOg0KPiA+ICAgVGhlcmUgaXMgZWNzcGkgRVJSMDA5MTY1IG9uIGkubXg2
Lzcgc29jIGZhbWlseSwgd2hpY2ggY2F1c2UgRklGTw0KPiA+IHRyYW5zZmVyIHRvIGJlIHNlbmQg
dHdpY2UgaW4gRE1BIG1vZGUuIFBsZWFzZSBnZXQgbW9yZSBpbmZvcm1hdGlvbiBmcm9tOg0KPiA+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRnd3dy4NCj4gDQo+IEkgaGF2ZW4ndCB0ZXN0ZWQgdGhpcyBzbyBhc2tpbmcgdGhl
IG9idmlvdXMgcXVlc3Rpb246IHdoYXQgaGFwcGVucyB3aGVuIHRoaXMNCj4gc2VyaWVzIGlzIGFw
cGxpZWQgd2l0aG91dCB0aGUgUkFNIHNjcmlwdCBiZWluZyBwcmVzZW50IG9uIHRoZSBzeXN0ZW0/
IFdpbGwgaXQNCj4gcmVuZGVyIFNQSSB1bnVzYWJsZT8gSSBndWVzcyBzbyBzaW5jZSBpdCBjaGFu
Z2VzIHRoZSBmbG93IGJldHdlZW4gdGhlIFNQSSBjb3JlDQo+IGFuZCBETUEgY29udHJvbGxlci4g
Q2FuIHdlIHNvbWVob3cgZGV0ZWN0IHRoYXQgU0RNQSBpc24ndCB1c2luZyB0aGUgY29ycmVjdA0K
PiBSQU0gc2NyaXB0IGFuZCBmYWxsIGJhY2sgdG8gUElPIG1vZGUgaW4gdGhlIFNQSSBkcml2ZXIg
aW4gdGhhdCBjYXNlPw0KPiANCj4gQ3VycmVudGx5IHVzaW5nIHRoZSBSQU0gc2NyaXB0IGlzIG5v
dCBhbiBvcHRpb24gaW4gYSBsb3Qgb2YgdXNlLWNhc2VzLCBhcyBpdCBzdGlsbA0KPiBicmVha3Mg
c2VyaWFsIERNQSBzdXBwb3J0LiBUaGUgZml4IGZvciB0aGUgc2VyaWFsIGlzc3VlIHJlYWxseSBu
ZWVkcyB0byBiZQ0KPiByZW1vdmUgdGhlIGJyb2tlbiBzZXJpYWwgc2NyaXB0IGZyb20gdGhlIFJB
TSBmaXJtd2FyZSwgbm90IGNoYW5nZSB0aGUgc2VyaWFsDQo+IGRyaXZlciB0byBkZWFsIHdpdGgg
dGhlIGJyb2tlbiBiZWhhdmlvciBpbnRyb2R1Y2VkIGJ5IHRoZSBSQU0gc2NyaXB0Lg0KT2theSwg
SSdsbCB0cnkgdG8gbWVyZ2UgYW5vdGhlciBwYXRjaCB3aGljaCBmaXggVUFSVCBkcml2ZXIgZnVu
Y3Rpb24gYnJva2VuIGlzc3VlIHdpdGggcmFtIHNjcmlwdCBzbyB0aGF0IG5vIGFueSBicm9rZW4g
Zm9yIHRoaXMgcGF0Y2ggc2V0Lg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCg==
