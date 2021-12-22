Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E447CFB8
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 11:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhLVKIV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 05:08:21 -0500
Received: from mail-os0jpn01on2114.outbound.protection.outlook.com ([40.107.113.114]:56961
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232631AbhLVKIU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Dec 2021 05:08:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e01k4lBRwfMQz0lypubX4oJ8FLkNi/2R3/lNtKdVi1a5DujdENzXpSbRTLC3FD6qni4wqErAnTanw4iHdi1NU/wiV4E0Q1rW3Sgmwhh4bu+h9kmkGxZTzHBcIzTehXjXhe/S9gCrFeQbYRmag9zhnYMvvhc+rr75Le2AfoxjMd6Jf9doWzBxbi+JfCw2zltpIGnAIwTPrcXNSfyZ6+IT31VE3WuILL8El7pQPIeZHshUfRTLl7PdR0YcqhWpYpXxb/1Z8rMj/lr18wbN1WR+QcyPNxjYYlzI0lkQnWpnBN/Xs4NPegTImOBu16Xp0LWMIzWiGCp9XbwCX+iLjoxpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foLz0HnlkLRNFGKc1g50HDwv0ln9NrKMj21NyCNdn1M=;
 b=BsXts7bwBU3yH4bTH846QFEVlBxkVHc2TknVsxH4hh7yU0tnVWpkSrAqNtzE7kKNkur5RvKXdYlvm8V14mk7KCtP7jJ4OcqXtVH7QrZUV7m+jUPzH5ibNH2huyppkCa3hYXlOvde/qN6be4Skwc3v7XdulfTqKiA6tzvGQUBeXFzTi4Zge1acfvaaMOxmt4550ZPADKOF3kSJf6VjC6iFWz5Z3Zq+fQFIik4Oj4YNi76IENWbvpvOUQ4lMD1ugs4QPhI0QHgxWYzHdejlmA6ly8EqKKpSQu6H3k6GEnjUCRdPvoOFIH1OBMV6VZZFSiUwsP01rLaBD1wcc4AC0LLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foLz0HnlkLRNFGKc1g50HDwv0ln9NrKMj21NyCNdn1M=;
 b=Tqlmj4lrm3goTjq3xo83SwqjpmLv9q4sc/8tuWWy+olUcpsXScUqOLjnf93oy91WiF0iSaezcyu9P1Ul8lQGCJwzY6VfpZhbxlelNUwEog5oah4rKmx6kKRgoFIr9MqqEqBWo2eCTfSuxPN7zOqA+iONt1EumQdOMt7GsEBRAyE=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB3290.jpnprd01.prod.outlook.com (2603:1096:404:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Wed, 22 Dec
 2021 10:08:19 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b0dd:ed1e:5cfc:f408]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b0dd:ed1e:5cfc:f408%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 10:08:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
Thread-Topic: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
Thread-Index: AQHX9it3/T9ejSK6aUednmQ2PJTQdKw+POEAgAAJUzA=
Date:   Wed, 22 Dec 2021 10:08:19 +0000
Message-ID: <TY2PR01MB3692659BC6251EED054C326BD87D9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
 <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX81Ed-U_DSTKtv074qAq0yB0DJA4YnF9XS1YfEi2zW=g@mail.gmail.com>
In-Reply-To: <CAMuHMdX81Ed-U_DSTKtv074qAq0yB0DJA4YnF9XS1YfEi2zW=g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2148402-2c66-40db-6685-08d9c532faa2
x-ms-traffictypediagnostic: TY2PR01MB3290:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3290EED281F1F7220FF989F1D87D9@TY2PR01MB3290.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+PT6Xpl2NBDVrmJIA7WIgcg/5/4e2Tos96uQZ9p4jdS19QEvOgLJPV5131OQFpThxV6eYE2HTn3NEz30JirthuLnyPyY4/Zn1BGUvGzJnrujSXKPSpJ3+QsuFu2xTEuaoZiqd5xADcZbM1uYdXVVTuJzxaMTciwbp9q7syjdcTewv1e7ddxGix2HRNwx8xbaOvUIlZG6DMrmBdIuaoT7t3HJ6JzO6YnYGq+IN2A5hYSawPxkpJGFvtqq/BTslKNndrpvOCGvTTCsmPZ8ubPCM/HNycbVJItabeRNhPdk4PwuS3Mt6T0wPTYkbX9Yqca2Exo70rnqNS5gULDQ0+We35eMriFizRlIzQtF7sY+8iqkobeHGimdakspQSHJYpIjRPP68CP0hIrLnL0ZFpo0rKAFOmfCJZufCJT14vGFw2ampDzQjt0bGuH+X2OqJKzzjMtpWE+KEYvGMSI7RP+o272CUIJxNJERC6VBfJLlA+agZpQMsiO6oK4aXBLadn3ObqbeSz+hH7GJDoO/GabXuOqMHQhZRtILPuXktGHr3RM6AjoHj8be0UbTbsMbvKyTHJGNXjYxH92F3uYUjE0c2fY37cJt8fs0gtBIy8bjhykfBOdUFCVbvw/asHbiWnuGYQqs2SZNMaX2l0sakKdiv83ODMBo79luUHAO0/8coEqIfftGmJpZJhtOUto7xWpEil0aGRoRHNEG3Fjd2J9sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66946007)(66556008)(71200400001)(9686003)(55016003)(4326008)(66446008)(5660300002)(76116006)(52536014)(53546011)(6506007)(8676002)(7696005)(64756008)(186003)(316002)(2906002)(6916009)(38100700002)(508600001)(54906003)(33656002)(122000001)(86362001)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG8wd3pjRTVRQ25WTzVpZmZLVDQ1OVNXUnhVaGkvOWFLYTlQRHhaL2pnRGZ3?=
 =?utf-8?B?Yk9SUGRvUXoveXlyckljSjExSEQwTDlPQkZKZ2VVSU9FQXBZdUJBTzVpUmtP?=
 =?utf-8?B?cUdTRk0zWnJxU2thRUlhYjgxWkJPVjlJcUVyUFJCQ3hjc2hpN1BjcmY5aVlW?=
 =?utf-8?B?bEZ2WDF2VmxIMUIzai90Zis5ZVllcHAxZDNOcGh6dG5UMG9WZGdsMnNhSFQv?=
 =?utf-8?B?UmJTV3lCU2tPWWdNQkpQaUhXREJ6aXlUUDZSeW5tSXpadUpGMFhTWDRTUjlQ?=
 =?utf-8?B?TStwTU9KNFVxS29hVGF3NDFDSHNERTVxYzBSYk8vbkticmdOVnM0RitBSFhJ?=
 =?utf-8?B?N1h0WlluZmdYejc3aU5XTWpObERQUFlOM0VIb3k0Q04xbGhzdEtFSTRCaXAz?=
 =?utf-8?B?UUMvcWxsQW9TV1BKZ2dSdnp1cGx5VkxBZlVpYkUyOFlNRWE0eVEvd0dXSzNP?=
 =?utf-8?B?LzJKZkJxODZCR09oWTViY1lpOFRNUkhSWmFNQmZ5ZEo2SmVUUStqTGgzbjZN?=
 =?utf-8?B?Tm9HTWxiQ1F2bjUvazZmSitYeU5hb1hxRWx4cjVmVGs4V3ZqVjVhZ1JMdGYy?=
 =?utf-8?B?U1JkMVBTMTUzTy9kQS9MaFlwRU9GSCtpMlNNUWNzSVJvSXdxdG1KQm5CdWNV?=
 =?utf-8?B?M1NVMVU4MmpselVGT3EyWi9vUkFKVDhUaHhobTZ4eDlJeGRIVzN0R2UwenZU?=
 =?utf-8?B?RGhqTlJXQ3o3RHVMeUx5RkJET2lqUlZwQ2ViN2duOFdGaDJqdFBMSXpBQmNz?=
 =?utf-8?B?NFFwNEV6U1dZUmQvU0lENWNVbzRYRVlLbERwOFBvLzhLNkd2SlA0ZmF2Tm5O?=
 =?utf-8?B?ay9heXpwTGU2eGpEZ3I5eGwwT1NWenI1SCtsa1pyNVN2N0U3alYvR1BQY29z?=
 =?utf-8?B?MGk3TG9TV1dTRkVwNW5OT1R1U2FtdnB3L3I4TkVJNFVORStLWE04UTByUnFr?=
 =?utf-8?B?WElHMmdxaDlodzdWUzdJWUJRLzRIdk1XQVBOVGJZbEVPaGxyeHdTM2tWKzlL?=
 =?utf-8?B?Ym03anJHOWVGYnkwSXNBdEl2aXRWQ1ZRNVdhOW9kV01VQmZ1eE00RndMUHZJ?=
 =?utf-8?B?UWJVaGZPZGhDbldLUVBjQkhTZXpMYVF0K2VVQnVRNnZKaDJVUTJtbW9FcXgv?=
 =?utf-8?B?ZGpJUGhDV1VJZEJXTnRqT2JIWm93OGErRWYxK2dXeW50M2FZRzRnOXVmQURG?=
 =?utf-8?B?d3Z6ZTRqYVVWaHNDbGJxeTM1Q2szZnJFY01rMGVjWHd0dnBGZ0o4QnhSOHF1?=
 =?utf-8?B?RThOZlYyZXcxWXlGSDBpSi9DR000KzlnbnBvU1QzTmJTdU8zSEZXbkZ6TlBU?=
 =?utf-8?B?SFRMdXorVzJRYWk5QldvSFJVbWI3Y20zSkVEaG1MeFF0VitTVG0xQ2pLRVBW?=
 =?utf-8?B?N09hcVl4dDk3ZERFVmNicytQbU5ZQUNTcDVTd2E4a09IL09PY2FteEFqMXV0?=
 =?utf-8?B?MzY5eXVpcWdqS0ZSak5lVDRSTUR4NkFBa2lsRXMvMGhwUHpQWlR3QzVHRHBh?=
 =?utf-8?B?S0pXRndQS0FQUjljU0JQdmk2SGs5aXFDSm43ZFM1VUhMaWFPdTJSZndFOThY?=
 =?utf-8?B?UUlYSW52a1UrZGV0NkFHK0NldUVWYVFHM3FXTlJlUVhzNVBUVW5XbGlYa0Qy?=
 =?utf-8?B?N3lmYUhOU3phbllFcnVYcWgyWVl3cGRyYk1xU2xwVURpV2ZtZGE5QldHNkRW?=
 =?utf-8?B?SklyTTVGM2JRMEV0TzlwOC9jUVNRcnFKNkVnR1BZYUJtTXpLcERhY2NtakZy?=
 =?utf-8?B?UHlqbUZndUl3UmRIeG5JcHRLbDdkYXF3T3Q1ekZmaGR3SUdkNUZTbHdtRWp6?=
 =?utf-8?B?ODBwamRBUm9vaWxhYnFTWnhYYVQ4azNwUnRtdHlXM2VJWFBac1BSaVF1UnVS?=
 =?utf-8?B?ZTFHK1NEWlBjdjc4ZXlXdmFpd3BWTVhDUWJ5MnIrMUR1UGJHUVRnUFF6cERr?=
 =?utf-8?B?dkFyQ0ZpdHVLT2wreTBoQTJ3RVdDQTRhV05oQXdvckw1SWkyb1h6TzBmSWFJ?=
 =?utf-8?B?azVyRWhMdzcremttSUx3VDFJVWJuTjIveDVGdyt2SlJpUHRoRERRUTM0Mnly?=
 =?utf-8?B?bTlWTFFVMzE4WVdjcE5PYXF1S3ZxRzQ3VnVGd0lybUd2S08rbjNYNTJlLy9v?=
 =?utf-8?B?ZTNNekhpMlhKblZGb3hFTWlaQTNSQW5kMGUveVhGc3h5dUQ0dW5MdDY5UTVS?=
 =?utf-8?B?eUYxTnI0aWk0Tno0UkpHdjFPRDdnUnhScENMQjlMMjIyNVFyWHpPazJhdGQv?=
 =?utf-8?B?R0Fnc05LelhDcjB5N0tGdFVxKzlneXVISXpaWGtvL2pXU2JvZjBIL0N2ZCtV?=
 =?utf-8?B?V2hIQk8wSUNoOFFDWlNzNGs1L0JCRWljQzNONGNkbHR5MWoyV0hGdVhXRWxu?=
 =?utf-8?Q?NvtDvgyWiZ1Wx5We3pkso3aeOqoQGAHgdb3VX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2148402-2c66-40db-6685-08d9c532faa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 10:08:19.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9ZDIohnJV6K+JWcRCTUEoANoRCyMAWOHA7YuRjZPHwbKvYD51WONcZRLPTXaFnuv8BEDOWTnHx36EzO4TuetclM63fLjPlwBjtDQU0I13u6wkrd0sDGAkxFtx2tsCK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3290
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyMiwgMjAyMSA2OjE3
IFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+IE9uIFR1ZSwgRGVjIDIxLCAyMDIxIGF0
IDEwOjUwIEFNIFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2Fz
LmNvbT4gd3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIFItQ2FyIFM0LTguIFdlIGNhbiByZXVz
ZSBSLUNhciBWM1UgY29kZSBzbyB0aGF0DQo+ID4gcmVuYW1lcyB2YXJpYWJsZSBuYW1lcyBhcyAi
Z2VuNCIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGlo
aXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gh
DQo+IA0KPiBQZXJoYXBzIHlvdSB3YW50IHRvIHJlbmFtZSBSQ0FSX1YzVV9ETUFDSENMUiwgdG9v
Pw0KDQpZZXMsIEkgc2hvdWxkIGhhdmUgdG8gcmVuYW1lIGl0LCB0b28uIEknbGwgZml4IGl0IG9u
IHYyLg0KDQo+IEFzIHNvbWUgcmVnaXN0ZXJzIGRvIG5vdCBleGlzdCAob3IgYXJlIG5vdCBkb2N1
bWVudGVkKSBvbiBSLUNhciBTNC04LCBwZXJoYXBzIHlvdSB3YW50IHRvIGRvY3VtZW50IHRoYXQg
aW4gdGhlIGNvbW1lbnRzDQo+IGZvciB0aGUgcmVnaXN0ZXIgZGVmaW5pdGlvbnMsIHRvbz8gRm9y
dHVuYXRlbHkgbm9uZSBvZiB0aGVtIGFyZSB1c2VkIGJ5IHRoZSBkcml2ZXIuDQoNCllvdSdyZSBj
b3JyZWN0LiBTbywgSSdsbCBtb2RpZnkgdGhlIGZvbGxvd2luZyBjb2RlOgkNCg0KLSNkZWZpbmUg
UkNBUl9ETUFDSENMUiAgICAgICAgICAgICAgICAgICAweDAwODAgIC8qIE5vdCBvbiBSLUNhciBW
M1UgKi8NCisjZGVmaW5lIFJDQVJfRE1BQ0hDTFIgICAgICAgICAgICAgICAgICAgMHgwMDgwICAv
KiBOb3Qgb24gUi1DYXIgR2VuNCAqLw0KKHNvcnJ5IHRoZXNlIHRhYnMgYXJlIHJlcGxhY2VkIGFz
IHNwYWNlcykNCg0KQWxzbywgSSdsbCBhZGQgc3VjaCBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0
IGRlc2NyaXB0aW9uDQpsaWtlIGJlbG93Lg0KLS0tLS0NCkFkZCBzdXBwb3J0IGZvciBSLUNhciBT
NC04LiBXZSBjYW4gcmV1c2UgUi1DYXIgVjNVIGNvZGUgc28gdGhhdA0KcmVuYW1lcyB2YXJpYWJs
ZSBuYW1lcyBhcyAiZ2VuNCIuDQoNCk5vdGUgdGhhdCBzb21lIHJlZ2lzdGVycyBvZiBSLUNhciBW
M1UgZG8gbm90IGV4aXN0IG9uIFItQ2FyIFM0LTgsDQpidXQgbm9uZSBvZiB0aGVtIGFyZSB1c2Vk
IGJ5IHRoZSBkcml2ZXIgZm9yIG5vdy4NCi0tLS0tDQoNCkFyZSB0aGV5IGFjY2VwdGFibGU/DQoN
Cj4gQXMgdGhpcyBwYXRjaCBpcyBjb3JyZWN0Og0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVy
aG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCg0KVGhhbmtzIQ0KDQpCZXN0IHJlZ2Fy
ZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
