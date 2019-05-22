Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4658D26123
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfEVKBc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:01:32 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:13764
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728852AbfEVKBa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoY2my2cxZrdmgh7yx7DhKszJb02zyXz9XuhYE5MPU0=;
 b=ftZ4B9r0L+neZmT7aI8HMdVXcha3h8ONV613ndUNsp0aPGhIQirvgKPT7Qso/cl14hlCGNe3J34cJ3Tk0GQT6sVKldlj6Z4F0S0u5oeRWQVdiposEYrW9k091PXw2jYbX83VuwaYZ/22tK9Lxu88A44oQO+xHkbFggqJtufUtc8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:01:03 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:01:03 +0000
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
Subject: [PATCH v4 14/14] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Thread-Topic: [PATCH v4 14/14] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Thread-Index: AQHVEIVEOHCp3qYurEufxlsdSFFt/w==
Date:   Wed, 22 May 2019 10:01:03 +0000
Message-ID: <1558548188-1155-15-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: c0d43ad0-1bb2-4918-98f1-08d6de9c6638
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-microsoft-antispam-prvs: <VI1PR04MB31497DFF1ED3CA4BDCABB08D89000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(4744005)(71200400001)(36756003)(6512007)(99286004)(7416002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(66556008)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fN+8mbVaioLkJvmGgy3/Q0QJ1iqAjGSWEJwZ6hkvMQJSQyPyp2j6jBJgNnN+cULqEAAHrESKbiXpc9P4rS9U8N/fbiSrO2aGvVEHJ3qEa6bUN0BQmVbnKMJ5n/OWc0X1UAOliUv6cuALP3brMM3rmxBVe+9WZFrEyxj603oSZzwgvXHu2btcysExL0PUsyY17WtH2tn+9OJGMlGMz2w8eXZRALmpZUqINZXNTSvAiYPypdNOql3WhZzWtdMmJIYPjgpYmJ4+BNbHnUVc+5wPkGGDCNTOpPQPAqWHXjfaqgA8vfAC4soQuTqK9plDAnjeEFS7JkD2fhQ4tiXUHVzSrk4eiu7ItWlvF02si2Y00aY+CTivvHnxpd0NJsEPSWRimG3M7OUOnpWPVnKqu3Nm5lov360CJafrUm+xBsxcuPA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d43ad0-1bb2-4918-98f1-08d6de9c6638
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:01:03.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RW5hYmxlIFNETUEgc3VwcG9ydCBvbiBpLm14OG1xLzhtbSBjaGlwcywgaW5jbHVkaW5nIGVuYWJs
aW5nDQpDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSL0NPTkZJR19GV19MT0FERVJfVVNFUl9I
RUxQRVJfRkFMTEJBQ0sNCmZvciBmaXJtd2FyZSBsb2FkZWQgYnkgdWRldi4NCg0KU2lnbmVkLW9m
Zi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZyB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvYXJt
NjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IGMxMmM1MDUuLjJmZmVhMzAgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnDQpAQCAtMTk4LDYgKzE5OCw4IEBAIENPTkZJR19QQ0lFX0hJU0lfU1RCPXkNCiBD
T05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIg0KIENPTkZJR19ERVZUTVBG
Uz15DQogQ09ORklHX0RFVlRNUEZTX01PVU5UPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVM
UEVSPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSX0ZBTExCQUNLPXkNCiBDT05GSUdf
SElTSUxJQ09OX0xQQz15DQogQ09ORklHX1NJTVBMRV9QTV9CVVM9eQ0KIENPTkZJR19NVEQ9eQ0K
QEAgLTYzMCw2ICs2MzIsNyBAQCBDT05GSUdfUlRDX0RSVl9JTVhfU0M9bQ0KIENPTkZJR19SVENf
RFJWX1hHRU5FPXkNCiBDT05GSUdfRE1BREVWSUNFUz15DQogQ09ORklHX0RNQV9CQ00yODM1PW0N
CitDT05GSUdfSU1YX1NETUE9eQ0KIENPTkZJR19LM19ETUE9eQ0KIENPTkZJR19NVl9YT1I9eQ0K
IENPTkZJR19NVl9YT1JfVjI9eQ0KLS0gDQoyLjcuNA0KDQo=
