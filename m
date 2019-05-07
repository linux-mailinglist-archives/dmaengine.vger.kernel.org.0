Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4066A16068
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEGJQb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:16:31 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:25157
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfEGJQa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB+e4U84dPs5AD7euKV+Ua/b5FgApuf8Zj6eJr9Ee0Q=;
 b=uhSAtYDmE71wyGcLuZCnVOU8LIXPPoyQ6rDhnGHlld9JVEHFaQjdobIGmty5NMMtJUMNvC0EIUBp2edGPrCDTjgaaY8cw9wxey+9MJv+DNqWYsefxmcH13joi5cdsjrYHUQwxiCYhBawO/5glH8u68iwpEPn1ecqomm5WLawPpM=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3184.eurprd04.prod.outlook.com (10.170.229.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 09:16:25 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:25 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v3 08/14] dt-bindings: spi: imx: add new i.mx6ul compatible
 name
Thread-Topic: [PATCH v3 08/14] dt-bindings: spi: imx: add new i.mx6ul
 compatible name
Thread-Index: AQHVBLWLUMm9qUJ7G0SuG6LWkrCzFw==
Date:   Tue, 7 May 2019 09:16:25 +0000
Message-ID: <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76e830fe-d330-402e-bc60-08d6d2ccadd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3184;
x-ms-traffictypediagnostic: VI1PR04MB3184:
x-microsoft-antispam-prvs: <VI1PR04MB31842011486331DE7E33A7A089310@VI1PR04MB3184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(478600001)(2906002)(7416002)(68736007)(81156014)(8676002)(4326008)(6116002)(81166006)(86362001)(2201001)(2501003)(476003)(256004)(446003)(11346002)(2616005)(6512007)(486006)(8936002)(3846002)(110136005)(6436002)(36756003)(5660300002)(66066001)(99286004)(54906003)(7736002)(66446008)(64756008)(66556008)(102836004)(66476007)(14454004)(25786009)(73956011)(71190400001)(71200400001)(66946007)(305945005)(386003)(6486002)(53936002)(50226002)(6506007)(76176011)(186003)(52116002)(26005)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3184;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6FVQGp+CZQyAECiWbedNvvg3k4F2g5S783raI6LyKXa43pR2931nbLLfjxqw74P1gRhEIRwsBccgQV9FHi+JuR3HT4dVfYeEoNED0jL70pJE+dx+zIivuF4kSdQy4TX6g3/veVOpMLGbkbpCXajpRioa0r9/s8bIWOrsWlLMnBYKBjxdytKDBNXX6FPkeGuQNXWIeEvBjirkbPFpCsiHCcrbRy4ngPfdO3lSgSeVFD7M6TX0AeflRjfOSg1BF+mFDIakn2gGDEUoDZAvtZNd4Q3Cjzi+kDRlIq1x7GC7xl6Iq1g5kNt8TySQdrasyEHEhr59nxwi79vr2N9eW9O41rg+BAsvSPWfCb3BA5CLeyPk6o65l6zqrWqrZFAiTR6wLAUa02odSSXH9U/T601n+hhMJQuriiB7myK+d/ooYMc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e830fe-d330-402e-bc60-08d6d2ccadd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:25.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3184
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgYWRkIGl0cyBjb21wYXRpYmxlIG5hbWUuDQoN
ClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCi0tLQ0KIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dCB8IDEg
Kw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0DQppbmRleCAy
ZDMyNjQxLi5iM2QwMmEzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCkBAIC0xMCw2ICsxMCw3IEBAIFJlcXVp
cmVkIHByb3BlcnRpZXM6DQogICAtICJmc2wsaW14MzUtY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxl
IHdpdGggdGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVgzNQ0KICAgLSAiZnNsLGlteDUxLWVjc3Bp
IiBmb3IgU1BJIGNvbXBhdGlibGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDUxDQog
ICAtICJmc2wsaW14NTMtZWNzcGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50
ZWdyYXRlZCBvbiBpLk1YNTMgYW5kIGxhdGVyIFNvYw0KKyAgLSAiZnNsLGlteDZ1bC1lY3NwaSIg
Zm9yIFNQSSBjb21wYXRpYmxlIHdpdGggdGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVg2VUwgYW5k
IGxhdGVyIFNvYw0KICAgLSAiZnNsLGlteDhtcS1lY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxlIHdp
dGggdGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVg4TQ0KIC0gcmVnIDogT2Zmc2V0IGFuZCBsZW5n
dGggb2YgdGhlIHJlZ2lzdGVyIHNldCBmb3IgdGhlIGRldmljZQ0KIC0gaW50ZXJydXB0cyA6IFNo
b3VsZCBjb250YWluIENTUEkvZUNTUEkgaW50ZXJydXB0DQotLSANCjIuNy40DQoNCg==
