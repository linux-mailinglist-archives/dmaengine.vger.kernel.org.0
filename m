Return-Path: <dmaengine+bounces-3990-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBBA9F35CB
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D531883FAF
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6F14D6EB;
	Mon, 16 Dec 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fTe1tvU4"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF68289A;
	Mon, 16 Dec 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365894; cv=fail; b=tgKWoP8Sa8OX1VFvA9jgTMnpAncViXTdTwsr0Q6V9D2KxaoJa886aDS7okjxTVz+9Dhy0H2E1rEENmbCrJwusnGpocRCVpwL+NLoZxglnXIGA7aJxqSUqnURY7dNE9GSk3s8cW4o/XViiAx6S2vMqCcBuHOTyTuFi6TErSiFFuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365894; c=relaxed/simple;
	bh=lemIMr5tgYD/+PRnSj2eK3JYI9HwFhBVvI6luYpYanM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CN7LR8dnP/1NriBxDs82RnJGUKKS472sZOQtlnK8NYP5k1Blzy3iQ7w4Izzc56tZeMQq/EwQDIpNk16iagqxiPkOh2KWKjO53IhkoeIee2bsBlPNV7hJV80jh8QNyqtIa2oJp/ShGtbXfrzK8FQZpeeTxIDFM2hVyLBf4Wy+SIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fTe1tvU4; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D18uOY2TWqjVv1DP35i6l7AP8pZwtH68NnPhEmr0o8lx9rRIQJiH6VXyJ16VG9liSBFZ9EtdAqz7xpn07+1BAqNCIJdVaYPP8PF+pgM1eOOF3JMmT1KT59a8TVoxXSwbEPQJZGXDuAaUqz6Ymt/UAs4l6388kvzCMUZ5RWDbVKm52SbcUNrX7PFatA1a58oF9GHQUJ+aD4sMXvl+Yca/e35CynO9VcS+S5DPzpQ02x4iVQTsuz3YBucQn6dbawfc5cioQauIChZaWWTVP6N8OUIw3qqttAvZEylex+wULGrzxIk6WBdY6DgTxND/gK5qV9sebDVvE3LtEFXN82EPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRhwhMl+3BWGxeRpCq7uB0/VsnBiu4NRyNrH8cqqxNQ=;
 b=lmCy6wPNiFp36LVOxIysilh7HiPmbhSIWg6pR+YOkveuuVBmiGFziE45DDqmckQH1bGGVlvvQc7ag9aY18efWeT76h/+IItfF4TTwr0fhvbM6ejWBImo5c63MKE9r4U8FZnQnof6PLnsrY69cm7hVxlFXd65cxJzFLKcqx9Imq6NiarEQUud1hKHT6of3rw4bq/PDVylBbakpDt273gNni2xFhS0hLMgI4xuOtxdsIoZYKA878GzBrFw4CmhAHqqLB0gNNVvKs8OiQtSU/WZ5xqOaqrUspEKT9i6k/4LTTyrB4mD4/YtWu4dUU0ZrV9b6iTXcshpbpAqIZV9piyT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRhwhMl+3BWGxeRpCq7uB0/VsnBiu4NRyNrH8cqqxNQ=;
 b=fTe1tvU4aEN288lDTjcivjjAdg+atzAbpgAtPaljWJS/Fm8u1AjO8ea3b+/D6Ixd5dYxjTxf6r3FpjocEywS5ZQ0lcj4bMN7gwe9qFD3s4Suq6rtFMx6ZJAfIVFlVry3tKWHgh5Zu38vjegqMXDAM8KF2ZeXmV23io9elKCys0j6zuEPNjUHwRwr+urfj+TUqmtOXt3nWEHFtk5gvaMfmeHVPW+G0GbXIEKZWUvCWXua6ARjBhW3HiU7EwAyALnjrSpiSqmksWmLO+dR9p3h1WmbzJWOtWXCmFQNFgFMBgGvlpvX1NNdH8+OcFFvDB+TaE/On0gmOXLr2PqPuk3GnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11043.eurprd04.prod.outlook.com (2603:10a6:150:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:18:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:18:07 +0000
Date: Mon, 16 Dec 2024 11:18:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 4/8] dmaengine: fsl-edma: add eDMAv3 registers to
 edma_regs
