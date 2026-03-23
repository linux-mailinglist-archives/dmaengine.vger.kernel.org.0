Return-Path: <dmaengine+bounces-9577-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDW6HzybwGnKJAQAu9opvQ
	(envelope-from <dmaengine+bounces-9577-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:45:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4A2EB953
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FF8030028D0
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336A3D561;
	Mon, 23 Mar 2026 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="l+j3DSpk"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010028.outbound.protection.outlook.com [52.101.229.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5542AD00;
	Mon, 23 Mar 2026 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230326; cv=fail; b=LcPFe8RZb52PjalbIFCH6gWyMdgpWMPimV13J8DSdcQGP73E3hZqOnfJoYy6inpuUFMMo51FnOdBREMeSz7s8yNyLyBSf5ODqmS48dZQreajN3ndZlVC5OhB1jrJWVF0rXX0qhhJeWvU3hGiSCp/oNq7WKO7EJt6GYv0oKgv868=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230326; c=relaxed/simple;
	bh=ED0hzKMtrtK5jGMBBJp96JqM+ueH6L0bgps7rRzEacI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=B4HDRCeI3Kprbd/7MKrJcstwp+40z+4aH0+LwYlnU93Oaly33T7BsaPJoYsGboPM4jMUIQR1HQyodHEmJNUYvqK7vfRU0xzVMuifzc3zAqmNJm3ginIFj+zYdBdE950+BdMFqaNEkhwu0iXkEjylD3Nw+pdoqRJKN9fE2QWzxQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=l+j3DSpk; arc=fail smtp.client-ip=52.101.229.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfWj0bOByk8MshXQaqRt5+kLK0KlycdWGMgIkccbTYySQ0GLVTvC461oE5H+DjM0mvkxl6tIM17NY6bvcPlQwl7UmG92ywFRyjr89cSpm8rbQIYbSP+w2uH9Zw2MAxYdZVA0j4CedNe6kvh7q2bi6lvtUEnZNPmJDp9A5R7ymul97gHWD8o5LtRIMaktPmMDgndVUF4jT93NNBvQUy7+WyS4JILP5m1S3ma+BBnyUN4tWGsHQIKgZtjP0XavjeuakoGuE7oCNiWdPGWhyKwbcN41tRJuPs30n4veTtpvy7lcqvIGwmz6vHHa7axe2nUcSXAXEOkSJ88JJcONJWaq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yygulYtLPFwffb7gpXlgD0S9pbpdMatquc2mUZFcSs=;
 b=vcj1Dl+J1Z3XlH9I2xVIm6hx63Sg1+li+HX0ip74+WysYu6p5jLkNihzx4R98lagVMBXgh1hGLG3kJ7etRT5Ioi7CVujxohqBHe1ztQC0DztseQ33J/hfp2P+LUGAbfo91IB7mqF4VgxxYSZKBnh6GRN2OHK4Eapefs6kuZ4iS9a2b7AAGdbWFPpeOoXp6H+N/ZVT5jc6Lv1l1BwKmCjgk/peaTBc1f/ThpzvXtf15fKEG7evdMxj1mckqtwVcq+KXWCuHYj1MKiW/tBBtbY3iz92rrdopUK5Q5wnzGu5C1yh+2jvdgIHAz/1VqY39GU5ehRfJ+8Pawl4cqm7M+ldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yygulYtLPFwffb7gpXlgD0S9pbpdMatquc2mUZFcSs=;
 b=l+j3DSpkbXP30gSOtO50ZwWmYPEMiXW9NS/EWFD/oIR4ewC4MEi6wb7nvVRQNPC0EmmDyKaMmzXO6StnE7xul4Iw1b5IUOS9B9noVdKFW5u+Dc/xgIXRCbUfe5Muqs6ZL0JdhnEYIuEurWFrQz0MTwtiyPESAHxEYdIjOF1+aSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYYPR01MB15206.jpnprd01.prod.outlook.com (2603:1096:405:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 01:45:03 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:45:12 +0000
Message-ID: <87a4vz9v4g.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 16/22] ASoC: rsnd: Export module getters for PM support
In-Reply-To: <20260319155334.51278-17-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-17-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 01:45:11 +0000
X-ClientProxiedBy: OSTP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:216::12) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYYPR01MB15206:EE_
X-MS-Office365-Filtering-Correlation-Id: 071fedae-a812-4bf4-6082-08de887dd318
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	m7+Epf/whpsaXFj1O06QLH/F9fmjdGZdwiyeDUFh1stXO9ZvW1wWCcbSqqmrb5NJEQYbzfbqWzIXxn14B73jjn2yTpXcGuTq7rlwhlsuU6pT1wfPI3Y2/k6IKglRGNMOLZwt7GZgZiYEi4z44Yfe+L6x3AQBskPW/8rV/Y1H9Eane4UT2B1QJomqp4ud4pyQobvXgpVlJ4+LqiTKciBrhqQg/ogH3sLUnrO9++pe1nrr9maWYzup9ysgojRVvWZWBU3f+1JMqvdBk/pNZEtjePU8MJ8y+YQb43Hzr7H4Dl6iDw1GPDobCGVVvaB4FWfIcr214qpBLXfdw1jnQmhjxr+AKWDRLYa6ZgzymL/Ikpk4Mtqm0NwOmuJd/BUK+VDNRbBVjXRz8YDigIGyTcUVcyeJNuM5u3VXbIB54oz2FyhCXF2LAw4bFh5IAVsZEKwFaqzzf+K1aXNlW8BAFkVTdnlglDGZzbytQA7hzy1BHFotyEQnt3w1yxPT2ZkqeHXD3NS+E+RODurQWMzWhXaeXomBLMHy5GPB6GasU06TzrW7OlfDGxSaeMNNauZItHRBCp2mHOXf2psbiyJls2advoXRh3cBTLb1H6Ar+r5xNKVl2exqLLGZ+w9JgQ7Gmnu0KPCxMilxrrfWN8cQx1S4eRVdVPm1qFiFfia8B7NVokGFKf2NM4HMz6u4yuox5787tE4pDFO2k2ip/26AmJz6gOGo4mXOdjSZH8HPgn8c0gpmbZyfyuR7gSxiGYtjFS7dgSOJxiDJHF/fnsZNaewF6PU72QjH7/d2ClUox2K2avA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wp0bbHnRPzaqNA4WC6qckhjVU1D5iEKv9yerXf+v5wGreUd0GSB12FU1KQPW?=
 =?us-ascii?Q?VMnvMZ/qwbzWy8s0W5FPaK2DahbjH7Z+9T2h+0siVeTw+Ew+Qn8uAnROKRMw?=
 =?us-ascii?Q?4ukSjiNBNrLrNZFt04YWxfUVr3p+eBjWdMhEo67ZrfM28kKU6yRz8q1Z0kHO?=
 =?us-ascii?Q?oMryaSz999y4gLT5H/13dvDfxS/lekfqM9f16rqivdbGqpTwzEUOhQQTaYmN?=
 =?us-ascii?Q?KlTK90PyHLXEOF2S6tRM7+7msbUSaMum+GWyJPYFY1xICTyf4BQ1Z6O04w0/?=
 =?us-ascii?Q?T73EDZeFgRkomQ9lp0hw3/MZD4yND6Ze8C0QsjOYTgkOmJpGGUJzwDcT/Nc2?=
 =?us-ascii?Q?TsTyXa4sT/ASeFd7sQtxOPGiB1RJImkc2AYtJuSo4FAXJuRrqa060Zy/b05B?=
 =?us-ascii?Q?qjYTTlfxaDXyVQqrb+N+80WV/A2XszpsHxNHDeYq1psj8qIOpKGAjsragdR2?=
 =?us-ascii?Q?A2HaypjNmUOK9bPmYi45/rab2d4r0xohXEDXWfHy0LLVDNl6YBHivn3lLlkR?=
 =?us-ascii?Q?77JB8hlMChvZAgESTsfNqFtZ5M7eevMTJqVMCpzwuK44lCWueI/CuKk3HsYo?=
 =?us-ascii?Q?T9yBk1jdbSUZCAE1hURT2PZ4BQDg2v3+RE/z/5pGp3TodWi50lOhP0qwePj2?=
 =?us-ascii?Q?RPvpBuVfGhILjCEEKaDdCOSgVHy27YMRdrD0Yp8j5a5aULPxlo83Km6odOH3?=
 =?us-ascii?Q?VJRYRvOIplewRkyCJ3cOnXwQ2VZbadhKNyj3BYv803NvgJie2vi5/ltPtxgI?=
 =?us-ascii?Q?IczIog863xaE8TpQjhOtL54jWyKu6HPE+wtF6KGBpEpf5JFcAzKviFJa9NT2?=
 =?us-ascii?Q?nnMJbgbPXEMCL7vTH7epGBM6fhjWpVxh7l4rhjithrVEbaHguq2amGzlUj9y?=
 =?us-ascii?Q?M7wVGgN0lWfBsdf+Ho5DD6zyEqtAPTlsaTu8IKRZl4Yx281CteOWmwmI623S?=
 =?us-ascii?Q?cq/6iIKiurWIBK8NQhhUnXR+O1KHMmrMR+uBF3IcgT7DqQw/OAwdxr/89SOk?=
 =?us-ascii?Q?wzG5ec5yewv+rGeCbuK4TKx+UOC6qtxXrEK3oWPTY1SjOjPsKeIfdMJpnMP0?=
 =?us-ascii?Q?gwbORcHTBu4BerbYy8noonFxHGVpwAkaAAkmBHZYeevGHlz6Cski/2scUsbb?=
 =?us-ascii?Q?BDp4W1FIr3w3EA9ueWOyVM5hF/hijPq0m4wNo34cRy+cCYxDQPVaO4BztLp7?=
 =?us-ascii?Q?l+W7c2oqFKxvXSREn+My5+d5r7/E4YT6woLVlma8H2W2Be6lDzKryd3Dp8wx?=
 =?us-ascii?Q?hOvur182s+/K/g8j/TlFzxCr24l3E5OLE/kzVvyTVB5BZ+n8OfEo0qWZWAz9?=
 =?us-ascii?Q?e7/mdu0Yk6UcRk5DfQZkVNtCyCLYyG8HpuRea28jRqlZ18plH6eDwYuPE3gh?=
 =?us-ascii?Q?NZ906xRbsxv6lVIA37aaRaI9Z9xgeW9KWLbXTK3WJlWo+wW7GUmQAjGPm81N?=
 =?us-ascii?Q?lmJ/aVobsynkLMN0F4Hzule9tP5EF3nAI8ugwlAP8wzAYANmwm2RIWY2GkLO?=
 =?us-ascii?Q?Nlc37KPnPRFXdKPV6rAecl9drg6/Xar7DSpa6c8uXvvUQWwNnu+WVYj2YICb?=
 =?us-ascii?Q?P4oRZYSnJOZ+T2LYbTymxJ38s4+LBXSmGsBxpvPnOOBsTGmdVxQ9j8TMioWl?=
 =?us-ascii?Q?/Pk0sg/7x9Ts6E6wTkBAl5BzMw8vzkfi0EVui/IBMlkwpLE08jJ3IIF8w+B0?=
 =?us-ascii?Q?IfPW8Je3WrtY32oL3y0HVKo5ih73v2KCLgiZ7Wtc2tUFQ1DhjTQLdWo0RGI8?=
 =?us-ascii?Q?Obcxh0afQrZ9v3WHMdlDIRJBu0u9btYuRW/H4dTNM8kq9svyRaAv?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071fedae-a812-4bf4-6082-08de887dd318
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:45:12.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BU3K8Oh9lytYQv6f17JRKj0eMypWfFYxbRkUwPCPaUlFSdmcCwFb1ysF27lq8F+0XB/VDNwrOZh44cD4jcdul98H85wcDAZIUAaxi0cJ3RJPU+hztFQhYhyqqR4KCAH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15206
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9577-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78C4A2EB953
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> Export rsnd_adg_mod_get() and rsnd_ssiu_mod_get() to make them
> accessible from core.c.

It is *adding* new rsnd_ssiu_mod_get(),
and exporting rsnd_ssiu_mod_get() different type of features

> 
> This is preparation for system suspend/resume support, where the PM
> callbacks need to iterate over all modules to save and restore their
> clock and reset state. Other modules (SSI, SRC, CTU, MIX, DVC) already
> have their getters exported.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>  sound/soc/renesas/rcar/adg.c  | 10 ++++++++++
>  sound/soc/renesas/rcar/rsnd.h |  2 ++
>  sound/soc/renesas/rcar/ssiu.c |  2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
> index 131a60689f6d..d73f29bc9de7 100644
> --- a/sound/soc/renesas/rcar/adg.c
> +++ b/sound/soc/renesas/rcar/adg.c
> @@ -906,6 +906,16 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
>  	return 0;
>  }
>  
> +struct rsnd_mod *rsnd_adg_mod_get(struct rsnd_priv *priv)
> +{
> +	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
> +
> +	if (!adg)
> +		return NULL;
> +
> +	return rsnd_mod_get(adg);
> +}
> +
>  void rsnd_adg_remove(struct rsnd_priv *priv)
>  {
>  	struct device *dev = rsnd_priv_to_dev(priv);
> diff --git a/sound/soc/renesas/rcar/rsnd.h b/sound/soc/renesas/rcar/rsnd.h
> index a803c0f03665..2cee5c2aa7d7 100644
> --- a/sound/soc/renesas/rcar/rsnd.h
> +++ b/sound/soc/renesas/rcar/rsnd.h
> @@ -628,6 +628,7 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *cmd_mod,
>  #define rsnd_adg_clk_disable(priv)	rsnd_adg_clk_control(priv, 0)
>  int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable);
>  void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct seq_file *m);
> +struct rsnd_mod *rsnd_adg_mod_get(struct rsnd_priv *priv);
>  
>  /*
>   *	R-Car sound priv
> @@ -824,6 +825,7 @@ int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
>  int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
>  
>  #define rsnd_ssi_of_node(priv) rsnd_parse_of_node(priv, RSND_NODE_SSI)
> +struct rsnd_mod *rsnd_ssiu_mod_get(struct rsnd_priv *priv, int id);
>  void rsnd_parse_connect_ssi(struct rsnd_dai *rdai,
>  			    struct device_node *playback,
>  			    struct device_node *capture);
> diff --git a/sound/soc/renesas/rcar/ssiu.c b/sound/soc/renesas/rcar/ssiu.c
> index f377d9414633..1462f02c2a7f 100644
> --- a/sound/soc/renesas/rcar/ssiu.c
> +++ b/sound/soc/renesas/rcar/ssiu.c
> @@ -434,7 +434,7 @@ static struct rsnd_mod_ops rsnd_ssiu_ops_gen2 = {
>  	DEBUG_INFO
>  };
>  
> -static struct rsnd_mod *rsnd_ssiu_mod_get(struct rsnd_priv *priv, int id)
> +struct rsnd_mod *rsnd_ssiu_mod_get(struct rsnd_priv *priv, int id)
>  {
>  	if (WARN_ON(id < 0 || id >= rsnd_ssiu_nr(priv)))
>  		id = 0;
> -- 
> 2.25.1
> 

