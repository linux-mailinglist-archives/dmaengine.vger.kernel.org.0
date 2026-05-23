Return-Path: <dmaengine+bounces-10776-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO5nMpPFEWr9pgYAu9opvQ
	(envelope-from <dmaengine+bounces-10776-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 23 May 2026 17:19:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAA5BF9E4
	for <lists+dmaengine@lfdr.de>; Sat, 23 May 2026 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEABD300D14A
	for <lists+dmaengine@lfdr.de>; Sat, 23 May 2026 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3C28DB46;
	Sat, 23 May 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fEIazeOH"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D032F3C07;
	Sat, 23 May 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549584; cv=fail; b=pLJvfwXudrTQbwy9ewKkPnjesbk/54HKqDlYTo4hGFiZvoIvqu9454zFJomHtSalImwu0XOPGwJzcJ43/NmGKfYv8j6QuuHQ20rjsnTIMbjymQ5ShudnMd7Pj1ndA9NQ4BFs2UNPQpMrAoA5D6Seof2iqjgR6hi+w6UZga7jV+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549584; c=relaxed/simple;
	bh=64JrRDNvY3yKf1rTUxd2m6qljmJ6jGMG/aOQgNMeCWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VjB3gUoFEugiyYhK6an9u82wPxYP9Bw3S1pT+olOW7rWyHFKripSGvPbhGZ9rUxvbPw+1PPcrMCxR3crCddCu79E1fX3Nsp61Sz7swD19biNW3shGyjBbS0wuxodMSqv15MJhCcbXPmNxiOC4vi1/QbnwwF+K4qDgLx4S+gTyp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fEIazeOH; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjATFUAzPVqab6QMtPfhgTZmq2iyTUrEXAKdLOgTgT+URTkwvxEZ0F67n9Wi0Th4vZmda0ygyZxW0Z6GvM96qNTc5mgv7n4GZhjAzcHnrxh2OD6sAy3xSt6IFmxTvrbCs0xTt46t0VIUpCZdoWcUO3xJHDh8tfJ2i1ofjQQXP+olzE6mWvKsj2vwDg86Eji8AP+FwQQ1K5/FQt7mdBDFQmg70utJzTVWjS6AIuTdJkRn9b0PkGHOhGEB4oLr+18JI3VOu/dZtmo02eYrYdvakAty9T5Z5oyn2WkGILbnlJGWnFUTjEkud2/M4fED6RmnYXdaxVyIPESqiVJFyE2Y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzNAeSwCF/KGd6hBJ1bel6nMFCmuynoIUJBDYRCJFjs=;
 b=gVWdk+sfFfPCdJWtwxt/HxLfgnReo3tUyzSQxVYhajz+FcSFhQnM13tHofjh42lnLNHGrWYI/JLiPSX1UFhi+kPhgeT+MNaw6/LzMHNXhHoC27XQzK4jGR5VvY6bksE3DfacJ906fXzcntoXy4xkKzhjrH8zWZM9WJSM9MC3fqRFFONoFYi4Qe62prax3LbcmCBEFbYFkHZuaTLuKKyG7BJQmKiaHaIsvWxUFZmcRFFIuMo04WkgU9vfcrlWYwy27I6dWeknlDdxzbxhemBXQeGeqtPzG3UswOQwB+5qKYImxmEs5WFKFHKcnJiOm/44/wF1Hpz3P4ceDHBlVp3zFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzNAeSwCF/KGd6hBJ1bel6nMFCmuynoIUJBDYRCJFjs=;
 b=fEIazeOHgK/zdBnZZ1OQhYI1/cAW4ak9Q2B5xi/R5vAubp5VVYwZAMp53kBNNcfy92/I5BJ8/t6gt+mfiiP0hZmptRvh+qUrY52NaRaJinPtLhsd8s0KxUsRBsO8s+d9GnWNwTDrI2TyjgHWV7Ydn/cLaIV622NVMgnTJkq5u9E7OeY359E8KbnpQLrOtVQBPQ4NVeQZdl/okgHdJD2GBOOrT6fQYDgCbQiCYSiW+SXO+EbPO6rWKhEM29v7egNjx7TcWTz7cKKvnmC1NXqKBhUCUmu6G3sTL4pvhC4As+3XS0SidWrBwwciwQELdNvp/XtkmX6s9GImduWEYqk2VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Sat, 23 May
 2026 15:19:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 15:19:40 +0000
Date: Sat, 23 May 2026 11:19:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Message-ID: <ahHFhl_joZsKc0qk@lizhi-Precision-Tower-5810>
References: <20260521100640.3333076-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521100640.3333076-1-devendra.verma@amd.com>
X-ClientProxiedBy: SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::7) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e32ad49-a5dd-416e-1c2c-08deb8deb535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014|18002099003|22082099003|56012099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZGXAu2d4w69ogSYhZFwbvCQLLY36cUmQ28tR9bNm3wKE4Stanux72TRgcZbOQS62FM2wonRjuOkBlfXrYGzAwacM4fsR5rbWNtJw5F/UtSny8LNus32P7/kEN1D0g1A1KfZp1QwHYhciSRx5r+BEsAN1BWJlpjDGm8+zKq05urzGNQ9QhvneuUhMfQIbWCFbHrxyPtF7YkrAX0y+D86dus0F3GOlVfaQV8fbXMv10OQru0Uri/yoi2qpCDGX+TxbveUW2mcCjzRLCRQ0rRkO8qHIn6DPjJr53WvAVE6ZNs6WAhyDaaDVZhQuC0uKMSV7+fxk7+q+xXGn/Z6hpqMWneX1WVOl3k8Z7LnXog+50pYfVE71+d+ElFs47dyH8o2onKUJc22h5xkJIgv0alfAt8SHZcBNkLGSW6Xm7K+FImInmoU7P4CuGkB6bFfb9SfLDn7jIbWWZr9mOooCnuCYRea8kZwd50PtypCbNKkSAUUR0jFN7fg5IaiDKYYt61BWaZxvEsyp9H2Oqk7NkdYYOBun5CuSxEHxZpCRNFev42F+/S97hBTFkurK6JzDlqXKk3ADc+hmJ6eKmhy7Kt/G7yuDjKvtTAzPo3bp4gqlPYE8uHqcXIintHtgvyXHesnvOHUAUGL+6xhL05rH8poN3/Lm+Z+xNv4WZ6JRHn+zQIYAaMM7/UYP8QdEsBhX9H0oRJU97/ynuVDWGhzh793VXvpgdksf+wBsOsnE5wXtyLWVfX23rm1zJUpmcLZZp5/U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1CNc4p60JRmbc9IB0Y8KYRNrjT9ntmrjxxn29C/2rQT+H14z0JfPii0q4/Ok?=
 =?us-ascii?Q?VjZ7n7hFrefzQ/4u1e7sd2JW5stChsHVVpW/ZEyZqwb87iOlB7GwghCObr9K?=
 =?us-ascii?Q?6k0RTS7tgtl+rlU9Q88phWh8kWEae0rM2ZWlIWE/ZpRGSlvAoX+bo2v0AUWI?=
 =?us-ascii?Q?OERhDXccU/LNS4qFrssI+Rl4sb8NOXnRcaVU61LTyMSXmJZfvNg+Tbt7FMi2?=
 =?us-ascii?Q?lC83AeozBNbcd9eWD1GlAQAdd2YeWxBtEmhaRH/aX/nSt0s9BeS76B2wlwi0?=
 =?us-ascii?Q?5LGB2YRT1GhvlUcMFfVP8i+r2nie166IW0OrV+MV292N2UTULVFgEyxuuawk?=
 =?us-ascii?Q?RWkPjDNj1Ko4kCwUCTrzFxQ+JLBQfvxG8pomknC7J0of9R+hN4qNS/LXDCXY?=
 =?us-ascii?Q?sCuevXq6KLbcb0SLlML0niu5E2r68DzCt11DbbrIr8T8IstSSbncdwMRkZle?=
 =?us-ascii?Q?Assf0+l/VCWDNP1WgNZb3GkAjS0o+NNZk1EDH9xrdyqRqcgdwWFEAS/vk5L4?=
 =?us-ascii?Q?xoA6WXek60uAY1GeH2z7JO34jwanp5zOkbf9gaFgu5cPmGoTvH5ZAPS3P2La?=
 =?us-ascii?Q?YwfQ1clIAAt84dvA0kqaFwr9FuWlQiA5e3dAsZOTcbfnYWdk4kG9IatSGIp+?=
 =?us-ascii?Q?67HGmk9+Agn9ffx5phz5vMsSwNDkZVahUFD6smiAkCIo7hKMjWjO28JC5pS/?=
 =?us-ascii?Q?CG9bBwz02XeVashOn0NC/EBdFULrjHDwSQX1MTFEThnuLsgLsUCAzyYiMh9x?=
 =?us-ascii?Q?9E8umpXr6JoZQb0ccKKbBndE45BBgBEOlQYdgg1YTj18Et9B+IOHOAw6bwwR?=
 =?us-ascii?Q?BpjmnrwPgOzaBznI4uXVP4K9QYBUf9mGiyLZy/F2zL5Fsuwau+FAv46qIQxf?=
 =?us-ascii?Q?N2U+mcjGs3V47ataXJ8xpN+GfPMNFfCLDNdg/BPR+xy3uWOag/usBkyuNyQ5?=
 =?us-ascii?Q?jACrd/ylacD7Z0L03Aj3edCk/gQ37az6Aqii251ZxLGuxLOD4AE5E88C9mZS?=
 =?us-ascii?Q?/NB84G24x6P0Y1uT+fzeTH87nKQARhCZ1XsENUJkedbna9nibjVMj8rZaKR+?=
 =?us-ascii?Q?ZvBt6JuHMFsP442/qEI2AULPiLHIbyIIdVLRJsnKG9G+7AWwKqEWCITVmDjl?=
 =?us-ascii?Q?tc28TDwQ2m9Yo7gU7z42lugl+kMRfccotceh5DFze2OdcjDpWRmHiJly0CJB?=
 =?us-ascii?Q?XBSE0xaRNN0Yg5iHIQAH/eykKIpJmQQ5VG+Lq3Md0cOr4va7l0onhl7sIu1D?=
 =?us-ascii?Q?1dD00vqIZt+sksoRHeRHx64uNvvryEQVqr309/q2+5QvgDaWnc9kMP5QFKWf?=
 =?us-ascii?Q?BOV63r/YTOA/qRKkKd/6IWP2PQ97A90a6ebE9sCic3vfGRrz4eVyiUR0ORwb?=
 =?us-ascii?Q?iihw3j2IIA916FWjK7VajXo+InjHB6uxoy2oqdHSKbeZM8sDJpDBj5qFq9Mq?=
 =?us-ascii?Q?H+ZMDL/U6JANbLNiSe5c1sj2T8rDeoSM+ByHiOR+uDSPuddkN2sPwDDXAeRn?=
 =?us-ascii?Q?C2E+Pnh6R/jpFLrQyu2A8Uwjt5YdmYtSil2sx6NEMBGHn/buXhBNrg2v+MLr?=
 =?us-ascii?Q?96BkL3pjJ9xzZjoOiIIabAS7sbD8nXjyZ2L4vAzeT1fsdnz9CapithrRyzfj?=
 =?us-ascii?Q?i8+hyJPsXJiUBDK6WyjOWcBbKfQtKJe5HW70OqPVd2YIpv7Pa3rydIbVl7I8?=
 =?us-ascii?Q?IO6oPI62joDVTLm6DSzsRoazweI/zH8U2hxDRw52nhnhEJjE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e32ad49-a5dd-416e-1c2c-08deb8deb535
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 15:19:40.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFyuxKHbX+gORH2DVrdCxL2GqZeZMlieQYPatilkW5iIdRqAuOw2K/D8VDFXINaIXZ4haPSitoZ7CWgdKIKuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6802
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10776-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 31EAA5BF9E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:36:40PM +0530, Devendra K Verma wrote:
> Function dw_edma_add_irq_mask() is not used anywhere. The
> output of the function is not used hence it is redundant and
> can be removed safely.
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-core.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..89a4c498a17b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -988,20 +988,12 @@ static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
>  	}
>  }
>
> -static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
> -{
> -	while (*mask * alloc < cnt)
> -		(*mask)++;
> -}
> -
>  static int dw_edma_irq_request(struct dw_edma *dw,
>  			       u32 *wr_alloc, u32 *rd_alloc)
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
>  	struct msi_desc *msi_desc;
> -	u32 wr_mask = 1;
> -	u32 rd_mask = 1;
>  	int i, err = 0;
>  	u32 ch_cnt;
>  	int irq;
> @@ -1038,9 +1030,6 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			dw_edma_dec_irq_alloc(&tmp, rd_alloc, dw->rd_ch_cnt);
>  		}
>
> -		dw_edma_add_irq_mask(&wr_mask, *wr_alloc, dw->wr_ch_cnt);
> -		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> -
>  		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
>  			irq = chip->ops->irq_vector(dev, i);
>  			err = request_irq(irq,
> --
> 2.43.0
>

