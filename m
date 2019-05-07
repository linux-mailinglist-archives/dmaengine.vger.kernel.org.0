Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DA316093
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGJRU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:17:20 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:57499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbfEGJRS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g0lTa6I7/GKE2J/Te7pvuU1GY/Y0Di8Xu7jjSBYGMU=;
 b=RqNlg4VNMA+1hb1dh9MERixqVtWvKHOl8oRwQe+3DLgD2WtOMUOAIP22o6VaRwEAc9d/j2NKAsfztWrDKH+iSltwotYE7tSbX/Hu43oixwfbhmhsdgQX4rJkGUXUfdtwN/sCPMTia1Kmfzlu3kgZHy1y8CX3yKZz+9HhtqGWTaw=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:17:03 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:17:03 +0000
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
Subject: [PATCH v3 14/14] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Thread-Topic: [PATCH v3 14/14] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Thread-Index: AQHVBLWi1hGP8ym7IE6DRAuYEaIkBg==
Date:   Tue, 7 May 2019 09:17:03 +0000
Message-ID: <1557249513-4903-15-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: e6a8b8a1-eddc-4f35-da05-08d6d2ccc45b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5005;
x-ms-traffictypediagnostic: VI1PR04MB5005:
x-microsoft-antispam-prvs: <VI1PR04MB5005D5C93EF6F9CAE88E72CC89310@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(386003)(6506007)(2501003)(36756003)(102836004)(6486002)(26005)(8676002)(4326008)(5660300002)(25786009)(68736007)(52116002)(76176011)(186003)(4744005)(2201001)(6512007)(53936002)(3846002)(71200400001)(66556008)(86362001)(66446008)(64756008)(476003)(66476007)(7416002)(305945005)(2906002)(11346002)(7736002)(66066001)(6116002)(99286004)(54906003)(256004)(14454004)(2616005)(73956011)(110136005)(6436002)(50226002)(8936002)(81156014)(81166006)(66946007)(316002)(71190400001)(486006)(478600001)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tgC5dr4tj9vKWcRwWLIwMwIHhBhqHT9KzRlyu62NFv1REU2dnQXHt+g7fhjtivOm6DIzfQ9QJ6v4ayt1x4BAUSeBJ4/U35gpk8u3HT72WRmAGx9R39dqYalAnttnbS35caEHYFdP+BmIfpYu8XfMrc1L78aNgXc5bx7li4+H9NYDRN14kQWMtWDMk+LThn/c1vBCAtyrvWGg+wWOf7Q7A8uiwRTkDK0y4+vmOUnl7bxGKkFDx8tQqaFR3gPnB+1sz1qdBmXToFaLlwpxLDyOtDmpj8TEs4KyBff6KghXNRoe7UKKaBmByRdRTNAcPuXzHc1sbCNPKLXG7oYrunsODLaadNbXdYOuYxx7sNOdQhOcm2EmQC2sp6K7AspoqhP/vMRCaxmgn1sVY7yme4j0z9tPnwpRCaAY5qRYVilUZyo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a8b8a1-eddc-4f35-da05-08d6d2ccc45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:17:03.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
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
NjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IDE3ZGFhOTcuLjcwODE4MTcgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnDQpAQCAtMjAzLDYgKzIwMyw4IEBAIENPTkZJR19ORVRfOVBfVklSVElPPXkNCiBD
T05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIg0KIENPTkZJR19ERVZUTVBG
Uz15DQogQ09ORklHX0RFVlRNUEZTX01PVU5UPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVM
UEVSPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSX0ZBTExCQUNLPXkNCiBDT05GSUdf
RE1BX0NNQT15DQogQ09ORklHX0NNQV9TSVpFX01CWVRFUz0zMg0KIENPTkZJR19ISVNJTElDT05f
TFBDPXkNCkBAIC02MzUsNiArNjM3LDcgQEAgQ09ORklHX1JUQ19EUlZfSU1YX1NDPW0NCiBDT05G
SUdfUlRDX0RSVl9YR0VORT15DQogQ09ORklHX0RNQURFVklDRVM9eQ0KIENPTkZJR19ETUFfQkNN
MjgzNT1tDQorQ09ORklHX0lNWF9TRE1BPXkNCiBDT05GSUdfSzNfRE1BPXkNCiBDT05GSUdfTVZf
WE9SX1YyPXkNCiBDT05GSUdfUEwzMzBfRE1BPXkNCi0tIA0KMi43LjQNCg0K
