Return-Path: <dmaengine+bounces-2043-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28478C78B7
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210AEB21443
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB72B14B965;
	Thu, 16 May 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oZhcn9Qv"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730B145FEB;
	Thu, 16 May 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871263; cv=fail; b=gCogEU2X4iJ5UnRMHnV3cbEs61JiveSY1H2QnpUofNf2h/K3dSdPrRYIPFTj4MF64GHHvJtA50x/k3o+V62C4euBWX03P0l2jqaDBauv3bQv2HD9SOKrGfaSnEIM7+bO7iUlKILmYGeQHXUDaIgXjugCssKVSeWSKPNn7GOvwDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871263; c=relaxed/simple;
	bh=WhHMD1ontwmxaF1tuplWEN44+yFjespx0hdiV6pJtf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L68XeDKwMD6G93cNRhDLWKnmxwwvUh7yCarD3FHF5yiro0XwP4f+R5o41opTV8hW3MVH4yk3yYAyOebOS/WrOmem2Rwqa1ImIh7yY7qsdObE+n8ie8MHD52xIo0LG5IWk+hiSuIc9bAKRHCDjmrUKmwWfHJtf0nwnz7ynYU7P8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oZhcn9Qv; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifwtAwTzVcMSOXcSMpC1IDLa9qVjCTolx9JgqOV5h5CJWZ5AdCurU7Gk7+4EZ0ziBS/0/51NDkKmckFPUHLspbgUsMVIBZPDhT7lYNvhsQtmT7EHXkUZw35oAp/5ViYzdeDCJKUYWLaeCXjy9tArz1ImtO6f4K9qpSDdvbQjriC1MpFfgXy7rTcAQQ12/JYAkDonbPAFR5KrLqqKCkZ5Un5TyOMJxSyealzBDCTWEfPEMBRgXdmOK5QXDbXQEmEgM4WFpMHMxzVFOXD5gdrepcZaozwHpWi3z/fGbsRk2oqa3gDzFNviV538BzCh4QwjnyiPky06OAQeHd8Km1Rptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90qojFtnTsNYQT/FPLsIxQersPfjkA3UE4dm6p8S11s=;
 b=hV0S3d67rRf3B8bgZvyY7ukAbFSxP44FdtxOHn7rK5FI32tw5oX+MiXCiLQxdJC9yIrAe7D/LgaDOyBnsmi2kXowpUtCatxXG/5N9q73Dgv8+D/ZCzjAh1FkVjv6woUIaugzdwuXLSv0+HM+GYlshJrcWBNqh5DWL9yq+5sNZgW7t+bTww6OHIAko7E0fgZSYNMmvl6F6CKKNTETWcgtckgjCXQghNd/fzExmSW98XnfDuSWjgrhK59jYfJT9qz4zlm6dyL7j+d0q8rxqoz68/OUkZJSbav8C2WC+9KLSB2u42P8HXkTWixPLZ+cZnWw6mLl3mmyfZZmJklkgRnVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90qojFtnTsNYQT/FPLsIxQersPfjkA3UE4dm6p8S11s=;
 b=oZhcn9QvboNmmXQNm+w0Au4uStv76hSVNIpxp5QnRcbbUCqzPiEfQGU1529MTweMeCr6OyPcP0BnU641uPjCXa/Q1H3Z25jA/ADsZxsO5JqECnCfYF2bRMqdN7MZ3eOIo2giEjASLDu+hn+XucgCdocQ0bWdNHpjJaiR8mbs93M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10253.eurprd04.prod.outlook.com (2603:10a6:800:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 14:54:17 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 14:54:17 +0000
Date: Thu, 16 May 2024 10:54:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: linux@treblig.org
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: moxart-dma: remove unused struct
 'moxart_filter_data'
Message-ID: <ZkYeE2SgzCFDqKs2@lizhi-Precision-Tower-5810>
References: <20240516133250.251252-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516133250.251252-1-linux@treblig.org>
X-ClientProxiedBy: SJ0PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::34) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10253:EE_
X-MS-Office365-Filtering-Correlation-Id: b0df8161-4e9d-449c-b7c6-08dc75b80f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lgw1po2TdXsagS5EjsSkN7ZY4Bs+7rA47PSDzzWEGmPSAi63rvc5ud8D+bA8?=
 =?us-ascii?Q?yIJlZ4OoJcpj9Y+4az1dfqP5W82qATS1CIrBzqGp1WcAW298c3S50G739Kmw?=
 =?us-ascii?Q?urE9L05dwtjPg9fb43bPDcjCO2k6tbgEsQCeGzAjO1uNYGxRYO5e+s5d//gy?=
 =?us-ascii?Q?+DuxzyGrpobymJouwyckZU5DO9ulAavd0BXUAT/jtPTzsdvBbt/a6QhTzUNd?=
 =?us-ascii?Q?QU3HHit/Q6efgq6KgNfA9+n5/oVgfI1AYdHcF+RFYKf565kh8gyoN2vgplha?=
 =?us-ascii?Q?vnpLhfAjqKs5OnKdfYDEufJ1XBU+XddCncTU2PetRzQYhOuYtb5jXwmiL6zF?=
 =?us-ascii?Q?9XiukNEOFz+4XNexuDvLYVNriTYkO1HXoBnJRbifLNUpxzhr8qvVxHMU50c8?=
 =?us-ascii?Q?FzfyREN+fZvf2C91t13a04NNeJL/ovZXaN0luhGJnx8tNtBlehWVGDZ6m6kQ?=
 =?us-ascii?Q?JE+5I5AdNtAu3UeTFpvn1/QAZOvImMbT/hW4GjY944mUJ0fx0D+v1aPUIxC9?=
 =?us-ascii?Q?/MP6M19kpnf7n5UoMenQGIptQPA698pNKswvlZYi4rJnPlIY6FvAYDDxOj68?=
 =?us-ascii?Q?FG3aAibBFKd+HVpX+UKwS08ihR8ZKkNQjBi7UGLzUyqD+JY6mebzxAS3rlNY?=
 =?us-ascii?Q?HpQqsdg/eb0RxGbmr5Tfiqi5Ci1WX25P+lZbnv+30xTYFkBCOdoHJw74aukv?=
 =?us-ascii?Q?YcmE91XmI6yB+wmG9qXu3RkWA0VxLmeGaGcfuEg7RR8oSupQI11tVssnf818?=
 =?us-ascii?Q?Yqel4AA+l7Nggm2uTJ3DuHtOcs8dVjmXYFCDyURsYiv9i+YZA2y4tc99YV73?=
 =?us-ascii?Q?IuyeIQwYGD/USpKdYcBrhfEcz5f3d9iECroP+UDnw4mYTl4RhG8lAjPTrFD8?=
 =?us-ascii?Q?R6fGQ7dV2T+Oyd6SfER1c6rmI5WnxFsP9biB9Nbz1MnOb/nz1o8KjP2nH7ZT?=
 =?us-ascii?Q?Qb0XCi9Txc53ejuvKSzqL18Nj8UlhxWy+Gu/SzzfNDqU1YhVyKSXiDOC3Lt8?=
 =?us-ascii?Q?KgNWfhGzVuEbNwB8gL6iEl1/ObwCP05Z9OQGX6N2dAV8mk2Dm9BcVph3HyQd?=
 =?us-ascii?Q?2LxuFcgpEA0Xn+yR+k20iznWJBlPR+MXU7UQJCQH3QwA5xFrSCWd/jFNPTMK?=
 =?us-ascii?Q?nlyCmPqBUwl+Jmref/iP4vG3oxEAyPL9WeVLO4pkLq6bU/soHnBJXzR/YBJn?=
 =?us-ascii?Q?22/X71+6Uhd+fVldT8lfixm8S0Bb+CAUu61TzNRB1aivQ8u9C6D/qAMoNDFJ?=
 =?us-ascii?Q?nAQ/HGVhpuo5e+6K6n4MMtH9IrlQEhQF2jYw2BuYXudVnBWAfCzPcYa3m7/m?=
 =?us-ascii?Q?C92G9gD1l6JGtRWj2VBmu0hDK5kBvmq1fhNbGc6Y0EV2Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lkZ6EQy54L2VP2abI0rPgJPy+NgKHORKDpR+3jUr430x6DqXrMPpaaX9sMl7?=
 =?us-ascii?Q?ordZcez93lCap7C6Ix1NrBuQRs0YGisxP+H/M/2aeqhVY23YdWHNI8ac+UtA?=
 =?us-ascii?Q?WIppSMEYQdbU6OYDlSlt4HyiXXnh6VwGCwt58naOgi0si/E6YfIBBHKZwQvk?=
 =?us-ascii?Q?EnhW+ll8dfFNul318/1o3gUnnXrugGy6EtrqL9/oD7uUp7sWVgePnMQDRpK2?=
 =?us-ascii?Q?ANujD3m3m+u/ZePyXaMhf/61Wf66rCmmQ6uiUVpJIM9pHbYDqh453uB1kPI2?=
 =?us-ascii?Q?YfLAg1ZfAkMmU9+m9Kq70Yg/GUJ4j9cgdwnIMAaAT3EjbcuGKSLp3H78nIow?=
 =?us-ascii?Q?SLRKyXmJy14G905c7tbEot2cqedcg7tNvA1ZabLU5t+dd6kW2ov29vWVVcdr?=
 =?us-ascii?Q?Npe9sA1j4ndvDj5Z4QkFgM1tyX2Fv0m1sNUN5ezVjdAlX3OJHD6RUBLQh8jf?=
 =?us-ascii?Q?0D5PoEpY+oWZ45+Bt3HaOhSJrUt/jSNr6eis8+T1r7Y7H5VWF2Hcb26sTdAm?=
 =?us-ascii?Q?AsVPM4F1NInT3f1+wxcqAvszXYqoHrgwLQB7TyXWAhTm4m4haHpofBAzetok?=
 =?us-ascii?Q?Liq+MvgZwlAKgjDZGlesmpC2qejLuYwEat5FbW0LlfI1RxG7nhqq7YYGS8LD?=
 =?us-ascii?Q?traP79F2Uy3f/69QzXu36AQHSG+l54ImSH5sq0FFCEaiLXHgYHI7ZFgK0WZm?=
 =?us-ascii?Q?0bNAMLk30kcd7w1qCBWUg6MhdVC8mgqbTCDLaaqDNOyQcnkOAOA8spndrDK+?=
 =?us-ascii?Q?Wf2ju/s5ggyU7ckJnqNjSz5IEyKHJ5P0+RbCThIc9Id4GZScGx7wYIqpndDV?=
 =?us-ascii?Q?G190E5T822K41Jste6/18gGcnI+jlvoKz6iqdyETNpRrWI3ixbbkExedcxkU?=
 =?us-ascii?Q?rhoTCRRhdighNu8red30bQstBh8GpnTTIiIQXMOtPRcrbCjDx5mgsHpeonU3?=
 =?us-ascii?Q?V9gANU1euQyxGGg3CzDXpPi3pBukC7Q9E6ArXbvM3yxtOuXdkBtvboIcyNDn?=
 =?us-ascii?Q?Hq4OiCXt+NwdnBm6lqZWXMzVB4cDxnLYGA6bd9QGM8kF8X45eBF0qauHVU4K?=
 =?us-ascii?Q?X6ZvVkrVfYp5MLGVa713lCK4mF6TXzYISB8zONO67pmr3tP81UYOaFT3H9XS?=
 =?us-ascii?Q?mFjxYAUFqTorN+lrQmJuSpAwwrV5i7xgoF83t7E6n9KSmhydIUq4k8qT1Tes?=
 =?us-ascii?Q?DZhqchcV6zewSdegsI+JVOUEttsOCuGvi6CILhJhbwMpmK3kLI+XSoRnxqqZ?=
 =?us-ascii?Q?DgsuS4aJS5uQDGk7S0CFDHtdB6hm5W0v20lSwYNSilcHoWhapVh6KkyK9Uty?=
 =?us-ascii?Q?rnzqqVf7A5+3JLR5s0w4DM33KJopZDGEKw0j4d8FG/Jho2YyPD7yDJ9IE5A7?=
 =?us-ascii?Q?OkrrypQG47rw63O5l9bd7yIJsG2VYPW1qsnc589NHjjjjID/PvM7UdzJBnle?=
 =?us-ascii?Q?jjJTDqJWevWsChHTBtAlHphrcIn/9k+icmfwE0NelqX9CqGWUr5tjInTYDs5?=
 =?us-ascii?Q?1GuWur+9DPKIn3XlQ5HEzjeE1FC7Xa0dv1TyzBgjE7WUO865N7LTcsMSrDk4?=
 =?us-ascii?Q?3mBP75Bv0PAM+r8wvkfGtpuivFgEYx/4QneiDD5t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0df8161-4e9d-449c-b7c6-08dc75b80f96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 14:54:17.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMQtyYzgVWVy2ChB+UtOJAcnvhTX4qdL5YzEyFaX6Ta2D2ZWzZsLvzQ4/t7OIFyvm4aPWCqOQZMNzo347jWEGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10253

On Thu, May 16, 2024 at 02:32:50PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'moxart_filter_data' never appears to have been used.
> Remove it.

You can duplicate subject.

Remove unused struct moxart_filter_data.

> 
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