Message-ID: <Z2BSuA/3V655k2bX@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-5-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216075819.2066772-5-larisa.grigore@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f273dd6-a9cc-419f-7e66-08dd1ded3a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWcohwCuYnOmP0rIQ9E2zVxyVgMu+sNXlowazlGDEF18aBYciEOpMJv258Fd?=
 =?us-ascii?Q?Xx5+RkaJeHmp1o/Phlh+z9WDday7EnLXWef30e7CMltoShpFHnWdGuNktssE?=
 =?us-ascii?Q?ZBBDZ4YCHbgDA5lUxY/xM/+166eQmsEBeYsEtA0msDRd2QMIuim6TsStGa3r?=
 =?us-ascii?Q?ogBRKBbSX+Bb9kwCtvxE1aDR1+WRy7OnpG4GspkZ6Y8EKGUFT4rslKr9Cl/7?=
 =?us-ascii?Q?YIFDQbqVAcE0AK9CJT5WGnrx2u7ABhpDdotSozLQV1EQi+jKARuK+nUAMghP?=
 =?us-ascii?Q?6j9H6+LFTW/xnqgyRVyZm7LhoFoQO12Kg+7BgVatpR9aBXRI0H1FUpv7O3gi?=
 =?us-ascii?Q?z9iqzT9LMgEplsFdp1ashtowDrpyxQhtG7cjp6+SeSvrtRhb79+Z31RyRMHJ?=
 =?us-ascii?Q?epvE6H50AhH26EOEYSxyo6oSFw4n3r7aJNsjlmY/AxoQ0s36+hRPaFb5O/VR?=
 =?us-ascii?Q?U56WBrPwOggoWASHe8FSYrRD39pE/KqkopUNriUQnqQquFwfZxHC/9VHKQGc?=
 =?us-ascii?Q?7Vf2JyxakIKJ34eL1rM6Ftq02eVT4TGLFQkDEuD9tPtQPekEj2RczFXTZqHk?=
 =?us-ascii?Q?e7XSOvzXmZICLRTe1eYRoGcn1czpFngEIYySWJXNhPf+iyn6WT5EqoFsVr4O?=
 =?us-ascii?Q?coa0Pwxpn7QDHcYZldtd6Lgdp5oYl61OqbVAOVuSSq2g+ih1LqNoa9UWW74N?=
 =?us-ascii?Q?U51C8GCfS0wosq7Cm+8dPNxlKWKDu8qpQgG9Gzl3shYnfc/LlaQGlrg3lrlK?=
 =?us-ascii?Q?ADAkBW+6EckH0GvL6eml4oAItxOXMrkSqB86DStkbgsk9mLH5vDZTe5AJAdR?=
 =?us-ascii?Q?ivzoDw9yrIAdmxT81NLhtC3eWmtQXIVga5OOy1sLumX1kCDvgV36V1AtvwWA?=
 =?us-ascii?Q?IBpvgYP62eVVOumYkQ6JzIj+dyyqBzgQkQMvnf5JQx8ivCbpPUOXewnoBfNt?=
 =?us-ascii?Q?Gru7jxmxjEd8ZvI6SZeO9cLe5A3P6suqxKh83jH/eSEvuexnxSmNBYtQLiVF?=
 =?us-ascii?Q?TT5hMBQfYPOm0TWigZAnlf0lQvgS04Q1uRPgMEWE4R8VG6PmgEQ2Pq1umn9A?=
 =?us-ascii?Q?agZAYU89gGwtajO9WyWI+fM8WzSK5efBfR+6DF7mZ3GOWm3pZ74HzmXiF/mw?=
 =?us-ascii?Q?GXWX/jkDmFfGTNxkgKpiFoSKCxy/a9JLRzDSQf9GxJanJ1/oZQFmPh56kwB5?=
 =?us-ascii?Q?F7v62G+qL6JLEUjrHVBuL5e0CSO83b/w/QgwxWlJxxRuWqqKIeKsJCH9uXGF?=
 =?us-ascii?Q?saRNlqIsqyUjnPvlZBVAPkVpPBFDsEVBpCfDtCWVcdpKdVuPZzoBAPj1pjQ/?=
 =?us-ascii?Q?IeZKv1UJ/m+TcZlpXjqHyDUQSBpaAbNYl5rEubkO9AQUu2/Tm98Znx3jCYFL?=
 =?us-ascii?Q?XdmgNbfoCxhHs0fR6bfHI9Pr4TbNvKpFPyUrWP0tNY1vcP4WXiV8ThMQ1EcV?=
 =?us-ascii?Q?2vXKqg4argr/lroKc4NMhlNemF9cy9Rx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JxC+880OA40gNru7JmN3Bi+Ba3HIWHX+qAOM3QJBcaw4YAvLl3Ul7vThQQyr?=
 =?us-ascii?Q?UjlfjYhg8ZjDXmWjZ3flv8A880PRpm7jzxvEkuhORc8fEmQGq3YLstCY4Wsy?=
 =?us-ascii?Q?vbsaeHVLaNuNw6ScPM5PgGW0d/ncQ4+KcrKOlzYT7Mz60sVQaIU2X8SAB/SX?=
 =?us-ascii?Q?z5vVrJWwIzMxs68KzYy2xUsVz33ySQ5m0tIJ5vRVOeuUEGLfBzu0V+uOsfkD?=
 =?us-ascii?Q?pKJNIhxYFf1s383Pm5EVJ7FoRuEF8CtR8SzLwm0WlHp/QTc1Za+1yrQ9lwZX?=
 =?us-ascii?Q?HOWxY7qGrhwN5RbXCLScfwYQs8UQjen7fJjv0shvyknLAq8iyt/wmjsNmfP7?=
 =?us-ascii?Q?kzUvKgYgpUgj3flvSgm9wguiUftfjJc1yI7vxbIZLW7TaoUL02TnE0i4lsNK?=
 =?us-ascii?Q?hvpBuRicO5qE3m0EEtizNsxRjZwsoIJmBB3crqRvIZCXakXaTJEpT13gzI3p?=
 =?us-ascii?Q?ptJPL/hUV6/ExpQJfX/T4GVR/KxrEw0lml72uCLF+zDv2h8ZwY/hlcT5pAea?=
 =?us-ascii?Q?y8RKseNaCoraylqVi36uQwD5R0SW3R3WX3I793UE+3Z8yZXHvUGMFlVq2Frx?=
 =?us-ascii?Q?bk8bFaU9FFeefBdc++b3Kbu1Um7b6qet3kgCVlorbEt1FDj1t/rV6cOf3gt6?=
 =?us-ascii?Q?P8FUxJ7xksfjacqLEkOR1bqCe0byni14k6yzS5y7n/QoQPOj3a1Luun+hTw+?=
 =?us-ascii?Q?Jb+eVvQjPIWukS/baS7l9tT9hkPHQxShAkC9LYFbTTLMghGUX3Cln6QkTqjK?=
 =?us-ascii?Q?wbByDGc8OzCxo2yyyJr6NJVQxd33eyC28EQRtYOstBOMLLOjhdlfjBiEuHwn?=
 =?us-ascii?Q?Gb4qS8co7W+YK+TCEsrTNZeA8spuT/3xrtAx0YVClJq+xOQffvGt9LNj1E4A?=
 =?us-ascii?Q?IOBeNy9hiAXBbC223xDAsAMVJdqPNbc9nvUS7kl+j4VqxFoWvxm4KTOrMnrI?=
 =?us-ascii?Q?deioSBb/9vDzr3jjrzWQdiQEdav1fOj4DYzuSxk1fZp87aSEEy3z9M1XQWP5?=
 =?us-ascii?Q?0vtHz5nnuZgifmUTBv48k9L2zKPRIiJJr3sMXUdUhtBX/rEPygpz90q9TrKS?=
 =?us-ascii?Q?I5rVG4pFTjxORIha8o6jTz3szmKdlmvmc2oxWhzMfNFtjuTg8JyyfDlM6Ps0?=
 =?us-ascii?Q?czVP03jGHWLVZw0cRs7jGcoWbm3Lcb9AKJ8K5eVLbK25wpusci6dbxE9vSAq?=
 =?us-ascii?Q?mH+IHltCHHXk13cj8B+L8ks8oWxZRkWzE3+LkhvpkkXzje2Mr5wz8RYHNPOt?=
 =?us-ascii?Q?PumggvsrUc0SXapDoM7ZzK90WibMw4JYwPytBUo2eSImP2jwnQz8DLmwR7u9?=
 =?us-ascii?Q?3E4r0kC0A3iGZhmvYEP1EuBiJr1N388Lni8eK+6+NcVk2sHsLZMZKzhzEuN+?=
 =?us-ascii?Q?mUnLgNkjo0FfUOZaNEFFxnUKTs/xprXIvIsGTimF2QAE8uymbR7bhU/QXCxb?=
 =?us-ascii?Q?v0R4okZRRcH9qUNlYbO0MNElPCxV5l7uV78ZN42Cnak35lmTIizMJ43Uot/Z?=
 =?us-ascii?Q?YVU9nO3xD5WknDbqq73JFqKgAccK/0Z8w6/9HzrM9EWGWE7CXfMuTYd5xn7a?=
 =?us-ascii?Q?z1Gd7dGnw8WQyEgQJUmJmWiy0jauxrGJAQEtOZiI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f273dd6-a9cc-419f-7e66-08dd1ded3a31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:18:07.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CECP7zWiBvxm079EC0aVbn5d81P8SeIFqyx2q/cE2x1EXLI4BTeKZl6aYX4sFbUEKrw9fuRhFEaFS4EB/ZGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11043

