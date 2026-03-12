Return-Path: <dmaengine+bounces-9392-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePJjBLmRsml5NgAAu9opvQ
	(envelope-from <dmaengine+bounces-9392-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 11:13:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F22702C5
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 11:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C8213175B83
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B66B3BED2D;
	Thu, 12 Mar 2026 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="L+MzvhDX"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010019.outbound.protection.outlook.com [52.101.229.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540B37F000;
	Thu, 12 Mar 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310038; cv=fail; b=i6NhWuv0WTzoQYL6YWnqIc03GwROsTrREXrymiRWDdbAms4RW0LbNhs7pHMqKcirYnj4QBgysCUsO8iisCJJEGVxKlu+4VfnSaDdob3cw/thZ+rN/fDAjjbT6+k4pV/o0urC7ePX+5K5L5lvUHPWjyUdF4A67rldFwNvlEoenpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310038; c=relaxed/simple;
	bh=RxEGwhqvMABDLbL5LIG+UXEpEvUV+DYeUsWGHJKOiHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tV1Pyuqiyb6bAM+hfKs/20geP/H0A3CecrKYwPuv02Q5MfBx7Bp6mB0/LkpPemhhAlx8m7fYmnfoEEpuZzvGtXx8/e9F9rvSvL+vvmOIQ0I27KEu1hSdTFZ/eQk12pgTmBow02++YvQK85OxY/hLTYjFvCVydjYC2GrMP6wYqYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=L+MzvhDX; arc=fail smtp.client-ip=52.101.229.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRe6BNykMty7Pg+FVReOAGnUtESERaOOkpI/WOe3c8F1kmguxbYxMBfivrhgLk9bOpZ80PCAfQ0awDB2l41wz/KYj43g6eZzktBdBxS248NY1z4aSOGcLg/Kuo619OGHs7Jin9zFkD+YKuKkFHmATL2L/Epyu+GvenMSp0EE+0hh2cSJZIk/OvPmvOSqfXCF+vkYoybWiRZG7rS72LWTKEE4cRZ2qXMB2a1LsQsgJG9gKH9/e81wN9kbPOGbj7Y5xc64SWJKakTHqYzp2CFZi+5n9r/OtjAgcLPyCkywO6PZ73Q58xjcJILsm0I1lO/lVN9X+a/TP+PTvjoCZbPGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxEGwhqvMABDLbL5LIG+UXEpEvUV+DYeUsWGHJKOiHI=;
 b=T3eKdao3Cy9jn/qyCh9bWJ7J5FZ9QOvm1ukHJaH7IffEhwdQdqcM/82wN8IVF109KV9AWlf7H3AItYC9EnNJrwVqdG182lkCc74gaQj8l/KSwe0/1AnX21mgdupQKTRJM1kWjHB5P21TUB72XRBDWlu+HBk2XiXcnqquKK2kC08DHjfdmGmDnaj0nv+AQYkvP4JEx4z2SP/xYtGeVeZVIkR66CuzYl+oh7MidH9bhi1w5ewmwUzHZX5a5zUcb6u/LfBVh+TwIzkgSHXABnJFrF2cLOJP2uX2XsZlIac09+G0FPCA6H+gOv6I12snXG+ZtwCQ1r5ADUFgglEMZ/8Hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxEGwhqvMABDLbL5LIG+UXEpEvUV+DYeUsWGHJKOiHI=;
 b=L+MzvhDXulOWR4dBAcS8LJvmNpu4KUqVb73c3giv1enjuRmKRezt2RSWfeu7WbXG7xkuXzgcCFjdC0ypva4wU3py7W4Df60OR5Wq1ONE3nh51OYzodVSktubRZDW76NBEzOLEwGTLfXrMt3xwvzarb6ae1nwfRj17NeLPe2p7w0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11836.jpnprd01.prod.outlook.com (2603:1096:604:23c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 10:07:06 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 10:07:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, geert <geert@linux-m68k.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Topic: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Index:
 AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/QgAAW+wCAAAEtcIAACGyAgAAC1MCAAAUUgIAAAEvggAAlpwCAD49ggIAAByHggAACRgCAAAWpgIAAOcKAgAAETGCAARKLAIA1cEHA
Date: Thu, 12 Mar 2026 10:07:08 +0000
Message-ID:
 <TY3PR01MB11346A3E071BEC86EA6CA96528644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
 <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev>
 <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ad752abc-275b-43ca-aec3-188c1a69c50b@tuxon.dev>
 <TY3PR01MB113460006A458AB2F8B96542C8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346C8AD27554E40EC5746E38693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7f0305f6-ae2d-4069-b53a-d2a81e75d164@tuxon.dev>
 <TY3PR01MB11346321A9AAE93C7070C6E578699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdWUpq1bUbNLu4WGheovQ1pYdEJGBMN3jdb6PZqXanN_GA@mail.gmail.com>
 <TY3PR01MB1134661E4B93CE785700FC5AF8699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <32ea84f2-621a-47d9-a661-9acd62d50662@tuxon.dev>
 <TY3PR01MB113460619AE8C46BC674B28078699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4dd522fe-8143-4423-b428-2774a185ad73@tuxon.dev>
In-Reply-To: <4dd522fe-8143-4423-b428-2774a185ad73@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11836:EE_
x-ms-office365-filtering-correlation-id: b50db65a-fe66-4b93-4ee0-08de801f1eca
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 UyUUImbi3odZvLQjA4WMyq/4Z//AHDU4iXON0CMKQmGTeaDntXFdfyEie6CcdQhvQ5rVJzzKuRvtTzMFzUNdFBY6ZiUOqSckJdeaX+4ePchRdxe/2rvO/KY9FJ8PqPG6lc2+eIH+gNZP8glpLQCnQVjRQub2bpD15X0sTfGx+0up/Q8ZxXgj1zLlJBb2KiTqrVOQ8Y7Vs5yaKNFJwyNhCK0n7mpREerqF11mJa1s8Y8ubiWFMwIpOZNIR5qlmk27jvYNgMe6WqubxXubbRwoErRTSezDQ3A6M4Y7cYY/8p9VlcUcUKnwU9o0JguosGwRQ+3PfDvH+rYlFFvvKoHQb4pNhVTHLyX8GoUegbHAcyeVEdZOOS5Q5j86+/EsD2mKc8Y4Xv2IhRFi9hksX1HrqP7Xb2CaVz2Gd0LmKWCUvvB734yyu5v43OuMs6hrYVFRmPCF9kcE3kzJ1oZnpNkj3Pj4ZXzVK8L59bsy2odEp1BkQGbMa5y28oq3c3eSVK5HE/+y5pYSPFfSEF9WNxZD8iLfO8WVpDhbkWtP2Qz83N1dC+5x8wVZQ/DJKKVFMwr4UmJurDeEkQpq6dn5dqwPTzNFNLeNjlhLT9uLjCoJcpILEpix/Z1ssOtrYzB6R2HyNwYfe8a5dmpLD3umGZn1YmTvpMW0/FG6CxGPgTwybv2niCjXUdBOQCZLRORrKki93YvR9aS4ztoU7cupLc8Scn95DEm7QyyYYlnNQD6s7FG5oVcS+ZzvR9NlWDXKpwBG9kvI4qsZIGB7B4T64Y8wFg7TOABsBd4tA73cHlgdDq8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTcvK2taV2dhaW5tVndhUGZUY0lveDQwOGFQQWxJK1UwR21ma0pUZ0M2TVh2?=
 =?utf-8?B?UE05WnV5aGJ4L2wxTW5JczJiS0ZjUTVjRG5PUlYwY2dwa0lwcXJseUVVTTVk?=
 =?utf-8?B?akRjbmY2NU1wZ3pNbkR5ckVCRDdhU0hCblMrWm13ZUMwcWVnNS93czdLR1Nx?=
 =?utf-8?B?OUZwSlpzckU2NkpmV0VnREdaNVRoMkxWMTVYRUNSbnFDR0ZPdDlXSjlnTlV6?=
 =?utf-8?B?RkFtSVdMQ1JZaCtLM3FCSDgzYndTRjEyZzdBRnlpdDdpNmZDb3ZteGgvYlJs?=
 =?utf-8?B?bjFIcFRFQU1Sc3ZyYVRkVHFxSkpVV3gzdXNiajdQcUJkS1dUUUcrekNuNzdv?=
 =?utf-8?B?QXBzYmtnVktCS1lwTGkxeSs0VHVTK2lkYSt1V1FJUHpnTzhWMENiU1JpWm1L?=
 =?utf-8?B?TXZ1TVVzaEdzS0NxZUdlYVpUNTJUcllOZzN1bmxmSGhzYVhSQmtiazBFRW15?=
 =?utf-8?B?TE1RalI2ellaMDRtZVJLdEg4YnlTU1A2YXJ2cStwRUdyMjVMZXAwWHhHemJQ?=
 =?utf-8?B?THR0Mk1RRjdDWkY5WTR4VFoyQ3h5SXY5OVV0S2dNbW5HR0ZUOFVNdzhvQVlD?=
 =?utf-8?B?QlUrWVgrTWV1ZGxZRFNTSXEySEE4Q3BqNUtsNjZ6Sjh5UDY0NFRRaGZOOFJI?=
 =?utf-8?B?VEp4STc0dXltbzRRM1pEWTN1d3MzcldBYTlTSEtKV3lkRmh3NEgzeTI5MjNH?=
 =?utf-8?B?ZUltSWRaeGM5YUYxeUNWWi8zbnR0cy9oaktwcldxUnE0SzE0a2Iva3RmZSt3?=
 =?utf-8?B?MlFsOEdjUHE3OFRhUVZXdjNYeXRMY1RURDNIc3dkNE9BdEJNN3Y3cDJVakR6?=
 =?utf-8?B?aEQ5bXplZ25UbHM1WGhOb3owdEhlK2tLajQ2cStlOEhOd1p6SzI3cXZlbFMy?=
 =?utf-8?B?ODlmL2FvTFk0QzQySlA4UTJWZmMyOTNpWHRmQjB1N0QvZEFSU0ZxTlRPeWg0?=
 =?utf-8?B?dnN1Y2VaVHZrUFpzbnJESnhTS1NBejBoT0trNk9kR2pVNHRzSzVqajVvQ1lP?=
 =?utf-8?B?Q0JuWkpYbElMYnJ5dWZhTmFqUmZPQ0xUN0tCWTdwM0krYmFaM0Z6OEkrOU5X?=
 =?utf-8?B?ejE5cUMwSHNMME5FRVNmWld5VVJBZ21WSG1tQWlWbzMwbHVSU2M0RGZ0L3d6?=
 =?utf-8?B?YUl5M0V2TDh3cEdtd2pwQjJLZ0ZaeUIzeDZvU01NNWJlYXlxR21ON2pIcmVC?=
 =?utf-8?B?WGNobnp3cTJRd0lZeWRJZUhiTlBLRjVTNkR3azlBeGxselN1RVczRnhXMUNz?=
 =?utf-8?B?Sk0zOEk2bFJVYzF1SmJxU1VlQ0RwaEczbHBCZDJkaVcvQlVMcWowUFh4TFd3?=
 =?utf-8?B?SzY0aE1aOWxaZ3pnSUtzMWZSbUZQbCtpQ0w1SG9pMVNNWTVUeGhrWjZES0Yy?=
 =?utf-8?B?VWlnZ09lQzk3dkJJeHBWKzl2REo1L0FLNnBwY2piRjdCUHd1V2ptMG1aNlpa?=
 =?utf-8?B?T2I0NVRETTc2bEN2ZkZEYkZVUFJmdWd3MHpMZ3pQemZwZmgza2dWcWpnSWQ3?=
 =?utf-8?B?RTVCMnBlVDRsTW1NQUVXd0ZwWnArZXI1UkMrbG1tY2J2OFZUdDJQZm5tdkhZ?=
 =?utf-8?B?VDNkY2huREx4MllZRFVpTlNPT3R1UTRjckxEVjVrTytYQWNzTGpsMlluQkJR?=
 =?utf-8?B?MW5YSEpsNzFwRWJGWU9uYzhweE42eFlad21nVWVteG1HWWdWK0QzallnVnVH?=
 =?utf-8?B?OFE0QlBoTHk3ZXhidGI2M3JzT0Y5TFFYTWc5THgvTmZSUUlRZzJrV3pZS25Q?=
 =?utf-8?B?L2Y4d0V4NktUUGdxOE94TStPSFFFS0toOUsvQnRndnlFcFQvQnJrOVVFbWhn?=
 =?utf-8?B?VTc4K0RKYzhmT0F6dTVsMmluVkZSN0NhUWdSQlY4SWFrcEpYczRhTXNZcW5R?=
 =?utf-8?B?RWpXNzROSno2b3pGZnpTT0xBamtybVJaOUpyaHVXTG5JTm9KSGVmTXlQaGU0?=
 =?utf-8?B?a28xZFYyVlhtbFRhbzk3SVdWa2REVjdzM2RGUWJwYVkvVFVHY3VVMTlGK1BP?=
 =?utf-8?B?bE9WMWhvRlhIbmhlUmFrOFkwa2g5QllNaFM4YkVWb1h3cEFJRWI5cW41aHJO?=
 =?utf-8?B?QmZWWFdYK3Nza2VJLzBlKzJ5cTJjaVRPRjhMWDZkb0Q2UFNPazR1a2RqN2s1?=
 =?utf-8?B?WVBjM1NRWFc3aGNqZFg3YXBUZlN4SGNSTWZnK3FXRmhoMXB4NlhPU2R2cUky?=
 =?utf-8?B?SGk0ZTZITXEraXkydi9vQlU4Zks3clhUa0JGODVFR1dSWk1PWGVGdklpeUhK?=
 =?utf-8?B?dU9NVW1IakIrUllxMVRSTkd1WnAxYWcvRU9BanVQL29ES2ZncThnSE1haGNF?=
 =?utf-8?B?U1l0S1BOZG8yRTZDYlB1bHlOYXp4OFFEbFVsZm52RHJUaWl0MnIxUT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50db65a-fe66-4b93-4ee0-08de801f1eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 10:07:08.1679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOksjy83+W83m+BmhtYj/aS/8kiPLQjuOPp+NnmA5pGUYrGeZH2zYlgypT7OoUPzbM0hqsOJoclPIz/wcN7kW6uTejMWso6tmzi1RvsZ9N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11836
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9392-lists,dmaengine=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 394F22702C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpIaSBBbGwsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+IFNlbnQ6IDA2IEZlYnJ1YXJ5IDIw
MjYgMDk6NTkNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzddIGRtYWVuZ2luZTogc2g6IHJ6LWRt
YWM6IEFkZCBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0DQo+IA0KPiBIaSwgQmlqdSwNCj4gDQo+IE9u
IDIvNS8yNiAxOTo0MSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQ2xhdWRpdSwNCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50OiAwNSBGZWJydWFyeSAyMDI2IDE3
OjIxDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83XSBkbWFlbmdpbmU6IHNoOiByei1kbWFj
OiBBZGQgc3VzcGVuZCB0byBSQU0NCj4gPj4gc3VwcG9ydA0KPiA+Pg0KPiA+PiBIaSwgQmlqdSwN
Cj4gPj4NCj4gPj4gT24gMi81LzI2IDE2OjA2LCBCaWp1IERhcyB3cm90ZToNCj4gPj4+IEhpIEdl
ZXJ0LA0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZy
b206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+ID4+Pj4gU2Vu
dDogMDUgRmVicnVhcnkgMjAyNiAxMzozNA0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83
XSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBBZGQgc3VzcGVuZCB0byBSQU0NCj4gPj4+PiBzdXBw
b3J0DQo+ID4+Pj4NCj4gPj4+PiBIaSBCaWp1LA0KPiA+Pj4+DQo+ID4+Pj4gT24gVGh1LCA1IEZl
YiAyMDI2IGF0IDE0OjMwLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdy
b3RlOg0KPiA+Pj4+Pj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9u
LmRldj4gT24gMS8yNi8yNiAxNzoyOCwNCj4gPj4+Pj4+IEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4+
Pj4+PiBGb3IgczJpZGxlIGlzc3VlIG9uIFJaL0czTCBpcyBETUEgZGV2aWNlIGlzIGluIGFzc2Vy
dGVkIHN0YXRlLA0KPiA+Pj4+Pj4+PiBub3QgZm9yd2FyZGluZyBhbnkgSVJRIHRvIGNwdSBmb3Ig
d2FrZXVwLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBGb3IgUzJSQU0gaXNzdWUgb24gUlovRzNM
IGlzIGR1cmluZyBzdXNwZW5kIGhhcmR3YXJlIHR1cm5zDQo+ID4+Pj4+Pj4+IERNQUFDTEsgb2Zm
LyBBc3NlcnRlZCBzdGF0ZS4gQ2xvY2sgZnJhbXdvcmsgaXMgbm90IHR1cm5pbmcgT24gRE1BQUNM
SyBhcyBpdCBjcml0aWNhbCBjbGsuDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IENhbiB5b3UgcGxl
YXNlIGNoZWNrIHlvdXIgVEYtQSBmb3IgdGhlIHNlY29uZCBjYXNlPyBGaXJzdCBjYXNlLA0KPiA+
Pj4+Pj4+PiBSWi9HM1MgbWF5IG9rIGZvciByZXNldCBhc3NlcnQgc3RhdGUsIGl0IGNhbiBmb3J3
YXJkIElSUXMgdG8gQ1BVLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gSnVzdCB0byBzdW1tYXJpemUs
IGN1cnJlbnRseSB0aGVyZSBhcmUgMiBkaWZmZXJlbmNlcyBpZGVudGlmaWVkIGJldHdlZW4gUlov
RzNTIGFuZCBSWi9HM0w6DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBTb0MgZGlmZmVyZW5jZXMgZm9y
IHMyaWRsZToNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFJaL0czUzogQ2FuIHdha2UgdGhlIHN5c3Rl
bSBpZiB0aGUgRE1BIGRldmljZSBpcyBpbiB0aGUgYXNzZXJ0DQo+ID4+Pj4+Pj4gc3RhdGUNCj4g
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+IFJaL0czTDogQ2Fubm90IHdha2UgdGhlIHN5c3RlbSBpZiB0aGUg
RE1BIGRldmljZSBpcyBpbiB0aGUgYXNzZXJ0IHN0YXRlLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4N
Cj4gPj4+Pj4+PiBURi1BIGRpZmZlcmVuY2VzIGZvciBzMnJhbToNCj4gPj4+Pj4+Pg0KPiA+Pj4+
Pj4+IFJaL0czUzogVEZfQSB0dXJucyBvbiBETUFfQUNMSyBkdXJpbmcgYm9vdC9yZXN1bWUuDQo+
ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBSWi9HM0w6IFRGX0EgZG9lcyBub3QgaGFuZGxlIERNQV9BQ0xL
IGR1cmluZyBib290L3Jlc3VtZS4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJJ20gc2VlaW5nIGF0IFsx
XSB5b3UgYXJlIGFkZHJlc3NpbmcgdGhlc2UgZGlmZmVyZW5jZXMgaW4gdGhlDQo+ID4+Pj4+PiBj
bG9jay9yZXNldCBkcml2ZXJzLiBXaXRoIHRoYXQsIGFyZSB5b3Ugc3RpbGwgY29uc2lkZXJpbmcg
dGhpcyBwYXRjaCBpcyBicmVha2luZyB5b3VyIHN5c3RlbT8NCj4gPj4+Pj4NCj4gPj4+Pj4gU3Rp
bGwsIHRoaW5raW5nIHdoZXRoZXIgdG8gYWRkIGNyaXRpY2FsIHJlc2V0IG9yIGdvIHdpdGggU29D
IHF1aXJrIGluIERNQSBkcml2ZXIuDQo+ID4+Pj4+IFNvbWUgU29DcyBuZWVkIERNQSBzaG91bGQg
YmUgZGVhc3NlcnRlZCBsaWtlIGNyaXRpY2FsIGNsb2NrIHRoYXQNCj4gPj4+Pj4gY2FuIGJlIGhh
bmRsZWQgZWl0aGVyDQo+ID4+Pj4+DQo+ID4+Pj4+IDEpIEFkZCBhIHNpbXBsZSBTb0MgcXVpcmsg
aW4gRE1BIGRyaXZlcg0KPiA+Pj4+Pg0KPiA+Pj4+PiBPcg0KPiA+Pj4+Pg0KPiA+Pj4+PiAyKSBJ
bXBsZW1lbnQgY3JpdGljYWwgcmVzZXQgaW4gU29DIHNwZWNpZmljIGNsb2NrIGRyaXZlciBhbmQg
Y2hlY2sgZm9yIGFsbCByZXNldHMuDQo+ID4+Pj4+DQo+ID4+Pj4+IElzIHNpbXBsZSBTb0MgcXVp
cmsgaW4gRE1BIGRyaXZlciwgc29tZXRoaW5nIGNhbiBiZSBkb25lIGZvciBSWi9HMkwgZmFtaWx5
IFNvQ3M/DQo+ID4+Pj4NCj4gPj4+PiBXaGF0IGlmIHRoZSBETUEgZHJpdmVyIGlzIG5vdCBlbmFi
bGVkPw0KPiA+Pj4NCj4gPj4+IFRoZSBiZWxvdyB1c2UgY2FzZXMgd2lsbCB3b3JrIChwYXRjaFsx
XSAtIHJlbW92aW5nIHRoZSBjb2RlIGZvcg0KPiA+Pj4gZGVhc3NlcnQgaW4gY3BnX3Jlc3VtZSkg
YXMgdGhlcmUgaXMgbm8gRE1BIGRyaXZlciB0byBhc3NlcnQgdGhlIHJlc2V0Lg0KPiA+Pj4NCj4g
Pj4+IDEpIHN5c3RlbSB3aWxsIGJvb3Qgd2l0aG91dCBETUEgZHJpdmVyDQo+ID4+PiAyKSBzMmlk
bGUgd2lsbCB3b3JrIGFzIHRoZXJlIGlzIG5vIERNQSBkcml2ZXIgdG8gYXNzZXJ0IHRoZSByZXNl
dC4NCj4gPj4+IDMpIHMycmFtIHdpbGwgd29yayB3aXRob3V0IERNQSBkcml2ZXIuDQo+ID4+Pg0K
PiA+Pj4gSWYgRE1BIGRyaXZlciBpcyBlbmFibGVkLCB0aGVuIHRoZXJlIGlzIGFuIGlzc3VlIHdp
dGggIHMyaWRsZSBhcyBETUENCj4gPj4+IGRyaXZlciBhc3NlcnQgdGhlIHJlc2V0IGFuZCB3ZSBj
YW5ub3QgdXNlIHNlcmlhbCBjb25zb2xlIGFzIHdha2V1cA0KPiA+Pj4gc291cmNlDQo+ID4+DQo+
ID4+IEkgdGhpbmsgd2UncmUgdGFraW5nIGhlcmUgYWJvdXQgYm90aCBETUEgY2xvY2tzIGFuZCBy
ZXNldHMuDQo+ID4+DQo+ID4+IFdoYXQgaWYgdGhlIERNQSBjbG9ja3MgYXJlIGRlY2xhcmVkIGNy
aXRpY2FsIGluIExpbnV4IGFuZCBjbG9ja3MgYW5kDQo+ID4+IHJlc2V0cyBhcmUgbm90IGhhbmRs
ZWQgYnkgYm9vdGxvYWRlciBpbiBwcm9iZSBvciByZXN1bWU/IFdobyB3aWxsIHJlc3RvcmUgY3Jp
dGljYWwgY2xvY2tzPw0KPiA+DQo+ID4gUGF0Y2ggWzFdIHdpbGwgcmVzdG9yZSBjcml0aWNhbCBj
bG9ja3MuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gT25lIHNvbHV0aW9uIGlzIFNvQyBxdWlyayB3aWxs
IHByZXZlbnQgYXNzZXJ0L2RlYXNzZXJ0ICBvZiB0aGUgRE1BDQo+ID4+PiByZXNldCBkdXJpbmcN
Cj4gPj4+IHN1c3BlbmQvcmVzdW1lKCkgZm9yIGFmZmVjdGVkIFNvQ3MuDQo+ID4+DQo+ID4+IFRo
aXMgY2FuJ3Qgd29yayB3L28gdGFraW5nIGNhcmUgb2YgdGhlIERNQSBjbG9ja3MgaW4gdGhlIGNs
b2NrIGRyaXZlcg0KPiA+PiByZXN1bWUgZnVuY3Rpb24gKGluIGNhc2UgRE1BIGNsb2NrcyBhcmUg
Y3JpdGljYWwpLiBJZiBzbywgd2h5IGhhbmRsaW5nIERNQSBjbG9ja3MgYW5kIHJlc2V0cw0KPiBk
aWZmZXJlbnRseT8NCj4gPg0KPiA+DQo+ID4gV2hhdCB3aWxsIHlvdSBwcmVmZXINCj4gPg0KPiA+
IGEgc2luZ2xlIGNoZWNrIGluIHN1c3BlbmQvcmVzdW1lIG9mIERNQSBkcml2ZXI/DQo+ID4NCj4g
PiBPcg0KPiA+DQo+ID4gQXJvdW5kIDEwMCBjaGVja3MgaW4gc3VzcGVuZC9yZXN1bWUgaW4gY2xv
Y2sgZHJpdmVyIGZvciBjaGVja2luZyBjcml0aWNhbCByZXNldHMgZm9yIHNraXBwaW5nIERNQQ0K
PiByZXNldD8NCj4gDQo+IEkgc2VlIG5vIGNvbmRpdGlvbnMgaW4geW91ciBjb2RlLiBKdXN0IHJh
dyB3cml0ZXMgZm9yIERNQSBjbG9ja3MgYW5kIHJlc2V0cy4gSSBzdXNwZWN0IHRoZSBpbnRlbnRp
b24NCj4gZm9yIHYyIGlzIHRvIGxvb3Agb3ZlciBhbGwgdGhlIHJlc2V0cyBpbiB0aGUgcmVzdW1l
IHBhdGggdG8gZmluZCB0aGUgY3JpdGljYWwgb25lLg0KPiANCj4gV2hpbGUgcmV2aWV3aW5nIGl0
IEkgYXNrZWQgdG8gYXZvaWQgYXNzZXJ0aW5nIHRoZSBETUEgcmVzZXRzIG9uIHJlc2V0IGFzc2Vy
dCBBUEkuIFRoYXQgY291bGQgYmUNCj4gaGFuZGxlZCBlaXRoZXIgYnkgYWRkaW5nIHRoZSBjb25j
ZXB0IG9mIGNyaXRpY2FsIGFzc2VydCBpbiB0aGUgcmVzZXQgZHJpdmVyIChvciBmcmFtZXdvcmsp
IG9mIGJ5IGp1c3QNCj4gY2hlY2tpbmcgZGlyZWN0bHkgdGhlIHJlc2V0IElEIHRvIG1hdGNoIHRo
ZSBETUEgcmVzZXQgSUQgKGFzIHRoaXMgaXMgdGhlIG9ubHkgY3JpdGljYWwgcmVzZXQNCj4gaWRl
bnRpZmllZCBhdCB0aGUgbW9tZW50KS4NCj4gDQo+IFRvIGFuc3dlciB5b3UsIG15IHBlcnNvbmFs
IHRhc3RlIHdvdWxkIGJlOg0KPiAtIHRvIGhhbmRsZSB0aGUgc2V0dXAgb2YgdGhlIGNyaXRpY2Fs
IGNsb2NrcyBhbmQgcmVzZXRzIGluIGEgc2luZ2xlIGRyaXZlciwgZm9yDQo+ICAgIHByb2JlIGFu
ZCBzdXNwZW5kL3Jlc3VtZSBhcyB3ZWxsDQo+IC0gdG8gaGFuZGxlIGl0IGluIGEgU29DIHNwZWNp
ZmljIGNvZGUgYXMgdGhpcyBpcyBtaWNyby1hcmNoaXRlY3R1cmUgc3BlY2lmaWMNCj4gICAgaXNz
dWU7IHRoaXMgcHJvYmxlbSBpcyBvbmx5IGZvciBzb21lIG9mIHRoZSBTb0NzLCBpZiBJJ20gbm90
IHdyb25nOyB0aGUNCj4gICAgbWFudWFscyBmb3Igc29tZSBvZiB0aGUgU29DcyB1c2luZyB0aGlz
IERNQSBkcml2ZXIgc3RhdGVzIHRoZSBmb2xsb3dpbmcNCj4gICAgKFJaL0czUyBIVyBtYW51YWws
IFJldi4xLjIwLiwgY2hhcHRlciA4LjguMSk6DQo+IA0KPiBJbiBhZGRpdGlvbiwgbmVlZCBmb2xs
b3dpbmcgcmVnaXN0ZXIgc2V0dGluZ3MgKmV2ZW4gaWYgRE1BIGNvbnRyb2xsZXIgaXMgbm90IHVz
ZWQqLg0KPiANCj4g4pePIFNldCBDUEdfQ0xLT05fRE1BQ19SRUcgcmVnaXN0ZXIgdG8gc3VwcGx5
IGEgY2xvY2sgZm9yIERNQSBDb250cm9sbGVyLg0KPiANCj4gUmVmZXIgdG8gU2VjdGlvbiA3LjIu
NCwgQ2xvY2sgQ29udHJvbCBSZWdpc3RlciBETUFDX1JFRyBmb3IgcmVnaXN0ZXIgZGV0YWlsLg0K
PiANCj4g4pePIFNldCBDUEdfUlNUX0RNQUMgcmVnaXN0ZXIgdG8gcmVsZWFzZSBhIHJlc2V0IGZv
ciBETUEgQ29udHJvbGxlci4NCj4gDQo+IFJlZmVyIHRvIFNlY3Rpb24gNy4yLjQsIFJlc2V0IENv
bnRyb2wgUmVnaXN0ZXIgRE1BQyBmb3IgcmVnaXN0ZXIgZGV0YWlsLg0KPiANCj4gR2VlcnQsIFZp
bm9kOiBjb3VsZCB5b3UgcGxlYXNlIGxldCB1cyBrbm93IGhvdyB3b3VsZCB5b3UgbGlrZSB1cyB0
byBoYW5kbGUgdGhpcz8NCg0KRllJLCBBIHBhdGNoIFsxXSBhbHJlYWR5IHBvc3RlZCBmb3IgDQoN
CjEpIFN1cHBvcnRpbmcgY3JpdGljYWwgcmVzZXRzIGZvciBSWi9HMkwgZmFtaWx5DQoyKSBSZXN0
b3JpbmcgQ3JpdGljYWwgY2xvY2tzIGR1cmluZyByZXN1bWUNCg0KIFdpdGggdGhpcyBjbGsgb24v
b2ZmLCByZXNldCBhc3NlcnQvZGVhc3NlcnQgIGNhbiBiZSBkb25lIGZyb20gRE1BIGRyaXZlciBk
dXJpbmcgc3VzcGVuZC9yZXN1bWUuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNjAzMDYxMzQyMjguODcxODE1LTEtYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20vDQoNCkNo
ZWVycywNCkJpanUNCg0KDQo=

