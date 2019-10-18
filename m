Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569E6DC753
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2019 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634160AbfJRO2p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Oct 2019 10:28:45 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:19840
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408333AbfJRO2p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Oct 2019 10:28:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Icfug4Ml5o0lnqu9Rhfho1Rc8fstUQ0ixfjILil2JF3+8eHFPj6OIAruS9G1BqXOGfHK2Mhy9CzkJD2KcH9VsAoTqEPp6pN51PmRyIS8nStLTQioLwWo2J1gk6I/xSDsxvM4im0AgY+CxP40l7e+E0qnmJUT2dSQW9ctuOs6X4P0y4+Ctx7SnkGMQ9+mbSgZlpaj7SRsctsIp8eez5AEtK0CF9WcuyjmJrQhedlFpWnuP50CGIGEmZVL0Kd5MdjqloNaDHxOXkDYOnjpz7AJSQ1By/DBl81QGD6N7CX15TvEsqZBXqsgEURyDe19LL1+NbdJfQ11eAQvOdznjiGk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i4k4kBZU/qbjk6aj//PNB/pIGVzHW8cnbeNvUP2wuo=;
 b=IH8u/siBVsw2ksNI/iFg7SjmODlHLFPKdKsijrvq820XAFt24LINHY5m08fX+MVhHSv13WS7zSU2E0FI3WV6YDPOnAP4fT5jtB4BtGTgqMDiz03GArwXD42CbFg6EN0ci+z3OvCZt+wNOxbDQmfEeeP1wDKaBG0Z0ALU/t3U3vxTfJN8de3II8zKklnsvwUzFBVQlM/QT3KxRSZK1lyPhItYMF9E9IJBJGT9GcidyxAbJFdNokm0ipGbgnXGxrXhwIOngEBf9OhowooPcBRAECsTDgD4qTU//nJy+mrElXpXFZ3mWHruE2JofzNDEEE+N2B/gJwIA74KWEzATWlkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i4k4kBZU/qbjk6aj//PNB/pIGVzHW8cnbeNvUP2wuo=;
 b=R4BJVlTp5efu82mqLs68qlk9ybVAIMyxEh0uhR/3A8tQaz3dekutvLt0NHT/8vToFZ8hEbUeWI0hC3ZpLN1rctdz9Q3FgN2Hm3E7N+Y649NbGIX9n6+b8x+LHg1KMyqwLqeDcQL79s7DAPlf7IiHlizXbSyfUETw+M9QCqz+XM8=
