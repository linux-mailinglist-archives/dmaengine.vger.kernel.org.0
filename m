Return-Path: <dmaengine+bounces-1821-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633918A1731
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873271C2036F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA314EC71;
	Thu, 11 Apr 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pxrPgYtm"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3D14F114;
	Thu, 11 Apr 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845778; cv=fail; b=NlvhN/JXOIAREOkraS20sBYP7OM7LrMsT+qIIheQm9GymvlEQnFtaiC75ETYPdWaQ5oJ71r51AiNKeDRpMMvSepvF3ubFggJryPZfpfpCU67QGwQp0a2DEqhiaiuo1vozxmSmDUJFw5t6tbnb8mjeqnne13N3HLyWe5T4CbMb+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845778; c=relaxed/simple;
	bh=RvrqnnwNZpIFSBKfryq626bwPlv4f6l5yPrpJmtnyxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xh/fY3FQg/MMN8UnTOJ336DYvCBqbygPnMBEiVDxufIilp972xYlw6uY43H47dFtRfmJjhvv/CYIu/auxoPByLvA06Ijcv2n5DpcPngRiMLvG8MfMtnyVZnf0e8R/Hb3+BIZl7KXTrPyf0uC3MXu44Vs2YnSt5hnKx/KeUxyG8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pxrPgYtm; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFST7fGmjVuUbHODHf20nuwiPTKjZ/ECuohG7jPnItEJ1DBhbTi5+2XKhCkvj7qidiR015IGhPXYFAFJeZbtIbMZk8xKqcHX3oEF8OCYQpOy0b0VPpXG7aBkM78MeAjF3RP9CBif3os0yKZqZlvkQlGeXpZOqfnp86kAqfF2KCOQFU8AlEU5jJ8wTgQFffcyuBxRT0Sp430qQB5wtPH/ZvVrWK6GTWK6jvN9p4dBTLOr7o4EBjtw+10tGb3taVu/508QeiQ4WnsLaJGUGxXo+fGnEccMgfKKu8oBVVc9577ldUC1FQtJu5GUiP6FMHqxO/MwmpfbzE9/se1RNwl0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlKuRi9F396I+CZcC7O507o+LNydIvLz9dSKW5aVd0g=;
 b=L6CUOsK4TRUgo6dvleVaU8LStzy13PLUfqzvde9afU7SQ3PZNhYmebr5+ELTw0ObPopk16gSLPGrVJdl2vLpUmnv2EBJfeVpwxL5WtaB8XydAlMsmcW1HzuA55Tr4AI8QmC3zU5qJvDl76YlS4aBONO3gNGravIWz40NK62wsClPdWl6kMUNcXN0pxJ3GsdiiQJS9iahFUS0ErNPQ48xsENDiOV97Xfyy/cgdTk04kSY/ITKCKdsDc2AJPPLi9hg4xbPPSChWdtAUuwhxZFtgHLe0RiJx05ZlX9VLFpMvFfRyhiVtKvEQtNeYx3krZHxe+pl0TbaNuHs85vh4UgvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlKuRi9F396I+CZcC7O507o+LNydIvLz9dSKW5aVd0g=;
 b=pxrPgYtm0MNllfkvYJK46YcgYVSTVgm/b2i/KIH1Bv+gnLvldg2uN9i4Aj62VQyBkRJVGl3AiAz9oRVeRFsn571q0MQzyFm92SI0VKDkVOZKmTdi3/QfKYmwaSk6JZ5JHggO24kvHAk3ep6B00ionGu5GRpLPZgBBzDNucR1hYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7384.eurprd04.prod.outlook.com (2603:10a6:10:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 14:29:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 14:29:32 +0000
Date: Thu, 11 Apr 2024 10:29:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: fsl-edma: Remove unused
 "fsl,imx8qm-adma" compatible string
Message-ID: <ZhfzxQKkP4G1KDFS@lizhi-Precision-Tower-5810>
References: <20240411074326.2462497-1-joy.zou@nxp.com>
 <20240411074326.2462497-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411074326.2462497-2-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fe219c-d890-40a5-eb48-08dc5a33cdb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	br4GU1kdUxS7oo/KXFKRSwaEwX0ntFDmEJLJE8/bGxLVQbfmaMTZvjKgpg0Bn2YPPhW2NI1MV+mNXjZTb4f9ym+aS8J8sd3MJe7ZXMQRCcVp9L66zNX7RL21ezRrVPGoyPd1VS9T4I7cl4Z2rjLWKi/8GbpgKQWfDa+O1nBxIK34oUvURWlEKw+tt6x2/Y90t7Ii4Bq4RgfAreY4ULGBDJn9P07fluoY8NoMmNe041jKozbKtrYeelogTbqjdzMVxFOaqVtdg7JkJZg0lVgsZYD6dKHZ4lL65LoCAHZ7KboSs5R+bqOK32h0b331Sl6MAhZnPsYRewZNpkbJrfrOT2F5N9vY0lH1DVLAbtcysBZAkq7Ww/VUDEPP+nzRTJNfVjlto5rZRyIqWvwGLoe8UIbtSyM5fE5viRbg34iPfzI6x0BPKG4QDcuoeUMaazyav0Z+As6ZfepigOaYLCDem4obtINbgBKFS8Xl02zkwzJeQ1OwpC33lYyUlGu//YEtlyL+PvGUitb4HovHUodbm8pqI/CYOWAfV44ji8VReS7G/GgTC9rSFELp9vaKv+AvnnS/FxcyUrUTDud1F6et+/YWSckeToMk2HnsCqc5bJGjtzc8wOFKoaOdglOQva3Aglj0lCnv8/Z7pCr6zIZya+KJ8LonlJdz9gk9jBUkWx2FX1dhRHhGNGKmCSA/IirLGvjb8tgfFPQzXW4ncLeyVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uy59PsjUylMJRenVPFE9SEbGoHMeOc37HY4dcivjVXNarnfvxfvaq2VE5FnU?=
 =?us-ascii?Q?S871w3Xb67+S+LYwta3ea5WOfWoVHLsOqaPoTCYCDCupKhON+jQadkFg/xZM?=
 =?us-ascii?Q?pRj9kwhwBDwA27do6rtViPFJ7qa29e7KP2NNogedQMdSngZmj4lx/llm3pmA?=
 =?us-ascii?Q?EIsdPJXa8lnyB1coVDbH8EhDGpCoH54VrpCUAJd09HOt+VpYl/8wNYJf0Kxa?=
 =?us-ascii?Q?0jW/HXGwB2pPhmthPuaoPfzfr0dNB8opNW1SKac8gRv5KC2iW+Ng8oGbM/X3?=
 =?us-ascii?Q?si0wUTVgN4ud3Kze2K5pDvhK4uch3IMFTbzyr4kb4D7yS8W5Vvql3KCsxKQq?=
 =?us-ascii?Q?HxUVNiF6Cib8Mqg2DkgruwLw8TYWn53c9SyyXBYJcQ6MXEC6GEieM0qMMdLM?=
 =?us-ascii?Q?3RH2f5n9AATLFP79kIBuaAVfliHhOLPVoWJgcp7lf5plC+gdUOBr25+iMG8t?=
 =?us-ascii?Q?fv4/4O7JjbqaEEPsgxxLUgb4ReFoIYQEWnezYXENBpkuy+aAFqTbPo4+cJPX?=
 =?us-ascii?Q?GBjEVrBNdrFtFOYxNM9yw1wkyf+nLgE60Yf9Hc9kpaOiYZSXHMO2hvZUs5o7?=
 =?us-ascii?Q?IOQKcHKCQOqek13qu8pxoeXWm9BGdz61k+wQlKTno4wYoLE73iWTV8HGQAb0?=
 =?us-ascii?Q?5VPX79ledfPZjwt7trvlmIViVhwU2gUXg0lzZHAsV3+wyy+UPSrlnr3G7A6H?=
 =?us-ascii?Q?Vsas0Nx2J6wtMDMOhcqcBLXK1vIz+qGzVlr+uJpiuDfiTmf/kXIGB8u4PHcs?=
 =?us-ascii?Q?X1ZW2OhDkIDpAqUKOtAh1NAjory+UvGeTVvZ18u2khM17gK4BNB4DmIeFyWf?=
 =?us-ascii?Q?s6I9g4FNBQjXo10o1Uv8ZAUyHtReP4LNAp6yTcviBJUgN84ZFglpPUxanlPf?=
 =?us-ascii?Q?8ywYY1n7z5wkgT/DXrp9vFWaLCi1bow/M5bHcJYTb/LtKiwDe1UUo9/n8LaJ?=
 =?us-ascii?Q?i+ONRufhHB82yoOCl1gJ/mGMrzZ1JPSXKciCHe8kI00iQxMWZYCN0Fd+3muz?=
 =?us-ascii?Q?4ZcO9xPd4RLJFr1z+cdb/GF0KJ1v2fe67UCtPVsd9sXy6MmxXkbDjYE6zJ8n?=
 =?us-ascii?Q?1dpZnk3X5RtCB45hlvayNxpitIvpEEJE7aAaRI9uklAZ6FbFY9kHnhfvQnb2?=
 =?us-ascii?Q?t+FqICLwoka3jZIBeDVG0LfpSdFdDh2iKwgaYiYqTvTSo3j3ejnlhQVvBtvZ?=
 =?us-ascii?Q?vSuFfl7C4d8bu8mgaKsrIwoUq/fS1NKeVswVGKihzy+dPcu5E7JKtJiYaWPc?=
 =?us-ascii?Q?xdCb++HlGgBYZZlBtSKNwVvFa8abC2jUIwkKDHifSMo5PTcnTfxQzlJB0ZRM?=
 =?us-ascii?Q?nPNTtfgKOy0WK7IM1x2aZ/ol1w1mCBpFhkfRI7ep0hhmMG3E0nxVNizf0Yb2?=
 =?us-ascii?Q?F/ydBvf2DijdJLW+3Um+IiNiTyXl+l9SUgu5saBZB05rjOZCKnmf/Twm4u+C?=
 =?us-ascii?Q?TJ55Kv+cW6XF0VFtjBCE4sbDdbVN+x2A05Z/yAOvsmOGeSD0Df/KDvt+CAnx?=
 =?us-ascii?Q?oQDn61NilGDH8hhmY66UN3xmmbdf5iyiJlbUhWzTun0u7i4gmyQRh1nKp6F4?=
 =?us-ascii?Q?sZLSHAG63aGHzrUZE5GDOsG48j0BswbpChAa1pIh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fe219c-d890-40a5-eb48-08dc5a33cdb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 14:29:32.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xyc3WEg4YHPfImZeQg1wvQAuKWUn3RNvbpafHK0YfZr6gIgOMOzvauMO2usv1P7t6Wo2Q3x1dMdqEhTAGC80EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7384

On Thu, Apr 11, 2024 at 03:43:25PM +0800, Joy Zou wrote:
> The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
> So remove the workaround safely.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v2:
> 1. Change the subject.
> ---
>  drivers/dma/fsl-edma-common.c | 16 ++++------------
>  drivers/dma/fsl-edma-main.c   |  8 --------
>  2 files changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index f9144b015439..ed93e01282d5 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -75,18 +75,10 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
>  
>  	flags = fsl_edma_drvflags(fsl_chan);
>  	val = edma_readl_chreg(fsl_chan, ch_sbr);
> -	/* Remote/local swapped wrongly on iMX8 QM Audio edma */
> -	if (flags & FSL_EDMA_DRV_QUIRK_SWAPPED) {

Please also remove FSL_EDMA_DRV_QUIRK_SWAPPED macro define in
fsl-edma-common.h

Frank

> -		if (!fsl_chan->is_rxchan)
> -			val |= EDMA_V3_CH_SBR_RD;
> -		else
> -			val |= EDMA_V3_CH_SBR_WR;
> -	} else {
> -		if (fsl_chan->is_rxchan)
> -			val |= EDMA_V3_CH_SBR_RD;
> -		else
> -			val |= EDMA_V3_CH_SBR_WR;
> -	}
> +	if (fsl_chan->is_rxchan)
> +		val |= EDMA_V3_CH_SBR_RD;
> +	else
> +		val |= EDMA_V3_CH_SBR_WR;
>  
>  	if (fsl_chan->is_remote)
>  		val &= ~(EDMA_V3_CH_SBR_RD | EDMA_V3_CH_SBR_WR);
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 755a3dc3b0a7..b06fa147d6ba 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -349,13 +349,6 @@ static struct fsl_edma_drvdata imx8qm_data = {
>  	.setup_irq = fsl_edma3_irq_init,
>  };
>  
> -static struct fsl_edma_drvdata imx8qm_audio_data = {
> -	.flags = FSL_EDMA_DRV_QUIRK_SWAPPED | FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
> -	.chreg_space_sz = 0x10000,
> -	.chreg_off = 0x10000,
> -	.setup_irq = fsl_edma3_irq_init,
> -};
> -
>  static struct fsl_edma_drvdata imx8ulp_data = {
>  	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
>  		 FSL_EDMA_DRV_EDMA3,
> @@ -397,7 +390,6 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
>  	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
>  	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
>  	{ .compatible = "fsl,imx8qm-edma", .data = &imx8qm_data},
> -	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
>  	{ .compatible = "fsl,imx8ulp-edma", .data = &imx8ulp_data},
>  	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
>  	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
> -- 
> 2.37.1
> 

