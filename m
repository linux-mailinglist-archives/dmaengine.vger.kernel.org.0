Return-Path: <dmaengine+bounces-10387-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6yAuMiWTA2qP7gEAu9opvQ
	(envelope-from <dmaengine+bounces-10387-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:52:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECAD5299C4
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2F9309F5F9
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07833C3445;
	Tue, 12 May 2026 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTC8WKnn"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D53AD50B;
	Tue, 12 May 2026 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618920; cv=fail; b=gt50tngijtmVyY0g2MY5ksoo8GpLBxqziRGtxuVNtApd/UwiNx2FCMEtnoRatT/o866pFfiIG6GVBBJrUG8QvyXyTb6fdH98NSKOeA1S1JLoTFLgV32SCu0CRWHtcnuhsr1GPom8WyE95jyYmYW6YFfR6XxglbCY2McZ7tCMJe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618920; c=relaxed/simple;
	bh=FIUVWmf9pM8Pehl6RynoksrJg/3yatCkpk7OpM3U3tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jojlUcTCu4ktHGJIo6ncJxJ5DblqkLeC4vldOBahTmPDwxDO8JEW8R++Ccf2PHgAFX6cxngvGc+dpa4ZCt9iDYNfM0myzBoa8ticlWtBgogE9NemeQMtTDCFbuUvzxcwxTzlHeIeb2ynKCcNI3agLHVnr4pZ3koFfGzGdW9PwZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FTC8WKnn; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm1D+803GKi9xCr/TfIDsBpGJz6EIPKr+VR92s/l8f2rWZeN2MR9CozqIzMcmfn2yqlCwTNAOgUw5ZcCMtG+c7kULJ9UPcq9Ug3PauekLTcMbIEYASQ/QjWsObXb2RTgkJPcTw8ZmFq2bhUffje1t8MFFRrEXy/e7EW7RcvOrtZAcvD38e5MnYxp/CpDzsG98V2O8co8bqjv/ptH2PIDXD/Cuj+IHAEvEJLpaplCqPBdAWNtCXjr9ZmlhKAFEdCUIyKfQjTxsB/c62+o63MV/mbc1qBUOjilaiYtBBtEt6QuSptzFBr0F3QVJjKPkvG7XO3g3bJ96afeIfmxNym6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51vzRoAaRHKcYuZ9I0gxtzN1hUL95O7QUfi0+2Req70=;
 b=kNKy6Ujfe3LxvUjpVOUYHlwyPNXCgUxSo4tBaBa0B6ghZfvnmggmpp48LqvTqY0cB9r0VlT4mwmAlAPp2TiUWyfhko3NpexJ+/1TpyLdGQEnat4vKL3+qNIZ/Wm9zdTsU+tLKnIXBOevVDvwkcH9qi/8Y9AP0aE2IK5xbNzxRRmgdxisp3+0fZzkA0Y9FVc0AIbIDjPKyIqmkCgQ7PyIfEzZz3cMWjFV1OkH3gLklzXfqwFdfPkJlYBFpfjSpxniYLDLHBWPSJTsx7Zt9RK0sr+RWVknXQUdPeH3iWhYX/a5Wr5wJEljvaWMq/ZXbLEH6h3d3nwFLMURm/AltUpOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51vzRoAaRHKcYuZ9I0gxtzN1hUL95O7QUfi0+2Req70=;
 b=FTC8WKnnwdkN5VwyqGU5DZKSPlF+LA8Pkpt/M9d5Wh1vY+yjpE5zdr1vlYyQSzUQwtFB/3jrt0DAsFQg+YMTb/+6/cN9l0RRPK9IpF+1xeNwjIpVw7e4IwcZ10z3O2x5aAWmX2DCEzqkAhQBu2ONiMHt6L9sVIOpoj0QsyZ3EzQUbMJ6VJtZIdq7kqhYTb+zjI9ZjOnYPEjaMBI3LnSlN93POmTxKfr7XY5pkTruh2G72ELUIwVZtivFSM9f8daxCxbKHfZCdXPvbEag+k1BV9jdWezdahwSgElMiMPx8zWBkF58GFB8OV3EauuVehXOJPM83fV7JA0b/5X2RM28Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 20:48:36 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:48:36 +0000
Date: Tue, 12 May 2026 16:48:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 06/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Message-ID: <agOSGoaNXKfV_pFV@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-7-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e89549-0a03-474d-ee5f-08deb067d662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rIV5oxpmwNYS6SwsZp5ZqcEzT/GUCzFI0gyoJW5ECQSDvHNdjR+37qnOPHkoT7imwiLisi0zUG1LJfuq5ksEjPlHP9VUqXe9vt9l6Wp+pnrLFzGGVzEz0yThyFvRdzunJr18j0Rd2TyUdZcv79RUOJ8w60kAJJ3TSsyWdXxgIGTGkQL4GL0eVXjpIcHmvmniZQ1vfecTSbzCmGNlO816cjYyPn9ihe7mjTJhevyitXvyOZ6k6Rz9Itcp4xYfiXWfgDLQxusddJcqGGkJT0s7TL9tPsm0uJAnn7GFxlfkV45NGoZosYMwgycQAc6e8lJsiUJ3DBLpIJmQahD5t5EWseLEc3Q04st5NLMsUTC3z5NOROXHsP7n80KA214DdyDVDy0vssJE88wBVKl8GJMq436U9FsSUA3z4UwXiVufxOwtcIVcFbpA7h98wXTLvisSQpLUJt30BFzvJOSr4XQZ2OY3HV4tuDwVXx7Qr34MND1LnJkhWKZscOC2A1E6R+nLmpu4onH0lJyJpV8o0xhbJV0RsrL7vCEnj4CuUuwsjQDgFlzyEZc4KrW1kuHJdmtfYHpwxt0qvKvNeRAeuQFElT40boPI/5h/doN913X5IWU35ieo9Md0aGCs9ZQlI21B78F0zDrwYvkWV0AqS82TPKtGV6oxNOftVvM5w10LadizyTbr9VwcrsqATxefFqKe6eBWOXPmZLoJJcDxjodMkkCR5wbOBj3nBf6ws+pXVk9uutUBNPCTDUpknN2dRLSG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FVCwN5pNW5bnktmySs9KhWcFndvAWp+A1SXC4t4XKsRiHM9DQIPgQzQTv0hp?=
 =?us-ascii?Q?2MsKFDIzGzbprTSVEHNShmeOLRN6hvzAh/cL7WJVCD1sceP0CpchAY5wWZIg?=
 =?us-ascii?Q?wwpAacRBbdR+ElxwM0d1mBndrTL+64ySJSqGpnk6dBoKsrWFiDYBsWuoy+hV?=
 =?us-ascii?Q?ALYcYy5fH4YP6sGvPSQ1Cu6VXDtdwRDM9skFZzvbd7fXgEF1ug4QYKx0650F?=
 =?us-ascii?Q?qifq6ONsWCfu++0jx3xhU47NtZTtBHVMU8+WdqYipKEkKLl8oqeD3E9EoTZ2?=
 =?us-ascii?Q?eXjwNxcTs2QnSd+g2gtE2+RykUidRhe1A9WB+xoXSW14jFZ9qmewcc6CpDmL?=
 =?us-ascii?Q?UMGz29uRGPltqYdWylRp2xEZJvZeWOHOHe5WqiD90uMq3Ws32tslASJojx/g?=
 =?us-ascii?Q?cBkxkBgNr7VKzBOcO2bIyo6tIerCrWDSc88crbofQR3FrN+b/okCMLY7yDC0?=
 =?us-ascii?Q?RkxabguQ9Ey4Py+kWpKVxNiSfIlmHXqOqh6lvVl3V0ZmDbuvLYXX3RXEPrxp?=
 =?us-ascii?Q?H4Har2sVoR+rDUBjPi1eYkW3yQJDeZO+C8ioLLW80tv1MOOTZFWUlEbY6Wmx?=
 =?us-ascii?Q?ylJiyNYk4LHcoyGyPdl2FERmGM3LsNkuVt+9ex76n0kFE5jUJKOnpUFIo1t0?=
 =?us-ascii?Q?3bCmcjQt58mGJ3X4DNVMLHyQIo9I+LeF9xvEx+N7WTQcP4mkF9k9a5Oslxty?=
 =?us-ascii?Q?2IlovrpmKEhDuLUJr+Jx8Gs68j174P1B6TFE8sqmJOVSV8eWzQTKiw8QaqiN?=
 =?us-ascii?Q?JjYXD77XkXDKlUnK6h7xqZiQcmZL+YWRdBfnVT8T1zNa14/M7eAGBOFPNR1C?=
 =?us-ascii?Q?TGIuMl73ZSR6mgqNO2J9eVnPa3JeEL3o8hS7STegFUhjSEE63cEauiCmG10R?=
 =?us-ascii?Q?/TqKuRXZIFMJ9DPdnGrUj+/q1DE106GqrVJPIkKqBoVM0dAOBFROz52NcvLZ?=
 =?us-ascii?Q?ZTLJ6wA/5UyRmf9qP6KhC7jcIqMqCixquXnyUsSrlynFwmw/zzp2+VDoTfBB?=
 =?us-ascii?Q?4uxJXIG4pgEgbns4WVlp3nAGONcYeLA3hSWEAmfWxoTILH+UPHKolB8n99v1?=
 =?us-ascii?Q?lmNZY2VCGcLV/BXMMR9kHB1Sxqb8yklAnSbxSrS5vCAs3UrK+ucANfd6tq8Q?=
 =?us-ascii?Q?m6MMcLucBgyl+IReRtdTPXjOkLX56e+cGCOH+8lNCgrJzc/Fge+YIrAPmOx6?=
 =?us-ascii?Q?o/syubBTme1dpR6Rfk0UZ6c6Q7QgKDHJwMtB4T+WYt6Ei9Wc7uZ10mAKaoco?=
 =?us-ascii?Q?twB0FYJEgm6dCXNaMzmJsQrmqdo4RKxl3m3pqHMUmgN/IrI9fAOXeIxrHl2G?=
 =?us-ascii?Q?Eguri0eFfhhAdvDuPtw6uu40/Btt0A/QpBXk5+BS4N0EetSGm+VrBcgWq9sG?=
 =?us-ascii?Q?8PnPgVx2uQiFre5/wZwVfiUcDyHrtzWWqFriqBpEbCtvrrKk3AoPez2Mid1O?=
 =?us-ascii?Q?zi0XDRpc1B1jWop6pky7jqTOdseIrUx/L8gC2JlUhDbCZBwbO96riMo8mKQw?=
 =?us-ascii?Q?UzQmnIpJ0x0EHxnMvYjBPYAS1PwGPnrgJCFkkq0B5mgENS8ueX81L8upCRO4?=
 =?us-ascii?Q?R6yrLl0JOl5/r6P8FAUQPTXaqwpxgloSBuET+AK7Ek0zHwgyHoH+rpZrG/pO?=
 =?us-ascii?Q?b4zmZAO+UBPinAbbJWHZuG7wov7qQRQAilOAhcgMzpCd3GVjglVK1/kBw8Bn?=
 =?us-ascii?Q?tR0XfYrkYUwmyN8uwVOPNK5XYXREg803/01xHEiQ03BAbc0b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e89549-0a03-474d-ee5f-08deb067d662
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:48:36.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNG/I/G2RqXX9+2CqpomJ+h5AyI7OXRiC+fyVC6has0NZ2LmGbiPzvR2ldDmwOlenECjo1JScJ5KiL3WdWO7nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
X-Rspamd-Queue-Id: 2ECAD5299C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10387-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:07PM +0300, Claudiu Beznea wrote:
> Save the start LM descriptor to avoid looping through the entire

where the looping you try to avoid?

Frank

> channel's LM descriptor list when computing the residue. This avoids
> unnecessary iterations.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - none
>
> Changes in v4:
> - none
>
> Changes in v3:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c48858b68dee..d3926ecd63ac 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -58,6 +58,7 @@ struct rz_dmac_desc {
>  	/* For slave sg */
>  	struct scatterlist *sg;
>  	unsigned int sgcount;
> +	struct rz_lmdesc *start_lmdesc;
>  };
>
>  #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
> @@ -343,6 +344,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>  	struct rz_dmac_desc *d = channel->desc;
>  	u32 chcfg = CHCFG_MEM_COPY;
>
> +	d->start_lmdesc = lmdesc;
> +
>  	/* prepare descriptor */
>  	lmdesc->sa = d->src;
>  	lmdesc->da = d->dest;
> @@ -377,6 +380,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  	}
>
>  	lmdesc = channel->lmdesc.tail;
> +	d->start_lmdesc = lmdesc;
>
>  	for (i = 0, sg = sgl; i < sg_len; i++, sg = sg_next(sg)) {
>  		if (d->direction == DMA_DEV_TO_MEM) {
> @@ -693,9 +697,10 @@ rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
>  	return next;
>  }
>
> -static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, u32 crla)
> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
> +						 struct rz_dmac_desc *desc, u32 crla)
>  {
> -	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> +	struct rz_lmdesc *lmdesc = desc->start_lmdesc;
>  	struct dma_chan *chan = &channel->vc.chan;
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	u32 residue = 0, i = 0;
> @@ -794,7 +799,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  	 * Calculate number of bytes transferred in processing virtual descriptor.
>  	 * One virtual descriptor can have many lmdesc.
>  	 */
> -	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
> +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_desc, crla);
>  }
>
>  static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> --
> 2.43.0
>

