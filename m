Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68D922AD49
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGWLMj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jul 2020 07:12:39 -0400
Received: from mail-am6eur05on2047.outbound.protection.outlook.com ([40.107.22.47]:37617
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbgGWLMj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Jul 2020 07:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aurfd7mrjR8H5tzakRdUlEFgQ9MqFOXGMwAUN9zAvvtpnW4M6MunwFGtbgy6v2Lr9NV3280EvTXBej44/xk7xniiljqEs57yGrHmpTS+DdtKlvqA2zVQDCii2eikbU372S4eGT2CmGCuVrJDxJgSKE4mrUJseM7WSS0V2Jr2cwek8fF02AJgW3ToifNTeLCgKzmWGjkUB9TEf3OPAMiyd6GT6pvZg+FMpAJD3xuf93RnQGYaLgRs5xZc++6dmvAKszbMKysi2qb3ea/8ZiJoLHvuJgYOw+6ATh/Ep12B1heTgOEldMD99k1qc8ZwRI/BtU2JKdHXHxAvK8meD2gokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz7Kzkho/TtPZDjlSali/hQOeErDU/+HCoNm5wKroDo=;
 b=SRR+O6JZulazOVxlmikZiZdeFtKYYJO8sAgH2vAsFRU5g55tv2S0s5/6hfPpz8NvN57n4uFoCDbyn82TLfB4id1S4rwQdAYHod9LZvcPvJoNc11Zdtfcg0arTwQ3MHeA7DurbY8Tuzuy8X6E4OFtZxzDLfoJxsjCCqE8qrePjTLUGPUic6TgK80nFlJp7t3Jeb98Ah18b92FwVN6+uIaEO6HfyFH0PzzFH2qTNLXDYDb94iBf2P+8iIKTAHOI7F9BH71A1Xeh4ah5yFUz4qeYrJAf6EEhZzU6+KBLs1j+V9/8TAXgIXA+xgmcznsJoSM1zdHm/UHbMVq/+8oZUks9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz7Kzkho/TtPZDjlSali/hQOeErDU/+HCoNm5wKroDo=;
 b=JOMcKi1Xl5JrpRVyH/Z1sGFWSrI3RD6lB2gWSB2tgBcKfqSeW0XwvMcQVC1FCEKVZhTV9FMiqV8WnW15pWqTHKH8vAqvek9gGCw9ujKe2V3sKKCp5D6oXYB5HNCD8hVwFvI+6FxImASxayr9AV5TGKbtXNBn7pAjVbJHL14uk0s=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2304.eurprd04.prod.outlook.com (2603:10a6:800:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 11:12:34 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 11:12:34 +0000
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
Thread-Index: AQHWTp7JbcJo/3lJ0kuBP+xQgJ1yA6kVAw+AgAAOScCAAAwKMA==
Date:   Thu, 23 Jul 2020 11:12:34 +0000
Message-ID: <VE1PR04MB6638BEA5C2594FEBFDE9318589760@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
 <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
 <1b04e4e6-ca26-3f45-e353-af81e03f85a7@kontron.de>
 <VE1PR04MB66385FC4FE591EAFA8CB7D8289760@VE1PR04MB6638.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB66385FC4FE591EAFA8CB7D8289760@VE1PR04MB6638.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f10d4a4-96c3-4fe6-1b45-08d82ef94ccd
x-ms-traffictypediagnostic: VI1PR0401MB2304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB230414832F6DC3A58B4166D289760@VI1PR0401MB2304.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOOsVy5mSJ55EWUs/2q53zEs1gD3WvBJhkUOraLlL04o1F3hY8KIsyzN33wgjR1RY5plQAIIiO7WhOjsmoIwAKBcg/F7Tv1fAvaPxxkUloFC0KJooveNgL9ChMCgFAccqDqYHDBe2/Jizk+PgYtFNiryN2az69ObvczRrLI45+SqraKOaAdzgu8h3iYiiMoJ9v3Bg3eaCE/64jqOePnwVqfcZLpZMPEI7ubUxOFGAcspV+7IPNKEL1ifqUoYwhMxRqPaS1B/LtrC6xIrrSrtoG+HYFqQqmGZHYrS+D0dnDBH3q353ebnAkBM18nXY0Gtrxr9Xe3nJsf+3mX5d/dIXOSWix657wmW19l22S8QtuUSvF79+eURhaUR95qNIpFjZmv0WScZm1nltvU9JYTcw0y5f1U3+smf/RDRLpjAsWvz4RnkTJMIe7HheTxws73fYJTssS/lxFj2O26wrRJinA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(71200400001)(86362001)(8936002)(53546011)(55016002)(186003)(52536014)(7696005)(9686003)(6506007)(83380400001)(26005)(66946007)(76116006)(8676002)(4326008)(2906002)(7416002)(110136005)(33656002)(316002)(966005)(64756008)(5660300002)(66446008)(66556008)(66476007)(54906003)(2940100002)(478600001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BIpUQec4ubYX129YeOhHzJsoMcc/km645vegFdjSqAt7YzXvIjBGRAaF7xfll0iyQ4uMn/A5+AiRNG0YlTCf6TPmYxNsr2rKkVd2trVLQChxXPi4avYdeZN5a/5DLd26tuTQwqGufGxOagaWygeIcaljuq19Kd7K7agzQdafskP5ULP6jrP7CCB6Vjlx86NRGLXogyOmg9SDaizRNGe6OiimngFXrD9SgjmWtksgtwozwaerlLL7EWON45LB2EmO5xW2K+ySxi8an1zZOEJngKnWXWXswL9z7J6YuoXkrw2VMzLqVf499EkGG18zqOV7vOtuNgdmfigIPMsWkuSGWAPjty27KHF9vcNHoyg9y0WpbVh7YKa0Y5KidEZbN91w4mZTItDEcMSIzHyzu2obKI8lMxZc+xkhquMR81lvpJ5NWLyjcqbKcqKeIhsah3TFb0rJpbQe5YKx34B2JE0SoPuO8k/UYfMSs0h2ZKuOn/s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f10d4a4-96c3-4fe6-1b45-08d82ef94ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 11:12:34.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7r18d40lYG8Fs2gJbGyBf+DU9GZF1j6Sba5Lv4AMB3C6rzTl58FgNJnOABFmvNaqDFEAwT3FqCFlIBf2GaF1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2304
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAyMDIwLzA3LzIzIDE3OjA0IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZA
a29udHJvbi5kZT4NCj4gd3JvdGU6DQo+ID4gSGkgUm9iaW4sDQo+ID4NCj4gPiBPbiAzMC4wNi4y
MCAxNTozMSwgUm9iaW4gR29uZyB3cm90ZToNCj4gPiA+IEFkZCAnZndfbG9hZGVkJyBhbmQgJ2lz
X3JhbV9zY3JpcHQnIHRvIGNoZWNrIGlmIHRoZSBzY3JpcHQgdXNlZCBieQ0KPiA+ID4gY2hhbm5l
bCBpcyByYW0gc2NyaXB0IGFuZCBpdCdzIGxvYWRlZCBvciBub3QsIHNvIHRoYXQgY291bGQgcHJl
dmVudA0KPiA+ID4gbWVhbmluZ2xlc3MgZm9sbG93aW5nIG1hbGxvYyBkbWEgZGVzY3JpcHRvciBh
bmQgYmQgYWxsb2NhdGUgaW4NCj4gPiA+IHNkbWFfdHJhbnNmZXJfaW5pdCgpLCBvdGhlcndpc2Ug
bWVtb3J5IG1heSBiZSBjb25zdW1lZCBvdXQNCj4gPiA+IHBvdGVudGlhbGx5IHdpdGhvdXQgZnJl
ZSBpbiBjYXNlIHRoYXQgc3BpIGZhbGxiYWNrIGludG8gcGlvIHdoaWxlDQo+ID4gPiBkbWEgdHJh
bnNmZXIgZmFpbGVkIGJ5IHNkbWEgZmlybXdhcmUgbm90IHJlYWR5KG5leHQgRVJSMDA5MTY1IHBh
dGNoDQo+ID4gPiBkZXBlbmRzIG9uIHNkbWENCj4gPiBSQU0gc2NyaXB0cy9maXJtd2FyZSkuDQo+
ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29t
Pg0KPiA+ID4gQWNrZWQtQnk6IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+ID4gPiAt
LS0NCj4gPiA+ICAgZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDEzICsrKysrKysrKysrKysNCj4g
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMg
aW5kZXgNCj4gPiA+IDU0MTFlMDFlLi5jZTFjODNlIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9kbWEvaW14LXNkbWEuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiA+
ID4gQEAgLTM3OSw2ICszNzksNyBAQCBzdHJ1Y3Qgc2RtYV9jaGFubmVsIHsNCj4gPiA+ICAgCWVu
dW0gZG1hX3N0YXR1cwkJCXN0YXR1czsNCj4gPiA+ICAgCXN0cnVjdCBpbXhfZG1hX2RhdGEJCWRh
dGE7DQo+ID4gPiAgIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJCXRlcm1pbmF0ZV93b3JrZXI7DQo+ID4g
PiArCWJvb2wJCQkJaXNfcmFtX3NjcmlwdDsNCj4gPiA+ICAgfTsNCj4gPiA+DQo+ID4gPiAgICNk
ZWZpbmUgSU1YX0RNQV9TR19MT09QCQlCSVQoMCkNCj4gPiA+IEBAIC00NDMsNiArNDQ0LDcgQEAg
c3RydWN0IHNkbWFfZW5naW5lIHsNCj4gPiA+ICAgCXN0cnVjdCBzZG1hX2J1ZmZlcl9kZXNjcmlw
dG9yCSpiZDA7DQo+ID4gPiAgIAkvKiBjbG9jayByYXRpbyBmb3IgQUhCOlNETUEgY29yZS4gMTox
IGlzIDEsIDI6MSBpcyAwKi8NCj4gPiA+ICAgCWJvb2wJCQkJY2xrX3JhdGlvOw0KPiA+ID4gKwli
b29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZ3X2xvYWRlZDsNCj4gPiA+ICAgfTsNCj4g
PiA+DQo+ID4gPiAgIHN0YXRpYyBpbnQgc2RtYV9jb25maWdfd3JpdGUoc3RydWN0IGRtYV9jaGFu
ICpjaGFuLCBAQCAtOTI5LDYNCj4gPiA+ICs5MzEsNyBAQCBzdGF0aWMgdm9pZCBzZG1hX2dldF9w
YyhzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYywNCj4gPiA+ICAgCWNhc2UgSU1YX0RNQVRZUEVf
U1NJX0RVQUw6DQo+ID4gPiAgIAkJcGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5zc2lz
aF8yX21jdV9hZGRyOw0KPiA+ID4gICAJCWVtaV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+
bWN1XzJfc3Npc2hfYWRkcjsNCj4gPiA+ICsJCXNkbWFjLT5pc19yYW1fc2NyaXB0ID0gdHJ1ZTsN
Cj4gPiA+ICAgCQlicmVhazsNCj4gPiA+ICAgCWNhc2UgSU1YX0RNQVRZUEVfU1NJX1NQOg0KPiA+
ID4gICAJY2FzZSBJTVhfRE1BVFlQRV9NTUM6DQo+ID4gPiBAQCAtOTQzLDYgKzk0Niw3IEBAIHN0
YXRpYyB2b2lkIHNkbWFfZ2V0X3BjKHN0cnVjdCBzZG1hX2NoYW5uZWwNCj4gPiAqc2RtYWMsDQo+
ID4gPiAgIAkJcGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5hc3JjXzJfbWN1X2FkZHI7
DQo+ID4gPiAgIAkJZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5hc3JjXzJfbWN1X2Fk
ZHI7DQo+ID4gPiAgIAkJcGVyXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5wZXJfMl9wZXJf
YWRkcjsNCj4gPiA+ICsJCXNkbWFjLT5pc19yYW1fc2NyaXB0ID0gdHJ1ZTsNCj4gPiA+ICAgCQli
cmVhazsNCj4gPiA+ICAgCWNhc2UgSU1YX0RNQVRZUEVfQVNSQ19TUDoNCj4gPiA+ICAgCQlwZXJf
Ml9lbWkgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPnNocF8yX21jdV9hZGRyOw0KPiA+ID4gQEAgLTEz
MzksNiArMTM0MywxMSBAQCBzdGF0aWMgc3RydWN0IHNkbWFfZGVzYw0KPiA+ICpzZG1hX3RyYW5z
ZmVyX2luaXQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMsDQo+ID4gPiAgIHsNCj4gPiA+ICAg
CXN0cnVjdCBzZG1hX2Rlc2MgKmRlc2M7DQo+ID4gPg0KPiA+ID4gKwlpZiAoIXNkbWFjLT5zZG1h
LT5md19sb2FkZWQgJiYgc2RtYWMtPmlzX3JhbV9zY3JpcHQpIHsNCj4gPiA+ICsJCWRldl9lcnIo
c2RtYWMtPnNkbWEtPmRldiwgInNkbWEgZmlybXdhcmUgbm90IHJlYWR5IVxuIik7DQo+ID4gPiAr
CQlnb3RvIGVycl9vdXQ7DQo+ID4gPiArCX0NCj4gPg0KPiA+IEkgdHJpZWQgeW91ciB2MTAgcGF0
Y2hlcyBvbiBuZXh0LTIwMjAwNzIyIHdpdGggaS5NWDhNTSBhbmQgaXQgbW9zdGx5DQo+ID4gc2Vl
bXMgdG8gd29yayBmaW5lLg0KPiA+DQo+ID4gV2hlbiBJIHRyaWVkIGZpcnN0LCBJIGhhZCB0aGUg
aW14LXNkbWEgZHJpdmVyIGNvbXBpbGVkIGludG8gdGhlDQo+ID4ga2VybmVsLCBzbyBpdCBkaWRu
J3QgbG9hZCB0aGUgZmlybXdhcmUgYW5kIGZlbGwgYmFjayB0byB0aGUgUk9NIHNjcmlwdHMuDQo+
ID4gV2l0aCB0aGlzLCBTUEkgdHJhbnNhY3Rpb25zIHdvcmsganVzdCBmaW5lLCBidXQgSSBnb3Qg
dGhlIGFib3ZlIGVycm9yDQo+ID4gbWVzc2FnZSBwcmludGVkIGNvbnRpbnVvdXNseSB3aGVuIHNl
bmRpbmcgZGF0YSBpbiBTUEkzIHZpYSBzcGlkZXYuDQo+IFRoYXQncyBjYXVzZWQgYnkgeW91IGRp
ZG4ndCBsb2FkIHJhbSBmaXJtd2FyZSBhcyB0aGlzIHBhdGNoIHNldCBkZXNjcmliZWQuDQo+IFBs
ZWFzZSBmb2xsb3cgYmVsb3cgc3RlcHMgdG8gbG9hZCBmaXJtd2FyZSBtYW51YWxseSBpZiB5b3Ug
ZG9uJ3Qgd2FudCB0byB1c2UNCj4gTlhQIG9mZmljaWFsIFlvY3RvIHJlbGVhc2UgcGFja2FnZToN
Cj4gDQo+IDEuIEdldCBzZG1hIGZpcm13YXJlIGZyb20gYmVsb3cgbGludXgtZmlybXdhcmUgYW5k
IGNvcHkgaXQgdG8geW91ciBsb2NhbA0KPiByb290ZnMgL2xpYi9maXJtd2FyZS9pbXgvc2RtYS4N
Cj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZmlybXdh
cmUvbGludXgtZmlybXdhcmUuZ2l0L3QNCj4gcmVlL2lteC9zZG1hDQo+IDIuIExvYWQgZmlybXdh
cmUgbWFudWFsbHk6DQo+ICAgICAgICAgZWNobyAxID4gL3N5cy8kREVWUEFUSC9sb2FkaW5nDQo+
ICAgICAgICAgY2F0ICRNWV9GV19ESVIvJEZJUk1XQVJFID4gL3N5cy8kREVWUEFUSC9kYXRhDQo+
ICAgICAgICAgZWNobyAwID4gL3N5cy8kREVWUEFUSC9sb2FkaW5nDQo+IFBsZWFzZSByZWZlciB0
byBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZmlybXdhcmUvZmFsbGJhY2stbWVjaGFuaXNtcy5y
c3QNCj4gYW5kIGxvYWQgdGhlIGZpcm13YXJlIGluIDYwcyAoZmlybXdhcmUgZmFsbGJhY2sgbG9h
ZGluZyB0aW1lb3V0KSBmcm9tIGtlcm5lbA0KPiBib290IHVwLg0KPiANCj4gPg0KPiA+IFdoZW4g
SSBidWlsZCBpbXgtc2RtYSBhcyBhIG1vZHVsZSwgdGhlIGZpcm13YXJlIGlzIGxvYWRlZCBjb3Jy
ZWN0bHkNCj4gPiBhbmQgZXZlcnl0aGluZyB3b3JrcyBhcyBleHBlY3RlZC4NCj4gSSBndWVzcyB0
aGF0J3Mgbm90IHJlbGF0ZWQgd2l0aCBzZG1hIGJ1aWxkaW5nIGFzIG1vZHVsZS4gSWYgc2RtYSBi
dWlsZCBhcw0KPiBtb2R1bGUsIHNwaSB3aWxsIGZhbGwgdG8gcGlvIG1vZGUgYXQgc3BpLWlteCBk
cml2ZXIgcHJvYmUgcGhhc2Ugc28gdGhhdCB0aGUNCj4gYWJvdmUgd2FybmluZyBsb2cgbmV2ZXIg
dG8gYmUgd2Fsa2VkLiBXb3VsZCB5b3UgcGxlYXNlIGFkZCBzb21lIGRlYnVnDQo+IGluZm8gdG8g
ZG91YmxlIGNvbmZpcm0/DQpIaSBGcmlkZXIsDQoJUGxlYXNlIGlnbm9yZSB0aGlzIGNvbW1lbnQs
IHNpbmNlIHRoZXJlIGlzIC1FUFJPQkVfREVGRVIgY2hlY2tpbmcNCiwgc28geW91IGxvYWQgc2Rt
YSBmaXJtd2FyZSBieSBidWlsZGluZyBzZG1hIGRyaXZlciBhcyBtb2R1bGUgaW5zdGVhZCBvZg0K
dGhlIGFib3ZlIGNvbW1lbnQgSSBtZW50aW9uZWQ/IFRoZSB3YXJuaW5nIGxvZyBjb21lcyBvdXQg
ZHVyaW5nIHNwaQ0KdHJhbnNmZXIgc3RhcnQgYW5kIHNkbWEgZmlybXdhcmUgbG9hZGluZyBkb25l
LCBidXQgaWYgc2RtYSBkcml2ZXIgYnVpbGRpbmcgYXMNCm1vZHVsZSBjb3VsZCBlbnN1cmUgZmly
bXdhcmUgbG9hZGluZyBkb25lIGluIHNkbWFfZHJpdmVyX3Byb2JlX3BoYXNlLT4NCnNwaV9pbXhf
cHJvYmVfcGhhc2UsIHdoaWNoIG1lYW5zIHNkbWEgZmlybXdhcmUgbG9hZGluZyBoYXMgYmVlbiBy
ZWFkeQ0KYmVmb3JlIHNwaSB0cmFuc2ZlciBzdGFydCwgaGVuY2Ugbm8gc3VjaCB3YXJuaW5nIG1l
c3NhZ2UuDQoNCkJ1dCBJIGFtIG5vdCBzdXJlIGlmIGFsbCBjbGllbnQgZHJpdmVycyBleGNlcHQg
c3BpIGFyZSBpbiBnb29kIHNoYXBlIHRvIHN1cHBvcnQNCicgQ09ORklHX0lNWF9TRE1BPW0gJy4g
QmVzaWRlcywgZG8geW91IHRoaW5rICdkZXZfZXJyX29uY2UgJyBpbnN0ZWFkIG9mICdkZXZfZXJy
JyBpcyBva2F5IGZvciB5b3U/DQogDQo=
