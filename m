Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D15DE8A3
	for <lists+dmaengine@lfdr.de>; Mon, 21 Oct 2019 11:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfJUJyZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Oct 2019 05:54:25 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:13550
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727649AbfJUJyZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Oct 2019 05:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjtNWdNvzkZ7rRP/dxguRbD7LXHE1PqGDqjOovZI/cKPd68P3seNLLZZACQX6ovx8Kx8DwTVgBPIvu97ykxEl2PxigxkRTV4ObbYNDOAk+QTdnAEcdR2i0PRqQqa3OarhqlQb1FNQ2p7r/AWRFoBOCJU36e0Byd5Qum4rt/snACcPAoFDbiSLkIchYoaYqjgWch5mgJg06+eLrVdRKH+Y8g9p2OKe7fIdWGXs2mXyC0NmNbW7cdVq04BYOynj38l5W5rZr6fL1lIrOzXYfuAAbZk5ZZENHBfmUE3v2cfrAxQEblAoBgmror1OS26EwuzNH9+pLIDmpTiZVcQT4qWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw/EplxJm4kiJVwTdlro4d3bdOAzgLRcPlbOLSj8bnI=;
 b=fJXaz5YFy0BVKYdVV17ztpVD1j1SqOI/DI1m/EpFElHn3IxgxfPn0HjMh0+VVm0niRFDaVZwfLeyx7xKHa/rvvAxe9TQ5jJBhONExPZ3YSg6Sq81kwUMNQBMIVlgNggKjpJ8JkLsO8/xDg5kY0uINmysb9OQZNQheBrb2lrCUthBOq0kRImK6sw/UwRm780S1xgohTVj6S4YOO41OKXm5JabVULOTcwWOCMcLPvs9rfQVLcoc39y+XiAWSvHZBxLR+GMV90/QAu357Kctkw32dJY3G/WoYIRg4yEoaPjc0ZbjSGhRac1T04JcTSWo0z05CiR8PH8ETAwNa58iv11Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw/EplxJm4kiJVwTdlro4d3bdOAzgLRcPlbOLSj8bnI=;
 b=dVkiXiOerPYHk00SoFFKVPfLs1yTXPf7EPO/UO+0/LYBYxG9HTdS9wPqNqukaLURdfweL7FxbPA7lwWsxYuIcmwBisIeCVutct6QFbACCWjdDVYi6iiD6U9BFVTT+tMaM97GxR7+snyjAH6VCnLnpcbfje9nSbCmzBlJ5a6kaN8=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB4559.eurprd04.prod.outlook.com (20.177.57.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.28; Mon, 21 Oct 2019 09:54:20 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb%6]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 09:54:20 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wen He <wen.he_1@nxp.com>, Jiaheng Fan <jiaheng.fan@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [RFT] dmaengine: fsl-qdma: Handle invalid qdma-queue0 IRQ
