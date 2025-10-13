Return-Path: <dmaengine+bounces-6825-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B43BD6002
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 21:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00CBF4E20B7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4692D9798;
	Mon, 13 Oct 2025 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JlL8vZIa"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177F27FD52;
	Mon, 13 Oct 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384930; cv=fail; b=XJ8vQZanNDvc6pXvdNkYF43nkt1M0HKlpQq6wWw2YcvFRfKnTN4OmOforgB8BjvbROQO7jHtFZvlfl/tU9g/qblROsy121wReSpyFLAK6I20PdraPEDtT/cMUMwCdzaKGa+i/7ukA+rJTUMD1PgJvxIeFLaOMp5baFA7tZoVCe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384930; c=relaxed/simple;
	bh=aW6xtLRCODzO05uoXyK4ZVMUcbHQ5ELqhfF6J8qWbV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a2NjFpCHPm/7UaHwzn5VTJrvVmb31utQbUmcgAJZus82SjC8WuIlm/IZlH2w92rHEmID8D9zkUGXhs0g3+Q8P7XyV9ZZbHy+zX8ZAo2vNI4KmEA5hCz07dKZlH6B3+WwbaOYOOKoIbSvdq8PJ0S0lzy2ownrbnTk22kZr11Cb4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JlL8vZIa; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anwOpJFdT5c9KTbhDazwsNxD7vwyCXaFdtWWvJYskr2rLRbqIrSWV0IJ4JMHdzOui1DAVurfiGseYkaQKxuPScQSNB2TEvHprWxlJx8WfrO2HfAOW1I8ulRX5dopXl6XnfIHDWM18wjIxLqrFc0hd8EiNZStY4S0Okl1k68dOUPqad171rdWqH64BVjJZYXFXrFwqshhAIAgdK8ixR0LDtFJwP5tvx0bMPuG3CvziYgqsKFQ1M6orour+3LEAzv+M5mpj8MicxQUv6VhxJbzBQ+mv1GGaJUZybB5tppsf614qbuaA1IGiGNfZGPNDQBwrVUSbPti+Jak46ljFHNmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4mk6kWyHCaYZMu6UAhVEb0Q1DGGKDVTgJdkEPuRo+w=;
 b=wKaNiCyGs+UscB4TPFIoMqnQkXAFXAGt0m4Z+oVy6+ABePx+0m/jr3LuIN0yDHZo7DniY3O+jlZWCpCzDPFAQdfsjvff2JRdugz1HLJ9aVFy7sCv5p5BJYHFwLhyZSBeGuwrlOZChv8Utt+cSSz+mx7tsRr4AZJkEnDQZD2esKfYUhwySD0TAA8WEkORsRQll1LiHPdlP9MngZwUI4if+Www+vuOD9Pw8rhSoDGpe3Ako1dSegXJCdke/1fN+M+OlOMaPCSlGRFuwaeLHeDaM6CCqqcMyD6Yll2RINt0q7YSSYcp/Rlqjty52uAp9pF4Ojtqjb8NO762Ci00Wkx7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4mk6kWyHCaYZMu6UAhVEb0Q1DGGKDVTgJdkEPuRo+w=;
 b=JlL8vZIahjwbwp2YEE52jgzxr4dvJqSQGj1DhIIJUmK1JJILPr+IfwcJ64pGiL4B+lEXHBVLd529Zem7kdq0Zw08E+ZNGu5cNwkz1nAREATPLdjJuZUo3+ql/r38TPZvMK4VtljhspLbYXlT08Cya6GZh3uDvkK854XjdNhte8dFkHWfU1/83zLr5yi/uKVYBi7i7M3lN9rNxR1nhK+XTKn6kEyEswCG0s63jFtpt5WkAft/CKZikEuJCyVMg3eLfXSSOhD/kXSd7qqHkDWb2+87gCB0k2A7kjHFhI39FOvV0G1HRmfGS0HZ32aasvxAzzbIngqL2Kyll3i5g7udLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 19:48:45 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 19:48:45 +0000
