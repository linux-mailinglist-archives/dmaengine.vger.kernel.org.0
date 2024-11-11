Return-Path: <dmaengine+bounces-3710-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8619C4270
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 17:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC130B26C16
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CC719D093;
	Mon, 11 Nov 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BXOVqEd9"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51812CD8B;
	Mon, 11 Nov 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341735; cv=fail; b=ATDU237vZZSpfgw94OBX4MKpAAWTHRHlJcAloa6lqSF30IpmPP6d+eMSnQXhyKxHChTVxBbiD7edVnUjsU7swrP4JvFqJqdPcc82oGR7P3QtI+tg2Yome/AasWOBohXmKwJ6S2Jg+MIQbhJ7MTJeyFh+YHQRleOVpv3WNxHfrNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341735; c=relaxed/simple;
	bh=oBnWtXfAUtOhZNZ28jZhxJgW2vbxuTFFOcpTBVtHT58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/sIfT2ElDx/A9BZzxbIQGwjMei/UuSfZhen2FoBZKsCdE5pvB58Jtu8PwPdbdj49wXVS1dfbjwNt9RIRjfjxR3e3EaZPYw0VYmMHq041TuuoNMf0kUzb/d9/uMpDpZa59e4v4jGfMCfLfp5ZZ/XSLzmNYmsf3eBwJSI6Oa7Te0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BXOVqEd9; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSK7fNPA4Oz6CFCPmrNce+Nid///cwKnm3F1/IuKCANU/Yq+IyxTpO/cp8Df3JvG69KsL0LB0dAKz5krBVNCd5G2K+gbVaRI4mbRflYFdwjxZWapeqV8WSzl658ojOlDgtIBRn/+LKL+mXqA5o+4MAEC2L1IPITeHKs3fsaIrKlS9G2jhCgCAPJ2xWKBvnFWRUfeQqRtVLTvEy4AAK7YGLPdXS/L9Bjba4azqqXRYVYNmYv3cBP1hsAX7Q3HS/Z+pE8uyfaZzdZTnv381yX4FhKC0PIFmX0e0RcmvXj5aGANO8dMsbTzOqZOSVahg4Fk/6inOP4FxXs3YyK2eXnbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhWu8/sAeh7hAT46B6BCnTDrjbFeekuZSJ3a2tjhMDM=;
 b=KkblJx+gliIrv4Q1P9RqoEUeMawQCPZCscXoEvmYNGa/jTMmgIUWywFhLl/3KHwdy0XSqKinBoE1KS1G2HdD9w6XHxowbxGGYaXf3ykeXjEcwwnvUWQWYDhYKKu5ZwlgR3B8RygXxlQdmKzaana8bC5bjTUgEOwH4a6Vued/Xk0k7P9Lk4muArBBpbnktIHbTm5eKRIflgAUfSKQlKqAjPGke5TbqJoK7skXIPv1KGp/Ka5R6e7a9cHeZrbj/F1OgyjKfNljqA5adzWJsn3fDmkFWYimDGBzQRQUDVYe+JDoh4dRPMFcLVEgz98Mn+tlfaVhFDcR81bLat3IyEnsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhWu8/sAeh7hAT46B6BCnTDrjbFeekuZSJ3a2tjhMDM=;
 b=BXOVqEd9KujCCxR3FwMc1y1WA5G1OscIPzeRDaQ/PDVPjdEg45q0byx0ErXD6rrA2C3E9iVJ+2u+NC4HATKYVK5VQLWAxnwFxfe7AWPGGPf3Y43QCf9UTHDGOBeznRi+ymAenXLMShgG4iUmlUBUahgAmFs2bAs1H6bv/1WYdYg7ct34BUVMyxzjLpEh9HiX+mnjG3VfnvX07CW090wAw01mCA9FAvGSp/Cuw5A2Xxcg4VpCgUVKeiHThdwR3XMjzb3GBnKvVswS1cpgLYzt2J0zql6des4FpFQUGTJf9gcLkIGEy5d1ad1dsrsXDsyGmhUD1NY3jhzcIBIvwvA1zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB10873.eurprd04.prod.outlook.com (2603:10a6:150:224::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 16:15:30 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:15:30 +0000
Date: Mon, 11 Nov 2024 11:15:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/2] dmaengine: fsl-edma: free irq correctly in remove
 pathy
Message-ID: <ZzItm7l9pGfrUSK8@lizhi-Precision-Tower-5810>
References: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
 <20241111072602.1179457-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111072602.1179457-2-peng.fan@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB10873:EE_
