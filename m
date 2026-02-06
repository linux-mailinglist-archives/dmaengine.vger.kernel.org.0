Return-Path: <dmaengine+bounces-8768-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBzEA3OYhWmUDwQAu9opvQ
	(envelope-from <dmaengine+bounces-8768-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 08:29:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60345FAFA8
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 08:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BFF3072DAD
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5DB30C36E;
	Fri,  6 Feb 2026 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="r3DB9tjd"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011013.outbound.protection.outlook.com [40.107.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB530C35D;
	Fri,  6 Feb 2026 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362743; cv=fail; b=iSdUOJmTr6lVB6cvslAA76cr6P0/mWYaMsbaXHBpU+2qbOVkFw7eTw9JHxYQfwksyEKNWkj/ukpDqK81rSfRnR0fNXd1xKd5Ctr2xTGSrLoUGNqzDIrmKGFdEDKjDD6jMMwa0jS1z1ogbcMfKgrR5jCVP1zgs2a1vbXO7N7uCpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362743; c=relaxed/simple;
	bh=QPe+0cHSAF/a/N1nWhXiwtSnmqp3+GaDxZiJAISp484=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGSej0zTOSxrnB6S14Q6vT1grOCWjhqVCdxDISVmHktxZI0Op+BSSefYwaZVWwfABtUE4OHbo3eLaW1m3WGdtuepCQKUalUPrJTPK9thDFSJC1A3jeC+EOqbSosnBVRvR5e7T7EXnZsvY0nLoK6W2N/rpu5+cxih7ywVZWoqLVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=r3DB9tjd; arc=fail smtp.client-ip=40.107.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPs33M6TFuO8gmOYtmK032ArHGueHxGsUX8TPib66e0OWxsJzwgq8cT/tT88YDC2dwt5iej0bSJBp/Z4/vB8b9U3wYPBbVrwpMejlTysPWHiNKI53KdBpTcNYxN/bbjqoP5Yu2F+MurNUxEoJWC3fmlY0MYL3fScSzdczRCvQvXCMaNLLBFnauwHDYOIQZTl+PRTxBGpgpCax76SK0E7j1DU9eqoOSMDLp3CLV1AT3O4xdP0SqnNQsp11432hQJooGMhPvmukTy9H3pv1Zjlw5jXFfCyODRDw/rwhHZSgJByycT8Ljphq+Zvm1lKqFU/IG2JDj9Fgfsz52eQm7lE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPe+0cHSAF/a/N1nWhXiwtSnmqp3+GaDxZiJAISp484=;
 b=l+ABZtYeTEF6OUnfSG6gLu0HmSf7ozyF5pZJonz4p18M+pUP3YSYPD9j5+KFKXC5WL8/LNb6rqubjkFa6V1XvTVUt57XycV9Pvy4nUVmuunnAGKx2R2Q43CLmHqZr047weDD4RzAiyh0HG0Yr4yTwpXZQzwapvFuqeb3VDo1JLTrwZFfPadYXV/pcSuzlLy2JYXvQ6JjpGNj7qhpyv6/R37+g38WTbGTDlhd4e/B4NO6/r2WloDvbyGQIL/cQinNlOnSa09fYK5XFC5cW7hfCDL0KQz724NoG+NmrsrZK5KeJkoSaGaMUzhDPYQcunRLNza39lEHFgo/3PLcUOrlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPe+0cHSAF/a/N1nWhXiwtSnmqp3+GaDxZiJAISp484=;
 b=r3DB9tjdluE75JhCp2VA7j0A9RjJ7icps/pfNQPSVr0B7N7SnzfeoPQAPpnjDn+eyTJ7xpQpprkFVUf3dDBgzNnVTOYzdvXZ+i4XguCrocYWg6H3MQAFDE9A/UHUVIsWxUN9VFDrtBRGcwFBLiUk3OE8vFQVsSzFrk+/G2QkY5o=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYVPR01MB11098.jpnprd01.prod.outlook.com (2603:1096:400:36d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 07:25:36 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 07:25:36 +0000
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
 AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/QgAAW+wCAAAEtcIAACGyAgAAC1MCAAAUUgIAAAEvggAAlpwCAD49ggIAAByHggAACRgCAAAWpgIAAOcKAgAAETGCAAOJLgA==
Date: Fri, 6 Feb 2026 07:25:36 +0000
Message-ID:
 <TY3PR01MB11346A05C348FE0AE83203FEA8666A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
 <TY3PR01MB1134661E4B93CE785700FC5AF8699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <32ea84f2-621a-47d9-a661-9acd62d50662@tuxon.dev>
 <TY3PR01MB113460619AE8C46BC674B28078699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113460619AE8C46BC674B28078699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYVPR01MB11098:EE_
x-ms-office365-filtering-correlation-id: ce94b364-fd83-429d-a28c-08de6550ebcf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFNKVVBwTHdpdjZ4L2VsZHRJSVZ6N0JlVmxoaE5GR0lqcWNoYWNHK2ZIOG10?=
 =?utf-8?B?TUl4V1M0UGd5eVp0VWJzaXVZMHBWbEJiWjRETWV4WVVQNk9xK0Y1aUxiOEg5?=
 =?utf-8?B?NTBUMlZ6bGNhVG1iZy81cHFrRXg1N0NQZ3BaZ3N5UW02Y0wxV3VwWitBOUoy?=
 =?utf-8?B?TUtoUHZwd1ZObVJiQ0tKRUliUXJrZVo3b2QxeVM0SjYrdXBQakw0K0FreTNX?=
 =?utf-8?B?SEJUZS9ROUM2SGx6cnpRczNDZ1JXMkIvdW9qQVBwa3pUNXFhcmYweHlxMXBy?=
 =?utf-8?B?WVJiSHhvVXlkRUZCN3VQdGZibnA2VWdjRVRhUlBQZXhuZ1ZXemFlUExaV2NF?=
 =?utf-8?B?dXprRjJCSTB1eDlFMlY3STVLdFRXc3lYb2hpd1NKeSttMHFsM1cvVXQ2MTFG?=
 =?utf-8?B?YzRsRTUrSzZMNlJUWWpqRnFWQ21mY1dmSVkrMWJYVTh4VmRyNlJoeFZiZDZ6?=
 =?utf-8?B?OXZFYWhqbHl4cUFUTkxnNXozejVqTExOc0NzTUlNYllEb0pRL0t6dllJWDMz?=
 =?utf-8?B?U0xSZHo5aURMODY5UHRjamZHemk5ZFMyRWkrWEFYcHdNL055SkROQnM2WERZ?=
 =?utf-8?B?ZFBKcmo4c3JRU1pwSUd5OTFvQml6R3pqa0J1S204aHdZSXlZdWQ2NEpQL3ZW?=
 =?utf-8?B?S2l3d3pmMWdGamw2WjVBWWZZY3J4OW1iVVU4a3UrNlVTb09GMVVXd2VrZXh5?=
 =?utf-8?B?S3FMZGNjWmM5emNkcW5VZmtFbDdpLzh3RGJQcUdPcjFGeCtlaWg3TnVKM3lD?=
 =?utf-8?B?Q1FhaU1wQUNMQm8wVFd5azJJSCtHZ0NqaGtaR0Fjc3c2QjMxNVl4TURSVEFa?=
 =?utf-8?B?d0FGcmNUcVNsUE9rdXkxNlloV0RvQVNlaW56VWJvdWlyNzhNblBoL3YyQUlm?=
 =?utf-8?B?RCttbCs2L1hjUWYzQW5hZGt4Ly9YTkZuR1oxVCtYQThvWTFNVG1DMVN5U0w3?=
 =?utf-8?B?K1lld1JFK0ZyeDNob0V4Qzg0b29BbHBVTXZHc3l4YVNDN0x6NHNqT1d0LytU?=
 =?utf-8?B?SDdUUDRxVlNEc0tTdk1ZanV6TTRwaXFwNzNRSGtUdzZoYnNPLzJQdnpGY1NG?=
 =?utf-8?B?eGRqU0JkaFZFOWFHL1BjREpabG55b1hmSExLY3AzanhON2NTbTIwY3pJd2NS?=
 =?utf-8?B?NTk3S09vSVF4bDdWOEk5Y3JEZHJPckFSbXUrSkV0T0N3QnJVN0EveUwrY2tQ?=
 =?utf-8?B?WjdNb1p1WDNPRHFHMEpoM1QvL1VxcEE2U1Q3YWRwNURZNm1GYkhiS055S2p0?=
 =?utf-8?B?dDhOTHJZbWVidnFwUzZnL0JINTMwazRMQkw5c29ENUJ5blhlQXBrU3hvUVhL?=
 =?utf-8?B?eElQLzgrSEhwNFlxbGdlN3BmMGZ0NCtBKytiSDB6RmZzZjhlRzdETmpGRmRS?=
 =?utf-8?B?cHB3KzJLS0JiUFVjRUdMWUJucVhPWTNRSDBzTDMwSWhNU2J6SzFFaUhxd3R6?=
 =?utf-8?B?Sjd3QnZEendaRk5ZSTluVEtqY1BleTE0bUgxeU1hV0dXMnJMUng1cWhBQ1pQ?=
 =?utf-8?B?Q29jVUhzZ0NJZmhURTZhK2pEdm5OMTR2MlVneWF6UldJZ1p6REhBSlpwU0JX?=
 =?utf-8?B?cUN4SVo4Sk5lc3N4MkR4MlkrV3BvSjU3SEs3T3BwcmVnRlpqNExrV1VHR0I4?=
 =?utf-8?B?cTNSbURxeVNEbWRPL1BKMDRVVUsyOXM5THdzV1ViMWxDVCtoUXNHV2d5Z0lt?=
 =?utf-8?B?ZnJQOGsrWk9pU3cyNmp0elJqcHNsS2g0VThRTjQzVDd2YjBNOVlBWHJJUzBl?=
 =?utf-8?B?U09ETzFwdzBYWjRmdEhOYzFuWkVPQnNYak5RNk90dW1JL2VJYmlUbU9XeGxk?=
 =?utf-8?B?RUZPWHZtby9zN1BlNmxNbTBoNTFvMWNHMFF1UjdHdXNNcGMxVE50TVVIOS9v?=
 =?utf-8?B?N2NDTHp2Tk9NNVh4U01CUklldTA2N1A2ZHNxblZsSWswNmtyZ0V0Ly8wa2pS?=
 =?utf-8?B?UERETHI5RkUxRzM1ME90M3g5N2ZpUlorNlBmTFBjNkc4blJUK0E2b0RLUldP?=
 =?utf-8?B?TEYrSVNYMnhUNUh4NXBNb3pOWVdGbkJTeWN4dU1uQzFiSFpZanR0RnlESE9I?=
 =?utf-8?B?ZS9ObUhxZytUTndwYzlhd2lXa2lxOUpnSUhFdTJaVnpBaElIazh6UUJzOXRp?=
 =?utf-8?B?MTNPUWFkMjlDTmVCTWt4QmZ3aWhyM1FKSEtHMnVraFMzMnc2YytjemNoNEFp?=
 =?utf-8?Q?qH4IxqqT0DpzXglM3PzoGQo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N016RTA5VUliTTlRbTZYOFRWak45L2V1di9GNHYvMmphQ201L013NHBCNlJj?=
 =?utf-8?B?cDltOFI5N2FmaThqUlB3WUhpMXNaOHdzZzc0WlFGQ202QzMrRjVMd1FmUHJi?=
 =?utf-8?B?aTNDb2tiTlVZMnRQNnBsZU1VK0xsaTdrbUxSUHk3cmVBQllmSGwrb3krNFBl?=
 =?utf-8?B?Nk91ZitjRm11NndYSzBLVFcwajZJam5SYS90MUVWbVFxdjlscXB5RUtpRTJz?=
 =?utf-8?B?Z1NwclJBVkJ1SXlBem1Nb1U0Q0lPbFh1N0ZjQ3FxYmZ4bUdRR2ZqMmViTnBp?=
 =?utf-8?B?NnVVVTdRbXNKdFhpZ1c5M3VPRWY5ZWwrV2dwbkFpODRoT3JERk9VV1l6Zlgx?=
 =?utf-8?B?VFJJcUhNdFhYbnorb1VLVXVlUjRKTmp3aS9BNVo0ZkgramVxLzRuRm5vMUhz?=
 =?utf-8?B?SVNsY3llZkVyalN2b0tuZXMyamNoWFgzeDBKQnRZbmJPdXZMYkpjTlgySU5q?=
 =?utf-8?B?WTE1LytOV3ZkNWJCN3RqdzJQOUN2azJVdVJrNjUydCtmUTQ4M3l6MUVyUG9R?=
 =?utf-8?B?d1dqRlBFa0wrRVpxUmlhc3YzOStsb2NkV2RYVEVpRmtCQjB2d3BlcmpOeFFH?=
 =?utf-8?B?cEdrNWtqaHU5MHJPYzVJMDMweDNQVmZzbHU1RFZtQ2hwcmcxY25DRHc1dW9R?=
 =?utf-8?B?YUtLWC9Xa2NLeDdRQmxPbzhCYnphWFQwVGs3aGVabURrNldibGJFdHNBSDVj?=
 =?utf-8?B?R3VZUyttYnVZdHdSUllQWm9RUXYzQTVGUFJJK011eUpBODkya2cyV3IxRnZw?=
 =?utf-8?B?cSs0eEErWXBpVHhnVFR0V1oyVFJNa0o5Wk50dUxkOGVQVWQ2VWVxU3Rzcy9j?=
 =?utf-8?B?WEdERkZ6dTdXMm5McFprakNxelpjYjErTEVTOHNQVVhHNG5wYjVUUFBlUldX?=
 =?utf-8?B?M21Xd2NVRStPUmVrOWJxUXErRjdUdmNFa2lEWWlkbzQzS1ZnZDUzMmM3Z3Bp?=
 =?utf-8?B?citSQ1M3R05qbS9jcU9uZ24zR0hSQXhSU2F4Q2VhMmUrLzd2a2dkUlIya1dK?=
 =?utf-8?B?b2FESVlFQ2xhVjEyR3QwQkl5ZTljT1JUYm9zanpsa0p4UjhxaFE3eTFGYnZN?=
 =?utf-8?B?T3ZiMjIyaXFPTmN4V2UxeEIwd3B3RVFZbXBudlFUaElPa3l1WFBJWk5rb0dD?=
 =?utf-8?B?RVN6RUFnVHFNS3d5SDBVRXpUa3UwTWVnYTNhcVBsSmo1RXB5dW5XL1VRNkFV?=
 =?utf-8?B?ZlVjSWdSMlpxL0U2cVlkN3A0VThBR3FiVEdrQkM1QVpCUHRSTThVTmFOS2x3?=
 =?utf-8?B?bmd4TGFFV1BKc1E1ekw1ZnZhL0N5NXRpOGlaT0tlSGd3NExiRGFmTDY5ZjlZ?=
 =?utf-8?B?MXB4ZUpCNmV3T2FJZlhDSUtEckhvbGV5OWFPY0pmOWtQSldPMmVoTmxHQm9x?=
 =?utf-8?B?alJQZHFJeFBxTHRNc25RTk01UXdIQU40WFlkL3RGN2dYVlh0UVJSTitRdEQ0?=
 =?utf-8?B?clhlZU05S0RwUHdMVmxUL1BzblFjSExuY3BWVjdJaUFjNVduZkc4eXdrUjhN?=
 =?utf-8?B?WnU4UEJkVk1WMVQvOWh6OUZncnVIY3NybkpaRG9MT2FxNWZGMmQrVS85L2p1?=
 =?utf-8?B?L1loYzc2Mm1rRDdaN2o1U3ZuMDFlemZta1RITFBFZWV2K3A0ZTRucDY2Y2RY?=
 =?utf-8?B?M25OM2g1UXdWUmNaZGJSWHlIekFBKzRSWktLbUdZM3hzS2VIak5SMmllUzNY?=
 =?utf-8?B?eDhBT252MzVVbXEzUVJ5dzJQOUd5QUJ2eWNWWkFvSTVpdlJjWWozUVdsQVVD?=
 =?utf-8?B?N29OVkpGcUQzZDdTTUduOWFTdVRCaUpVUWx5WHVzYU9aRy8xRllZaXpua000?=
 =?utf-8?B?aG5lT0FhVnRhbXF0RTlsYjBEelhOdTRYVkt5TFJWT1h5bVhUL3FCeHZKYk01?=
 =?utf-8?B?aEh0cElvd2hWN0crdVlOVWRONnFxM2pLNllkUnhZbDNhbzR3WlBxbkV3L1J3?=
 =?utf-8?B?Ukc1ZVBodDRJUXBkVVJnYXVSUWI4UjNPbUdwdHQwU3pmaFFqU3ZoZk0xemJk?=
 =?utf-8?B?bVloMWZpbXc1eVBFUGFvMDhwRUs0bkZzOWtGZmdwd0hSWjhMLytTZ3FqOFVj?=
 =?utf-8?B?ZElrV2xPN1J6amp3ekhNdGpCN0ZLMTlkWmIvZVJTZmI4SVloQUdhWDNlZnAx?=
 =?utf-8?B?YUc3Q01BMjlxZHVkRm5Wc296N05CdHMyVEJ0c0w5Ykhvakx5aDRCQlBnbldI?=
 =?utf-8?B?ZkZuUDRIS2Y1dU5jQWtwQ0cwV1VUK3RZcTcvNnMwdjdjZHJkbHVBOGZlM1dq?=
 =?utf-8?B?UlNvTnphd3VSQWVqMXNXZjV1UWpwcU05Z3J0THo4Tkk3djdoWFZxZzlyRlNU?=
 =?utf-8?B?S2NZZ1crcWhXV3U4RXRWdi9OOG1RaUUvUlU5TWF6WjROSUQ4WmRnZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce94b364-fd83-429d-a28c-08de6550ebcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 07:25:36.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGNHnZDm75MV5c+smGvFK/P5jdJ0Nf8AvX5dCf2eo1dSskZEuKhb+h1KdEsKaH1vXV44rWBABgTunQA0tbBo41Q0StWMSGGhOWPSjC3NBSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11098
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
	TAGGED_FROM(0.00)[bounces-8768-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,tuxon.dev:email,renesas.com:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 60345FAFA8
X-Rspamd-Action: no action

SGkgQWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpanUgRGFz
DQo+IFNlbnQ6IDA1IEZlYnJ1YXJ5IDIwMjYgMTc6NDINCj4gU3ViamVjdDogUkU6IFtQQVRDSCA1
LzddIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6IEFkZCBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0DQo+
IA0KPiBIaSBDbGF1ZGl1LA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4gU2Vu
dDogMDUgRmVicnVhcnkgMjAyNiAxNzoyMQ0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83XSBk
bWFlbmdpbmU6IHNoOiByei1kbWFjOiBBZGQgc3VzcGVuZCB0byBSQU0NCj4gPiBzdXBwb3J0DQo+
ID4NCj4gPiBIaSwgQmlqdSwNCj4gPg0KPiA+IE9uIDIvNS8yNiAxNjowNiwgQmlqdSBEYXMgd3Jv
dGU6DQo+ID4gPiBIaSBHZWVydCwNCj4gPiA+DQo+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsu
b3JnPg0KPiA+ID4+IFNlbnQ6IDA1IEZlYnJ1YXJ5IDIwMjYgMTM6MzQNCj4gPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIDUvN10gZG1hZW5naW5lOiBzaDogcnotZG1hYzogQWRkIHN1c3BlbmQgdG8g
UkFNDQo+ID4gPj4gc3VwcG9ydA0KPiA+ID4+DQo+ID4gPj4gSGkgQmlqdSwNCj4gPiA+Pg0KPiA+
ID4+IE9uIFRodSwgNSBGZWIgMjAyNiBhdCAxNDozMCwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+Pj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYUB0dXhvbi5kZXY+IE9uIDEvMjYvMjYgMTc6MjgsDQo+ID4gPj4+PiBCaWp1IERh
cyB3cm90ZToNCj4gPiA+Pj4+Pj4gRm9yIHMyaWRsZSBpc3N1ZSBvbiBSWi9HM0wgaXMgRE1BIGRl
dmljZSBpcyBpbiBhc3NlcnRlZCBzdGF0ZSwNCj4gPiA+Pj4+Pj4gbm90IGZvcndhcmRpbmcgYW55
IElSUSB0byBjcHUgZm9yIHdha2V1cC4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gRm9yIFMyUkFN
IGlzc3VlIG9uIFJaL0czTCBpcyBkdXJpbmcgc3VzcGVuZCBoYXJkd2FyZSB0dXJucw0KPiA+ID4+
Pj4+PiBETUFBQ0xLIG9mZi8gQXNzZXJ0ZWQgc3RhdGUuIENsb2NrIGZyYW13b3JrIGlzIG5vdCB0
dXJuaW5nIE9uIERNQUFDTEsgYXMgaXQgY3JpdGljYWwgY2xrLg0KPiA+ID4+Pj4+Pg0KPiA+ID4+
Pj4+PiBDYW4geW91IHBsZWFzZSBjaGVjayB5b3VyIFRGLUEgZm9yIHRoZSBzZWNvbmQgY2FzZT8g
Rmlyc3QgY2FzZSwNCj4gPiA+Pj4+Pj4gUlovRzNTIG1heSBvayBmb3IgcmVzZXQgYXNzZXJ0IHN0
YXRlLCBpdCBjYW4gZm9yd2FyZCBJUlFzIHRvIENQVS4NCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IEp1
c3QgdG8gc3VtbWFyaXplLCBjdXJyZW50bHkgdGhlcmUgYXJlIDIgZGlmZmVyZW5jZXMgaWRlbnRp
ZmllZCBiZXR3ZWVuIFJaL0czUyBhbmQgUlovRzNMOg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gU29D
IGRpZmZlcmVuY2VzIGZvciBzMmlkbGU6DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBSWi9HM1M6IENh
biB3YWtlIHRoZSBzeXN0ZW0gaWYgdGhlIERNQSBkZXZpY2UgaXMgaW4gdGhlIGFzc2VydA0KPiA+
ID4+Pj4+IHN0YXRlDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBSWi9HM0w6IENhbm5vdCB3YWtlIHRo
ZSBzeXN0ZW0gaWYgdGhlIERNQSBkZXZpY2UgaXMgaW4gdGhlIGFzc2VydCBzdGF0ZS4NCj4gPiA+
Pj4+Pg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gVEYtQSBkaWZmZXJlbmNlcyBmb3IgczJyYW06DQo+
ID4gPj4+Pj4NCj4gPiA+Pj4+PiBSWi9HM1M6IFRGX0EgdHVybnMgb24gRE1BX0FDTEsgZHVyaW5n
IGJvb3QvcmVzdW1lLg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gUlovRzNMOiBURl9BIGRvZXMgbm90
IGhhbmRsZSBETUFfQUNMSyBkdXJpbmcgYm9vdC9yZXN1bWUuDQo+ID4gPj4+Pg0KPiA+ID4+Pj4g
SSdtIHNlZWluZyBhdCBbMV0geW91IGFyZSBhZGRyZXNzaW5nIHRoZXNlIGRpZmZlcmVuY2VzIGlu
IHRoZQ0KPiA+ID4+Pj4gY2xvY2svcmVzZXQgZHJpdmVycy4gV2l0aCB0aGF0LCBhcmUgeW91IHN0
aWxsIGNvbnNpZGVyaW5nIHRoaXMgcGF0Y2ggaXMgYnJlYWtpbmcgeW91ciBzeXN0ZW0/DQo+ID4g
Pj4+DQo+ID4gPj4+IFN0aWxsLCB0aGlua2luZyB3aGV0aGVyIHRvIGFkZCBjcml0aWNhbCByZXNl
dCBvciBnbyB3aXRoIFNvQyBxdWlyayBpbiBETUEgZHJpdmVyLg0KPiA+ID4+PiBTb21lIFNvQ3Mg
bmVlZCBETUEgc2hvdWxkIGJlIGRlYXNzZXJ0ZWQgbGlrZSBjcml0aWNhbCBjbG9jayB0aGF0DQo+
ID4gPj4+IGNhbiBiZSBoYW5kbGVkIGVpdGhlcg0KPiA+ID4+Pg0KPiA+ID4+PiAxKSBBZGQgYSBz
aW1wbGUgU29DIHF1aXJrIGluIERNQSBkcml2ZXINCj4gPiA+Pj4NCj4gPiA+Pj4gT3INCj4gPiA+
Pj4NCj4gPiA+Pj4gMikgSW1wbGVtZW50IGNyaXRpY2FsIHJlc2V0IGluIFNvQyBzcGVjaWZpYyBj
bG9jayBkcml2ZXIgYW5kIGNoZWNrIGZvciBhbGwgcmVzZXRzLg0KPiA+ID4+Pg0KPiA+ID4+PiBJ
cyBzaW1wbGUgU29DIHF1aXJrIGluIERNQSBkcml2ZXIsIHNvbWV0aGluZyBjYW4gYmUgZG9uZSBm
b3IgUlovRzJMIGZhbWlseSBTb0NzPw0KPiA+ID4+DQo+ID4gPj4gV2hhdCBpZiB0aGUgRE1BIGRy
aXZlciBpcyBub3QgZW5hYmxlZD8NCj4gPiA+DQo+ID4gPiBUaGUgYmVsb3cgdXNlIGNhc2VzIHdp
bGwgd29yayAocGF0Y2hbMV0gLSByZW1vdmluZyB0aGUgY29kZSBmb3INCj4gPiA+IGRlYXNzZXJ0
IGluIGNwZ19yZXN1bWUpIGFzIHRoZXJlIGlzIG5vIERNQSBkcml2ZXIgdG8gYXNzZXJ0IHRoZSBy
ZXNldC4NCj4gPiA+DQo+ID4gPiAxKSBzeXN0ZW0gd2lsbCBib290IHdpdGhvdXQgRE1BIGRyaXZl
cg0KPiA+ID4gMikgczJpZGxlIHdpbGwgd29yayBhcyB0aGVyZSBpcyBubyBETUEgZHJpdmVyIHRv
IGFzc2VydCB0aGUgcmVzZXQuDQo+ID4gPiAzKSBzMnJhbSB3aWxsIHdvcmsgd2l0aG91dCBETUEg
ZHJpdmVyLg0KPiA+ID4NCj4gPiA+IElmIERNQSBkcml2ZXIgaXMgZW5hYmxlZCwgdGhlbiB0aGVy
ZSBpcyBhbiBpc3N1ZSB3aXRoICBzMmlkbGUgYXMgRE1BDQo+ID4gPiBkcml2ZXIgYXNzZXJ0IHRo
ZSByZXNldCBhbmQgd2UgY2Fubm90IHVzZSBzZXJpYWwgY29uc29sZSBhcyB3YWtldXANCj4gPiA+
IHNvdXJjZQ0KPiA+DQo+ID4gSSB0aGluayB3ZSdyZSB0YWtpbmcgaGVyZSBhYm91dCBib3RoIERN
QSBjbG9ja3MgYW5kIHJlc2V0cy4NCj4gPg0KPiA+IFdoYXQgaWYgdGhlIERNQSBjbG9ja3MgYXJl
IGRlY2xhcmVkIGNyaXRpY2FsIGluIExpbnV4IGFuZCBjbG9ja3MgYW5kDQo+ID4gcmVzZXRzIGFy
ZSBub3QgaGFuZGxlZCBieSBib290bG9hZGVyIGluIHByb2JlIG9yIHJlc3VtZT8gV2hvIHdpbGwg
cmVzdG9yZSBjcml0aWNhbCBjbG9ja3M/DQo+IA0KPiBQYXRjaCBbMV0gd2lsbCByZXN0b3JlIGNy
aXRpY2FsIGNsb2Nrcy4NCj4gPg0KPiA+ID4NCj4gPiA+IE9uZSBzb2x1dGlvbiBpcyBTb0MgcXVp
cmsgd2lsbCBwcmV2ZW50IGFzc2VydC9kZWFzc2VydCAgb2YgdGhlIERNQQ0KPiA+ID4gcmVzZXQg
ZHVyaW5nDQo+ID4gPiBzdXNwZW5kL3Jlc3VtZSgpIGZvciBhZmZlY3RlZCBTb0NzLg0KPiA+DQo+
ID4gVGhpcyBjYW4ndCB3b3JrIHcvbyB0YWtpbmcgY2FyZSBvZiB0aGUgRE1BIGNsb2NrcyBpbiB0
aGUgY2xvY2sgZHJpdmVyDQo+ID4gcmVzdW1lIGZ1bmN0aW9uIChpbiBjYXNlIERNQSBjbG9ja3Mg
YXJlIGNyaXRpY2FsKS4gSWYgc28sIHdoeSBoYW5kbGluZyBETUEgY2xvY2tzIGFuZCByZXNldHMN
Cj4gZGlmZmVyZW50bHk/DQo+IA0KPiANCj4gV2hhdCB3aWxsIHlvdSBwcmVmZXINCj4gDQo+IGEg
c2luZ2xlIGNoZWNrIGluIHN1c3BlbmQvcmVzdW1lIG9mIERNQSBkcml2ZXI/DQo+IA0KPiBPcg0K
PiANCj4gQXJvdW5kIDEwMCBjaGVja3MgaW4gc3VzcGVuZC9yZXN1bWUgaW4gY2xvY2sgZHJpdmVy
IGZvciBjaGVja2luZyBjcml0aWNhbCByZXNldHMgZm9yIHNraXBwaW5nIERNQQ0KPiByZXNldD8N
Cg0KSnVzdCBGWUksDQoNCldpdGggcGF0Y2ggWzFdIGFsb25lICsgRE1BIGFzIGNyaXRpY2FsIGNs
b2NrIGFsbCB0aGUgdXNlIGNhc2Ugd29ya3Mgb24gUlovRzNMLg0KDQoxKSBTeXN0ZW0gY2FuIGJv
b3Qgd2l0aG91dCBETUEgZHJpdmVyDQoyKSBzMmlkbGUgd2l0aCBzZXJpYWwgd2FrZXVwIHdvcmtz
IHdpdGggRE1BIGFzc2VydCBpbiBETUEgZHJpdmVyDQozKSBzMnJhbSB3b3Jrcy4NCjQpIHN5c3Rl
bSBjYW4gYm9vdCB3aXRob3V0IGJvb3Rsb2FkZXIgdHVybmluZyBETUEgY2xvY2tzL3Jlc2V0cy4N
Cg0KVGhlIGlzc3VlIHdlIGFyZSBkaXNjdXNzaW5nLCBpZiB3ZSByZW1vdmUsIHRoZSBjcGdfc3Vz
cGVuZCBjb2RlIGZyb20gcGF0Y2hbMV0NCnRoYXQgd2lsbCBsZWFkIHRvIHMyaWRsZSBicmVha2Fn
ZSB3aXRoIHNlcmlhbCBjb25zb2xlIGFzIHdha2V1cCBzb3VyY2UgYmVjYXVzZQ0KdGhpcyBwYXRj
aCBkb2VzIGEgRE1BIGFzc2VydCBhbmQgU2VyaWFsIElSUSBpcyBub3Qgcm91dGVkIHRvIENQVSBm
b3IgV2FrZXVwLg0KDQoNClNvLCBlaXRoZXIgaW1wbGVtZW50IG9uZSBvZiB0aGUgc29sdXRpb25z
IHRvIHN1cHBvcnQgdGhpcyBwYXRjaA0KDQoxKSBJbXBsZW1lbnQgY3JpdGljYWwgcmVzZXQgaW4g
cmVzZXQgZnJhbWV3b3JrDQoNCjIpIGN1c3RvbSBpbXBsZW1lbnRhdGlvbiBpbiBSZW5lc2FzIHJl
c2V0IGRyaXZlcg0KDQozKSBVc2luZyBTb0MgY29tcGF0aWJsZSBhbmQgYXZvaWQgYXNzZXJ0IGlu
IERNQSBkcml2ZXIgaW4gYWZmZWN0ZWQgU29DcyANCg0KNCkganVzdCB1c2UgcGF0Y2ggWzFdDQoN
Ckxvb2tpbmcgZm9yIGVmZmljaWVudCBoYW5kbGluZyBmb3IgdGhpcyBzMmlkbGUgYnJlYWthZ2Ug
d2l0aCBzZXJpYWwgY29uc29sZQ0KYXMgd2FrZXVwIHNvdXJjZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
DQoNCg==

