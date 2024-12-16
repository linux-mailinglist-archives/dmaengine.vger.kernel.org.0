Return-Path: <dmaengine+bounces-3988-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DF9F35C2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25CF188902E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF57207657;
	Mon, 16 Dec 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EMfH2twu"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C228206F3D;
	Mon, 16 Dec 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365833; cv=fail; b=gKg3S21knIDG01Xb0t2ccQVEeA///B4XuonjCA8pM9Xk1I6ZEuPb/L2jcjPYmICNNq/jX112RGGEUhJ/NNmPIy7T5LLJzd6WzxwbQZYMV48aMJlmj/BPSDpzTEn3lrAcsW6c1RTkzJzLsT5Tuqs1IA7j4nxrmxXK5j3hzoTSVXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365833; c=relaxed/simple;
	bh=CapZFTe0SE2IbM/NnoLCmkPrAicMqwFKm34o6GQKYOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=reuAUQKWwAb3VZNFtYv8492KLRwGoTb7bLuQY2VDS7Vs9mPuyTxotkcbLfI+J6Nk0zRPrYQ0VIVWgZv2X9PxxG/YZ0SlEE94pXFcxYS5Fmrq/DgwvGDoz1+M5Q5n8imWxpdUG78vRk1asXrOKG+tFgfqF1Z/j8y3GQHD2ZETXYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EMfH2twu; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYIlc3VLMI9/MThXtIxbGaPx97yqtT36/xdf2d9C18eh0MYKluZdUn2AhtzR3UuyCgzzjVvqwrbiAlh634mAwRqbY8a6yWkHO6WodaiOyQgccGrxQhAACD4Z9XzvFYOCXpzGeuDxhZHhBBZWUKYPQSjRhbVO0ICdAdOTZOkoq/u1bqISt/hTqQYm6MtjQnDZgzKnRdPmeSxXn2RuJSQE5p5XacSQA7HflpCbB54LHoIKX8L+35bzWiyC584Fz0bzWw4r76f5rDpCnsDJUp6CIzEa8Of9uprGEFExWeO8Z23qZRwyTxJAEd1RBB3cOqjjat/F4KOmFEGz2AHLIfKCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/1eK38v2RAZuRL1Cp3OkvX8zan5sqs1ZiYByw+vZzQ=;
 b=J3zcXLUctX8nYCBzcXXlZ5guk8DtLjzUxwfLof0l1X2rZTIdGXybgh2igWnLhr4YF7sAvy1/7ChV5Vv5RSdrTEwfAzQ7buQDxbb92DtrSKkFlgdqCNXcoK4yQssSqcw0HpmIk3trHOLFnsibRDCKPWMnaV4ItZIQ405aoflbBPF21DMDeunKkf4GUpgFY++Cw+dGHv645kCNELd8bcbn/2AzPs2Nr/DS8grcY9KJbnIBsBlzZVTbSYD6cau0+dg9Bjovjv2Gp2JOBK3RMyUJOOC16v4IA/I5etnGHBTttlX/HkSLukVdw5o3GSzNZj9Y7CcwGY27qBfIMFKt+sK5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/1eK38v2RAZuRL1Cp3OkvX8zan5sqs1ZiYByw+vZzQ=;
 b=EMfH2twu7JbdbxBB88P6JFcdRCiV80kA9lyNE0N7oKoPOsfPiYTdyDhCwYnxi3w6pW4Lt4r3pw1vc9u9N/gx/zLusCLXcE98sgc7FKYrRuSy5blRcp8EhzLLaGKV6I4hobEx4MsG8yRltDmLBUjoWdzJbD1CXXf6bfzf5q3BozGmBq/u+vT0LKyrsI06eLB/J8Ngy+Wb9UEPQC/wk3iX77qNkOq8h5Lbc+X3/23Hgwp48WIPFl1AkmsIC7HnAXgofNq5hssxvyUjaT15BsLwCw6g0R1TKT1LjSpg1rd6iYLeRlvnnOCZ/l3pr0nqF9URtYnpG8MUxThszNrxUpe/uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8529.eurprd04.prod.outlook.com (2603:10a6:20b:420::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:17:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:17:09 +0000
Date: Mon, 16 Dec 2024 11:17:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 2/8] dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG
 check when parsing muxbase
