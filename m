Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72B35535
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2019 04:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFECZF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 22:25:05 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:35814
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfFECZF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jun 2019 22:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP44AFfGfS/Dl7DZmYj2i+WklCHcuM18wzZpVSFDxYQ=;
 b=gVFi7n4ON71QxbkKwLDJXJj6om0v8CQRKGo/IYx+dtF/dCx5amCP68KOpKxLJlP3b57qE3v4ZFD7mRZHT+eJ81c2yzoBzkIWlDPGw0M+jdPEBtNRt7Gv6aUGYGRaauekXLkxB0ltwbfhKimUj5dWkKyrrkiCbNdDkNCvFtv2lf8=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6670.eurprd04.prod.outlook.com (20.179.235.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Wed, 5 Jun 2019 02:25:02 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a13e:6f61:e9e6:16d7]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a13e:6f61:e9e6:16d7%7]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 02:25:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 5/8] dmaengine: fsl-edma: add drvdata for vf610
Thread-Topic: [PATCH v3 5/8] dmaengine: fsl-edma: add drvdata for vf610
Thread-Index: AQHVFf3r7/Xb7jxz/ECdaeOw3gnZcaaLd3OAgAFveAA=
Date:   Wed, 5 Jun 2019 02:25:02 +0000
Message-ID: <1559730524.24019.11.camel@nxp.com>
References: <20190529090848.34350-1-yibin.gong@nxp.com>
         <20190529090848.34350-6-yibin.gong@nxp.com>
         <20190604123331.GE15118@vkoul-mobl>
In-Reply-To: <20190604123331.GE15118@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5eef4971-2cef-41bc-4b97-08d6e95d03e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6670;
x-ms-traffictypediagnostic: VE1PR04MB6670:
x-microsoft-antispam-prvs: <VE1PR04MB66707006ABC29C7E5D7F474F89160@VE1PR04MB6670.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(14454004)(6246003)(53546011)(6436002)(25786009)(5660300002)(54906003)(229853002)(53936002)(6506007)(86362001)(11346002)(186003)(7416002)(76176011)(76116006)(1730700003)(64756008)(66476007)(66556008)(66446008)(5640700003)(81156014)(81166006)(6512007)(4326008)(6486002)(91956017)(8676002)(316002)(71190400001)(50226002)(8936002)(71200400001)(66066001)(66946007)(446003)(73956011)(6916009)(486006)(2351001)(7736002)(305945005)(2501003)(36756003)(99286004)(68736007)(2906002)(26005)(4744005)(256004)(3846002)(103116003)(102836004)(476003)(6116002)(478600001)(2616005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6670;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: joe5DdmRg2PzTPEbrlGD/5ABWreANdEOZbZyYo60HQSZM2cAXEpSKBu4zFeGMcbU4xRjIc9WXfQI3I99QEEKFv9OU1HYjFxmemR/jtCrligbCxrHx6vkszxovrEcepjsXHtYROoLZVdXFO//+kA7V5URj3P32V6mO6+u6PNIlA6NuEoLrGys53zRpmqO8RmDGynKVvJ3iUQ3m++yFxA2TpRYOWWFOB+i/DFiCDi2K/O4KY92LkmEB0iPJH6m0ru6b1uNOFwZ7max7fwBwX7SXbPHqTJu4XYfgY2wjQmAmrtQPFHdmAm96xM7R4zSE02Wy7C7HSS7E7caLpKfQH2ete9i3SKrQLLriLyNryghiZ0BCLX/DpROm8ydCF7p3amvF30w8M8K2/G3hA6QTx2uIboznR1Jk5UNwS2U+EHMeoA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D5076106775FA4C8D1276EB52B6257E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eef4971-2cef-41bc-4b97-08d6e95d03e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 02:25:02.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6670
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24g5LqMLCAyMDE5LTA2LTA0IGF0IDE4OjAzICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAyOS0wNS0xOSwgMTc6MDgsIHlpYmluLmdvbmdAbnhwLmNvbSB3cm90ZToNCj4gDQo+ID4gDQo+
ID4gQEAgLTIwNSw4ICsyMjgsOSBAQCBzdGF0aWMgaW50IGZzbF9lZG1hX3Byb2JlKHN0cnVjdA0K
PiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiDCoAlpZiAoIWZzbF9lZG1hKQ0KPiA+IMKg
CQlyZXR1cm4gLUVOT01FTTsNCj4gPiDCoA0KPiA+IC0JZnNsX2VkbWEtPnZlcnNpb24gPSB2MTsN
Cj4gPiAtCWZzbF9lZG1hLT5kbWFtdXhfbnIgPSBETUFNVVhfTlI7DQo+ID4gKwlmc2xfZWRtYS0+
ZHJ2ZGF0YSA9IGRydmRhdGE7DQo+ID4gKwlmc2xfZWRtYS0+dmVyc2lvbiA9IGRydmRhdGEtPnZl
cnNpb247DQo+ID4gKwlmc2xfZWRtYS0+ZG1hbXV4X25yID0gZHJ2ZGF0YS0+ZG1hbXV4czsNCj4g
QW5kIGNhbiB3ZSBhdm9pZCB0aGUgZHVwbGljYXRpb24gaGVyZSwgeW91IGhhdmUgdmVyc2lvbiBh
bmQgZG1hbXV4cw0KPiByZXByZXNlbnRlZCBpbiB0d28gcGxhY2VzLiBCdXQgcmlnaHQgbm93IGl0
IGxvb2tzIGxvZ2ljYWwgc28gdGhlDQo+IHJlbW92YWwNCj4gc2hvdWxkIGJlIGRvbmUgYWZ0ZXIg
dGhpcyBzZXJpZXMNClRvIGF2b2lkIG1vcmUgY29kZSBjaGFuZ2VzIGluIG90aGVyIGVkbWEgZHJp
dmVyIHN1Y2ggYXMgbWNmLWVkbWEuYyBhbmQNCmZzbC1lZG1hLWNvbW1vbi5jKHJlcGxhY2UgYWxs
IHZlcnNpb24vZG1hbXV4X25yIHdpdGggbmV3DQonZHJ2ZGF0YScpLG1lYW53aGlsZSwgbm8gYm9h
cmQgdG8gdGVzdCBtY2YtZWRtYSBzbyBJIGtlZXANCid2ZXJzaW9uJy8nZG1hbXV4JyBoZXJlIGlu
IHRoZSBsYXN0IG1pbnV0ZS4gQnV0IGlmIHlvdSBzdGljaywgSSB3b3VsZA0KdHJ5IHRvIHJlZmlu
ZSBpdCBpbiBuZXh0IHZlcnNpb24uwqANCj4g
