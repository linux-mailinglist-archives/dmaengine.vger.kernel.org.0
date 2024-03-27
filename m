Return-Path: <dmaengine+bounces-1549-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48888D942
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 09:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011EB1F2AD70
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948AF2E85A;
	Wed, 27 Mar 2024 08:39:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2101.outbound.protection.partner.outlook.cn [139.219.146.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2A2D60B;
	Wed, 27 Mar 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528745; cv=fail; b=kV3y54coenhfSbY8KdPwca2QEkrfygg/HyMlMSJ/Gf5Bj1/vA31BJUytaGGoq8ZOcdQ3dm/+L4rZB464NtuNeaseeEXS7oRSZUjNDbc+s2ie/DwL29fYflmlgDHPmyVQ3LFIEA8bcLQsx1uSWRnJ4i/lVUSxc0tZ3SGt4MuPf+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528745; c=relaxed/simple;
	bh=4aVwKWueyk+tq+PQK8VJR+EGBmcpE0zssipr8z7yYIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzWV2SRnoYwiPuJXb5KdIoE0rFBzxdRNDjWgaowGzpCqzS9N0bqdLD6ufQY5QI0BJ5Psq8hM3/0+Inse9BAQ2DtQ4m3kNJznGZyuO2XgitWPEUovtPfQRm5GUNPwUMTXrWu4E2D+E/daXtcSsfzOxH5Ya1X3+4OgN6YW8P/HCMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5pLQg1l2YkiaZgQ+M8+ulL+FF1xOIQi1P8H+LfOngHNuxXe8OKB4fChB8ACFvoHp7q0TPKjkb8ckkUAMdCK1uOjtCKuHvRsxIrwKDpVgVT5ThKa43OT9Wp8IVNorl/NOuCMyAX8Mbup4v/sz3fEN8prX3UnkGH7B0ZsAqlFh1pXEbEbyg6ZXzWpYN+lBWJOAFL4Oxng2PRzdpGC3IUx8JlkKcq2RQe2e2knJ8/6D/3b5u34ogaYcIouK8i5vohtABvzgVQZaj/6kR0imQey30mXHyIIUaJChjV9xl5sSne/hobCGN7vjN9Q+B3U2LiTUweKAjsTHm564mcy8eWOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aVwKWueyk+tq+PQK8VJR+EGBmcpE0zssipr8z7yYIo=;
 b=je2uWXqvRmST6LHhVTh99Qkf2qGxVmT0VBueTjkqHzwuCXYIjnNVJ9YfDMp6MiSCpd58d+MmlXHZ06udDM1Gbpc1TnLw9WKmv53qs6o1jGAAHyvH12qzpx4bDFlDdtJy5oHHB7infUUB4JiTDi4Wprp530NvYNR7LDXa0imfbA5WRDpRtO+z1BeYG1+1TBbsAmC/ngzV9pr40QrvFi/akdkTkHWrsk+RV5wzhMegkwT3Vbq7PV/gxtdOux0hs/C/4quDUvaObR9/o2XOvxK4uIktwQi6mdiL+kloz9iteRN1dEoMcxuRe3c4AQqhA2w1NEXIWwUODYsfZRs/2CgwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0769.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 08:24:02 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 08:24:01 +0000
From: ChunHau Tan <chunhau.tan@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Eugeniy Paltsev
	<Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, JeeHeng Sia
	<jeeheng.sia@starfivetech.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
 support
Thread-Topic: [PATCH v2 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
 support
Thread-Index: AQHaf/GyiHYkf+O6W0qtfxQX63srE7FLNtAAgAAH9aA=
Date: Wed, 27 Mar 2024 08:24:01 +0000
Message-ID:
 <BJSPR01MB0595D132CB5A072A9E61F9C09E34A@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
 <20240327025126.229475-2-chunhau.tan@starfivetech.com>
 <6533503e-18e1-4957-96cc-db091e9c46c9@linaro.org>
In-Reply-To: <6533503e-18e1-4957-96cc-db091e9c46c9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0769:EE_
x-ms-office365-filtering-correlation-id: cbceb606-08d3-4e9e-861a-08dc4e374204
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DDQWBfLN3aVQOrlaP1XHjBYqMGXpJwYBD32fmeCCRzIeGq6dHlBvQr5fIWkAbI2nbV2awT2GBAA1evf9bOGTtBxap1CorDeS+TZtAhyYNnTr548WMmAeiLHhvF5DCn+DtSFG42SzPADIIDkBsDxv8PYwxP0vWp/I6cWV58jhp2fJbdDhFe3g0Mwnh6YUt7SsnbG3Wv7T2YHYUE2p8vMgJQItqf4IthO6wFedWNvHNV8OZroTUXkVxagxT66zM1+broAQAE/tWA5qLs3v4SK0qaAN3MlSKnqO1AEUzqJP03Sa4yX5slRckV9DWldVhCVYWtbapnepf9u8kfJEVVW9nD5/X/mROW8tA+BmIrmponxemgvP4dIRBlUntszkkI8rJrtIm8o+GbGrcjbcngIAVfmnHxYVJg0wR0D0yZ/vKHWzCAVw0ucbexAK0vmEDrpiKSK5FTMUa7m3MOPTfLnjKCi7UC0lsNqw6TpPGlXVqzU3xHHygiZ4QZ6/p0pa7n9edWTpVMl8qSkVwNOYaXtXOHtwF7hie7D1zCj5ZiGC2zTS6lDqCOynn60WK36rP90uLUWOrZtkm9NvuzIJ15lty6UqWea2ws/Ug7VxPbxQj0ERaYuiQxyzZX08k8IEogbK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?andtSmdjekQrZjV4akFWR080Ni9rMzNqVTRmVmFFRk9hWTJOT29kZTRGdXVl?=
 =?utf-8?B?eXpiV0JNTXduaEQrZ2pQMDhaYzNHLzBLVC9iZFM2R29FUWVmangwSEdJUkQ1?=
 =?utf-8?B?K3FIZjVrYW44RDB1cXZtY29iQnZ5UzM3eDN4Qkc3S1VkWCs2Tzd1OHhqTGxW?=
 =?utf-8?B?TjVSKzErMFlBYUtHTjhxeUJtSEhuZGVNTFQxSzgrMFY5NVJJV005K0h1bHF6?=
 =?utf-8?B?QndTbG9odjk5d1lYU1ROaFkzRmJtazh6emVVeTJhcFB6bWZFcHJxS0g2UURn?=
 =?utf-8?B?SHlzZ2M5Q0dtK2dNYmxFTHJCZDFucExtYU8veEhhU2d5NFUzWU1ObXhmZDdz?=
 =?utf-8?B?N0VBNElqaEk4YmQ3Uk5tTUVCcXNDak8ydkl5a2V0eFhRT0hZU0dUdTVJTEtH?=
 =?utf-8?B?anVQeVVBa1dmR0drOTNMVytMZ0w5L3E2ZHZQdmZUVDNhWFhrS3p1ZVBwNkZY?=
 =?utf-8?B?Q25LNzN5YVJzbGgybUtFb0RPa1laRmZKSlR1Qkd1cjh5VUZmbU91S1FvVFlr?=
 =?utf-8?B?MmN0VkJOYXhqcU54NEM2NEttaWdMY0ZhRVpzUG00UldFWnNVcVltWXZGMXBR?=
 =?utf-8?B?SXpzTFh4MlJJeVdpUTFJTEU3aDFMa0x3dldidTYxNWFxUGRlVmFTZHhIdEdH?=
 =?utf-8?B?ZUJuV0ZUZ0dFdzA5NDFXR1VHaUYydXgyVjArV3F6NWd5c01Hb1JXcmJscTZP?=
 =?utf-8?B?K25jRDlGQ1FUL3hnay9ZeFI4c01XbnB0Mk9jTWRKOW9GQWJoQjI0bzRXZ1hh?=
 =?utf-8?B?MmdwMzQzVmVnemNKOHQ1aGh5SEV4QmxhclVmQ1ltQ0R2ZXRLSzk4UWl4N3R5?=
 =?utf-8?B?TXBkL3RQYmRUQXphUzRsbllVVjZkVERVcjZGRlBzRUkrUjJKUWZoalZneXNr?=
 =?utf-8?B?ZU0vaXdpUDVpVWV0QzVSRU1UYUpZTWZqVWlVVSs1UTFSN3ZiVFV0S29kclV2?=
 =?utf-8?B?emhLSTl4N3NWNENaL1QxelJWdkV3RzJJd3FLaUtxNnJ6eEozbDdncGFYckov?=
 =?utf-8?B?aUpPemdTeWp2dzNKZ2hMYmhabUJFdUlmR3ZCTng2b3Y4Z3NHc21kQUdDMFRF?=
 =?utf-8?B?dDUwSkxwSW5hdVd6aFYzUk03NmdaemRNVjlxSGlxTHFkbXIvM2dSQ1FNZUE5?=
 =?utf-8?B?dHk5d2t2NXFGd1ZDUG1MQzJkZmlOcmNvL01NSkRha1dHWThOVjJRT0RrbmZp?=
 =?utf-8?B?NHlhakxocU9EZXRCWW9kV0RKcEFwMEVXTGFyVzdqNlFrQVVKTnNUNDh2a2xq?=
 =?utf-8?B?azZrK042UE1VUjVIamwxNFdJRFpqZzNtMW1zdVd5VmJ4K1hUVzJSa1lkUGNL?=
 =?utf-8?B?aVlZZzNjNVU1Rml2UXlEQTNxZUtOMzBtQmlmWk95TVQrckNUY3NGOFpzbXNN?=
 =?utf-8?B?dVhmZm1rN0RrRW41YXp5QXdaVnZ6RHR4WjMvM3YxKzhDenFzdXU1UnJIT01I?=
 =?utf-8?B?bzNUcFAxSThVR294OE04ZGZieVdYLzNLUTZucStzUGJYZ1hBSGp5dHNZVmR3?=
 =?utf-8?B?L0FXblVGUzJJTDJhMmVsbkkvODROZWsvTlY3VzZGNjRieWp1ZHMrYTZNc1pr?=
 =?utf-8?B?T2lwNnFGRE9VM2VVSG9JR2FSQUZNUEZTKzlUM29aRUhNb0lQK1ZBRHRISWZk?=
 =?utf-8?B?TnVoUTBFZnlaclhTanNqdDAxVmhHdEhDbTYwWW1mK0lYaVVKRFJhWDJlbmlI?=
 =?utf-8?B?Mm5LbjdYQlNHZ2lSdzFsUE9TRFRLMGY0aEwwWTV2SUIrbEVWMEo5WlkxZEZX?=
 =?utf-8?B?VFI2Vm82b0RPa3BCd2lIUnJKNHBKWWJIcEh1RTJrK0hMSEpXL0QzNENoN1F0?=
 =?utf-8?B?NUM1NU03alVvSTBhVXZDNXFabmppaEpFOUx4MG5YR2ZKMk5VUXR1alF4TXNL?=
 =?utf-8?B?VS9aR0g3NkRRZ3J6MUhCakFCcEVCbkdKcnBwREFqclJzam8rRkJSR2ttbjV6?=
 =?utf-8?B?VEFxeEtoaHJxZGZvK0p2NVJuQzduSUVELzF3UUVkczN4clMzQk9ncEdrdFVO?=
 =?utf-8?B?bTV4dVlDVjI0d1J6QjRwQVpISmZsN2pLRXB3ZFhPVVZ3MEVyR3pIc2Z6c0x6?=
 =?utf-8?B?ZkkzVFpDY0kxaDJ0ZTNWb1hxbkpHOHdZeS9Bc2R2Ylo5K1lHSnRVR2tQSkh2?=
 =?utf-8?B?czVmOGRrYnRMNjVac1lmeCtvWHBkSHd3K1RwcEJhSGdna2p2T1pzTE10VitL?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: cbceb606-08d3-4e9e-861a-08dc4e374204
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 08:24:01.7083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2rgVPVmgcyips6qJhpIkSVxaGGEldTUTh1CORsvilxR5dc/h5T3zk+CVj4Nrt4FvkXnMGT3/GRTI7MzmegYXtTuqcrCa0QvC+UsUr+x8Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0769

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IDI3IE1hcmNoLCAyMDI0IDM6NTAgUE0NCj4gVG86IENodW5IYXUgVGFuIDxjaHVuaGF1LnRhbkBz
dGFyZml2ZXRlY2guY29tPjsgRXVnZW5peSBQYWx0c2V2DQo+IDxFdWdlbml5LlBhbHRzZXZAc3lu
b3BzeXMuY29tPjsgVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nDQo+
IDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc+Ow0KPiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+
DQo+IENjOiBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47IEplZUhl
bmcgU2lhDQo+IDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgZG1hZW5naW5lQHZnZXIu
a2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdz
OiBkbWE6IHNucHMsZHctYXhpLWRtYWM6IEFkZCBKSDgxMDANCj4gc3VwcG9ydA0KPiANCj4gT24g
MjcvMDMvMjAyNCAwMzo1MSwgVGFuIENodW4gSGF1IHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZv
ciBTdGFyRml2ZSBKSDgxMDAgU29DIGluIFN5c25vcHN5cyBEZXNpZ253YXJlIEFYSSBETUENCj4g
PiBjb250cm9sbGVyLg0KPiA+DQo+ID4gQm90aCBKSDgxMDAgYW5kIEpINzExMCByZXF1aXJlIHJl
c2V0IG9wZXJhdGlvbiBpbiBkZXZpY2UgcHJvYmUuDQo+ID4gSG93ZXZlciwgSkg4MTAwIGRvZXNu
J3QgbmVlZCB0byBhcHBseSBkaWZmZXJlbnQgY29uZmlndXJhdGlvbiBvbg0KPiA+IENIX0NGRyBy
ZWdpc3RlcnMuDQo+IA0KPiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVtaW5kZXIgZHVyaW5nIHRoZSBy
ZXZpZXcgcHJvY2Vzcy4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgeW91IHJlY2VpdmVkIGEgdGFnIGFu
ZCBmb3Jnb3QgdG8gYWRkIGl0Lg0KPiANCj4gSWYgeW91IGRvIG5vdCBrbm93IHRoZSBwcm9jZXNz
LCBoZXJlIGlzIGEgc2hvcnQgZXhwbGFuYXRpb246DQo+IFBsZWFzZSBhZGQgQWNrZWQtYnkvUmV2
aWV3ZWQtYnkvVGVzdGVkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucywNCj4gdW5k
ZXIgb3IgYWJvdmUgeW91ciBTaWduZWQtb2ZmLWJ5IHRhZy4gVGFnIGlzICJyZWNlaXZlZCIsIHdo
ZW4gcHJvdmlkZWQgaW4gYQ0KPiBtZXNzYWdlIHJlcGxpZWQgdG8geW91IG9uIHRoZSBtYWlsaW5n
IGxpc3QuIFRvb2xzIGxpa2UgYjQgY2FuIGhlbHAgaGVyZS4gSG93ZXZlciwNCj4gdGhlcmUncyBu
byBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1cHN0
cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3IgdGFncyByZWNlaXZlZCBvbiB0aGUg
dmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjYuNS1yYzMvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0DQo+IGluZy1w
YXRjaGVzLnJzdCNMNTc3DQo+IA0KPiBJZiBhIHRhZyB3YXMgbm90IGFkZGVkIG9uIHB1cnBvc2Us
IHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdlZC4NCg0KSGkgS3J6eXN6dG9mLCB0aGFu
ayB5b3UgdmVyeSBtdWNoIGZvciB0aGUgZmVlZGJhY2ssDQpTb3JyeSBJIG92ZXJsb29rZWQgaXQu
DQpEbyB5b3UgcHJlZmVyIEkgcmVzZW5kIFYyIHBhdGNoIG9yIHNlbmQgYSBWMyBwYXRjaCB0byBp
bmNsdWRlIHRoZSBBY2tlZC1ieSA/DQpUaGFuayB5b3UuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQoNCg==