Received: from DB7PR04MB4425.eurprd04.prod.outlook.com (52.135.140.156) by
 DB7PR04MB4266.eurprd04.prod.outlook.com (52.135.130.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 14:28:41 +0000
Received: from DB7PR04MB4425.eurprd04.prod.outlook.com
 ([fe80::c068:28ec:7f2f:4a5e]) by DB7PR04MB4425.eurprd04.prod.outlook.com
 ([fe80::c068:28ec:7f2f:4a5e%6]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 14:28:41 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        =?utf-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dmaengine: fsl-edma: Add eDMA support for QorIQ
 LS1028A platform
Thread-Topic: [EXT] Re: [PATCH] dmaengine: fsl-edma: Add eDMA support for
 QorIQ LS1028A platform
Thread-Index: AQHVhLtWQPtc6yR4Rkmk/ITG0gU0sqdgdkiAgAAAQmA=
Date:   Fri, 18 Oct 2019 14:28:41 +0000
Message-ID: <DB7PR04MB4425E937B423C39F0F45FCEDED6C0@DB7PR04MB4425.eurprd04.prod.outlook.com>
References: <20191017070923.6705-1-peng.ma@nxp.com>
 <CAOMZO5AK+wv0vAfqv7PC-gYF32MSD9nMqFCuRmLxMN6dYZdvGA@mail.gmail.com>
In-Reply-To: <CAOMZO5AK+wv0vAfqv7PC-gYF32MSD9nMqFCuRmLxMN6dYZdvGA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a6d791-7d9c-4ed2-a349-08d753d77990
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR04MB4266:|DB7PR04MB4266:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB42662B1A234E041B0C70D8A4ED6C0@DB7PR04MB4266.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(13464003)(189003)(199004)(478600001)(74316002)(486006)(305945005)(256004)(81166006)(7696005)(14454004)(76176011)(44832011)(102836004)(2906002)(11346002)(6916009)(99286004)(81156014)(8936002)(33656002)(7736002)(3846002)(6506007)(8676002)(71200400001)(476003)(71190400001)(186003)(6116002)(26005)(446003)(25786009)(76116006)(4326008)(5660300002)(66066001)(4744005)(66946007)(66446008)(64756008)(66556008)(1411001)(54906003)(86362001)(229853002)(6436002)(6246003)(52536014)(55016002)(316002)(9686003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4266;H:DB7PR04MB4425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iyhZ1nW9jWZ/KZfIzA3WpWWn04nVuEjBLQMkVVhkj1zGSBFyOviSaCkoH4PPNJph0JmjobpsAa9elBihuKB9gYu78TY2NhqA5//zhMBWF/fJJDeHyoG887z1md1tki4C0ZnxaQlcpa503YgAqQ5vBBMwgJgI/AWBLwP9XxyXbsyFTPdbf0HPaISfxEhA4uK41Oulh1Wo0QZ0lLYtDiwR4EslEFqi7R8yd/3xrHIbfxijP6EvByl617NE4Mf5vKYg+Q8urKUY35mG/WuJSdZWU4Ndrg89ppxSX3OWlROKiRTmYlueAVE+16pzZIGhRw5NeOtH3VBnAZhTO1S9PriOyPSA+7LGsAwgPT+GOrVQMmLkZ7pZVYinK+eaXo2aADYjj/BF64lN40Tkpr+bCZAK/G04IM5gb06G6Cdg3KAGYcY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a6d791-7d9c-4ed2-a349-08d753d77990
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 14:28:41.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0VQxzZp3iGuiwbP07PO+53Fb7U71OV3MlpS28ZqotFrNcSoHOSuCXpwcf4FiQpg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4266
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgRmFiaW8sDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCkRvIHlvdSBtZWFuIEkgZXhw
bGFpbiAiT3VyIHBsYXRmb3JtcyIgaGVyZSBvciBpbiBwYXRjaD8NCg0KQmVzdCBSZWdhcmRzLA0K
UGVuZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBGYWJpbyBFc3RldmFt
IDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+U2VudDogMjAxOeW5tDEw5pyIMTjml6UgMjI6MjUNCj5U
bzogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPkNjOiBWaW5vZCA8dmtvdWxAa2VybmVsLm9y
Zz47IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsgTGVvDQo+TGkgPGxl
b3lhbmcubGlAbnhwLmNvbT47IEtyenlzenRvZiBLb3rFgm93c2tpIDxrLmtvemxvd3NraS5rQGdt
YWlsLmNvbT47DQo+RmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgZG1hZW5n
aW5lQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+DQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSF0gZG1hZW5naW5lOiBmc2wtZWRt
YTogQWRkIGVETUEgc3VwcG9ydCBmb3IgUW9ySVENCj5MUzEwMjhBIHBsYXRmb3JtDQo+DQo+Q2F1
dGlvbjogRVhUIEVtYWlsDQo+DQo+SGkgUGVuZywNCj4NCj5PbiBGcmksIE9jdCAxOCwgMjAxOSBh
dCA3OjA4IEFNIFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT3VyIHBs
YXRmb3JtcyB3aXRoIGJlbG93IHJlZ2lzdGVycyhDSENGRzAgLSBDSENGRzE1KSBvZiBlRE1BIGFz
IGZvbGxvd3M6DQo+DQo+UGxlYXNlIGJlIG1vcmUgc3BlY2lmaWM6IHdoYXQgZG9lcyAiT3VyIHBs
YXRmb3JtcyIgbWVhbj8NCg==
