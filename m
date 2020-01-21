Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF921435C8
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 03:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAUCy6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jan 2020 21:54:58 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:42564
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726890AbgAUCy6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Jan 2020 21:54:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYOYMSYXS2A5HJ3qESDiT6J9SsrFvZznWAf8aYyAuE5ujgIGIxO/WC5kPZH5uQLWn7hHQ0hWJO/p6N2ljYJeOdbOCn5Crhqz9iGQbzbSD9nciHou/nJAp5OLawEJb6dAw6KcL3LvN5flIendyUR5rcdYTMhI+FqeTx/vHLdj1V1160WCZrGMP/7ti14w/xv03tUaU8cyYYFcXfPjqCz9WsjtXNIZL5UBOA2tyQoOAqG7cOc6lsK0N40RQmPdxMG8SNiVki+mW5mX+knXh9rvK4HA8fVqEhvzgIwtPVy3LO1DKF4xNp65J4lCLQBEX2XxOrmedZHrVLkQ0rqmwP3f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwanQaKuIqWPH2ibQ40M65rFvlSkyygrZQ0nB5kHfik=;
 b=YeKpEMZLq2vvFIuyR6Xmc7o4J/WKVpglHqXDH4qWi/3225AoxVLcSZF4LbKmDtPPuTRm0NgCzRy1wsS6FwUyk128mLufd7Mga9RsrwdWs8U1m+mF4e0MwIVpB4gsWgfA3TRg2+Sjrob3MXLW6QrEqzdaJeH3dHpgNroCtj90mkS4iBA4+MGagKniVnvV22GwdNcOAOgi3QAJhtLRj56f2am42r+RQk/D6zhtgHmNp+QqKkqVhcWSO494avnIdWiyxc80P+Bb1KCfmVH92QMuK1pUBjxb3BphEWSFDGiUgciDJhg/WKv9MEJCZ/h1dRpgVsKXrmPY3xeRtpH3dU4lUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwanQaKuIqWPH2ibQ40M65rFvlSkyygrZQ0nB5kHfik=;
 b=avovgtiMO6sDBp26qIjx1l4er2cGOLTr9efxgAuHC+Ffwh4o4AhHJhJx2FlFyAsfUxfYF5FB86W2Z0qjn81ZnOrZNcqV4xiWXDuy7TEbzinHEiZ2AskrLhFInLoICXtBkf1UfuseBbAWyL6QzARImxzwWlDD2Qej9WLT9zLoB4I=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB5584.eurprd04.prod.outlook.com (20.178.123.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 02:54:55 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::751a:cffd:6e67:e05d]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::751a:cffd:6e67:e05d%7]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 02:54:55 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Chen Zhou <chenzhou10@huawei.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
