Return-Path: <dmaengine+bounces-9574-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NriG9uVwGmxIwQAu9opvQ
	(envelope-from <dmaengine+bounces-9574-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:22:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E252EB74B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA1DD300B133
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B3203710;
	Mon, 23 Mar 2026 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hgN51M1t"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010055.outbound.protection.outlook.com [52.101.229.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41C154425;
	Mon, 23 Mar 2026 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228749; cv=fail; b=Rq9ZSdvagKHdjP5Mk2P3qRlbDk52o8Ha1no811wu2kIN3DOuvKOtYobvkhs3wIX34N9plo3Y9ARwxI29DAmXkGqj6DCDlOyc1XpUdZd+G5onF+Mp/Qsu6UUaDIXxZ25DjKN3TBoCX7i+IfHqvucgdB7XLt3z7LeGE/i5oagpPdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228749; c=relaxed/simple;
	bh=o0q2siJZh5Obras2U4ENzL6pw7Lh1J0y0DTNCHEmhbg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NM9OfMjcxBcYki0+G3DvlfBtDYKt1hKqEhkjXxJ6uCS1OPsM38r3BFd8EdptZg2LAbevH5p2sspDG1Dxv+Uj52JSh28Hn6ilHqOWH8ESMnor8NrWheFIfv9GhyyCn6vPCyYU2ipiH9pCKOy/kNNQLcPnFAnVuPhQbR0HyKtdKAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hgN51M1t; arc=fail smtp.client-ip=52.101.229.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+Z8hTAP7apRNgGB4ohFpwgiQY9eFBJj7XRg1+clYGaG99k0WzfPXbItK8mOY1LE0j2WQylm2GKINTeFRIND2XsVOlUj+0++x5sWOJxld7ek8U26m6K30u9U5kOoZv8hl5kVb05Q7g7sBIbYrbwFFeTtT+GsAX3ukTqA14bxqll7S8QCH1Cx9PDDOuZSvVX1q70kpnkWG7kyn1ayBBzDiz0YlAZ26AqRHIHtoy9t+v12lXjHHHd9hUoD+iEJ7uzpJBiMXWa7KEX1kgRQFGcqVTkzKnQS4gbr/veFBD6nOBAGh7t7qxyehgRKUQWBz0PUS6SzLO0GNYmgthni1qT7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZoR24k+Tkeu9NsZUL/93PcmM90fvXbYfHH9L4YNjoE=;
 b=WhreNMeVIRy49Tz472tfvgjdVyKszQ3QqGGwecshN4uE0MTGfSKkFicT5SMJsidM+zEhFmO6p6Zm1UTh4bHJzfpq18dA1hWCLo5lRS2MPH7bfZ6WpDHxxPKgdQQ4mMWPh80jlNahbRftdYkvLyAm5k6zPbKrUcL9Ei/eVbn+F9TPgeqzzvJbqukVZC3k+Da+wms7aZTJ2N/Oxy7m/eZrgcndi9NyoPQWth/Qkl1P1ec/qbktDp0JvPr5kMFuJbrWJnfJIuF6BCjVq/sIVTarObdYcRlmBZ8atO3ATogcMGfVmrJ/F2L7e5XNwpLwkYD4CRq2GW9qrpN8OGIRt3CpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZoR24k+Tkeu9NsZUL/93PcmM90fvXbYfHH9L4YNjoE=;
 b=hgN51M1tRgmyxqEuNplegOBXXr7RKfiSLFQP9syl5xkHvakZ4L4RpzWeZq0rGc3caZbovp07NcG3iexwnbLxv754pADN4rbrixJdWMAGLkvNcrYGVsj7H8Nl1mVlxABeBLc7KHRVTyIAI/jsERBMieWJpDsVOwHdqHsILRqwVaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TY7PR01MB16177.jpnprd01.prod.outlook.com (2603:1096:405:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 01:18:48 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:18:53 +0000
Message-ID: <87ikan9wca.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for RZ/G3E
In-Reply-To: <20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 01:18:53 +0000
X-ClientProxiedBy: TY4PR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:378::19) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TY7PR01MB16177:EE_
X-MS-Office365-Filtering-Correlation-Id: 023aa438-667f-4248-8812-08de887a25ae
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	GFDy74upBR1btGbsxhZEZkwCVTnosbRvJdmmASUXmUU9ej9uq+alBRzEEZ6ekEVdPGB4/xED6oI5m3WJattFdmZkV1Oymd5PPigzqryziYRrNR4kjTI1WXs27YG5zfzYZgTdYPlP4pRux94D1ehHMYJhRK3HpW2P6sbvBS727KTnbeSF/vjUGqrt4ilIhn97pfNRQKXLvUkTc9tz5ao7vb27E0hCLf94X7HdWvgFNbKEHlBoAsPVyIeoAqvudmcgw1Ukk2CtRtcABKlmoGtoRwnSkUhwuK3/lLPQm9JhCnG2shkNFHnzZL4U5vpgpQuEPZTWKCfKCplrKkv99Q9REKZsCuR0uO88wWLd3u0mhDNWmuelENg6zH1RrDOVSyR0/JfjehqJUuFybq9hU5Sj41nhdA28RhkJHCMjBb9YDq6iqrvVQlQoe8NVXCAwMX6V1h2cktScCyYk/pQyaf6hG53/r5b9bQkxykgh4Lg8g8XUUwya3tvay0v3qBHDkA5r6DZ/iD1RKSUka41T/mDJ9UcTgF9GNWpo7YBB/Z+mQNajlkJHztXlDxcJOxORQCuaiaQ8UVOlExDu1nQT1lhVEKodabG/h/Ojg/+3MGNV3ju/ApvHuDsUI43fRgwMiCdGtVTrBqcdgm5/TrI6G2L3Jr50GZEkJrR6HsJ33BKBK6EzAUPNecgbae3IM75MZgv4d9D6ZGTVeyAunvxn46eAR1+3eYAIPofVTqhm0m2GF28Bj7YOwiwdBV63sdccMAf9V9B7akBUtiVXf6S25Ap2AKiddNiIhuHr2rvBKLqGx4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2yOQkj8yZyx1rzONoVkeRiNAxp/GbsPThUK3k0GZEBFQP8MkQLk7iGGQ+Zj?=
 =?us-ascii?Q?gi68o60sD4rnOj9yW7kl2g8AZwiKYw4nJ9FwbvcwtgRGBx5cOksQosqwJdbp?=
 =?us-ascii?Q?8r/aRkexwO0yb9nUYxgqeifFNeX6+wsXK9HlR8LA9wTyZP67A9fco/cdZoSl?=
 =?us-ascii?Q?iWk9JxHOnub5q+6yu2jCJUuNsyVDcvihghbOvVjagNIjAikKKtiIOq6YLhym?=
 =?us-ascii?Q?gnoxVRyapiMMxqUk1DBTLMOatvAtp0YKaDlPqRm9/f2/8lLIW+2VHTnhKs/m?=
 =?us-ascii?Q?cPoSq+ZkHLF0SULzUSWWnf059J43EkdQy/EzF3KyZM2hTxbgWZEZImB2sbCA?=
 =?us-ascii?Q?1fe4MHhSuzh6tIkcIBRgp8a5V/jM0X8TChUB2UFw+L+btKQvrZN+/YK3OThF?=
 =?us-ascii?Q?TtcO0TyGmmTW8hSmZkSfvH9nNts/wKHTsSPTjqnrUpmmy2QzIoaaKWnkLRAF?=
 =?us-ascii?Q?EcpdUAErFHp++LwyUnXYe8h6hfp7311QY64uqXsjcnNVZ55G/zUstWGAygGG?=
 =?us-ascii?Q?Zgixl6qZHRGi+ApCVgbIVqZBF+U54AqYj0u1PVUNKcmRNhL++D5Bpu4LOqgT?=
 =?us-ascii?Q?9B7YTbY3GA0CM916DJS9D2NSpG3ybR05p0T80fngouSy/mIAu16zLEfbDEsX?=
 =?us-ascii?Q?DqQ80qm58gVJZbht2nM8wxgnk3GJrNS4H11qJHjoZFMBaUquQ59rhj2fXBrp?=
 =?us-ascii?Q?liRFd96GT80rCDAGIHA+QmVJf56YGvwFaNkx4pyvvM4DrMO7pKuc7QMfCccg?=
 =?us-ascii?Q?JbG/qFRKxqYHCuX8ei2Skk6+dNu3h2P536pEgUsuo2uid2ohdOZvtCHDv5Ua?=
 =?us-ascii?Q?5hipo3WIgpNksulcYEFAmnkYB4kPcf07JUmjtHfk/V4W1/Wb6FxkrZTe+obZ?=
 =?us-ascii?Q?fjN5dALW8Xf6EyVp0FucBuELsen3IWs+AksET1QajQaCUs57pLokgOjm28HW?=
 =?us-ascii?Q?18YvKTZNYypPXE46Se9RPfN4rTDhSca2TS/2zLYbmi1QNifHOeCMlhO+0Jv8?=
 =?us-ascii?Q?DDo/oXAAqlCGNa4BNpKfm2cKPS+0/5vu/nYTcj0BkTv+4p7nkZui6nr4pi8l?=
 =?us-ascii?Q?UuLcgrTumqP6L8qdewqOp/sjkw1jQsrOszZhnczEnltblDAcfJnNgOdQwT0u?=
 =?us-ascii?Q?br0M8QF63sotpOXPIXLkRMRLqvy3YgkwMs3euC6bMLcyZQGAgK9d/W8R7n6W?=
 =?us-ascii?Q?2/DzTcFlv6ZANsYAdcCUWfxn1c2jaaswWZXelu9hoawNFQbP7hTIQmrmAjUH?=
 =?us-ascii?Q?a2PmuSF1ECb7tIdwbsikBIekag0zcgA5u8pR95uWwrkM2jj2ZjBaLEmaphV2?=
 =?us-ascii?Q?odIzk6ozSZBCyHhsPw+KWs7Kjs5kKtMsc+L5K0fSOdDwOqPAadrUm8eZSOWf?=
 =?us-ascii?Q?vGI32ctTyA7nEk4pNUPC51UQysTJCfmb+x0TQhYY4lf1qJ92XWF7GtF/wiy2?=
 =?us-ascii?Q?yLLxXu7NGgLngVMb1N9huMgXV7K47T1GhNsWDF3737la8cZq471GgyxiPyDL?=
 =?us-ascii?Q?ZYdsDnj5fvaXf4UseCBaKaUuSUIv8ZkHUgyudSwBtdy0kyrQz/9JBda37Duu?=
 =?us-ascii?Q?6yOAR9Jc1o0t2SA35b5vQPNPZqSj5kGzKcKLnoDlvTfn/uwnfblCjV+rgIU9?=
 =?us-ascii?Q?2Srk88OfTbpJZeZF7RrYFGIxaV6YGgBCpiHk1D/zfCa0o2p8vLZ0P4aELkej?=
 =?us-ascii?Q?fn/ue0XIxMbibxJtG5ss+xo2FGCY44psgDBsS7kPMlTdS51XxWBh0nEoyGrZ?=
 =?us-ascii?Q?dRpMARhUHtmstpS+4EMmhOhfFpOyXf3Ay4/RaPLtzsqJH4GfyDjp?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023aa438-667f-4248-8812-08de887a25ae
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:18:53.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5V1eYkYAzUBR+DuW6eYg6I+uHhRe9pD0sz1f2R9tMBzEdYxNsWQt/cloEg6FJCOq1WGnm1PPgIDIubBkSMrdrhNaTGyLBfvsrWnzh15HQY2kOjxbHBtZVARmuJm6LfC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16177
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9574-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:email,renesas.com:mid]
X-Rspamd-Queue-Id: C8E252EB74B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> RZ/G3E has different DMA register base addresses and offset calculations
> compared to R-Car platforms, and requires additional audmac-pp clock and
> reset lines for Audio DMAC operation.
> 
> Add RZ/G3E-specific DMA address macros and audmac-pp clock/reset support
> using optional APIs to remain transparent to other platforms.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
(snip)
> -	ret = rsnd_mod_init(priv, *dma_mod, ops, NULL, NULL,
> -			    type, dma_id);
> +	/*
> +	 * Pass NULL for clock/reset - audmac_pp is managed globally in
> +	 * rsnd_dma_probe() and core.c suspend/resume, not per-DMA-module.
> +	 * See detailed explanation in rsnd_dma_probe().
> +	 */
> +	ret = rsnd_mod_init(priv, *dma_mod, ops, NULL, NULL, type, dma_id);
>  	if (ret < 0)
>  		return ret;

This patch change rsnd_mod_init() parameters independently.
Is this patch-set can keep compile comapatible ??

Thank you for your help !!

Best regards
---
Kuninori Morimoto

