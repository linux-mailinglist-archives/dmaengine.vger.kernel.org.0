Return-Path: <dmaengine+bounces-6606-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB6B80260
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 16:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2049A7A8737
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE230B526;
	Wed, 17 Sep 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S1jyxVtQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F123016EC;
	Wed, 17 Sep 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120167; cv=fail; b=Q1iH3mh03vuKni9Ax5u0rujCESTRcouCCMzNQuu79BEOSF1OK1oAmsQJvrsE3uoyztVs/VmYa9usWv8mV6mc2aXEE1fBb9FwFwv7ivmDmF/VIVFUlFc7TuRd08W3y/G2kp/0jNY4nT0OHiDGoMnnq1ccpBYwerR7wfHvZndpZeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120167; c=relaxed/simple;
	bh=uPPrE6OHYrioJblA0uQ5p4rNytwk0w07R3ABGKt53kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tZgRppw8DY8KHpDTM3vc/VTdE6fu7vXv8I5NPljlxtuytS6HAE5mCbKOZKdq68M7Da4jGkbtImiuw+eTSZbpAvhRf8qtGSTdO+ZuEP5GhWkReCJWiAcCi7aFetzpx7qgFwGyzVIoKtxQ2b6UtrvjWaGxP1XGrbOLizVjyP4Zids=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S1jyxVtQ; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfKM3WjTB2JTGXJDHD8BD1MXIIv/1jVsZfE/dP/Dcnmh7HLU9wwCoPcmsces4rmyIUir4iI4eIlNbs+/oMSECNAzLTnNS5oUp26pj3kapNrYZi3eiiddYjzpglUSEwCJK5dmMfwnjyE3sHiSuSIFeymkm3Q1O1qPrOOsjg2zPi8Cdm6NS1zRqrdntjsp7auUbNCJEtwTkbAk/FExl723ppXbhOtOKjpgyHa2rpcCo+AOoOvQJ694BkYGPgOOP1cWP8ZobhOeoBi76BBLZcbQQE7NmotyYyRT/A4LKMNFh2d4bit3dSfFnDD+YA/5aKpRTuYC94IlUEYjjq3tZjPQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzMUln5VrUZShnuk6+LzVVndpQcO6LeAhrKeVrp3QAI=;
 b=o/WwhD2TSWjhr7Jzgu4zx2sPo46Wz218o8zTATWDDevlnFUq3r3hrr0vz8cufUBETiYOpef/FCtrJWHXpCg78B3+2Fko3io8qrCe7HLuCRqbnRcxuxth8I078uLnfzOweB/nIz9o6zS9zELnsNMH0VdbZ1FO1VfZLgsqU4T+1Y/xQ6gbuI3HR8NMOaCQI9D7ctLeXuGTwnq0Jen6ulhb0sC6THAkhPOhSoFPZDLpP9j/1dPYrG4e3t931hGgbmJW0w8jf9NuOORwvPmVy8Rn58z2Aot+kBBlluv5f57HCasVGFd4JdROIHzSSigIRQ4An3k2r3GsvgCyHZkUHX7W2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzMUln5VrUZShnuk6+LzVVndpQcO6LeAhrKeVrp3QAI=;
 b=S1jyxVtQT0a+8qTagTNYPKMN8A+2KeOgGyoMsaj6sZTFp2Fe+n1ehrbZBIJr1WGrZjh6/FwWMi6bzhZzeNfLBS9uYIIVAYpxHnEqPKczyvIigjcWmCtsy/izM1kpMD2rTbbjvs/1ZAEBmqsJ1g4Y3dsQDDobrwRMovka07QpOHfzzL6w4aNTerFfu2EOZHKZU8yxFJAjtTpxZJF9tHfEuYUR6D876ESCrbct200/xQKFBoH8xl2besnv+SVY/ip7ufro5dyNDxtbNNbX763haU15ilsL/qmafkc1A4X/3Q9n1fmPaOTAiUQn1Ht5PZkvG5DkG/ib7M6p7PRERZGk0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB9175.eurprd04.prod.outlook.com (2603:10a6:20b:44a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 14:42:39 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:42:39 +0000
Date: Wed, 17 Sep 2025 10:42:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: fix channel parameter config for
 fixed channel requests
Message-ID: <aMrI2ZEz6Zdoj6iy@lizhi-Precision-Tower-5810>
References: <20250917-b4-edma-chanconf-v1-1-886486e02e91@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-b4-edma-chanconf-v1-1-886486e02e91@nxp.com>
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: d890d8ca-083f-481e-2a06-08ddf5f87399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8HCEdJDZaEeTxWKOlTv5+L+CzhF46RB0nDbYaSwSv/vKUEpLGqssekkacsbg?=
 =?us-ascii?Q?brvqLDGsnmlQZmtpjIrOUl4m5Ci2+ESG45XdGQx6UbLz4w3iRaRb7wARzkdq?=
 =?us-ascii?Q?m/0yozVlsTKEy6nVvkD0dp73BQWyJBOF+KocMpo1lqVyiGT1fMDVs0pdcZ4m?=
 =?us-ascii?Q?q3QjN+oGvxm0+gzY/FJuA7UWIs3p/ivIj3l5LEYl9dTRK9jT5kyq2kwa86F0?=
 =?us-ascii?Q?mpaA847WMzI11hTSq+7d2mEo40rZuV5CerPQZT4bWKs3P0kxBWjb3OXuVNKB?=
 =?us-ascii?Q?mOAkyeK2ie4hKJl+NYUplsfXhTH8kpvNdb3oPJ/PpIz3tGp3O8IIxEZjmwNH?=
 =?us-ascii?Q?MlBOGNwkjpBIGR4QToY/Bk32GmVcM/HFRBwlNWMxQ1Yv6T940p9GU5hozaio?=
 =?us-ascii?Q?/mma/RMpek96aMVc3X1ZqVu3xHyd0f7JvIo//X+hilMkwNnRgnWzgxfmccHz?=
 =?us-ascii?Q?ZrzxytwLlDPAq0QEiEJqopg/YRGfNtrvxUwtD6JCSA60U/ahPc9JZK3lXMJk?=
 =?us-ascii?Q?zR/TpF8jleepjyRkhBWXoScXvBOLt2gpiWQM0bjbqYcyPXfbE4SPDdPvAOCd?=
 =?us-ascii?Q?MY7mmLpAlkJRJq5TDTcE7g/wdlTw/jHahSAp0iA9Vfa3qMF+5gvheSJMaNmX?=
 =?us-ascii?Q?HWhxENOzcpMLTCLhAal95I1IkpdgUB1XXCu3i59nRZ/0szdoPnw78LMdoxCJ?=
 =?us-ascii?Q?Rp8Lirio+6aa2rSuIbL9300S4V5ZaCC35SlPd0cNuldywlRXPVHiIECH4mdQ?=
 =?us-ascii?Q?BkLur5nnCH/btdpchGzoH1WWigZTbhMjv8mHBn3nO9Q1NUTbyPGmj2f2/m6k?=
 =?us-ascii?Q?WJQ4nx/qkx6YZSnE6jX61BLS450NTI05lQSVBf7J1jVRy6Vh6JdpelZe3o2S?=
 =?us-ascii?Q?4v/Dom2+mCefxRr/Xd21yiiRm0UMr1AHiz7Vdm4I7Nv2hBWmyiFTep6FZizO?=
 =?us-ascii?Q?1iYKJ1SCYc0x8t+4FwX5Dho1zWCXceDbuGOp1b5nn/4wltEJVmWohTfUn0Hq?=
 =?us-ascii?Q?7ATp4xk7QUtiMLKbEE3LCjNvVFng9YoQIhaJFrN74+LQBvV7uzgGewFmSX4e?=
 =?us-ascii?Q?+zt6lIEhKpVoZh6b1VhuN/7t6yrqlUtRbIuhs/nwaQBK+Lmq2aQHJ5eZnj9m?=
 =?us-ascii?Q?0aBJ0ECpozqFsPLhw6wvXAjjob1nVZFsNlcBGwOYGaCKhpGewbYrHifRPL6V?=
 =?us-ascii?Q?v7DCjO2Ul6TfQcZgDQ9fCnCmqYqBuw5Z4AyZKlj7eJB33Ier8BsTHNxne50H?=
 =?us-ascii?Q?wS3v6btKW4aQqOrWOXTcGdD/ukHq5ShWgmbT8TJneR2sWFmglgnhmXkWwkNZ?=
 =?us-ascii?Q?2/rWG5ouyagxozGunIyoiCpC1B698nYGXJFLxmYUCcB+YwPr6xfxDJ8I2Cfp?=
 =?us-ascii?Q?hCnTm49I0AgnQ/2FrkNARpVUpGul3hnu8SmAeBa8R2PDgRxnL4F6hIVOE6nr?=
 =?us-ascii?Q?N8Y8fiS+NRYbwmqDkqpt3tHKAs1yDZwruV5EnMKmpIWS1sXISnFU7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBS+B1bSr3bpXBJwBJ/WrrLpdSlm8V64O4ORZiVXiQj2Tp2JJ5FgQmLVYByW?=
 =?us-ascii?Q?Wb3v27lhj90oi5ZtcFaVDhJtaC8bFxpGHy/DuQKtAHWb0lJC0BYIzNqV37Ji?=
 =?us-ascii?Q?uiJYosSeM9sHVEj6a2j2P6ERS9Jzfzfz2Z9XDjJexAyGJ01RPKBibBU7E5uL?=
 =?us-ascii?Q?UByG2CT+eaZ4c7PwTggnaxHSZ0vu4bcMIy1J5OKWX1gEaEVLXyAa1dJ+GS/I?=
 =?us-ascii?Q?w1LX/ejEZGXuySSjRFkEGabriwBoj8pqA7RrZYAbLVhInNLilEh9r2/udRu7?=
 =?us-ascii?Q?PLnepBOpJkqglq2hYwSvRUL4hXiJDLbdHK0sPYVC6YL3BPZ/1ge3/exC1QZH?=
 =?us-ascii?Q?q5iU9/0ruO/6YQqjGPO2gLozjYOy4S5UMMP6v+M8E4N4SVit1ss0HYjzgtQJ?=
 =?us-ascii?Q?5rsbuazLaSJUVLIL13E/TQLnMs42k1leHttT5G14yn2le0NSSP7Wewiqewao?=
 =?us-ascii?Q?DmyTKup/NWZwnNpRCoqYd3rhSx4ejAJiVVMl5ao+22z+/s9drG17HR/ihSCF?=
 =?us-ascii?Q?TTAxESQF4pGlgk6djat3D5fhaJ9/BHN+t0MrP2Kg+X/KYgc9VyviyualpvUU?=
 =?us-ascii?Q?broZb0+CTIVR5d25PO0c8X2xeaKo0ZdsRj8m788bUXb9v1dkO+ZQitD6AcDu?=
 =?us-ascii?Q?G0mi+lk/3MzVUF53jmY2fpSRVITO3pN/up8p5bsNl0eu90rEe4uLvUa1P8ZH?=
 =?us-ascii?Q?5W6+etV3QAI+LodTCORsYzZwgnRZGD2MZMZxXTCRLG5gEurV+RcEadWqVXV7?=
 =?us-ascii?Q?NiddMWUbZyHBVppTMHfotam/ekbvRocAtGHMIQS+br15VqmII2jWh4DZRRVh?=
 =?us-ascii?Q?BRMw/2a9sLncha9U3OTKfSUVVZ8szxiDV8ElWUbZShwT+jMRK9PmBlzsVvkY?=
 =?us-ascii?Q?mwUjRKc7+v/t56uf+n+PCDkEil4wCaTZnfEv8mCuzVe8kMR27KFB22NplN7M?=
 =?us-ascii?Q?9tjA37nxdxdmu5v9+6In4STSGenskXqSy3ipLLkLt06OwxRvjbFIkOdmpqsp?=
 =?us-ascii?Q?R5IZOHDozfUzRodmGCa8unGtJOovd/TStJhnGZVek4f92qdvUYREjxkdwjS4?=
 =?us-ascii?Q?cbymwqCDNVqLnbunPSxlA7Mvc3hEQkgReSA40KM7fr6xoYnve4e5pJHPm2on?=
 =?us-ascii?Q?QYvyFLcXxCjTOgElk3cnyevVBYOcjXgGJ0FVKqCIb9ZnjZJcQ//ytat2T3o2?=
 =?us-ascii?Q?nh/yEAIt4f97NneRXtnVCh34BU+Vz9GVjt5hyySlWl3FJVfkk5C17qTVv9Jc?=
 =?us-ascii?Q?ERZZ9FX1qBvTYE7/wZarr/ZtvzBGiKYHeA5JlFQj9xFDTg1SP/7PRDEtY231?=
 =?us-ascii?Q?3E1FdupIm6rj6IPhjZnM3zSY0ypQ/xF2SAAYFq0gQ6jZ3rWgPuJt4/BVbg9Z?=
 =?us-ascii?Q?kLBXBVg5f1touwr+LehzUJm7KMq8vQaIs77lc3cMbZu79TayUjuKdxUT4Gmz?=
 =?us-ascii?Q?ryBjkKQP4So9vrBNTARZ8//LBlB9RSjw8ZR2KYGXCk9cGecfnJ6Ew3FX7QCj?=
 =?us-ascii?Q?tLSfygu7fc0i4Ap8a9jN4Pw/tcZN/U30L6rDjL0cLXyfNm6+0Q5nWmmSmAMl?=
 =?us-ascii?Q?Nl69eWbEgGDM/stmrWnFCwJnH+twq0KsYdd+PkIX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d890d8ca-083f-481e-2a06-08ddf5f87399
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:42:39.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF6DyPC0R9yvkD5x3RiGAW2J/PB8Oze3BngwLdJUmFraxjO8kGhM8at/0lPYrQf2Pksw/W4brGI1AJn19QLK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9175

On Wed, Sep 17, 2025 at 05:53:42PM +0800, Joy Zou wrote:
> Configure only the requested channel when a fixed channel is specified
> to avoid modifying other channels unintentionally.
>
> Fix parameter configuration when a fixed DMA channel is requested on
> i.MX9 AON domain and i.MX8QM/QXP/DXL platforms. When a client requests
> a fixed channel (e.g., channel 6), the driver traverses channels 0-5
> and may unintentionally modify their configuration if they are unused.
>
> This leads to issues such as setting the `is_multi_fifo` flag unexpectedly,
> causing memcpy tests to fail when using the dmatest tool.
>
> Only affect edma memcpy test when the channel is fixed.
>
> Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsl-edma-main.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 97583c7d51a2e8e7a50c7eb4f5ff0582ac95798d..f0c1a2a3fd26e663b3f0b918ff979a68af510fbf 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -317,10 +317,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
>  			return NULL;
>  		i = fsl_chan - fsl_edma->chans;
>
> -		fsl_chan->priority = dma_spec->args[1];
> -		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
> -		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
> -		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
> +		if (!b_chmux && i != dma_spec->args[0])
> +			continue;
>
>  		if ((dma_spec->args[2] & FSL_EDMA_EVEN_CH) && (i & 0x1))
>  			continue;
> @@ -328,17 +326,15 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
>  		if ((dma_spec->args[2] & FSL_EDMA_ODD_CH) && !(i & 0x1))
>  			continue;
>
> -		if (!b_chmux && i == dma_spec->args[0]) {
> -			chan = dma_get_slave_channel(chan);
> -			chan->device->privatecnt++;
> -			return chan;
> -		} else if (b_chmux && !fsl_chan->srcid) {
> -			/* if controller support channel mux, choose a free channel */
> -			chan = dma_get_slave_channel(chan);
> -			chan->device->privatecnt++;
> -			fsl_chan->srcid = dma_spec->args[0];
> -			return chan;
> -		}
> +		fsl_chan->srcid = dma_spec->args[0];
> +		fsl_chan->priority = dma_spec->args[1];
> +		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
> +		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
> +		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
> +
> +		chan = dma_get_slave_channel(chan);
> +		chan->device->privatecnt++;
> +		return chan;
>  	}
>  	return NULL;
>  }
>
> ---
> base-commit: 05af764719214d6568adb55c8749dec295228da8
> change-id: 20250917-b4-edma-chanconf-da616503f29f
>
> Best regards,
> --
> Joy Zou <joy.zou@nxp.com>
>

