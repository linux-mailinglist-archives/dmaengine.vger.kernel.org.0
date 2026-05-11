Return-Path: <dmaengine+bounces-10328-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AANMoA9AmrmpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10328-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:35:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F50515ED1
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0271307BFF0
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 20:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B9382286;
	Mon, 11 May 2026 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gINjrpha"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EC382F1B;
	Mon, 11 May 2026 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531376; cv=fail; b=J7ZGzZqo6tmsjPBPBkA5xFh/42pmm7CysJL0FFMb6Xamh01GOYv/J81WmvWp6EQqlpLT6ai0k4AB/sWgrSpGIaD6K+D52h4YxXFpifZRWtX1irV7rWlrLWcSeY0ERzP2E9AC+zOzFZhTtin96HtaVWpnlhCrrAZGCIoX5tWyH8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531376; c=relaxed/simple;
	bh=sf0dPBa0kfGNAmz4q1P8kugXX2kSfGDre8+0HQm8/Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RmVBCpNL/2lCR3JpjWY2kRHTHx9S6uy/6MEXdgaSOC6JnyXhc5YxoIuWjZjyPTJm8ok752tD5bDEYCopO6KcG+7pNHTNdZ09oLIiZTAaZhyqoWocmWOzct/7tIPowhitqhFxnsFnAzjVRvDRmRaDWKHRZAW+NDd45x4LCI3a6mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gINjrpha; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFEZDRU/kwRoC3KZ6GQ12X0E5ogFoYqS3cqY2DjBM59+jCfOZQyCzDA4apx9es+nOd82bBiDJQ2yx5ysaIeKpZvITW2hbrjldPwE0Sn7s6BzgS2nA2J44fdren7EYwYeBLRcXLU3fLlTygxiKlfJUiF/9huWaSLbiFs0oZBPcaVIPOQKLjPw+NrcrkHqbejt7Gu005MR2pcJpd6wO1WIKE6+efzbrI71NzLvGs5ud1gNlBRMnPrrsrJULdB3YP8oDq/Kvd1kQqzaIOSqQ+CIKQK0Dx/Yn1mo5mnXz1Qc/yWTvzHfsROyRdYL3OMsdIPQpwJV/DJTpG0nJJOQV+FznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBGpcvUlvzH9LNDJsLFovTDNd6vFJu1pSq42aIOjqLk=;
 b=sWIF5zlco/X1W+U3yZYomlxX97gwcsmk6VRzloY/SNHjsicRTbA/4eKi+Oq6Y5Xr6+q4IVilHWYRT90/I4whyWyBBFO7juVbqFxiuk4hAWRCs7n8FaaMDUgOxhlsODVAf+ki5GhN/RNnvqAApv9dqvIvadTBxEgPEez7zvqw+SGGS/NFQeRpM46+2trnBOFtVw+n4qM+2i6TA+EBruZR14I+gUpRCnXGf5FQ/rF1bx4/8cCXAnMkq5UlO7OdufTUcNDoHyvDDH0deP5nehVvqFjnyOOzz9C6I+F+xdh1s0Sf9Iv35holWc/J71LYksUqGt1abIxngJzmM+5RcudieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBGpcvUlvzH9LNDJsLFovTDNd6vFJu1pSq42aIOjqLk=;
 b=gINjrpha/xuQtxTnUSbqNt67klaXVQiiVzrOFvxZqNRpvHBJxVh8gNTQUaK9pranr7tHucp8cvjPfzkT6itljS6jl/a51bwTzoT4SlG4pi8+V1emEj5Ad6rhNpvHM/ljUV3Vq1PODYOn5QfEhzsbSkgPHX6DfDKF/7uFJUNCklcg3B5tZpBWaB8ajaisHCXDi9FBtHVsYZXNqx1fMlRU7SAQhUMu/QLLmHFrQ5T6Wfbsf0HWfRf4cc5mrSicM/k/gqkSx91OwvT8GppJxyzuXMabB8gXypeC86pr9PF0wRwnSsZ+FBKOIp3OSSBgfdBSvxTEN7KJ3NrWgH0oOvc+LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10174.eurprd04.prod.outlook.com (2603:10a6:800:243::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:29:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:29:30 +0000
Date: Mon, 11 May 2026 16:29:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: ludovic.desroches@microchip.com, vkoul@kernel.org, Frank.Li@kernel.org,
	djbw@kernel.org, nicolas.ferre@microchip.com,
	maciej.sosnowski@intel.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH v1] dma: at_hdmac: Use stored IRQ in error path