X-MS-Office365-Filtering-Correlation-Id: 8caee65b-2c61-4c63-ee46-08dd026c0fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GLgQ3veW+m9RZZyak2B+ABopdAthsUHgaEqaG8tyK0xMZ+mXlJwRWo3eyNZX?=
 =?us-ascii?Q?dBzKa36ZDbt3pWvIx0nSFfPf2D61jfoClGpDLadQm+V+5dy8owa33eadP5lM?=
 =?us-ascii?Q?XVsoZPMAaS6FVN6+3l8AxQ1OrOWmKh7yHw29WQ5rzx1nWagbPQTPKGnpMFOl?=
 =?us-ascii?Q?IqLZjL0h54xhhGd7UEWpdwRvJIgUIEQbW2pZRn81ih9fNLQgDzUvqTLFK8lo?=
 =?us-ascii?Q?EWaWGVnGwhxv1tFHAjgUnRlbIVXNFmSlcZYev+xw1gYWC5uWZwz0Bh/sKUks?=
 =?us-ascii?Q?XUsQ19wYHAdbkmPNsayDQInZRgHeVjsbCDa+XS+WLP/z9bqGcT/h0WbUA9kI?=
 =?us-ascii?Q?WGdAk4G3/fEV91T+bTO2LDQzv/M78Tgwh9niMNilB5YTyKKSHViKM9tUpK8t?=
 =?us-ascii?Q?Qr34H8eK/FP3QNAU8FnBJC/2f2Cw5cnD2O7V3mA3UO+YqHKYL6wvI3lw1344?=
 =?us-ascii?Q?s9bxgfs868JZWc57GMQfJgG7Q7APgvG/vXG2FscWSLpm3Bjew20wYxT0Pz9E?=
 =?us-ascii?Q?YU3RONn9SdO31AFvCjPgA5jQKK2Vr3HshN2mNcC/y1oE+GyhwEujI+oWKTkV?=
 =?us-ascii?Q?k1evjaMFitvc48mL6BMgxmb2A9HjFCN3rjWQevoGEFxThYh/jv/VaeouFYoV?=
 =?us-ascii?Q?h5IB0xWgSKn9RKlL8ZNVdRTXykFZMOFpCocXMLnOxR3hAAKN6QoIEwkXIle8?=
 =?us-ascii?Q?VSho443zP7l4K/Rh4ObS3FvAQe3d50bweExTdoMtRUkOXQLrbtAKtrXjqE5b?=
 =?us-ascii?Q?HR3CSWr7/ssfXCRgvi3MRNBiGOy6FmvWz9hxHksFygzvUnD1l30TpYShgp1g?=
 =?us-ascii?Q?Wp5DLLzBSoTtXN+wmMKK8JNoSMz5h4s9XT8LCRm8ihVOU8FYXoqjRQobkW8p?=
 =?us-ascii?Q?nAXD3CML3HihoimhczWGKIem8cDVQgyC1aM7lCxeLVujE2mtdmmCz0hfL0wO?=
 =?us-ascii?Q?U87xuBT+rud2Fko/9FsbhRVSk4S2qMVXjl/LcUGBHrUL7dIqhd6mM8PbEiRz?=
 =?us-ascii?Q?8vXICrx91edY0jdOSFEky330pDgUPlwsXA5sfO0vkdPlvRJm81Md6Thg1bVV?=
 =?us-ascii?Q?NvA4wYTT8OgFuX8oX+d8qARA3LCONlSoGgBsADZxMp3GsYmgoz20j+g9vuch?=
 =?us-ascii?Q?pyDBaLlMBe1Kk1yAslhmkKfwwfZsqXVHFXQdYgSUlA1VAftTJNb1A8AAwfyf?=
 =?us-ascii?Q?gc1FBbf/OJwtEwitePc9jiPuBCZStahWZIdyelEfrR83jZcefckdn4vrpdQf?=
 =?us-ascii?Q?i6yb8hgXO4OXYJYxSPn3SUke2wDA79x2c238EuvZNoqC1U5Mm5qA75EcXvFI?=
 =?us-ascii?Q?V96OgewxVdFwnRe3bEK0qko+w6A5RZHv29GVAWS1sBf7hmslCQhcySSobEUz?=
 =?us-ascii?Q?efpEkxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0AQoOxxNZOmRDO2J+7dwwoNi0g8rrMQWQk54WSkN2IMYd82t7TY2MJsJ6+9?=
 =?us-ascii?Q?dI3nPpvZrVSzRN7G8oPIfQ9lE/vMqWejqki8zLFCGOtrEYms5i6hs9cvE9QY?=
 =?us-ascii?Q?EpHcK7cS42xW1wQNSLk2YC0zXf7vX8kg6DlnRmUhGLrQw5vtVn8kz69GO3hH?=
 =?us-ascii?Q?xs2FuLuix+lhqYNKSmdr5jmcGJzabgT2j5B+yo5XUXC6Orz5PsOGzXiytRHl?=
 =?us-ascii?Q?BgNqQ3Hwg1DZAMlgefOzm6oTSxahVgBdrFne0+99GxJrBwc4zeu3UwWjFOsq?=
 =?us-ascii?Q?OriyurVNUvgo3DhXX8KyNgALPRGHHz1p7MFdKt5fdacZhPEb9w+IKDaenX9W?=
 =?us-ascii?Q?CIW4bgA9gkIXQMgOXXvfRN8daxDvOgvtPrTFxYGg1kOhqq1eREkU7L3DLjWe?=
 =?us-ascii?Q?lQbvy274gJX6DYyQhK9cC7t8pKR1ldWvgfZ7ELX7ZkZ1DEIHGP0laWyZ0t+p?=
 =?us-ascii?Q?1J2obkYPQukji1fWovjqcv8Ooe8MwLhbX7vPvOfo/oDx9QIfb/G0bOVc5nL1?=
 =?us-ascii?Q?vMPCp3SvtQOnALeHH6XwO/nEWbF4DTdKhqe9kQlq5vYU0D1PHAnklbTHJMm5?=
 =?us-ascii?Q?bXt6kGKua3NNCAcDVfa+79cvLoxcP0TAAmavLAfUQKALmLMLKcFN3Jg8VhE+?=
 =?us-ascii?Q?UU4wPynwEsD6jKK11TBBuImlxLRG4tkWOC0bouxhfoyUGDepXZy54uPbg/k9?=
 =?us-ascii?Q?uZF/dMXewXR122yzzS2OOfMdTjJldJjRzZiOQlkVSp/Rm3RCWF4J/ZQvfZzJ?=
 =?us-ascii?Q?cj3OhTZk309mTzewGXKCHLUb+a5gx1nuLWHby8BVICTKBRbVejt6ud4DSI+o?=
 =?us-ascii?Q?NnbKjeK/JiloZZFgru5hY1pLLlX82qT6SMJHdYYl6eF47udaWfTlO1e43wd6?=
 =?us-ascii?Q?pIuFFs+vLQo/uZYwmhG6ln01JwwfTENu4H9Bcf0OS8ZxaVpQYwJB/AVjtc7F?=
 =?us-ascii?Q?ePh/UV1yO1aWst28KlBEs2nLrr5NQfw9WvoV7iHQqJSQpo9qUhSTUBAnX2bZ?=
 =?us-ascii?Q?ahDCixig7nUUPuM42TE/sW8qr7w/OSEsmcmOnpCpVdyw51yLBhjBUtGCM9N9?=
 =?us-ascii?Q?h4kgItvpw0F7xDI5f+3d0YoRp7+FETeqN4repoD6AjA9IBH62rbwqsKyX9No?=
 =?us-ascii?Q?9z9/FKiqGywutcWv2wjTmB3UetNxuxrgrdCdkjwFZeqyk8RSqwFqfocvs5xJ?=
 =?us-ascii?Q?IVjIL4t5inKMkL4HnXfbNmNFYx7VBrRONKcVs3IAHzAcPl1AaHWb3Y2QzF4z?=
 =?us-ascii?Q?gjmEJ5W+Ii3dGpAcYbQ/mImXAY9gPav72Z1Mrj5FAOBVVZu7C8jtj17FMJfu?=
 =?us-ascii?Q?hjV9J+ZLbwxSRTxdCaNq8pqJ7OS4zz/bQaUK7Idg1NpZ87bxWuGXW55CRhh7?=
 =?us-ascii?Q?kNi0jZ5s5DzkFA2k5OYhvHlnPjG1d+P1ei6wAwHzc0ywltNVogTRZcizaTjR?=
 =?us-ascii?Q?j97lXl6NOKol1HAo3VQpPQZKetDi0iv2Fqfuxs7VeAlpsaArP2ge4NjVqHUS?=
 =?us-ascii?Q?y+AGs1sUzvBfuZ9MyRF+pnW/Yb0J18IDf1YWokxu5fXchtQHy0ux+oCAc8sY?=
 =?us-ascii?Q?ZKghDr8rOBABQTmrHJbi2vDJ/TRSLVE69LJANtPL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caee65b-2c61-4c63-ee46-08dd026c0fdc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 16:15:30.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0hM9bCYG8QbfY35T+t6vOODmSDAUcU0ehxf/6UKPb7wLjg6NOl3gBOdIbzESLL1nPA1KM4UIuZ2gpFpMjYwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10873

On Mon, Nov 11, 2024 at 03:26:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> fsl_edma_irq_exit to avoid issues.

Nik: can you add descript about what's issues?

>
> Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  None
>
>  drivers/dma/fsl-edma-main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 01bd5cb24a49..89c54eeb4925 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
>
>  		/* The last IRQ is for eDMA err */
>  		if (i == count - 1) {
> +			fsl_edma->errirq = irq;
>  			ret = devm_request_irq(&pdev->dev, irq,
>  						fsl_edma_err_handler,
>  						0, "eDMA2-ERR", fsl_edma);
> @@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
>  		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
>  {
>  	if (fsl_edma->txirq == fsl_edma->errirq) {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> +		if (fsl_edma->txirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
>  	} else {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> -		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
> +		if (fsl_edma->txirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> +		if (fsl_edma->errirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
>  	}
>  }
>
> @@ -485,6 +489,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	if (!fsl_edma)
>  		return -ENOMEM;
>
> +	fsl_edma->errirq = -EINVAL;
> +	fsl_edma->txirq = -EINVAL;
>  	fsl_edma->drvdata = drvdata;
>  	fsl_edma->n_chans = chans;
>  	mutex_init(&fsl_edma->fsl_edma_mutex);
> --
> 2.37.1
>

