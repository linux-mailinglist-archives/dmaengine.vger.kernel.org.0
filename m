Return-Path: <dmaengine+bounces-6365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A763B42402
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 16:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A183BD0CD
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB79220F5E;
	Wed,  3 Sep 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BpCpmjTi"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AE20A5DD;
	Wed,  3 Sep 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910974; cv=fail; b=Hsn/3bXrY9BhBE41pBFxfrcL+L0dwoVYwcnlHXodAla+oi+6tz96q0JYgloWp2AU99VnSHLjb4DUB6ovsiG9YXQSm0xA1dAIJO1PCV6JvGXsHSgYeba+z1nCke2I7XyIoD9kmQF6D3xB2aVU8RvIepezd00MmP9lj6r9r6v5XYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910974; c=relaxed/simple;
	bh=RIZa+QZbjnjwsz6IoX/RD6HlLtto2ici0t1CC1hEPWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d7U16ggBpKn5K9cfiRAjARAGbG5H88FqJ1OhZMAzHbWwyB7hDaOx373xGZJ6Zmx7AOmdNXGPFlzPBryjFdlMcmB1UP8m5goRMpRtTk4doyg51Rp93k8XbchCRPYMX80eJl35qnm3UUAEixpysAbPJGrS8PO29SygcFlQH4oM+Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BpCpmjTi; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kClNajcLpvqcNWNuta9pU7Izo0dRkr68Y/Mzg1FpKC6unwqXlMUQT6mc6oa9t7otGcy5sBUKqhjTLaLAxxYablCHROlfjJ2ImbL6XcLuXsTPhbGbpBUBgeDBi2WQn2iLQM0Wyz49aRKiPDvARky0V8dGgoEw6X2QcYpbeW8hNw3cUqDchDYWDnI2hfUZdkzTJWlvAMFxINdAJh14kLasJrzrjWgPUxwwMys4WNP146uSPdZrtXtKYoLtWXGcf2Y0MWaQIiQfwk0N2WK1rk+6ayQSoaMDiGImD48zeDFD/wMMK3uDpQZwituSx4w1JA4EV1+AcdvSGJrPQQ8TKJZSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plnbngCPUVbYWa1BsicwezENb9/v5bfu3F4Am6tRHlw=;
 b=hprHP7kV1q/+xpGbwuBd5HwxFZhLwkKjy6KSXsvze7hYm3vbaXNR3If26D//Wn1Eog/zNrI4B+11CDAhNb1iSXYb6qSxbaY5qIe1RF0zKb9FEKlWWD3w+uolMNrym3Rx+rcVOV01sWUD7Q56TdEo8Tzu61yU120MXoOQiYGxKbKmtKKWJ54zSUyWPQxCTW74pJZMfOpSSVaz8O5hehXugnFf6GMl6W1ODQDGjQqesnKHeUMrKp1vbe7QLNjrLAeU+Di6q4oMo3BQ2YMZJ/ohnYlkiEXE9VQhA51fUj4WqeWamGkCxP0YWFuDnmfGu2vG8nUx9Z5rBQ7OH2dQm2KXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plnbngCPUVbYWa1BsicwezENb9/v5bfu3F4Am6tRHlw=;
 b=BpCpmjTihT2y/6vocxSVO19pRdp5x6xQqgZEF89cS3WeNO9rdC9NUAHiRqrx8wzmsGTdEJXgMj8AnwCzSM5iDSwwFOh9Sh2iZLCzSYM9xKnyHy+/UctY1jVUDaliU02S5pUIITZjRK1t/cFa8JDzXpe4sHSfOVbU0OmUYqbo5rwLlJlD+q9E3j6avwumNJ41MkgoancOejj4nGL1gyAwMsifeYbgJWqaFcqMNzuexYsFVVa1981wk65fQJDWrZY+r1BxGD/hfJaX4PXXKZq0hYZHV55xWvgMLxL3U74DAiOMYe8eyXm5EdI+1T2fEpGbZqbqon5jQQmcNo6AXjIPRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 14:49:30 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:49:30 +0000