On Mon, Dec 16, 2024 at 09:58:14AM +0200, Larisa Grigore wrote:
> Add edma3_regs to match eDMAv3 new register layout for manage page (MP).
> Introduce helper function fsl_edma3_setup_regs() to initialize the
> edma_regs for eDMAv3, which pave the road to support S32 chips.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c | 15 +++++++++++++++
>  drivers/dma/fsl-edma-common.h | 11 ++++++++++-
>  drivers/dma/fsl-edma-main.c   |  8 +++++---
>  3 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index b132a88dfdec..62d51b269e54 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -44,6 +44,11 @@
>  #define EDMA64_ERRH		0x28
>  #define EDMA64_ERRL		0x2c
>
> +#define EDMA_V3_MP_CSR		0x00
> +#define EDMA_V3_MP_ES		0x04
> +#define EDMA_V3_MP_INT		0x08
> +#define EDMA_V3_MP_HRS		0x0C
> +
>  void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  {
>  	spin_lock(&fsl_chan->vchan.lock);
> @@ -904,4 +909,14 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>  	}
>  }
>
> +void fsl_edma3_setup_regs(struct fsl_edma_engine *edma)
> +{
> +	struct edma_regs *regs = &edma->regs;
> +
> +	regs->cr = edma->membase + EDMA_V3_MP_CSR;
> +	regs->es = edma->membase + EDMA_V3_MP_ES;
> +	regs->v3.is = edma->membase + EDMA_V3_MP_INT;
> +	regs->v3.hrs = edma->membase + EDMA_V3_MP_HRS;
> +}
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index f1362daaa347..52901623d6fc 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -139,10 +139,18 @@ struct edma2_regs {
>  	void __iomem *errl;
>  };
>
> +struct edma3_regs {
> +	void __iomem *is;
> +	void __iomem *hrs;
> +};
> +
>  struct edma_regs {
>  	void __iomem *cr;
>  	void __iomem *es;
> -	struct edma2_regs v2;
> +	union {
> +		struct edma2_regs v2;
> +		struct edma3_regs v3;
> +	};
>  };
>
>  struct fsl_edma_sw_tcd {
> @@ -491,5 +499,6 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
>  void fsl_edma_free_chan_resources(struct dma_chan *chan);
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
>  void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
> +void fsl_edma3_setup_regs(struct fsl_edma_engine *edma);
>
>  #endif /* _FSL_EDMA_COMMON_H_ */
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 0b89c31bf38c..cc1787698b56 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -495,10 +495,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	if (IS_ERR(fsl_edma->membase))
>  		return PTR_ERR(fsl_edma->membase);
>
> -	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
> +	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
>  		fsl_edma_setup_regs(fsl_edma);
> -		regs = &fsl_edma->regs;
> -	}
> +	else
> +		fsl_edma3_setup_regs(fsl_edma);
> +
> +	regs = &fsl_edma->regs;
>
>  	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
>  		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
> --
> 2.47.0
>

