Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98E5FF64
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 04:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfGECFE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jul 2019 22:05:04 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:46402
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfGECFE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 4 Jul 2019 22:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS+0gswj8H22c/NES4DoDnbwTE+AjXvcMRkffF1pP1U=;
 b=EkaSyeAdFh0dfL9vqFl1iDGJmn30Uo2CRTUCy4SWdDSoZ+wmblBS9Rkeq39ePn07DmiPoRLsYArbvv+354nrNqjtZPvvtBVij8O5gEdV6wRgrpgUk9Pb5ISiUlmvwNWioWo6zv7+ZYq8ZVW1HD4CnTKSOg8m0kFdFPJwCKUGoHI=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB4173.eurprd04.prod.outlook.com (52.133.15.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 02:04:21 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e8aa:b70a:82ad:9309]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e8aa:b70a:82ad:9309%7]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 02:04:21 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Andy Tang <andy.tang@nxp.com>
Subject: RE: [EXT] [BUG BISECT] Net boot fails on VF50 after "dmaengine:
 fsl-edma: support little endian for edma driver"
Thread-Topic: [EXT] [BUG BISECT] Net boot fails on VF50 after "dmaengine:
 fsl-edma: support little endian for edma driver"
Thread-Index: AQHVMM97bioibA225kez47O1R7Lss6a5tHCwgAC57oCAANuG8A==
Date:   Fri, 5 Jul 2019 02:04:20 +0000
Message-ID: <VI1PR04MB4431E18760FCB6CE32E5717DEDF50@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
 <VI1PR04MB44316904F765E93CC1DFA0EDEDFA0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <CAJKOXPdYJKe019CKT=hPRXLejMdZ1KNzxpFh60ruToKOqnAorQ@mail.gmail.com>