Thread-Topic: [EXT] [RFT] dmaengine: fsl-qdma: Handle invalid qdma-queue0 IRQ
Thread-Index: AQHVesWaY7lZ3xT0I06FGKi10zfOGadk8Kvw
Date:   Mon, 21 Oct 2019 09:54:20 +0000
Message-ID: <VI1PR04MB443161476574A4424B0B55B2ED690@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20191004150826.6656-1-krzk@kernel.org>
In-Reply-To: <20191004150826.6656-1-krzk@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d33613f-88a9-4191-6512-08d7560ca54a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB4559:|VI1PR04MB4559:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4559079CEFEE525DF9B8EA32ED690@VI1PR04MB4559.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(13464003)(199004)(189003)(229853002)(486006)(2906002)(11346002)(186003)(476003)(446003)(66066001)(44832011)(71190400001)(71200400001)(81166006)(256004)(8676002)(6436002)(8936002)(81156014)(6116002)(55016002)(3846002)(99286004)(25786009)(9686003)(6506007)(7736002)(305945005)(66446008)(64756008)(74316002)(5660300002)(52536014)(76176011)(6246003)(102836004)(2501003)(2201001)(33656002)(26005)(76116006)(316002)(478600001)(66476007)(110136005)(66946007)(7696005)(14454004)(66556008)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4559;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 661A++JJNSOF0eiIzmoD6WppU22v2o50i3FS466ZtD1vcavIMrLosjOkUKFAm2PWC1MQb58DEyX7PnJVXO+K09gh6a23YQpw1yq7/nfJnEKy5IivCiQSHR5RKS0v4Rya7SUkQejqJKsJhc3nNaq3gBur+1RwC4NbIf8wfyppxKatxYcAsp/T9VQmq4HHPGTM3DWzWLU50o1bCxEvpuU9q/lPin9pr+ObqbzR+3cdvPOsSj2WyDR/S3h3ABZW2SP8bekIgaoTwYwAeqoQbsINTag6Zx4Tv6H3gyJtllbGLJbqhQM00QC3U3uWcpYJ/YGl1nWo3Lo+frroLr6zYUr5a998MtaceIgIhipVfXUq+SnMxAGkLmuZbtT9QL6MBQngzGlQObsDrhrMFu+enOZdhbnTSBejqYr7lITULa7Y/Tc=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d33613f-88a9-4191-6512-08d7560ca54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 09:54:20.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9p4CX4NPiA0uLQfyXpr6xjLta5/7fvnZ/YYhYfxFLN5XP43BCmgT/HJiSPEOd9o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4559
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQpSZXZpZXdlZC1ieTogUGVu
ZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KVGVzdGVkLWJ5OiBQZW5nIE1hIDxwZW5nLm1hQG54cC5j
b20+DQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj5TZW50OiAyMDE5
xOoxMNTCNMjVIDIzOjA4DQo+VG86IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBEYW4g
V2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47DQo+UGVuZyBNYSA8cGVuZy5tYUBu
eHAuY29tPjsgV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPjsgSmlhaGVuZyBGYW4NCj48amlhaGVu
Zy5mYW5AbnhwLmNvbT47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47DQo+
ZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PlN1YmplY3Q6IFtFWFRdIFtSRlRdIGRtYWVuZ2luZTogZnNsLXFkbWE6IEhhbmRsZSBpbnZhbGlk
IHFkbWEtcXVldWUwIElSUQ0KPg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0KPnBsYXRmb3JtX2dl
dF9pcnFfYnluYW1lKCkgbWlnaHQgcmV0dXJuIC1lcnJubyB3aGljaCBsYXRlciB3b3VsZCBiZSBj
YXN0IHRvIGFuDQo+dW5zaWduZWQgaW50IGFuZCB1c2VkIGluIElSUSBoYW5kbGluZyBjb2RlIGxl
YWRpbmcgdG8gdXNhZ2Ugb2Ygd3JvbmcgSUQgYW5kDQo+ZXJyb3JzIGFib3V0IHdyb25nIGlycV9i
YXNlLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz4NCj4NCj4tLS0NCj4NCj5Ob3QgbWFya2luZyBhcyBjYy1zdGFibGUgYXMgdGhpcyB3YXMg
bm90IHJlcHJvZHVjZWQgYW5kIG5vdCB0ZXN0ZWQuDQo+LS0tDQo+IGRyaXZlcnMvZG1hL2ZzbC1x
ZG1hLmMgfCAzICsrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+ZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2ZzbC1xZG1hLmMgYi9kcml2ZXJzL2RtYS9mc2wtcWRtYS5j
IGluZGV4DQo+MDY2NjRmYmQyZDkxLi44OTc5MjA4M2Q2MmMgMTAwNjQ0DQo+LS0tIGEvZHJpdmVy
cy9kbWEvZnNsLXFkbWEuYw0KPisrKyBiL2RyaXZlcnMvZG1hL2ZzbC1xZG1hLmMNCj5AQCAtMTE1
NSw2ICsxMTU1LDkgQEAgc3RhdGljIGludCBmc2xfcWRtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlDQo+KnBkZXYpDQo+ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+DQo+ICAgICAg
ICBmc2xfcWRtYS0+aXJxX2Jhc2UgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZShwZGV2LA0KPiJx
ZG1hLXF1ZXVlMCIpOw0KPisgICAgICAgaWYgKGZzbF9xZG1hLT5pcnFfYmFzZSA8IDApDQo+KyAg
ICAgICAgICAgICAgIHJldHVybiBmc2xfcWRtYS0+aXJxX2Jhc2U7DQo+Kw0KPiAgICAgICAgZnNs
X3FkbWEtPmZlYXR1cmUgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJiaWctZW5kaWFuIik7
DQo+ICAgICAgICBJTklUX0xJU1RfSEVBRCgmZnNsX3FkbWEtPmRtYV9kZXYuY2hhbm5lbHMpOw0K
Pg0KPi0tDQo+Mi4xNy4xDQoNCg==
