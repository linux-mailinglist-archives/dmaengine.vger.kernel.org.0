Return-Path: <dmaengine+bounces-9572-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0bxKEqaNwGnkIgQAu9opvQ
	(envelope-from <dmaengine+bounces-9572-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:47:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 964CF2EB496
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 516C030073FC
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 00:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFD1632DD;
	Mon, 23 Mar 2026 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="k+qvMZ3M"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011020.outbound.protection.outlook.com [40.107.74.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA06286A4;
	Mon, 23 Mar 2026 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774226849; cv=fail; b=samRdlAhwDU/+3h8Y+mBVejm18dBtNDB2Q4Sl3rv+vDLV4Oq+PctvnKL2DCZX9tJgZlAAZVfvxAr8pOeRpG26ltswhI+sYSVbEB2LOkk93YTHy5pcYh8a5EA7ZkyE5kGhOwUtlEfRg67hvwSG3X6lUg3kZ2WtlPkkitU/xjKTYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774226849; c=relaxed/simple;
	bh=/x+YXy04o5xhxKToWscAd2fQ2UnIV3Vgvdm630q9N4I=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=H9nEXxB3yqsuejpUCENCYcAkRrh68WqjuPG/R+tFQ0xHuzcOq+tGoSq+3P57VPVCV/wVu53s3UuWcwxl5qVcGyxv3S5KxE6CievlafeZmLHJD+tKFRowIaYaXxvf31n4TLvcc5wvLQgAG9NPgiy2CK9qM/S98uzHYPKIDU3zt64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=k+qvMZ3M; arc=fail smtp.client-ip=40.107.74.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwRLDJeVUNMnlzKCL7zdGT4FU63wU2fgXeB6IObygQFG4qZo82Cox8pUVZDHbrCvm2l0qIE9CP2oP6UESGbvNb24rMVTlVQKqd1K9xM/trvukz2qhQAAqtWi7UFZ/YrIkf//N0md7Tt3AYpZS19Rg+VfBWNggkN89nqdN0xvL8zNJFGwmW4iip9+3utAb+M9vvM7yh3P2yE01G1aIgT0qKolJLPo8s7ctwzmfBewL34tkCE1x2YrxoGdqkxz8k1xYwH7oQYIYhbjv3l5/50bOoB3AVsxF/7VmReeUuOVTI28a6XqGIZf1gUP0NuooWgXNlyC0yv85QcC+KIFCINqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Orj5RXPCHMOXEOx1CvYsWLqdAKT6D3IbBy8xiZVPgD0=;
 b=Wj9xHQzIePX2eJySyjSVYDgGK0ZL7iIOrpOJeDQYLw85KtYmQVbxiGP6M5W4chMYVSHNXmD4b0F3xuPFgv7o2UW9MASEAjuXwGXY66OgqinajLBWPyfcpLuzfjOSFeBxn7bhfDQ0w9JtG5RGZrISlbSpHwxsPI+pJTv7YZLuVNXL18j+4ps1TsJFpz3FSyi7W+xGLFV2tNDCjlHoBqVoBLx5P0iTNn8BPuq98YNWks75glP8YX2rzGBY8reC9k0meivZYV8YdLyw/PYVoL8/0X62L+Jq9JbxiWK2NyfLzgeiZ3zQbYr/qSpn9uZiQHWXDaTQaFP80DxJqa0++unDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Orj5RXPCHMOXEOx1CvYsWLqdAKT6D3IbBy8xiZVPgD0=;
 b=k+qvMZ3MC6qqaq3rAdmFiB/Uy6tRtBV0VUXKhcQ/tFzDsol67LqefM+E2ooazLkEJzeSRv0m6LTx6eBfCn6O2kN6K6PR1p4DE+RPT7X7IRwXdMMRRkbZwPKcoxvuU6ANUAdhJSPcF3OW5NoJK14VoN3y0Dmu1v+dYKhG7Bn5KqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYRPR01MB13759.jpnprd01.prod.outlook.com (2603:1096:405:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 00:47:07 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 00:47:12 +0000
Message-ID: <87ldfj9xt3.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 09/22] ASoC: rsnd: Add RZ/G3E SoC probing and register map
In-Reply-To: <20260319155334.51278-10-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-10-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 00:47:11 +0000
X-ClientProxiedBy: OS3P301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21f::16) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYRPR01MB13759:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acd109a-eee7-41e6-8b73-08de8875b8b8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R9e/nFz9pD9UGGnbDcjJn31n/X9BRsFc6bPKPZUGx3h9XEuuQEMbfVqmOCgyV4mC6Fjof11DTnGDrHDPdEpc2O28VUCXMy+ZB2z+QY9F2SB0y/n3J6C0UittbqLpUot13edeSn9Vr9rJ5Q+v38L5kgeiaM5RBw8ua6n9S1VH+v2y3EtmPll2i5N3nFr1Bbx5tpauZZoRZjp+3KMtASCZWSiNKPhhsd2gJm+j7g3XBeDFi0nCkTJDxwx0N1pKSdq0WvnuxQxf/0iHKSeCtLSU7TuPy341Gv8c0Y8yuEI03uvPw3LmMtA5uxKwWn2Mq6obrODA7QhKhMH91p6n/3yxvBw49jxTeXCr7aK+2+Ch7ZWD28OGmwgnzunajtukGjvrxhuWUKUzz0NMZw/qacHkOX9mLa/K0u7EfkLFvDTopZUDDdc/fq8iEX1VtzAvO1sys9BGfLGzHMfG6BkNxcOvunqMEwfuwsl8OPpgfCutrvzRW1dRVPo8cNyC6yghiB+p90N4OphsxHjc5aQIZ8337jY9Duf/LGQnp0zXUJxcqE4N73cQ2DzHD1ksCUxmZlY93OQPnqLoYV3akSgniNnHCn/ffY1VY8+MnFHEN0hKsIU8IXPIL5uhxRm2q+BD4tCS+yj5m6XrKF9SgPMDbtCbKmmDBllYjsgzsLZAfgP6d21Lw93mdxQYbebrkXqu9j3khFA6kMvfdfYsCwVt2s2Ud1yDW8QOaqCU3vvOSRCMdd9diplHieE2ozps83ufwAKVyLDjg6mRWUFRnMhfQPknP+6YQXR6K2RNe2c4iaOnH8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqoZSUDGlUjQlx3i1fmBa4YwUDKIoWRN8seuuedv9FLta7cVSOQkCJ2BEc97?=
 =?us-ascii?Q?X3pl0mctDf/uLQ1MzwXiyzG9Yt691vsMt1ZJy9mWNdcVRIvYkkfjgtCTEAnC?=
 =?us-ascii?Q?taFrN4i2KNwL64kz7kDV7aQ/eUfKmTU4AFXc90oFea2AylobJ6M9Ijs8oljv?=
 =?us-ascii?Q?YYnb0EG8RGKkAFHw6dYFckgJ8SGkLv5wT9mkcmSoCUlMuJGWv0M3X3PLz9Ls?=
 =?us-ascii?Q?G2+BURh/qHiA5Vfd8trZJaEEN2mUDJF8jB0WjH3c3lcgzs2ifZBT3zB9aapf?=
 =?us-ascii?Q?FIz7SgQPe6Nm4YHaSR7BkBtMvsCtZsbCcD6dDh9T6RPX5LlwSp+yXfhwfj7A?=
 =?us-ascii?Q?BLEktFAiqemp0xYjffq3dDCXUS7q7VElZvA7rruy5lDFqW0/gbtDhop5V2sI?=
 =?us-ascii?Q?2f9k3s5BDSCWGuAETFtixrWu60qLZZyv+WrP8G1cDOS5xSTkERHcHZrXIUYH?=
 =?us-ascii?Q?uDnl1JRVBNNo7tr9B78/U/uCEPPKkRTk0I82TqVRRrtJelmcOaXARTs7rOCH?=
 =?us-ascii?Q?mxobI6Lf9lAR8tJ6S6nr+Bpjf3foCfC/iZNu7/YcMM9p/rUKLxKpJ9t0nuJj?=
 =?us-ascii?Q?4QwsCNvfnLFMvzolfMSLwC6f8vvbLg6/HJIVxDtLVBYPur7xgKtz/Dav5Cy3?=
 =?us-ascii?Q?6wPUrFxROQwXslf2NS3nfsFmBwkKnJjCBYoM3A8Dd25pSx/HyDwPR8Nrcdbm?=
 =?us-ascii?Q?hQgjIZN9emeWjxnebmCilbF2oOJayRdohj6ahlGaD6d1s7m2puis6X+A/Anf?=
 =?us-ascii?Q?hU18KrKXjV5WqrSFTC6WiPQD0fBfdq0W5B7RvY9cOGnGHR1P9jlWgQekpE3/?=
 =?us-ascii?Q?6Hl8vMP6NgMj6Zu1BzEFpz16hIAEZoGMcgboHxiCbxqHubLeBFJ0gEsC8jYU?=
 =?us-ascii?Q?laiVm5pd37KjI6GZJyw026oStVWqmGwInTrCVE/TKjPoKd5CFziv3kwjcEuq?=
 =?us-ascii?Q?xmIWzTSHpbO4zbcLI6ieJc1U65BLImBxghRFkMK7a2IqVe01or75PcD7iQ8R?=
 =?us-ascii?Q?I45lW9nHAJcm3gqWdGh2M8E25Gqg75di8MmDjHp70uXC5Y7ebHRwOjTt3TjP?=
 =?us-ascii?Q?sC42zziEFIGE9o+yNHQIGXP5pZSzpfVzyrKmA8D+6ExXXNZ93DjLhkd9fvaM?=
 =?us-ascii?Q?0CP1TOqHp/O7tqpDl1i8rg0SPvJUeeaFGUq9L4cj5xXsQAprpuwvTBmbrHHX?=
 =?us-ascii?Q?CyPVXUCg3rYSiuwzyFVqlHu+uzS/37TvV/L6bVbPqir/AbViK8r54aO9tTik?=
 =?us-ascii?Q?iArOOAgWSnM3znmvImT+QbH7bJhBhOwwVbAzIK1iaKg7rqJeV3EgKZ2Hh28y?=
 =?us-ascii?Q?3PFvzRS9eC1mOnZ0WqB0kNil/hApQCFZ4EExwuxiSgprBsbB2Gkl+RPPV7zv?=
 =?us-ascii?Q?GqV1a/fQZ45Am94PbR5eAH5S8OsTrDCIXNO/FpDonQqWfz3m4MdNCHwvIe+5?=
 =?us-ascii?Q?FQn7sHdGH/Et72zz72Rplqo+IYbVwDNdLwpjP56gfHWM1MrWa7e+C3afhpBL?=
 =?us-ascii?Q?kFO/ewakZ3mKb1XHa+cou2ydf7VCf66eQL5iV5mEoK6C6nasRITkDJ+sx0tV?=
 =?us-ascii?Q?QErePvYKkZcvVwV/3w0DS8QJoXFSkQ44N1NbVjOiyQqXmNjMAoww9aeiXZH6?=
 =?us-ascii?Q?XlcKw89e+FdnFy0GN/0KC5UNwQvh0TC+tFoGCxJBf7c7F0quvkLlMTsdnpIp?=
 =?us-ascii?Q?jfrwygoRSYBprDzSo9EU7Ki510Jccdkg6jv1bZpP5HT5A3lqm2nWNR1nDOm3?=
 =?us-ascii?Q?Kl1XLQVYefbKAtPCfvhG6hHdTdSGE7CDCWqHwxTjc7OsMENdq/cl?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acd109a-eee7-41e6-8b73-08de8875b8b8
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 00:47:12.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGiWULuU2JUVenapjHLh6umxLuh0fi7u2t7HAo6VOowKuG/kFux/UPJ88reJ1HMX6yYZ5simreOIdDnvr1A662WOvueaOAUxjVOaesoUDcIv4TBf7XW3qw4L7pUkBS2x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13759
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9572-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:dkim,renesas.com:email,renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 964CF2EB496
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

Thank you for the patch

> RZ/G3E audio subsystem has a different register layout compared to
> R-Car Gen2/Gen3/Gen4, as described below:
> 
> - Different base address organization (SCU, ADG, SSIU, SSI as
>   separate regions accessed by name)
> - Additional registers: AUDIO_CLK_SEL3, SSI_MODE3, SSI_CONTROL2
> - Different register offsets within each region
> 
> Add RZ/G3E SoC's audio subsystem register layouts and probe support.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
(snip)
> +	static const struct rsnd_regmap_field_conf conf_adg[] = {
> +		RSND_GEN_S_REG(BRRA,			0x00),
> +		RSND_GEN_S_REG(BRRB,			0x04),
> +		RSND_GEN_S_REG(BRGCKR,			0x08),
> +		RSND_GEN_S_REG(AUDIO_CLK_SEL0,		0x0c),
> +		RSND_GEN_S_REG(AUDIO_CLK_SEL1,		0x10),
> +		RSND_GEN_S_REG(AUDIO_CLK_SEL2,		0x14),
> +		RSND_GEN_S_REG(AUDIO_CLK_SEL3,		0x18),
> +		RSND_GEN_S_REG(DIV_EN,			0x30),
> +		RSND_GEN_S_REG(SRCIN_TIMSEL0,		0x34),
> +		RSND_GEN_S_REG(SRCIN_TIMSEL1,		0x38),
> +		RSND_GEN_S_REG(SRCIN_TIMSEL2,		0x3c),
> +		RSND_GEN_S_REG(SRCIN_TIMSEL3,		0x40),
> +		RSND_GEN_S_REG(SRCIN_TIMSEL4,		0x44),
> +		RSND_GEN_S_REG(SRCOUT_TIMSEL0,		0x48),
> +		RSND_GEN_S_REG(SRCOUT_TIMSEL1,		0x4c),
> +		RSND_GEN_S_REG(SRCOUT_TIMSEL2,		0x50),
> +		RSND_GEN_S_REG(SRCOUT_TIMSEL3,		0x54),
> +		RSND_GEN_S_REG(SRCOUT_TIMSEL4,		0x58),
> +		RSND_GEN_S_REG(CMDOUT_TIMSEL,		0x5c),
(snip)
> +	ret = rsnd_gen_regmap_init(priv, 10, RSND_RZG3E_ADG,
> +				   "adg", conf_adg);

I don't think you need 10 ADG.

And it can be 1 line here.

> --- a/sound/soc/renesas/rcar/rsnd.h
> +++ b/sound/soc/renesas/rcar/rsnd.h
> @@ -26,6 +26,11 @@
>  #define RSND_BASE_SSIU	2
>  #define RSND_BASE_SCU	3	// for Gen2/Gen3
>  #define RSND_BASE_SDMC	3	// for Gen4	reuse
> +
> +#define RSND_RZG3E_SCU		0
> +#define RSND_RZG3E_ADG		1
> +#define RSND_RZG3E_SSIU		2
> +#define RSND_RZG3E_SSI		3
>  #define RSND_BASE_MAX	4

You can reuse existing RSND_BASE_xxx

>  	AUDIO_CLK_SEL2,
> +	AUDIO_CLK_SEL3,
>  
>  	/* SSIU */
>  	SSI_MODE,
>  	SSI_MODE0,
>  	SSI_MODE1,
>  	SSI_MODE2,
> +	SSI_MODE3,
>  	SSI_CONTROL,
> +	SSI_CONTROL2,
>  	SSI_CTRL,
>  	SSI_BUSIF0_MODE,
>  	SSI_BUSIF1_MODE,

Do you really use these reg ?

> @@ -627,6 +635,7 @@ struct rsnd_priv {
>  #define RSND_GEN2	(2 << 0)
>  #define RSND_GEN3	(3 << 0)
>  #define RSND_GEN4	(4 << 0)
> +#define RSND_RZG3E	(5 << 0)
>  #define RSND_SOC_MASK	(0xFF << 4)
>  #define RSND_SOC_E	(1 << 4) /* E1/E2/E3 */
(snip)
> +#define rsnd_is_rzg3e(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_RZG3E)

(5 << 0) will be used for Gen5.
There is not detail rule yet, but I think we want to keep (x << 0) and
(x << 4) for R-Car.

Maybe you can use (xx << 8) and (xx << 12) for RZ ?
Something like this

	#define RSND_RZ_MASK	(0xFF << 8)
	#define RSND_RZ1	(1 << 8)
	#define RSND_RZ2	(2 << 8)
	#define RSND_RZ3	(3 << 8)

	#define RSND_RZG3E	(1 << 12)

	#define rsnd_is_rzg3e(priv)	(((priv)->flags & RSND_RZ_MASK) == (RSND_RZ3 | RSND_RZG3E))


Thank you for your help !!

Best regards
---
Kuninori Morimoto

