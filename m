Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1E3D8E0C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhG1MmV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 08:42:21 -0400
Received: from mail-eopbgr1400128.outbound.protection.outlook.com ([40.107.140.128]:32646
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234979AbhG1MmU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 08:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHHB8Yf+HCiusT4efsMJcybzNiXoyr/7S9PyH/G7h2B1dq97MzMD6HLfvdC2fbOaxB1cwznE381fIGGZHFSko/C2d0h/4//+ldGDjte6mDUFuicdwGq/CSj+AU605I6TgAEKhAqmHkMWwsr+xsMM7PcD4Ajh9O4yUSQ/5OtikxDi3xbgyp2VPi38zUL6LprL+rh1NOauTNJLsIY7D/ziNQ4ANxIqzscYmBulEObPS08xTCADcNCBBh9pyGmN//TT9q+mFH89c/qAWASNUNNFb1YEWs43RIR0uoPHRk8+tyn2GU8jyRnBl6X7VAsFMKSzV+ZuJcPV6kmHwjAv+xRk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxEyeFb5RX2KhT3gzLRO9epKqIF5a+753ZS5NJ3YeiI=;
 b=iuSkHRSUCiv0GSvxgJu8mwEj7z0QUDcHor8QREPYVlG61m7sIKMNgMSI4ixJRlOQPp6Z2QRPoDKc4+0eq2oMdkC255pxiCfPPYsaAOQEw3caH4nqb5E2qnyxuJ54XA0M4joiPbg3frc3PvOqCUeAanPl28BQuz+P17wJcW4H0T1eTtFkQRCe2pMXP+Iy7XLV7GH7qGL1sh2rvTC4uDhJC6X4ezlCMo7qCeghW3K8MGnkprAxn6vTsxRzcG4O47fU3UQjjm19AXBj59yaabi8mLUhnYqpE0FNxJQPEyMuSZo1DAQ43iodzd1jcsFCdF/YP0M8M71dFbNiC2wKjASXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxEyeFb5RX2KhT3gzLRO9epKqIF5a+753ZS5NJ3YeiI=;
 b=fXWS84Eczp5R+oElYfBZVvkelJU9cbvZqhhQenyKGZGCBhnN/pitjttSSsuDOwqRmMCtCSPArqCmZU6OB58UR3n5dIEqJkR7vjqQw2Vg+dLKhvDGy45xHahpMntU5m0tQnTMHWBn88tedxTAR8/MCK9/7ubC3inhmrt8rCpJCWo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 28 Jul
 2021 12:42:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%8]) with mapi id 15.20.4373.020; Wed, 28 Jul 2021
 12:42:15 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXfIANJc0R/9gnn0any8kXgzWfvKtW0BiAgAAIXJCAAR/AAIAABG1QgABLOICAAATp4IAAE+wAgAAA8cA=
Date:   Wed, 28 Jul 2021 12:42:14 +0000
Message-ID: <OS0PR01MB59220E0282D0EF21437B6EF786EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com> <YP/+r4HzCaAZbUWh@matsya>
 <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQD3FLN0YEVk6rnr@matsya>
 <OS0PR01MB59228D6F0AD7A51DAFFB512A86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQE542kiEGcYCCFO@matsya>
 <OS0PR01MB592222F26C8684E8D88DA55486EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUFr8FWk_i2hG3HJ1vTz7wjdHc=Sr8eYtzU20AwcA+2+g@mail.gmail.com>