Date: Wed, 3 Sep 2025 10:48:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] dmaengine: imx-sdma: drop legacy device_node np
 check
Message-ID: <aLhVW2xkjer5SEkZ@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-1-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-1-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e99a3b-8b95-4e74-2d40-08ddeaf9098d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXGYfWEYgKTitcm2xPP2Kg4qy/0QiWmJjAf3+Xh1OzYNCG6O83tNX+keXGeE?=
 =?us-ascii?Q?vB+vEQ0tWTHwx//Khc33azFlBYBXgRQVXhbxRFz8BMm4M8n3OniNgyMRk8iM?=
 =?us-ascii?Q?K3zo3ayewA46KGY8g068oBM1flsxsEemRT6zF9UmBelX165AAhPpssFYDSN5?=
 =?us-ascii?Q?ikgGhVqVipuLphE4PTbKqvio1Fa5ZPDXz7I3SdwMm/VFOE15CzwIRpebhKvJ?=
 =?us-ascii?Q?W3fJRY8PM3CibrVHbD9J9n4AXLaqA2aT1msElTnUcziAZv5ls+Fp8hbIqV3E?=
 =?us-ascii?Q?dwuOi1O+/X7WQKJ7P0O0WANPWs/0HaubXahuQMPfezrrwnbJCH/B1hpNjOzR?=
 =?us-ascii?Q?AWRpUWofr2YWPgs08JH5DzD2Nq7eJzfWCORpe+9XMQGnsycV8b9/Ls7ZgkY/?=
 =?us-ascii?Q?hbhTQKq3Egt+40yHdgtCCjo1yYcBWBJ2o8zO8OGx0IlM/SpGTQGXqB8COOnk?=
 =?us-ascii?Q?ybUmh9wH3f+0a8b3MaACWM79mUL2qHKiYRGPhes5Hv14EGr4tJtMUQtD/BGh?=
 =?us-ascii?Q?3+/eyF9xEsl5laKDRfje1DSeQRm5qYNVGlXgm04eMcu06w/sSMFFqRGfhrs4?=
 =?us-ascii?Q?zrjCW51FlQta36StPIbUoB3dUW7GpCZscKSqQZEXC8krEahxhiyH/AjusHWx?=
 =?us-ascii?Q?bSWz0Gim0EKxNBCJa2W936q/g+5rDuhEhwxgTpdeh8IV8jmweP4l/MtEJaDX?=
 =?us-ascii?Q?zPo2kEE0gpAi4dQhT/2QLNA9PxKDftJBAENg6KEnjfZ/v+BS7S9HqpE7g2gb?=
 =?us-ascii?Q?EN/6JmEjsTru1Rhf0CUFtgbLIxDudsudngQ8K/vy9z5lYk7HLI4s1Gh7mr96?=
 =?us-ascii?Q?vrYEHuTuis+VmzgtQPXSLkMW+TqmEokPmloNBtoW3D+3AS73k07U3gB9s8oP?=
 =?us-ascii?Q?VXrfQaLIss4DaHO2LM8qyKz4QrC/nNlBOZq55Qn2v0X6J89R9SBANkyK4t5x?=
 =?us-ascii?Q?sjsHWwz3qJFYFoPJu2zsqEYGWP2CWw3A9vJ5C4sWpsqGB+sdFQQ1H7v8Er5d?=
 =?us-ascii?Q?yVadUYGsrsANM+7fJJt2lRHtQSDb7Vro+UK3rSW67rKo/hXj527UgYP8JXMS?=
 =?us-ascii?Q?a6ZVb8ZvKA0EsuEIFm5khTkoRKWWVH7mmOViJUySrIJKu/eGZdnV6JbpRdis?=
 =?us-ascii?Q?lGVm4Qkvxzr7VN5EPH/6sUweC+tF3KbjXQT+gL0U2YK47x1Z9tHVHzMFH34h?=
 =?us-ascii?Q?o7z4TWfuHo0RvCdtOi16gSNRUo8ZvSh2kl0iFuhv21V0zZxBRAPxhkA48DAF?=
 =?us-ascii?Q?vLmFF5JvMMFPRw8ttsEjQBdkfCUpPMEHjTXJxj7mOCs5OpmgMEGDzHwoFbAw?=
 =?us-ascii?Q?G5uWkHX5LPD30g0DkokaZakyHllNM/WxnIK+eQaf1CR51nEtvYyCYnp0zeUN?=
 =?us-ascii?Q?ra+EGJ2iOWPuaThq5ZS/QgmENtZRZLLXwf4LH/oqIw+NB1iDruLnZy6n4EVb?=
 =?us-ascii?Q?lgqLtuLa/kSFi4X0Y5jMQ74zmPFpqS3PxzZDVaSvKZ4w3/eb4wBEPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sh1EJ4J/b+NBJKUDyL5b/0myVqN4I3CGHaoclKSnO9bmBghT4fLayzw3SxK5?=
 =?us-ascii?Q?5afV8Wxj7hP1LBH4Z0KKbuitjvQ/HIlb5hj0DMl3Nx4TsJC6fgLiCbvoGkHS?=
 =?us-ascii?Q?Zgjzs4FVo6SYufASkEBZEF5PZAbpQqmC1XvvqWuk0VhEYMGYctLIbE23XRs4?=
 =?us-ascii?Q?amnRyWoaLikG2w4XwuAB1hJizg735+33yPkd+nmyYolbnr1q4h822qLWuN/A?=
 =?us-ascii?Q?ON6t7ZHKB2AJwzQ27OrKkZJndh7ooubQ5wU7S8vcXJv3yIJTorMA4+uHsQ1U?=
 =?us-ascii?Q?vZmf3Wp7OVQ50G6vEa41UBe0yG03lTwR1piId2SCYWJ6mhD0iPmprImotJam?=
 =?us-ascii?Q?7stX6HSNmt1bNqh2RtfbxW9TK7JAPsxeTkxhnzm1lljXdnesVsB4rf16wOsf?=
 =?us-ascii?Q?S4pQuLc8810AbI+p7AyNxF4qHc46xC6tFXfl50R3GU4JnkrtvbRzpBX8xzq6?=
 =?us-ascii?Q?IemeMV7dqES0blvV9ZPEwM9iunz1QSPGwogD9Dk+NfAxMYBWLggU6OTgOD2Q?=
 =?us-ascii?Q?amI8sDv7DEodC56W2ZWzKJfpot5qGXTEdLhcrV82f4+Ak0QUImjDt/grkniZ?=
 =?us-ascii?Q?ROEZO32vPR2Szlqg8SLBscjyqyVYvjVR+hc34rbahh+jDcQVb7Lq8zV0HbA2?=
 =?us-ascii?Q?nmh1qKW6fgd96lrZmJuGC4MAy2WoJMKTPo/684INbORclYtC0XBsLFM5SkGQ?=
 =?us-ascii?Q?vhETjyFZc7+0iVyl9i9EgkH4RhhnjNQLasj2kYdbNM73QOh1PWj8XUsG/KJn?=
 =?us-ascii?Q?fNvN9uQv4ApeRhvDbR00bo7x375q5zndTNTj5+NRpuJ3mHcge129bUqUZEbk?=
 =?us-ascii?Q?m8yrJy0o59uea1SkuSo58zN1QxNzd6yDDDI5Jxw5/Tfk86XD8TffhCv8PnD4?=
 =?us-ascii?Q?kXqjtRm84OAZavoyDgxveiNMLtW76yRokwQXOEarvP4tnUtLjqxbFOGtbzHc?=
 =?us-ascii?Q?CvMu7M/yrXmZ05mek+Dk1bTC9jEJkemK79Sa3vUOsTCcAwjieFkx/gnBODad?=
 =?us-ascii?Q?Lvjf7ra3IRth3gI1R6iuaIg5a81ZoTqx7E1CjGPx2VrlV4M8MA72H0trh0cD?=
 =?us-ascii?Q?8wLXyInLLxaOdgNvW0tKQrKp/YMQ3fi8mj8c0+m9ZtUN4Js4jyu4DJBRlpWp?=
 =?us-ascii?Q?SOcCD8eEu50SVxZJD7xOw4T2Xf3xxBe+e6EgFxN/6otl/wYtTNdnrYHyeXbP?=
 =?us-ascii?Q?NrwYRb70nuJpAS70rRqXzLRhgRTB/66ymbE8RodiM6ZQtulUGwQo732utNDR?=
 =?us-ascii?Q?tnomC/OLJDl1wYKpJO+wtM/TVWPYPrs1qbZE2mMQk4etDqvTd2ttUIPTt/gw?=
 =?us-ascii?Q?mtyQYzK5kf/xpnWqR0+NGl85HHNNU1H6+aLmTCV7BzgB8gzmWwMI631qpq1L?=
 =?us-ascii?Q?/AmEfaZ+WaEkCNXUR9JBvas7vefun0fKISAa6SqneYjU/UEIJ9ZE10P/6Uzu?=
 =?us-ascii?Q?0keP6iGzADtHUzVcZEv3k0KKVve9fCUuNFUOvFCdcUbWjqBYRRojY+9N6Z/X?=
 =?us-ascii?Q?PQ/wVyo95bMNV8YPVU9iDpdDEMbW37r6AehYvmRCpt5ZAWj+CmzKJgWXVeMm?=
 =?us-ascii?Q?0Gg1xl5bm7VOgRa1KBRfwxp872AoKc806g+GTG53?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e99a3b-8b95-4e74-2d40-08ddeaf9098d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:49:30.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkbLsJ7oA7muMXPeu56DYW4ywtgPXDwyMnihngOQsrkLDtyfalbvjmWMgwvbk7bb6I7Q/ggg+Q1xA1tlpl9zyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422