Message-ID: <agI8I5OEcjibX7Eg@lizhi-Precision-Tower-5810>
References: <20260509015812.19834-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509015812.19834-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: PH1PEPF000132F9.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2a) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10174:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d227e9-73ea-4380-1479-08deaf9c015d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tCCw7GWwiaaSTVVoZ/kQSH7pP/pbUqHnZZs6BQ035xWA1PFUbjcCTJb1yNS8eXbpe/p13f0D0eE75iSe4kdkvmkjFpB9Z3JGnpPbtiAvaZUu5NrHvX4Iv7vtsags5vzN7+agJts01KBbLT5ax2+zyI+vFCGMTtQsKGzsC3QZbNysLcPeIXcy8LJtgmaYXTWNT+mHM+u8eZ5zF7QuOOu250ZwoK8b0rhCDqc2ZNNA8xrNkrHgHQe8M6Fev7CLwHDQ50zaq1leWHiXfm2dB8xG+pYQSS7WQMl4O91Qa1NHf/Qdt6DyfDJUfimJ0BvPpYgHIFq627V8xOXjYOzM7YFGeE207CkqG7ywf7WTqjrfMP+/UMpm6tgdAXrLDi/MUFA3KCisVlZgkqbe3E6l3h6uoDpP+6CbtYkyFYSkPuKOuXy9NGwMUV78BOjrw8HuW1sPXNBukr29SnKQbUmDlEYKg851n/nuIZ8ZjmSBAmnUOnYU4dZxmkX+tvyJDQb7yvdZQZv8sGB0cedviFoZU1nlcvnEUbXPLurKn6ELP9rRy3fGUK34TSlvCobulOzaTy0Ej6e0eWwt6d527i70f1LCfKuyTQ+ZI/QR8q6M2bCxbs7eEeMlhC4iWQsKmCuGtFU9FwGycm0BMrNJl8q/VktL0RZ9GppzrjA95cMqjPZ7Rz+YMfkgye9dfpELts177YkQ3xQ1hkzNe/t02m22sZy958AJtzU+VJkv7Jsk32fUtS1bks368W5OVUubSdts0AYB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kw7xb0RpirteHN0gdyYW4EdeJWF+ZVmPktH6kDHKECmVp0DRtpSTK19zL68Q?=
 =?us-ascii?Q?c2Sr348sHUXdYOgNH8qdtECXElDLkLqwN4PildEtpScdmmU4Ah/8JTXXsA1/?=
 =?us-ascii?Q?TTafe5xE7pmgCeczSzOlvngth4msD8dHBhzOVbmnbEB+kOBh4c6rcKfkyG4J?=
 =?us-ascii?Q?GIxkdXBawH8x8PKNdcjUQHEy5V8FdCKrQOv5mA8oNFRNDlL/nLuBKs0mNXII?=
 =?us-ascii?Q?KT0u5EZJFHiHDwmO7Ne6EzrTtEnumoJIo4+wqqlLxUqiYnnrb05tqiyt+nMU?=
 =?us-ascii?Q?XEPWJ3ghxv923/WtFFvUL+pNMUjI4woKY/CIM4temXkzpcOdFA43+M27srQo?=
 =?us-ascii?Q?/7yPfPUv2klzbXS4KV4rrV3O4DxtsPtlUqndp1J5pno/e3rLww7KK85PAWAq?=
 =?us-ascii?Q?6A8ZdGbmz4Rh1A2Tq4k8rn2ho2IrvLsxq3klklZmXg2Fe54jngPFrxhtMAo/?=
 =?us-ascii?Q?iDLHkNKYW+I76J4ajK4iZ5p3xglz0szVkUdB9tpq9n/zRSMfPNAnjpmqzhVV?=
 =?us-ascii?Q?b/ESJx7HSc4tJvoZtldJTtEGu90zQaVNV+s84muGXt/cFES2fgoGrNsFkSm3?=
 =?us-ascii?Q?l/0j/LcLUPgHyt+heQZ75YgvgFOOzbmM6mmmPHGRtV1a77Sv+SSrK58NVNwZ?=
 =?us-ascii?Q?bKXkz/7gwWGhNG+kD7x4i/Yj1JgKnhxXD8eT7CIu6SUWtoO4nroCnmAs/kdv?=
 =?us-ascii?Q?K1XDPflN3ox1W/EC5j6DKXiUzIVT9luQVXHq9/esSpAap2Vg51+fzRi9soVM?=
 =?us-ascii?Q?FpQKv54OchDh7I6Cbvs+yO0kMqgtsmyVcoerwEF67VNzHSoHB5KvXrmflV3P?=
 =?us-ascii?Q?cNsQ7Ys2AmqQKxoaAuEzGWEsYSTDv8XRIcdomuVss17uKOOcsI4TBHRIpOWK?=
 =?us-ascii?Q?jIlOC+pwv0VgfkWuivFefd+Z25I0CVuBvwa3jzDh7qxsoHas0Xr54/J7KVR+?=
 =?us-ascii?Q?jpJQEASdhinhapPKM+QtRsLss+4Mo/zKglML16mORV6MAnszaFnEPclQVkFO?=
 =?us-ascii?Q?Yd8CgJsOSXs5dxbep6xnA8Jjq3DkliGqjtsQVxok7Yp133lgdKS4hovEK+3e?=
 =?us-ascii?Q?EPMIUiIXhK+gJeyhoIqOV4ZUWmfTKpliXKUAd+V+NFLfldI97G1s88/rTwzk?=
 =?us-ascii?Q?1fnvfMxsr2DCycKJJczmzVoQRc3Szl9b8uFwC/JPb0lXINh1ZXD6pAMLZ+Yb?=
 =?us-ascii?Q?Zy87yAMRPmPOlvFr6POfZulK3YY5e8SrPTY6QaGxBTxnUKJS9sDgl47tSFf3?=
 =?us-ascii?Q?dMpBr1jOVV31PmH1JLj1p6uAFwAE+CRtVjG7ScBAbcsiKKzJ1Ily1Igvv3hj?=
 =?us-ascii?Q?Urk0amqxsP65b1Uwnyhhw+ilokRVKu/mig+ULpA20EIZUo23gaAwQhjgIIh8?=
 =?us-ascii?Q?+stF5D3B3gKK6GIrsVqv4lR5DcB3ZSXXa9Xa0jsU5iOQ/yssOFwnLHJasTPK?=
 =?us-ascii?Q?73vE++ORoA0GTpbxcc0aU2/LARy5GJRR+Qw/UDRkb7Vi3vxY2sVndg+Mzwz8?=
 =?us-ascii?Q?tRgyB7EeeREjWHZpbO3g666tqQihB+0c/K3WFRXbI61+fzwPp80hKIKhzV3O?=
 =?us-ascii?Q?Pfx2+2YfXj4KQAxMmkjshPvOn47opzH5PUw6j3xxG4xvO/nFEWxw4HV03YXB?=
 =?us-ascii?Q?gvQB6K3kY7OHqCRhnOZ2LnOq3wqmkMxnmIzbhIk61iEVGBvz5xsJbN5Z6byW?=
 =?us-ascii?Q?lsynBY7oxiYtFTU8lMdr6Lg+HVRgiUO0zEiG75RElg1OKUgM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d227e9-73ea-4380-1479-08deaf9c015d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:29:30.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJus3Jt2O5XG8qLF1g2850xo0bTsEdPVgtQyk5nyeSNsljq+eD80YKAmlxhcAXvcxtLJOh+2NZTh4uULCCLrdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10174
