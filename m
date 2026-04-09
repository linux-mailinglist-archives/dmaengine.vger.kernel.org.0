Return-Path: <dmaengine+bounces-9947-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKmeEgXS12mrTAgAu9opvQ
	(envelope-from <dmaengine+bounces-9947-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Apr 2026 18:21:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4653CD978
	for <lists+dmaengine@lfdr.de>; Thu, 09 Apr 2026 18:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEAD1303814B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Apr 2026 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3D3DE456;
	Thu,  9 Apr 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fbjp0NwZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011070.outbound.protection.outlook.com [52.101.125.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A33DEAD6;
	Thu,  9 Apr 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751253; cv=fail; b=mdoQb+4DXQJ73jDWteWo4dNJ0j0Sq/szMSNNsopAYqkDvQTm79Trlvu0EFMXD0Ofm9fc8mJkhZd9bqx9+z13fdQuRZ8nSN58feoveC6L+vvPMJ6pk3sNfCZOnY2TGP8xfEfX5LCOufgYLuna/F4z1PEvNVtAhGkTU8VfybqMbQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751253; c=relaxed/simple;
	bh=TwN+WZ+hZotDhnQQdoF+/vhC4AMqyA3u7qcA65ZFp5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K5z0S6DvsofTFGYIo6kjDGsRrpDwlz7Rn/r3ueTX0iRsoNe15+hTx5wxybVJY2Z6Sp/PV96aBPiGZH/ANjx5ygVK74rnd9/AJF7SoddNypk3736QqprYbleqwyg/Ln62FMH5jw58XdGYQ4KIFMAviit6EB0vKL+TgIFmz0vENIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=fbjp0NwZ; arc=fail smtp.client-ip=52.101.125.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpbY/KCXS3XRIfi0P9kAsYdwJ1nnspGfubnMIlux5dMgAzvQqEGH9ClgrK0s+RfLxqtcyGbpeIHiXjuDBAjhoaF8pBaNzlDt5/9wmtqd1HkFk81Gt6mfgbTGHdPsCGPkKQvsE2uYgW6GtUzvGIvP6LzgiHQAlKhnsMZWeRSALrO3Qq4IflWWlZM2FuKchGBMhjuPbWSHbrJKz9BPh30Rr+0w6CIT+B7aMV/cDxxgk3+RX+dmIXYr/iQczupTr/O/hRbHny+lquqKd7RV0m6AaAkY56RDUTSYZK9NBEgTbwb5fruwDsatNemQ6BMJOiaNJFLKCuTWTRnxeai36CbjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwN+WZ+hZotDhnQQdoF+/vhC4AMqyA3u7qcA65ZFp5o=;
 b=RnoecpxuIesIBxi4hMOuFun2eJIBzm+HHsJwgF1Cocoeq4dgjM7SmkASsDj+6+CdPqJf33fzhk/YYIWMaA4VN+l032PRZnkGxp8VwO4g6op6SFWony5b/WtQ5bheYtOIATQFBEvF7JRxVYSNqbQ5xzyLN9+Wzff+qbI8fSXTajk72jdTePbtk47XKuYW9GIUfkCU17BfuPMO9okdWITO1Njz7oreOIoFaCnPFfjIOiwpVXsO/sU5zO5PYXoiD717BoKWgx0QQuf6XlRFG7BZ1M/vy+duRBGmitWLTUsD/Zs4cym14G2/JZkUrfTNhE7Kk1n0v0Hbmd+rUMgKT313NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwN+WZ+hZotDhnQQdoF+/vhC4AMqyA3u7qcA65ZFp5o=;
 b=fbjp0NwZE/5iJPMq5CnFgN7HpvH5YFDC2dXtuTJlwwnn8n/3vnNNhfHQWnoiDA032r8/THHAYo9Sd5ZLsqrQadOLWwiddl9e2gazxDB5Yn/4j1Z4IwQg9NDQDd/jF+lxYXyykYqC0mHmsCJNEJCQ7H0iOP+1Wa4m0TI1YhZjjxU=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS9PR01MB16852.jpnprd01.prod.outlook.com (2603:1096:604:2bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 16:14:06 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 16:14:06 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul
	<vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, magnus.damm <magnus.damm@gmail.com>, Thomas Gleixner
	<tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, John Madieu
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH v2 24/24] arm64: dts: renesas: r9a09g047e57-smarc: add
 DA7212 audio codec support
Thread-Topic: [PATCH v2 24/24] arm64: dts: renesas: r9a09g047e57-smarc: add
 DA7212 audio codec support
Thread-Index: AQHcwoCYYXa7rCmkQEe/oePT32mVg7XU8reAgAH/rRA=
Date: Thu, 9 Apr 2026 16:14:06 +0000
Message-ID:
 <TY6PR01MB17377A6E40FE4BEE55E2E4E57FF582@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
 <20260402090524.9137-25-john.madieu.xa@bp.renesas.com>
 <CAMuHMdVLb3Wj=4qK_5jLsiN28i2LDYPVH9ch91Y6e8XyT+yjjA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVLb3Wj=4qK_5jLsiN28i2LDYPVH9ch91Y6e8XyT+yjjA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS9PR01MB16852:EE_
x-ms-office365-filtering-correlation-id: 2669db34-e952-4649-ac2a-08de96530651
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 GiisGgfAk+nFV4WWv63lg2RYGEnOXf1GJjG3KFjV2RPKG0CLuJwvyUkeqgvY/2tLZwTboG8alRmVOWi7QjKRr3hEex2eRGvNfbTMiH2L7wy7LVDtMOcCawzhIefKRiSiy9e+5+WZcXzF+Cy2DMEZzKNjXeF0piD9EZ9TEO9xqri2WaTpGtIhcIF+AXq533uDggwZeNtviLmB3vLEm6iBVV1ucSX+vlBGGRG2fLH1EmWmiMmAZ8yUYLSAwfGgplblkjRWc9qQ84d0y6J1bK+Yrpt38umePYDHJlzpVOaqNDrCeog4A31EZvO5bN10mIrs4tOXZoj2xTZVUpdkXehZbk/1pdfWcFZrFmn1TryoHXKO40tMtIpgOKtX5/N3EnokjgdGAQ3W0+KeNcTneMItIKCZnieBxTJgF00J3T72YBBvF5Glb091rhtmIT96RLUkdhhqWis1k7Fss1ZaRH4Uwe+5opTiiQGX7BWngQdj7eguptdgWmbGq6WK0tKVNFiXvLheQZesm5c4k5wM1jZekbA3bM6QBfxse5/SJWlw/M0hWEGi54RRgT9XX9/5eLKgn+obp6KHEaKAg9CjGVMdnm5QNsZiZUrqEytwa222dH3H6oJwLfQ3r6/W4mOaHdJ7E+byGRpbB2m9xlxBIy0tI2MSyzzxUeIMGRuzJoADTwaBhhBMthonzNuDo1WA1Mo7GaZpjJ1voP86o1faChQg0gAGsjglmwoTMZbhg6z+Du5qzMoKC8L23nzHH4oVQoNWDTLRMb8iqrlWlacOPurXwjx7f0srAkuftKg4ZS+4Itg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUdmdi9KcUlvd1Y1YlhzcnBSbTFPRHFJb2FKd2gzZnhGNUhhSzB2aHBKOHNS?=
 =?utf-8?B?bUl5Z0VPZllvbU9PS2dDSTZoZkZ2UHk5UTQ2ZTI5YlVaclgyZ0VrQ3FVSmhv?=
 =?utf-8?B?a0o5SzlrY2RyTStJTGkxczlMREhMNThyZ1RpZ3JKRng0SlhsVVRFK3ZnQzFL?=
 =?utf-8?B?WlNCeTBHcEJYbzRMdWJ4ZVJIaDBISXZDK0F5SVVwNXJzUVVlTXNOekRuZUlK?=
 =?utf-8?B?YUlLWjhtaHZMdm9zR1JyY09WVjJPYjc2dVczWGlhK2JyamNLTFhwZElVR3pU?=
 =?utf-8?B?bnVFYW9TV1FSVjluTXRKOFozc3hENkpFMTBvcWFrRlhMSXI4RnVNcU5yTXl3?=
 =?utf-8?B?cHMwRTY1aC8wWEpYUk5LOWFOSWdvdE90UlYzcFovbitCLzJUSVV5NmR4U3li?=
 =?utf-8?B?MWRwTFQ1LzN3bDlXRTVrV0MzbnhYUmVQZEVnNklBVC80RWMxLy85dHB2MWln?=
 =?utf-8?B?NjJZaUJIeDk0MTcybnMxc0xOVkkzZUh1amsycjM5cE5kVGlyTUhJRHJNZDRW?=
 =?utf-8?B?VWVOLzRKYm13bTNNUlp3b2NzQk40QzhQZHJvM0QyaFpnYW40TnNNaWgvVUVi?=
 =?utf-8?B?T3VRMW9YNS9QdGRjMWxNODFkTU5kZEIrZXVwU3loaE1wdlQrc2Y2RGNENGlT?=
 =?utf-8?B?QnMxNWZUMnM0Zllrdi9tRUFQUDlVb29nV3dpbFRKbmR3a2hva3dOYk5CRGdu?=
 =?utf-8?B?dzRhQnRzL243RXE0enFLanhpb3U4Njdra3hpN3NhckxnUzUwampKd2s5dTFC?=
 =?utf-8?B?WGEvZ01oam5EenRSai93M1ZiSGYwNkNoWWNxVEplbSswL0R2d0FTaGRzWERY?=
 =?utf-8?B?YVJ1STdjTi9LUWlPQ1dPWHR3dG5TQ01HT1dHNDJ6cFFjTjBaRWcxNWlUelRo?=
 =?utf-8?B?RFh2a3cwSGhuUGJiT2VWSEFrNm9GdmxETFo1bWZMUUhnY1pCcXZyRE9LWHdN?=
 =?utf-8?B?ME9tVHdnVzdwNHFQVmJ2cDE4NHNxSjd0V3Y1SHhwaWJSOGhjaUl6bHIydzIv?=
 =?utf-8?B?WUNJUGZ3SEgzZUE3VTR1TVpEYkFLNFZaM0d2QkVvNDR4dG8rdzR4M25BOEFD?=
 =?utf-8?B?ZTR5SzgxM3I3MzQzMmxrMzl2Mk53cW1UQzdSTXdRR242Rm5BTEErYzhvdms3?=
 =?utf-8?B?L2NqNDF3cml6b1UxU2NEdWozWkszSVFQT1dsbE5vOUdyZlY2WEtoaVhLSk1N?=
 =?utf-8?B?QS9sVTEwQ21Mb3dvQTcwRWhBM0QxWC9LbXNsOWtTNEltYnQ0aWJnU1loOXJp?=
 =?utf-8?B?YzhWcE92d1k0NVRKN1lDWnZpZVFkZ0pjTE5ycFRMNlVLWlVWY1hIMEFaVXlX?=
 =?utf-8?B?RmlyMHZRM2xkMGxYRzNMMjlDWGV2VmtLaGN5SnpaOFVTNjByVjBlMWR6dWF1?=
 =?utf-8?B?b3J5WW1VOGFmdW1xMkZVUmRPU2x2UlFWbGFMWFpMNU9Jci90YisyQkl6bGc0?=
 =?utf-8?B?TjdSZlNDYy9BQW1kckk1MWhCeThpQlg5TkxJR3JzeWRZZ0dtcG8rbGJtcHRP?=
 =?utf-8?B?T1pINitzbVRXWlF5d1MrYkF2V05EeDB3N3piWGdxRGdFbHFwVDF4YnZvSTFs?=
 =?utf-8?B?U3VmLzdlUnJmWGFGQWtzcTBMbEdBamRFWTZrRVpsZlZHR2g4M0M3aE5KWFUz?=
 =?utf-8?B?YzVJbE9rRXVFSkJMNlN5R29YNTJ4TnhjT1ZPYzFIVHpvbXRtRWZHaTYzV09U?=
 =?utf-8?B?ZHRPVU9VZFFBSVBWZWdPR3VCbkdjSjhRS2UxbkJHS01zS2tpZVRiSmU4UEtw?=
 =?utf-8?B?SlYvTzQyQjRHbVRpNmd4RzVxeDVxTzRBSWdlSWlyUTlGVWJhRXRlNHNPSzRv?=
 =?utf-8?B?eFhHZjV4K2J5RXRuZ1pIa080OEVCZzdlS0NOOE45ZURMZW84WStNOUNwanll?=
 =?utf-8?B?RUZaT3lzRVlHUmNRdlptbzFMbXNJMnNoZ0ZUVWkyL0FQbks2YjgydTBCTENU?=
 =?utf-8?B?M2FSbTYxNlNuQ1hOQmo4QytkZmJiVDNQeWhUSk92V0RVWU05cmo3ZExURENy?=
 =?utf-8?B?djhwcTdzV1JWRVJWQzZ6VU5rdHVLMkQ4NlI3L3R6SzJZVSsyNTJnQktVaHBC?=
 =?utf-8?B?WHRDZmdIMUVRak5IN3ZTZUgwblRqZXVmNnhWZ2twWXZXSU1EN0VaaDE2VHE4?=
 =?utf-8?B?Z1ZGaHZNalJUZHF0MDRLelgrYXdUelk5OGc4WExsNUc5OGlIa21aNUdwSW5K?=
 =?utf-8?B?YWdyVE43QmlWMHg4akZzMjVMbndYa2JSY1dTR1BPK0NoR1JSbEgwMWZxNWxq?=
 =?utf-8?B?Yys4RC9JQVRURlliZXljaDN1and2RnptS1lFZitHcEVaQVZlY2JBY3dOUk9Z?=
 =?utf-8?B?QUZNQURsM0V3bFE0OHdPdEM3V3A4cXY2U3JXMkY3dnFLT3hHdmN5Y1d0Mkcw?=
 =?utf-8?Q?Q9faHDlCR7PP92oc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2669db34-e952-4649-ac2a-08de96530651
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 16:14:06.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8ACjwxN56v6N6OOzBQ4s751KCJWshlj2WMiC/Pb3tDOjEoIzxu5HoRzRQ6WwZGJR6qiG9/qgADYlcO00U+Udmz62zg6md6gogAoosgPjnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16852
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9947-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,linux-m68k.org:email,TY6PR01MB17377.jpnprd01.prod.outlook.com:mid,m68k.org:url,linux:email,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC4653CD978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1t
NjhrLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCA4LCAyMDI2IDExOjQxIEFNDQo+IFRv
OiBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMjQvMjRdIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA5ZzA0N2U1Ny1z
bWFyYzogYWRkDQo+IERBNzIxMiBhdWRpbyBjb2RlYyBzdXBwb3J0DQo+IA0KPiBIaSBKb2huLA0K
PiANCj4gT24gVGh1LCAyIEFwciAyMDI2IGF0IDExOjEwLCBKb2huIE1hZGlldSA8am9obi5tYWRp
ZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IFJaL0czRSBTTUFSQyBib2FyZCBo
YXMgYSBEQTcyMTIgYXVkaW8gY29kZWMgY29ubmVjdGVkIHZpYSBJMkMxIGZvcg0KPiA+IHNvdW5k
IGlucHV0L291dHB1dCB1c2luZyBTU0kzL1NTSTQgd2hlcmU6DQo+ID4NCj4gPiAgLSBUaGUgY29k
ZWMgcmVjZWl2ZXMgaXRzIG1hc3RlciBjbG9jayBmcm9tIHRoZSBWZXJzYTMgY2xvY2sNCj4gPiAg
ICBnZW5lcmF0b3IgcHJlc2VudCBvbiB0aGUgU29NDQo+ID4gIC0gU1NJNCBzaGFyZXMgY2xvY2sg
cGlucyB3aXRoIFNTSTMgdG8gcHJvdmlkZSBhIHNlcGFyYXRlIGRhdGENCj4gPiAgICBsaW5lIGZv
ciBmdWxsLWR1cGxleCBhdWRpbyBjYXB0dXJlLg0KPiA+DQo+ID4gRW5hYmxlIGF1ZGlvIHN1cHBv
cnQgb24gUlovRzNFIFNNQVJDMiBFVksgYm9hcmRzIHdpdGggYSBEQTcyMTIgYXVkaW8NCj4gY29k
ZWMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFA
YnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwOWcwNDdlNTctc21hcmMuZHRzDQo+
ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I5YTA5ZzA0N2U1Ny1zbWFyYy5k
dHMNCj4gDQo+ID4gQEAgLTI4MCw2ICszNTgsNDIgQEAgJnNkaGkxIHsNCj4gPiAgICAgICAgIHZx
bW1jLXN1cHBseSA9IDwmdnFtbWNfc2QxX3B2ZGQ+OyAgfTsNCj4gPg0KPiA+ICsmc25kX3J6ZzNl
IHsNCj4gDQo+IFBsZWFzZSBwcmVzZXJ2ZSBzb3J0IG9yZGVyIChhbHBoYWJldGljYWwsIGJ5IGxh
YmVsKS4NCg0KTm90ZWQgZm9yIHYzLg0KDQpSZWdhcmRzLA0KSm9obg0KDQo+IA0KPiBHcntvZXRq
ZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAt
LQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBp
YTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVy
c2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+
IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1t
ZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

