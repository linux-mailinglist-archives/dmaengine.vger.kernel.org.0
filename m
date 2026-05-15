Return-Path: <dmaengine+bounces-10478-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFWcB8vdBmp4ogIAu9opvQ
	(envelope-from <dmaengine+bounces-10478-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 10:48:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58854BAE4
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 10:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 323F03015A61
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47803368D53;
	Fri, 15 May 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RyRv7AV+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010014.outbound.protection.outlook.com [52.101.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D776126F3B;
	Fri, 15 May 2026 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834669; cv=fail; b=dyXmU20fSEpzDpEZKY9ES3sC+SoYn04cp5uEGDfH9f7thuAhbiNVODPgG0fmSNshCQ54Ph1FRV4B5eA7W/dlo6Qwk/z9UJQVxsuHHG7iVDJcjhCWYOIScXi7er744ipOW/rIEctAbWs7Aw/TuESLKPp3E7HNKAlH6XpVfkroVMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834669; c=relaxed/simple;
	bh=7BnjnTMEx2NMvk3u4Wl+5em3iOQhso4i8PlfXrxlngs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhCuX0TS2sFh6LkpYL7Hqu/ILSGP1ojQB/FaGVD0qM55J9h9IKPUb/9c0Yc6c+3h5k3ieZtwqnDQ+ew7gY3PGKCYQiPNq1yLZIaGhi8er15YFpGgUV0Wd0Aa5174DawfIqHxwpqSomelKufBER6scgMX+OjsOem5QjNI1rl3lZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RyRv7AV+; arc=fail smtp.client-ip=52.101.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoScUzXudqxdV3gIPh/sAcwfNUMf2mHxtbRTyWs4FoSJcjRVcwW9G2BFRPBrBHsrJJXXNXyWPinxbysarmIdLmAeK7/LwscNEA9/C4Lie5pVo/usnu0Cx1zkG8CGZlN2FNt9vO2oH3ZetOrzKBmicDYZe0BJl/scqoeZkxrPnFZIZj3tZdoBXAv2aBjUeLhpCs5G2or1ll0dxmDOdcuVh847Z71c6R+dw2FqZin5Zgs7niI51+dDon1WqiNRQdvYVrWa46ibH1aA5QBxFx/mOTeey/I+um9Zzec738ONLYQLQQEIKLp9bFGtNammP1prUwHRV/psSSiB2DT8nKiKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X302SStUAVinxZL7G/S7ZQu8NI4ET5kaXxRr6XPokQ=;
 b=WtOVlCYdt54c+FGLVUXRt1gi73bBYmuDJRXVd4BsKxlJgUYAEyB4xJSXkxqO0usxN+780sPQZpfzg5DnzAuZ6hSkyHRnXSX6iUtkOwpMqsRiTeMONDbc+yAVJpi1UwZlua7ScuIeFbTH6ykv4YjxqIVYvyTqwZBTzK/Am23n9UGyhEB8sDopc2g2g+2jxAdPOR8vkrfZizI4BMV0p21Lh3btGaWBrXhVbdD2O2ft3W0/xrcCKDf8hmvjsKAVGBxQYCDaqYJQwNcnorfkMcSBwUg2Cct+Nm3KB+IzokigJs2gVzsBDLUUzgpyGnuYTUELQQ8fmhj/auThqEyD0Py5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X302SStUAVinxZL7G/S7ZQu8NI4ET5kaXxRr6XPokQ=;
 b=RyRv7AV+zLxC/L5Td4tyOio2nUQ2G9mUdf+83CMwcaLkb0WCaKki86eSR+5e4UdpGTvRoXRRqOJ2evN5tW+3B98HFol26FO7lDTP1Q/SCqYJYCNlUXsNMMOlu7RmNvfGPVkx9wUe/W9XeSMWIQME8lwSgjGD34cB94PvYl1HL1E=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYVPR01MB11366.jpnprd01.prod.outlook.com (2603:1096:400:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 08:44:24 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 08:44:24 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Biju Das <biju.das.jz@bp.renesas.com>, Prabhakar Mahadev
 Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Long Luu
	<long.luu.ur@renesas.com>
CC: "claudiu.beznea@kernel.org" <claudiu.beznea@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 00/17] Renesas: dmaengine and ASoC fixes
Thread-Topic: [PATCH v5 00/17] Renesas: dmaengine and ASoC fixes
Thread-Index: AQJUtISbF+JA9DApvXbDe0PFu5cYurUfIYsw
Date: Fri, 15 May 2026 08:44:24 +0000
Message-ID:
 <TY6PR01MB17377E4E020C1CA30413F6099FF042@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYVPR01MB11366:EE_
x-ms-office365-filtering-correlation-id: 3d361e21-b220-42a1-b3d9-08deb25e2a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020|22082099003|56012099003|18002099003|11063799003;
x-microsoft-antispam-message-info:
 7XWEsaEd+SxkJf8v0oZEC92H3U5NokDBpFfF6LbrYLQZvJUSxCCW9GXoeAiczCuiaUrZfJESjNbf9bGL63G39PZWvV/38eipVHoDP5OCc99etcbE4r1rkCpn9eF3pYprhdF5i2GlQTQ+bQxvKva2Noxo9P8kNgUhE/+WQNlOcZeldso8q3Nk4IsnCGAPIYTQZtxH7+xSdYQ04AZjAwWG0X4FdBa3pHckNjuRGmqbk7Jc0wC7Nzs8wXhsRkbkDpnyW3R0da0s6o4WnvHUXzoOmuIu0bxTo9YlDRwMK7c498DKE0if3sjEERy+bN/Sz6ilKnBn23I4DKUu+kTnyz//C5y8TqaMVQsSoHKLK5fe/927YdRAzR2gBh5UXKfsP4eWRfcHpsLIj6D4+JaHd48/qlbrhmCA0/6xGXKtNU+iF+Xm37D1ObrrWTB1TpAu0p+tx4oITmzDsi23DCBvnciBM+QLaxljTK5znsuXheeUeRS1FqcJxr2g3RdcKdufhSOnmo2Sq80w3Ushnk+2MgU+/BOJ0RRA02RoomHOvNpLomeuUWU6GXKolx6yBzlt1jIcRYylP9wERFr9mxqVwEInUoyKhWPUIbC/T6X53QfA7LcKPxrZ1xxPv+DwCTsB6/1DKBZfl1cPLWDCbhqVgJds82IVAcPcB85D1rrf32PsIdsFfMk08HwuCatj2+a2LbVYRocDqGCZZNCzKPrqIqOWWtOUKz2YRO/FbnYgJEgGG4rIqOMGHxAQqhZ7YBVXchYy//5CYbVCgpdsiQeAO/wkeQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JegT2LIlUoxbp5W1GEHhT9IEJovpavioY554BU4Zh38Mq/A+R1yK36tNMA1j?=
 =?us-ascii?Q?ZX53KFurx7M+mwjntBx7z/nXyquU10w1f7acGnohOZB7gxI2s4M2b5+w5wAv?=
 =?us-ascii?Q?46zr4doTo6Xk5j2ShJRBv8qeqMet+CrJRsu6QQ4uEStYBlvkG1d7hIHzIU+V?=
 =?us-ascii?Q?b+HhV4TeNlel7nJGIzSzEPcwMh6ch2TkVPGFocclX2RCYxdBga26nQklKcBy?=
 =?us-ascii?Q?18OIGMNPq2W/8BjdyOHTE5XAliMTUfsmUX5/6+ywesQJOpTHtgsMOhxRBCpR?=
 =?us-ascii?Q?r/T8ibBkyX6osmySkZqxvslbw9FFv9DB7C0gKNe3Mxj7/jPzeguvpPfRgs9p?=
 =?us-ascii?Q?oQWgjQKT24OR1xsXgiUdok7NqrQMrCTkqb3J89LiE0wj7qQP2hoi4OmaZeux?=
 =?us-ascii?Q?lbRck+94QXI9nP6NMgQeaHvb5ukM/86kYt1oxOOLcQ1rnV+UqzdA2mt3OWoE?=
 =?us-ascii?Q?oj83BQnpobOMy/FlseldhZinnP+QE+/2qxX1R5lrQNoCdot+H37T4+b/GufJ?=
 =?us-ascii?Q?ntomeLHEK9OJ2ZjwDiP9oJMjqy1FICfHigE+FUtEcUGVMqRUWsIUghEstuy6?=
 =?us-ascii?Q?F540AVk1w74Dtlr4qyDhYDMwkGt/iQkqZtEaOTqbXsHIroAgitRTs4Vmmbze?=
 =?us-ascii?Q?TJl5ZOFxND532LpTlcL0bFtOqKsmtU0Mq7JnfdrvoYP+Ntf1EB48jDkJn5gp?=
 =?us-ascii?Q?yKwuMw2kgl+Xuo1Qn0cGUw4QxB7drEPMW3++vep7fVSffAF1SbVRV9eNFKos?=
 =?us-ascii?Q?1xt4odwGJI9vcVk9M9UH+BSqoreygP6KKU1I1kbTDadDEP7yYb0VQl73Va+R?=
 =?us-ascii?Q?Y4iXfUSHwoS53PyYD37/XwFNl5x51i37+dikr5M9p6Nv2HEIoZt64dvLLXwq?=
 =?us-ascii?Q?B7FCMqnU1356gKYCbnQpIzUjf/XgzGFR+T1TbkDFN20Ye5i8WwKTA0JiMo4q?=
 =?us-ascii?Q?Qmnw/ftU7tCs2rgLMRiUjyRuZIt01GVpfMB/3XRJqcGXeNkhI2VP7j/Za3XL?=
 =?us-ascii?Q?Zgj/7vEZP0wC9C5hXoe0rzONoQdLD+J9MLtgwtpeasnxP6/SImk3uvVXP/DU?=
 =?us-ascii?Q?bjRALtxhcsv75xhjFB12H3m0tdwvFZq3Fx+Hmh6AVWJGoV+AALIKM5kmkVTX?=
 =?us-ascii?Q?giA20ghvUSB8jQg4FpYMyyXsGPDpXUirv5OYDx4SQbntEHpuB0GG1Zwxb/uF?=
 =?us-ascii?Q?gf8/mpPLYLHKK1Q1BQUnTXchnd/tt7GrLDgA4MOZZJwGzN/zWvCy7JvCHCAc?=
 =?us-ascii?Q?CcxZANhq44bWUe1sN8GQWYQPLGYsojhcAGH5AxlgNjhlO3Z+PZ/A4bvJ/DXR?=
 =?us-ascii?Q?wuu4Um233ZGIe+OuGesNqHCXVVK55NGH+1Qv046iRrY9Jm8x1v8jtmr78j4m?=
 =?us-ascii?Q?vgogV7GkYoQE0fmE/GD9/+vCGNvbdCQMDv91zxLJeEMl72yUfiiBb0Q43zdX?=
 =?us-ascii?Q?VjTovwi0fdvTXY2xogCrfRrkyW5oNhNmYo7U9gxAzPtfb10pxWtSd4tYPtqM?=
 =?us-ascii?Q?AJDDrFfEJZx+4ezDa0Tg1iBnNRsu2qrWKoI8T1c1oCZq7R8rQk38GP5ltnOc?=
 =?us-ascii?Q?qrdk8QAl2y1E3hJ71XqzgvJZWapvLsSw7VmaAim4gFC3AmRn63KR48oD0TSC?=
 =?us-ascii?Q?764HdFm9y+mp8Qg+Ao58HEZV+Qs+I5duu3n/vj9aNV9KrtDr62RZeRC16f5G?=
 =?us-ascii?Q?Y9eg5ggONK4zqzCy4T4frRHd429iOt+0aEuvZSG6UGUia6TzmzhGU17dPWhC?=
 =?us-ascii?Q?kJiRfeeS9ScawaBf+VRwtd9dm+3NLy4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d361e21-b220-42a1-b3d9-08deb25e2a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 08:44:24.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdMafLzOmAWASP+/Mh7yW62HQY04ZpImT5ACuN3/GFSdNfm7PZSg/TAKE4d94yL7lOOJU5BhSFN1jUoN6PRsadnYUymJuCRBt6BW7lQKFXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11366
X-Rspamd-Queue-Id: 8D58854BAE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10478-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,pengutronix.de:email]
X-Rspamd-Action: no action

Hi Claudiu,

Thank you for your series.

> -----Original Message-----
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Sent: Dienstag, 12. Mai 2026 14:12
> To: vkoul@kernel.org; Frank.Li@kernel.org; lgirdwood@gmail.com;
> broonie@kernel.org; perex@perex.cz; tiwai@suse.com;
> biju.das.jz@bp.renesas.com; prabhakar.mahadev-lad.rj@bp.renesas.com;
> p.zabel@pengutronix.de; geert+renesas@glider.be;
> fabrizio.castro.jz@renesas.com; kuninori.morimoto.gx@renesas.com;
> long.luu.ur@renesas.com
> Subject: [PATCH v5 00/17] Renesas: dmaengine and ASoC fixes
>=20
> Hi,
>=20
> This series addresses issues identified in the DMA engine and RZ SSI
> drivers.
>=20
> As described in the patch "dmaengine: sh: rz-dmac: Set the Link End (LE)
> bit on the last descriptor", stress testing on the Renesas RZ/G2L SoC
> showed that starting all available DMA channels could cause the system to
> stall after several hours of operation. This issue was resolved by settin=
g
> the Link End bit on the last descriptor of a DMA transfer.
>=20
> However, after applying that fix, the SSI audio driver began to suffer
> from frequent overruns and underruns. This was caused by the way the SSI
> driver emulated cyclic DMA transfers: at the start of playback/capture it
> initially enqueued 4 DMA descriptors as single SG transfers, and upon
> completion of each descriptor, a new one was enqueued. Since there was no
> indication to the DMA hardware where the descriptor list ended (though th=
e
> LE bit), the DMA engine continued transferring until the audio stream was
> stopped. From time to time, audio signal spikes were observed in the
> recorded file with this approach.
>=20
> To address these issue, cyclic DMA support was added to the DMA engine
> driver, and the SSI audio driver was reworked to use this support via the
> generic PCM dmaengine APIs.
>=20
> Due to the behavior described above, no Fixes tags were added to the
> patches in this series, and all patches should be merged through the same
> tree.
>=20
> In case this series will be merged this release cycle, as the audio
> patches are acked, best would be to go though the DMA tree.
>=20
> Thank you,
> Claudiu

Tested with RZ/G3E audio. With that,

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>

>=20
> Changes in v5:
> - dropped patch "dmaengine: sh: rz-dmac: Do not disable the channel on
> error"
> - added patch "dmaengine: sh: rz-dmac: Add runtime PM support"
>=20
> Changes in v4:
> - collected tags
> - addressed review comments got from sashiko.dev. For this:
> - added patches:
> -- dmaengine: sh: rz-dmac: Move interrupt request after everything is set
> up
> -- dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()
>=20
> Changes in v3:
> - addressed review comments got from sashiko.dev. For this:
> - added patches 1-9
> - added patch "ASoC: renesas: rz-ssi: Add pause support"
> - dropped patches:
> -- dmaengine: sh: rz-dmac: Add enable status bit
> -- dmaengine: sh: rz-dmac: Add pause status bit
>=20
> Changes in v2:
> - fixed typos in patch descriptions and patch titles
> - updated "ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs"
>   to fix the PIO mode
> - in patch "dmaengine: sh: rz-dmac: Add suspend to RAM support"
>   clear the RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED status bit for
>   channel w/o RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL
> - per-patch updates can be found in individual patches changelog
> - rebased on top of next-20260319
> - updated the cover letter
>=20
> Claudiu Beznea (17):
>   dmaengine: sh: rz-dmac: Move interrupt request after everything is set
>     up
>   dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()
>   dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
>   dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
>   dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
>   dmaengine: sh: rz-dmac: Save the start LM descriptor
>   dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
>   dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
>   dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor
>     processing
>   dmaengine: sh: rz-dmac: Refactor pause/resume code
>   dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with
>     CHCTRL_SETEN
>   dmaengine: sh: rz-dmac: Add cyclic DMA support
>   dmaengine: sh: rz-dmac: Add runtime PM support
>   dmaengine: sh: rz-dmac: Add suspend to RAM support
>   ASoC: renesas: rz-ssi: Add pause support
>   ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
>   dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last
>     descriptor
>=20
>  drivers/dma/sh/rz-dmac.c   | 827 ++++++++++++++++++++++++++-----------
>  sound/soc/renesas/Kconfig  |   1 +
>  sound/soc/renesas/rz-ssi.c | 393 ++++++------------
>  3 files changed, 726 insertions(+), 495 deletions(-)
>=20
> --
> 2.43.0
>=20