Date: Mon, 13 Oct 2025 15:48:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: fsl-edma: Fix clk leak on
 alloc_chan_resources failure
Message-ID: <aO1XkmQS9XU61XUO@lizhi-Precision-Tower-5810>
References: <20251010090257.212694-1-zhen.ni@easystack.cn>
 <20251011030620.315732-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011030620.315732-1-zhen.ni@easystack.cn>
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcbdc79-82d9-44da-3103-08de0a918281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Me8tx2opE999k0DyHKNDxj+VYc4/L7sypUXgbN7HPeyXPyFdgJbPAYM/InX5?=
 =?us-ascii?Q?a8G1tOOlkk9zgHZsD0wqKexpErFyKz1P62fYF/vCgJsykXiYkwGEV04SyYCX?=
 =?us-ascii?Q?EIW3G+VnXmbSl6dJpL2GUrKn43uJFb0g2M2Ftt3ekcALomXGglTJNmUjI1cS?=
 =?us-ascii?Q?4FH1Fpmi52BL63ffVrV+4TXRMmxVvSy7el26UBL/Tvj/SxEWMvk1pTHk5FI5?=
 =?us-ascii?Q?pK49WoVDTSDDA11DFQQA5WcZrrmrAD3CaWr+TDaIKn4EAl8B04OAi8ntTxeJ?=
 =?us-ascii?Q?3QV00pF4KRFBDNEQkzyLuKhFcPWNfAdUd0IB8pXODCRSXX8x4zKNuFXY3TXV?=
 =?us-ascii?Q?DBAVuekoRyUfJpCFOp1UYB+/ajAvhbvTAkmeg0KdJyct14ficjxfjmYIy6sK?=
 =?us-ascii?Q?kKdRgX/HFlF9pmuInxiIRZ51zBVQyLfDOJR6KenC8wt2NmlK31IFeFn9JP/Y?=
 =?us-ascii?Q?hP3OBcPIMTFeqhh/HkI/FqClMGq7zyyUN6rlsPe+ZDjxhVQ0Av5oNAqZs58o?=
 =?us-ascii?Q?jCVgsbHkIx/h6f2X5QTD7PauWcwBj8uBPJrpXyqbM4XJKmDiMziQZjTRsZpg?=
 =?us-ascii?Q?ZmNzWBbQcKFLNY59yZACOIpZn23ZxVF8gtMSmt/hPGSF/XlfYJTt2Xeihoqd?=
 =?us-ascii?Q?oG2NN0H8g9Mp7o3fbgRr9Lct7DNsdL8d+lFf/9UhGXWLJM8giLzhzpUruXgl?=
 =?us-ascii?Q?lTYr6ZuGgeaY6duu8D+OSg5gM8VUQ3oX6VZCwzkReJ8+cG6WxmfrSOM4ll9N?=
 =?us-ascii?Q?BsGJrBkIcu6kf3AzUB3ojROpRPASm6w4WilBKkHpfnXJVFCbYry6BfVqWpB4?=
 =?us-ascii?Q?/uppVn1hV3kxlabu4XoEm8IF/v79n6xwcRdOO+4UAYB3SLhCHVpACvnVt4nh?=
 =?us-ascii?Q?lXe32KsBn1fQ2da3XDlzKpDrpON8R+GI60fO70c23eHJ91iwXtivCsveUmjw?=
 =?us-ascii?Q?MgYXItCv/AJZ39VdB/ZyT3/UhcP/4CImXmedCb/nfVTW2tDdn7YO2BTjZ0dZ?=
 =?us-ascii?Q?B29jyeybnbnPjYiuMyBXvtoPy725F34JIhtosHcERyjFN0sMnYdLZy1c2GQ5?=
 =?us-ascii?Q?wXmuHiUHlEJ4g/WWHvcHSxpyipUkA40RprmojfpYHZCJcIUCOegQUHxcRrIw?=
 =?us-ascii?Q?LHutUk/YuoF7wmZAzSYjt1+i7MxokZmsCDRxDQqjaY3DoTH+HC/D7BzFXbP3?=
 =?us-ascii?Q?EFmx4KbyQUvmp9zXkxDEMcBrNBmPhqUSPcVeWWRBSrBs0e161FINQ2DVr+W3?=
 =?us-ascii?Q?KJlFRhj8HbB5IOYZUf3Mlqnr3X6HdUSMqNBYDdAGWRWvZ/odDTDrBRPTAxXE?=
 =?us-ascii?Q?VJgImvY1DDGN1owjE2YtfEtjd3Nnyd+DHqMskQ4mk6ZsrlaKdfPNI8uSJA2L?=
 =?us-ascii?Q?MLDTKNqQiJU7YSFzqiW7MsGNwkNP2EkR0ORWqNzNJHIH0hacqKrmlidaBj2W?=
 =?us-ascii?Q?g69z2IbroV/rYL1++Vhy+7RUqjpbU6c/5uIj7k4TfFnJyQWtLitL71eeBtv+?=
 =?us-ascii?Q?NJdP46BU/VWhBVWPhAA1uXFdw2caNML5ddrO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8B+2yrVCZd0jwVj3hl6FZrwf6S41jYiZuoN/CWng7MtBG9hF9QsmRd2p7prh?=
 =?us-ascii?Q?Kqzk6ni+UteGLIQb71+77nXP2FlVinGZxXwGhRfh9d/kEje44Du2N1CprpMD?=
 =?us-ascii?Q?yqVT+arKHCl7yyDhTzxYfIac9EukcdJS/aWvs65CJlW5q+6lUhDDrK5Fc535?=
 =?us-ascii?Q?a8mHc/QWbLtA/S8VvUSrjdrS822reQvJPtMzo8E4viVTHAPltnD6+iRLg8b7?=
 =?us-ascii?Q?goNrQwAnod/+xKkv4JiPx/zCcL/2EpWdWfnuGs6/MChHJ9CWFZQ4pj/QVgmn?=
 =?us-ascii?Q?Wl9tD0ZXk3dNRALw5QNw3kWFl63n0UnPsXLLB8TxBp12suuXduIB4ybYG+cF?=
 =?us-ascii?Q?bUhmpzkiGnju8n9fI8TXCEjqS+bmDejz95vugFEhRFpZwuDYaaBiFD2SoSju?=
 =?us-ascii?Q?0shhXCm0g6C96PaV6bFjnvjWvXQpzVICmxjiyy5S+ufIDIW5+mZKMI1Denj/?=
 =?us-ascii?Q?i/u3kXxPPUHa5O3d4HYQxr7jreJqjzxocZx/uJDvxS8MLiITAyX6pLAR8sp/?=
 =?us-ascii?Q?BnEzxs2r882TqzZdkHe/ULL1dlEA2dqdImACyFxvWqeS4e9plp7tiZuONlqL?=
 =?us-ascii?Q?hW2rDwc/Y+RAxwLgUrWRzbEkKV/C4Wy/pKCulMQlhVGJmHp+sqCiGP2LACzC?=
 =?us-ascii?Q?AJfNINZvPxKXMGfJxTMdsrO0ixeV2b1HqwHyeibDXaSsx5SFtPCIV06r+olw?=
 =?us-ascii?Q?cSqgX8GmhccvzWKSfnBvwxL36Dp2ahlb/cS/TvV3m52re33ov6VrQ9msG3jn?=
 =?us-ascii?Q?qDLHRd5bKjSw/rBJvJ6k0sLBt+dH6WDK4AjxRLpKkI9qYgjmmsL994/wQ8BM?=
 =?us-ascii?Q?9wZDi1hWknUSoaZuU9Io5N2zd2A7l4iTMwbXC6dJ2WRn1HsysediruEn9Yhh?=
 =?us-ascii?Q?iUOxB2JcPwXJwQ12UaxG6oxlkiyU9qsuiOCvQ2QUpgYh83J3dv2UziNqPpsN?=
 =?us-ascii?Q?H5HD4owT7ktAHpnC6m8ipsF9ijGOuKP/+n2aigLUxulAWbn6/yjXQMtxoiQw?=
 =?us-ascii?Q?NyI1D/WZcrkAhjFqUEEpgf9Gia/XW5uf8BXTUXtdaxf5uePBEXT7hmA0aeid?=
 =?us-ascii?Q?X2RF4Y88wlm/a9ZVaCXMEK8nXrhaSrUCbKBetNWV4X1KFlba8WEeMV4cnStI?=
 =?us-ascii?Q?PAv4KO01B1phkr1MoP8Drp/igyTTd6wmuZ8Spa6whUqsYw/jfYTU3WlAmlre?=
 =?us-ascii?Q?+deKwjI8Ptkvd+5j/oMy9VJPVY0OZWehCqmgHxiiaa5SwdTZdnrDCPf+e15K?=
 =?us-ascii?Q?IH9Y9Fv8GxTF8Ijg1HOFb5O8VhHh4H6R1wsQGClDZO6tuXGOPXa1yBCo1VBl?=
 =?us-ascii?Q?IEB+h8SrS3Et5nmJbt+vP+N/CRQx6IWUsG9/+w9FErbeAybvGwvTeRtQRl6p?=
 =?us-ascii?Q?tJox/fjnwDxKpj6yZrWSsMGOgHaGf3jt/WjzZr4kulm0qFl+C8QPpIp9qQic?=
 =?us-ascii?Q?D+4tbXmVEUIYmkhWlIlDu3tuA5LCKhdm4j2SIVJrJLQsbACGUedbSOCY0T25?=
 =?us-ascii?Q?JuoKlgJEjNjvtMeX7cGn79OXB4yi8HdiKrbuvecJ1nhHDP1D9tMYKD87iYx6?=
 =?us-ascii?Q?Cv9/uJmLjUbvzDJxPH4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcbdc79-82d9-44da-3103-08de0a918281
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:48:45.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udx1Nr737H52/Mi/ru8UGSbcLiLnFioFbpLNsFE6XbhO+knS48dHegN8JGHSZzWYquYfyuKQrgjp5Cv6yTFOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798

