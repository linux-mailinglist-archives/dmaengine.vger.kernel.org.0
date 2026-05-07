Return-Path: <dmaengine+bounces-10270-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFDwMlTa/Gl9UgAAu9opvQ
	(envelope-from <dmaengine+bounces-10270-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:30:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494594ED70B
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58583013020
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88023233F4;
	Thu,  7 May 2026 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y2fmPS9Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742C46AEE3;
	Thu,  7 May 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178640; cv=fail; b=PVjmIQF6JwKTGAc1hBCiF/Gar3TyeRpSRBlURWDQ7n889c+Nj/6s2pQsYaurXEIkffXDeTOmqobT2Sbbo+RWOqlx1pxNHzDMFuob/IbSGQRE0vCTiN3h90RzR01gFCGSdons+xb2vIm693uLalHkgriK1WsH01l7u1f9ozIDY8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178640; c=relaxed/simple;
	bh=78f1exVJacLD4qGXe5WQeFWWlofVFmnm4sYLzg3P54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nhC7CNjLq8oFuktrtHf0G5AXTCOAfqxiVzpWpSTC1JZrXfSvyy9aHb5k1ROJ9KZ0Zr2zZUeHGDnT93f4All4ORmnSu/0ghMklpM7v7/PFM+Z6F/6ZLK2FX3pkUNStuLdRx5hSgQQdwy9r/sB4KdrSSqBPSQ3U5AY/HTaXp2ErFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y2fmPS9Z; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drVPfMsJH8FaZJ+zceqSqNYTiW2wBVNZwSpvgKRQn/kFFXXUq2QuyxOruRKEZMimUSbndkEBsy6qiwtZ+np4OstgW+QOHSfqL6WwpehFJQEJqY1c1Jz3jBsKUcfZ1Rcf4zJqUMTLDTJvGFNej2HhaLktvRASv87y2obJUj/f9LXc1E3yP2hnspbhF2FB/b1YTe5NNPKDxxMJxzdTSRcO1ACxzlXHIGQf6HCbv/QeXplR6bFMQ2G7e2zPSHRTVZYHIt7pVZn1JHbbgtx002BALvcsM0saUUTFC0PoJMDNJN4fAbwHzhyV/QJimVyvCfoo8L+gAA77HeYBNfZqusfPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3aL/v4sWqjUnxcx5vTpUM9kGY+sA6uFnIAe60aqxJM=;
 b=wvUikqCRKet9tFJzK4vxW/j90WOkQzkHeiJdpWlJz9MnHgn65erh0opfSEcMO/s5H6AVywSTrqevIg3v2SQRyNHL+iaejtRfkRF8Li1JO0YsTKblei79Xj+qdQiR0IaGLHqZ1TL8qe1eaKDbJuE9vTSjzpPewL+DuF76dOpOCIaSLTxooJxTJsRg0HOUMEdrtIfUoQXJEEhIqzdsiPXcAMN8PDh5BUDfAqQjB+ILfLj4MltlwC0UOcxf/mzh7K6fAMIQ9npsmwP/kAGgLnbOsRDw8p1v+Nq8vR8bsfw+RJMyd5JzPm93cLk9BDKOG0IjLHw02v0vnkKQjfGux+L1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3aL/v4sWqjUnxcx5vTpUM9kGY+sA6uFnIAe60aqxJM=;
 b=Y2fmPS9Z36umAxhqvXKJOY89EeuJDE/xHtdhIHEI8S05qOcGGsHYPhEqW9bBjan2G0oaZaIU3WlCHEWTZfpAbjy4KyAwc6gzR9cOiHlpI3XS63Ovsx4VgiUgYzNzBtPOLpAnsUccSqygLgyRbkhBdThDnEV9kB3ZZMpa9RsnS/nbPouNqQ34OMuaRDNXpWEngpyct0LzLNqJ601btvrppUx1O2eSANv3gWU+bWxaw4pBwTp+phGmvvEaQX/v2teM9jRAexEw55hJRWc9JVWGAoCH82hq9mIdz5mwYlZorysEqAt7XsnCnn6FelHWz0JqIo/XhQo2TRl0nT2wIKX3RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB12614.eurprd04.prod.outlook.com (2603:10a6:20b:778::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Thu, 7 May
 2026 18:30:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:30:34 +0000
Date: Thu, 7 May 2026 14:30:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: zhoubinbin@loongson.cn, vkoul@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: loongson2-apb-cmc: fix NULL deref in residue
 computation
Message-ID: <afzaRRRVQ_JbGFqS@lizhi-Precision-Tower-5810>
References: <20260507023153.400-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507023153.400-1-sozdayvek@gmail.com>
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB12614:EE_
X-MS-Office365-Filtering-Correlation-Id: de7aea18-bb7e-4ed3-03a4-08deac66ba16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7UlI8yAdX+YpHqEEHz987Y6aZw9nrxQ/GrPBMtCpZ667x7VOzJo797XEVs6r2pSPEytmD9Oq0frtztPKkS/ErLujoj8qySlq3RP/EGJ6b8vVCy/k+Cg5Oc5OY/Jn5NGvuv2OyC8pgVkUEmWQoCuz2tqf4Tj1gHHjAUe2Zv7OkDGgztpEShYnhJJ1SEMjIuoRVo9KB3dXstIkQ1jgyZiMIK49fRc33QGGsvhQCOX/w1WHC0U1Dilw35ak50mZ+gW4/OdhhTN2+fiTlRCn/kcokIK1NCe+qPyxuZwOGxVP7dn0o9BoMLW3SsTkp6TwoY9aWsX3zZFYnHLsir45tEBPzZQH4mfOs7o0M/dZRWS/Q0+MV88NxpsT6ZGmXYw9uqeBE5EQBzB7ybDKVa+qOpTSrM5Jv0SpAMnIAc3NhNW4EYuhsLqTYFJjB5VwGqErhU/YLnK919Int3PN7Yn0qjlbRytgU7FZuANNWZ6MWW5cNCLba4I5UoemUdtWcltGOC5J8BBnZQ8IeUswVb4oTXVcOzFZK7jJ1RdZvQZZm/vYf6S2cZ5/qGTC4Ffzdt1Z7v+Q5esTz1XqXZYOuZhHg4fbSzq0Wen24+dfpjKIQOSUoBQsb8hocxYrNsETVuB0/QPSDNztw+4y66NAOgv2XPUovVKE5aA7i02UyURqv+Te3YhINcqlSSOoAte5EOPpktQOAPM7Ett92N2eM54wphkvcib2cJAMmTi8V/WclHuj3mzc0tRzC+vKc5vMIkzPA+MK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaWG06iTecebCZfxUC/jike0w/zSAmeQfCfqNc6teyrq7TTO8xFSFB7RWQ56?=
 =?us-ascii?Q?3XxPzXxZde6RWymnRF0TQ0HTuk9s5iRLKSYbcWI1HWzuhsjDxligaXq3lHLY?=
 =?us-ascii?Q?tKHzxXiMIJWyyeCExU72JPz7FL3JpTBu0cwOqzGHXZ4c+9L6dzAlDqsrS1tV?=
 =?us-ascii?Q?MpDw5kOuq1j3jLs/e7HiUVFkb1HI8/bFDrsDSttFxvmVNeBctjN2/IffjdBS?=
 =?us-ascii?Q?mNEOREZ4ggM4HLU5MseYK4bVKgkdrYIRSa5Z2zgwwLXjXiwH+oqYfZWBiXMU?=
 =?us-ascii?Q?vGdpqz0sw0W7GdMtj/jSpHzhTar9v0N6LLd9AdR0EFljve1jnal2fANGEHIo?=
 =?us-ascii?Q?PpxyCrf6O+QLlH/ufjb0u7XkcxjdMd+WRraokmNNJIIi0eDEGJ6ik3ac8f9K?=
 =?us-ascii?Q?FtXuaM2CB17F3e1LSkw9lbb8xRjJNN6O3dhqDDeOwN6RZJ13XK2TS/tDtHKE?=
 =?us-ascii?Q?BZ9ulSF/4SjDTZAf2hlTd1DHJFKypoxr85HsVYtB26bXvmCYfbZLiHHZQ1PB?=
 =?us-ascii?Q?Ue/q4veLYlYRru9Jcr8Ng86M/JnjF2yVn1qDcssu+xA+7qbL+/frCxclZ4w4?=
 =?us-ascii?Q?3MHsXVWitM71oiWmZOvXwRigkJ0FgibOiRvfkxRWPzB+lb7LIJQ+S0pyMpmC?=
 =?us-ascii?Q?FTMOily1GD5dy0rCUNZMWGI5T39yvpkO6r/CrFsM8Eipxn1qyWRRUjAS2rRH?=
 =?us-ascii?Q?xfzjEVsmH/dIprZzOge1tGr7mPRgJRCJbj6DJceqPrxHOc/9uyi5wYq4TetI?=
 =?us-ascii?Q?TKUJBJhN/lpZqKrErvBc9H5G+gV/JWtV9jjYufqw82TMB/lLF+yAcDPoLlfi?=
 =?us-ascii?Q?FZhoa9iBAaW5LfrJQFFoKsXhZPN50+mJX3uCxyb3PBGvIsEgX06Ky+nkwzh6?=
 =?us-ascii?Q?b41R7MmCHC7Np2g55ajW7wk/B1Y5UYXGyAuQVIcGeluI6WqZELBXuw9d4ql3?=
 =?us-ascii?Q?5mW/i42WR54rm2dup4YOWKvXraGrydf4qtAB4zfJxeU4iTEBWnGQZYsNgPOW?=
 =?us-ascii?Q?XvyoBNXwhdE0zzPt5c8zcgwxs6H1W3X+LnjMITz61ebPNZlOulh7VJuCC7q8?=
 =?us-ascii?Q?ybWI3sxAWQsZUM02PfycKi88/yVW/dZcjsU/mP8X20AlTkqXAOdfXFXQqeRe?=
 =?us-ascii?Q?S3mbupCagpeZ0C7YNuy0bvZw+/0QWFy+/RnQy49lQOt58BTlIUhCi5Q9Ofmm?=
 =?us-ascii?Q?n3ntscAxS42BYNmlzXBGPvNDyBKQmjgpnqahN3Itch8PvWzCXphzkg5o6vQy?=
 =?us-ascii?Q?w3vOuN/14vzKfw8yx6YoWGl+0djugm8cfvwDBRe76N/9TAi1kek+kFfN/ZLd?=
 =?us-ascii?Q?ef8mimOo2wjKKRKG9Ic5H110L4KeiFuxbFodVuo0RMO1y3PB6kTNxC7WLqWw?=
 =?us-ascii?Q?T9mxmpN6nEKH/PBKCNvb/oMUb3leTlz6im/lBa679U8HotL0uuJhizJKvWqv?=
 =?us-ascii?Q?xeeueK2vAl8n0Mojfllozz3cg9R7eyiA6k27R/hBYFj/WAadCpYv5Ie7nml+?=
 =?us-ascii?Q?sxpDR6F+soIxjvMjY3KYwcIKQzAIO3si/ntrypnJNOjp3qlmY4sJ9YIuICP/?=
 =?us-ascii?Q?jJU71MznMbZn6pLgOGiVdjkfvqntv18m8kF3MgdemjOgW8Jfx8qaZ2fbTXXS?=
 =?us-ascii?Q?Z0nwi+BMtNJFw4EyZRTxUXj7tmtRJUfUjz25indpQ3znm4Esvr+rEl6cwkZs?=
 =?us-ascii?Q?CVSF9NkWVPdRoIpkp0RH4+rll5X8l2H1oxpWF75rHdSCJetK9MRxgMZ8fbeI?=
 =?us-ascii?Q?yVAPILuKZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7aea18-bb7e-4ed3-03a4-08deac66ba16
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:30:34.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMnx61tV9L2YG6LErJBBI2oZmJJzkw8v48Vad3bcnN3W+KH1gGsRJ/lnPSsVegO931xpIUhOIFiZ48aig68RoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12614
X-Rspamd-Queue-Id: 494594ED70B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10270-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:31:53AM +0500, Stepan Ionichev wrote:
> loongson2_cmc_dma_desc_residue() takes a "desc" parameter that is the
> descriptor whose residue should be computed. The body uses it
> correctly via "desc->num_sgs" and "desc->sg_req[i].len", but the
> cyclic check incorrectly looks at the channel's stale current
> descriptor instead:
>
> 	if (lchan->desc->cyclic && next_sg == 0)
> 		return residue;
>
> This breaks when the function is called from the vdesc fallback path
> of loongson2_cmc_dma_tx_status():
>
> 	if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
> 		state->residue = ...desc_residue(lchan, lchan->desc, ...);
> 	else if (vdesc)
> 		state->residue = ...desc_residue(lchan, to_lmdma_desc(vdesc), 0);
>
> The else-if branch is taken precisely when "lchan->desc" is NULL or
> points to a different descriptor than the one being queried, so
> dereferencing "lchan->desc->cyclic" inside the helper either NULL-
> derefs or reads the wrong descriptor's flag.
>
> smatch flags this:
>
>   drivers/dma/loongson/loongson2-apb-cmc-dma.c:516
>   loongson2_cmc_dma_tx_status() error: we previously assumed

remove "we previously assumed"

>   'lchan->desc' could be null (see line 512)
>
> Use the "desc" parameter, matching how the rest of the function
> already accesses fields of the descriptor under inspection.
>

fix tags here.

Frank

> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index 1c9a542ed..3b02bcd75 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -487,7 +487,7 @@ static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lcha
>  	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
>  	residue = ndtr << width;
>
> -	if (lchan->desc->cyclic && next_sg == 0)
> +	if (desc->cyclic && next_sg == 0)
>  		return residue;
>
>  	for (i = next_sg; i < desc->num_sgs; i++)
> --
> 2.43.0
>

