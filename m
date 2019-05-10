Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BDB19B22
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 12:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfEJKOZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 06:14:25 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:33870
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727389AbfEJKOZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 06:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlfPyPNr3+DR3Xo2sUHvN2uFqauK0uZvHmAJaWkZC6g=;
 b=jKHS0SooHpvjBNAA2oBcpZoRTMymeKY+5EvqL30CMvIUT3AuAK+602+Tnxirhaq6j2oejz2OhxtgNc0UXwtfJ0us10ZRxbQoyG9vRRxg+aU5nCHlVtUs9m4kz3tTBpm8CGPgFv0j9inBqiMm40y5FX4ko4nWEYBI0x9BW2nEeDs=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5661.eurprd04.prod.outlook.com (20.178.126.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 10:14:17 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:14:17 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 3/6] dmaengine: fsl-edma-common: move dmamux register to
 another single function
Thread-Topic: [PATCH v1 3/6] dmaengine: fsl-edma-common: move dmamux register
 to another single function
Thread-Index: AQHVBxkgcaTW3qOI30G2s+s8jusgdA==
Date:   Fri, 10 May 2019 10:14:17 +0000
Message-ID: <1557512248-8440-4-git-send-email-yibin.gong@nxp.com>
References: <1557512248-8440-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1557512248-8440-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d54e8c5c-fb13-4490-5269-08d6d5304279
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5661;
x-ms-traffictypediagnostic: VI1PR04MB5661:
x-microsoft-antispam-prvs: <VI1PR04MB566178DF9D7CBB87E520BFC6890C0@VI1PR04MB5661.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(4326008)(86362001)(66066001)(110136005)(316002)(14454004)(25786009)(14444005)(256004)(6116002)(3846002)(71190400001)(7416002)(71200400001)(2201001)(7736002)(305945005)(2906002)(386003)(6506007)(5660300002)(6512007)(6486002)(50226002)(446003)(476003)(8936002)(478600001)(52116002)(186003)(102836004)(76176011)(99286004)(54906003)(11346002)(68736007)(6436002)(26005)(486006)(2616005)(66556008)(66476007)(66446008)(66946007)(64756008)(53936002)(8676002)(81156014)(73956011)(81166006)(36756003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5661;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mpbNZvwCSZlgoLIYTlDrO7JsnuyKYBCPfbwqislVb0EoEPXQ8tOFtgNnB0DlGmvG8LcNSp7HzjdtQZPIustcK8fOYi4Bnq8LrmvCDJSrzj3xRYOeYMSv+ki6QrGfeDmXeJ48l5PRTHubQyvO1FXP4x/IcG5YnLaOwq9CPe4rg+wSUReFvB7UNXSqGTWEz6GkOejfarezvT2i4sqm2lhoeqWEjnZXYVIhGtpvgUi3TbLB6qqpQGey67LLw2vbTGjrTQGR1eh81Vf4oFwrZ4KAV5Wldd6k89Fq9ytPdgJZdWILKbsYJgz0NJ+mudlx0SlqEzG5mZqbkqKLjMaFImtgLrAUGoaz6iUlxRcunh+RNDXDG4zUJGdSylN1oiXEm7gXHo/98deoAB1JmYhASDymgGuD7abS2bis7aSDvGhIwXg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54e8c5c-fb13-4490-5269-08d6d5304279
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:14:17.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5661
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

UHJlcGFyZSBmb3IgZWRtYXYyIG9uIGkubXg3dWxwIHdob3NlIGRtYW11eCByZWdpc3RlciBpcyAz
MmJpdC4gTm8gZnVuY3Rpb24NCmltcGFjdGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25n
IDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24u
YyB8IDE4ICsrKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZnNsLWVkbWEt
Y29tbW9uLmMgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYw0KaW5kZXggYzlhMTdmYy4u
YmIyNDI1MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLWNvbW1vbi5jDQorKysg
Yi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYw0KQEAgLTc3LDYgKzc3LDE5IEBAIHZvaWQg
ZnNsX2VkbWFfZGlzYWJsZV9yZXF1ZXN0KHN0cnVjdCBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbikN
CiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoZnNsX2VkbWFfZGlzYWJsZV9yZXF1ZXN0KTsNCiANCitz
dGF0aWMgdm9pZCBtdXhfY29uZmlndXJlOChzdHJ1Y3QgZnNsX2VkbWFfY2hhbiAqZnNsX2NoYW4s
IHZvaWQgX19pb21lbSAqYWRkciwNCisJCQkgICB1MzIgb2ZmLCB1MzIgc2xvdCwgYm9vbCBlbmFi
bGUpDQorew0KKwl1OCB2YWw4Ow0KKw0KKwlpZiAoZW5hYmxlKQ0KKwkJdmFsOCA9IEVETUFNVVhf
Q0hDRkdfRU5CTCB8IHNsb3Q7DQorCWVsc2UNCisJCXZhbDggPSBFRE1BTVVYX0NIQ0ZHX0RJUzsN
CisNCisJaW93cml0ZTgodmFsOCwgYWRkciArIG9mZik7DQorfQ0KKw0KIHZvaWQgZnNsX2VkbWFf
Y2hhbl9tdXgoc3RydWN0IGZzbF9lZG1hX2NoYW4gKmZzbF9jaGFuLA0KIAkJCXVuc2lnbmVkIGlu
dCBzbG90LCBib29sIGVuYWJsZSkNCiB7DQpAQCAtODksMTAgKzEwMiw3IEBAIHZvaWQgZnNsX2Vk
bWFfY2hhbl9tdXgoc3RydWN0IGZzbF9lZG1hX2NoYW4gKmZzbF9jaGFuLA0KIAltdXhhZGRyID0g
ZnNsX2NoYW4tPmVkbWEtPm11eGJhc2VbY2ggLyBjaGFuc19wZXJfbXV4XTsNCiAJc2xvdCA9IEVE
TUFNVVhfQ0hDRkdfU09VUkNFKHNsb3QpOw0KIA0KLQlpZiAoZW5hYmxlKQ0KLQkJaW93cml0ZTgo
RURNQU1VWF9DSENGR19FTkJMIHwgc2xvdCwgbXV4YWRkciArIGNoX29mZik7DQotCWVsc2UNCi0J
CWlvd3JpdGU4KEVETUFNVVhfQ0hDRkdfRElTLCBtdXhhZGRyICsgY2hfb2ZmKTsNCisJbXV4X2Nv
bmZpZ3VyZTgoZnNsX2NoYW4sIG11eGFkZHIsIGNoX29mZiwgc2xvdCwgZW5hYmxlKTsNCiB9DQog
RVhQT1JUX1NZTUJPTF9HUEwoZnNsX2VkbWFfY2hhbl9tdXgpOw0KIA0KLS0gDQoyLjcuNA0KDQo=
