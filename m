Return-Path: <dmaengine+bounces-3992-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E29F35D0
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B17188CFCF
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAB1494CF;
	Mon, 16 Dec 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jKmjA2RW"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E781126C0D;
	Mon, 16 Dec 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366014; cv=fail; b=npqiUihye8aFNVr/gV+5LMR1OKRtC1XXah20s8b28T5/t3nQDNImHKQG5K12JvNMy37r6aSj5frC1NuQYLc3Hr1F0XMhlQJMDF82oOUEZ4zaJKr6TYyD/dniyjcZyrmluvtHaxyeP2qBJtgJUXzkBnoA/JAPjTTt8iDvd6MmQyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366014; c=relaxed/simple;
	bh=oCXpysiYfyvjORtFm1wHxdl/m+/fNbQjwgUwgQMLhXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GohSlsAjQDpBszsjYuIMKoArS6GIQoeLV8t4L1kIU+W0s2Ru7KYtc1CVNwGR1swIHz4mAE0jFjDOCyMFlNJWWAjwj35i+YM91Cjdw0Vm0+mfjku9oqznCQTpNIiYmLq0z/J7PXzipQ7+oAvC1gzjIbG/ZYWZgxB4qyNA2SLkXsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jKmjA2RW; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6ImBCQWcofLwQwK7v+thc2D9sKBlUTv7QeG48f4qneFUJBMjCN+D7P5fcy4B8UsMIoC2VLIGQTyUGc5ob+ql0n189QiJEH/GSH1LQ7njv7i+LI9KbN7bG9dVEPn/YZumNt8BHvc2zazvICdAJS/XW431ShKZxzl5+qoR71AogXkkRruxrP7q007Y9Xj38OD94evBXrNsnIId/YIxxtvq4FFMOJxSUqSKrI2v5d1kXVLIbJgznkGLkcmcba6NrIPPxy6UmvonD9yr/yfwZ8/Q7NublscbA/TSBCxJVyJVhEDOlTrDa7NM4LL8EOTsA37DPMQuvUUo5q/WOd6uriU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViqE5uc1c8OKNTx/5gEppMba3hcpicCyTx9x52KaXs0=;
 b=rd8fqoF/R9XDaAqEeVWlcvgmMZWROGNwCpCvzHcnR5ST9mOoP9y2rM8vRGKakTYHjWalZGOFogZOE2huITHlRf9TSGpP/HNiQ494ipBDx75Og78PcvZ89gpooEJzXriwk8v5q40PQdruVFJsXB44oxA/vqu9+O9qgI/Tdv3tIBjNnR8s6PIu7PwQFXaLKwHbEJMD87YjU7wrDU1cvSFaK2/cZC5oS0ZfQGVYqX+TwTLWJK5vEc/JjNsk72GiMNetByDUlwPVtknjmbktQyjaxVZ5Y6snknjb8sbalch0s0+l7RtQTcR8Xo6bPpZ35rTs4SadyINqsYclK7UIvBmkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViqE5uc1c8OKNTx/5gEppMba3hcpicCyTx9x52KaXs0=;
 b=jKmjA2RWU8LW3gmZcOxGafWxKddGSaZCTU111QJVXvys3uJ+YCek5dpQ6Xjcm+dQnH7mnyCjDOWIlq2+ndNW6cul47W1gIuSsWXBQfM6/qFY4fFsaVVWHSeZRAkeX/mw3wSzM8AIt4Rnrv8KTzyJ5psXfK5x3RUa+o8g9w2wkpX8derhqqjnWTR+Md8iIvb5+NvxgbuqL6BvRmMv9bxJoLiFW0pO/5cv+1+dvGE2sBpcGoN+IkHd55leYO+YzRN/6Wv+5g6DOB9OItGCEpxS/mtPXkN7sNrjNEBnwmBlsFTVN6ZpyFq0xFLsVgW9KqYREZ2PHMctab7xtu/ylGgpaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11043.eurprd04.prod.outlook.com (2603:10a6:150:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:20:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:20:09 +0000
Date: Mon, 16 Dec 2024 11:20:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Subject: Re: [PATCH 6/8] dmaengine: fsl-edma: add support for S32G based
 platforms
Message-ID: <Z2BTMqAX+GKBzeFJ@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-7-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216075819.2066772-7-larisa.grigore@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11043:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bf3285-d6b5-4b0a-bbaa-08dd1ded827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WH5eOW6PBwLognwZqgd27ZszbYJLPCN24dGP/bT4uz6qUaVVjkP768kc4ccU?=
 =?us-ascii?Q?KEAXXkN9iEqejUYOl1Fi1b50n7UQ05er6vYPAT0O1ruZpPvqE5PT/XmI4ulm?=
 =?us-ascii?Q?nA7/QoT5rJDNCP3ZAj+7QpykNFC4H/R3w6t+kOCj3VmFooYbKlRbjD2ED0Ti?=
 =?us-ascii?Q?FaAz87Hs/ORkUZQgFJ1Gj0wF6KdLRsceo1TdLeLPlzUT4e/w07ZhuJPfZTt5?=
 =?us-ascii?Q?LnhAwXo21dNYAhnLnUzTYPcDjjCL269oWi9fAvZtV0995+CbDbMT0TliCciu?=
 =?us-ascii?Q?QGQMt6pQvTU6q26+UwxtndgdfIdT9jGt+/VWQv/pm5PH2+lqiL0N7EZHUjCH?=
 =?us-ascii?Q?JbTUTVoSbp0sQr9xh+ScZV+jrP7grdvscdcgg6OZLVVoaHNWKt39gDJCsHGm?=
 =?us-ascii?Q?HQwARac3bRF4C7YuIrXcjZapq24KTtFccd38a72r1jDvEcSVg/P/Wv3uPBTN?=
 =?us-ascii?Q?oL7xYu8bh1L2T/RXQZlP+0fFaR7HZeBCTRgesvL2aAMxwTZdE4nx878GEuOi?=
 =?us-ascii?Q?EWKZ9tfXKJKOrCHXdyAFi1ho7m6Sfa7l4VAVbHCmuikUvCM0DIz4O+gwNC5Y?=
 =?us-ascii?Q?93Y7x+r0m42tWxMiptil2AlpRpMb2zsVZ2nLoil5hRbpXOkEzqqMiWZyCGge?=
 =?us-ascii?Q?X+8AMoXcSRIHLVUD/T3I7qn7NNzNEqBBGeSZ66Of6g3toYLUncDFKdBmGcK+?=
 =?us-ascii?Q?E3KQB8tP6XOFiyvej8uIJzEPf/n8/OMYZXqeyNRPcE5nm3vQaVNcnEt9LTAl?=
 =?us-ascii?Q?hEnwt6YQGnPHJNIr8PzaGQ+Ht0gkXy88FGMZIx2+Ho/gmXNVZUKdpfeb6mDh?=
 =?us-ascii?Q?Ghro5eoclYBPIgOvrSXIuceVekmY/Y7SKEc+6sE7+UYKheCZM/o8JX20i07a?=
 =?us-ascii?Q?zOGqn8fGhqldatB5Zl9+TueOZ8w1R08lBwZpv4khhXc4eG/kSP3csV1ikPzS?=
 =?us-ascii?Q?6T4Bm0/e7Ahy4xfAIc7QoBLYybr2OlXNTWdyJ1syy39D67p3l8Q81cN5LfNR?=
 =?us-ascii?Q?LDnC2AmBq3SVPnx3hFcnUO0vQV9u7TEQgxlK9IIVsnMHy474aYi2iRd8GVbG?=
 =?us-ascii?Q?g4zv3iSbVkSAxJCq8qts9dr7g/ozCxqR8MfVJGhf6y64IZ85K0D3vS0N/UrA?=
 =?us-ascii?Q?yx22tYZUcwLtPAOVyytYZgJVtd0lDqAK+AQV60y+F7vu0uDtVS38KF8HoCRO?=
 =?us-ascii?Q?xvfrTvdMn9kVPoH6OFOmp/RnFrIFK1UZeBm/I9QrU4QxC25Hn5Bfr6vEzQv6?=
 =?us-ascii?Q?iU8Z3CP8KefX0la3t9O/e0jVEGKmT0VdBQotDgdjxoTYPneBcMl5ttWC8F7Z?=
 =?us-ascii?Q?4tRjdFLKh19ufloyi2N+m5rOJVsz0uBAs7OLOFhoTWk7mGmDUNOSPPBswJBY?=
 =?us-ascii?Q?UK80lWinozMyNPY+FvyNKuVVPnOIDTxjKSc6DT3td9q4X7AqPw+Isc9rVjko?=
 =?us-ascii?Q?Kn4YWgiHEmrE/9LXcYKjl2LP50JCsYEB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QWBtwKMMTqP6BMs2PCZGLypvz2r/r0jEmy7w7QODJ6LYzu+ShOpBMVIf+h6h?=
 =?us-ascii?Q?6Bnk166NX/1t8+J3c9Y0Kik9t8eTnHuXVvBV0FYUG10gXarkanmfgTq1soTV?=
 =?us-ascii?Q?+5Muqm6ZCZqLSUJix6WqWuHY4AcrOx7zTUTRjAnhjUg08Q3P+rFMPnfDgZtB?=
 =?us-ascii?Q?Tq3SuByOWZYasdB1E1/tZ7BslvHFgIEtFSYlu/FZ4yggFxFPpY31wlAbIVKo?=
 =?us-ascii?Q?OFKuO9jCrM4T3fgamNg8dMtYtnEhbkB/Qw+YNu7gD7dnCdbtcSdPKsphLFDT?=
 =?us-ascii?Q?LlCTM7EhSMNbuKr1m56xDwF2ugpSiiPecBzjl8xwmE9FCksTUscqojOLHWCp?=
 =?us-ascii?Q?PwTGSzC0dqMjunMEsbJUFAwFYQgKe5b6TQmtVnSy2xMcGfUTyU1PExrB5Og8?=
 =?us-ascii?Q?SRSh1qvZulC5PAAXteFnxw551oMb7q5kJnx4zH/yYT3l4A8P2OJiFJtux8lo?=
 =?us-ascii?Q?fc1Y/n5bsqq8M2bl19ocLQMQ8kRAL0mlEOAoDw2mgCZAhs280JHbeh0sIz4M?=
 =?us-ascii?Q?rRmSoIA6J51nsG9kgq/skhzIfySGsaoIpx/1Ol41VfvbfMghm33EcdQfsoLc?=
 =?us-ascii?Q?DqbsM7qt2qThafzztQCqNdXzxJlEpBoG63I0tGMxZi5GESgVxBO+hPfwrIVt?=
 =?us-ascii?Q?CT5sh/PzKoO+aJ+wDQUzmVDp4QzgwdIanqGxt+HCudOcysoQ10n2KGSdJNuS?=
 =?us-ascii?Q?qnsKRYl/6EkR42P6yq/kiCvJtzFUQUy4zcsc3GSnskBJqrC7xdzP3jYoeW95?=
 =?us-ascii?Q?x1xfs+aFJ6LfwsPfo0D+wji6b+Ml4od/dzzai5Q9GDR5yrH2zMZV7cvRMwpx?=
 =?us-ascii?Q?T63+jsBObMIcds2oMhzU8M2Ih6E17SK0vx46jWD+cULLVQqFn/BcnC8e4K9d?=
 =?us-ascii?Q?7IpWMKgx7PRJUt2LGRYhJuX9r8teuNUpjUCK7Az6AnPmw0TOBNblLPt39X4H?=
 =?us-ascii?Q?9PE/AKMHFmAKmZrKbDQRNqfbLKC5d9wjzYliQ1DXF3/LtPvgcZr83ZRbZQE9?=
 =?us-ascii?Q?c26Pjp/LqhaEFwZKRjZHGPNXzdE4t0/CH7GpQ7znJwy/UeBgol0b4mlI8aIo?=
 =?us-ascii?Q?enppKTA44Tbhv4J5wgJFRzr6mRQygKlW8HuVZ8HbYvrycJqLYapiAPTjGIDX?=
 =?us-ascii?Q?fgTx18ERwmvLZC5XBDKMd5cDwUG9nWlDOSitl3ggaXq72MoqeISe1k+z/Vi+?=
 =?us-ascii?Q?Hif+BTd9JTBGtqmPU7UqbuQlPg/aNw4jfENCC9AnieWRuRW8qG7UjvFvV77K?=
 =?us-ascii?Q?w+jyadNT1scS3atjmxJJGED5krqhy/FK7NLzh9pdEIs2rUVGvfKjSB42Ro40?=
 =?us-ascii?Q?SgUHKdCB9jagHjXivYT1LlAkhRq/XmUPQ/kSvJTeffJHqbNIuETOXqnSzzlS?=
 =?us-ascii?Q?jxJDI332k60LVLS8Dn5RJFQm4v+Wn5JnHUSrlbELNEXAoUyx3MSuWpValzmG?=
 =?us-ascii?Q?9Hel4y+ztE3Y6jR3jWIRWm+QeKW3tDy1AgZxh2YQU5qS4wM9XQsbyuuuYxLc?=
 =?us-ascii?Q?gTQOy0MbyRB8ckjzfGZkSTiXwv3i0i09mAArBl787LV08NfSnLte2Xg8phyn?=
 =?us-ascii?Q?MPAOl7XauL77wKTL1XQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bf3285-d6b5-4b0a-bbaa-08dd1ded827f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:20:09.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkfHVfB9Rzbpwy0iSExh5/bU/IYuYWUmnzph/MizcTCaCGsSf/RLEywNbm6uja/YPNdpEco462r/TLnEpDTm4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11043

On Mon, Dec 16, 2024 at 09:58:16AM +0200, Larisa Grigore wrote:
> S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
> them integrated with two DMAMUX blocks.

Nit: empty line here

> Another particularity of these SoCs is that the interrupts are shared
> between channels as follows:
> - DMA Channels 0-15 share the 'tx-0-15' interrupt
> - DMA Channels 16-31 share the 'tx-16-31' interrupt
> - all channels share the 'err' interrupt
>
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.h |   3 +
>  drivers/dma/fsl-edma-main.c   | 109 +++++++++++++++++++++++++++++++++-
>  2 files changed, 111 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 52901623d6fc..63e908fc3575 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -68,6 +68,8 @@
>  #define EDMA_V3_CH_CSR_EEI         BIT(2)
>  #define EDMA_V3_CH_CSR_DONE        BIT(30)
>  #define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
> +#define EDMA_V3_CH_ES_ERR          BIT(31)
> +#define EDMA_V3_MP_ES_VLD          BIT(31)
>
>  enum fsl_edma_pm_state {
>  	RUNNING = 0,
> @@ -252,6 +254,7 @@ struct fsl_edma_engine {
>  	const struct fsl_edma_drvdata *drvdata;
>  	u32			n_chans;
>  	int			txirq;
> +	int			txirq_16_31;
>  	int			errirq;
>  	bool			big_endian;
>  	struct edma_regs	regs;
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index cc1787698b56..27bae3649026 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -3,10 +3,11 @@
>   * drivers/dma/fsl-edma.c
>   *
>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
> + * Copyright 2024 NXP
>   *
>   * Driver for the Freescale eDMA engine with flexible channel multiplexing
>   * capability for DMA request sources. The eDMA block can be found on some
> - * Vybrid and Layerscape SoCs.
> + * Vybrid, Layerscape and S32G SoCs.
>   */
>
>  #include <dt-bindings/dma/fsl-edma.h>
> @@ -73,6 +74,60 @@ static irqreturn_t fsl_edma2_tx_handler(int irq, void *devi_id)
>  	return fsl_edma_tx_handler(irq, fsl_chan->edma);
>  }
>
> +static irqreturn_t fsl_edma3_or_tx_handler(int irq, void *dev_id,
> +					   u8 start, u8 end)
> +{
> +	struct fsl_edma_engine *fsl_edma = dev_id;
> +	struct fsl_edma_chan *chan;
> +	int i;
> +
> +	end = min(end, fsl_edma->n_chans);
> +
> +	for (i = start; i < end; i++) {
> +		chan = &fsl_edma->chans[i];
> +
> +		fsl_edma3_tx_handler(irq, chan);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t fsl_edma3_tx_0_15_handler(int irq, void *dev_id)
> +{
> +	return fsl_edma3_or_tx_handler(irq, dev_id, 0, 16);
> +}
> +
> +static irqreturn_t fsl_edma3_tx_16_31_handler(int irq, void *dev_id)
> +{
> +	return fsl_edma3_or_tx_handler(irq, dev_id, 16, 32);
> +}
> +
> +static irqreturn_t fsl_edma3_or_err_handler(int irq, void *dev_id)
> +{
> +	struct fsl_edma_engine *fsl_edma = dev_id;
> +	struct edma_regs *regs = &fsl_edma->regs;
> +	unsigned int err, ch, ch_es;
> +	struct fsl_edma_chan *chan;
> +
> +	err = edma_readl(fsl_edma, regs->es);
> +	if (!(err & EDMA_V3_MP_ES_VLD))
> +		return IRQ_NONE;
> +
> +	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
> +		chan = &fsl_edma->chans[ch];
> +
> +		ch_es = edma_readl_chreg(chan, ch_es);
> +		if (!(ch_es & EDMA_V3_CH_ES_ERR))
> +			continue;
> +
> +		edma_writel_chreg(chan, EDMA_V3_CH_ES_ERR, ch_es);
> +		fsl_edma_disable_request(chan);
> +		fsl_edma->chans[ch].status = DMA_ERROR;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
>  {
>  	struct fsl_edma_engine *fsl_edma = dev_id;
> @@ -276,6 +331,49 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>  	return 0;
>  }
>
> +static int fsl_edma3_or_irq_init(struct platform_device *pdev,
> +				 struct fsl_edma_engine *fsl_edma)
> +{
> +	int ret;
> +
> +	fsl_edma->txirq = platform_get_irq_byname(pdev, "tx-0-15");
> +	if (fsl_edma->txirq < 0)
> +		return fsl_edma->txirq;
> +
> +	fsl_edma->txirq_16_31 = platform_get_irq_byname(pdev, "tx-16-31");
> +	if (fsl_edma->txirq_16_31 < 0)
> +		return fsl_edma->txirq_16_31;
> +
> +	fsl_edma->errirq = platform_get_irq_byname(pdev, "err");
> +	if (fsl_edma->errirq < 0)
> +		return fsl_edma->errirq;
> +
> +	ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
> +			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
> +			       fsl_edma);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +			       "Can't register eDMA tx0_15 IRQ.\n");
> +
> +	if (fsl_edma->n_chans > 16) {
> +		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
> +				       fsl_edma3_tx_16_31_handler, 0,
> +				       "eDMA tx16_31", fsl_edma);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					"Can't register eDMA tx16_31 IRQ.\n");
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
> +			       fsl_edma3_or_err_handler, 0, "eDMA err",
> +			       fsl_edma);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Can't register eDMA err IRQ.\n");
> +
> +	return 0;
> +}
> +
>  static int
>  fsl_edma2_irq_init(struct platform_device *pdev,
>  		   struct fsl_edma_engine *fsl_edma)
> @@ -406,6 +504,14 @@ static struct fsl_edma_drvdata imx95_data5 = {
>  	.setup_irq = fsl_edma3_irq_init,
>  };
>
> +static const struct fsl_edma_drvdata s32g2_data = {
> +	.dmamuxs = DMAMUX_NR,
> +	.chreg_space_sz = EDMA_TCD,
> +	.chreg_off = 0x4000,
> +	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MUX_SWAP,
> +	.setup_irq = fsl_edma3_or_irq_init,
> +};
> +
>  static const struct of_device_id fsl_edma_dt_ids[] = {
>  	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
>  	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
> @@ -415,6 +521,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
>  	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
>  	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
>  	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
> +	{ .compatible = "nxp,s32g2-edma", .data = &s32g2_data},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
> --
> 2.47.0
>

