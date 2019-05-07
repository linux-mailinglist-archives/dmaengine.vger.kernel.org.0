Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F71608F
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfEGJRQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:17:16 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:57499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726399AbfEGJRQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6sqrqxqwTiZ4tbyJIcnvRvAcZq7pQfaNREQf2oUNJU=;
 b=eyqNA4XX2nL0Jazcg8dm5nHU3TBxAmtyhwyRADC3l/SMjK9jpVgKPstRIWZjJJVztXmRz9pfGpmT8xpZjb5XUYFpAVw0MhN9AGQLfId63K/zvTYWI11QkoTTKNr+PbpW+uVq0zGHiC+TqHYrB4y1Ns4HpaqP38TKTYxZJg1wNgE=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:16:50 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:50 +0000
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
Subject: [PATCH v3 12/14] ARM: dts: imx6ul: add dma support on ecspi
Thread-Topic: [PATCH v3 12/14] ARM: dts: imx6ul: add dma support on ecspi
Thread-Index: AQHVBLWaB0GttY0kNkmwqcwEn85IqQ==
Date:   Tue, 7 May 2019 09:16:50 +0000
Message-ID: <1557249513-4903-13-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 632e6275-59c9-44d8-5709-08d6d2ccbcdc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5005;
x-ms-traffictypediagnostic: VI1PR04MB5005:
x-microsoft-antispam-prvs: <VI1PR04MB5005FC23BA179C49D4B39E4689310@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(386003)(6506007)(2501003)(36756003)(102836004)(6486002)(26005)(8676002)(4326008)(5660300002)(25786009)(68736007)(52116002)(76176011)(186003)(2201001)(6512007)(53936002)(3846002)(71200400001)(14444005)(66556008)(86362001)(66446008)(64756008)(476003)(66476007)(7416002)(305945005)(2906002)(11346002)(7736002)(66066001)(6116002)(99286004)(54906003)(256004)(14454004)(2616005)(73956011)(110136005)(6436002)(50226002)(8936002)(81156014)(81166006)(66946007)(316002)(71190400001)(486006)(478600001)(446003)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 87vuaMkH4nnMeWbxtiefOoCgbLQLIZDDPNZFdFTgI/U2wWs4XGEm35bucZvgua/H34/97PRJfn8CGtwzYedN1W8qYtOnD39OaZnrsO9XbHuFpjJvtrtNFxJV0ecCGAGKzkm7D8xL+F7wn9tGLwyuGs4TaX1PIKB9ieJ1tTUrZdhqTV9axYXMoY0fvjea3YLCJX5FuFX3QbLh8EI76cZnllc7xxvZFJSk+vulTKH2wTD/XLVwzLziYvp2947KEs9hKIa/0FYQJehduCaeCc30WELtTiYsch0NTwelQMNsP+Vf5uGPLWPdo3J9WHpK4UE6uDSTJX9KgO+gxYXfP6f61MZZzmPfsn4POUDMMhKsoYNbIHjzy1f6SIBh0iDDedirnfEKRIiZl25v/E3yNhQJcm2Mc9BYD+bDOM9XDy106N8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632e6275-59c9-44d8-5709-08d6d2ccbcdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:50.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QWRkIGRtYSBzdXBwb3J0IG9uIGVjc3BpLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5
aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSB8
IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZ1bC5kdHNpDQppbmRleCBiYmYwMTBjLi44ODBiOWVlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsLmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5kdHNp
DQpAQCAtMjI2LDYgKzIyNiw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlVMX0NMS19F
Q1NQSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTE+Ow0KIAkJCQkJY2xvY2st
bmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwgPCZzZG1h
IDQgNyAyPjsNCisJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIAkJCQl9Ow0KIA0KQEAgLTIzOCw2ICsyNDAsOCBAQA0KIAkJCQkJY2xvY2tz
ID0gPCZjbGtzIElNWDZVTF9DTEtfRUNTUEkyPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtf
RUNTUEkyPjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KKwkJCQkJZG1hcyA9
IDwmc2RtYSA1IDcgMT4sIDwmc2RtYSA2IDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAi
dHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCkBAIC0yNTAsNiAr
MjU0LDggQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz4sDQogCQkJ
CQkJIDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGci
LCAicGVyIjsNCisJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8JnNkbWEgOCA3IDI+Ow0KKwkJ
CQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQog
CQkJCX07DQogDQpAQCAtMjYyLDYgKzI2OCw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1Y
NlVMX0NMS19FQ1NQSTQ+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTQ+Ow0KIAkJ
CQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDkgNyAx
PiwgPCZzZG1hIDEwIDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KIAkJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCi0tIA0KMi43LjQNCg0K