Thread-Topic: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
Thread-Index: AQHVz5IYyfo46j7pF0OQYf9kiJHCJqf0az4g
Date:   Tue, 21 Jan 2020 02:54:54 +0000
Message-ID: <VI1PR04MB44314C51FA4C397F352C14C8ED0D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20200120125843.34398-1-chenzhou10@huawei.com>
In-Reply-To: <20200120125843.34398-1-chenzhou10@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaf18be5-ada2-461a-b816-08d79e1d4b42
x-ms-traffictypediagnostic: VI1PR04MB5584:
x-microsoft-antispam-prvs: <VI1PR04MB5584EA48BA189705CB521C35ED0D0@VI1PR04MB5584.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(52536014)(316002)(54906003)(186003)(110136005)(478600001)(5660300002)(33656002)(71200400001)(2906002)(44832011)(6506007)(64756008)(9686003)(81156014)(86362001)(81166006)(4326008)(66476007)(66946007)(66446008)(66556008)(8676002)(76116006)(8936002)(55016002)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5584;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /SrIS0aEefi4qmO1g4SNIKBDv0qA/GVHNwWvn3lEwIOzDGyEb8wsai7Aq2n7qisxKAKC4GVfOZooS4q6zRaB19GdRQlxaM8PCDqSqtAqO6lwINazpaR5QRrNtBUfgh8pr4W63GXweTaSxbRkTkVoSV9cNEN3X0SDXjgMnURJzWRup6c8ohXHTyka83ud4mbHyzwPNRCdzNhX/lxGSnhdwGHZLbSm7kWdL5NdSAfZyd3aqpU+E8ciyvL8NLieRbmsSTOiP4l6Po+gYkQFXob9l3lbUbf9L0VQzwPxCJSksKCYeTK/JLyrIDhCPNVs6coAS1y0KS72EzoiqYd1OTzb11VuL09UJaO+m6kBjJpvAK4Eqkx0VaUsFpPnQwrqKO0/sxxeWuZP3kgu3Z+5xD2lyHh0CfhN4McV4e8usssKmVQFgccWuxMlRuyrkeO0id4d
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf18be5-ada2-461a-b816-08d79e1d4b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 02:54:54.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nca7fMP+TArXe3jkX7828Z6fvVtUFXInNz8JjJCT8mvyB9ZTbH7tXWXUv9WgeCD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5584
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW4gWmhvdSA8Y2hlbnpo
b3UxMEBodWF3ZWkuY29tPg0KPlNlbnQ6IDIwMjDE6jHUwjIwyNUgMjA6NTkNCj5UbzogZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tOyB2a291bEBrZXJuZWwub3JnDQo+Q2M6IFBlbmcgTWEgPHBlbmcu
bWFAbnhwLmNvbT47IFdlbiBIZSA8d2VuLmhlXzFAbnhwLmNvbT47DQo+amlhaGVuZy5mYW5Abnhw
LmNvbTsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBjaGVuemhvdTEwQGh1YXdlaS5jb20NCj5TdWJqZWN0OiBbUEFUQ0ggLW5leHRdIGRt
YWVuZ2luZTogZnNsLXFkbWE6IGZpeCBkdXBsaWNhdGVkIGFyZ3VtZW50IHRvICYmDQo+DQo+VGhl
cmUgaXMgZHVwbGljYXRlZCBhcmd1bWVudCB0byAmJiBpbiBmdW5jdGlvbiBmc2xfcWRtYV9mcmVl
X2NoYW5fcmVzb3VyY2VzLA0KPndoaWNoIGxvb2tzIGxpa2UgYSB0eXBvLCBwb2ludGVyIGZzbF9x
dWV1ZS0+ZGVzY19wb29sIGFsc28gbmVlZHMgTlVMTCBjaGVjaywNCj5maXggaXQuDQo+RGV0ZWN0
ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPg0KV2hhdCBkb2VzIHRoZSAiIGNvY2NpbmVsbGUgIiBtZWFu
IGhlcmU/DQoNCj5GaXhlczogYjA5MjUyOWUwYWEwICgiZG1hZW5naW5lOiBmc2wtcWRtYTogQWRk
IHFETUEgY29udHJvbGxlciBkcml2ZXIgZm9yDQo+TGF5ZXJzY2FwZSBTb0NzIikNCj5TaWduZWQt
b2ZmLWJ5OiBDaGVuIFpob3UgPGNoZW56aG91MTBAaHVhd2VpLmNvbT4NCj4tLS0NCj4gZHJpdmVy
cy9kbWEvZnNsLXFkbWEuYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2ZzbC1xZG1hLmMg
Yi9kcml2ZXJzL2RtYS9mc2wtcWRtYS5jIGluZGV4DQo+ODk3OTIwOC4uOTVjYzAyNSAxMDA2NDQN
Cj4tLS0gYS9kcml2ZXJzL2RtYS9mc2wtcWRtYS5jDQo+KysrIGIvZHJpdmVycy9kbWEvZnNsLXFk
bWEuYw0KPkBAIC0zMDQsNyArMzA0LDcgQEAgc3RhdGljIHZvaWQgZnNsX3FkbWFfZnJlZV9jaGFu
X3Jlc291cmNlcyhzdHJ1Y3QNCj5kbWFfY2hhbiAqY2hhbikNCj4NCj4gCXZjaGFuX2RtYV9kZXNj
X2ZyZWVfbGlzdCgmZnNsX2NoYW4tPnZjaGFuLCAmaGVhZCk7DQo+DQo+LQlpZiAoIWZzbF9xdWV1
ZS0+Y29tcF9wb29sICYmICFmc2xfcXVldWUtPmNvbXBfcG9vbCkNCj4rCWlmICghZnNsX3F1ZXVl
LT5jb21wX3Bvb2wgJiYgIWZzbF9xdWV1ZS0+ZGVzY19wb29sKQ0KPiAJCXJldHVybjsNCj4NCkhp
IENoZW4sDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgcGF0Y2gsIEl0IGlzIHJlYWxseSBu
ZWVkIHRvIGNoZWNrIGNvbXBfcG9vbCBhbmQgZGVzY19wb29sIGhlcmUuDQpSZXZpZXdlZC1ieTog
UGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KVGVzdGVkLWJ5OiBQZW5nIE1hIDxwZW5nLm1hQG54
cC5jb20+DQoNCkJSLA0KUGVuZw0KPiAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGNvbXBfdGVt
cCwgX2NvbXBfdGVtcCwNCj4tLQ0KPjIuNy40DQoNCg==
