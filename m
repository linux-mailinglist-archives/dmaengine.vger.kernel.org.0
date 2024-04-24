Return-Path: <dmaengine+bounces-1951-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED288B0A7D
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920AF1C232C2
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101015B158;
	Wed, 24 Apr 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bz4lgrSz"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F515B150;
	Wed, 24 Apr 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964196; cv=fail; b=gIL7+iC/5Cb3Nc0KyQ/S1pouZWKH5TwX29hJWODHjBC8Ujeg9veHKWPNe5jJ5sbuPU46jKTQulwbq7yUijEBWjk+a8zxRO770g63cb9cTZ/9ax/zFgn9DPlJlT87Hv2XURnl2AI1FwS0UbuqMe0n+iNrE+5QZVNqw9t76qwyvlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964196; c=relaxed/simple;
	bh=moFU5yypEgTBW3ReUkXTrRXfoabEgxpyjKkToeNmEN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CxVPHKKgdZfp0D+/k67tqGrH7sYoHc5QGqvxIjzNWLk+oF9B8F82sdmf++2cDeI+sixOBwTxFTnsfl2Wu8obQ2AubURo/tPlR6iKA6fIURN4CWWhv/ZstaPDQu4B4t4r0ieu7ZKTUQJY+cIqVgHVAdr4pZao/WlFM07nPIsKI9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bz4lgrSz; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3ZcDbSRqJsELm2ACoBYU/CgoB5DWpGlwDm8OcvLWVtXxKKND3whby9fJJ0ucRL0VE78+SdJ0KLANXUn2xeGvawOmjlw82BTfxoJGWg6Zj/5zQ+IS677jZKxQqSbEdG7ppGTwVoWecUnq5oDgGek3htiJAyCsTHpiKDmmKE+6T1nGWkhu3CXURttWWOH44ru2kfUma/mwG2q1OvGyT32z8NxhNiFOt2vSt0S2HPGiJFWOlpkcuGZYEWMZcSxmPFNzRFO44G4uyQMAMbv9B6Faxpxi0b08U168Ku34doExC7Cb/i/rqxyjGDDcT0SpWt4nDs0Fe4Q4dusYZZjlwWwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxEku2hewmWYMR6SCNUfzVBWwfRzrKIgFkq3/X1Knqw=;
 b=X/RzSbkcZpRCL/f0n37rwzdQwf3lm5J9HP08tulSV2aKbVbfqFRYdNK4aO+5jIQI3p9W/0avRbAEOWVGR0A/SmIsnmk6vjvViG+pjFf7lRehWU35dPgKXC0mmSU/W+EVW1xvAGYXNLcO/qhb2cpKIVmmbcHVp7sAOv853Cs0gPqJMqMrsa2i9+Nnbo18LsLFFuFizO9ZD0inuUdIS9j9apN4ihtRSvuJOkksXvZuIe1U+ca8e0u/TCMKVkkCyCLMf+Bo1r0JQ9hN+KuKm49fW0e9ANL6ZZ4PM275PPvSEg0bp2h8IBgjwMz+J0PbijBksphFCo8cjFiorCkKrR2qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxEku2hewmWYMR6SCNUfzVBWwfRzrKIgFkq3/X1Knqw=;
 b=Bz4lgrSzk2Q+lyQhAMM+GqASaiZr4Hj/319PN1J7Cl+X1aFux4uUpryHWxeSW/3G0w5RDwl7hOLh+3qsS/TF9/BIOt5ZcNDwOVHhJt5gcui3/HLRlKqjhHUWfwxXlTwwZFGEkpheIymDwq0RaX0Ua0CsHzfO/L02alUqjEvJ1wY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:09:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:09:51 +0000
