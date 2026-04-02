Return-Path: <dmaengine+bounces-9868-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHTSI8qLzmlMoQYAu9opvQ
	(envelope-from <dmaengine+bounces-9868-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:31:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F42F38B4A2
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E3A130388CE
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818033D7D6F;
	Thu,  2 Apr 2026 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Emwcrm5c"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010029.outbound.protection.outlook.com [52.101.228.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993135AC0F;
	Thu,  2 Apr 2026 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143827; cv=fail; b=ENg4iitmzRFxJUq9iMa9o2aCwz1Lm5F6tuBmmbee9jZTq+TdQwtwX1fahjtM+4Iiq34qsyboBPLyzC4zXgNnF+ZCtu/nynGaQ+5baypF4N5HQB/6wXbVHw0EXY2u+Y+En6RnGOepzwhb4a8vCLz/PZMrhbTyAPfzvTqYT841wh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143827; c=relaxed/simple;
	bh=jOBh1EOtZ5MMSBRVn1T6wcgL8elv+xLM3jhUj59teOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTGrr/6v47QPDYsdkV/YeRhF314j3l0c/dnD/jNdojvPT6KBhnyMi7MnderOcg07EGOloVM8pQTLvwW1zN4hYPaiMALFRM55+bDn+ErbI3iXfp4YTplnbtEWRjxqFVlWDO3ofwbrMnaIDbV+vPysAQuI+qF4MzcrcLUm6MH3BWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Emwcrm5c; arc=fail smtp.client-ip=52.101.228.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0cMgkLNN920JAc1xUKburybkv64VKJXeh7jDXGpaKFlxiuuMW9aqY/BUSHjEAWSpLYdd5lN7TsFoOMys5iJO1f/Bttenqxs04S1rIQe/aPIZ2bi3qJCknd90h03diUbFfej1YOaM/zXlDhlf41G+3SmVDDGLvkw86KrvkSQy1AStfmq7ifGTHEKgc8w6SO8nlG2hwc01/ab/k8Kfb9Jsn20Nlex9dRtc2lt7tnEFobNVHrLmtvyBBZGTaTCWs37TReppWWClRcyc2pBWMzQvhBR5bObQWovH9AWC2ui80AXyADrp0gNp3cJpzux2HaZ/Bo9mJREttK6+F457+FayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxnsUjesHEauAet9SLo5DAAaJ1FLSzYClRDS8190R7A=;
 b=kInbRbW6w0UZoTzDTIcjZpIqRjvxwysIZGS4khYk8wzjAg6bCx7/UDxSndY+xr3orNKc4ZbyI6yeunk9hbyUm1aFptgUxbAPJzXeXvvKVDB2zq9Xm+HWn6gNFtiPwYdbROFU+bgWen4Gn5JUqyxjJFLZfIIsJoW+GcTJQ8sFaajhICkLnmsDLM5W9X3hrZsJN15EETD+ki+4ZkNUXBMyOwD0gtunE57A7aS4PHc7CoyxYTrQjIM76Xd8LOoso/PkYU0w/pdaCQAD3Ao1jtCs7f4SQtQmVeUEncfRCUems7spHAidnEoGolaLcdSAWmPg3M5AENiTyRYvCQWKqCNLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxnsUjesHEauAet9SLo5DAAaJ1FLSzYClRDS8190R7A=;
 b=Emwcrm5cU2XQJdUQ+KPEkPTu4t1//K2VRkAN64p5RCWhwJs1Ny8I5ZlQ/8GjZZClJBVkw0IXqovgmTTzc1eDDabHwtp9+/88mQCxWfRo4oWPmiguu8RatKMWGL2V7Imlx+5qS16NLHpZv+pSE31xZqXM3GDL808m7OsZ6QOw2ps=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB14650.jpnprd01.prod.outlook.com (2603:1096:405:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 15:30:23 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 15:30:22 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
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
Subject: RE: [PATCH v2 00/24] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Thread-Topic: [PATCH v2 00/24] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Thread-Index: AQHcwoAViEoTPRneNUuLlOmr0wZP9bXLqigAgAA7coA=
Date: Thu, 2 Apr 2026 15:30:22 +0000
Message-ID:
 <TY6PR01MB17377F712DF6B99132952619DFF51A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
 <0c5afdbd-1348-4c61-b036-89adafeb5109@sirena.org.uk>
In-Reply-To: <0c5afdbd-1348-4c61-b036-89adafeb5109@sirena.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TY4PR01MB14650:EE_
x-ms-office365-filtering-correlation-id: a3b03ba8-8e8d-4b39-8c3c-08de90ccc198
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 2Wl2pLBpU5yTHg65el5EYuk8DyiChNltydNj1okDwpE+AdvU6uPUIylKS9okJ8CsWW9JYZxM/srTZi5kmMciA5l3lxV9OBWmXXWwyH6Pz70BvIZjdsKQwRQuVWR0Y0ajxCYHyTqo4OS259uYNP8IYzNKSY3lT5dDf0XMjKzPNeC1MJ8kojzplKvhDE3/7dHs9GuQNLU+hlmzWj9gidGA2LwE89Df5h8HaeP4LiRZHjI9mHzlBBLJIkQiEUdnaSMbPPncbTQGBxT2H7vjQMRcnkcHjpgxFB1xOiz7WUZWM2+vmaIpgvsxR2bFuqxVUXLOb4DLqdhzWlIcfGneJcxgxx3CJ1FWm8s3fKpdqZCjEI8qkCgxwrtba36J1LcN2SQ05Wp71zEM9HZOsQoYcvWkhBc3LTqsqVgsslmhp8/vLZvFe7n/lWy7R2gtMH5CX0tmHOaJnDkdQtMJDx4IFAZrmX0apJmRUDiBzaXZPZ21X/pjI44fz5BCRHFFHtWVxhFN4wVniXToPrnbT5w0pHyMuCKDUnEhAP9e6vPe/czTSxmjkrh4Ksp73B7v0D/0VmqX+/oCKggkEh7dQrFRSFRi3Q6a7d+ZVSJAIciLYLaFJLflNa0xD7duJVGy+yVbfEHYsTYWeicp9Qcx25x33Cv14ImTyLMChosKZyEndG9pFSv7vNyV5XLmze3qqfy9Y2P26kHXhe4+oBff+rr4PqJ0R9H9zhr/kp8QYenPRM5tF+YjC717nuP1n8gbrZ07Vcan
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jUxmBFyCp1r++18CRFO+KRHeVQou/dwZHUxbR4smXNC7hB/6+K4GUjzy6Crl?=
 =?us-ascii?Q?/TCn0cQ/X257mp22ZOLaE+FqaBwLTyrDP+GUHhrJ6fB8NsX3tUJG0u58SiBP?=
 =?us-ascii?Q?mNswDCitlQ6/vLopBtPW61PDpBYIuJoZ69y1g7l+EqjZs8f1dBC7iwW8BtWU?=
 =?us-ascii?Q?0hJZ/qwzpFSIIkIcxL11CsV4EtVbDg+ZcYNUzhu2eC/G6oNv0lDvmPVkUd5f?=
 =?us-ascii?Q?BRfuWdPZYEdyKdKrhQK1vEUUwqidoqwKVY3FO23DKS48iZkSXr85GAv9V97r?=
 =?us-ascii?Q?heIlgvjKDslpXnTp/PpTW5laMctJ2S1dwu9DEUB1axTb3GU+qPLITstY+Buk?=
 =?us-ascii?Q?bqdBrv7GgZ7cRgkTTjdXA+HhE/D58f7IUyklhUr74FOwim1CHDMZ1hmWO6t3?=
 =?us-ascii?Q?HQQFneYXJyCKBt9M8T9fvL3Zjjhsjw9QAinIkvMnyn2lAbu9wtVrsDkfoTWq?=
 =?us-ascii?Q?v5Ghflg8/OgK+t0Qiod4hInkQqPfxjId3dvY/XiNhVdWEhP0xqM13gY14SPc?=
 =?us-ascii?Q?J6geG1xrQ9xKtohqGqxYvoVM/g0TPCnU2twDdTQTyk76Zwp5ugGNL7JJPLRO?=
 =?us-ascii?Q?fN7c3xqkUdFKJyBe5jzeZM/AgJWaZLuU8/PAMIg8hgoQu4XHRp8gHp2AlpLm?=
 =?us-ascii?Q?q742U+RduA9tvY8nVr3FZiPlGurJ7yymZVpZaw7EE2SVMJx5tWIAfpS0GljT?=
 =?us-ascii?Q?EBMcNviy7vPvcoU/oq5dPi69Rsb9AcQ2zAnNvP9mRiXv3CEFagJzgy0d0f4U?=
 =?us-ascii?Q?eM4abPISTGjfxi8q/WKEu8ysSFYMP4mkAB5sxQU28AEs1nKrcYU6XIC1PMPO?=
 =?us-ascii?Q?Xrdu53dzykoynEkvtFIzg1ERr8smRt4uFfGhjXfAYgVFbEOavufsc90lj+Ak?=
 =?us-ascii?Q?6mpML9+enJuoRFly4TR1GHNx2M/CtvwC8GExlfIWgjCG1qZnTvleRsITxFvn?=
 =?us-ascii?Q?RGUf//AB0HW4Z9cWuqSmRruS+AqdM2O4rnIt0BwUMw2ALnqhWV8I3vm30EN/?=
 =?us-ascii?Q?eEp0M2+ezaTXWI1z6TG2nvbuUQXhvX51qgPXEclkqfCrC7hKMDD7he0vnaz3?=
 =?us-ascii?Q?hYst0FWyuLfNaXQPksz+j3BqvFLF/ESR97gVXIOKHXYl5heG2sniAc3OgBF3?=
 =?us-ascii?Q?weFYHqCxO9yiPst2aDVcp6GSL2Gkkar9SJZ78lcWv4X0YpBGeaqD7UsHYDI4?=
 =?us-ascii?Q?CXyqwYf7LWUndvTW11xaTLAuoEzMhLkkTWo9+yatkXNsTAK/l0byaIRNn8/e?=
 =?us-ascii?Q?WmR7tTbkTVgLOG8uE0OxqwqOhynIkJmWbh6657T3cdeIAHKI+VwWwu2gdGnk?=
 =?us-ascii?Q?b7s5fazs1hzakM0/YdmOUT7Ic3lWWvv4H3gUnapCqiAdpHzeBoY2MKwX2Zwe?=
 =?us-ascii?Q?lXJDN9jWg8Yh+noDACG+VAnX9WZYiBKIXqu5Ol8LcNlw/uLj/1UEVRfSEsdD?=
 =?us-ascii?Q?szFK9rgmTZkaMYXmTHdqiyNpoNiUrynGVrdFZCd1lyGwVmw2Im5EBhWPgiW/?=
 =?us-ascii?Q?yc/qm7HzmfMV+0rBnZ0vibvUSz8LNS6Ulog6POTE+EC84Pdu3xoGkjEzawNG?=
 =?us-ascii?Q?4CQaXH1KrwNkCNx2l1DYJQYxTr5M7/jQ7rBBAEbOnrHz8fg60UHhm9tB36vp?=
 =?us-ascii?Q?rrJzphtIH4kb41//jXn7HMIUDzMtKPu6BifYVuSYSDNxaSn8PzyKQ/f2xhSy?=
 =?us-ascii?Q?69lcGgyvz6MJe+fuYZQ5JzOw68hjCR8zfovSaQGPlpf1lbBSgI/icHy1z5YN?=
 =?us-ascii?Q?mjBQRfamazsjC4+3fAOOlphy07x30s0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b03ba8-8e8d-4b39-8c3c-08de90ccc198
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 15:30:22.8620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mp4L3NEHeokRjiukKllkMsdlVissMqrth+lAGS4jeFR0FiPo072Wj4UOznX4W9/hCqaEKvWP3hkjMsEhiGD2xe4+uLSaZRdlVvtWvKo/9Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14650
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9868-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:url,bp.renesas.com:dkim,renesas.com:email,TY6PR01MB17377.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 2F42F38B4A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mark,

Thanks for the feedback.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, April 2, 2026 1:55 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH v2 00/24] ASoC: rsnd: Add audio support for the
> Renesas RZ/G3E SoC
>=20
> On Thu, Apr 02, 2026 at 11:04:59AM +0200, John Madieu wrote:
>=20
> > This series adds audio support for the Renesas RZ/G3E SoC and enables
> > it on the SMARC EVK board with the Dialog DA7212 codec.
>=20
> > The RZ/G3E audio subsystem is based on R-Car Sound IP but has several
> > differences requiring dedicated handling:
> >   - SSI operates exclusively in BUSIF mode (no PIO)
> >   - 2 BUSIF channels per SSI instead of 4/8 on R-Car
> >   - Different register offsets for SCU, ADG, SSIU, and SSI
> >   - Per-SSI ADG and SSIF supply clocks
> >   - DMA ACK signal routing through ICU
> >
> > This series includes:
> >   - Clock driver support for audio clocks and resets
> >   - DT bindings update for DMA ACK signal field
> >   - IRQ chip extension for DMA ACK signal routing
> >   - RZ-DMAC driver updates for ACK signal support
> >   - R-Car Sound driver updates for RZ/G3E support
> >   - System suspend/resume support
> >   - Device tree nodes for RZ/G3E SMARC EVK
>=20
> You said you were going to separate out the serieses:
>=20
> https://lore.kernel.org/all/TY6PR01MB173779BDE4BE11739D3B7DAACFF4FA@TY6PR=
0
> 1MB17377.jpnprd01.prod.outlook.com/

My bad. Sorry for not taking care of it. I'll split into
subsystem-specific serieses and send the v3.

Regards,
John


