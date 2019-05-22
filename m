Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304B625E20
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEVGdQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 02:33:16 -0400
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:55973
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfEVGdQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 02:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeHjNQ/1noy2v+qVfWNBDIneeNtdHzDWFGoVDZQk64c=;
 b=GalRkEnFY0RpFNPT2Y4/MYGR9o7qHIn7T5RcN8JVW1c9DZsXGwrk+PSzh5TWaakaG7RSl6RrRba6laK91durQl5FOiComFD4j4+3VKzcGrqxodbkjp/k0JPh9fKNgIenSXAftCTiur4q3y3Q+AMxtFdeaVMnzyj3XPAFZwYFehA=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5135.eurprd04.prod.outlook.com (20.177.50.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Wed, 22 May 2019 06:33:12 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::2019:b65b:e862:7db3]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::2019:b65b:e862:7db3%3]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 06:33:12 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 3/4] dmaengine: fsl-edma: support little endian
 for edma driver
Thread-Topic: [EXT] Re: [PATCH 3/4] dmaengine: fsl-edma: support little endian
 for edma driver
Thread-Index: AQHVA+u22k6DG9FKYUKGRuMuWXFXD6Z1FiGAgAGnp2A=
Date:   Wed, 22 May 2019 06:33:12 +0000
Message-ID: <VI1PR04MB44319B81D1DBBB4752822813ED000@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190506090344.37784-1-peng.ma@nxp.com>
 <20190506090344.37784-3-peng.ma@nxp.com> <20190521043807.GN15118@vkoul-mobl>
