Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B16F3A4974
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKTfw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 15:35:52 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:7609
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229633AbhFKTfv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Jun 2021 15:35:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INPynFX9Ph51GJtnNrNcI7y//eajbLyjfJidcsNw6lSrzL0LAlRPBqZwvrd1E3ZxrM0SwQ6GJcVFGLohfm2JqwquoYYm1zQkURRfanWzq2lWpCRTHn93xNCP6euMpLxWxhGTgJkW/o8l5GNdcdlm1qjp7geO0MUJI+wrp1ySl8kXsj1SrVnNjbVhfoQqSSX9BSnuHwIXVHmNDvx+iE3J2wdSIdJzf3vcP3EQp9Im8MHY151tsrn61MyK166BooLb8jOiq7RKJ+zgQWfSJ7rVs/trS/Y+Tj3/fOjlW2cSV1KkF+vovBWpMOwQrva/6oGmL3hc0yuL1BOYDDufxGQ2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42OxHiua5a46NCitaCoC0V2/kInWTYLMAw2F4YsUeis=;
 b=YNhL/gw+lO23UB1qyDAKKq84P7CCnikmnxoUgduDKvf0rtSlje3SsFrs3mZrs4IjcBE1OBvb8kv5xI6PBDkN84/1lRF9wNClYusOF47ZjHlaKOm+NXaycbYpwx9YdjpFHWDTJoVXPHZ42k16f9l4NJpQA6SD9E7Gcpfn7eRqPnAo7VOU0UbLW8ZhOucRKvk3jUrM6TObQNGXdTzx1jVFPPaQ0FySvy/r3Q0uEOIR/XsR8I2o2IYEhB/awqLKD6KOCMNCudlK3NVJxPgZr5pOdnCuqZTNT//eA3uE9wzWaDopiJJeq/nXD10wW/prK4BsBDNXMkcrWq5vsBd5mY3GdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42OxHiua5a46NCitaCoC0V2/kInWTYLMAw2F4YsUeis=;
 b=sLoTIdqFAzs3ajmoSKI7AYPUeu4EevlAjPpjEaX5s2UNF/4OGhH3/IDDbz0/aAPJv7LfJCfhoJKc7VYDWCNkZvphWyN6JJisqZzdIX4+f3z1QGiUgACpoicE344PBB44rW8CnPT3f5pLLhzPOvBsiId9wHskVJWU43pfEgB5AfU=
Received: from BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8)
 by SJ0PR02MB7405.namprd02.prod.outlook.com (2603:10b6:a03:29f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 11 Jun
 2021 19:33:49 +0000
Received: from BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798]) by BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798%5]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 19:33:49 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [RFC v2 PATCH 7/7] dmaengine: xilinx_dma: Program interrupt delay
 timeout
Thread-Topic: [RFC v2 PATCH 7/7] dmaengine: xilinx_dma: Program interrupt
 delay timeout
Thread-Index: AQHXLWngzvQLpEib4UGvbcGStfFKLaq1OF+AgFpUkEA=
Date:   Fri, 11 Jun 2021 19:33:49 +0000
Message-ID: <BY5PR02MB652001BCA69400852A361252C7349@BY5PR02MB6520.namprd02.prod.outlook.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-8-git-send-email-radhey.shyam.pandey@xilinx.com>
 <2985f8ac-ae2c-c142-f2d6-c5051bd6bfb2@metafoo.de>