Date: Wed, 24 Apr 2024 09:09:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dmaengine: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Message-ID: <ZikEl8Banvu9AyW6@lizhi-Precision-Tower-5810>
References: <20240424064508.1886764-1-joy.zou@nxp.com>
 <20240424064508.1886764-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424064508.1886764-2-joy.zou@nxp.com>
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b3283c-fced-45a1-c91e-08dc645fd333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1MeQDJPSny50P66x7vJWfF1MeXBQjbLsCKhXI7RytB3LPm6f02GmXTHTAsVy?=
 =?us-ascii?Q?xI4mobANlNlqfOK54fqSGOohUwXpJ9Yh8/sy9hZs5FkCd1GPgmQJ5FLg9wb8?=
 =?us-ascii?Q?WTyUFAc7e4paheDgf5B8fF+dRhdUg+XCIJ0T1uRJIxMJ4P+hfP6JfrSMBRKJ?=
 =?us-ascii?Q?rL1Lh3GLmZ4dUkmDspsAOYxnIfkvS53XfbzbGpahrAmSO6UvwaW00N9/GOcB?=
 =?us-ascii?Q?yeIorWmPZLmrkalGWuHRRUhHsVvU+2F8hxJ6vsPR7AFBN/H0ickFgO3FTO5S?=
 =?us-ascii?Q?9jvm0BSHJ9CZlE/LqvJCVjhmovBcc8/v9WWU1uptDIaSNJRwqS4qqGuwRRu6?=
 =?us-ascii?Q?A7jaggNjv+UkOFJ39kcDPwo9BLBwACBzmIy7p4H9m89HODD7fGRiC++zIJt/?=
 =?us-ascii?Q?PxnVtgcBhX5Ll02N6WzJvV/g8rOtQb0OHtN7KfgONj1G5NcuHajoAEWAMw/s?=
 =?us-ascii?Q?A7OoSKBB5wpoUPKz+SkBqCghzo6d1/SMqe4MXloyAiQ2+EgodRxto/rcf8CZ?=
 =?us-ascii?Q?IQt62yZiehIGDa8UmraHMuyF5LzWQHPah4RLNJw/UsslL5e3eYdyfeOYJwxI?=
 =?us-ascii?Q?uSzzF+u78soZzNRJEayZVCp+pcC3opkdekfjd2PE5JDcFUJg8MIZl5XZkQeA?=
 =?us-ascii?Q?j13fYu/lPFkRXkiKDq+O8O4DxEyDzvnlHvRnNNYd/2EOVaCp/9tyKKmeYJ6f?=
 =?us-ascii?Q?MyG987K7p3v/mR1Ty5HW53gADyAxr11bjXsUfAMiGK9jPVk8IkjhEQRf1DK7?=
 =?us-ascii?Q?RH8KgOSokzpx/7fNp++6GEttbcbkfbLSQ5bLLOlut4m0JBCkd798BLRtFBuR?=
 =?us-ascii?Q?nJol8IBPbsHydyFgimSJL9dEOIDmtqZOjV/gjWwS41lgFOWEIghvfmTfyHF8?=
 =?us-ascii?Q?b8wmJ9slmzEMoAaG8sTKPcRX2j5wFP4LkS/+f1tJogdwatQGtvy9GQ2YUmCz?=
 =?us-ascii?Q?b0TnDaDC77ursJPkKXHJpA9whhbkl0h3tU+V7oWxdtYLF6ocGRg+V2WlRMj2?=
 =?us-ascii?Q?CwgsGVf9bl6PUbo9x9oMivm3GpJO+EwbqxMS/5a8wlyofyEDarV3ijW+fVga?=
 =?us-ascii?Q?PXopvOiDeG0ePBvOd4+P8wZHd/+w5FuraOd1hGCPgpXKhR+A128oGHPE77H6?=
 =?us-ascii?Q?hmZp0zETuifJ64KXIdiXmUSat25+Z4Cy+LDVRKkwTouajel7ZM7G10loKZKE?=
 =?us-ascii?Q?uwLaqFvcv3ne2md46Bzmi/W2mNGMST3h7ZDS9fENZxjBfCx/w5YfDZEye/cK?=
 =?us-ascii?Q?f5YX1PEKnMOPIDxI49gg3iMy2pHH+ta1bDtMmha5/2cmdGeuNb62yohh9N5F?=
 =?us-ascii?Q?yf+FeFdgyHo6x7LiXMw6jjo0XrWgUZZXA+0EzFlsEKkmwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wItPSPCguoshyNhoubtJyeFAFraKJJ3OtIhZZ3K21/lPEdqLL/9ksEjzisKh?=
 =?us-ascii?Q?hPOeKBKgiOlO9l+Ia7EJW9irIGkOOpNIlLOoDGLShAY/7DCZIoSkURUaC+h0?=
 =?us-ascii?Q?kZR0YNAjyPPDl87MrsPhluYtkzhCJ6gnRgXoRDaLXwZgU9xRYsIRsGilp7tv?=
 =?us-ascii?Q?2aECc585YLXV23J+iQgpjC/6UqWvDMBHQ0mx3X1LLjrpoosbbABahHxyC3kY?=
 =?us-ascii?Q?pOTSucGXj1D9NQQpqk1Hdsoe6y7lFgJ3o/dtMwMQOo+ldc+rcWKLysyJ02GI?=
 =?us-ascii?Q?lrQEptOzYzA+e+XJCEKN1xu27zl0i4usC9tBTjhg8p2zB5WN8jDcipEYDJIc?=
 =?us-ascii?Q?yIt2hOEAyiB90t9HRlBATWhLX9umpyA0pw7kN1ze2+7+aNiLlhzLoxwRet91?=
 =?us-ascii?Q?HQG7ao7CmR5G5uAHXWuG3qS4msxXaA8CNYlYsgm5i3GtApCt977BfM6W67LU?=
 =?us-ascii?Q?H7+f6WA+8QzHwqsGj2IjNzcoxYFTbJfd9n0pwk413ahPax1DjcoEhoBPTM06?=
 =?us-ascii?Q?T9qnYhWTCl+XeuDauo/gtseoWJI/befppyx4E2pD4XlA9BnGaYcPPP+H+hGl?=
 =?us-ascii?Q?D+1g3rdSRs2bzk5SfjeP9A0+P+k+nlAyyxeydejxiSLXWcFmB5oYX34JrQjb?=
 =?us-ascii?Q?I+6KslA0rZlXWECIw3m3dxaQfa5sLP66NQQd+ZIyq56mKDEYQ1BmwrrJcryd?=
 =?us-ascii?Q?ZnOrtTUxeyi1TOk8p1AdjrWRWqvX9E1pMgUfa/6u+2gsWav5iBRu582ofhc0?=
 =?us-ascii?Q?drV/b/wpSGBxrCfP2yp0m3CCLFYYRh8rWoKtc75if6I54s+BoSafnNSGCkDw?=
 =?us-ascii?Q?Kc5a2HzgK26+ppTdA1o7Yy1vakPoWZq04Fd7FmRExT2M9zpW5TEPaxZpQncu?=
 =?us-ascii?Q?92JNnorDl5MCIO5HCnB3jKh23kz7o8QbKPTnFltr/qb4yOscBlP0gtH5guSi?=
 =?us-ascii?Q?z2pFBV/yb1mdgbTGTiOlpGzg9dGDOqvMPa8PF35k0H5vY+5QlBIrEbOfz3zt?=
 =?us-ascii?Q?CTuXzcTW5lOY94uBSUhOT0KWVbMSaqpNXgJW0Iz0kRDNohWrnva1REM02q3h?=
 =?us-ascii?Q?dBHcVNaAtpstQq5UgRSO6hgfiAiGlWAs3NepynhlB9/Uyll5gqi4d4CqY+av?=
 =?us-ascii?Q?NarfBwJ6DX3Fm1OlmwFMGyW4Tc7WDMEf17P/3RrT89dySQiWAJnRY7wzWCXb?=
 =?us-ascii?Q?yGhZzfTu/6fzOd8noEaiQZIUTCsOR7B+Xhc0G9Vx64I57/uOvI+dnqfH71Ox?=
 =?us-ascii?Q?MZ8fmSgKCNuf/dpOo/eg01d1R50JJeB3Kov2JkS/wNNvha2Ep37GD7TTrCDq?=
 =?us-ascii?Q?uHA7Gd+EMGXoy+FlhBcypN940NW8s7rJP8Ww/zWVJFjqF+QY9c/y8DMIzYFj?=
 =?us-ascii?Q?zhgZcbrOUVRc07VX9yOiD5LWpURzMaziYEwi2JHiTvPPyd37qY79mW+zUHwz?=
 =?us-ascii?Q?7X5Ukn9vCtVKo3fwRi39rzjyVyL3Ltpt/b23fS3iC4N4waObjyEkYnmrOZuS?=
 =?us-ascii?Q?IRp1aHsNPf2KB3b4fXP0Pw01Iz3u+Erv8VHjDlKHpd79waWpW8HDxGSmSGKl?=
 =?us-ascii?Q?PPA2xUoBq4jhFsFe+44=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b3283c-fced-45a1-c91e-08dc645fd333
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:09:50.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDej25MftCkfmWdNypyH9OxLYi5HeWxgDH+XN4Hy21P5i1WPuhRwlF18ZXeq9SJ6QREgSENCOGnryleCO9r0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

On Wed, Apr 24, 2024 at 02:45:07PM +0800, Joy Zou wrote:
> The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
> So remove the workaround safely.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for v5:
> 1.remove FSL_EDMA_DRV_QUIRK_SWAPPED in fsl-edma-common.h
> 
> Changes for v4:
> 1.change the subject to keep consistent with the patchset.
> 
> Changes for v2:
> 1. Change the subject.
> ---
>  drivers/dma/fsl-edma-common.c | 16 ++++------------
>  drivers/dma/fsl-edma-common.h |  2 --
>  drivers/dma/fsl-edma-main.c   |  8 --------
>  3 files changed, 4 insertions(+), 22 deletions(-)
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
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 01157912bfd5..3f93ebb890b3 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -194,8 +194,6 @@ struct fsl_edma_desc {
>  #define FSL_EDMA_DRV_HAS_PD		BIT(5)
>  #define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
>  #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
> -/* imx8 QM audio edma remote local swapped */
> -#define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
>  /* control and status register is in tcd address space, edma3 reg layout */
>  #define FSL_EDMA_DRV_SPLIT_REG		BIT(9)
>  #define FSL_EDMA_DRV_BUS_8BYTE		BIT(10)
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