On Sat, Oct 11, 2025 at 11:06:20AM +0800, Zhen Ni wrote:
> When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
> the error paths only free IRQs and destroy the TCD pool, but forget to
> call clk_disable_unprepare(). This causes the channel clock to remain
> enabled, leaking power and resources. Since clk_disable_unprepare() is
> safe to call with a NULL clk, the FSL_EDMA_DRV_HAS_CHCLK check is
> reduntante.
>
> Fix it by disabling the channel clock in the error unwind path.
> Also clean up similar redundant checks in the driver for consistency.
>
> Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
> Cc: stable@vger.kernel.org
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
> Changes in v2:
> - Remove FSL_EDMA_DRV_HAS_CHCLK check
> ---
>  drivers/dma/fsl-edma-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 4976d7dde080..3007d5b7db55 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -852,6 +852,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  		free_irq(fsl_chan->txirq, fsl_chan);
>  err_txirq:
>  	dma_pool_destroy(fsl_chan->tcd_pool);
> +	clk_disable_unprepare(fsl_chan->clk);
>
>  	return ret;
>  }
> @@ -883,8 +884,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_chan->is_sw = false;
>  	fsl_chan->srcid = 0;
>  	fsl_chan->is_remote = false;
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> -		clk_disable_unprepare(fsl_chan->clk);
> +	clk_disable_unprepare(fsl_chan->clk);

I may not say clearly at v1. this is cleanup patch, need seperated patch

You need two patches

first ones with fixes tags, to fix fsl_edma_alloc_chan_resources()'s problem

the second patches to do cleanup, remove redundant check
if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)

Frank


>  }
>
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
> --
> 2.20.1
>

