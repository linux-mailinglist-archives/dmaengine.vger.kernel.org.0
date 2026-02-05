Return-Path: <dmaengine+bounces-8760-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UArYMcOkhGmI3wMAu9opvQ
	(envelope-from <dmaengine+bounces-8760-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 15:10:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A2CF3CF8
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C858E300A636
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352D3EF0DC;
	Thu,  5 Feb 2026 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="k5bGxbl/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96003EDAB1;
	Thu,  5 Feb 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300390; cv=fail; b=bncoZ1ZJy9oZMm7J6RgPhnVl2Bw1NyhsJDFNlLSr7hFmb7xwjjOgyoZdFBMTWiiRus9Hlr2r8tGDn6pY/HsppofBQ/c1r0qU0e2eJ3oRLagtDnIUisOTn73Hu71tMu3ach63rr1WCx5T2stkV+dYOEpu45Vt1NajQaCeskPkHOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300390; c=relaxed/simple;
	bh=o6QrmNYxag3v9xSIejnMwTsuwpRE/spqiw0j4gZdxZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5rsfWjOVBIOV/ZNM172ORv4//sYXlgwLHJgJqCqoj+DHW5sIv/Ir+xz2bcVCweNoVeU5YFrH0CewZAJpd92W3mJvgh1kSdnM6//+iUgkxTVCQagR1wrMUJPE1dqLwhfse7Xo0/e98UO3lqRkqltglhMxE3urCrNh7Sra023ZTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=k5bGxbl/; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrW7suoO7aTdTX8sfU2Itx/rx9eqU0DDEGR0/0s9Yp/942kVCbRjHg8euGXpwT/opvnouCXWiAXhB1fFmRgxh1Xtipaeo0i+ZCbJbc8Xo0KOv24W9rwZsMxEqQjg1toBcgaLOlqsIBR92ipPfvxf0+MqP365mrw8VQaq/f/4b4B9/1mnvIoO1KkZttL/lGmOvsLDc1rDghHPx0FlSC5r35EqC4avfKKsXFFV1ykDoiy/e8uWK/D5qivxXoJvO4abbidczdeTbjpF9wInClwOzJw0GJJ2lrT6x6rOBbBrLeO4tvV6k0/q6kxxLtwgbEv0OidOj17wEfFzAjGm16Cnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6QrmNYxag3v9xSIejnMwTsuwpRE/spqiw0j4gZdxZA=;
 b=uR5aMh3Q1NDMIfyGr6oW5xFtgCRe/I2f1jCEIgQuzCy6wzcuUP8vweH+xmEe9wvl7LJhw6UiwVCDZDkFOGQ5UOIGQT4w0DMQ+kFjVo4Jqzag+os9YfaK/f0TQuQXxk0rbIKvm++UCA3WFTcWXEFn2Inyz3b+cxCCsu6F1mBG4+KMWyQ2B2uYFDM1SDZ1RuQ1o/xYkzhv8Dt61US+ssXl1Jp0vIHrKcYrIqR2vbMMwUmdxn09j4xYBGcVQiEUzSUwh7hjEWjGboGYDH6cvgo/GFVSAo9uDL4NnvOv2GXDr8t4xlJYPNWA68OkS2m2LgzJuBDrrLxsfV6lXRgcymU9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6QrmNYxag3v9xSIejnMwTsuwpRE/spqiw0j4gZdxZA=;
 b=k5bGxbl/Ov64iR7kbRAskB+OoMiF4DkGpqIOUdYiU0yGSmqDQxdjpdKamN/N9teH3QUhW5cYwC3tx7Z2PCcjrhM8xTdiixzXBmmcnFSB2AEtgG6yUPSJttJ/QKSR4rWCXQ+/gLLCET9WlrAZI3jr8qBC02syuXX0BeviVcEmXXY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB12949.jpnprd01.prod.outlook.com (2603:1096:604:33d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:06:26 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:06:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Prabhakar Mahadev Lad
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
 AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/QgAAW+wCAAAEtcIAACGyAgAAC1MCAAAUUgIAAAEvggAAlpwCAD49ggIAAByHggAACRgCAAAWpgA==
Date: Thu, 5 Feb 2026 14:06:25 +0000
Message-ID:
 <TY3PR01MB1134661E4B93CE785700FC5AF8699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To:
 <CAMuHMdWUpq1bUbNLu4WGheovQ1pYdEJGBMN3jdb6PZqXanN_GA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB12949:EE_
x-ms-office365-filtering-correlation-id: 14349dd3-9cf6-4c65-61a4-08de64bfc036
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWw2ZWF2ZkFuNHNkMldUKzZ2MmNTR05EQ20wbXJSc29Sb0EyTktsN3RnemJO?=
 =?utf-8?B?TTM0ZlF0S1dkdzJHSExXRTRLQnFiYnF4TDhOeXpINnpmUEh6L2cyazlDVTQ3?=
 =?utf-8?B?TDhXcDh3QVBLczNXTGlCOFAvWmZRYms0ZExRQmpTaTlqZ3laVkU3K1h5a1dR?=
 =?utf-8?B?VEZRS1NYdEZIaGVOc1FtYi9FYWdsNDlkKzVXeHd0VGtFNmxTYTI2T2pZcjZI?=
 =?utf-8?B?NnZBK3VNTnE3TVJ5RVZkSnMyeGpQYXVwZVk1d1BoenIxdGJ1WFhyUjJHOVB2?=
 =?utf-8?B?aSt4OWQ3cHovdVZraUM5L2JWVVJjZ0RUeThyQTYvSGNMOUtlZFpxRVc3UWpP?=
 =?utf-8?B?a0lFWWlpb1NqckJIeERleGxrYkRUaWV4aTlCd0VsN0dwSytIbDQ2NmZ4eGxs?=
 =?utf-8?B?Mk9oaXFNc0pRWldCU081bXNvdkhFZlBWYVhvY0luZFZlbXV6RDN2WE04NlVB?=
 =?utf-8?B?Q3JHWUgrbldGYUZ1bzR6bFBxRE5KTi91VTNIdTRVeHRvd2grbTlPeURjS2hT?=
 =?utf-8?B?cW04VGdCZG95SUtDcVEweGpad1NmMnFXT3REd3N6bmdaOFFLUTZ2MytTdkdD?=
 =?utf-8?B?OFRIR3dSa1QrSHJnc1BYY01HWGZsaXJ3RWt1NDgxMGRPSm91M2pmeXBwZEFS?=
 =?utf-8?B?Umo0eWtUbElTdFdLWWNobmxKOU50L0YwQ3NpdEFDOHFoY2NxMXBkeGVvbHAx?=
 =?utf-8?B?ZTdlZUY3aDhHQVVURThTcUU1TnM5YXFiNWRqYjg4Yk1sYTlDNmxISG5OdCs3?=
 =?utf-8?B?T2RkYVIzeGF2TWt6dmxaeHh1YmYzY0p5MWJJUEVScWUyeG1TeUJVb3Vya3Rs?=
 =?utf-8?B?QVdwekdDUEhaNUd6SUNzdTBlYk8xdWc2TWRqZWRMM0pkSXNKbmJiQXBUV2w4?=
 =?utf-8?B?M2kyWitLb0dZZUNadDRnUDJKUmVDNkZQU1loMXNiS2x2QmRaeVh1RUFTL3Ft?=
 =?utf-8?B?aWVRRFl0RUYxa3RGSFQ4eDl0V3BuRDFtTFFmV2ZtdUNYcE1TaU1CQWd1TWlx?=
 =?utf-8?B?R1VaWGQzT1RQVGxldVFBM0ZsSkFhZnZReDcwNVBrK0hvOHRMRWJ6NUxMRjY4?=
 =?utf-8?B?TFZGeGxnVkZIWUtqMjY5VkpNTjdrQ1J6UWk2dmNqbDdDS3JjS3V1MFFFM2Rn?=
 =?utf-8?B?U1VCcFhMeGRqQkhNYzI3NW4wd3NWN2RCV2RTWThQSkRmOEZXUWhGMDVneUdz?=
 =?utf-8?B?d0dVckU0K2FzVUU3VHV1SktXbHQ1ekVmZjVBOHZ1RzQ1amJNcmE4YmVtakNJ?=
 =?utf-8?B?RWdYdnA4aC9wYUJ3NUtTWmtZZGlReVlFclFxVEdmb242VEppSW1GSmRuS2dS?=
 =?utf-8?B?K0VVcTc3bXYzWi9NRkVuVW9pb2RpUkxVcEFqeVY1SDgzTXFFN0FoeWFEeEtF?=
 =?utf-8?B?YmR6QlVoMWdjMXdtY3ZMT3dOSDltZmZZK2ZEVlpGcDJ3QytLZVZpa3E2TWYz?=
 =?utf-8?B?YmVwZk1LSWM3QSt1aXFvbHdjUDIrcm0zTGdRWFFFRFZneDB6UFhscHBJQVhP?=
 =?utf-8?B?UC90bVZ4VGJ4SkE4VFdrUXh4bUxUME9FUXFaaldzenk4bFJtcXdsV0hTN0pu?=
 =?utf-8?B?aXpEazBpcXZQNG1jK1Q0UXdGYzBhVXZBdm5Kd2tJQ1lDbHVURzF2TTJKWXBS?=
 =?utf-8?B?bzVEZm5ESWpQd2J4dGVlSWxGakV6MDIreFZyeFh0MXRZYjFTYmxwOWdYNG5G?=
 =?utf-8?B?Tm9CdS9iOWF3Tm5zd041Q0hkK3lRS1NUTmZ2ZU04RXFGcXNYTGdGQ2VlYWlT?=
 =?utf-8?B?MmtNYzF0dThCMmNYNDlVZ09LdTh6R3p1UEVEZFZQNzJSd21VUTgrNTA2V1VQ?=
 =?utf-8?B?cUN4d3NScm9TMzBSaXpvV0JCZ3dEUDBTUXVMMUo1eWJpNmdJcmViZERxYmpp?=
 =?utf-8?B?dzhIcTlqYkJScm1hd292eXZiaENWTkVBa1NzRFVLbUxKaXBWci9aYWtjOGhF?=
 =?utf-8?B?ejFrUEt1YVBkaUJqb3dpQ09kRU9KU3dIQWVzRUhPdnFrTGJHMmVMOUxkS2t3?=
 =?utf-8?B?dDYxNGs5Rm41U2k5bDgwV2FWc2E2eTM5M1k2STJVdlFERUhCaGNmMjlKVFF6?=
 =?utf-8?B?T2lNUzVWbmJBLzdsSENTcDV6NkpGSjIySXM3V2NWemJweGpzbC8rR2NENi9w?=
 =?utf-8?B?NnZGZmN3TVZuQlNVSEZOQjJQSHpBeGhQazUxYThERXRTd3cwQVRHeG5ZU3FC?=
 =?utf-8?Q?dsDmJJgvDNI+vkHlsci4tXY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bE5YK2ZCeDBha0JaWnJvYjdOMXlUSGVoYklGeldnNW1FWUxYR2VxaWY3Sk1P?=
 =?utf-8?B?eEZKendjOHhZUHZhNFgxbUdiY3hRcWhnZ3pXcndNTGRVYjNOcnJqSHpxVnZr?=
 =?utf-8?B?VWRtWlUrRXU3TUc0K3d0ZmxFdW5kOVlpcVBhaUZEOUZLdytEclRSNVRoTUtm?=
 =?utf-8?B?QnVQSG5lV3dFb0ZndmVRV2ROVG9PY1l4aHZqb0FpdjYwYVkyQmh3WE9IaHJy?=
 =?utf-8?B?OHptQnU1TllvbXpKRkNFa1FGN0lkUTdyWnRHTXg3c2RjMll6YVRjblJncjVy?=
 =?utf-8?B?TWowekZiZFZXbnhvU05lb2licis1eGtNeXZRMzlRL2dKMUMxdDYwUEROZXdY?=
 =?utf-8?B?bElpaHptb0U2d2grOTQ5N2JCME9EUG5CcXhKdHVEN2I3blZ5MmdNNHZPemZR?=
 =?utf-8?B?dythVjRHdEpYUEZLK3dFcDRSM3Q5ZzB6MGN3Qndzak0rZ0hFS2VocEVxbXox?=
 =?utf-8?B?WGQ0S1JPMUljS2ZXY2pId2xpOTl3T3M4VFlYY0hsUjFyQUo0VFdndDRPbVFj?=
 =?utf-8?B?elMyVURwUHZpSkdrdUJ1WEJmeGtGcnkrQ1pKS2RQakJyVlZUSGhtVXBtclFU?=
 =?utf-8?B?WmxlZlZLYnBiMHVUZGNqM1Y0d2NiUFVTdzJ6bTg1TWlRTWxmdWpESVYwaDFY?=
 =?utf-8?B?aG5kUXZmbHlzeDZiaGZOT2RPcGFINElOYmZkb1R3MC93c3ZSckJ0RjFQbWE3?=
 =?utf-8?B?NklDMHA1S3FjaHQyb252QUNMNkN5d2xKcmF6SEduN1dQUFRHdDJSdXJ0bEpr?=
 =?utf-8?B?Z0xKQ0dRVWsrdkd6L0RYbFFQQWdjU0V4NVRTZjF0dm94THRvRDU3TjVYT0g2?=
 =?utf-8?B?c2k1TkRUT0dCYUNpTFdpMisyU3prcytNcjhreERON0ZBUEdJQ0IvNWtySDBE?=
 =?utf-8?B?UGwzUjl4SWJrTnV0UG1GbE5ReTBNS0NxRmVvOC8waW9pQ3RlTnVTUjY3dzlv?=
 =?utf-8?B?dnFNS0V0am9Ud1Y2NXVBNE9uVG5RTXBIK2o3Q0UrcEpIalZ3T3FwbWlQU0U5?=
 =?utf-8?B?SjBhY3p2MENzRDY3Qld6bDBMTWJCYmtGOCsyTVAxNUlFb1VjbGVpckZHNVVx?=
 =?utf-8?B?bDdpbHBSUkI0QTFralIvUXZ4MkIxcnU5OUNXb1Z4VFA0amJXQjNxUytoMXZL?=
 =?utf-8?B?L09acG1IVitFa05VWWNzVmlUeGZrUnpzMHNSRGVUeTBjbThSMytDWHpwZkNK?=
 =?utf-8?B?OEpRTVRiRDdFdFdpeWZUMHg2cXpjN1ZaL1RWdVlxZUZyeW9nMXI0Qmt1TkhJ?=
 =?utf-8?B?SllvV2FPZUNiWGFYcElVeVdOdXB3U3l6NmdKR3Z5ZFF1dFI3MU95VllDTURH?=
 =?utf-8?B?azN1WEZmT1o5VE9raFMxbFNWd3IvU2Zlb2p0Zzh4eXF3aC81eU8xbDl1M1RE?=
 =?utf-8?B?UkxKd2g2cnliQk53V01GOXZlcTVaOXhDclppUU5SZXRJZEhOVzMyeGErRWR6?=
 =?utf-8?B?QkUzaXZZZVNSNWdrTXREdVlLWEtCWTkxbDgzc1VLL2pIeGVJOWxGRHp2QktG?=
 =?utf-8?B?RzEyUVdjNDZydzJKUzlqWmcxcmpMSjEvWVFZVVg1K2VOdG0xQ1BiNWQvTmhU?=
 =?utf-8?B?b0IyTHpQU0hhRTh6L1c1ZmE3eXlXdUxvNGhZclBZWWgwWlZtVjVKaStCRmZI?=
 =?utf-8?B?TS9FY3hMQTZqMVA2aHRiaHQ1TUZzNjZaTnZFd2d1aVdlWXR1TTFCS21NNmJS?=
 =?utf-8?B?YkdWSkM1ZFI2VnFiajFCTXF6QXFManp1dWRMd25uWk9ybmlUeDVRWkpsRGF5?=
 =?utf-8?B?ZEYwbnpPQjdQeWRZMVU5eEFnckdWYkJPaSt4dEdUZUE3OHhHam1TcWoyZzZo?=
 =?utf-8?B?U25jdFFxclR3bUFEN1poUnBXdmUxNGE1Y1FIeVc1NjdLQ2tTbWg3bXpXc0JX?=
 =?utf-8?B?cUc0QTBzdTNCeTRWNEpydzJMbEc5Z0dOWlpxYmlUSWFBOWNHLzBYSjdkeWky?=
 =?utf-8?B?bnU1RUlNdU9hSmhTVDhidWRrQlFpdGlSQVRYdlZCR2J3YmYrTC9rTzQ1YXBL?=
 =?utf-8?B?UVdjQ0xES0x0RmNGRXA5NnJRQnZiSkZSTDFtb04ya0dNOC9lSXdkUVpqbjFN?=
 =?utf-8?B?ZDIreEpoQnJqNzdCVUdjR2NwN3ZlcDJkQlJJa0xaOUlGakMyd2ZVU1c0U2t0?=
 =?utf-8?B?NE9vcFA4eTN6R0dHd3ZBbXluTXJVVzExS1h0cGs1bHAralpTdUQ3V3dCNUtv?=
 =?utf-8?B?a2JIc1dKSTV4NkJWdHV3V3ZuY0Z3VjJrZ0dCeVVsK0Z0WS9wTFdwNTJQMDNN?=
 =?utf-8?B?T3ZrN0hZMDExalRQdkNFRE1nQXpYMTlGdjAzQUtmM2xYaUg5ZnE0eTZTcU5a?=
 =?utf-8?B?WnJiQjhBcFVscUlXYytHZVpUZkxGODJuREtNS3FxcnplNUJlZzQxUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14349dd3-9cf6-4c65-61a4-08de64bfc036
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 14:06:25.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KclT4GIM3TqPMPAjFYaxgJUZe2FUHDgzexZrsNTExgQLAvAERwbGwLxyxAecZwUGfyM90PZLbblXLBz4SWor6gtVwPwNR8STprhho72rhmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12949
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8760-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[tuxon.dev,kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid,tuxon.dev:email]
X-Rspamd-Queue-Id: 75A2CF3CF8
X-Rspamd-Action: no action

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMDUgRmVicnVhcnkg
MjAyNiAxMzozNA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvN10gZG1hZW5naW5lOiBzaDogcnot
ZG1hYzogQWRkIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBP
biBUaHUsIDUgRmViIDIwMjYgYXQgMTQ6MzAsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAdHV4b24uZGV2PiBPbiAxLzI2LzI2IDE3OjI4LA0KPiA+ID4gQmlqdSBEYXMgd3JvdGU6DQo+
ID4gPiA+PiBGb3IgczJpZGxlIGlzc3VlIG9uIFJaL0czTCBpcyBETUEgZGV2aWNlIGlzIGluIGFz
c2VydGVkIHN0YXRlLA0KPiA+ID4gPj4gbm90IGZvcndhcmRpbmcgYW55IElSUSB0byBjcHUgZm9y
IHdha2V1cC4NCj4gPiA+ID4+DQo+ID4gPiA+PiBGb3IgUzJSQU0gaXNzdWUgb24gUlovRzNMIGlz
IGR1cmluZyBzdXNwZW5kIGhhcmR3YXJlIHR1cm5zDQo+ID4gPiA+PiBETUFBQ0xLIG9mZi8gQXNz
ZXJ0ZWQgc3RhdGUuIENsb2NrIGZyYW13b3JrIGlzIG5vdCB0dXJuaW5nIE9uIERNQUFDTEsgYXMg
aXQgY3JpdGljYWwgY2xrLg0KPiA+ID4gPj4NCj4gPiA+ID4+IENhbiB5b3UgcGxlYXNlIGNoZWNr
IHlvdXIgVEYtQSBmb3IgdGhlIHNlY29uZCBjYXNlPyBGaXJzdCBjYXNlLA0KPiA+ID4gPj4gUlov
RzNTIG1heSBvayBmb3IgcmVzZXQgYXNzZXJ0IHN0YXRlLCBpdCBjYW4gZm9yd2FyZCBJUlFzIHRv
IENQVS4NCj4gPiA+ID4NCj4gPiA+ID4gSnVzdCB0byBzdW1tYXJpemUsIGN1cnJlbnRseSB0aGVy
ZSBhcmUgMiBkaWZmZXJlbmNlcyBpZGVudGlmaWVkIGJldHdlZW4gUlovRzNTIGFuZCBSWi9HM0w6
DQo+ID4gPiA+DQo+ID4gPiA+IFNvQyBkaWZmZXJlbmNlcyBmb3IgczJpZGxlOg0KPiA+ID4gPg0K
PiA+ID4gPiBSWi9HM1M6IENhbiB3YWtlIHRoZSBzeXN0ZW0gaWYgdGhlIERNQSBkZXZpY2UgaXMg
aW4gdGhlIGFzc2VydA0KPiA+ID4gPiBzdGF0ZQ0KPiA+ID4gPg0KPiA+ID4gPiBSWi9HM0w6IENh
bm5vdCB3YWtlIHRoZSBzeXN0ZW0gaWYgdGhlIERNQSBkZXZpY2UgaXMgaW4gdGhlIGFzc2VydCBz
dGF0ZS4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gVEYtQSBkaWZmZXJlbmNlcyBmb3IgczJy
YW06DQo+ID4gPiA+DQo+ID4gPiA+IFJaL0czUzogVEZfQSB0dXJucyBvbiBETUFfQUNMSyBkdXJp
bmcgYm9vdC9yZXN1bWUuDQo+ID4gPiA+DQo+ID4gPiA+IFJaL0czTDogVEZfQSBkb2VzIG5vdCBo
YW5kbGUgRE1BX0FDTEsgZHVyaW5nIGJvb3QvcmVzdW1lLg0KPiA+ID4NCj4gPiA+IEknbSBzZWVp
bmcgYXQgWzFdIHlvdSBhcmUgYWRkcmVzc2luZyB0aGVzZSBkaWZmZXJlbmNlcyBpbiB0aGUNCj4g
PiA+IGNsb2NrL3Jlc2V0IGRyaXZlcnMuIFdpdGggdGhhdCwgYXJlIHlvdSBzdGlsbCBjb25zaWRl
cmluZyB0aGlzIHBhdGNoIGlzIGJyZWFraW5nIHlvdXIgc3lzdGVtPw0KPiA+DQo+ID4gU3RpbGws
IHRoaW5raW5nIHdoZXRoZXIgdG8gYWRkIGNyaXRpY2FsIHJlc2V0IG9yIGdvIHdpdGggU29DIHF1
aXJrIGluIERNQSBkcml2ZXIuDQo+ID4gU29tZSBTb0NzIG5lZWQgRE1BIHNob3VsZCBiZSBkZWFz
c2VydGVkIGxpa2UgY3JpdGljYWwgY2xvY2sgdGhhdCBjYW4NCj4gPiBiZSBoYW5kbGVkIGVpdGhl
cg0KPiA+DQo+ID4gMSkgQWRkIGEgc2ltcGxlIFNvQyBxdWlyayBpbiBETUEgZHJpdmVyDQo+ID4N
Cj4gPiBPcg0KPiA+DQo+ID4gMikgSW1wbGVtZW50IGNyaXRpY2FsIHJlc2V0IGluIFNvQyBzcGVj
aWZpYyBjbG9jayBkcml2ZXIgYW5kIGNoZWNrIGZvciBhbGwgcmVzZXRzLg0KPiA+DQo+ID4gSXMg
c2ltcGxlIFNvQyBxdWlyayBpbiBETUEgZHJpdmVyLCBzb21ldGhpbmcgY2FuIGJlIGRvbmUgZm9y
IFJaL0cyTCBmYW1pbHkgU29Dcz8NCj4gDQo+IFdoYXQgaWYgdGhlIERNQSBkcml2ZXIgaXMgbm90
IGVuYWJsZWQ/DQoNClRoZSBiZWxvdyB1c2UgY2FzZXMgd2lsbCB3b3JrIChwYXRjaFsxXSAtIHJl
bW92aW5nIHRoZSBjb2RlIGZvciBkZWFzc2VydCBpbiBjcGdfcmVzdW1lKQ0KYXMgdGhlcmUgaXMg
bm8gRE1BIGRyaXZlciB0byBhc3NlcnQgdGhlIHJlc2V0Lg0KDQoxKSBzeXN0ZW0gd2lsbCBib290
IHdpdGhvdXQgRE1BIGRyaXZlcg0KMikgczJpZGxlIHdpbGwgd29yayBhcyB0aGVyZSBpcyBubyBE
TUEgZHJpdmVyIHRvIGFzc2VydCB0aGUgcmVzZXQuIA0KMykgczJyYW0gd2lsbCB3b3JrIHdpdGhv
dXQgRE1BIGRyaXZlci4NCg0KSWYgRE1BIGRyaXZlciBpcyBlbmFibGVkLCB0aGVuIHRoZXJlIGlz
IGFuIGlzc3VlIHdpdGggIHMyaWRsZQ0KYXMgRE1BIGRyaXZlciBhc3NlcnQgdGhlIHJlc2V0IGFu
ZCB3ZSBjYW5ub3QgdXNlIHNlcmlhbCBjb25zb2xlDQphcyB3YWtldXAgc291cmNlDQoNCk9uZSBz
b2x1dGlvbiBpcyBTb0MgcXVpcmsgd2lsbCBwcmV2ZW50IGFzc2VydC9kZWFzc2VydCAgb2YgdGhl
IERNQSByZXNldCBkdXJpbmcNCnN1c3BlbmQvcmVzdW1lKCkgZm9yIGFmZmVjdGVkIFNvQ3MuDQoN
Ck90aGVyIHNvbHV0aW9uIGlzIGltcGxlbWVudCB0aGUgY3JpdGljYWwgcmVzZXQgYW5kIGNoZWNr
IGZvciBhbGwgYXNzZXJ0IGNhbGxzIHRvIHNraXANCnRoZSBETUEgcmVzZXRzLg0KDQpDaGVlcnMs
DQpCaWp1DQo=

