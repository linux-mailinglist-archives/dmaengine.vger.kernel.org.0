Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF316050
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEGJP7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:15:59 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:2784
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfEGJP6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne8lUTHYIL86i2wNgDyCIKewW238BE0WWwtYB4rlmGc=;
 b=JXqy3cXiqu9demRVtXbF7foDWlf4FtG1oQFQqOHOAN4lj3XTYpu5vwQvTDW9fAH0eIVnxxjQ96XmNjWWol2kMewbd0qc9/Sl9twmw53viLrCKTghe9H/LEQC874j/E9BJ+QCxXMv9dOLZCFbJSn7AKhZ43/DdgvFHbEaq8t3hcc=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3184.eurprd04.prod.outlook.com (10.170.229.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 09:15:53 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:15:53 +0000
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
Subject: [PATCH v3 03/14] Revert "dmaengine: imx-sdma: refine to load context
 only once"
Thread-Topic: [PATCH v3 03/14] Revert "dmaengine: imx-sdma: refine to load
 context only once"
Thread-Index: AQHVBLV4PrqnG+2A2UC5DKEfCD6/JQ==
Date:   Tue, 7 May 2019 09:15:53 +0000
Message-ID: <1557249513-4903-4-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: fac4926f-5e8e-464d-310f-08d6d2cc9b0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3184;
x-ms-traffictypediagnostic: VI1PR04MB3184:
x-microsoft-antispam-prvs: <VI1PR04MB31842E7330C9B106258675C789310@VI1PR04MB3184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:119;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(478600001)(2906002)(7416002)(68736007)(81156014)(8676002)(4326008)(6116002)(81166006)(86362001)(2201001)(2501003)(476003)(256004)(446003)(11346002)(14444005)(2616005)(6512007)(486006)(8936002)(3846002)(110136005)(6436002)(36756003)(5660300002)(66066001)(99286004)(54906003)(7736002)(66446008)(64756008)(66556008)(102836004)(66476007)(14454004)(25786009)(73956011)(71190400001)(71200400001)(66946007)(305945005)(386003)(6486002)(53936002)(50226002)(6506007)(76176011)(186003)(52116002)(26005)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3184;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 50ZmTTmWJrPCciKxzS31qpBeLHzbeL3PLWLiuc61sFzxUlH9g+eHVaK2PKMNT+ZtA5kFHIqLsMiNH7GRttraeEAw21OrLNJzayenkR0Za6nhqpKYp0t2s4xTz1vHTUqU4QTNGMKD6D0aRKjx3iQR3vqdWmIrO1l4nAyw9eT43/roGarvvPrs2UUpXn/ipPr4ab/lD+4STG9q9kePoCt9Q6AKkERwfDPefVyVsD3t6490NVWWNMTNQlVLQgGj4TPX8qqxaklA3Td7ScUIvi+DhlqCorOaOe78fM2pfHB6pJYWlQ6SHLiofl8HbkXFORTEBmrjenzPqRDNYjgp1xi6SAggoSYLnEePuraBgm41vaYcbU5DuxgeLFXzjUqMjbKmaOPLNXZXczekJIkZ+yUQ9MLpKB4KCVNHcmriuGfg9cY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac4926f-5e8e-464d-310f-08d6d2cc9b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:15:53.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3184
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBhZDBkOTJkN2JhNmFlY2JlMjcwNTkwN2MzOGZmOGQ4YmU0ZGEx
ZTljLCBiZWNhdXNlDQppbiBzcGktaW14IGNhc2UsIGJ1cnN0IGxlbmd0aCBtYXkgYmUgY2hhbmdl
ZCBkeW5hbWljYWxseS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0Bu
eHAuY29tPg0KLS0tDQogZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDcgLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDk5ZDlmNDMuLjQwN2E1NmUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9p
bXgtc2RtYS5jDQpAQCAtMzc3LDcgKzM3Nyw2IEBAIHN0cnVjdCBzZG1hX2NoYW5uZWwgew0KIAl1
bnNpZ25lZCBsb25nCQkJd2F0ZXJtYXJrX2xldmVsOw0KIAl1MzIJCQkJc2hwX2FkZHIsIHBlcl9h
ZGRyOw0KIAllbnVtIGRtYV9zdGF0dXMJCQlzdGF0dXM7DQotCWJvb2wJCQkJY29udGV4dF9sb2Fk
ZWQ7DQogCXN0cnVjdCBpbXhfZG1hX2RhdGEJCWRhdGE7DQogCXN0cnVjdCB3b3JrX3N0cnVjdAkJ
dGVybWluYXRlX3dvcmtlcjsNCiB9Ow0KQEAgLTk4OCw5ICs5ODcsNiBAQCBzdGF0aWMgaW50IHNk
bWFfbG9hZF9jb250ZXh0KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KIAlpbnQgcmV0Ow0K
IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIA0KLQlpZiAoc2RtYWMtPmNvbnRleHRfbG9hZGVkKQ0K
LQkJcmV0dXJuIDA7DQotDQogCWlmIChzZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fTUVN
KQ0KIAkJbG9hZF9hZGRyZXNzID0gc2RtYWMtPnBjX2Zyb21fZGV2aWNlOw0KIAllbHNlIGlmIChz
ZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fREVWKQ0KQEAgLTEwMzMsOCArMTAyOSw2IEBA
IHN0YXRpYyBpbnQgc2RtYV9sb2FkX2NvbnRleHQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMp
DQogDQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNkbWEtPmNoYW5uZWxfMF9sb2NrLCBmbGFn
cyk7DQogDQotCXNkbWFjLT5jb250ZXh0X2xvYWRlZCA9IHRydWU7DQotDQogCXJldHVybiByZXQ7
DQogfQ0KIA0KQEAgLTEwNzQsNyArMTA2OCw2IEBAIHN0YXRpYyB2b2lkIHNkbWFfY2hhbm5lbF90
ZXJtaW5hdGVfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogCXNkbWFjLT5kZXNjID0g
TlVMTDsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2RtYWMtPnZjLmxvY2ssIGZsYWdzKTsN
CiAJdmNoYW5fZG1hX2Rlc2NfZnJlZV9saXN0KCZzZG1hYy0+dmMsICZoZWFkKTsNCi0Jc2RtYWMt
PmNvbnRleHRfbG9hZGVkID0gZmFsc2U7DQogfQ0KIA0KIHN0YXRpYyBpbnQgc2RtYV9kaXNhYmxl
X2NoYW5uZWxfYXN5bmMoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KLS0gDQoyLjcuNA0KDQo=
