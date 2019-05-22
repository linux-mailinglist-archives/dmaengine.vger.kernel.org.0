Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11A2610D
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfEVKAb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:31 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:60334
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbfEVKAa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GYTio95S+FMY2hCE8ZwmP1JPMGedABgm7meO/VeRmY=;
 b=rByh3uFY2qvERS5tQHiApd7as02rASGnJ82kAouUOSu+O1+/RLWzQNVFHTA2QI9tfVu1HFhI17xRsR3+61F4AiaGkMIjVNqeqKrI5Yuc9QGoUS5QvI/oyRpCcS3p4+NY9Uayt3JNPQeZ3Jy9FvfX7eeyGzl2uhzRH1GBXFw64k4=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:26 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:26 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v4 08/14] spi: imx: add new i.mx6ul compatible name in binding
 doc
Thread-Topic: [PATCH v4 08/14] spi: imx: add new i.mx6ul compatible name in
 binding doc
Thread-Index: AQHVEIUtCpJ9uatjT0Gf8pzpUgHmVQ==
Date:   Wed, 22 May 2019 10:00:26 +0000
Message-ID: <1558548188-1155-9-git-send-email-yibin.gong@nxp.com>
References: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2a1d94f-142e-40fc-2b9e-08d6de9c5000
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-microsoft-antispam-prvs: <VI1PR04MB3149EFB9D6090B412D9725A589000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(71200400001)(36756003)(6512007)(99286004)(7416002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(66556008)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mOq04VkpW9VrAw5J1jSNpBbvP1x6M1zmkIJI+vf872QstPB6w44bgp58xgpn/Fpe3BY+IlHm5nv/eneLeRupU+vZJ35cVY/iOvEQrrMIFI0rn3kgcJrqgI60cEqbMZHWf/cXgN8lINyoZvWYRf/KVL6x6QJ2xzA5UDn/tSPk9xyGaPhHlIvaYhrGdhIu1zpKk3hj7AtkEJ5jc9P8w7YhA/1ngpL/fmXG3PFaiBLGLxcYKNyCfIa53gTlRhaHDCRVFLs526hfKBSv8lBogx4GiFzqM2BsOX52aeRXRowrenQybsEdlxFVqh4inP0ppO0fgJG+titeH90wn2X4stzVP5v44Ne0Yg8cqmL52xqDnJvwpRFIfmnFpJ7AJqEuzsJ2YqshL+XFyRcnjYIrG0WoI0Z35sfenCmjUSXh5XJHt9Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a1d94f-142e-40fc-2b9e-08d6de9c5000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:26.5992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgYWRkIGl0cyBjb21wYXRpYmxlIG5hbWUgaW4g
YmluZGluZw0KZG9jLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54
cC5jb20+DQpBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KLS0tDQog
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0IHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCmluZGV4
IDJkMzI2NDEuLmIzZDAyYTMgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dA0KQEAgLTEwLDYgKzEwLDcgQEAgUmVx
dWlyZWQgcHJvcGVydGllczoNCiAgIC0gImZzbCxpbXgzNS1jc3BpIiBmb3IgU1BJIGNvbXBhdGli
bGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDM1DQogICAtICJmc2wsaW14NTEtZWNz
cGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50ZWdyYXRlZCBvbiBpLk1YNTEN
CiAgIC0gImZzbCxpbXg1My1lY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxlIHdpdGggdGhlIG9uZSBp
bnRlZ3JhdGVkIG9uIGkuTVg1MyBhbmQgbGF0ZXIgU29jDQorICAtICJmc2wsaW14NnVsLWVjc3Bp
IiBmb3IgU1BJIGNvbXBhdGlibGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDZVTCBh
bmQgbGF0ZXIgU29jDQogICAtICJmc2wsaW14OG1xLWVjc3BpIiBmb3IgU1BJIGNvbXBhdGlibGUg
d2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDhNDQogLSByZWcgOiBPZmZzZXQgYW5kIGxl
bmd0aCBvZiB0aGUgcmVnaXN0ZXIgc2V0IGZvciB0aGUgZGV2aWNlDQogLSBpbnRlcnJ1cHRzIDog
U2hvdWxkIGNvbnRhaW4gQ1NQSS9lQ1NQSSBpbnRlcnJ1cHQNCi0tIA0KMi43LjQNCg0K
