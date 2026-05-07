Return-Path: <dmaengine+bounces-10271-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC3KJgTb/Gl9UgAAu9opvQ
	(envelope-from <dmaengine+bounces-10271-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:33:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB84ED771
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C5A93026152
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E02302140;
	Thu,  7 May 2026 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EQWfev2I"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A52F49FD;
	Thu,  7 May 2026 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178817; cv=fail; b=FmWjYzMFvM7dLoQXBPpIXVVVhrH7V0uUMecFELO1SoJ5kSnAfn7lJpIjAMNBLXvDsz0RYamI6v13VWhtZVpfwXhbB4gbbcw5TuTqm1Um6iPYOUTF95fp/x/FzQHPD1qvTGURVRyMwIrTWUsEt7qILGkywSeT80w7KMHGLfHlXDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178817; c=relaxed/simple;
	bh=cLxrK2Q319OYUZl6n6g/8ArPwdjgWlHeQhSs2qljICg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N28ESTJzRwAWj+G8ZpyWdQa6pKH/+jvra87/bUErTvsLhP/XlpdhB385GA+ArP33tXZqZzkNVSIv37vS1ODCAlHjSxYoj2gLBYePVH8gWkRSHzCTEPzuZafMQVI09/BVAVkKbt0V/o0RsNNWuWzNal2R7CbyLv6qiNwFyt5xMew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EQWfev2I reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltxDFi0BPrrpq5DL1Ikv7v4g1E4LOWh6WqTca8VpdHio+c9q/VJ6vX2VRU1VAcqSEfbhJFr9VnQE54Jrq7TMR/sahgaMyU3aIWYEvUgUkn2jpfJBda0ua05nKu4uoJAivLWJrxPgR/qu04QNFSRFXSQuP6TOAz6JQK1cl+MU+6PwXHetYjUe0nuHQgvHR4IFXLafFqn+D9obTde6c9XNsHe8HrveSMieEaV2cI3k6RXY5aOMUVg5nJJDFfF/1g+JmXBaxReXF+zGnDNAuHjfNFfqdYOxPPxepaOj6B/QGhXcP8eD/mXWrYgdBGHAGu6OWMhwx67u3iiMmoWNG5w0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAPGF7vkVlj0F1rXG2bAHZ0+Qp49cRjas7GpaSdor2A=;
 b=MSSPzzNMyyXl3znaenUqFDY22mnAYNCEt+G96Dhf3eJNAx4RbtBxyW6i2QorXkVpYOWCoDMS+9ZsmRx6LJEVPyN9WHcYK9KUkcQrnyILED99kqMTaJLSU+oMTroGgsoH4ArQVz9vklyU1sK9Th/BPV96HZO7e5D2Zz04wsIjd4Ep3obpywDbIxsjBalMXlcefw3SCnIK8Mq0+hOy64ui7vF8jn2+ey6irKrZfGIzfyGKK3vYP7x9mFv5YknN7jJ7Lgtck8qkBIh57UOAjyiiAcyHbg5Nl+0uQPwRCsETgsrs+44pd0bCH8fPIB1SNvDFrkYP58gQ6u1D/HXKbsvAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAPGF7vkVlj0F1rXG2bAHZ0+Qp49cRjas7GpaSdor2A=;
 b=EQWfev2IE31hRKtzk8aKsXSd0677h/nhCnJiyWcaRpERnPqh3VUQ00M4qKvCnKQRNljmQMZGZb54DduZ7W36/wMY8m1ViHaAs3socFo9D/cvFUxOemQ1lEuoXAkXZGKbSq5kz/N0llR/HFkJ/vLHIvS2yM56m1osOSnC0XhSXlYSVyF+NKcl6CgNP4BnF4rvN5csdOx5L19dWvnRlcwOjHBA2kNB0SlZDd3PvebdWi6zOAuXKS5qKHB5CtoMwuxFjCBGvRWB28l03BawsFi4B/HlhkfxMhCfWMEJzMZ0Y4sln0hk+6lx0PlDgYzW6iMn4KzFFXqvB++pnMSnrIdAYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB12614.eurprd04.prod.outlook.com (2603:10a6:20b:778::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Thu, 7 May
 2026 18:33:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:33:33 +0000
Date: Thu, 7 May 2026 14:33:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v4 1/4] dmaengine: Fix possible use after free
Message-ID: <afza96yBZIK3zYSO@lizhi-Precision-Tower-5810>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
 <20260424-dma-dmac-handle-vunmap-v4-1-90f43412fdc0@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-1-90f43412fdc0@analog.com>
X-ClientProxiedBy: SA1PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB12614:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a4c36b-32bf-4743-edfa-08deac6724e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	2ZALvDcS6OpBWdgwA/PfQpUrUd6WyFdA2iGDr+E/3ihpnJkWmnVZIWrvHUMdo8FBs4oe0w7jKawYz8dtyXAhsgPImBK5otUiVKnIwQsonsh8W2Wvd/eWtytmBvlAN3lEO3ljL8PTLMw5azqrTA5PYcr5pJ+joFLQxCis0UtYgcxO70qCQLt9WeVEFi3RU/8hqq9MJwLnznCYEC0ebaeA6rufGqkrBwn42wL+9AeqP769END2qfOn+BcThXz41MeLvH5U8mkD7IvNQDw4ea1KOFbECCGwRPRDWA/dnLFTZBfl1mIjy280EiPizuoZzWad3rtDspb4shnFCxMW9AqOtRY3e+KpV2wgsyKkr4bdmMmpqNWJR9ATXPUC+LYi2ykqotJDFslKtl5riSLFBUW6mYihJHAl85yg95IqfX3xZzzDavJQVo4xF5qB8Y8nEskrauINtx7XyyAqYoUmrZuiFAOha19eU7vNJ1b4TVeeUoGEuz45Vgng0adplTl7lyLNS0PHp4kuvQh1xEj9G4bgE+lzmMXUt6s8q4C4XackXKR8P9ysyn59OUj9OJdHxRTwtTfhgrFfhyE0W4DSOXkwwYPA+mP0dwAHGs+/SfIUE/gmfNxhS/UUyJmKfCzRoUuwmXDNICZz+0RPKOFAOWbZD6vGCDFAj8ziFXBzwaCguwHfsZXIfmuAOyBMreXEQ0OQB18ZR1ms0SCGTQF+UbnwJ1Rj+f0KnorBc3eUDVpbDrnEe3CIWabAMkTRYJ59jzGz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?AsR2vTKogiUTdbFpXhclcCiNciRAfa/lpdB/wVtQp/ODUNFTMX461sSo36?=
 =?iso-8859-1?Q?c9A3cZ865fVkWeI0/TBUCoS3l2onqWwUhXG1Ns0LsEGORbywBIISCpVxE/?=
 =?iso-8859-1?Q?NLAy3nIGcdzRd+o5gEiDQUNy6RvBRr2u5vchTZO8L8AxAbxXSDAfU7usEv?=
 =?iso-8859-1?Q?Ro2Y46lMvB4s0F0jfxTNXdO7F30iUbsB5y/qDTFjFzYtgIXc3KahJGrDIx?=
 =?iso-8859-1?Q?Uy0JQXNKU1qDAnp5H1O95IVzIBbdJ8m1pAd5vV845mCqc1XMc2rX9VDcbi?=
 =?iso-8859-1?Q?VIIDcSeIo0CjyM2JGtKpnGLRl9Mk6NZQxiLOSUghkg5LWLmmnRbFxuobA2?=
 =?iso-8859-1?Q?1kxhQ7bNck5updDZNAy35xAAidSMF4vya/HN08xVo4dfVtfU6i5nXb9QvY?=
 =?iso-8859-1?Q?NDcVeVp6SLS7Hz9AssTcHAQmXc0tDPXDojpl7NEMHSCzCq+hYgyEF71PUS?=
 =?iso-8859-1?Q?ZI6V7kvcSvWvXh5H5ihKtWC9X9Osb3SqP9506ub+r+sOvb3KsIFDy4Ka+A?=
 =?iso-8859-1?Q?Hto9wXR6fIOIH/xMtu4r20XnSaepz0pj9809ZBahz5mPfAjLYlxhRyXBHw?=
 =?iso-8859-1?Q?9VXS6xD+FmhnoC5AQrQacSD2mG2MsF0I5n7t6E2b+TaE70fbG8r67CWSgg?=
 =?iso-8859-1?Q?aHX7BZqUE3ii+v/JTlnhKVLVypp5p1Ixr4S9+YbAeox+jIVvXR0cjYQ33a?=
 =?iso-8859-1?Q?c84TfdFuR7Zu3QzlKZvOeczoRyAQl2vgRrySBtLPZFsOXbyYD/LPY0axY9?=
 =?iso-8859-1?Q?r4OrZmpKFev7RdTyuGJQwanwxugEZJe6QJ22Uiyj7QRyU+RUsRViGwkWAi?=
 =?iso-8859-1?Q?pfpJfhcHqM/I46ttkOA/QzwPT/NqmKdhNucTjz9C9JV3o62RmMMnV2V7yD?=
 =?iso-8859-1?Q?/Pcjhi5OtBp5YFX/LodpH842qNJ0T/yOAUrwv1x7DMGdJe2h289FZToPuP?=
 =?iso-8859-1?Q?+lb+azC0FXRpZXY9GzxI/8DIGLJDBrmD6eC5572FL8geYQBIoMQr7VZbXg?=
 =?iso-8859-1?Q?mzrtA6ScU2YbZDE4WERR8bgSUSRRjI45Nvz9VvZOMCp9rSZidfSEUKGYsl?=
 =?iso-8859-1?Q?H+SVzxKePhurf6b24ITgMVov4BQoxRAEmTmPRHpAViogNqlcu20Dxcgls4?=
 =?iso-8859-1?Q?2Lc1AP6/FAjh3IcfqIKf8UAY14yZcaOl/pp6101z07sMBs+hTjX7QqVfrL?=
 =?iso-8859-1?Q?XPEKM8CDP32du9Tw3kca//3LYAGwrO2P3lur5kdGooRdwsiHBPLZb6AcRm?=
 =?iso-8859-1?Q?kTm9pkvKeH7g13rnKjZHq0Wg2RHYEHHIeAFTT3m2A9I+JIENrfh+USgljB?=
 =?iso-8859-1?Q?emb6MCccPH0M0YEmjUBTY85Wrfo+fCjVtC4hBneJTXhcgtZ3e40VXSmFfI?=
 =?iso-8859-1?Q?INVLm8USaCEbRdPWnu5egG8xtLzjwenpVK0Q5cjnaBIKuvrMqmRjF5vyFN?=
 =?iso-8859-1?Q?HcsVUjQqk5yHaYAcPyLceK9rRzVjfSnWeEjZJxr1juZg01p3PaSfPUAu8k?=
 =?iso-8859-1?Q?8uYjsSepqbshwaV44/yEIFs2OY2610H4/nDybjVHP0SOjkzpVt6sNKFQAs?=
 =?iso-8859-1?Q?782sPP3dezTrDrlhbH0aSyG4fkstVeZD8JBzvBwtjh4vbbAfPB+AdQF8JV?=
 =?iso-8859-1?Q?A37ljScfnigsYFoVYCVOF+rcOdzgFj6ijgggNWUd/FNAnXsGi8D7O6Opwq?=
 =?iso-8859-1?Q?8LOk16bbmt9r6zSvm9bwV2dXmoNL3N2cXDxLQqEalDWdWQiZVWlxnBgG9D?=
 =?iso-8859-1?Q?lx5UbM1AU4oQBxb1YBg1N65iXIXLclPus/UgchmC1VUIrC8lVpCT0IF5hn?=
 =?iso-8859-1?Q?4SCFgNPZnw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a4c36b-32bf-4743-edfa-08deac6724e9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:33:33.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MN8A/U6kkFqb4vZgSiq1R8dnENzoIuZcV3wPN74if9hA2ZU4/whBfA6Xf5I7+Y3U7CtyXs3YptbS60HkU1NOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12614
X-Rspamd-Queue-Id: 05CB84ED771
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10271-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, Apr 24, 2026 at 06:40:14PM +0100, Nuno Sá wrote:
> In dma_release_channel(), check chan->device->privatecnt after call
> dma_chan_put(). However, dma_chan_put() call dma_device_put() which could
> release the last reference of the device if the DMA provider is already
> gone and hence free it.
>
> Fixes it by moving dma_chan_put() after the check.
>
> Fixes: 0f571515c332 ("dmaengine: Add privatecnt to revert DMA_PRIVATE property")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dmaengine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 405bd2fbb4a3..9049171df857 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -905,11 +905,12 @@ void dma_release_channel(struct dma_chan *chan)
>  	mutex_lock(&dma_list_mutex);
>  	WARN_ONCE(chan->client_count != 1,
>  		  "chan reference count %d != 1\n", chan->client_count);
> -	dma_chan_put(chan);
>  	/* drop PRIVATE cap enabled by __dma_request_channel() */
>  	if (--chan->device->privatecnt == 0)
>  		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
>
> +	dma_chan_put(chan);
> +
>  	if (chan->slave) {
>  		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
>  		sysfs_remove_link(&chan->slave->kobj, chan->name);
>
> --
> 2.54.0
>

