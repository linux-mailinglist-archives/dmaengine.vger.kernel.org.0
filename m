Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC382AF62
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfE0HbI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 03:31:08 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:3523
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfE0HbI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 03:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79ZjyipAqebJuZXJXJz7EtcewtV9LhALiwRnr28aT5U=;
 b=KOFBijN4t3ebtlVA0HuyOLXWruv5+ska5nzSTGyEsm5RpCekX6r7LRqQsh8Hk5J0ygDpks0Wvr+Xzk5WppTpXvsiDGyjf5AcoQXzRH1Xlq2IbDqLZeTKz6tJd5iN6pFMbgq1KuMA5ZHqF8KQuRWcwlNaXdMo/FN46p78w0ErAd8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3246.eurprd04.prod.outlook.com (10.170.229.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.19; Mon, 27 May 2019 07:31:01 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 07:31:01 +0000
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
Subject: Re: [PATCH v1 4/6] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Topic: [PATCH v1 4/6] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Index: AQHVBxkiWq7ELKRpKk+QnDmvsVTzcqZ+nkiAgACW+IA=
Date:   Mon, 27 May 2019 07:31:01 +0000
Message-ID: <1558971291.19282.3.camel@nxp.com>
References: <1557512248-8440-1-git-send-email-yibin.gong@nxp.com>
         <1557512248-8440-5-git-send-email-yibin.gong@nxp.com>
         <20190527063431.GC15118@vkoul-mobl>
In-Reply-To: <20190527063431.GC15118@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09b42a95-d862-45b3-3036-08d6e27544e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3246;
x-ms-traffictypediagnostic: VI1PR04MB3246:
x-microsoft-antispam-prvs: <VI1PR04MB324607F1CDA7C6106DD4B93F891D0@VI1PR04MB3246.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(6246003)(2906002)(229853002)(5640700003)(81166006)(91956017)(8676002)(7416002)(81156014)(1730700003)(66066001)(53936002)(6116002)(3846002)(36756003)(486006)(14444005)(256004)(4326008)(25786009)(6436002)(6916009)(478600001)(6486002)(6512007)(14454004)(2616005)(476003)(11346002)(64756008)(186003)(54906003)(446003)(26005)(99286004)(68736007)(71190400001)(53546011)(71200400001)(6506007)(102836004)(86362001)(76176011)(305945005)(7736002)(76116006)(2351001)(4744005)(66556008)(103116003)(316002)(66446008)(66946007)(73956011)(66476007)(8936002)(2501003)(50226002)(5660300002)(99106002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3246;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sV2iTP617LRhCsZGbR4LQIRUFeEQ+78B+bWWXATWplo5BjX/5Pyj8ds0InC5msq0IKEHwDx7+jeyXUA/CAK211HzYvX0lmacIKcZ3SgKfkJYcRTr/F+wVRsMpdE9y7/AZv9W7IXP5EnK+wGWCcTqA3D8ct4x9PaesKr4iYdyW8kakrM1dNCFl3fGG+SA9I6zPvZ6/1bqkmPSXnVQzeZHCn6T+X/JMOfCs/jYGMVhtuitqucv62nB3Nixbwh2/pYFsnFdEMUOJRO3j7pU3iQpXGSkFDphOZX3BlS+wiuJPk/tv/4tCjWf4e9QKY44ha5Ln6Hpj75RreoiQY0WvGm6OqiLgPsSK7FMBq2gvgCBpOZz5Fpk6XAh2J5q1Mvwl0b8kgvuaHEF16fJcXbjkDczxu7NKbC4oMmxGkXgYd/uRV4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25F6E151E044984DB1AEB174A2075C0B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b42a95-d862-45b3-3036-08d6e27544e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 07:31:01.3618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3246
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNS0yNyBhdCAwNjozNCArMDAwMCwgVmlub2QgS291bCB3cm90ZToNCj4gT24gMTAt
MDUtMTksIDEwOjE0LCBSb2JpbiBHb25nIHdyb3RlOg0KPiA+IA0KPiA+IMKgDQo+ID4gKwlpZiAo
b2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsICJmc2wsaW14N3VscC1lZG1hIikpIHsNCj4gPiAr
CQlmc2xfZWRtYS0+ZG1hbXV4X25yID0gMTsNCj4gPiArCQlmc2xfZWRtYS0+dmVyc2lvbiA9IHYz
Ow0KPiB3ZWxsIHRoaXMgaXMgbm90IHJlYWxseSBzY2FsYWJsZSwgd2Ugd2lsbCBrZWVwIGFkZGlu
ZyB2ZXJzaW9ucyBhbmQNCj4gY29tcGF0aWJsZSBhbmQgZXhwYW5kaW5nIHRoaXMgY2hlY2suIFNv
IGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gY3JlYXRlDQo+IGENCj4gZHJpdmVyIGRhdGEgdGFibGUg
d2hpY2ggY2FuIGJlIHNldCBmb3IgY29tcGF0aWJsZSBhbmQgd2UgdXNlIHRob3NlDQo+IHZhbHVl
cyBhbmQgYXZvaWQgdGhlc2UgcnVudGltZSBjaGVja3MgZm9yIGNvbXBhdGlibGUuDQo+IA0KPiBC
dHcgdGhlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBzaG91bGQgcHJlY2VkZSB0aGUgY29kZSB1c2Fn
ZSwgc28gdGhpcw0KPiBwYXRjaCBzaG91bGQgY29tZSBhZnRlciB0aGF0DQo+IA0KT2theSwgd2ls
bCB1cGRhdGUgaW4gdjIu