In-Reply-To: <CAJKOXPdYJKe019CKT=hPRXLejMdZ1KNzxpFh60ruToKOqnAorQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0ebcdc6-21fb-469f-ab28-08d700ed184e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4173;
x-ms-traffictypediagnostic: VI1PR04MB4173:
x-microsoft-antispam-prvs: <VI1PR04MB41732F18CCEA18BA5BDBB1D4EDF50@VI1PR04MB4173.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(40764003)(199004)(189003)(13464003)(229853002)(6116002)(14454004)(66446008)(54906003)(86362001)(478600001)(52536014)(66476007)(6246003)(55016002)(73956011)(316002)(9686003)(102836004)(66556008)(66946007)(76116006)(5660300002)(64756008)(6506007)(33656002)(53936002)(66066001)(3846002)(7696005)(6436002)(26005)(4326008)(99286004)(11346002)(25786009)(81166006)(8676002)(81156014)(8936002)(486006)(446003)(6916009)(2906002)(7736002)(44832011)(476003)(76176011)(256004)(74316002)(186003)(305945005)(68736007)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4173;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mNPGQlnEzhS8/CTN3ddSSIsRHmPENXg7PgqWCh/G3RJOoJJWQJOFM1gBwykPp4Ivi0A24v7uOUDNv7is0LIydzRfjkBySOa2SdwJcI7WFUDIT8r5NjrYk/blaXKi+H+7xNcNooXRnb4s8hzbqqbJXX44CcyV0iDjw9oGj5NVBV+E5FkOFtbug4KpNBTf/4Elg9mzKjwTAYfech+rvJwo5Ws0KFCk7FThXu3Ljb4NzDml6myGFw/qO+8fEUP0oXbBRaj+W0Dzl9Et7tg3YzcV2xI+3to65CXh2HeI7jyNiR5+BiW7ZaxB+9WQXCCarMfWu4aQMgTqBwSndtHqeioL3P50jls0SQFykaaMdc9a6sBotUVOHNxZBiEGdXmbiKakp+XK5JGfOlpL6wIwZ8WDzsXUoOf2DnY9MwSo/hLMAu4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ebcdc6-21fb-469f-ab28-08d700ed184e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 02:04:20.9453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.ma@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4173
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpHb3QgaXQuIFRoYW5rcyBmb3IgeW91ciBoZWxwDQoNCkJlc3QgUmVn
YXJkcywNClBlbmcNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtyenlzenRv
ZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj5TZW50OiAyMDE55bm0N+aciDTml6UgMjA6
NTcNCj5UbzogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPkNjOiBWaW5vZCBLb3VsIDx2a291
bEBrZXJuZWwub3JnPjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBM
ZW8NCj5MaSA8bGVveWFuZy5saUBueHAuY29tPjsgQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNv
bT4NCj5TdWJqZWN0OiBSZTogW0VYVF0gW0JVRyBCSVNFQ1RdIE5ldCBib290IGZhaWxzIG9uIFZG
NTAgYWZ0ZXIgImRtYWVuZ2luZToNCj5mc2wtZWRtYTogc3VwcG9ydCBsaXR0bGUgZW5kaWFuIGZv
ciBlZG1hIGRyaXZlciINCj4NCj5DYXV0aW9uOiBFWFQgRW1haWwNCj4NCj5PbiBUaHUsIDQgSnVs
IDIwMTkgYXQgMDQ6MTAsIFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4gd3JvdGU6DQo+Pg0KPj4g
SGkgS3J6eXN6dG9mLA0KPj4NCj4+IEkgYW0gc29ycnksIEl0IGlzIG15IG1pc3Rha2UgdG8gZm9y
Z2V0IGFib3V0IFZGNTAgdXNlZCBFRE1BIElQIHdpdGggbGl0dGxlDQo+ZW5kaWFuLg0KPj4gVGhl
IFJlZ2lzdGVyKENIQ0ZHMCAtIENIQ0ZHMTUpIG9mIG91ciBwbGF0Zm9ybSBkZXNpZ25lZCBhcyBm
b2xsb3dzOg0KPj4gKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gLS0tLS0tLS0tLSoNCj4+IHwgICAgIE9mZnNl
dCAgIHwgQmlnIGVuZGlhbiBSZWdpc3RlcnwgTGl0dGxlIGVuZGlhbiBSZWdpc3RlcnwNCj4+IHwt
LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgICAweDAgICAgIHwgICAgIENIQ0ZHMCAgICB8
ICAgICBDSENGRzMgICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4gfCAgICAg
MHgxICAgICB8ICAgICBDSENGRzEgICAgfCAgICAgQ0hDRkcyICAgICAgfA0KPj4gfC0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwNCj4+IHwgICAgIDB4MiAgICAgfCAgICAgQ0hDRkcyICAgIHwgICAgIENI
Q0ZHMSAgICAgIHwNCj4+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgICAweDMgICAg
IHwgICAgIENIQ0ZHMyAgICB8ICAgICBDSENGRzAgICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS0t
LS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tfA0KPj4gfCAgICAgLi4uICAgICAgfCAgICAgICAgLi4uLi4uICAgICB8ICAgICAgICAg
Li4uLi4uICAgICAgfA0KPj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4+IHwgICAgIDB4QyAg
ICAgfCAgICAgQ0hDRkcxMiAgIHwgICAgIENIQ0ZHMTUgICAgIHwNCj4+IHwtLS0tLS0tLS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18DQo+PiB8ICAgICAweEQgICAgIHwgICAgIENIQ0ZHMTMgICB8ICAgICBDSENGRzE0
ICAgICB8DQo+PiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4gfCAgICAgMHhFICAgICB8ICAg
ICBDSENGRzE0ICAgfCAgICAgQ0hDRkcxMyAgICAgfA0KPj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0t
LXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LXwNCj4+IHwgICAgIDB4RiAgICAgfCAgICAgQ0hDRkcxNSAgIHwgICAgIENIQ0ZHMTIgICAgIHwN
Cj4+ICotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+IC0tLS0tLS0tLS0qDQo+Pg0KPj4gU28gd2UgbmVlZCB0aGlz
IHBhdGNoLCBJIG1ha2Ugc29tZSBjaGFuZ2VzLFBsZWFzZSBoZWxwIG1lIHRvIHRlc3QNCj4+IGF0
dGF0Y2htZW50IG9uIFZGNTAgYm9hcmQsIFRoYW5rcy4NCj4NCj5XaXRoIHRoZSBwYXRjaCBWRjUw
IGJvb3RzIGZpbmUuDQo+DQo+QlRXLCBDb2xpYnJpIFZGNTAgbmljZWx5IGJvb3RzIGZyb20gbmV0
d29yayBhbG1vc3Qgb3V0IG9mIHRoZSBib3ggc28gaXQgaXMgZWFzeQ0KPnRvIGFkZCBpdCB0byBh
dXRvbWF0ZWQgdGVzdHMgZm9yIHNpbXBsZSBib290IHRlc3RzLiBUaGlzIHdheSB5b3UgZG8gbm90
IGhhdmUgdG8NCj5tYW51YWxseSB0ZXN0IGl0IG9uIHN1Y2ggcGxhdGZvcm0uLi4NCj4NCj5CZXN0
IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQo=
