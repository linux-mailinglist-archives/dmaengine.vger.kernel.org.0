Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA65A22AC77
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 12:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgGWKYc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jul 2020 06:24:32 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:2275
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgGWKYb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Jul 2020 06:24:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hndrpY1DcI+G5owU3YB88e60UGjlRXgOnOmxjtyxFuWGoiKvgh4Ue4oWU+A96GIlrs2n0c6WqLK3Pnu9ftqxfFUivruWV8ZYLQTcXhbwbAE29BvIc3vDcOyTkpcCQcYLwTBIHRhVF8o5JwjeNk7H4WBTSDaAmF50oypLaPUNeZMu88EE6+oEj8Q+lJJcYEkkR2Lsc5klNv3aZQxCQNJaGDSkS/cru/CF5HeCeALdffRR+bczeYeklfZAbsyrgiyCRwLtM/7/kgQbqlGW/wK8SoX1vGhWXyu/wVFq/P4w+uVPI9c/eLvlKLBYweztz1LQRHJgAtwgLj3I22IGLxTomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy7L9so1UZiRQFFktHmkKHtFhqNLoOXeChliVpxemVY=;
 b=d4sfoEpcOXfwGU2RIN9BNVCVYwCuhi72izz01i3x5WDzxxqIE2knTKnYCt+jpvezQ3jXKS7u+rsx9PYJkd1VAczBBz6lubOHD2BCX01/hNYMLhTMmsH1kRBr5RN5/kk8H2qP/L8oHlGcdgcSoEt867ZLX9IVXjwzEmN5ScHBUNvYJ2rG90QyeFws0vpQBJ0XSRSGVWAXTHRFRf94iULXSUkdi8iXMUEgLy0VxucN4D6TsRmP2SP0hmCU+boGtB24ik8eykIie8hl2tpWPDrw3hjV7TFStSOiSkWYwOUyzcwlUUtKm9lZ19V5LRRXZF8e0SZTrAZDwU3MWr/FNNt8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy7L9so1UZiRQFFktHmkKHtFhqNLoOXeChliVpxemVY=;
 b=kkGUXq1Pda/xbGAemsOOVaceGq11vJoq9RU1r7EqZN1qzf1yoZSSdGe5Qoj01L3tx0NyBjSBqRSAjClnoqYUiwk0WR19YGQw4js3CVxPwLr7wR1558OWHdRoEWlorLHGJ3tcGhe19dUQXPnCskRcLTyQhr/yPQLg7HfFkY+1ViQ=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2687.eurprd04.prod.outlook.com (2603:10a6:800:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 10:24:25 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 10:24:25 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
Thread-Topic: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
Thread-Index: AQHWTp7JbcJo/3lJ0kuBP+xQgJ1yA6kVAw+AgAAOScA=
Date:   Thu, 23 Jul 2020 10:24:24 +0000
Message-ID: <VE1PR04MB66385FC4FE591EAFA8CB7D8289760@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
 <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
 <1b04e4e6-ca26-3f45-e353-af81e03f85a7@kontron.de>
In-Reply-To: <1b04e4e6-ca26-3f45-e353-af81e03f85a7@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3ee1c90-5dd6-4fbf-0b65-08d82ef292b8
x-ms-traffictypediagnostic: VI1PR0401MB2687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB26876BF85C613181C9289D9889760@VI1PR0401MB2687.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6FndDPgVNFpnQsxBquKQ6OZFjqql3U0osmYPCsXuQlM1Sm/G9UzvEWXBiA7VoGcOwCbrjzoyyU1cDn0hTYVfUpzHOlsfKsmYOLuF8xRZin/2y7umbOgBIjVuHp5SWV9w06bv38A1deiuua+fY9bMnFAG390kySHkBApH66lkC7tprYUsnfcWBj5+cZdRsFqREpoRT2Pyymbk5gXRHwcKAiL1DAAzav8PDbrmziIerpymkAjKkBW/ibrusSlg5cFZfVZih/dZsbvxEw/zQ+TDqghXZMhwdjeZNzT39UGX9PW+W7+yDlzoaHk5myF1Wtu4VpBoNTlp5eRhylM1flGjxfaWW/vFJa2+qUwMFIe8cRNuXVZ47y7RZcDRqxfjTI4wlJ2jww4LqTQkjBOyKH3b4uiz07qq9IB1wRwhLIl/YMTX+5M2mcEPK/Rog80gcsB5H5hfj0Dcv1bNMs29+bdiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(71200400001)(86362001)(55016002)(6506007)(7696005)(9686003)(52536014)(53546011)(186003)(8936002)(4326008)(26005)(83380400001)(66946007)(76116006)(8676002)(7416002)(2906002)(33656002)(316002)(110136005)(966005)(54906003)(66556008)(64756008)(66476007)(66446008)(478600001)(5660300002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7ZJntGfikxW3OwLAsYiovBMtzJMIjJ21nrRUxjbFyZnBNCYTWkQ//3Jjp0qJ5SdvR1/n76R26q8UdXDeyEx1VhWHcA9e1fx5WXhB9JkaeoxmAyJetxGPxQMsf718voiV5tGxVCvcORi/Sq7R2SjXyXT26QAwW9/rVWDRnwK0aMc/X4mZLOPNizYmYpZHAM1hPx9hiFuw5GE5yfKUWDbp9eoAOeH6MjmjY1fvQ/obyAZdtWeukgP5slWKhasGf7ZrFc+d9vY+SNlc+WJWT28/iRi43P3a2DfkniD5iDU8WuuzM+3pi66Q07P9Vy5KNGlXVjM1ynegGNPBAX84bVDuXwz8MidjO+MrhtnG5QZ3auaewVUzTYVDblUHicCdZ//bvEFiKzgocRdqTS6B8rqxNPNilYvxJHJ11d94bC9yjE9lT6RUug+gNNiApeasDEAkYsbzY+1gxnWoxJ5pFdaRkGpq0cOYraS064b79M5MoYs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee1c90-5dd6-4fbf-0b65-08d82ef292b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 10:24:24.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKG5NdNY9piXUio+KHx+EsDCrz2uxXJhLEJTnixcHlUzHL02UsvKDKG9Va+cnPR/ECOfb7G0T7bxt4tCKsfMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2687
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wNy8yMyAxNzowNCBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+IHdyb3RlOiANCj4gSGkgUm9iaW4sDQo+IA0KPiBPbiAzMC4wNi4yMCAxNTozMSwg
Um9iaW4gR29uZyB3cm90ZToNCj4gPiBBZGQgJ2Z3X2xvYWRlZCcgYW5kICdpc19yYW1fc2NyaXB0
JyB0byBjaGVjayBpZiB0aGUgc2NyaXB0IHVzZWQgYnkNCj4gPiBjaGFubmVsIGlzIHJhbSBzY3Jp
cHQgYW5kIGl0J3MgbG9hZGVkIG9yIG5vdCwgc28gdGhhdCBjb3VsZCBwcmV2ZW50DQo+ID4gbWVh
bmluZ2xlc3MgZm9sbG93aW5nIG1hbGxvYyBkbWEgZGVzY3JpcHRvciBhbmQgYmQgYWxsb2NhdGUg
aW4NCj4gPiBzZG1hX3RyYW5zZmVyX2luaXQoKSwgb3RoZXJ3aXNlIG1lbW9yeSBtYXkgYmUgY29u
c3VtZWQgb3V0IHBvdGVudGlhbGx5DQo+ID4gd2l0aG91dCBmcmVlIGluIGNhc2UgdGhhdCBzcGkg
ZmFsbGJhY2sgaW50byBwaW8gd2hpbGUgZG1hIHRyYW5zZmVyDQo+ID4gZmFpbGVkIGJ5IHNkbWEg
ZmlybXdhcmUgbm90IHJlYWR5KG5leHQgRVJSMDA5MTY1IHBhdGNoIGRlcGVuZHMgb24gc2RtYQ0K
PiBSQU0gc2NyaXB0cy9maXJtd2FyZSkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBH
b25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+ID4gQWNrZWQtQnk6IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMTMg
KysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEv
aW14LXNkbWEuYyBpbmRleA0KPiA+IDU0MTFlMDFlLi5jZTFjODNlIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5j
DQo+ID4gQEAgLTM3OSw2ICszNzksNyBAQCBzdHJ1Y3Qgc2RtYV9jaGFubmVsIHsNCj4gPiAgIAll
bnVtIGRtYV9zdGF0dXMJCQlzdGF0dXM7DQo+ID4gICAJc3RydWN0IGlteF9kbWFfZGF0YQkJZGF0
YTsNCj4gPiAgIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJCXRlcm1pbmF0ZV93b3JrZXI7DQo+ID4gKwli
b29sCQkJCWlzX3JhbV9zY3JpcHQ7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICAjZGVmaW5lIElNWF9E
TUFfU0dfTE9PUAkJQklUKDApDQo+ID4gQEAgLTQ0Myw2ICs0NDQsNyBAQCBzdHJ1Y3Qgc2RtYV9l
bmdpbmUgew0KPiA+ICAgCXN0cnVjdCBzZG1hX2J1ZmZlcl9kZXNjcmlwdG9yCSpiZDA7DQo+ID4g
ICAJLyogY2xvY2sgcmF0aW8gZm9yIEFIQjpTRE1BIGNvcmUuIDE6MSBpcyAxLCAyOjEgaXMgMCov
DQo+ID4gICAJYm9vbAkJCQljbGtfcmF0aW87DQo+ID4gKwlib29sICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGZ3X2xvYWRlZDsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgc2Rt
YV9jb25maWdfd3JpdGUoc3RydWN0IGRtYV9jaGFuICpjaGFuLCBAQCAtOTI5LDYgKzkzMSw3DQo+
ID4gQEAgc3RhdGljIHZvaWQgc2RtYV9nZXRfcGMoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMs
DQo+ID4gICAJY2FzZSBJTVhfRE1BVFlQRV9TU0lfRFVBTDoNCj4gPiAgIAkJcGVyXzJfZW1pID0g
c2RtYS0+c2NyaXB0X2FkZHJzLT5zc2lzaF8yX21jdV9hZGRyOw0KPiA+ICAgCQllbWlfMl9wZXIg
PSBzZG1hLT5zY3JpcHRfYWRkcnMtPm1jdV8yX3NzaXNoX2FkZHI7DQo+ID4gKwkJc2RtYWMtPmlz
X3JhbV9zY3JpcHQgPSB0cnVlOw0KPiA+ICAgCQlicmVhazsNCj4gPiAgIAljYXNlIElNWF9ETUFU
WVBFX1NTSV9TUDoNCj4gPiAgIAljYXNlIElNWF9ETUFUWVBFX01NQzoNCj4gPiBAQCAtOTQzLDYg
Kzk0Niw3IEBAIHN0YXRpYyB2b2lkIHNkbWFfZ2V0X3BjKHN0cnVjdCBzZG1hX2NoYW5uZWwNCj4g
KnNkbWFjLA0KPiA+ICAgCQlwZXJfMl9lbWkgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPmFzcmNfMl9t
Y3VfYWRkcjsNCj4gPiAgIAkJZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5hc3JjXzJf
bWN1X2FkZHI7DQo+ID4gICAJCXBlcl8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+cGVyXzJf
cGVyX2FkZHI7DQo+ID4gKwkJc2RtYWMtPmlzX3JhbV9zY3JpcHQgPSB0cnVlOw0KPiA+ICAgCQli
cmVhazsNCj4gPiAgIAljYXNlIElNWF9ETUFUWVBFX0FTUkNfU1A6DQo+ID4gICAJCXBlcl8yX2Vt
aSA9IHNkbWEtPnNjcmlwdF9hZGRycy0+c2hwXzJfbWN1X2FkZHI7DQo+ID4gQEAgLTEzMzksNiAr
MTM0MywxMSBAQCBzdGF0aWMgc3RydWN0IHNkbWFfZGVzYw0KPiAqc2RtYV90cmFuc2Zlcl9pbml0
KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjLA0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBzZG1h
X2Rlc2MgKmRlc2M7DQo+ID4NCj4gPiArCWlmICghc2RtYWMtPnNkbWEtPmZ3X2xvYWRlZCAmJiBz
ZG1hYy0+aXNfcmFtX3NjcmlwdCkgew0KPiA+ICsJCWRldl9lcnIoc2RtYWMtPnNkbWEtPmRldiwg
InNkbWEgZmlybXdhcmUgbm90IHJlYWR5IVxuIik7DQo+ID4gKwkJZ290byBlcnJfb3V0Ow0KPiA+
ICsJfQ0KPiANCj4gSSB0cmllZCB5b3VyIHYxMCBwYXRjaGVzIG9uIG5leHQtMjAyMDA3MjIgd2l0
aCBpLk1YOE1NIGFuZCBpdCBtb3N0bHkNCj4gc2VlbXMgdG8gd29yayBmaW5lLg0KPiANCj4gV2hl
biBJIHRyaWVkIGZpcnN0LCBJIGhhZCB0aGUgaW14LXNkbWEgZHJpdmVyIGNvbXBpbGVkIGludG8g
dGhlIGtlcm5lbCwgc28gaXQNCj4gZGlkbid0IGxvYWQgdGhlIGZpcm13YXJlIGFuZCBmZWxsIGJh
Y2sgdG8gdGhlIFJPTSBzY3JpcHRzLg0KPiBXaXRoIHRoaXMsIFNQSSB0cmFuc2FjdGlvbnMgd29y
ayBqdXN0IGZpbmUsIGJ1dCBJIGdvdCB0aGUgYWJvdmUgZXJyb3IgbWVzc2FnZQ0KPiBwcmludGVk
IGNvbnRpbnVvdXNseSB3aGVuIHNlbmRpbmcgZGF0YSBpbiBTUEkzIHZpYSBzcGlkZXYuDQpUaGF0
J3MgY2F1c2VkIGJ5IHlvdSBkaWRuJ3QgbG9hZCByYW0gZmlybXdhcmUgYXMgdGhpcyBwYXRjaCBz
ZXQgZGVzY3JpYmVkLg0KUGxlYXNlIGZvbGxvdyBiZWxvdyBzdGVwcyB0byBsb2FkIGZpcm13YXJl
IG1hbnVhbGx5IGlmIHlvdSBkb24ndCB3YW50IHRvDQp1c2UgTlhQIG9mZmljaWFsIFlvY3RvIHJl
bGVhc2UgcGFja2FnZToNCg0KMS4gR2V0IHNkbWEgZmlybXdhcmUgZnJvbSBiZWxvdyBsaW51eC1m
aXJtd2FyZSBhbmQgY29weSBpdCB0byB5b3VyDQpsb2NhbCByb290ZnMgL2xpYi9maXJtd2FyZS9p
bXgvc2RtYS4NCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L2Zpcm13YXJlL2xpbnV4LWZpcm13YXJlLmdpdC90cmVlL2lteC9zZG1hDQoyLiBMb2FkIGZpcm13
YXJlIG1hbnVhbGx5Og0KICAgICAgICBlY2hvIDEgPiAvc3lzLyRERVZQQVRIL2xvYWRpbmcNCiAg
ICAgICAgY2F0ICRNWV9GV19ESVIvJEZJUk1XQVJFID4gL3N5cy8kREVWUEFUSC9kYXRhDQogICAg
ICAgIGVjaG8gMCA+IC9zeXMvJERFVlBBVEgvbG9hZGluZw0KUGxlYXNlIHJlZmVyIHRvIERvY3Vt
ZW50YXRpb24vZHJpdmVyLWFwaS9maXJtd2FyZS9mYWxsYmFjay1tZWNoYW5pc21zLnJzdA0KYW5k
IGxvYWQgdGhlIGZpcm13YXJlIGluIDYwcyAoZmlybXdhcmUgZmFsbGJhY2sgbG9hZGluZyB0aW1l
b3V0KSBmcm9tIGtlcm5lbA0KYm9vdCB1cC4NCg0KPiANCj4gV2hlbiBJIGJ1aWxkIGlteC1zZG1h
IGFzIGEgbW9kdWxlLCB0aGUgZmlybXdhcmUgaXMgbG9hZGVkIGNvcnJlY3RseSBhbmQNCj4gZXZl
cnl0aGluZyB3b3JrcyBhcyBleHBlY3RlZC4NCkkgZ3Vlc3MgdGhhdCdzIG5vdCByZWxhdGVkIHdp
dGggc2RtYSBidWlsZGluZyBhcyBtb2R1bGUuIElmIHNkbWEgYnVpbGQgYXMNCm1vZHVsZSwgc3Bp
IHdpbGwgZmFsbCB0byBwaW8gbW9kZSBhdCBzcGktaW14IGRyaXZlciBwcm9iZSBwaGFzZSBzbyB0
aGF0IHRoZSBhYm92ZQ0Kd2FybmluZyBsb2cgbmV2ZXIgdG8gYmUgd2Fsa2VkLiBXb3VsZCB5b3Ug
cGxlYXNlIGFkZCBzb21lIGRlYnVnIGluZm8gdG8gZG91YmxlDQpjb25maXJtPyAgDQo+IA0KPiBD
YW4geW91IGhhdmUgYSBsb29rIGF0IHRoaXMgYW5kIHByb3ZpZGUgYSBmaXg/DQo+IA0KPiBUaGFu
a3MsDQo+IEZyaWVkZXINCg==
