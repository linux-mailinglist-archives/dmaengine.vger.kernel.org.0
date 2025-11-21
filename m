Return-Path: <dmaengine+bounces-7274-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A8C7729A
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 04:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02C3E4E1C32
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 03:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB30279DCE;
	Fri, 21 Nov 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KY71dvUe"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013031.outbound.protection.outlook.com [40.107.159.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517D2248AE;
	Fri, 21 Nov 2025 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695640; cv=fail; b=mkgTdR8HPK01EyefxOg7y8uvFpq3egJNTU9feDeoTNTVXncTxGKNluZfkFhvFBPGjVxnMjpP6Q+B9y25FFsNGVAPU8zTWGf0823nV/er1IX8Z4+I0G4usdu7R8ha+bW4hMcaOOmgtKyy3afnRIt/6djwhuQziO5YW72BKA57lyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695640; c=relaxed/simple;
	bh=6pFhKMkL1WcjoMOReeLjd//Yf0Dd3TwZCSrgKWxIyro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qVyvnd7pqzK9mzxVmAWFuE6xTXztaS4uI5cr4DMNafuAeX5cRoDQhxRk1UDcaGlHuhkzepK2WqfJKm/LKzMqZL7hgxkAXj8ftJRQfTIHT1KNUkSr89f2c+rfd5fJYo+d59YLOXyZHZUo129fYEejMr2WeftysuIPd3ojLor3BX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KY71dvUe; arc=fail smtp.client-ip=40.107.159.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvK+lrfLqNHL9p7i94DANmBF06j5XRUuAplGHkJ60P3x+mgsNEeHgTm02I2mEpH8YUC7hSYbLp6XaC04h+LfmdimT9F/owSI56CR/n2Ce57vX6/Do4H5BIS7nQoZBr5RDFP3d5rnfgXHQsScRI1AawOclTflPIs7H99pE+46WV/y3oCMtDa8bVn3vYTe3/PFwWdesu53nlXREWMwl6EvjFbI/E1Jgowh0g2WkUq425g/5pw1eNZdMcivUhG5bULOwt5TjgkVtF6WwIx7tBGY+dxSUdYpQZXI9VIVyqG3K0B6dJVyjCLecP6ih1WEaPcuqIKp97WHWI8CGZAAUKw/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgCIVDUyqu7SjrPr+ap/Yss2fDJ1heQojq1/W8d0fEE=;
 b=kdo3uIeTLtsp8qLmzX0DhTIpPSGfhL3N8/7QaBpCUas/FREKZelwqOfb0UcBHKRfb+IqxQ163Kt5VDC5IOO8wXpU5eL3n3ukY0yqK2S4KO/7ZeXLalFiidSAZuv2Y+nxZvEHTwAmqnqzCDl4HjL7afD3KglhywTeY+KEJRVZpWRArKeV3Wa9M1JAQ95BSXo9XDwTKNo8Qnb66HUh1pogYELLs38ERHZiqKW4tQ3bIVFhYl94132hMszUr6we9VPlEH554r+4r2UfYhu+l17yzWjCPGMzCE9MtH+e9pYCQWsHOGGj0Bv0eRYb3L2J8z3bdIKtVbbARf21AT9GrW3rAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgCIVDUyqu7SjrPr+ap/Yss2fDJ1heQojq1/W8d0fEE=;
 b=KY71dvUeRhdDvcuPRMYGIAhRkLD9ogt0mF75qOzWOV3z3kxOe6YvbE1JoPbKk5hFM7ZmzbnrfSUWnFHFp+IoZD18ABUc/WzjXe74VeDKd1IHmanF9N9xE7A8Lr5+FU4m4g3GZ3rQf8Ppcr1f3BJfmfBWTD9est71CcCtCU+2Sl2DZFiMXuMhtClBrjtpna5zhdLL8meW9f+bGSd9B1w5Ot45V3vgU47L2ctWMi/lgo5b038h/BEunVa8K0iEp6Co0HVou+jabol8YaRup6ThUwSmJ2kLKIgYUGG++r6+IQMGyuqcOJ9ouTeZJ9uCYt35D1IvWGqT9oV0fKhigInkBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:27:15 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 03:27:15 +0000
Date: Thu, 20 Nov 2025 22:27:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] dmaengine: fsl-qdma: drop unused module alias
Message-ID: <aR/cDhKVaR8P52QF@lizhi-Precision-Tower-5810>
References: <20251120114524.8431-1-johan@kernel.org>
 <20251120114524.8431-5-johan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120114524.8431-5-johan@kernel.org>