In-Reply-To: <CAMuHMdUFr8FWk_i2hG3HJ1vTz7wjdHc=Sr8eYtzU20AwcA+2+g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfa22030-557d-4288-ead0-08d951c520e5
x-ms-traffictypediagnostic: OSYPR01MB5445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSYPR01MB5445BB1DDFFFBA09AEB45BE286EA9@OSYPR01MB5445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2eojJkKjXdGhuRRqZGiD/nXAupgRB1TjWRv+S9wWesZg0rmS9XfgqE1+nIDdPOgiNQqWUcGG75zgi20MAoQ/0JYRmnCYP1yTeA44ut2JUysFuAE1frJLpooKEEjWTO4LuHS/IKCZfPAeT6rEB88cPh5+dW8xlcza9xIN3HyGHTTFuEsyQlX6pWIx4koAPU2eNuFY7jcyMMPxchDPwjgjD+COY1/08C1TGa6KJ3keVv2wYnaZikR5dnsYmAEaI2qPpDhc42ERdBQXjcNLrxAX17GzU9lxq9TirN54PJSPFn0/WaucFiRXJxkL6jastuLYR4grqkvSP8Ew78f7anKFLGIVjSO60atn7cnhKV8w1zXKtVKmH9hCIbJzKkLQ/y9sZBeXCLAaLB8BWDP+QIIyxhtLm1A0/r/GRH0j6IzTLJoMUg0Uutj1GD/dmDu/bGMqH7pEc09MEiqgEHAp0a2hyAjBogPbKzjUCapZDYImTsjPjqIvKLev5AsI90maSdr/wfpDdu3awezYiaWMWxk8WC3CplZhcDeiT0Bf2v3lfAiXT0zYgKwVF46zj96s5BgrNRt8jlTb9WeFHom0eC6sadkBVrziNm+LQObkAt0yi8ilwjvh+HHZ9oB99vEGJqlcut6RRkFY63YdCyeh5852SD58vHVxf4EiDGsLU5MHX5HBzbeSSZMWR8xxYZz2qClWG6kh/HdhRVqc8BEBr833Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(136003)(396003)(376002)(122000001)(38100700002)(52536014)(76116006)(66476007)(6506007)(2906002)(66446008)(53546011)(86362001)(186003)(5660300002)(66556008)(26005)(7696005)(64756008)(66946007)(4326008)(54906003)(55016002)(33656002)(71200400001)(9686003)(8936002)(8676002)(83380400001)(316002)(478600001)(6916009)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRoR1U0czRQdEptK1Zib1FMTm1wNTFsN09sTldDZjVmdnYraXdWT3Q4dm9v?=
 =?utf-8?B?STdpYmZDdjg0bDJaWmNXeDBhbXZjUm5RYzZNY3R5czc5bGZlcnhrTUtWcnhx?=
 =?utf-8?B?RFhSSTNwVEpzNmkwZEsyaVB0ck9mZGFUNzE1YmRIWHdnSyt5S0x0dWVvWEYw?=
 =?utf-8?B?dVpqcEo5MzYwa3hsSmUvZG02TjFwd0ZDNExkb2hpeUc0c2U4dzMreFc4UjhZ?=
 =?utf-8?B?NjlaMEdVNmZRN1ljUG9kM244UUV5MGRXZExzckRpT3VEcVJMTk5QZHlIOFRD?=
 =?utf-8?B?QlFDaHZZSlYrYlhlbE5MRlFGWC94Qko2OWkrTFRjeGNmNGF2RytBM2hwZjdG?=
 =?utf-8?B?cXFzcWNvTFNsT3FuSmpHRzZCMkJKViszdDFDWEtRc01iYk5yU3U2Sld6RGNT?=
 =?utf-8?B?eEFNVVdZbFpvOGVrd2tMRGdvSUZ2VlpEUmZLQVo0N0lvM01FemFFSjBoS1JN?=
 =?utf-8?B?ZmNMNHBnSEdqVDUrUTJjK2hQU0Q4b3NqZEZJN3VSQyt4Y3BrcFFpdVBBMFA5?=
 =?utf-8?B?QlV2U1NZaVR3Q1RnSTZXUFZ3MlVlbVZmMGFNUjhxWlIxNkMwZHY4Y1JkamZX?=
 =?utf-8?B?Vk5zY3dmb1g4MmY3SmUrVjRvOVZQK2plRmhTUmRoZ0Jhb3AxeHRsYWcxK1Yw?=
 =?utf-8?B?NFBEa3NBSTdkdS83WWRiUWZHck93T3hQMVFQbEdCYXhMdDBKTGRoN2ZMKzFq?=
 =?utf-8?B?RExBMDZKcDRVTzFOTUpaNTFwQ2srcWZ6L2dheGFFdFJwZzZwR2VwNVU5aXNh?=
 =?utf-8?B?Y2VJL2t2U0J2N2ptOWc5Rno4VlJjMm9tVDN1U21yODFsRWNuRkRNZzBEVzZr?=
 =?utf-8?B?R1E3aEJmSldtZDBnck1YZWlySDUycWpxc0tiVDV6QlpvZ2N1MXdLallweXVN?=
 =?utf-8?B?RG9BTWtzVko1RjM5UlhMY0JjZXVJZmxnNnV2Wm1GS2Fwa3ZZMjd0aU51c3h6?=
 =?utf-8?B?Ti9rdVJWalM4MW54TzBaZU1zMkF3V2ZYL3VnaG91WE84M005ZWo0ZEEvNWtZ?=
 =?utf-8?B?OTZpUGszSUhSa0hTaU5yc1I1M0RMRCtKTTMrZGh4dXlPTWVlRmExMGkxQjhU?=
 =?utf-8?B?Ykk4UENlSktxZHEybkduaXRMcVFHa2hUMHBvb0tlOVY1ZEcydHcvTnZlKzNp?=
 =?utf-8?B?YWZqYStvRjkyQTMrcmorWUd0VXFFazNWSm1kU21MYURIK3JOTG5lK3MySWdD?=
 =?utf-8?B?WktFNjNHYTRYOHhJS2tjb3pZbnQweGtwY0JJdU1CSkZsMjdRVDBGc1R3Snkr?=
 =?utf-8?B?cHQ2RGl3b3hDZDRneU0yVCtBL1RkOXhmdlM3SkRFcnN2a0t2dWowdnh0YjNV?=
 =?utf-8?B?UmxIU1VVZGxZWmRxVXR5bDFTOGZxZWd1Nit2NWJrSzUrSnYvejc3RXRXRUs5?=
 =?utf-8?B?RVo1MWU4cjRha1FnQko0c2ZsSVFjWVFiWG9zN1N0MWtWT2N6OHBMTFI4VFlQ?=
 =?utf-8?B?bE5sd2Zib0tMc3o0dmMxY0crNTNlNDFXTCsybURrQ296Vkp3aWtHcFhoYXdl?=
 =?utf-8?B?OEhTbXByU2FiS0M3SGxlNm1meDRRR25tWWE4U2YxRy8wQ1NkUHVqSkt5N3o3?=
 =?utf-8?B?dzVjSGF3N3FRb3RDS2ZaQ1BiZzlSYktlOE1aT2FhRlFUaW9ub2FaY1grSzNI?=
 =?utf-8?B?TXBzSUp5V052RDlIeXdsNTV4UVlESHV5eFF0bldCNFQxbDVFamZlc0c2VWtL?=
 =?utf-8?B?c2V4dm53dHppZVhQMnJ3M2VZZHJ2S1A2eDl1ODNRZ2s3ek1GL09lNkV3bDBS?=
 =?utf-8?Q?5tl70Uy9WX1oqaWIDwD0UQcrWWsgVo3TjAuPgUG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa22030-557d-4288-ead0-08d951c520e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 12:42:14.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmAHqrdvtjh4pwFZeVROlRpVpxdpKjlmU7xNmeFsE/lKU0JtVc6KFgqfCnKE9+ATxtt1pw110TtVtdxV1Dvj6plsJtMyxSBpFYiiusbYHIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5445
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDI4IEp1bHkgMjAyMSAxMzozNA0KPiBUbzogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9y
Zz47IFByYWJoYWthciBNYWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJw
LnJlbmVzYXMuY29tPjsgQ2hyaXMgUGF0ZXJzb24NCj4gPENocmlzLlBhdGVyc29uMkByZW5lc2Fz
LmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IENocmlzIEJyYW5kdA0KPiA8Q2hyaXMu
QnJhbmR0QHJlbmVzYXMuY29tPjsgbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi80XSBkcml2ZXJzOiBkbWE6IHNoOiBBZGQgRE1BQyBk
cml2ZXIgZm9yIFJaL0cyTA0KPiBTb0MNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIEp1
bCAyOCwgMjAyMSBhdCAxOjU4IFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gd3JvdGU6DQo+ID4gPiBPbiAyOC0wNy0yMSwgMDc6MDAsIEJpanUgRGFzIHdyb3RlOg0K
PiA+ID4gPiA+IFNvcnJ5IEkgZG9udCBsaWtlIHBhc3NpbmcgbnVtYmVycyBsaWtlIHRoaXMgOigN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IENhbiB5b3UgZXhwbGFpbiB3aGF0IGlzIG1lYW50IGJ5IGVh
Y2ggb2YgdGhlIGFib3ZlIHZhbHVlcyBhbmQNCj4gPiA+ID4gPiBsb29rcyBsaWtlIHNvbWUgKGlm
IG5vdCBhbGwpIGNhbiBiZSBkZXJpdmVkIChzbGF2ZSBjb25maWcgYXMNCj4gPiA+ID4gPiB3ZWxs
IGFzIHRyYW5zYWN0aW9uDQo+ID4gPiA+ID4gcHJvcGVydGllcykNCj4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gMHgxMTIyOCAoVHgpDQo+ID4gPiA+IDB4MTEyMjAgKFJ4KQ0KPiA+ID4gPg0KPiA+
ID4gPiBCSVQgMjI6LSBUTSA6LSBUcmFuc2ZlciBNb2RlDQo+ID4gPg0KPiA+ID4gV2hhdCBhcmUg
dGhlIHZhbHVlcywgaGVyZSBpdCBzZWVtcyAwDQo+ID4NCj4gPiBZZXMsIHRoYXQgaXMgY29ycmVj
dCBzaW5nbGUgYml0LiAwIG1lYW5zIHNpbmdsZSB0cmFuc2ZlciBtb2RlLCAxIGJsb2NrDQo+IHRy
YW5zZmVyIG1vZGUuDQo+ID4NCj4gPiA+DQo+ID4gPiA+IEJpdHMgMTYtPjE5IDotIEREUyhEZXN0
aW5hdGlvbiBEYXRhIFNpemUpIC0tPiAweDAwMDEgKDE2IGJpdHMpDQo+ID4gPiA+IEJpdHMNCj4g
PiA+ID4gMTItPjE1IDotIFNEUyhTb3VyY2UgRGF0YSBzaXplKS0tPiAweDAwMDEgKDE2IGJpdHMp
DQo+ID4gPg0KPiA+ID4gdXNlIHNyY19hZGRyX3dpZHRoL2RzdF9hZGRyX3dpZHRoIC4uPw0KPiA+
DQo+ID4gV2Ugc3VwcG9ydCAxMjgsMjU2LDUxMiBhbmQgMTAyNCBiaXRzIGFzIHdlbGwuIEkgd2ls
bCBleHRlbmQgZW51bQ0KPiBkbWFfc2xhdmVfYnVzd2lkdGggdG8gc3VwcG9ydCB0aGlzIGluIGFu
b3RoZXIgcGF0Y2guDQo+ID4gSXMgaXQgb2s/DQo+ID4NCj4gPiA+DQo+ID4gPiA+IEJpdCAgMTEg
ICAgIDotIFJlc2VydmVkDQo+ID4gPiA+IEJpdHMgOC0+MTAgOi0gQWNrIG1vZGUgIC0tPiAweDAx
MCAoQnVzIGN5Y2xlIG1vZGUpDQo+ID4gPg0KPiA+ID4gV2hhdCBkb2VzIHRoaXMgbWVhbj8NCj4g
Pg0KPiA+IERNQUFDSyBvdXRwdXQgbW9kZSBpcyBjb21pbmcgZnJvbSBIVyBtYW51YWwsIEEgYmln
IHRhYmxlIG9mIGFyb3VuZCAyMzANCj4gZW50cmllcyBmb3Igb24gY2hpcCByZXF1ZXN0IHdpdGgg
ZGVkaWNhdGVkIHZhbHVlcyBmb3IgdGhlIGFib3ZlIGJpdHMuDQo+ID4NCj4gPiAweDAwMCAtLSBJ
bml0aWFsIHZhbHVlDQo+ID4gMHgwMDEgLS0gMDAxIChMRVZFTCBNb2RlKSAoMDAxIGZvciBNVFUs
UFdNLENBTiBldGNjYyAweDAxeCAtLSBCdXMNCj4gPiBjeWNsZSBtb2RlICgwMTAgZm9yIE9TVE0s
STJDLCBTU0lGKSAweDF4eCAtLSBETUFBQ0sgbm90IHRvDQo+ID4gb3V0cHV0KFNDSUYpDQo+ID4N
Cj4gPiA+DQo+ID4gPiA+IEJpdCA3IDotICBSZXNlcnZlZA0KPiA+ID4gPiBCaXQgNjotIExWTCAt
LT4gIExldmVsIC0tPjAgKERNQSByZXF1ZXN0IGJhc2VkIG9uIGVkZ2Ugb2YNCj4gPiA+ID4gdGhl
c2lnbmFsKSBCaXQgNTotIEhJRU4gLS0+ICBIaWdoIEVuYWJsZSAtLT4gMSAoRGV0ZWN0cyBhIERN
QQ0KPiA+ID4gPiByZXF1ZXN0IG9uIHJpc2luZyBlZGdlIG9mIHRoZSBzaWduYWwpIEJpdCA0Oi0g
TE9FTiAtLT4gTG93IEVuYWJsZQ0KPiA+ID4gPiAtLT4wIChEb2VzIG5vdCBETUEgcmVxdWVzdCBv
biBmYWxsaW5nIGVkZ2Ugb2YgdGhlIHNpZ25hbCkgQml0IDM6LQ0KPiA+ID4gPiBSRVFEIC0tPiBS
ZXF1ZXN0IERpcmVjdGlvbiAtPjEgKERNQVJFUSBpcyBEZXN0aW5hdGlvbikNCj4gPiA+DQo+ID4g
PiBob3cgYW5kIHdoYXQgZGVjaWRlcyB0aGVzZSB2YWx1ZXMNCj4gPiA+IEl0IGlzIG5vdyBoYXJk
Y29kZWQgaW4gdGhlIGNsaWVudCBkcml2ZXIsDQo+ID4NCj4gPiBJdCBpcyBTb0Mgc3BlY2lmaWMs
IGNvbWluZyBmcm9tIEhXIG1hbnVhbC4gRWFjaCBvbiBjaGlwIHBlcmlwaGVyYWwgaGFzDQo+IGl0
J3Mgb3duIHZhbHVlcy4NCj4gPiBFdmVuIHNvdXJjZSBhZGRyZXNzL0Rlc3RpbmF0aW9uIGFkZHJl
c3Mgb2YgdGhlIG9uIGNoaXAgbW9kdWxlIGlzIGFsc28NCj4gcGFydCBvZiB0aGF0IHRhYmxlLg0K
PiA+DQo+ID4gY2FuIHdlIGRvIHRoYXQgaW4gZG1hIGRyaXZlcg0KPiA+ID4gaW5zdGVhZD8gV2hp
bGUgZGVyaXZpbmcgbW9zdCBvZiB0aGUgdmFsdWVzPw0KPiA+DQo+ID4gSWYgd2UgYWRkIHRoaXMg
aW4gRE1BIGRyaXZlciwgaXQgd29uJ3QgYmUgZ2VuZXJpYy4gV2UgbmVlZCB0byBwcmVwYXJlDQo+
ID4gYSBiaWcgTFVUKGJhc2VkIG9uIE1JRCArUklEKSBmb3IgYWxsIHRoZSBwZXJpcGhlcmFscyBJ
ZiBTU0kgdGhlbiB1c2UgYQ0KPiB2YWx1ZSBmcm9tIExVVCwgU0NJRiB0aGVuIGFub3RoZXIgdmFs
dWUgbGlrZSB0aGF0Lg0KPiA+DQo+ID4gU28gcGxlYXNlIGxldCBtZSBrbm93IGhvdyBkbyB3ZSB3
YW50IHRvIHByb2NlZWQgaGVyZT8NCj4gDQo+IExvb2tzIGxpa2Ugd2Ugc2hvdWxkIHBhc3MgdGhp
cyBpbiB0aGUgZG1hcyBwcm9wZXJ0aWVzIGluIERUIGluc3RlYWQsDQo+IGVpdGhlciBieSBpbmNy
ZWFzaW5nICNkbWEtY2VsbHMsIG9yIGJ5IGVuY29kaW5nIGl0IHdpdGggdGhlIE1JRC9SSUQgdmFs
dWUNCj4gaW4gdGhlIGV4aXN0aW5nIGNlbGw/DQoNCkkgbGlrZSB0aGUgaWRlYSBvZiBlbmNvZGlu
ZyBpdCB3aXRoIE1JRC9SSUQgaW4gdGhlIGV4aXN0aW5nIGNlbGwuIEkgd2lsbCBwb3N0IG5leHQg
dmVyc2lvbiBiYXNlZCBvbiB0aGlzLg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+IEdye29ldGpl
LGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0t
DQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlh
MzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJz
YXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4g
QnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1l
ciIgb3Igc29tZXRoaW5nDQo+IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
