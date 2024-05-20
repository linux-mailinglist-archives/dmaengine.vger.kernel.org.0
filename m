Return-Path: <dmaengine+bounces-2107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A318CA0A0
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EED4B20FFF
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C53137929;
	Mon, 20 May 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZXlF+02T"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801220EB;
	Mon, 20 May 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222080; cv=fail; b=FbqHQSfXbz/yHsAD9SPRgRv0+GshVNcQixJ6t/atJ7MYJTR3rQlsE0Ays8WGp7IZGJR+Ypee+7VVIbG1kK4rfl9L4bFwurakHc9LLhs5J2Xtvbcl/PLN0GhAJ46Pucu0oEKvuc61OK0YOMRrXSqEM4AjBwXmi3Y7B8BWfb8+IW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222080; c=relaxed/simple;
	bh=BJh68L2Vo442M71kmp+NPXtJGO3KdaNTcmACexJNETc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=se3Ra8NPM+b1flJ1nOzN+ttsd5alhyG880AIybkffu8sR12iHdDfSWrZXJGTOKayDHZh5ayEDdm2UTBjUrvo3avtPxi98+8Hr4YRALhGIJJNDUx3e/kE9ddg7nKSi4FiuLbBqAzW9J4bVml7QbjVMr5jzD/Mse1c1qv/+i0KHlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZXlF+02T; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE8pSerZfh8rsg2grecl/Vkay43yT3DJxunUG1AgeQ3Gk/7UVlIAVCQaVDN3EUIAbZ9d7jnzWqUCBJCI+OEEcuCLjCQ89a7VdLJD04Wa1I/J9Np9v7EC7CQ+A9MDPMfBZ+ODtzhhgKfSS2NNBl3k+z+zPqQclP52EeOk+f3uKwRNa/TUjEY2xovZG8HPbnW9MX+OeCtkgft0L+wUDynqh+/P4v79r07vn38Eiw/kDXHzzr5E/K9Aj5qUTpeszdlkgxRksF9f5tBmFS4SAO1hhiqZDTcEk4hnvZ57tHo2ounmXetRKihhaLw9icchvwtv35HxZA6y3JFw1FCY0XElzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evB8sm3euJVq7vQR6Ti3pbEKrwLAvCFw9hRO/klxrsE=;
 b=Pcw/on3dsZDjyV3jWJvpxKxX+qKzDaS0CqnRuwMJdFWk6BJiY/pAkUE/6iySDeo0G7VvNLcOOruJX7A8tlPeRIEHYjnMVjP+TMAWrd+KvHw+EY7KOI6gJDi69UMGEl1JTkB+AEeKSGwl11JGANvI/AkQQMuR2UYTlyz+dMt2ytq7ze8wUaDfiBYkSxAqDeJaY3jSWguDGAfQRtyfz8FnnltF18613hCZXQLczPe2Vj0sa6SUSDF+vNovvZFxf8zTMRBWdN62C/Sdq+VBm0wXG46ZpjWHaneQBZKCpDjvfoQoieKhUdyjOGDPYK1GhdBkgiv44MfvFGcRf8+O0pGHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evB8sm3euJVq7vQR6Ti3pbEKrwLAvCFw9hRO/klxrsE=;
 b=ZXlF+02TClmEj9wDWtp+Na5slQsSRBNrAOtIUGrTDA7rM79pu5hsl3UAoXw2Y7ELp4DL2IjupF+tg+Xwlv7Xik+vwertjSJpzR6bYl7YPfaG2nXrMXbzkSjFdPQv6VEUXdnejk+YLyY/3NI9OJUXtrSfRlMBXgyY8FEWDcb6ZTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:21:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:21:14 +0000
Date: Mon, 20 May 2024 12:21:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: linux@treblig.org
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: moxart-dma: remove unused struct
 'moxart_filter_data'