On Wed, Sep 03, 2025 at 03:06:09PM +0200, Marco Felsch wrote:
> The legacy 'if (np)' was required in past where we had pdata and dt.
> Nowadays the driver binds only to dt platforms. So using a new kernel
> but still use pdata is not possible, therefore we can drop the legacy
> 'if' code path.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/imx-sdma.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 02a85d6f1bea2df7d355858094c0c0b0bd07148e..89b4b1266726a9c8a552dc48670825ae00717e1c 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2325,11 +2325,9 @@ static int sdma_probe(struct platform_device *pdev)
>  			vchan_init(&sdmac->vc, &sdma->dma_device);
>  	}
>
> -	if (np) {
> -		sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
> -		if (sdma->iram_pool)
> -			dev_info(&pdev->dev, "alloc bd from iram.\n");
> -	}
> +	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
> +	if (sdma->iram_pool)
> +		dev_info(&pdev->dev, "alloc bd from iram.\n");
>
>  	ret = sdma_init(sdma);
>  	if (ret)
> @@ -2369,21 +2367,19 @@ static int sdma_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>
> -	if (np) {
> -		ret = of_dma_controller_register(np, sdma_xlate, sdma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to register controller\n");
> -			goto err_register;
> -		}
> +	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register controller\n");
> +		goto err_register;
> +	}
>
> -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> -		ret = of_address_to_resource(spba_bus, 0, &spba_res);
> -		if (!ret) {
> -			sdma->spba_start_addr = spba_res.start;
> -			sdma->spba_end_addr = spba_res.end;
> -		}
> -		of_node_put(spba_bus);
> +	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> +	ret = of_address_to_resource(spba_bus, 0, &spba_res);
> +	if (!ret) {
> +		sdma->spba_start_addr = spba_res.start;
> +		sdma->spba_end_addr = spba_res.end;
>  	}
> +	of_node_put(spba_bus);
>
>  	/*
>  	 * Because that device tree does not encode ROM script address,
>
> --
> 2.47.2
>