In-Reply-To: <2985f8ac-ae2c-c142-f2d6-c5051bd6bfb2@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b3721c-9634-4a9f-8cab-08d92d0fd66b
x-ms-traffictypediagnostic: SJ0PR02MB7405:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB7405CD80CDD12DD52233450FC7349@SJ0PR02MB7405.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYYoTDZn3cKLvOROrXHldN4yVN4/yZVbW9Gi8ajCTIRxmoTSAQD2xQ5tgNSrWnHk/2DdZ2qCdnvU64ORZc9jkcr/6kLFeIy5Nsf4jvTrq+5wNXjzMbffB44vcw0HQOUhdEHy83WfIeXwIUmUavWjsEEIslfvazBp4wQX7klnOVHgx0Znj8QYRZENyOfOpEEjoUc9RYiv949fc9teObjQmyz94GZhLe1+gy0FMXmWkrkQU1utFaya+yA+vnofP0jkv/T25KcRCt8HZ2W2Xx59gpgmX4uKaoMEYzNh3DoFzdX3Q0XHpnyNxkPui3C5uhvh+vXovRMhHAD4TbjKLylVriZQHxa6S8Z15qKv84pntG+QWKMREBEH8m+Fq/IV5sNIrpbhYjrMQ20aXPlcPvLWXG5fiquJPT+k+0wq8TceBJtt4hqaX/BdfwKT43Ga9nzBL66TLxOB6BHLGBtOoF7A274szGfvKsPveCcENdWrnSa6Vs29WpbbT8VvVZsUZCp0QauXhQIc89OCqKSLexrLy2rwyP3N+hCgZVNJVPW0V2dWB892WMsjsw/dBm4dlXei5B/mD6Ia2Cvjh87IOi85Av2zJQU7jalmeQkpymVTBto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6520.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(52536014)(83380400001)(316002)(478600001)(107886003)(38100700002)(33656002)(6636002)(71200400001)(7696005)(110136005)(4326008)(6506007)(53546011)(122000001)(186003)(54906003)(66446008)(66476007)(8676002)(8936002)(26005)(66946007)(76116006)(55016002)(64756008)(2906002)(9686003)(5660300002)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azkvSTcxbDB4b0xLQno4YUVKSW43SG9hTWY5dEEra0NDcFQybG9QNng2VDI4?=
 =?utf-8?B?dWJ1YmlYSWJocDg4Q3k3Rnd3bHlLSDBHYUJGcGNUTzhyWVhZbnFZQ0VQaWl2?=
 =?utf-8?B?a25hTUhiRnhBY0JBMDVoaFg2Qm4ybDZsOTRyMVhZc1YxcjQ1K3YvbVBYNzZS?=
 =?utf-8?B?OEZ1QStaTHgwQ0MvVW9tdmVJcFBuaVZpN3plNW4xNTdTdjZ1dllmcHd1RW9Y?=
 =?utf-8?B?VElDVHl0ZHdjVW1VaTJQV2w0OWE5QVIySTJqeU9hMys2MkNuWDRITXg1RDlQ?=
 =?utf-8?B?dHBBL2xEUUVFR3F2aGdYeTF5SzBVSjByRExTc201TFIyMEVwYkxLMVFkajJW?=
 =?utf-8?B?Wno5dWhMYU5zVUZreCs2TEZ5TXJDcGlRS0srUWk5RHJJTXNPWjFOc2pRUWdF?=
 =?utf-8?B?LzJEYXRtRmpIQ3lNVTFRT1IxazNzQXh4MERzZ0UzNzFqd2ZaWmRqSXdXcnFu?=
 =?utf-8?B?K2VLTWN1SGd3WXMzTDdBQ2wyRythenk0MEM0WjIxaXhzd1RmUENNeTJlTS9o?=
 =?utf-8?B?Sk8wZVBianNlVEliSlA2bzJYeXNQSnhKd0lqYTVvbGdZWk8raHp3MGorb3I3?=
 =?utf-8?B?OGZDVXJGWXQ0OU45c1E3ZU45RExlV293eHRnZEdySStCczlwRjA0R3ZCRmFp?=
 =?utf-8?B?a0xTREtHWlVQSC9MOE94U25LbEI3NlJ1MlgxcU4rV3ZjSkczWGs1cHhKa0hU?=
 =?utf-8?B?eHBCRkxzRGhDVlpqTXhSczdUTzhJNlpwSFJMNWdvaUpqajRxbEUzemY4azl2?=
 =?utf-8?B?WjRLLyt3a2JadGJSWE1STEluQU96NEFKZ0VsU3VPM3NSTncyUXU0aGlYRENs?=
 =?utf-8?B?TkUxVTIxWS9DZUozenkzSnV2UlNjb2N2ZEUvK3NxUDZqMVU5TGlaeGZFak01?=
 =?utf-8?B?dEZwQ0RUa0svRHladUVOb0JMRlg1SW5qcmlyYk9JRGphenpBRlZDUjNoU0dz?=
 =?utf-8?B?NTllYnAvUVZiYjkzNkg5YmhoejZYQ3FLTnFxbUhubEVVeXF2U2RsMVBraStq?=
 =?utf-8?B?NU93bHFmMjd0VDlDbmtVVTc5dUlURjFyM21wZUM3TmlDVXYvaDFLNXl4eTMr?=
 =?utf-8?B?RU9rc2NXRnlDdG5qQTdMbjdnWGxhU3QwWlAxYUYyK1J2Sm9WWFhkRW9pUkQ0?=
 =?utf-8?B?NXVTK2ZmejJOeXVkSnhnWFB1cEVEWmJva2hUZlBwUUtYLzVjTEVOUk13YXc4?=
 =?utf-8?B?RG1pSVc3VkRvcjVPaFVUeTU1UlNyUXZTQVMxY2NGdHExMGVaQ3ZrWjdEK1Av?=
 =?utf-8?B?Q3hham12MFY3YmlmNjdPT01lVW0rZmFubkRhV0tEUGcwQm9EYjdJai81eFBq?=
 =?utf-8?B?L1VUVS9sdjgwWGc3T2Z2aERodDhEWk1GeFMwK2RYaTNUdjc2RHJRNUhDOTRS?=
 =?utf-8?B?ZEJrR3pFM1dKTmtVQ2xKQlo0QmhiMkU4MUZtWUh6cVFZdlIraHl4RW5hZ0Nu?=
 =?utf-8?B?RWpGT2tsNWVkREUyNG52OWtEa05uQi8vVVdXN1N0amZ0c1BaVTB4eWVNZDkr?=
 =?utf-8?B?RGwvcDJSMzFtRjJwOFpVUllBMHVSUUZjbDN0YnJWd2dadTc2R09GSTR2b2g5?=
 =?utf-8?B?dXdZUEhzeFBCZm1rYnJLTDdkQm9Zam9IU1hnb2hEMmFOZE1MY3VZT3FRMGQ0?=
 =?utf-8?B?U1NQMVJ3UFJ3ZkNWTm8yWll6RUJOeFNQeTM4YTRrR0RlMjBoYTVGemh0b3By?=
 =?utf-8?B?R1NhVWNKL0hZeGlBNFB3dTJWNEZuT0dKeDczNGNuamE0TlNGZjE3dEJLTXV6?=
 =?utf-8?Q?OSqyZ6LiF9EcP2b2fhHhsY7Imb94ZzEc2K2aSVL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6520.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b3721c-9634-4a9f-8cab-08d92d0fd66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 19:33:49.2667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9JBAF1/Essnou0fUQpEqRNqSKG0rrJ47mB5n/OsLsUm79/cP96eOtzbhSUIqKTGYJyowkzfVvRgn5sRmHJEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7405
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnMtUGV0ZXIgQ2xhdXNlbiA8
bGFyc0BtZXRhZm9vLmRlPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTUsIDIwMjEgMTowMyBQ
TQ0KPiBUbzogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5c0B4aWxpbnguY29tPjsgdmtvdWxA
a2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNA
eGlsaW54LmNvbT4NCj4gQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBnaXQNCj4gPGdpdEB4aWxpbnguY29tPg0K
PiBTdWJqZWN0OiBSZTogW1JGQyB2MiBQQVRDSCA3LzddIGRtYWVuZ2luZTogeGlsaW54X2RtYTog
UHJvZ3JhbSBpbnRlcnJ1cHQNCj4gZGVsYXkgdGltZW91dA0KPiANCj4gT24gNC85LzIxIDc6NTYg
UE0sIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+ID4gUHJvZ3JhbSBJUlFEZWxheSBmb3Ig
QVhJIERNQS4gVGhlIGludGVycnVwdCB0aW1lb3V0IG1lY2hhbmlzbSBjYXVzZXMNCj4gPiB0aGUg
RE1BIGVuZ2luZSB0byBnZW5lcmF0ZSBhbiBpbnRlcnJ1cHQgYWZ0ZXIgdGhlIGRlbGF5IHRpbWUg
cGVyaW9kDQo+ID4gaGFzIGV4cGlyZWQuIEl0IGVuYWJsZXMgZG1hZW5naW5lIHRvIHJlc3BvbmQg
aW4gcmVhbC10aW1lIGV2ZW4gdGhvdWdoDQo+ID4gaW50ZXJydXB0IGNvYWxlc2NpbmcgaXMgY29u
ZmlndXJlZC4gSXQgYWxzbyByZW1vdmUgdGhlIHBsYWNlaG9sZGVyDQo+ID4gZm9yIGRlbGF5IGlu
dGVycnVwdCBhbmQgbWVyZ2UgaXQgd2l0aCBmcmFtZSBjb21wbGV0aW9uIGludGVycnVwdC4NCj4g
PiBTaW5jZSBieSBkZWZhdWx0IGludGVycnVwdCBkZWxheSB0aW1lb3V0IGlzIGRpc2FibGVkIHRo
aXMgZmVhdHVyZQ0KPiA+IGFkZGl0aW9uIGhhcyBubyBmdW5jdGlvbmFsIGltcGFjdCBvbiBWRE1B
IGFuZCBDRE1BIElQJ3MuDQo+IA0KPiBJbiBteSBvcGluaW9uIHRoaXMgc2hvdWxkIG5vdCBjb21l
IGZyb20gdGhlIGRldmljZXRyZWUuIFRoaXMgc2V0dGluZyBpcw0KPiBhcHBsaWNhdGlvbiBzcGVj
aWZpYyBhbmQgc2hvdWxkIGJlIGNvbmZpZ3VyZWQgdGhyb3VnaCBhIHJ1bnRpbWUgQVBJLg0KDQpU
aGUgaW5jbGluYXRpb24gZm9yIHJlYWRpbmcgaXJxIGRlbGF5IGZyb20gRFQgd2FzIHRvIG1pbmlt
aXplIGNyZWF0aW5nIGN1c3RvbSANCmludGVyZmFjZSBmb3IgY2xpZW50cy4gRm9yIGV4YW1wbGUg
LSBJZiB3ZSB1c2UgeGlsaW54X3ZkbWFfY2hhbm5lbF9zZXRfY29uZmlnDQpBUEkgaW4gZXRoZXJu
ZXQgZHJpdmVyIGl0IHdvbid0IGJlIHRoZW4gZ2VuZXJpYyBlbm91Z2ggdG8gYmUgaG9va2VkIHRv
IGFueSANCm90aGVyIGRtYWVuZ2luZSBjbGllbnQuIEFueSB0aG91Z2h0cyBvbiBpdD8gIFdpdGgg
RFQgb25seSBsaW1pdGF0aW9uIGlzIGl0J3MNCm5vdCBydW50aW1lIHByb2dyYW1tYWJsZS4NCg0K
VGhhbmtzLA0KUmFkaGV5DQo+IA0KPiBGb3IgdGhlIFZETUEgdGhlcmUgaXMgYWxyZWFkeSB4aWxp
bnhfdmRtYV9jaGFubmVsX3NldF9jb25maWcoKSB3aGljaA0KPiBhbGxvd3MgdG8gY29uZmlndXJl
IHRoZSBtYXhpbXVtIG51bWJlciBvZiBJUlFzIHRoYXQgY2FuIGJlIGNvYWxlc2NlZCBhbmQNCj4g
dGhlIElSUSBkZWxheS4gU29tZXRoaW5nIHNpbWlsYXIgaXMgcHJvYmFibHkgbmVlZGVkIGZvciB0
aGUgQVhJRE1BLg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhZGhleSBTaHlhbSBQYW5k
ZXkgPHJhZGhleS5zaHlhbS5wYW5kZXlAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2Vz
IGZvciB2MjoNCj4gPiAtIFJlYWQgaXJxIGRlbGF5IHRpbWVvdXQgdmFsdWUgZnJvbSBEVC4NCj4g
PiAtIE1lcmdlIGludGVycnVwdCBwcm9jZXNzaW5nIGZvciBmcmFtZSBkb25lIGFuZCBkZWxheSBp
bnRlcnJ1cHQuDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5j
IHwgMjAgKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZG1hL3hpbGlueC94aWxpbnhfZG1hLmMNCj4gYi9kcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2Rt
YS5jDQo+ID4gaW5kZXggYTJlYTJkNjQ5MzMyLi4wYzBkYzk4ODJhMDEgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1h
L3hpbGlueC94aWxpbnhfZG1hLmMNCj4gPiBAQCAtMTczLDggKzE3MywxMCBAQA0KPiA+ICAgI2Rl
ZmluZSBYSUxJTlhfRE1BX01BWF9UUkFOU19MRU5fTUFYCTIzDQo+ID4gICAjZGVmaW5lIFhJTElO
WF9ETUFfVjJfTUFYX1RSQU5TX0xFTl9NQVgJMjYNCj4gPiAgICNkZWZpbmUgWElMSU5YX0RNQV9D
Ul9DT0FMRVNDRV9NQVgJR0VOTUFTSygyMywgMTYpDQo+ID4gKyNkZWZpbmUgWElMSU5YX0RNQV9D
Ul9ERUxBWV9NQVgJCUdFTk1BU0soMzEsIDI0KQ0KPiA+ICAgI2RlZmluZSBYSUxJTlhfRE1BX0NS
X0NZQ0xJQ19CRF9FTl9NQVNLCUJJVCg0KQ0KPiA+ICAgI2RlZmluZSBYSUxJTlhfRE1BX0NSX0NP
QUxFU0NFX1NISUZUCTE2DQo+ID4gKyNkZWZpbmUgWElMSU5YX0RNQV9DUl9ERUxBWV9TSElGVAky
NA0KPiA+ICAgI2RlZmluZSBYSUxJTlhfRE1BX0JEX1NPUAkJQklUKDI3KQ0KPiA+ICAgI2RlZmlu
ZSBYSUxJTlhfRE1BX0JEX0VPUAkJQklUKDI2KQ0KPiA+ICAgI2RlZmluZSBYSUxJTlhfRE1BX0JE
X0NPTVBfTUFTSwkJQklUKDMxKQ0KPiA+IEBAIC00MTAsNiArNDEyLDcgQEAgc3RydWN0IHhpbGlu
eF9kbWFfdHhfZGVzY3JpcHRvciB7DQo+ID4gICAgKiBAc3RvcF90cmFuc2ZlcjogRGlmZmVyZW50
aWF0ZSBiL3cgRE1BIElQJ3MgcXVpZXNjZQ0KPiA+ICAgICogQHRkZXN0OiBUREVTVCB2YWx1ZSBm
b3IgbWNkbWENCj4gPiAgICAqIEBoYXNfdmZsaXA6IFMyTU0gdmVydGljYWwgZmxpcA0KPiA+ICsg
KiBAaXJxX2RlbGF5OiBJbnRlcnJ1cHQgZGVsYXkgdGltZW91dA0KPiA+ICAgICovDQo+ID4gICBz
dHJ1Y3QgeGlsaW54X2RtYV9jaGFuIHsNCj4gPiAgIAlzdHJ1Y3QgeGlsaW54X2RtYV9kZXZpY2Ug
KnhkZXY7DQo+ID4gQEAgLTQ0Nyw2ICs0NTAsNyBAQCBzdHJ1Y3QgeGlsaW54X2RtYV9jaGFuIHsN
Cj4gPiAgIAlpbnQgKCpzdG9wX3RyYW5zZmVyKShzdHJ1Y3QgeGlsaW54X2RtYV9jaGFuICpjaGFu
KTsNCj4gPiAgIAl1MTYgdGRlc3Q7DQo+ID4gICAJYm9vbCBoYXNfdmZsaXA7DQo+ID4gKwl1OCBp
cnFfZGVsYXk7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICAvKioNCj4gPiBAQCAtMTU1NSw2ICsxNTU5
LDkgQEAgc3RhdGljIHZvaWQgeGlsaW54X2RtYV9zdGFydF90cmFuc2ZlcihzdHJ1Y3QNCj4geGls
aW54X2RtYV9jaGFuICpjaGFuKQ0KPiA+ICAgCWlmIChjaGFuLT5oYXNfc2cpDQo+ID4gICAJCXhp
bGlueF93cml0ZShjaGFuLCBYSUxJTlhfRE1BX1JFR19DVVJERVNDLA0KPiA+ICAgCQkJICAgICBo
ZWFkX2Rlc2MtPmFzeW5jX3R4LnBoeXMpOw0KPiA+ICsJcmVnICAmPSB+WElMSU5YX0RNQV9DUl9E
RUxBWV9NQVg7DQo+ID4gKwlyZWcgIHw9IGNoYW4tPmlycV9kZWxheSA8PCBYSUxJTlhfRE1BX0NS
X0RFTEFZX1NISUZUOw0KPiA+ICsJZG1hX2N0cmxfd3JpdGUoY2hhbiwgWElMSU5YX0RNQV9SRUdf
RE1BQ1IsIHJlZyk7DQo+ID4NCj4gPiAgIAl4aWxpbnhfZG1hX3N0YXJ0KGNoYW4pOw0KPiA+DQo+
ID4gQEAgLTE4NzcsMTUgKzE4ODQsOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgeGlsaW54X2RtYV9p
cnFfaGFuZGxlcihpbnQNCj4gaXJxLCB2b2lkICpkYXRhKQ0KPiA+ICAgCQl9DQo+ID4gICAJfQ0K
PiA+DQo+ID4gLQlpZiAoc3RhdHVzICYgWElMSU5YX0RNQV9ETUFTUl9ETFlfQ05UX0lSUSkgew0K
PiA+IC0JCS8qDQo+ID4gLQkJICogRGV2aWNlIHRha2VzIHRvbyBsb25nIHRvIGRvIHRoZSB0cmFu
c2ZlciB3aGVuIHVzZXINCj4gcmVxdWlyZXMNCj4gPiAtCQkgKiByZXNwb25zaXZlbmVzcy4NCj4g
PiAtCQkgKi8NCj4gPiAtCQlkZXZfZGJnKGNoYW4tPmRldiwgIkludGVyLXBhY2tldCBsYXRlbmN5
IHRvbyBsb25nXG4iKTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlpZiAoc3RhdHVzICYgWElMSU5Y
X0RNQV9ETUFTUl9GUk1fQ05UX0lSUSkgew0KPiA+ICsJaWYgKHN0YXR1cyAmIChYSUxJTlhfRE1B
X0RNQVNSX0ZSTV9DTlRfSVJRIHwNCj4gPiArCQkgICAgICBYSUxJTlhfRE1BX0RNQVNSX0RMWV9D
TlRfSVJRKSkgew0KPiA+ICAgCQlzcGluX2xvY2soJmNoYW4tPmxvY2spOw0KPiA+ICAgCQl4aWxp
bnhfZG1hX2NvbXBsZXRlX2Rlc2NyaXB0b3IoY2hhbik7DQo+ID4gICAJCWNoYW4tPmlkbGUgPSB0
cnVlOw0KPiA+IEBAIC0yODAyLDYgKzI4MDIsOCBAQCBzdGF0aWMgaW50IHhpbGlueF9kbWFfY2hh
bl9wcm9iZShzdHJ1Y3QNCj4geGlsaW54X2RtYV9kZXZpY2UgKnhkZXYsDQo+ID4gICAJLyogUmV0
cmlldmUgdGhlIGNoYW5uZWwgcHJvcGVydGllcyBmcm9tIHRoZSBkZXZpY2UgdHJlZSAqLw0KPiA+
ICAgCWhhc19kcmUgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobm9kZSwgInhsbngsaW5jbHVkZS1k
cmUiKTsNCj4gPg0KPiA+ICsJb2ZfcHJvcGVydHlfcmVhZF91OChub2RlLCAieGxueCxpcnEtZGVs
YXkiLCAmY2hhbi0+aXJxX2RlbGF5KTsNCj4gPiArDQo+ID4gICAJY2hhbi0+Z2VubG9jayA9IG9m
X3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAieGxueCxnZW5sb2NrLQ0KPiBtb2RlIik7DQo+ID4N
Cj4gPiAgIAllcnIgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihub2RlLCAieGxueCxkYXRhd2lkdGgi
LCAmdmFsdWUpOw0KPiANCg0K