In-Reply-To: <20190521043807.GN15118@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4f980ae-3e04-49c8-1132-08d6de7f5d14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5135;
x-ms-traffictypediagnostic: VI1PR04MB5135:
x-microsoft-antispam-prvs: <VI1PR04MB513572890E73E11842BD6790ED000@VI1PR04MB5135.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(13464003)(71190400001)(71200400001)(8936002)(6916009)(66066001)(81156014)(81166006)(76176011)(8676002)(2906002)(86362001)(498600001)(99286004)(55016002)(14454004)(256004)(9686003)(305945005)(7736002)(6506007)(7696005)(66946007)(5660300002)(66476007)(66556008)(64756008)(66446008)(68736007)(186003)(44832011)(6246003)(229853002)(73956011)(4326008)(11346002)(52536014)(26005)(53936002)(54906003)(76116006)(3846002)(33656002)(486006)(6116002)(74316002)(102836004)(476003)(25786009)(6436002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5135;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V3TkbAsUM+/pOExkSEZiezb1XLwbiz5Ydkz2Hbix6n4iCrTVH7l6of9Q26E2lPRveZfhHb679dxZRfcXBprPB//1QD15JJgP6jRnp/3evaE1n9+y6RFycXBXHm/CqO0wzN+0BZiARujXuHsP/Hu70+T23LRU4Am5EiCQhSdRwG9aEwqDWki4mCRz3013acz56O3rjGMkAV8P9VJW38KBWOF6yZk0VirWMVzHAbSabkdEk6Z05kIMXbDnPoSIF/tYSNdosUinrS+w3LEPUzm+7taujGIESVZ3T1AlfIT8nx9DnfhFKiKnz1O/xvanHueKmUcX6NSql/uAn5WjzfaDSoyBbVOz2VwcIrUgYjOwd5M55KPQr43VMCr1EKtae7UBxTHm45T8qvrT4ML3WaIYgZgP0oCFJAENIYfE14fQBcc=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f980ae-3e04-49c8-1132-08d6de7f5d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 06:33:12.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5135
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNClRoYW5rIGZvciB5b3UgcmVwbHkuDQp0aGUgcmVnaXN0ZXJzIChDSENGRzAg
LSBDSENGRzE1KSBvbiBiaWcgZW5kaWFuIHNvY3MgYXMgZmFsbG93czoNCkNIQ0ZHMAkJMHgwDQpD
SENGRzEJCTB4MQ0KQ0hDRkcyCQkweDINCkNIQ0ZHMwkJMHgzDQouLi4uLi4NCkNIQ0ZHMTIJCTB4
Qw0KQ0hDRkcxMwkJMHhEDQpDSENGRzE0CQkweEUNCkNIQ0ZHMTUJCTB4Rg0KDQpPbiBsaXR0bGUg
ZW5kaWFuIHNvY3MgYXMgZmFsbG93czoNCkNIQ0ZHMwkJMHgwDQpDSENGRzIJCTB4MQ0KQ0hDRkcx
CQkweDINCkNIQ0ZHMAkJMHgzDQouLi4uLi4NCkNIQ0ZHMTUJCTB4Qw0KQ0hDRkcxNAkJMHhEDQpD
SENGRzEzCQkweEUNCkNIQ0ZHMTIJCTB4Rg0KDQpUbyBmaXQgdGhpcyBtYXAgd2Ugc2hvdWxkIGFk
ZCB0aGlzIHBhdGNoLg0KDQpCZXN0IFJlZ2FyZHMsDQpQZW5nDQo+LS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj5Gcm9tOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KPlNlbnQ6IDIw
MTnE6jXUwjIxyNUgMTI6MzgNCj5UbzogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPkNjOiBy
b2JoK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBMZW8NCj5MaSA8bGVveWFuZy5saUBueHAuY29tPjsgZGFuLmoud2lsbGlhbXNAaW50ZWwu
Y29tOw0KPmRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggMy80XSBkbWFlbmdp
bmU6IGZzbC1lZG1hOiBzdXBwb3J0IGxpdHRsZSBlbmRpYW4gZm9yDQo+ZWRtYSBkcml2ZXINCj4N
Cj5DYXV0aW9uOiBFWFQgRW1haWwNCj4NCj5PbiAwNi0wNS0xOSwgMDk6MDMsIFBlbmcgTWEgd3Jv
dGU6DQo+PiBpbXByb3ZlIGVkbWEgZHJpdmVyIHRvIHN1cHBvcnQgbGl0dGxlIGVuZGlhbi4NCj4N
Cj5DYW4geW91IGV4cGxhaW4gYSBiaXQgbW9yZSBob3cgYWRkaW5nIHRoZSBiZWxvdyBsaW5lcyBh
ZGRzIGxpdHRsZSBlbmRpYW4NCj5zdXBwb3J0Li4uDQo+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
UGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9kbWEvZnNsLWVk
bWEtY29tbW9uLmMgfCAgICA1ICsrKysrDQo+PiAgMSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2Zz
bC1lZG1hLWNvbW1vbi5jDQo+PiBiL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLWNvbW1vbi5jIGluZGV4
IDY4MGIyYTAuLjZiZjIzOGUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2RtYS9mc2wtZWRtYS1j
b21tb24uYw0KPj4gKysrIGIvZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmMNCj4+IEBAIC04
Myw5ICs4MywxNCBAQCB2b2lkIGZzbF9lZG1hX2NoYW5fbXV4KHN0cnVjdCBmc2xfZWRtYV9jaGFu
DQo+KmZzbF9jaGFuLA0KPj4gICAgICAgdTMyIGNoID0gZnNsX2NoYW4tPnZjaGFuLmNoYW4uY2hh
bl9pZDsNCj4+ICAgICAgIHZvaWQgX19pb21lbSAqbXV4YWRkcjsNCj4+ICAgICAgIHVuc2lnbmVk
IGludCBjaGFuc19wZXJfbXV4LCBjaF9vZmY7DQo+PiArICAgICBpbnQgZW5kaWFuX2RpZmZbNF0g
PSB7MywgMSwgLTEsIC0zfTsNCj4+DQo+PiAgICAgICBjaGFuc19wZXJfbXV4ID0gZnNsX2NoYW4t
PmVkbWEtPm5fY2hhbnMgLyBETUFNVVhfTlI7DQo+PiAgICAgICBjaF9vZmYgPSBmc2xfY2hhbi0+
dmNoYW4uY2hhbi5jaGFuX2lkICUgY2hhbnNfcGVyX211eDsNCj4+ICsNCj4+ICsgICAgIGlmICgh
ZnNsX2NoYW4tPmVkbWEtPmJpZ19lbmRpYW4pDQo+PiArICAgICAgICAgICAgIGNoX29mZiArPSBl
bmRpYW5fZGlmZltjaF9vZmYgJSA0XTsNCj4+ICsNCj4+ICAgICAgIG11eGFkZHIgPSBmc2xfY2hh
bi0+ZWRtYS0+bXV4YmFzZVtjaCAvIGNoYW5zX3Blcl9tdXhdOw0KPj4gICAgICAgc2xvdCA9IEVE
TUFNVVhfQ0hDRkdfU09VUkNFKHNsb3QpOw0KPj4NCj4+IC0tDQo+PiAxLjcuMQ0KPg0KPi0tDQo+
flZpbm9kDQo=