Message-ID: <Zkt4dHQuSoRaz7Nn@lizhi-Precision-Tower-5810>
References: <20240516152825.262578-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516152825.262578-1-linux@treblig.org>
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 274bd63e-4a4c-4a2e-c890-08dc78e8dedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zp73mOJq967XfTBkDVAvUZHlYZLrNKu+82z0Bmj161fLtE9KDQYsO1fKNM2a?=
 =?us-ascii?Q?nd7RPW8rj1WWbUuuNN4L63njNGOAHPnb8kHn8OoQlhyfoPjyzLC/UMFQeW20?=
 =?us-ascii?Q?tj1yfdIjBqoBMRkpSccAWr4KUtFIoaNDmvUhoxrQawzWe3M1B9+yTqn1TEhx?=
 =?us-ascii?Q?DsaXHNRFXvEFsqxb3CIEPHKmUENoP+XqWLB6fbY7XmWMKC8ikMLJe5qhvlAU?=
 =?us-ascii?Q?4+1hB9kuaVHPjQEx4LUA9xWDlST16J64KMq6Hx6k4TsL27FVHnWLY9zTLT6l?=
 =?us-ascii?Q?R37id1aLRHMla6xS7piytlvQQ+ERYFk1Y9bFBTOypoPHo3QqwvB98LcynzEJ?=
 =?us-ascii?Q?MVVcXLKBRaAkDzbGqODUKFK7rUbr5TD4cacH1oZNpf7+vtqf4yMPw15bqh83?=
 =?us-ascii?Q?Gh8ABw//+QfsSsRivJ0ROl6lqW1nlnIQfuRGzSJrQ3wiyCIXX6Nii9L3Fg3w?=
 =?us-ascii?Q?JrXovSnyCb/HS/IJONyKpzLUdB96POI3nfcRNz98IJFKWUL2X1H+JaUm+s6g?=
 =?us-ascii?Q?6SjlGxlUspo97TXFCs6nMf/tepHlV1gNgbtrLLRe97DKFj1lEQTTO2JNKNc2?=
 =?us-ascii?Q?brmMv7iu3NeIN3iCQK55bSTVzwfhoIi5TdagUWDIxr9jhumjIhgB+bcqY3iz?=
 =?us-ascii?Q?M8Ss/2+wsY/JVuhGWM4g+ykPJ7rErUSKKE1DVD1tHeXvZVDOO+LP6WxfHSFx?=
 =?us-ascii?Q?SjIdOvuh0ZEI1zYAd/6/D0IXEpv0sGBo5/4sa+g32lH6EFp8HpX41V/HsH40?=
 =?us-ascii?Q?imva4LLEn6wH7Vmm2hsJJoLgRkbN5IWiooHTsPeZRc4XDvmpNM19KQ7gPblf?=
 =?us-ascii?Q?O1Tp8J7WwJy/8Z8P+oUUmIVBJGxfktDBpxNVdboo+lrwikLT1srQayFHe1nr?=
 =?us-ascii?Q?HJcnMKy3xheQRDaiXeeB8TSDFXD+cKcL4vtjdlpXgv6ejU05Z8nOcBxjV8ZE?=
 =?us-ascii?Q?27xF0DoR7jLF0aHHgO16NAjo53xV9NWwF8WbDFBjfK/H6rWUETa26wdAD/6C?=
 =?us-ascii?Q?wGXY6yxEGcQ2YQpJhWHHkTkrNBSNshOabCt1ZoNKaPLws451ynS1XbusKMY7?=
 =?us-ascii?Q?risAbRkd8QM8K1XdtbZ66PrO0IIkxDWAhzX0dEiy47aVXFGhIL2qSIswnaoD?=
 =?us-ascii?Q?6cdsM+Wy7PrgCH5XmCH8ABPj3GBOAyILDG5RNKCufUHpSfFn3yX9vRm8SAfv?=
 =?us-ascii?Q?IzQsshLWHFT/g20Apzrh5NtG7WLnNG/Jb+SR8KsD8YNq/463dE9VRBMpMb7S?=
 =?us-ascii?Q?FMINCX/VvMCyalo9ya3qvBRJK5AJsqlZl/t5IX1hjKf71hKD81jsUOZkpKWn?=
 =?us-ascii?Q?UBT10qlrFFn6SKQqlUlNY9aNFnSLzb7krKp2T0y0aDuUlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgcL2jzzYNQp6YxOiGjvoMEl6OiYZRfJ495milJeIMW8kYPjwcxnyUgQ6pOM?=
 =?us-ascii?Q?lUw9O50p+ftANE6cGY9ZWIgsMjdIfY62IsEmiOqCDBHl9SvwGJFh3RIwUveA?=
 =?us-ascii?Q?kqqYRLA9KtSiQbCDEy5teZHxQw4SB8BCNGlK9WcCzy9+8+yKOwpzKUrUynOF?=
 =?us-ascii?Q?eQ4ofUbXgDu/v8sn0r3M/dsWjDVwp8xqt+2mv2vYRFDqnNYgiukF2JwKEePK?=
 =?us-ascii?Q?9GH/Hj09GXhArjWFf992iFuyM1PNJlYpPQmTWBvClkDRvbdATIvfbB/5nK6C?=
 =?us-ascii?Q?hNgmk8W97Xh2hGKjjfnUrPjSOAgDyiiDqwaI2gIZskjBFHHZXV5nuSJoGhl2?=
 =?us-ascii?Q?cKC01mV3aQG0668ZotqJZ+Iz7ArGm0s3OzUEL5R0zebBrbl28PVWzzkqqlD9?=
 =?us-ascii?Q?vvMGhdQI0+aVcn31euJW7N5JiF17WJ0gqfoJZih2jqn+15GAqgxTnDXDXrjg?=
 =?us-ascii?Q?Aqg4tj3GHS+M5Cb2k689G7WNDY4FpZJHvbUvpHuiZYv/qyJwCBDkjyMKYmdS?=
 =?us-ascii?Q?gVIY1H9FjVtvHZp6ZRseSJR4V6v/IREJb07KqfGgIybfjL9H++qjhcGs/59g?=
 =?us-ascii?Q?lXzbwTjGTrTEhfNOLUVb/rNVv/tNGX1HJm8DAlR5ysvf636rcxBC6H+ux6SW?=
 =?us-ascii?Q?InANeSzH5rkFnw9NQe34DTtn5o+xigVY0gH6i5Ip7kyWEARm7JmgnvzdE4hH?=
 =?us-ascii?Q?PvqHZzNXvtzEbGT9uDeXjDou7lzHCRdVCw1hir8e5IU+cokD9b/1h/w0MFdP?=
 =?us-ascii?Q?q8t4EnDcrqteE/+U5qgJpa5MvAQpOQRh1Vo+yLbftN4vulmPEJzlxC0fv3xi?=
 =?us-ascii?Q?yRaj1juBnZVJys3KtDv0TGEzjYT6s0s81hF69m4yqlUNlZlJJ7/VqGa4vo8M?=
 =?us-ascii?Q?AkhfEX5k7qEIa+xgELEjsVAOm1vRV/jBRWG+M5qk54AirXrlKi7SRG7ltJ6M?=
 =?us-ascii?Q?dWsAlPBCzSIMgJfVFm16jrLQ7gvwB8rWT7IcqsmTOAdSxJmkRUZzrpByrmpB?=
 =?us-ascii?Q?jyl44fXsWNrrBpRxshrLM9L7tXMrujRPYBPDLQwo2+XltR/fnUlCx63gIEzg?=
 =?us-ascii?Q?eKtttEds20wUnuJ6vjKZT33lRkzeQAAnC7jFJb6692zsaPrt7jWc5w1Qj1dn?=
 =?us-ascii?Q?+Zj5/6fWFEgtVqFRTp2VE8OOfUPQRP+uL+kfugsj00hmQIBXFNLimGdfC2ig?=
 =?us-ascii?Q?ZZhO/PdDeosvfDszSfdUimmnI6Y/csX0wLBlZ2H++KBQtavYKzZAxAmdEvou?=
 =?us-ascii?Q?yBYpxNjtD162+ulkNZxYndenSZMdbykiTRz6PFnzufE26HLtDbraqODcTirK?=
 =?us-ascii?Q?n8bbWsm8GzM2GDhS1S1KZlNiWADjlQDg2ZvQyxV6ZbEsXax+MQ78uQwdZLux?=
 =?us-ascii?Q?MWsMKLa1is45wnyev67/qTmloDN0THvavzjTlIwnDS6geEGFmAxwHKjfx+14?=
 =?us-ascii?Q?uqkzST0aa4/eRvqvhHOjm1608U8APqK1u+PNuo1v5w2a+HG5He42RPzpt5cH?=
 =?us-ascii?Q?rb5R8csjiyBb3AeubND+jpNIr09PIt3HV69GucG8qdRfWdDtKNzkdD1VhicN?=
 =?us-ascii?Q?Q3f6ERheGti1SpYok4c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274bd63e-4a4c-4a2e-c890-08dc78e8dedf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:21:14.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNPmclaRNPvgMZxfvDNogk2rc1OW9vjiylJUSaeYTrzTXs0yQqGCBfRL+Y6+HNZRSAB6fxyXrViqyqyBw0h7cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

On Thu, May 16, 2024 at 04:28:25PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Remove unused struct 'moxart_filter_data'
> 
nit: need "." after sentence.

Reviewed-by: Frank Li <Frank.Li@nxp.com>


> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/dma/moxart-dma.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> index c48d68cbff92..66dc6d31b603 100644
> --- a/drivers/dma/moxart-dma.c
> +++ b/drivers/dma/moxart-dma.c
> @@ -148,11 +148,6 @@ struct moxart_dmadev {
>  	unsigned int			irq;
>  };
>  
> -struct moxart_filter_data {
> -	struct moxart_dmadev		*mdc;
> -	struct of_phandle_args		*dma_spec;
> -};
> -
>  static const unsigned int es_bytes[] = {
>  	[MOXART_DMA_DATA_TYPE_S8] = 1,
>  	[MOXART_DMA_DATA_TYPE_S16] = 2,
> -- 
> 2.45.0
> 

