Return-Path: <dmaengine+bounces-4048-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D319F9619
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 17:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B4B1643F6
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11565218EAB;
	Fri, 20 Dec 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5QXRWDY"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8C33062;
	Fri, 20 Dec 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711163; cv=fail; b=dWnHMlay+fFVUDIFyrJ3heVxtoYk4SCivZJRcP//XEyuqAsBRmk86/zWVFHAZ8AA6uyzqnoCuv/PDhFuWAoZhB8MRtacqEy75CFr1lln4P9ntXPmknj8C8hV0vlJU1hNfv7B4aQPFfLM5obJ550mPQPILGUgncIXleSWVxDEKH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711163; c=relaxed/simple;
	bh=3gKa58EMZ091Hbta6uUWGNukM6yoiT3ul3zEdkS5Zvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VX7/1iymrv2Qpzx/ROdaB9+v/YhHCYcB34ydnYnMZuIqcUA8NIPl8kynwcLhudbkaWPU0TCw8vNml6PjxXh44B5aZmoCyEumczoXOJbK+QValvKVx/1iI8h3Y62Us8Go+BYIRuBKN/rL+Vq9EkYrIL8wG/w7OBMZwUIkK3/oaLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j5QXRWDY; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teFiCWcunCtCS4h+QXf2f9f5BzKqT631vhvk6Yu+M2PULzw+dJ9fcpCf6psVsnyHlCkr89oQObyjKC+bNMq12VX0fxKSNkqnBqgz4Pp0WGKOALe2RiiPB7U9qFtqUq4shFkAopXxJguMsyOIQthaK82r9aWgHXFG/VvtuRmaCSuN7qwxVVwGKNfnbln3Qeh851Npp8ijYn5lDULAXTEsr1NB6OP+b4Xisdx6JNQPWl49OK+H7zqW72eGDar0laMN/8UVucmY+nJwPqm/qRqQ5ajh7ERJTnrQgy4f3dnsnKIkM6HYZhUP8BgP1BaxFIYStfzrc+QkvkvT/s2Fdr0A+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH55JY4FeIpXgtHgeY95AJ9Hd9kUyDIR7rzgzFL4n4U=;
 b=riN7QMitx18XjiRtrb8nsNGxEuwUQzOw603xeN5iVIoCr5AjjeKac/8ra9BRfO5KTTNrCT6JhHau4tGwHSUn9TwqzcCmsb4FBJhx4PlY5FFaOTXExBb3Mg+8/n16EKxCAsTAsB7z4XFN7bjgsu6qZNqlN59KNgpfZkannZfA0vAB7WcehK0IG/Rb6NYb9cvuYYfR3uDY0wXr1+4GevIJclvFT3Tqq5fhAr3BayaFh3C9jwFv0uWeLeHLe3yGRV70q0HlW5cA53A4f0WithcZb6JewXdS9+iEBtMdq4CTREzoVup4VylkVcujTtxOWBls0RB6qZZrVBErwtNdkPLvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH55JY4FeIpXgtHgeY95AJ9Hd9kUyDIR7rzgzFL4n4U=;
 b=j5QXRWDYirymt7bgrTjxyJZxpdeMXyHvva/HNZKEn4F3hifoEXPPsrfdWmxETxErjbzUg/FU989xetjM+4LnBWcTVXQ4l8K/LEJc9ICSoKr65wk9Q6JMfeJPMSEqoa/F0h0EOH8H263B3azbgqNiKZKRllOOMYFD3u6AJo2pwJrks2qMLculba8xS94ZO3gIJo7fNj87UpD7wDmrGWQqj5ah9QAcdFiLjP1cwnyaRGCKbRZOM3OHus13Md2giZPn4BsUV795Rx2nUVGQEdewU0v5Ft458Ef1EJtaygE2ecuwijLTZ1rvn+yC7JKmugP4T12cguVmdAMTXZOqB6rLaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7468.eurprd04.prod.outlook.com (2603:10a6:102:8d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 16:12:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 16:12:37 +0000
Date: Fri, 20 Dec 2024 11:12:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: vkoul@kernel.org, shengjiu.wang@nxp.com, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: fsl-edma: add runtime suspend/resume
 support
Message-ID: <Z2WXb2cwQU7UV/tj@lizhi-Precision-Tower-5810>
References: <20241220021109.2102294-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220021109.2102294-1-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bd9070-fdae-4377-9632-08dd21111ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mue9DMyq7fZI3LiLL+3szI2t4gbFHQFJNBQTXIpVzKNa7a9EdGDwD8WX6BJn?=
 =?us-ascii?Q?r+pi15umJ2xFRgKBz5ED0IC+e7PPBPErTHV6FPVwLnTqO/NRVqNQ8rfFRui/?=
 =?us-ascii?Q?7mhUYwBDnaoPeoxS29TtVES8IIfwXe1VS2zJoyClaVqMJdRCHqAHpf92QCdQ?=
 =?us-ascii?Q?ugen192TU8VKlPCoKFnUzR6ittNbXVKAYYYWRI/MvSl8YsknRHa6yn3SnkTX?=
 =?us-ascii?Q?nKiHrhIqHRH+pTTUMAOijEhBZ5RXAydvOtE4hXMb/q/kcHFPlI3lv+4axfoN?=
 =?us-ascii?Q?f5vIepvRYv2CumaT2CM1aGH6lEsnXuPPiaxDtgl+55ggGwO8x/6B/Rjn2B2P?=
 =?us-ascii?Q?AhjG0B4fuUdyyS34g+1FTx4XSMeCe3xE+lb4N+msw6pZpoUhjR45TZKEHeX2?=
 =?us-ascii?Q?HANL3FYKCfm3n6W/WTheh/YpJOvURho6gN9lM9hTaHzVgbrDuHPjLYev+qBp?=
 =?us-ascii?Q?Du5s1mJipSH1eVQo9is5W54M3KcIh4gmZ4nYVAWiYMCRH0vZagKftGsVls0P?=
 =?us-ascii?Q?hK//6skQ8zOVgxUz3wcehHx2vPo+7FUN13qXiYZfs8t510tlUP7qijm02Hif?=
 =?us-ascii?Q?5/71KSE6OJOOpKCE4GQrgukYe3LJZBl0ZX36nPHIye7aPJs7ZbChQFgBknH8?=
 =?us-ascii?Q?sU77Syp5ZFhhIO97EI3z1DPMiNW7d3PzzPcG/gJQj+4YaPH2A7rMaL0Mrz0W?=
 =?us-ascii?Q?CluDuJa2FvFHb0810IRlDrpWoDqrddicb1RKrwRyAi1QGKtDzT9C7ef2qRUs?=
 =?us-ascii?Q?EU6n9hd5HajuyZSf7i6H+/gxgKmSeimCU1b0TiPyMmqNToj7Icn4AdyXQixy?=
 =?us-ascii?Q?IR+qdsfFOO27REwpuyThBjQ1zj4Pteh4+Wp150xfylBasbSkcOGEkiRynrzv?=
 =?us-ascii?Q?IYkiDJkI+nQpdqf2QYsjYn1b74QfTV5lxhhJFpCyaamvcT1pTcqAnqtTvitU?=
 =?us-ascii?Q?3RV65bCFL9DgcLQaZOdj2a3upGoh3x1ciekEV8+RJaNll0OeFtSYPwU6z94r?=
 =?us-ascii?Q?SbL3qaKp4xAt57zBnEcDss/j3Hgx/igHuZLzzR9LSv/wa6TLY2tbMq7vfKT8?=
 =?us-ascii?Q?cF55iREbP5d21DCLaYCesvIYe0mYE50RISzbDGW4zT4bpVHOqX1i7Qx2O3zi?=
 =?us-ascii?Q?b+0Ck+fus0hTVH8vKrGBQlYI+ScjnNJqlLuCA4WzYWr45awzB8b9t2zzakiq?=
 =?us-ascii?Q?QNZNEBUwWOmgNXPr7J04i8nZzQL1PtXTPLfMnVFWOK8QUVmgZUqedgzGMYs4?=
 =?us-ascii?Q?otuIOvzmlqAvHnS5P/r8cLBxPjhXJ+TxN0wfhPLRsCkWl8jF3Z04WjZr1jt0?=
 =?us-ascii?Q?GPoO1n+9CQ1mr3zRQdNnvf1nIgRB5QKQXZZK5sKfbQBr/Gv5rKdaU6ryVUl2?=
 =?us-ascii?Q?kIzJ4FopJMOOFchrEHVrPQirbVRX7Ml3KfSsh0kRU445VcfoExpBRsOSgWiw?=
 =?us-ascii?Q?58wojI8GczH0fgM2osOu0iS/lFijA/j2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwcSCjHBnrtjDRHM/ZZPp6ktDgdE+nn6OciXDeLCwNOMUa26+PoC1B1gocvc?=
 =?us-ascii?Q?M0EULIFxSj7RF5aWqIcBjtgGRsyEQ63jEB2FCvP0fyBlMLsdoIxgMHs4rYqN?=
 =?us-ascii?Q?35a1cAZHpKhJEyEYtO6eHINmggsTSsjjIoEoZZr9aphKuFuFKBTuEkyYn4il?=
 =?us-ascii?Q?UpgYGz889B8HlRO/fyrOzNwD3VYaStpmhHxkay6nlGGbI3OFFtK3DtbG0mFe?=
 =?us-ascii?Q?lV5eBkyEssjcxCgZf2pr0UWsd53i9QCt9q4/sdSiHvRWo16OxJx9Wqruk7sg?=
 =?us-ascii?Q?kmL8vkjlOEO11M6iFL8wUSEyLKBa/Dppm5BNQ7FP9tqfdMKgghXAfkstrAtU?=
 =?us-ascii?Q?sUK56veo0e9bFKlL1MAMLCWZ+Ev2yisayXdHu/AQW0QUT/PUW8SIN/cRkD9x?=
 =?us-ascii?Q?MFQOmxQAMo8+1w7THWo52FSAMtILi4pH3k52iSuzP32OUthzG0zN1iklo65+?=
 =?us-ascii?Q?3ogslkS7MGfKCgjZH68t/QrrjtoKgoQEF3JQlQ6O6WYStajymhlvEAD3Vo+g?=
 =?us-ascii?Q?9JGe35T+mJr/fLJJJMvKfVZf65gjXw1em3eOtpB1d01EBHKgg1LoluRFwDO5?=
 =?us-ascii?Q?4Bacp+2UqytkjiSdHZmIpGiqghg+A0KoE5Tl2PpLPJrhJ3VfGuKAWx3SlPDL?=
 =?us-ascii?Q?jjPW20DDmnXFCO3Umv3hbLsCvWkCUkm3uxkAKpdeTXdwcHo3rYW5bEnBBnn0?=
 =?us-ascii?Q?dFyUmXkGS4kCgIi6DEB9nSazMph9rRxYjq2NRUVX7k6JY/Ln9g29qWrB1n0g?=
 =?us-ascii?Q?BTc5+XllpoQcT3oXZz+jWOHwqbapv0n8VYuhA3qbnwzgkFMe4XPeB5sItcDb?=
 =?us-ascii?Q?lXNMS5OakUxV6Su5GCD/OJ+FYl/BlB2/d3iqHMXoe+FTlflL4wsuWy3rPCtS?=
 =?us-ascii?Q?0mEC5G5Biqgm7cU9hwOaE6NKiu1HkKldjyFZOvsCHxF1ldhWCCDCdpsqwd/K?=
 =?us-ascii?Q?sZ7V4GUGAjt7jc09rXIeyGl/Oq1TCRtQsF8oI4N13LjG8uvIToLRPghgok6P?=
 =?us-ascii?Q?keYAw0UPd7QkmfWUsU/dLLybXIvK9JSY1EyojK31ZdRuyrmAmjsBbQzN7eWe?=
 =?us-ascii?Q?aaOsCtEAFj/+nqqHvIneUWkPB7H+0VMuwdDOiWXEhDpMYNIkFr21xxNN+JYA?=
 =?us-ascii?Q?bDe1WgicAdWWB6x/2Ylxm2LgKsQuuI+CCjMshyMdHh43a0rmUOm4hT/VrBWl?=
 =?us-ascii?Q?7XkbrqMxOqoMOU3gx1EiR2I1v4y0eQbTcQ9TwL2wivJJlAqy1UYdAOIk45mi?=
 =?us-ascii?Q?+PT13glugLMCZIYkla4hohbf0Tb+4fqm6NpuS/pI1jI9u+lQNld4Y5PzD9WS?=
 =?us-ascii?Q?jEzQKLPllyBI1LXheFsolzIbk42ZCZ/B4fl24Uo2Kn96HJriE/6ZIeWVFiK/?=
 =?us-ascii?Q?oOCkzEXmgb2Tx77VdV0pNFXW/w6ZFuVDYTIXuQuM+OKj0Py5TTS4IiJqmMC5?=
 =?us-ascii?Q?seHtxHpsQdUZuHbzx7OQkpExNlWYknnXgcnVH4fgvT7dnRTXduO3hm3qQIG0?=
 =?us-ascii?Q?qfB+jyAiaykpuFKPrYmsQEujpXSVXz3OwhKnIa1flGFwcvjcLkPKpAnLds6c?=
 =?us-ascii?Q?gxq3IxHrI3aKYOXGne4ynV1wK6e5+SnaYdHwsnSs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bd9070-fdae-4377-9632-08dd21111ef3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 16:12:37.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBm4JMo+CFRnh1aiIQI3/jYLPjcjRwa7PFaLbquHRo1hJevQm+p2b5KwSQqXrSZuB1jEyVEWjO9Vj4WQ5qa7Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7468

On Fri, Dec 20, 2024 at 10:11:09AM +0800, Joy Zou wrote:
> Introduce runtime suspend and resume support for FSL eDMA. Enable
> per-channel power domain management to facilitate runtime suspend and
> resume operations.
>
> Implement runtime suspend and resume functions for the eDMA engine and
> individual channels.
>
> Link per-channel power domain device to eDMA per-channel device instead of
> eDMA engine device. So Power Manage framework manage power state of linked
> domain device when per-channel device request runtime resume/suspend.
>
> Trigger the eDMA engine's runtime suspend when all channels are suspended,
> disabling all common clocks through the runtime PM framework.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsl-edma-common.c |  15 ++---
>  drivers/dma/fsl-edma-main.c   | 115 ++++++++++++++++++++++++++++++----
>  2 files changed, 110 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index b7f15ab96855..fcdb53b21f38 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -243,9 +243,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
> -		pm_runtime_allow(fsl_chan->pd_dev);
> -
>  	return 0;
>  }
>
> @@ -805,8 +802,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>  	int ret;
>
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> -		clk_prepare_enable(fsl_chan->clk);
> +	ret = pm_runtime_get_sync(&fsl_chan->vchan.chan.dev->device);
> +	if (ret < 0) {
> +		dev_err(&fsl_chan->vchan.chan.dev->device, "pm_runtime_get_sync() failed\n");
> +		pm_runtime_disable(&fsl_chan->vchan.chan.dev->device);
> +		return ret;
> +	}
>
>  	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
>  				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
> @@ -819,6 +820,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>
>  		if (ret) {
>  			dma_pool_destroy(fsl_chan->tcd_pool);
> +			pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
>  			return ret;
>  		}
>  	}
> @@ -851,8 +853,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_chan->is_sw = false;
>  	fsl_chan->srcid = 0;
>  	fsl_chan->is_remote = false;
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> -		clk_disable_unprepare(fsl_chan->clk);
> +	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
>  }
>
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 60de1003193a..75d6c8984c8e 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -420,7 +420,6 @@ MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
>  static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
>  {
>  	struct fsl_edma_chan *fsl_chan;
> -	struct device_link *link;
>  	struct device *pd_chan;
>  	struct device *dev;
>  	int i;
> @@ -439,24 +438,39 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
>  			return -EINVAL;
>  		}
>
> -		link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
> -					     DL_FLAG_PM_RUNTIME |
> -					     DL_FLAG_RPM_ACTIVE);
> -		if (!link) {
> -			dev_err(dev, "Failed to add device_link to %d\n", i);
> -			return -EINVAL;
> -		}
> -
>  		fsl_chan->pd_dev = pd_chan;
> -
> -		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
> -		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
> -		pm_runtime_set_active(fsl_chan->pd_dev);
>  	}
>
>  	return 0;
>  }
>
> +/* Per channel dma power domain */
> +static int fsl_edma_chan_runtime_suspend(struct device *dev)
> +{
> +	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	clk_disable_unprepare(fsl_chan->clk);
> +
> +	return ret;
> +}
> +
> +static int fsl_edma_chan_runtime_resume(struct device *dev)
> +{
> +	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(fsl_chan->clk);
> +
> +	return ret;
> +}
> +
> +static struct dev_pm_domain fsl_edma_chan_pm_domain = {
> +	.ops = {
> +		RUNTIME_PM_OPS(fsl_edma_chan_runtime_suspend, fsl_edma_chan_runtime_resume, NULL)
> +	}
> +};
> +
>  static int fsl_edma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -583,10 +597,15 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		fsl_chan->pdev = pdev;
>  		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
>
> +		if (fsl_chan->pd_dev)
> +			pm_runtime_get_sync(fsl_chan->pd_dev);
> +
>  		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
>  		fsl_edma_chan_mux(fsl_chan, 0, false);
>  		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
>  			clk_disable_unprepare(fsl_chan->clk);
> +		if (fsl_chan->pd_dev)
> +			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
>  	}
>
>  	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
> @@ -645,6 +664,34 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	pm_runtime_enable(&pdev->dev);
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
> +		struct device *chan_dev;
> +
> +		if (fsl_edma->chan_masked & BIT(i))
> +			continue;
> +
> +		chan_dev = &fsl_chan->vchan.chan.dev->device;
> +		dev_set_drvdata(chan_dev, fsl_chan);
> +		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
> +
> +		if (fsl_chan->pd_dev) {
> +			struct device_link *link;
> +
> +			link = device_link_add(chan_dev, fsl_chan->pd_dev, DL_FLAG_STATELESS |
> +									   DL_FLAG_PM_RUNTIME |
> +									   DL_FLAG_RPM_ACTIVE);
> +			if (!link)
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "Failed to add device_link to %d\n", i);
> +			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
> +		}
> +
> +		pm_runtime_enable(chan_dev);
> +	}
> +
>  	ret = of_dma_controller_register(np,
>  			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
>  			fsl_edma);
> @@ -685,6 +732,13 @@ static int fsl_edma_suspend_late(struct device *dev)
>  		fsl_chan = &fsl_edma->chans[i];
>  		if (fsl_edma->chan_masked & BIT(i))
>  			continue;
> +
> +		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
> +		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
> +		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
> +		     !fsl_chan->srcid))
> +			continue;
> +
>  		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
>  		/* Make sure chan is idle or will force disable. */
>  		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
> @@ -711,6 +765,13 @@ static int fsl_edma_resume_early(struct device *dev)
>  		fsl_chan = &fsl_edma->chans[i];
>  		if (fsl_edma->chan_masked & BIT(i))
>  			continue;
> +
> +		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
> +		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
> +		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
> +		     !fsl_chan->srcid))
> +			continue;
> +
>  		fsl_chan->pm_state = RUNNING;
>  		edma_write_tcdreg(fsl_chan, 0, csr);
>  		if (fsl_chan->srcid != 0)
> @@ -723,6 +784,33 @@ static int fsl_edma_resume_early(struct device *dev)
>  	return 0;
>  }
>
> +/* edma engine runtime system/resume */
> +static int fsl_edma_runtime_suspend(struct device *dev)
> +{
> +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
> +		clk_disable_unprepare(fsl_edma->muxclk[i]);
> +
> +	clk_disable_unprepare(fsl_edma->dmaclk);
> +
> +	return 0;
> +}
> +
> +static int fsl_edma_runtime_resume(struct device *dev)
> +{
> +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
> +		clk_prepare_enable(fsl_edma->muxclk[i]);
> +
> +	clk_prepare_enable(fsl_edma->dmaclk);
> +
> +	return 0;
> +}
> +
>  /*
>   * eDMA provides the service to others, so it should be suspend late
>   * and resume early. When eDMA suspend, all of the clients should stop
> @@ -731,6 +819,7 @@ static int fsl_edma_resume_early(struct device *dev)
>  static const struct dev_pm_ops fsl_edma_pm_ops = {
>  	.suspend_late   = fsl_edma_suspend_late,
>  	.resume_early   = fsl_edma_resume_early,
> +	 RUNTIME_PM_OPS(fsl_edma_runtime_suspend, fsl_edma_runtime_resume, NULL)
>  };
>
>  static struct platform_driver fsl_edma_driver = {
> --
> 2.37.1
>

