Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133A319B2B
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 12:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfEJKOb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 06:14:31 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:33870
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbfEJKOb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 06:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDuStmeBEbYuneEVk9w3Huevi8CiqxMmX/TigSqkEHA=;
 b=KpK1WDp96afimbQ2PLcFdyaaR784cXXugfEL7qFJRIIw2RbM/Yhj3jaB2a84BZstMtbS2VHOmFyupdkfXd8XvbAq1v87pRQqZ75Eom5i6LZZoHmaRLaYUri9HDm0C4NBN2W0Ywp+1lMJao8y8RHU8MjdZV8Z1tp8dNB/o/zYRzM=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5661.eurprd04.prod.outlook.com (20.178.126.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 10:14:26 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:14:26 +0000
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
Subject: [PATCH v1 5/6] dt-bindings: dma: fsl-edma: add new i.mx7ulp-edma
Thread-Topic: [PATCH v1 5/6] dt-bindings: dma: fsl-edma: add new i.mx7ulp-edma
Thread-Index: AQHVBxklOigPkWz8BkCq4tLPeU1/6g==
Date:   Fri, 10 May 2019 10:14:26 +0000
Message-ID: <1557512248-8440-6-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 7a586247-4554-473e-3b5e-08d6d53047e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5661;
x-ms-traffictypediagnostic: VI1PR04MB5661:
x-microsoft-antispam-prvs: <VI1PR04MB5661864D271308E68E38CD33890C0@VI1PR04MB5661.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(4326008)(86362001)(66066001)(110136005)(316002)(14454004)(25786009)(14444005)(256004)(6116002)(3846002)(71190400001)(7416002)(71200400001)(2201001)(7736002)(305945005)(2906002)(386003)(6506007)(5660300002)(6512007)(6486002)(50226002)(446003)(476003)(8936002)(478600001)(52116002)(186003)(102836004)(76176011)(99286004)(54906003)(11346002)(68736007)(6436002)(26005)(486006)(2616005)(66556008)(66476007)(66446008)(66946007)(64756008)(53936002)(8676002)(81156014)(73956011)(81166006)(36756003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5661;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QnZLFPlM1+/P3WHdnzYXVrgSICvZWVJ8DjFsGxHoK3Z/wmiDUjDXHkylXv0bGhPnweARfqgtpwOzoIMMUMPEtaxpwvdYCJ66SXECFfG5aQe9sp6NmmtnRzo2GZBUoGap22yDylTfft0cFEgYwoRebavBO2/w18uHguZ2JKOp1f/pERlZz9mTcu/xD8L2aKH64YsTZkiXNyT/uDGr2EoqxyW8YpoIxtbyiy+JuOKrOfyCjavTH5FNHnUQnn0a6nN5ne4tbiFNlg4QO1RY6ehDYRiyyow62QgbX790so4ReIU3q88v8EbN3+tYdJROZ9untCzrRZrnrb9Ow5tkyw3HDCzbkTeMQ+6wrKOvN3nLB4egakryp/dRb02uz5C1h8Ddo60UVnlhg5YjtdE8JlIpxRRU3r3PzoOOqXTtWtFO4l4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a586247-4554-473e-3b5e-08d6d53047e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:14:26.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5661
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

TW9yZSBjaGFubmVsIGludGVycnVwdHMsIG9uZSBtb3JlIGNsb2NrLCBhbmQgb25seSBvbmUNCmRt
YW11eCBvbiBpLm14N3VscC1lZG1hLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJp
bi5nb25nQG54cC5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL2ZzbC1lZG1hLnR4dCB8IDQ0ICsrKysrKysrKysrKysrKysrKystLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWVkbWEudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtZWRtYS50eHQNCmluZGV4IDk3ZTIx
M2UuLjI5ZGQzY2MgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZG1hL2ZzbC1lZG1hLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2RtYS9mc2wtZWRtYS50eHQNCkBAIC05LDE1ICs5LDE2IEBAIGdyb3VwLCBETUFNVVgwIG9y
IERNQU1VWDEsIGJ1dCBub3QgYm90aC4NCiBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIC0gY29tcGF0
aWJsZSA6DQogCS0gImZzbCx2ZjYxMC1lZG1hIiBmb3IgZURNQSB1c2VkIHNpbWlsYXIgdG8gdGhh
dCBvbiBWeWJyaWQgdmY2MTAgU29DDQorCS0gImZzbCxpbXg3dWxwLWVkbWEiIGZvciBlRE1BMiB1
c2VkIHNpbWlsYXIgdG8gdGhhdCBvbiBpLm14N3VscA0KIC0gcmVnIDogU3BlY2lmaWVzIGJhc2Ug
cGh5c2ljYWwgYWRkcmVzcyhzKSBhbmQgc2l6ZSBvZiB0aGUgZURNQSByZWdpc3RlcnMuDQogCVRo
ZSAxc3QgcmVnaW9uIGlzIGVETUEgY29udHJvbCByZWdpc3RlcidzIGFkZHJlc3MgYW5kIHNpemUu
DQogCVRoZSAybmQgYW5kIHRoZSAzcmQgcmVnaW9ucyBhcmUgcHJvZ3JhbW1hYmxlIGNoYW5uZWwg
bXVsdGlwbGV4aW5nDQogCWNvbnRyb2wgcmVnaXN0ZXIncyBhZGRyZXNzIGFuZCBzaXplLg0KIC0g
aW50ZXJydXB0cyA6IEEgbGlzdCBvZiBpbnRlcnJ1cHQtc3BlY2lmaWVycywgb25lIGZvciBlYWNo
IGVudHJ5IGluDQotCWludGVycnVwdC1uYW1lcy4NCi0tIGludGVycnVwdC1uYW1lcyA6IFNob3Vs
ZCBjb250YWluOg0KLQkiZWRtYS10eCIgLSB0aGUgdHJhbnNtaXNzaW9uIGludGVycnVwdA0KLQki
ZWRtYS1lcnIiIC0gdGhlIGVycm9yIGludGVycnVwdA0KKwlpbnRlcnJ1cHQtbmFtZXMgb24gdmY2
MTAgc2ltaWxhciBTb0MuIEJ1dCBmb3IgaS5teDd1bHAgcGVyIGNoYW5uZWwNCisJcGVyIHRyYW5z
bWlzc2lvbiBpbnRlcnJ1cHQsIHRvdGFsIDE2IGNoYW5uZWwgaW50ZXJydXB0IGFuZCAxDQorCWVy
cm9yIGludGVycnVwdChsb2NhdGVkIGluIHRoZSBsYXN0KSwgbm8gaW50ZXJydXB0LW5hbWVzIGxp
c3Qgb24NCisJaS5teDd1bHAgZm9yIGNsZWFuIG9uIGR0cy4NCiAtICNkbWEtY2VsbHMgOiBNdXN0
IGJlIDwyPi4NCiAJVGhlIDFzdCBjZWxsIHNwZWNpZmllcyB0aGUgRE1BTVVYKDAgZm9yIERNQU1V
WDAgYW5kIDEgZm9yIERNQU1VWDEpLg0KIAlTcGVjaWZpYyByZXF1ZXN0IHNvdXJjZSBjYW4gb25s
eSBiZSBtdWx0aXBsZXhlZCBieSBzcGVjaWZpYyBjaGFubmVscw0KQEAgLTI4LDYgKzI5LDcgQEAg
UmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNsb2NrLW5hbWVzIDogQSBsaXN0IG9mIGNoYW5uZWwg
Z3JvdXAgY2xvY2sgbmFtZXMuIFNob3VsZCBjb250YWluOg0KIAkiZG1hbXV4MCIgLSBjbG9jayBu
YW1lIG9mIG11eDAgZ3JvdXANCiAJImRtYW11eDEiIC0gY2xvY2sgbmFtZSBvZiBtdXgxIGdyb3Vw
DQorCU5vdGU6IE5vIGRtYW11eDAgb24gaS5teDd1bHAsIGJ1dCBhbm90aGVyICdkbWEnIGNsayBh
ZGRlZCBvbiBpLm14N3VscC4NCiAtIGNsb2NrcyA6IEEgbGlzdCBvZiBwaGFuZGxlIGFuZCBjbG9j
ay1zcGVjaWZpZXIgcGFpcnMsIG9uZSBmb3IgZWFjaCBlbnRyeSBpbg0KIAljbG9jay1uYW1lcy4N
CiANCkBAIC0zNSw2ICszNywxMCBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KIC0gYmlnLWVuZGlh
bjogSWYgcHJlc2VudCByZWdpc3RlcnMgYW5kIGhhcmR3YXJlIHNjYXR0ZXIvZ2F0aGVyIGRlc2Ny
aXB0b3JzDQogCW9mIHRoZSBlRE1BIGFyZSBpbXBsZW1lbnRlZCBpbiBiaWcgZW5kaWFuIG1vZGUs
IG90aGVyd2lzZSBpbiBsaXR0bGUNCiAJbW9kZS4NCistIGludGVycnVwdC1uYW1lcyA6IFNob3Vs
ZCBjb250YWluIHRoZSBiZWxvdyBvbiB2ZjYxMCBzaW1pbGFyIFNvQyBidXQgbm90IHVzZWQNCisJ
b24gaS5teDd1bHAgc2ltaWxhciBTb0M6DQorCSJlZG1hLXR4IiAtIHRoZSB0cmFuc21pc3Npb24g
aW50ZXJydXB0DQorCSJlZG1hLWVyciIgLSB0aGUgZXJyb3IgaW50ZXJydXB0DQogDQogDQogRXhh
bXBsZXM6DQpAQCAtNTIsOCArNTgsMzYgQEAgZWRtYTA6IGRtYS1jb250cm9sbGVyQDQwMDE4MDAw
IHsNCiAJY2xvY2stbmFtZXMgPSAiZG1hbXV4MCIsICJkbWFtdXgxIjsNCiAJY2xvY2tzID0gPCZj
bGtzIFZGNjEwX0NMS19ETUFNVVgwPiwNCiAJCTwmY2xrcyBWRjYxMF9DTEtfRE1BTVVYMT47DQot
fTsNCit9OyAvKiB2ZjYxMCAqLw0KIA0KK2VkbWExOiBkbWEtY29udHJvbGxlckA0MDA4MDAwMCB7
DQorCSNkbWEtY2VsbHMgPSA8Mj47DQorCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtZWRtYSI7
DQorCXJlZyA9IDwweDQwMDgwMDAwIDB4MjAwMD4sDQorCQk8MHg0MDIxMDAwMCAweDEwMDA+Ow0K
KwlkbWEtY2hhbm5lbHMgPSA8MzI+Ow0KKwlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPiwNCisJCSAgICAgPEdJQ19TUEkgMSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwN
CisJCSAgICAgPEdJQ19TUEkgMiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCSAgICAgPEdJQ19T
UEkgMyBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCSAgICAgPEdJQ19TUEkgNCBJUlFfVFlQRV9M
RVZFTF9ISUdIPiwNCisJCSAgICAgPEdJQ19TUEkgNSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJ
CSAgICAgPEdJQ19TUEkgNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCSAgICAgPEdJQ19TUEkg
NyBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCSAgICAgPEdJQ19TUEkgOCBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCisJCSAgICAgPEdJQ19TUEkgOSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCSAg
ICAgPEdJQ19TUEkgMTAgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQorCQkgICAgIDxHSUNfU1BJIDEx
IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJICAgICA8R0lDX1NQSSAxMiBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCisJCSAgICAgPEdJQ19TUEkgMTMgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQorCQkg
ICAgIDxHSUNfU1BJIDE0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJICAgICA8R0lDX1NQSSAx
NSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCisJCSAgICAgLyogbGFzdCBpcyBlRE1BMi1FUlIgaW50
ZXJydXB0ICovDQorCQkgICAgIDxHSUNfU1BJIDE2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwlj
bG9jay1uYW1lcyA9ICJkbWEiLCAiZG1hbXV4MCI7DQorCWNsb2NrcyA9IDwmcGNjMiBJTVg3VUxQ
X0NMS19ETUExPiwNCisJCSA8JnBjYzIgSU1YN1VMUF9DTEtfRE1BX01VWDE+Ow0KK307IC8qIGku
bXg3dWxwICovDQogDQogKiBETUEgY2xpZW50cw0KIERNQSBjbGllbnQgZHJpdmVycyB0aGF0IHVz
ZXMgdGhlIERNQSBmdW5jdGlvbiBtdXN0IHVzZSB0aGUgZm9ybWF0IGRlc2NyaWJlZA0KLS0gDQoy
LjcuNA0KDQo=
