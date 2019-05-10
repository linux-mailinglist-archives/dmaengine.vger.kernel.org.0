Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7218019B2E
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfEJKOf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 06:14:35 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:48295
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727424AbfEJKOf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 06:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v5vFTsv76yKNg5iU1sz3pESLU+/PFlW8gwi43yR6ZI=;
 b=kFj3lEtIlmyz/BdJ5Sdc5N3wUI81frp9JZYeuz6SKBCzmwCbVrBjj6r4SePx5tMWOoUxNb51CJ4nlN1uTpDeL58tt0o1wFR0AZVPEiGe6Vpxl8fWYB6/02m2K22j43eAlPePyH+eQi5L3yfGhIMsqWok7dE3Y8z5fMeGkMRiCXA=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5661.eurprd04.prod.outlook.com (20.178.126.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 10:14:31 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:14:31 +0000
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
Subject: [PATCH v1 6/6] ARM: dts: imx7ulp: add edma device node
Thread-Topic: [PATCH v1 6/6] ARM: dts: imx7ulp: add edma device node
Thread-Index: AQHVBxkoZ1iKNPhzy0mgKg/A3CKtDw==
Date:   Fri, 10 May 2019 10:14:31 +0000
Message-ID: <1557512248-8440-7-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: ff0c8eb7-9641-4f33-61af-08d6d5304acf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5661;
x-ms-traffictypediagnostic: VI1PR04MB5661:
x-microsoft-antispam-prvs: <VI1PR04MB56619625BB53B333B9C091A9890C0@VI1PR04MB5661.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(4326008)(86362001)(66066001)(110136005)(316002)(14454004)(25786009)(256004)(6116002)(3846002)(71190400001)(7416002)(71200400001)(2201001)(7736002)(305945005)(2906002)(386003)(6506007)(5660300002)(6512007)(6486002)(50226002)(446003)(476003)(8936002)(478600001)(52116002)(186003)(4744005)(102836004)(76176011)(99286004)(54906003)(11346002)(68736007)(6436002)(26005)(486006)(2616005)(66556008)(66476007)(66446008)(66946007)(64756008)(53936002)(8676002)(81156014)(73956011)(81166006)(36756003)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5661;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0szcbJlghDInQHrW9foGqqJ1drf7xSjNAiB90OsoFebxdkLp8vGe1vRWpABtP7zrKIg/svHqi5iR+y5ByhnkPvGYkjQbxiiJu1zIOG9Df5LX5X8R5JYpF8QPrk7Mdr0OakWP5SdxUhPDTZ3aoE3HPSZD83ed8PbF2JDPZsFIUjWKZmjV/ptKCxAYH3Win3JNQVBjMmx/cPCd4ZFOlndlIlF45cOpkfHRKB6eEcv64SE8vLjh1Gy60+kk7C8u1FP2KKFZa3AYtJOF/NMRMJTfQTnKIoguxYZqJZ5Q4ljGhULikDxfMmYnnrgQuZvscyKccP24X/CAzL11gQ98pfx0X5Hi/AIzhCRA3lNXWbt0gRtwPWNVwbJ43GFK6tvNMpBPTZ5GF0caPvlP4Hh8yYg6i/sYZ99Dkel7AzACeFwpTBk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0c8eb7-9641-4f33-61af-08d6d5304acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:14:31.1796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5661
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QWRkIGVkbWEgZGV2aWNlIG5vZGUgaW4gZHRzLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25n
IDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0
c2kgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDI4
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAu
ZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaQ0KaW5kZXggZDZiNzExMC4uYjRm
N2FkZiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaQ0KKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNpDQpAQCAtMTAwLDYgKzEwMCwzNCBAQA0KIAkJ
cmVnID0gPDB4NDAwMDAwMDAgMHg4MDAwMDA+Ow0KIAkJcmFuZ2VzOw0KIA0KKwkJZWRtYTE6IGRt
YS1jb250cm9sbGVyQDQwMDgwMDAwIHsNCisJCQkjZG1hLWNlbGxzID0gPDI+Ow0KKwkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDd1bHAtZWRtYSI7DQorCQkJcmVnID0gPDB4NDAwODAwMDAgMHgyMDAw
PiwNCisJCQkJPDB4NDAyMTAwMDAgMHgxMDAwPjsNCisJCQlkbWEtY2hhbm5lbHMgPSA8MzI+Ow0K
KwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkg
ICAgIDxHSUNfU1BJIDEgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQorCQkJCSAgICAgPEdJQ19TUEkg
MiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCQkJICAgICA8R0lDX1NQSSAzIElSUV9UWVBFX0xF
VkVMX0hJR0g+LA0KKwkJCQkgICAgIDxHSUNfU1BJIDQgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQor
CQkJCSAgICAgPEdJQ19TUEkgNSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCQkJICAgICA8R0lD
X1NQSSA2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkgICAgIDxHSUNfU1BJIDcgSVJRX1RZ
UEVfTEVWRUxfSElHSD4sDQorCQkJCSAgICAgPEdJQ19TUEkgOCBJUlFfVFlQRV9MRVZFTF9ISUdI
PiwNCisJCQkJICAgICA8R0lDX1NQSSA5IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkgICAg
IDxHSUNfU1BJIDEwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkgICAgIDxHSUNfU1BJIDEx
IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkgICAgIDxHSUNfU1BJIDEyIElSUV9UWVBFX0xF
VkVMX0hJR0g+LA0KKwkJCQkgICAgIDxHSUNfU1BJIDEzIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
KwkJCQkgICAgIDxHSUNfU1BJIDE0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkgICAgIDxH
SUNfU1BJIDE1IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkgICAgIDxHSUNfU1BJIDE2IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCWNsb2NrLW5hbWVzID0gImRtYSIsICJkbWFtdXgwIjsN
CisJCQljbG9ja3MgPSA8JnBjYzIgSU1YN1VMUF9DTEtfRE1BMT4sDQorCQkJCSA8JnBjYzIgSU1Y
N1VMUF9DTEtfRE1BX01VWDE+Ow0KKwkJfTsNCisNCiAJCWxwdWFydDQ6IHNlcmlhbEA0MDJkMDAw
MCB7DQogCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC1scHVhcnQiOw0KIAkJCXJlZyA9IDww
eDQwMmQwMDAwIDB4MTAwMD47DQotLSANCjIuNy40DQoNCg==
