Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3316047
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEGJPn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:15:43 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:64034
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfEGJPm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQai884lROnk2NZALqfyIkBTXCTaxANisRKzYvdUB6c=;
 b=FUzO3CLmQ6CEcDB3TgGdKlo47vjcqJ23hSBlJh6gA3jn3/yURyU1IcvEULUWTDsLx3N0QMyvgvEYvoPyGaIkKZc17ZBGXW+ZGPA3YLPZ30vTvquXVpNFBqDEF/IZ4/DcTUCmek3fA9rP+U7n207xy4+k9QFssZw6Yiklpga+syg=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3184.eurprd04.prod.outlook.com (10.170.229.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 09:15:35 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:15:35 +0000
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
Subject: [PATCH v3 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v3 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHVBLVtTlA9AoCGPEiNrQoWVi6lDw==
Date:   Tue, 7 May 2019 09:15:35 +0000
Message-ID: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 729d98a2-eaa1-44ee-0a14-08d6d2cc8fd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3184;
x-ms-traffictypediagnostic: VI1PR04MB3184:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB31840FE945AFF8D3D5C7A7A289310@VI1PR04MB3184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(478600001)(2906002)(7416002)(68736007)(966005)(81156014)(8676002)(4326008)(6116002)(81166006)(86362001)(2201001)(2501003)(476003)(256004)(14444005)(2616005)(6512007)(6306002)(486006)(8936002)(3846002)(110136005)(6436002)(36756003)(5660300002)(66066001)(99286004)(54906003)(7736002)(66446008)(64756008)(66556008)(102836004)(66476007)(14454004)(25786009)(73956011)(71190400001)(71200400001)(66946007)(305945005)(386003)(6486002)(53936002)(50226002)(6506007)(186003)(52116002)(26005)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3184;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oV+uDeEfV9XC5xOlactlipOsIwx1KuTNM31hdMh05QabQOnw8zUBKGtetR1FJpvAuWPATpXvcQcWjf4DpalyegDs4kCSEuwRp32Cv4k3OGEvl7R32lkPOENTO2F8qVguA8ggzeaVDUdzCex5L6Nv/G9Gc22HfgnPVr05+0YTnWE+IXLPVOI3vyX201UkiY8rlOL4obD62/cXCEthXGKQmenKXmgIweWSTm59caRF+iXy+HAnBj67ruHSeFMX/8ghy3KFy5EZBrToGwofHaE77EJrPrNf+z6armsgTRwosAwOQM+G+8+Ky8mIDOPrs12byAlhdXl5HjI0up/V2dU5sPymHNgVLiPql0R7ANeakwS3mi/r67tDYV0A7vxS35ydLDg5isPP9C62u/YQT/YxPkjO3wIV7Gf51s8gCNPhCnc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729d98a2-eaa1-44ee-0a14-08d6d2cc8fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:15:35.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3184
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ICBUaGVyZSBpcyBlY3NwaSBFUlIwMDkxNjUgb24gaS5teDYvNyBzb2MgZmFtaWx5LCB3aGljaCBj
YXVzZSBGSUZPDQp0cmFuc2ZlciB0byBiZSBzZW5kIHR3aWNlIGluIERNQSBtb2RlLiBQbGVhc2Ug
Z2V0IG1vcmUgaW5mb3JtYXRpb24gZnJvbToNCmh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9l
cnJhdGEvSU1YNkRRQ0UucGRmLiBUaGUgd29ya2Fyb3VuZCBpcyBhZGRpbmcNCm5ldyBzZG1hIHJh
bSBzY3JpcHQgd2hpY2ggd29ya3MgaW4gWENIICBtb2RlIGFzIFBJTyBpbnNpZGUgc2RtYSBpbnN0
ZWFkDQpvZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xEJyBzaG91bGQgYmUgMC4g
VGhlIGlzc3VlIHNob3VsZCBiZQ0KZXhpc3Qgb24gYWxsIGxlZ2FjeSBpLm14Ni83IHNvYyBmYW1p
bHkgYmVmb3JlIGkubXg2dWwuDQpOWFAgZml4IHRoaXMgZGVzaWduIGlzc3VlIGZyb20gaS5teDZ1
bCwgc28gbmV3ZXIgY2hpcHMgaW5jbHVkaW5nIGkubXg2dWwvDQo2dWxsLzZzbGwgZG8gbm90IG5l
ZWQgdGhpcyB3b3JrYXJvdWQgYW55bW9yZS4gQWxsIG90aGVyIGkubXg2LzcvOCBjaGlwcw0Kc3Rp
bGwgbmVlZCB0aGlzIHdvcmthcm91ZC4gVGhpcyBwYXRjaCBzZXQgYWRkIG5ldyAnZnNsLGlteDZ1
bC1lY3NwaScNCmZvciBlY3NwaSBkcml2ZXIgYW5kICdlY3NwaV9maXhlZCcgaW4gc2RtYSBkcml2
ZXIgdG8gY2hvb3NlIGlmIG5lZWQgZXJyYXRhDQpvciBub3QuDQogIFRoZSBmaXJzdCB0d28gcmV2
ZXJ0ZWQgcGF0Y2hlcyBzaG91bGQgYmUgdGhlIHNhbWUgaXNzdWUsIHRob3VnaCwgaXQNCnNlZW1z
ICdmaXhlZCcgYnkgY2hhbmdpbmcgdG8gb3RoZXIgc2hwIHNjcmlwdC4gSG9wZSBTZWFuIG9yIFNh
c2NoYSBjb3VsZA0KaGF2ZSB0aGUgY2hhbmNlIHRvIHRlc3QgdGhpcyBwYXRjaCBzZXQgaWYgY291
bGQgZml4IHRoZWlyIGlzc3Vlcy4NCiAgQmVzaWRlcywgZW5hYmxlIHNkbWEgc3VwcG9ydCBmb3Ig
aS5teDhtbS84bXEgYW5kIGZpeCBlY3NwaTEgbm90IHdvcmsNCm9uIGkubXg4bW0gYmVjYXVzZSB0
aGUgZXZlbnQgaWQgaXMgemVyby4NCg0KUFM6DQogIFBsZWFzZSBnZXQgc2RtYSBmaXJtd2FyZSBm
cm9tIGJlbG93IGxpbnV4LWZpcm13YXJlIGFuZCBjb3B5IGl0IHRvIHlvdXINCmxvY2FsIHJvb3Rm
cyAvbGliL2Zpcm13YXJlL2lteC9zZG1hLg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvZmlybXdhcmUvbGludXgtZmlybXdhcmUuZ2l0L3RyZWUvaW14L3Nk
bWENCg0KdjI6DQogIDEuIGFkZCBjb21taXQgbG9nIGZvciByZXZlcnRlZCBwYXRjaGVzLg0KICAy
LiBhZGQgY29tbWVudCBmb3IgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZlci4NCiAgMy4gYWRk
ICdmc2wsaW14NnNsbC1lY3NwaScgY29tcGF0aWJsZSBpbnN0ZWFkIG9mICdmc2wsaW14NnVsLWVj
c3BpJw0KICAgICByYXRoZXIgdGhhbiByZW1vdmUuDQp2MzoNCiAgMS4gY29uZmlybSB3aXRoIGRl
c2lnbiB0ZWFtIG1ha2Ugc3VyZSBFUlIwMDkxNjUgZml4ZWQgb24gaS5teDZ1bC9pLm14NnVsbA0K
ICAvaS5teDZzbGwsIG5vdCBmaXhlZCBvbiBpLm14OG0vOG1tIGFuZCBvdGhlciBpLm14Ni83IGxl
Z2FjeSBjaGlwcy4NCiAgQ29ycmVjdCBkdHMgcmVsYXRlZCBkdHMgcGF0Y2ggaW4gdjIuDQogIDIu
IGNsZWFuIGVyYXR0YSBpbmZvcm1hdGlvbiBpbiBiaW5kaW5nIGRvYyBhbmQgbmV3ICd0eF9nbGl0
Y2hfZml4ZWQnIGZsYWcNCiAgaW4gc3BpLWlteCBkcml2ZXIgdG8gc3RhdGUgRVJSMDA5MTY1IGZp
eGVkIG9yIG5vdC4NCiAgMy4gRW5sYXJnZSBidXJzdCBzaXplIHRvIGZpZm8gc2l6ZSBmb3IgdHgg
c2luY2UgdHhfd21sIHNldCB0byAwIGluIHRoZQ0KICBlcnJhdGEgd29ya2Fyb3VkLCB0aHVzIGlt
cHJvdmUgcGVyZm9ybWFuY2UgYXMgcG9zc2libGUuDQoNClJvYmluIEdvbmcgKDE0KToNCiAgUmV2
ZXJ0ICJBUk06IGR0czogaW14NnE6IFVzZSBjb3JyZWN0IFNETUEgc2NyaXB0IGZvciBTUEk1IGNv
cmUiDQogIFJldmVydCAiQVJNOiBkdHM6IGlteDY6IFVzZSBjb3JyZWN0IFNETUEgc2NyaXB0IGZv
ciBTUEkgY29yZXMiDQogIFJldmVydCAiZG1hZW5naW5lOiBpbXgtc2RtYTogcmVmaW5lIHRvIGxv
YWQgY29udGV4dCBvbmx5IG9uY2UiDQogIGRtYWVuZ2luZTogaW14LXNkbWE6IHJlbW92ZSBkdXBp
bGljYXRlZCBzZG1hX2xvYWRfY29udGV4dA0KICBkbWFlbmdpbmU6IGlteC1zZG1hOiBhZGQgbWN1
XzJfZWNzcGkgc2NyaXB0DQogIHNwaTogaW14OiBmaXggRVJSMDA5MTY1DQogIHNwaTogaW14OiBy
ZW1vdmUgRVJSMDA5MTY1IHdvcmthcm91bmQgb24gaS5teDZ1bA0KICBkdC1iaW5kaW5nczogc3Bp
OiBpbXg6IGFkZCBuZXcgaS5teDZ1bCBjb21wYXRpYmxlIG5hbWUNCiAgZG1hZW5naW5lOiBpbXgt
c2RtYTogcmVtb3ZlIEVSUjAwOTE2NSBvbiBpLm14NnVsDQogIGR0LWJpbmRpbmdzOiBkbWE6IGlt
eC1zZG1hOiBhZGQgaS5teDZ1bC82c3ggY29tcGF0aWJsZSBuYW1lDQogIGRtYWVuZ2luZTogaW14
LXNkbWE6IGZpeCBlY3NwaTEgcnggZG1hIG5vdCB3b3JrIG9uIGkubXg4bW0NCiAgQVJNOiBkdHM6
IGlteDZ1bDogYWRkIGRtYSBzdXBwb3J0IG9uIGVjc3BpDQogIEFSTTogZHRzOiBpbXg2c2xsOiBj
b3JyZWN0IHNkbWEgY29tcGF0aWJsZQ0KICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgU0RNQSBv
biBpLm14OG1xLzhtbQ0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2Rt
YS50eHQgICAgICAgfCAgMiArDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgt
Y3NwaS50eHQgICAgICAgfCAgMSArDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaSAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRz
aSAgICAgICAgICAgICAgICAgICAgIHwgIDggKy0tDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNs
bC5kdHNpICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZ1bC5kdHNpICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrDQogYXJjaC9hcm02NC9jb25m
aWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArDQogZHJpdmVycy9kbWEv
aW14LXNkbWEuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA3OCArKysrKysrKysrKysr
KysrLS0tLS0tDQogZHJpdmVycy9zcGkvc3BpLWlteC5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCA2MSArKysrKysrKysrKysrKy0tLQ0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0
YS9kbWEtaW14LXNkbWEuaCAgICAgICAgIHwgIDEgKw0KIDEwIGZpbGVzIGNoYW5nZWQsIDEzMiBp
bnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjcuNA0KDQo=