Message-ID: <Z2BSfW+YO6/3YXTn@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-3-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216075819.2066772-3-larisa.grigore@oss.nxp.com>
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 82afd8ea-acfa-4125-b813-08dd1ded1708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApFQN+6Os+3f83O9jVZtJUj/kbudT2SIVupDO/e5YmBTTLQgqBdVVnH5anbD?=
 =?us-ascii?Q?Rt6QbQhPpR7UlKz1inL3DxeXnpsDejgS0GsOYl5UhfVi1Wg6uMvE3twqn3zE?=
 =?us-ascii?Q?DXaRqXps8XXqFaHSxA/h70ynbfCKQHyZ57cd8WWGXd++xkj6aqP4c6EbegGg?=
 =?us-ascii?Q?4LcY+zdGmJaMRaPOfq78LJSLctNOX75i6M5JeQMawFoonWQ6HvjJ3iJu0e3V?=
 =?us-ascii?Q?3s+0BPZtupVidiI1A30t7RSjUd+yTXGsRF4bswieh5y7wBDilfljxXquFrBg?=
 =?us-ascii?Q?lxhmHXUla73f+A7mUqbAKCwXlvfRQ5ZZSrc+Kye3Qi8EpjOSmpVBqyFhvibe?=
 =?us-ascii?Q?p6GF9qg1xNx0jyDFv1DMry2MEvyLhnK1+dX3o23n0v3Yp/f9hx/t2MiaB+IZ?=
 =?us-ascii?Q?rEATaMAsVxpInYLIV3jqx7JGZje1ULeYGao6tUJ3ei0oq1rucRAeW5UuiUNp?=
 =?us-ascii?Q?BjemtHwqI0rhLGZKumHdBYS4p0uIDBRaXybAbFHSNVD4Q2lvUuNXFLtbbynT?=
 =?us-ascii?Q?DV2aBoieQ83tJnyc2F7uixq1IwHDG0BASOGTFNUPaDDHkjXL21I6vZJv41GJ?=
 =?us-ascii?Q?205R+2iRF0PZGVPMU7Dt7tpMzSlLrIFKfH8fjO9vpXJHiFPiprh3qf9RtiVv?=
 =?us-ascii?Q?qVFxIDC5raMl8ITAp8NtCGMaa0VjYMjBfUe/vxvgguNZYi00OPD3zvyVTgA1?=
 =?us-ascii?Q?phDDrRVFeIm6GiOm5iRuHsGQbT1uu4o3UYToDNZSXJfSDpqSeuVlTgPfugh9?=
 =?us-ascii?Q?Ly3GyNcvYCoADwGRjXUJ86cDoVXuOFBNE3OWwYZPRtYtBH5/1pyFyyAbN9jr?=
 =?us-ascii?Q?IWvHjdkSi2u22HJCWsbnnvQRrGbL7ofappVleErOaLEjT1rwUOJUNnhwTq8n?=
 =?us-ascii?Q?knDa1KmDlfjvRfMEdGugyULLoMWzU9wRRnJ1xgyjqEd87OsZJ4/1aXRmvHoi?=
 =?us-ascii?Q?46jh/OvWr8I1BRLd/uqEPax49XUWdt4ZFNjIvmA8Ccbn0ZYWgrSYKm4nhphg?=
 =?us-ascii?Q?90ONRf7gRinJIuYCaJYmMK/2TL1CaElQ8OEizMWs8SOTKtk0XeHKjFPowHy4?=
 =?us-ascii?Q?XmkRlG5ceDH7dfsY9tGYMrTV9qqFOFqazbNoSrzCurXHGuy/+4ZqHeTzJIjP?=
 =?us-ascii?Q?2muTPxY8j47WszXqHhvrDCpFNMWS1noPvd8ITlMr3QVzGd5C57ozE8C2FIyo?=
 =?us-ascii?Q?dozETdg+541Kz/V1uAbZAg6m3IbTW2jHqW6BUwrJWdpmogUud8KRd9yQ0c0G?=
 =?us-ascii?Q?XHR8T9k7baoJE2gsIlMteJrYQYPYyr83sGVLwvn86Nu+27sOcJLNSSQdUFV+?=
 =?us-ascii?Q?Q0Ugqfk8ydzclchS6aF9q65oaALbsKNI34V0+fTA7eLCV7QVSPGOcjkKM/Y2?=
 =?us-ascii?Q?6Axf3LMy9NdV8mJRTxaA64+TVRaH6LD7DfsR035pkdT9D40tQGsP8zWa5JE7?=
 =?us-ascii?Q?UnqDXqPBtXHbe+446GBx6yyH02AAXK+S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaaMOfrLZxu+JbvORq+v1KVNu2F4Ixf2r+D/nNTZjwc/dkdhq7NN+C+kyZrV?=
 =?us-ascii?Q?a/E3GrEo1d45CxnPWOQJhDFew23KM2hQmDn/cWnE/R3bJ18Ae49Y5QehQNFM?=
 =?us-ascii?Q?buBGulLH597ELHXjBlsKg8vb+ldON723A/wB9+bZZ+SFqGZsj9jiQDPc5xLk?=
 =?us-ascii?Q?Ne0i9+8nGTk0GezIJqx3lNyl0fKQeoP8NKOLoV5VOn6e+cRugJxckReqFMn5?=
 =?us-ascii?Q?yFD5C+Z/gU51saEsbs4pzmlR3fx+Q8R15GhhGSJfkXeN85KakY1QVAW0NSjH?=
 =?us-ascii?Q?M0eLl1gdUd/H0qCelzW902YWhWpOPTjrRqScS5lHAC18dwuwcZoaD8p9QCOq?=
 =?us-ascii?Q?O3M4xFfS4QgG8fW4YWZIvLFXYjJh0zI3VBADONaGNOtYa7DDmYbllQTR9+Wg?=
 =?us-ascii?Q?4vPFnTSbGevlOpf4rMu11bLGKtGd+NBGCgLx25PSre7kNvRfxcJidBwDELrl?=
 =?us-ascii?Q?CByVUM7ZUbYyfy8W8m2FBqMxw6c5rRgREqDHpHTM0Z6tBZ2Z2VV2SZ5BIyUA?=
 =?us-ascii?Q?VM4exm/6rc0YIsX6saRcSswIJqrKsPLI0ezKaC4WjgP/GHy09mHl5FTtnMU0?=
 =?us-ascii?Q?V2MFqjj9qP2OM8ss9UtKnU3ys4DF/o8AG7WlGmDOZ3upm/d2ie+iJmX+vmoJ?=
 =?us-ascii?Q?KWGMfG6iAKt6X+k5BtV4UJ8qaQowXhyVholc5Pw+Lc7OijHFzME7LUDbN5QK?=
 =?us-ascii?Q?5gvlgQ4VqXWsjHjo74OCJVHdZZJJSyHQalhkx4CbiOIq6gtPgONAjeaerLEJ?=
 =?us-ascii?Q?Gze7uo+bpkOeGgjUr02iK9Yjx8EIB6NbfYEiFFs9P6g+bBG1xF/2RXeqdrO4?=
 =?us-ascii?Q?QHyV04AHRifyN3mKWaRTZViGnzJgzv2ArNZk/7ctLGpsmFE8RFJCNPnB801P?=
 =?us-ascii?Q?VwVToNe0UsDMiUc/Eu1FnQA3uMiN7B1EZviKGFl7YCXKruG12Xj7sqrwpEVp?=
 =?us-ascii?Q?fofZcgceYlqp8mehUDV51NBp1Li0cAlIffY0ljU9qcTfsAN12asvPGnhcIo3?=
 =?us-ascii?Q?wMU+mgxTIaXLlCB8XK5UtVl5kGZMYyaAJ9YCO9a08T3MlAT8mImFLqWJoUCy?=
 =?us-ascii?Q?mp1QXRg1cnccSd4OialWyLSNPgDKDNXZVpSeLWW/L7d7aBiDYido9Gibus01?=
 =?us-ascii?Q?JJzTimcwbW1j3NzmUUAFRSdovE94y3kFV24+P6M1zVOnzcnQlZF2np4Y7hfT?=
 =?us-ascii?Q?rNCdsnSaqycSnBcnuBhdYAvEpFBUxmCIjREHb9GymP2pdYlrvIf5xYoW41i+?=
 =?us-ascii?Q?/ViDyXNBiBtZv+l1a3Rz4XHq/YjVKBwkc7Kf/SfWYswcxM4HORDVpKKeGIOj?=
 =?us-ascii?Q?hCYYlIxqvMvcyO69UQS63uxsb+MbsmX/gmmCqhQda78arWAIp3Ai1vHRhGZh?=
 =?us-ascii?Q?c6yh0GkNyf23nRCMdKyqIfYIHgo/Wvl7a5xtw19nPze+Em7zXVw9CxPIG3Z8?=
 =?us-ascii?Q?Q7DJl7vo2KL677FAWk0wYWbT2QwuYMinlnFkIFqM82R9+yLhhBATuFxLGDXF?=
 =?us-ascii?Q?JkcWt68NKo0+VqD86Cdl3bhrn2MAdtNVBuI7KNRfaByuiyBTyV0iqglKRynq?=
 =?us-ascii?Q?NtquiZ3kClBJSqf0+CY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82afd8ea-acfa-4125-b813-08dd1ded1708
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:17:08.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeUpYeP3U0dlmSrb93AU2/QCiesfV3YzEiODTXBzA1hLpZJDk2oJguqHXqkKfRSq9YeFIIN+7Ln/YyuhBYqjSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8529

On Mon, Dec 16, 2024 at 09:58:12AM +0200, Larisa Grigore wrote:
> Clean up dead code. dmamuxs is always 0 when FSL_EDMA_DRV_SPLIT_REG set. So
> it is redundant to check FSL_EDMA_DRV_SPLIT_REG again in the for loop
> because it will never enter for loop.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsl-edma-main.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 2a7d19f51287..9873cce00c68 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -517,10 +517,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
>  		char clkname[32];
>
> -		/* eDMAv3 mux register move to TCD area if ch_mux exist */
> -		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
> -			break;
> -
>  		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
>  								      1 + i);
>  		if (IS_ERR(fsl_edma->muxbase[i])) {
> --
> 2.47.0
>

