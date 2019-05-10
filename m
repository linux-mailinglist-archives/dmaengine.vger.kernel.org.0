Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09319B1F
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfEJKOQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 06:14:16 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:63908
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727389AbfEJKOP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 06:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV5H3agBaistDtUEGiaYiRDiYipcCTZf8rCwhHmAFrM=;
 b=Z0uyff3u5jn6Ihjkwya+ukiAPXHk7anfzlkzwSUWpzTjZAyeZNMi0FMOusgR4KIP2AAXPCcNQetL1hkXytU5h7QzQAIbVfDUUfo1dZX9hSYn8ptnk9jXCrBaSb69dVRdcRZr90VeVXwo5lARykcfd+8Yx/gxXuI5vDs3FkiPcyM=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3007.eurprd04.prod.outlook.com (10.170.228.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 10 May 2019 10:14:12 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:14:12 +0000
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
Subject: [PATCH v1 2/6] dmaengine: mcf-edma: update to 'dmamux_nr'
Thread-Topic: [PATCH v1 2/6] dmaengine: mcf-edma: update to 'dmamux_nr'
Thread-Index: AQHVBxkdDB3d1BKeOU+Q7kmGptbRJA==
Date:   Fri, 10 May 2019 10:14:12 +0000
Message-ID: <1557512248-8440-3-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 61da59c3-33ea-4d91-a160-08d6d5303fc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3007;
x-ms-traffictypediagnostic: VI1PR04MB3007:
x-microsoft-antispam-prvs: <VI1PR04MB300794233EEE6CE5FDB680D9890C0@VI1PR04MB3007.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(189003)(14454004)(2201001)(110136005)(54906003)(478600001)(2501003)(8936002)(8676002)(81166006)(81156014)(50226002)(316002)(86362001)(66066001)(25786009)(7416002)(53936002)(4326008)(36756003)(7736002)(71200400001)(2616005)(71190400001)(446003)(11346002)(66946007)(14444005)(256004)(486006)(2906002)(186003)(26005)(102836004)(476003)(5660300002)(3846002)(6486002)(6116002)(15650500001)(76176011)(52116002)(6506007)(386003)(68736007)(305945005)(66476007)(66556008)(64756008)(66446008)(73956011)(99286004)(6436002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3007;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M1YtOFvQdX7Jx6r2nNHc40XOC97i+Cd/oQZtjoNn28CMYq6Qmi0CfeSBWv6vB016lkG845uafOEUeP5VxCr8ICfbxE2SoFxgKkvx631rDh7pqnZUYLkd2w3Ii9PgAIBXDzJpul6Ky9ZpQJ6n+VDyQumASBk5mbnxj/zSbJ+y0eHMzhwqliBSari8CnOPI9UakdcVV/0BP2Z9rYa337bceeFJ97el8kBq9SZDrWGjn+IFVWxpJGhx8gQIJt+g+1x62L8inevIDw/wiPeaj/4/zpOf6i0mtvF84aAPPB4ke4aPAxj3EhxDPPYUPQxzUH74MDx6t/uR+kFfj0IgZSI5G+PBlzGIApMhNQSLy0K4DluZ4m3qdLAdkNpQarQwTDuMfAOsZYeSlCjbNYg7M1JiCzkePf1krmJPeQ+ECe6v38g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61da59c3-33ea-4d91-a160-08d6d5303fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:14:12.8748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3007
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VXBkYXRlIHRvICdkbWFtdXhfbnInIGluc3RlYWQgb2Ygc3RhdGljIG1hY3JvIERNQU1VWF9OUiBz
aW5jZQ0KbmV3IHZlcnNpb24gZWRtYSBvbmx5IGhhcyBvbmUgZG1hbXV4Lg0KDQpTaWduZWQtb2Zm
LWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9m
c2wtZWRtYS1jb21tb24uYyB8IDIgKy0NCiBkcml2ZXJzL2RtYS9tY2YtZWRtYS5jICAgICAgICB8
IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYyBiL2RyaXZlcnMvZG1h
L2ZzbC1lZG1hLWNvbW1vbi5jDQppbmRleCA2ODBiMmEwLi5jOWExN2ZjIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmMNCisrKyBiL2RyaXZlcnMvZG1hL2ZzbC1lZG1h
LWNvbW1vbi5jDQpAQCAtODQsNyArODQsNyBAQCB2b2lkIGZzbF9lZG1hX2NoYW5fbXV4KHN0cnVj
dCBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbiwNCiAJdm9pZCBfX2lvbWVtICptdXhhZGRyOw0KIAl1
bnNpZ25lZCBpbnQgY2hhbnNfcGVyX211eCwgY2hfb2ZmOw0KIA0KLQljaGFuc19wZXJfbXV4ID0g
ZnNsX2NoYW4tPmVkbWEtPm5fY2hhbnMgLyBETUFNVVhfTlI7DQorCWNoYW5zX3Blcl9tdXggPSBm
c2xfY2hhbi0+ZWRtYS0+bl9jaGFucyAvIGZzbF9jaGFuLT5lZG1hLT5kbWFtdXhfbnI7DQogCWNo
X29mZiA9IGZzbF9jaGFuLT52Y2hhbi5jaGFuLmNoYW5faWQgJSBjaGFuc19wZXJfbXV4Ow0KIAlt
dXhhZGRyID0gZnNsX2NoYW4tPmVkbWEtPm11eGJhc2VbY2ggLyBjaGFuc19wZXJfbXV4XTsNCiAJ
c2xvdCA9IEVETUFNVVhfQ0hDRkdfU09VUkNFKHNsb3QpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZG1hL21jZi1lZG1hLmMgYi9kcml2ZXJzL2RtYS9tY2YtZWRtYS5jDQppbmRleCA3ZGU1NGIyZi4u
NDQ4NDE5MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL21jZi1lZG1hLmMNCisrKyBiL2RyaXZl
cnMvZG1hL21jZi1lZG1hLmMNCkBAIC0xODksNiArMTg5LDcgQEAgc3RhdGljIGludCBtY2ZfZWRt
YV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAkvKiBTZXQgdXAgdmVy
c2lvbiBmb3IgQ29sZEZpcmUgZWRtYSAqLw0KIAltY2ZfZWRtYS0+dmVyc2lvbiA9IHYyOw0KKwlt
Y2ZfZWRtYS0+ZG1hbXV4X25yID0gRE1BTVVYX05SOw0KIAltY2ZfZWRtYS0+YmlnX2VuZGlhbiA9
IDE7DQogDQogCWlmICghbWNmX2VkbWEtPm5fY2hhbnMpIHsNCi0tIA0KMi43LjQNCg0K
