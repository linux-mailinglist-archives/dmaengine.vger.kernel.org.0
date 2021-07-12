Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8A3C41A0
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jul 2021 05:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhGLDXM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Jul 2021 23:23:12 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:26528
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229891AbhGLDXL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 11 Jul 2021 23:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjUMMxl//vnvsc8gn8K+RpQK4baxSoiqHaZJrSl4vpSYV4Grk/40cHqBsE1LEeUDrPbYLVIgNsCA2XRZLbDj/BYO9eKQG4vf0Tl8AaSGPsTxhryjpR/1/omFl/xNr0CTjApXmnCSWDqEsgn9bo9wcpmi4gl1CRmijG/4J5zTVomDgp7mY2pFcQr7iSolCFTbAKrVyELRqNRIaMfU2KCsh/JMq9xRbZZPUZUz/zXFlzBjDmRVbmz4iB0mGNSk/X2OG1F3sL09t1Phu6LgV57WBfTqgnrE0Bqu0rJylNeEsi8sVVXUHDiU/Knc30lKxUS/VAQsTAI5FIaEBkTkHMmofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEGARH2fzjdamk+p7UwO/VqlzX8Qn3GzYl85QdR8VUk=;
 b=XznDrAuv5AgQOFLTCKNrBOau+kYiM6t31Atbf+Nq9ruryFB9PjKWRPrPQlEzWQNjuzwLmpuFddK0GcY2rvCkd2//SBaYVAlBkraeAFBKPZ1ao/qziGbOM9GepRdakzqsjDkNfKH0+4Bs+JV8DuD4aN1SWNz04LgwpuD6U5Bad7zAFChuGzmmOw84uxSFM/tUI/XO/MdLizbwBoIimJn2DeHyx21p4/6pUXytuXmyphJSOwkDuohPGvOvzmkpWQ0DmqXhXt1WL2ha3jnnjtk/dXMkWgnF6Tb/fsbczYIXRQ5Um1cN6iux1at4X3vL2Y0OrTbpBNRZuFXb6P4ofa+HFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEGARH2fzjdamk+p7UwO/VqlzX8Qn3GzYl85QdR8VUk=;
 b=J/bJd0qmi4QDIZnQN72L+JRO3QU3TbEM1IuLdF/YosJDS185T3sAZnFatqt/4X15cxv56g9DL+MUyq0k1BLkueREZvzKw1BoURWye31JMolqXyZh3N2Rngb0QKiXg0H5INjXzsgT4zTHJkEl7pZKn9ElDxAhX8qRspDY0wwI380=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB5230.eurprd04.prod.outlook.com (2603:10a6:803:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.24; Mon, 12 Jul
 2021 03:20:21 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 03:20:21 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v14 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
Thread-Topic: [PATCH v14 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
Thread-Index: AQHXK33ekKAPURjLqUiGQriOVyH8wqs68YoAgARPjpA=
Date:   Mon, 12 Jul 2021 03:20:21 +0000
Message-ID: <VE1PR04MB668833FAAEEA2F5D0C076A6C89159@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-6-git-send-email-yibin.gong@nxp.com>
 <17cadf46f4a0f9771fdde1c9aba9ffecb20efc9f.camel@pengutronix.de>
In-Reply-To: <17cadf46f4a0f9771fdde1c9aba9ffecb20efc9f.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53ba5805-06c7-446e-551b-08d944e3fb35
x-ms-traffictypediagnostic: VI1PR04MB5230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB52308DA490FC62880257C59389159@VI1PR04MB5230.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fd4HsQuZhxkxaRpEJZ3rOCebVdx8AMUUkdz78k8+mZ8IiE8mRwTOQ/u8mDuaghnf37psCPCWzP5kpi5aQW5+ejniKop/s3EZK/MlO6PwSg90iaQrGFmotKIVm6cTjNjWv42v2Fm7SWYMgYfbXdd+MaFWs791IJ6BSLCKxyWi21gAhZS0xcqqFassSsBznMK/iJ7FGGb0UKYJ9HjVRVKXiclawfB7qaMjsk0whxGIDaVWvoJiyk1bRM67gTUTxRVSxbx+3UI4gKHqyYmKf8rDyCxGFhZzRSAplCDfyEfAozb8Qddi1YkDJUQiI/CLY+Q0jJd9OyD7oFX6gt0PiQpmYxeA6kPwoU73THGI55iZ6PdFOYqBOIfQfweISEgjtqYLkNrdj5WFuqAuarrT+1EB5bBY/G//jwtE1UMMkyRTGjoaGjBeDXMODRKEC93Ybuw8SfLLiSKyYy/Sa82fUp4Y9ZiIaYWNJINvFO/zTnDobtHw4bPHlYxX2npu26zjBiPrim4C0lw+kwVXHSk6ThUq7GsYlO8Er9qWB6ROYzW3OE5Ro4xm7EPnWiHEJGKi6bXLwqpvu0WSpMjhEPocFqPQYzaX/1/6w3T46sM1nv5NJGExYWbYHKnounaEEfPf2dE+M9rGjFvQXvi8+9N6INHvB5Dc4tJPC3J0CS2ClcGfsaE6EvAoyr4fvPZDlIRxk6IT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(38100700002)(66946007)(122000001)(55016002)(8936002)(7696005)(86362001)(921005)(26005)(5660300002)(52536014)(83380400001)(186003)(66556008)(66446008)(6636002)(64756008)(66476007)(53546011)(71200400001)(6506007)(478600001)(4326008)(8676002)(33656002)(316002)(110136005)(2906002)(54906003)(9686003)(76116006)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3VaRkRhMy9pa0doNmlETTM0VjJFaERkcDN2Z1JrN2dwYlVEOXZ4SFp3OXVC?=
 =?utf-8?B?OEZxWEFKelpMZ2U0NXFzM0pkN0dKaEZta2NEbnk0eVBxMFdMSGVmZmY4Rnh6?=
 =?utf-8?B?Ni9vTEpYQlFZMDd3VExIRHRNc0l1ejRGU2p6VU52ejc4OExabk9WdlBYdUdG?=
 =?utf-8?B?aDlteDlBM0VSaHBIOFJ6THVtVnV1WW5BdWdUU0NTRWc5UUhJc25MZ3c2RVBs?=
 =?utf-8?B?Z1dubFowR1BzWlQzcE5UaEV0Y0ZjWnltazBJWVNKclQ3dXFkaWlDd0pKY2lw?=
 =?utf-8?B?TVlrZnU3SXhoZGxVcVZGZjNoNTNQR3hoVU1RTUJBMUtyTkNrUXQyWHBVSld4?=
 =?utf-8?B?aUNKZ2dZa1I3cnhrZG5KQVFmdW5hbHQxb0ZFVXVjRHBGUGQxTFd5T1JKb2pl?=
 =?utf-8?B?Y2tDZEh5SXVWQzZpamZtQm1nRkt1SFFtbi9MRUFrdDhueG9NOG9Zb3hmYm9s?=
 =?utf-8?B?VkhBNGFiRG5JZUZtdmxZc1BncmNJVjZKNWpQbnhSOWRPQWx5cVlXRGVzNSsr?=
 =?utf-8?B?bDR0akd5b3ZVVmxKc0JmSnRYT0xzNysyVWpEbFhyNlV3NGxaU0NxbU9ISnB4?=
 =?utf-8?B?ZFRUMzB0YXJGdTFhQURFOFUyVWFlSlc4Y2xQSkVjZ2RBQUt3SjZxYTV2ZzF1?=
 =?utf-8?B?WFpKTXpGM3lJa2tSVlhneVcwTC8wb25ncUhRcExVeHp0ZnV1d1dIWGx5Ukdi?=
 =?utf-8?B?M0xHVzRLQjhGbHJMUUdSVEd5MEtLMXpRWDZ5UkdpUkRUZ05PTmlWVWI3RG5l?=
 =?utf-8?B?MmRyNTRRVEFnc01vREh2RElOMmlFTjc0bkxWZHYzZEJIc0FzUHA0YjM2MnFW?=
 =?utf-8?B?ZUhUdm9QRG5QOGkzTmVsQ3huRlNaVTZIVmlldE1JMVI3MzFZeHpwNkcyUmFV?=
 =?utf-8?B?S0hjQWFvcFpmN09RUVJ2TlNtRnQxL3NaUG5rdlJONzVrMGNtZGZnQ0ZFNm9l?=
 =?utf-8?B?T0doY3kwRzRGcG1MVFpFaFczVU92eVlDQjY2Wmo2bHdNUlJzN3pmSG9uMFUy?=
 =?utf-8?B?OWtyMVJmcHlqcjdTcVRFVEhoaVloL1BBQTNUWTR2Y0dqUEhjQmNYby9WeElo?=
 =?utf-8?B?akNRZkE4Q0ltcU9VMDRQQ2FXUWswWnZrMVlvajNPcHdZQWN6b21IdnJmWEhI?=
 =?utf-8?B?OU9xY0RNR1J4NmpaZHNiVTlGWXJlUGlnQnRpSzZLVTBpdThKenZqbERNemsw?=
 =?utf-8?B?bTlrU0RNR3JxcnhYWDdzK2xqTlpyN2M4VWcvTHdpOTgwbS9Xc2RONmFXZHgw?=
 =?utf-8?B?WDJiRWtad0huaENmRThHd1ZxTFpBeEszb084Mkk0NmpBTGEzUkY4SW5meXlo?=
 =?utf-8?B?Ti9mV2syODZYaFN2QkR2R0cxNG40MlJsUUxxUTAyZmRiUHNocEgxekU4Vmh2?=
 =?utf-8?B?WHh4bDhFUDROU0VyQWl2aU1NZmgyelViNUJuRHBrcStWQkw2SDIvL3pDZCsw?=
 =?utf-8?B?OGRyMk92Sys4TDNTeXFVSDdzZWVqMFRBVWMxVWFhN1ZHaDF0VS9ydkhCY3hu?=
 =?utf-8?B?ZzZPVFJVa2UzbU1qb2dmWkFWWGJvVGpyNWRIWlMyQWI1TmRmY0xOaEpWZElh?=
 =?utf-8?B?RlpwcDUvbm83Um9lUVIvZm92QTV5Y0ZLQjVObE1tZkpsZ2FlMGQyWTJORnha?=
 =?utf-8?B?UU11TVVPK1hic0w0QndwZmNYTDk2VU51YlJmTmxmYUNaa1B2dnlnVGFseHJu?=
 =?utf-8?B?Z3M0azNaTGIyd3JIc1BkVEdrQWcvTVhPS3NMR1N3Z3NrNlVSbm5ETnhNdmlS?=
 =?utf-8?Q?M3mGXZDVLoWRUOfD+t1B6YuvsZIu3o4blrGK7Sk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ba5805-06c7-446e-551b-08d944e3fb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 03:20:21.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kx7/zM554PKFotLTjiSPHQbBuYwuhsLqFp+u9Slim3MsNwnovVGYpMEQHfvNJT6rsARQ2p6y9UG1V/L5b9RhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5230
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMDkvMDcvMjEgMTc6MjUgTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+IHdy
b3RlOg0KPiBBbSBNaXR0d29jaCwgZGVtIDA3LjA0LjIwMjEgdW0gMjM6MzAgKzA4MDAgc2Nocmll
YiBSb2JpbiBHb25nOg0KPiA+IEFkZCAnZndfbG9hZGVkJyBhbmQgJ2lzX3JhbV9zY3JpcHQnIHRv
IGNoZWNrIGlmIHRoZSBzY3JpcHQgdXNlZCBieQ0KPiA+IGNoYW5uZWwgaXMgcmFtIHNjcmlwdCBh
bmQgaXQncyBsb2FkZWQgb3Igbm90LCBzbyB0aGF0IGNvdWxkIHByZXZlbnQNCj4gPiBtZWFuaW5n
bGVzcyBmb2xsb3dpbmcgbWFsbG9jIGRtYSBkZXNjcmlwdG9yIGFuZCBiZCBhbGxvY2F0ZSBpbg0K
PiA+IHNkbWFfdHJhbnNmZXJfaW5pdCgpLCBvdGhlcndpc2UgbWVtb3J5IG1heSBiZSBjb25zdW1l
ZCBvdXQgcG90ZW50aWFsbHkNCj4gPiB3aXRob3V0IGZyZWUgaW4gY2FzZSB0aGF0IHNwaSBmYWxs
YmFjayBpbnRvIHBpbyB3aGlsZSBkbWEgdHJhbnNmZXINCj4gPiBmYWlsZWQgYnkgc2RtYSBmaXJt
d2FyZSBub3QgcmVhZHkobmV4dCBFUlIwMDkxNjUgcGF0Y2ggZGVwZW5kcyBvbiBzZG1hDQo+IFJB
TSBzY3JpcHRzL2Zpcm13YXJlKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcg
PHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gPiBBY2tlZC1ieTogVmlub2QgS291bCA8dmtvdWxAa2Vy
bmVsLm9yZz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDEzICsrKysr
KysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNk
bWEuYyBpbmRleA0KPiA+IDFjNjM2ZDIuLjc4ZGNmZTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9kbWEvaW14LXNkbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4gPiBA
QCAtMzgxLDYgKzM4MSw3IEBAIHN0cnVjdCBzZG1hX2NoYW5uZWwgew0KPiA+ICAJZW51bSBkbWFf
c3RhdHVzCQkJc3RhdHVzOw0KPiA+ICAJc3RydWN0IGlteF9kbWFfZGF0YQkJZGF0YTsNCj4gPiAg
CXN0cnVjdCB3b3JrX3N0cnVjdAkJdGVybWluYXRlX3dvcmtlcjsNCj4gPiArCWJvb2wJCQkJaXNf
cmFtX3NjcmlwdDsNCj4gPiAgfTsNCj4gPg0KPiA+ICAjZGVmaW5lIElNWF9ETUFfU0dfTE9PUAkJ
QklUKDApDQo+ID4gQEAgLTQ0NCw2ICs0NDUsNyBAQCBzdHJ1Y3Qgc2RtYV9lbmdpbmUgew0KPiA+
ICAJc3RydWN0IHNkbWFfYnVmZmVyX2Rlc2NyaXB0b3IJKmJkMDsNCj4gPiAgCS8qIGNsb2NrIHJh
dGlvIGZvciBBSEI6U0RNQSBjb3JlLiAxOjEgaXMgMSwgMjoxIGlzIDAqLw0KPiA+ICAJYm9vbAkJ
CQljbGtfcmF0aW87DQo+ID4gKwlib29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZ3X2xv
YWRlZDsNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50IHNkbWFfY29uZmlnX3dyaXRlKHN0
cnVjdCBkbWFfY2hhbiAqY2hhbiwgQEAgLTg5OSw2ICs5MDEsNw0KPiA+IEBAIHN0YXRpYyB2b2lk
IHNkbWFfZ2V0X3BjKHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjLA0KPiA+ICAJY2FzZSBJTVhf
RE1BVFlQRV9TU0lfRFVBTDoNCj4gPiAgCQlwZXJfMl9lbWkgPSBzZG1hLT5zY3JpcHRfYWRkcnMt
PnNzaXNoXzJfbWN1X2FkZHI7DQo+ID4gIAkJZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJz
LT5tY3VfMl9zc2lzaF9hZGRyOw0KPiA+ICsJCXNkbWFjLT5pc19yYW1fc2NyaXB0ID0gdHJ1ZTsN
Cj4gPiAgCQlicmVhazsNCj4gPiAgCWNhc2UgSU1YX0RNQVRZUEVfU1NJX1NQOg0KPiA+ICAJY2Fz
ZSBJTVhfRE1BVFlQRV9NTUM6DQo+ID4gQEAgLTkxMyw2ICs5MTYsNyBAQCBzdGF0aWMgdm9pZCBz
ZG1hX2dldF9wYyhzdHJ1Y3Qgc2RtYV9jaGFubmVsDQo+ICpzZG1hYywNCj4gPiAgCQlwZXJfMl9l
bWkgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPmFzcmNfMl9tY3VfYWRkcjsNCj4gPiAgCQllbWlfMl9w
ZXIgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPmFzcmNfMl9tY3VfYWRkcjsNCj4gPiAgCQlwZXJfMl9w
ZXIgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPnBlcl8yX3Blcl9hZGRyOw0KPiA+ICsJCXNkbWFjLT5p
c19yYW1fc2NyaXB0ID0gdHJ1ZTsNCj4gPiAgCQlicmVhazsNCj4gPiAgCWNhc2UgSU1YX0RNQVRZ
UEVfQVNSQ19TUDoNCj4gPiAgCQlwZXJfMl9lbWkgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPnNocF8y
X21jdV9hZGRyOw0KPiA+IEBAIC0xMzA5LDYgKzEzMTMsMTEgQEAgc3RhdGljIHN0cnVjdCBzZG1h
X2Rlc2MNCj4gPiAqc2RtYV90cmFuc2Zlcl9pbml0KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFj
LCAgew0KPiA+ICAJc3RydWN0IHNkbWFfZGVzYyAqZGVzYzsNCj4gPg0KPiA+ICsJaWYgKCFzZG1h
Yy0+c2RtYS0+ZndfbG9hZGVkICYmIHNkbWFjLT5pc19yYW1fc2NyaXB0KSB7DQo+ID4gKwkJZGV2
X3dhcm5fb25jZShzZG1hYy0+c2RtYS0+ZGV2LCAic2RtYSBmaXJtd2FyZSBub3QgcmVhZHkhXG4i
KTsNCj4gPiArCQlnb3RvIGVycl9vdXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJZGVzYyA9IGt6
YWxsb2MoKHNpemVvZigqZGVzYykpLCBHRlBfTk9XQUlUKTsNCj4gPiAgCWlmICghZGVzYykNCj4g
PiAgCQlnb3RvIGVycl9vdXQ7DQo+ID4gQEAgLTE1NTksNiArMTU2OCw4IEBAIHN0YXRpYyBpbnQg
c2RtYV9jb25maWdfd3JpdGUoc3RydWN0IGRtYV9jaGFuDQo+ID4gKmNoYW4sICB7DQo+ID4gIAlz
dHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFuKTsNCj4gPg0KPiA+
ICsJc2RtYWMtPmlzX3JhbV9zY3JpcHQgPSBmYWxzZTsNCj4gPiArDQo+IFdoaWxlIGl0J3Mgd29y
a2luZyBjb3JyZWN0bHksIEkgZmluZCBpdCBjb25mdXNpbmcgdG8gaGF2ZSB0aGlzIGluaXRpYWxp
emF0aW9uIGF0IHRoaXMNCj4gcG9pbnQgaW4gdGhlIGNvZGUuIFBsZWFzZSBmb2xkIHRoaXMgaW50
byBzZG1hX2dldF9wYygpLCB3aGVyZSBpdCBnZXRzIGNoYW5nZWQgYXMNCj4gbmVlZGVkLg0KSGVy
ZSAnaXNfcmFtX3NjcmlwdCA9IGZhbHNlJyBqdXN0IGNsZWFyIGlzX3JhbV9zY3JpcHQgc28gdGhh
dCB0aGUgbGF0ZXIgc2RtYV9nZXRfcGMoKQ0KY291bGQgc2V0IGlzX3JhbV9zY3JpcHQgY29ycmVj
dGx5IGlmIGl0J3MgYSByYW0gc2NyaXB0LiBZZXMsIG1vdmUgaXQgdG8gZWFybHkgcGFydCBvZiBz
ZG1hX2dldF9wYw0KYWxzbyB3b3Jrcy4NCg0KPiANCj4gT3RoZXIgdGhhbiB0aGlzIHNtYWxsIGlz
c3VlLCB0aGlzIHBhdGNoIGlzOg0KPiBSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU+DQo+IA0KPiA+ICAJaWYgKGRpcmVjdGlvbiA9PSBETUFfREVWX1RPX01F
TSkgew0KPiA+ICAJCXNkbWFjLT5wZXJfYWRkcmVzcyA9IGRtYWVuZ2luZV9jZmctPnNyY19hZGRy
Ow0KPiA+ICAJCXNkbWFjLT53YXRlcm1hcmtfbGV2ZWwgPSBkbWFlbmdpbmVfY2ZnLT5zcmNfbWF4
YnVyc3QgKiBAQA0KPiAtMTczOCw2DQo+ID4gKzE3NDksOCBAQCBzdGF0aWMgdm9pZCBzZG1hX2xv
YWRfZmlybXdhcmUoY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdywNCj4gPiB2b2lkICpjb250ZXh0
KQ0KPiA+DQo+ID4gIAlzZG1hX2FkZF9zY3JpcHRzKHNkbWEsIGFkZHIpOw0KPiA+DQo+ID4gKwlz
ZG1hLT5md19sb2FkZWQgPSB0cnVlOw0KPiA+ICsNCj4gPiAgCWRldl9pbmZvKHNkbWEtPmRldiwg
ImxvYWRlZCBmaXJtd2FyZSAlZC4lZFxuIiwNCj4gPiAgCQkJaGVhZGVyLT52ZXJzaW9uX21ham9y
LA0KPiA+ICAJCQloZWFkZXItPnZlcnNpb25fbWlub3IpOw0KPiANCg0K