X-Rspamd-Queue-Id: 47F50515ED1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,intel.com,vger.kernel.org,126.com];
	TAGGED_FROM(0.00)[bounces-10328-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,kylinos.cn:email]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 09:58:12AM +0800, Hongling Zeng wrote:
> When request_irq() succeeds but a later error occurs in at_dma_probe(),
> the error handling path attempts to free the IRQ by calling
> platform_get_irq() again instead of using the already stored IRQ number
> in the local variable 'irq'.
>
> Use the stored 'irq' variable directly in free_irq() to make the
> code clearer and eliminate smatch warnings about potential IRQ leaks.
>
> While platform_get_irq() is deterministic, using the stored value
> makes the error handling more robust against future code changes and
> clearly shows the relationship between request_irq() and free_irq().
>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v1:
>   - Update commit message
>   - Remove Fixes: tag per reviewer feedback
> ---
> ---
>  drivers/dma/at_hdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e5b30a57c477..2a860679b9e1 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -2109,7 +2109,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->lli_pool);
>  err_desc_pool_create:
> -	free_irq(platform_get_irq(pdev, 0), atdma);
> +	free_irq(irq, atdma);
>  err_irq:
>  	clk_disable_unprepare(atdma->clk);
>  	return err;
> --
> 2.25.1
>

