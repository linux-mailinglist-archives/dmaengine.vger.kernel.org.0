Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5F1291C9
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfLWGMg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 01:12:36 -0500
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:10358
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfLWGMg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 01:12:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYSaUl8VC1z5fBwjkzyi006VM/xEPnBIwHP0d4/3iYfUHJKeBDSep0vqI2cGcmOqNBawqwK/FQamYRHKEf6hgOu9RbQk2SpgOFm6mLnhme5Y/KkDYj24wQp6VcrXDVhJa3wQuT4siem1E+z30jHZRll4oZjp/LBA2g/UPYYxRy7gxuAE5W6MbXKF1PeaXiacUVyyGhs1nEgIPATLbamiyVsHJFosdEgKswtqSA5+W5TA76jvY/bG5Akq58bVPnfVcOHgiRvj8aYKU9xvZ7axITWp0n68WH6KaVLv5i1CAF7Ig/ivI2O3T6KFTDIf6Mc0sIrgAD8zKJYfIsYTN8OcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mefm3d82/kdLpLir2oc/hAF26QbAMmVhQrbYoJTSBk=;
 b=mb+29tBUKcxl+Db2vCaTe6ylrY0wyx2eATUI5L1mEQeRhl75R+hmpapB0ZMj84d64I0NvyFJLpS/XP62T2TKTshWM2VqZyNmrCG3TROSXX+wmh9gy0+cSjsxKDUFA5md2EQd94xWOQTmD1pGgXVuNgc6FI6SbkRb5z+swQtYm5Zf7OHDXtkqHPC9QuV65AJjYvFIGCmGjrACUFXaXMfFeLLpUcQAO3wuiwijElfdarWLPYkIipFYcMmBgLyHj8gF4NN7Z0CmFeXghYNRixXQhZZuQxFwh0snTGhtKEmJ4FX0QwEitMTcgaB0Af7j1gLRjkLvzimyEURncRMCX1GQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mefm3d82/kdLpLir2oc/hAF26QbAMmVhQrbYoJTSBk=;
 b=V5Ui3vQnjokTNYgVEmtnFz7vOBVOpUxiZIByAxYyu1FyJldD2K3LkGp5ZzcioJ3e+psFVcjFuNLAL+yOkVCGdqM4jQKMvNAKVcpLSYlg5gAMaR0iqKlIH8zI1i2UftZwUu7SRgrUEv6owCvwNhBDS0BwTyGfj7d0Kfc8NvG9EdY=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB7152.eurprd04.prod.outlook.com (10.186.158.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Mon, 23 Dec 2019 06:12:32 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 06:12:32 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for
 QorIQ LS1028A platform
Thread-Topic: [EXT] Re: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for
 QorIQ LS1028A platform
Thread-Index: AQHVsJ2TZ/jVyH6lNkyvcDWZa1lfcae/dvcAgAAYxuCAAhhbAIABQiJg
Date:   Mon, 23 Dec 2019 06:12:32 +0000
Message-ID: <VI1PR04MB4431671A81F87AB20A0313E6ED2E0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20191212033714.4090-1-peng.ma@nxp.com>
 <20191218062636.GS2536@vkoul-mobl>
 <VI1PR04MB44311BE955B863C73DF4CD4CED530@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191219155458.GY2536@vkoul-mobl>
In-Reply-To: <20191219155458.GY2536@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66c26685-71e5-450f-0213-08d7876f18eb
x-ms-traffictypediagnostic: VI1PR04MB7152:|VI1PR04MB7152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB71527827608529BD68AE8D90ED2E0@VI1PR04MB7152.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(13464003)(199004)(189003)(186003)(64756008)(44832011)(71200400001)(8936002)(2906002)(52536014)(76116006)(26005)(7696005)(66446008)(86362001)(5660300002)(66476007)(66946007)(6506007)(66556008)(33656002)(316002)(9686003)(55016002)(478600001)(81166006)(6916009)(8676002)(81156014)(54906003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7152;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/pZPHoIAo1qaKJarAa6XA5TYPfTvyxq44ge1c++Et+b/VFJV9qJ5U6THDFvMJ2XJWVE63Lc29b5p9wGx6CmlZPSRhI93E56uDP7E3K35pCGeZDhi7GhButDxT1M95YbBwLiHJmir0w4aRWJBbVboZZrGgSzZelt77h2bA5CGv3hUDjIYMXZEnrHhHpXjs39q2Q8cbeX4k5WVK2A18mv5xMvplzV0dhQkKH7QJssowjz+uv5jghVsymesupz1NiQGEK7pSJqz0WtgGjeI/rRpbd45Ne0PYB/aALCNs4crHymtlOt3l8vHNFSSPC9FmuKGTzaoT+NMXZXEc3PXvyNxqTIQL/2UqD9R2mUuKfQU1lTQMDEYsce22fsLozjgFP+w34IEr4d143MNaUoiI0LzcyFoEMaHT+np3cmn+yaHqhMgrdsGN5H3M7g2osDt9ZBfdgl3OXc6UnN5vj4Tw6NIkgGLjW488zw+uMkDRZ0h6L7PIXnOJGJ1dwaAQl9VsTp
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c26685-71e5-450f-0213-08d7876f18eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 06:12:32.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suFb/ZoT7jamvtc+Tqk4MHxi4wCKL8wtAuqRNV7XW9m/GYezczLzPo2GOmDefAAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqMTLUwjE5yNUgMjM6NTUNCj5UbzogUGVuZyBNYSA8
cGVuZy5tYUBueHAuY29tPg0KPkNjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8NCj5MaSA8bGVveWFuZy5saUBueHAuY29t
PjsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBSb2JpbiBHb25nDQo+PHlpYmluLmdvbmdAbnhw
LmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+U3ViamVjdDogUmU6IFtFWFRdIFJlOiBbdjUgMS8zXSBkbWFl
bmdpbmU6IGZzbC1lZG1hOiBBZGQgZURNQSBzdXBwb3J0IGZvcg0KPlFvcklRIExTMTAyOEEgcGxh
dGZvcm0NCj4NCj5DYXV0aW9uOiBFWFQgRW1haWwNCj4NCj5PbiAxOC0xMi0xOSwgMDg6MDgsIFBl
bmcgTWEgd3JvdGU6DQo+ID5CdHcgcGxzIHNlbmQgYmluZGluZ3MgYXMgcGF0Y2gxIGFuZCBkcml2
ZXIgY2hhbmdlcyBhcyBwYXRjaDIuDQo+PiBbUGVuZyBNYV0gSSBkb24ndCB1bmRlcnN0YW5kIHRo
aXMgc2VudGVuY2UsIFBsZWFzZSBnaXZlIG1lIG1vcmUNCj5pbmZvcm1hdGlvbi4NCj4+IEFzIEkg
a25vdyBwYXRjaDEgaXMgZHJpdmVyIGNoYW5nZXMsIHBhdGNoMiBpcyBkdHMgY2hhbmdlcywgcGF0
Y2gzIGlzIGJpbmRpbmcNCj5jaGFuZ2VzLg0KPj4gWW91IGFjY2VwdGVkIHBhdGNoMSBhbmQgcGF0
Y2gzLCBJIGFtIHB1enpsZWQgZm9yIHBhdGNoMiBhbmQgeW91cg0KPmNvbW1lbnRzLg0KPg0KPlRo
ZSBvcmRlciBvZiBwYXRjaGVzIHNob3VsZCBhbHdheXMgYmUgZHQtYmluZGluZ3MgZmlyc3QsIGZv
bGxvd2VyZCBieSBkcml2ZXINCj5jaGFuZ2UgYW5kIHRoZSBkdHMgY2hhbmdlcyBhcyB0aGUgbGFz
dCBvbmUgaW4gdGhlIHNlcmllcy4NCj4NCltQZW5nIE1hXSBPS6OsR290IGl0Lg0KVGhhbmtzIHZl
cnkgbXVjaCENCg0KQmVzdCBSZWdhcmRzLA0KUGVuZw0KPi0tDQo+flZpbm9kDQo=