X-ClientProxiedBy: SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d349f40-cfcf-424c-741f-08de28adde10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LyiaDeYP+wzkKtOA23vL85Z748GYFbzHrTW5Yarqn36l2OAmQeGX/K1oJj5O?=
 =?us-ascii?Q?WgC2r5uHCJWaUEPrur4AARTiuGe2OlERLgkmFDytgFl4aniSBVZVxEBbSAwM?=
 =?us-ascii?Q?YGSZpuW54p+WsAVOxNMRdyby6RagoXUou82BKCKtHvOMTYolXrnhM+aFBQSE?=
 =?us-ascii?Q?eBqstWiE1AvVPK/OYPj5cR5N4+53cWWz/+RRRpH6dqErWGiitmbD6FI4Wwry?=
 =?us-ascii?Q?RZDan3jjNSKhB2PRb+Jc8opWNaKm6FX74F2puY9vYIrV8ojxbmzZTyPJbP93?=
 =?us-ascii?Q?Fvj2s+cHll8T/xHj6IqHpt1HDiKtDSPYNY8eExGTy41Ik4sDOryxLp9sHeFK?=
 =?us-ascii?Q?NLQhLb8lmFPnLkFhAZbhQAbFVWilJKMnn0Xuimkkv9pEbIMudPeJokJv7PjF?=
 =?us-ascii?Q?uAr1URNI1EdquhCmFgd5QgeTi9V8jPbvhoIdtggk1rCAzKZp2exhUduL0Ed3?=
 =?us-ascii?Q?+kmjfPRxS+YNGp2BnY1M5kca9WwdPX9cH4q/6oleWoXJz4wKDjOAewlpXfKh?=
 =?us-ascii?Q?AHYN941dHdNIyGWu3ETaxck5N3SdlrUg5ziOcMGVWpLDZGi7Q1aGuYE4/c7f?=
 =?us-ascii?Q?GtcJLnXtYz/pvT5xjs4+mJRd0amiDLycVUdmfJWgeD5E6C9ISkTWDLLNHYCU?=
 =?us-ascii?Q?N/1SbQjax19rIhXbtn4XZfUD7RYXgXKsL/3wqhxCuGOIIpG330G0SL/PNEHA?=
 =?us-ascii?Q?3RHwgTQQcyGdihfiKlNSUEHJJW/I69XeJW/81E4DtUbrNECgfJk6OUY4M5az?=
 =?us-ascii?Q?VoBRv2b4lSBW7GfnIfDvKN9AnVIyQC4EzBd8/dOmttSn5MvtoyCkAJuP1hAp?=
 =?us-ascii?Q?9/guwpKi90SF/Na3YvsJQDLTKaAJldorLOd5aHDshXWmt7HxHzjfyk0nAOQO?=
 =?us-ascii?Q?LdyCMoT+OXBVmTsgQaSfkineKoWrQX6bC1x2oUlsmT6JKR4mcB57wkTpA/8Z?=
 =?us-ascii?Q?AGo45hr1kYxocZPQwfAh7VYkHtl8YmtYv6MQ58GccpGjSb0p+jiSVMrOz1xL?=
 =?us-ascii?Q?DhXTVnjTK0S8T8gDeKShaVjkJJ6JOn7KEaCU+WvnFhITl4uZriajT/bjGF1w?=
 =?us-ascii?Q?arPAZ0VIxNloehpFJihj8q8W30jqCXS8UjCbnUvAMCJCaKEekfq45d1/ixDt?=
 =?us-ascii?Q?Kc06pHSfoBdqUZLDWPsb5lExvTGECScBdfxEZAI+RKcfoATuk4K1YAO/79o4?=
 =?us-ascii?Q?fL56L5pD+johiaGsCbJCB/Muk9zfmPxTEoRBUxFS1Jk7q2ged5XP0wAJboAD?=
 =?us-ascii?Q?fcz3TnNCQpwH/+6g6K+/wC2AW4Z4IxOFyEzlWMBgEK+1/6g+azur8DP94F6z?=
 =?us-ascii?Q?HIaA+Svp2/aQW/qmSmk70UHia2KFxpNj0ouYdNOvFdYjBZxbxQjccFovyIpC?=
 =?us-ascii?Q?FPyRm5QVNqtzZOO0KghVdFmJpdZ0Z2TeBc8mftvwMHP6d+WLAbhhG7aEoE5n?=
 =?us-ascii?Q?moaTpKqTmyu/ECmMXw3ndJCUd5tpi2qMGMSMJ9n6UTTe75ckw1I9Rggv9NfM?=
 =?us-ascii?Q?U6NASbebvUk1zypVTxUypPS6mpLuSIHWvV4t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XW9J7WJ5Nbyu239XB8RFDJldETkjsIsv13zXN2Mg4xD53lK90I+0GfH4bJTw?=
 =?us-ascii?Q?pMg9FpPH4D08zY0M9DHjq0yIZaeh2lEIYQScnIKemFDgdB5UCNSxf+TvytTR?=
 =?us-ascii?Q?dQy4XzKqPidhHWHxHneScn1JgdryExGr3jUENQTHJP5JnaIH2eNQnSTAc1wr?=
 =?us-ascii?Q?FUsiczrpbNTLSPJxFc8qihh+cab9c+WoTd3o3t1H8IKLZR9ZnGrICN4KxDqN?=
 =?us-ascii?Q?nZUwdFWgLzlp0CJ4rWwv/28IYz4dS5PN80ChFJpIWQSfQ+g3I+NlDckdtWQY?=
 =?us-ascii?Q?1rlZnDiMWVsjxMs53+8cmcMTwsNQ3XUI1YHibysgA5B6KND9A5fNyOldSm6P?=
 =?us-ascii?Q?MwofglmEhss42sWfT1Z6Q/rHcpSd2ZV8ZjNTBbBo3iv7IfIgbZXwCOiPoJfE?=
 =?us-ascii?Q?T4XvLr6ePgeMokXPZenmxrMhWICN4qVPZZ0IIrWTVbbFtgx9Uh+3802D7kOd?=
 =?us-ascii?Q?W1aH6u3tNK+/L6GxerpzFpr1psk5ARpjJMzJXfN4RrMdL/qWth4suBoMt9UL?=
 =?us-ascii?Q?/IEqizyxAcBaCg2pauacSo2+JDtUSHrvju5tY2/dRoUDrtH+7t/+m1zJQd61?=
 =?us-ascii?Q?NR6Qa5ry40kJ7fXpwo86tf2kqzUebrMPxhtMSj/lLy4Aq7bGgD/YvuNKfAZe?=
 =?us-ascii?Q?LW9BG2Y4BPBaCV+dK8h0eDFXdXLL4nyfSD40Lwum6vVn1SvVLVseSO+mUSsj?=
 =?us-ascii?Q?qkR9R1nM49A1u/6AapZTg504TOcYz/fJOuO+MDXsnwgLi+fwNX8kMQQvnE5e?=
 =?us-ascii?Q?xuWs96GIp7zy+cZr+gv61LI0DtKqr7lQP9HlolIqnV8PbdEAobzFOg4hWZRE?=
 =?us-ascii?Q?N2L5OBmndOOPbO/KY2O58o+TEGtbA2twOjXIfv5n//OSsWOFLXQEdZzO+3fL?=
 =?us-ascii?Q?tweS9womWaEm+4PQ5JS1BVfqD5aOMa5qEtNeo68/8C2j5LU747iVex3u2ZiG?=
 =?us-ascii?Q?MnWzBF4tkCeB8XkrELeo3EOMIRHd0rTMXFRP5LaIP8lFhjPo9p3LY4pKBYrw?=
 =?us-ascii?Q?MYb7nf+/svweCB0HbzcdAfpmhZVd5gBnqyZjP+5OBe1nhsbZiWp6BC6ARoDw?=
 =?us-ascii?Q?kXQpAgwRw/3CBCpzBr/HJyeiycsUeVpLhZizDb6yk0e+KVsWZrPQNp0uJkWm?=
 =?us-ascii?Q?ZcUuNl5gX6zUIub5SCu4vJeXP81pVaWRjqQANBQGYz92fSRJqJdchzKw+6e9?=
 =?us-ascii?Q?9rYnPNYfRXv7T2onwMyLIiHEnTvBgsoMBQM1i6J4+9lk8IzvQZa8FtZC6DvC?=
 =?us-ascii?Q?P6xg7VRGqgSEITDmt5iycmrs8JT4czUqnRJ5nzUb33qTBc4XwM/A6skIF4xw?=
 =?us-ascii?Q?shIWvxAjScsK/3WJ/7oDLApyO65/DwXpilrh3XhIe47FP+H6sET9c6AsQs2a?=
 =?us-ascii?Q?Nme6hoeCkNyQ9xJ9idr8Zeq1lIfpUZgphUq2CP9XXF7PI/mAD8eqSWj6Fh2c?=
 =?us-ascii?Q?jXyR1UeNA0K0peRKeFKhtEnVihW/58UX9csFt53Hzo03P9UG1iJIr9E1l3CO?=
 =?us-ascii?Q?yXEhV7pfcRvIYwBZdE6lb7tInma252lkVTLTJFle7Mhbd/wmuogSSWcj3YnV?=
 =?us-ascii?Q?ONcGdUvSDN46jcfwcslVprVbZi2ON6r2YlsB95vz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d349f40-cfcf-424c-741f-08de28adde10
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 03:27:15.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKfrpjnElPeQ9FAa2QQC9a7s9rtw9o1JTAs+1eGDXZxVTXF4JySwJJJElJsLrGqZ4DG4OM7hy3Qhac/baSQypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

On Thu, Nov 20, 2025 at 12:45:19PM +0100, Johan Hovold wrote:
> The driver has never supported anything but OF probe so drop the unused
> platform module alias.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-qdma.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index 21e13f1207cb..6ace5bf80c40 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -1296,6 +1296,5 @@ static struct platform_driver fsl_qdma_driver = {
>
>  module_platform_driver(fsl_qdma_driver);
>
> -MODULE_ALIAS("platform:fsl-qdma");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("NXP Layerscape qDMA engine driver");
> --
> 2.51.2
>

