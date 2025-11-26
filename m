Return-Path: <dmaengine+bounces-7362-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B09D3C8AE3E
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A46ED347266
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BF33DEE1;
	Wed, 26 Nov 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UOVB/L33"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042733C538;
	Wed, 26 Nov 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173675; cv=fail; b=FrTj1DKOTiBIrdVkulG2dxdmRBt05bd0uE0RidJqjjsZlvydow9kDf1aKHUI+FOZ/VPLW3v7tvSnCFYTvm4qSndF4RLRS/vSaWaTvy345NvjPSdSbMfNH+46Vo8K9oLQMsxaVRKBszpnIE0ZsyfZQF0/in5l3MUt0GZcRPGXCCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173675; c=relaxed/simple;
	bh=7pVt1roxN8YQrmaNtW+6Gp72W//fXPtFID2usrNVHnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=In1CbB3DNyJ+G9zQsvtL/yk1T2obVjWIXcIN42u6rHqrB1pL4q6QwoK7erzFQ3vWjguamlOYR3QmRkWXG++MlCeXwimp8dHDSNpfvQi8OxwilsCHAhOjyD127XEWN0NoVB4501gzdHusoxDvEyjgy//P3uaVJ+zWrPJi30Wb1Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UOVB/L33; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZxjpsbII5RQoqzdgmu5prYhQxdXa5LTORBBay3e9MhFE9wrK4e2TXR/ARjTnQrlsA72RlO3bxKjxxsA1vshgS56yg8S3u2bPvl7HVCs6Q0yYQs20MDy/vy3a7dyWc/8eFVutB5KdGexbe0wLLSadaHy7/OuWGKGJMFnd5xKwHYXN/SABnK29+syXmmw/ckAG6+9+QlExJq8Qa2lDJPbP3NS5OImGPnJ12o/OOHkhODQOABUki190zSYwLPabJ2zVOLFVssnlxQY0JEJgoAQowKJK7OGdRw1VRkMCWG700AbtLtlsJ11xFxf2GXzt6tws31d0NAuOPi+sJIB9t1PPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rv2n5g54xqtYjz8ZaXwCfro2DboHiZMJMNsT3A7Nh8=;
 b=Mv6U0V5cqHd5fXkrkQTRGZFCp5JhuU6EcA2v7f3To+HerDnGEgQmmfqE4/eE1SfxSId8Oa1F3mJamoyYe2mDgWZ6xquVJM5yS8VxxxGBmHz+mc6bdbZOmP1yMxYPYCv+xJuaezw+pGsRb6Wikq6GYPhneSezErMbj954tulXsbVQ6HGFnTysu2iS29EU6sQ4iF+64SIsENxnnEpio56U1HyVG+RXx4W0ZSPE2x8cSPWjByQrSGI58dAevuRo9v21tnEdAEtETavzO5BNCodcc8CT3RRm8hrPSE2xTNWxK6sqbOeEo5n/Y4OemImqy+7zRQM2crb2JmfJHEZq+g+vdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rv2n5g54xqtYjz8ZaXwCfro2DboHiZMJMNsT3A7Nh8=;
 b=UOVB/L33tPyIeSxGU+L6ltOUbW8/jf6G8N+JX2V/DG9S2ugafIRUKmB8n95wJmkdNRRyusYcIzCa/JmebyW7FPKmmd7jqgz765U3dBSjwKMWwtnQtk1CCIirW6U5SH79DPkNXNMCaVYBzCl6RdzY1Ek25DDCBhA6JYlo0D/F2Y8YLYzzjr/t4VMC/R9K313izvvNrme4kQVT2dVt9j7UpRGmNgtYULnxNrzKHN30MiNfTzElANMcpbxPz8//hJuH9BKFtAHdk4nyWVt5Zzvzg12XFBJVGKmOTbnwStSwfkJvwAwGiMW6NvZJ+k6ORMK30BBRP0AF0p3ZSpclhhDVQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 16:14:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 16:14:29 +0000
Date: Wed, 26 Nov 2025 11:14:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: jeanmichel.hautbois@yoseli.org
Cc: Vinod Koul <vkoul@kernel.org>, Angelo Dureghello <angelo@sysam.it>,
	Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dma: mcf-edma: Fix error handler for all 64 DMA
 channels
Message-ID: <aScnXpTHSpism78j@lizhi-Precision-Tower-5810>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
 <20251126-dma-coldfire-v2-5-5b1e4544d609@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-dma-coldfire-v2-5-5b1e4544d609@yoseli.org>
X-ClientProxiedBy: PH8PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::16) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce349e4-06ae-42e4-e026-08de2d06e07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VD3vwFUXCHZJ5XvrNNIilbfWYngS+so2tO7xtBkbENv4RyQyjTblGCEumqnY?=
 =?us-ascii?Q?EpqDap4itiaRxTbD0Wt/FJxxqqmFFhPJnCkeJKUS+hAdO4zYLFubkvNgy0/o?=
 =?us-ascii?Q?TGlAUNvm0tih+69CZ0qen/Ctqkv2yOQioZN6MEztIuXjvSjJ802CM2bw8PpJ?=
 =?us-ascii?Q?yXJzEzNBNO7C4TUhVzqRtsRX7uuiwogaH9zn/1lr0J6axsSX4CLwJxCezdL0?=
 =?us-ascii?Q?WFBCo8UIyf0UiZil+Veha27LT0JjrObBAQMTD75rMZ86f4+SbMEw7CjZNuNN?=
 =?us-ascii?Q?w1LYg5JIitxCiMtGeCZCmFi1hWz9zHWRQcbnXP79lpJjqe4EaTYWgyvXoKIx?=
 =?us-ascii?Q?1A77o61g8FAYgwRl8HrnJ9VJPtBbM2Sav8998p6XEt6SrkQTXBxdwNDFkUCT?=
 =?us-ascii?Q?5DmYKmw7c3pXfkYcVj4j5t67V+QrfwpoanGoMPgDJFRZTjxmTCs1qGpiCTkN?=
 =?us-ascii?Q?7GtjCCoOEA/ZGc0FOD8BtfRgE66xjqNMQMygEIM8asEzYT9bf8JPRDECDq7C?=
 =?us-ascii?Q?Nc3bsoldDA7mTszmYSz5GfU8fQolGvOrXLOX6j8jQgIyK6Jv3a0HpVnNRHYc?=
 =?us-ascii?Q?QMqoS3xHV3pRzFUmElvaDCz3n71q0HEBRFXgbRxcdlG9sRZM+/xoUgOVEIPo?=
 =?us-ascii?Q?R3FAzI9NXh+sDW/Jn1CdlGGJCORfz2nf6DxGITLFL5/2hph3KofZJ7WJg6t8?=
 =?us-ascii?Q?JG3uKKjepLpxw7VFueLgnMRRh435nXzZNzoAyACye2SsrKJ91W7IiDVxGMOn?=
 =?us-ascii?Q?HBygL1/wWwE57IULjgReEnNwcOTTWmbvjUmEJqFCr5rAiM4Bb91jhVBjgQU2?=
 =?us-ascii?Q?B0czLqJh+RcBEdCaEA4rfMpOAD4ZMRmm1wg/RfJ/5AgpyiE1BXT49rEAKQuT?=
 =?us-ascii?Q?EpqGShgeh5+b1k7f4+2ERzWETFNzU0pO6XCejE2G30wlZwWxQ4QQsT20tAVP?=
 =?us-ascii?Q?hYyhyFghyjpLiW3SLDVksPrdTM/djQtKof6djOkrAFqcKV/QmsB6r4tTVZb4?=
 =?us-ascii?Q?BaiHif8pzFccx74IMeWwUdZrZ6rv7XLMT7uxfu/mMvfVHUtBp1v0LBgkqO3L?=
 =?us-ascii?Q?2bKAAGp6D5PHWTxbwDe/jwJgMmTssye6gCwl2dRmoMQB+7sd1LyWTfTzTDf6?=
 =?us-ascii?Q?LTxL/0Mjmiv0frzGsDSVEcaAEQJkJD965i6sYeM94CEDnpRcAQrQwFDghZg3?=
 =?us-ascii?Q?myvEIW2vTgIbmQtZwt23K3F+sz/WQ7naFOaX3Js7rs7sXK2u4/r2wlMptzjO?=
 =?us-ascii?Q?AYvESL7eA8112aJFUDzxfzDNaanCly3LI9oXaLMC6h2O3HalUumRi4RAJDIk?=
 =?us-ascii?Q?/cWXpVpselkAkAJWymxqjVhgYDnuIM4t29bJ4DV4i014qwfEPGVMHmC01MvT?=
 =?us-ascii?Q?N/ZrfduIlnuDB9mux5VTRAXiSr9fPlAtgqFPbxVqG01qr8F39Z5YFKQyK0lE?=
 =?us-ascii?Q?riQ/uRNZfJB6i6kA3t++rsFTDPtXi8AVt8Nh4lBwrGEvppsm0SwS/jmIpLMx?=
 =?us-ascii?Q?b/5NfhHve3t7HB5pT60ZzAgNw3N5tpiKzfer?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TSZd/EA4+emziPh5QYbhWklLroADT3qfPsOkgsSY9jwW0cnWhOR/X+vFZ4wZ?=
 =?us-ascii?Q?yNufD1SZWsEUNdZue8vfL1OJzQnuu80aUyEqrd1j11QtaoYU+bp1tUKmkU6W?=
 =?us-ascii?Q?lDsqSuIp2aay25JEHDmKcJeZ3FjhDAp3IyC1xU/ytJCHasNZbYjoVBEhQLbD?=
 =?us-ascii?Q?0KnSPAvdRI3LFQVpRr++4EwzE/6i0Ya0xO4pzVqfCPVvzqzxbon3tbrmaaYF?=
 =?us-ascii?Q?5YTOibXjnLLIhDfcIny8StqeaWHjunzEZKVh8t/okxTRdgwFud8FafzQC2c2?=
 =?us-ascii?Q?B2+rB7uof7YDb5kl2hBzNG2CV8hgrZYPlC2AX/hToy3RLUB+aAW9lc9VFklj?=
 =?us-ascii?Q?Pn/4p5lhHXQTXT6w5NjRew16hX7RvHSjK+cIDrsn6PBGzpsVG9QfxSa3uBUt?=
 =?us-ascii?Q?pOVc5rze87zbt4GZKRUAEwEOTvP9GnuRK/94KPxaV3fXAZXNPPy+MzjunmJ5?=
 =?us-ascii?Q?ufla0kdZU9pGdP1SKy5h+C5lx/wCluLnUPn6C2BTCKDRLz3rIURY6WBoS1ky?=
 =?us-ascii?Q?phv+u3yxG94jGayC2EOQ0VFjvukhgHjwWj7EFTEiDOcZERsHhvYCr8A4Szwz?=
 =?us-ascii?Q?QByI8K1zcbmifkBdmjxSrp+o8ylfzsc4e6cTqd5Xd3QpoSuhzgCznuKazCUB?=
 =?us-ascii?Q?LF4Ex78dEaKdGO70PkgehzEXPiPcEvNYx03XgsLNp1miVr8ni37LB9I+XyGZ?=
 =?us-ascii?Q?fb7zFh+qwhCSvxliR2COVayo1Bkh7DSBo0X1OfGHUGyZ0jBKFAA10DqZdeMG?=
 =?us-ascii?Q?We4z1MbzXfI/6+7JmsTqhGzIaYYRl8zmTkO/2puP/MQjGWnlArbjNoeFZ2Ve?=
 =?us-ascii?Q?pGopwVuXjDyPT83zQG0KAT8ZxmXe01WidxH28TINmN4s6RCYRHUOJH4ulwiH?=
 =?us-ascii?Q?SLmJbGMXdMOhXlHBX6YBZaIuKMj3KI3QZ5RW6nMnOStC13EkmQeRYF8IJsLp?=
 =?us-ascii?Q?niKLU0uC77HscrfjXXFmeYZV24gRbf11h3KHFNG9WuoTHB2ESC7/Pwbb4cqk?=
 =?us-ascii?Q?a5pEgcgWnNMnVeSfHXIcMyWakcHVQmuVGvqI3i7WkX/XIeFvc6BgMu/u7cNx?=
 =?us-ascii?Q?MUvA4pAXsU9yyjvRZSuATS7i6giVI6lTDyqDXvOFANzDr/YRjP0W3nvAeKfq?=
 =?us-ascii?Q?NDZgE20QsYLlwiGsDvJRYVuHQhQQ8kbQKSzm26jN5aH/3A2/Ltt4Pr3zUfNg?=
 =?us-ascii?Q?U0oy2wBzcgi5wMATy/poy6eP8tj8OAmZrC0oy/iMma+9zSDtyqShx3OfXTE8?=
 =?us-ascii?Q?xFbHwU291KepOy2ChGrEX0lHagsbRWtWbFLsiq/RbolgXqtNstUPMeIhQ2Ez?=
 =?us-ascii?Q?jhTDGVouO5QKquK8c7CPy9nuVCs1aTSnjm/Ywi0c3nxMdOwpsIJXrxPKcnOG?=
 =?us-ascii?Q?Freh9GkDSZgtLQ0bbrjulgrrD/ZjmiK5Uoa80Ohd1RdIffmxnX9JSvTFZ4if?=
 =?us-ascii?Q?yQuISb2ZmnJx5vGqrpGNDPGL8t2v/QeKUVTdJLEjr3Imrgd+cwIGYEpnA4hq?=
 =?us-ascii?Q?/66tyuXSrG7yBpUEugLD91ai+UAtxjD8C+hd5/6GEZ/vm0Yl0zd4ylrq/DAt?=
 =?us-ascii?Q?UTUJ27wY+Js+mbPeIJYSYezluK/YM6wJYnQiT3X+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce349e4-06ae-42e4-e026-08de2d06e07e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 16:14:29.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ED+Tvf5fv7FRUn9OL6qQvduG4xjcjeKhVBLj6aMs/5fceZRvRj1Kgi7Ap1fye4v39ki2KaQ0m1arK7CbPoLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207

On Wed, Nov 26, 2025 at 09:36:06AM +0100, Jean-Michel Hautbois via B4 Relay wrote:
> From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>
> Fix the DMA error interrupt handler to properly handle errors on all
> 64 channels. The previous implementation had several issues:
>
> 1. Returned IRQ_NONE if low channels had no errors, even if high
>    channels did
> 2. Used direct status assignment instead of fsl_edma_err_chan_handler()
>    for high channels
>
> Split the error handling into two separate loops for the low (0-31)
> and high (32-63) channel groups, using for_each_set_bit() for cleaner
> iteration. Both groups now consistently use fsl_edma_err_chan_handler()
> for proper error status reporting.
>
> Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/mcf-edma-main.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 6353303df957..5bd04faa639c 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -12,6 +12,7 @@
>  #include "fsl-edma-common.h"
>
>  #define EDMA_CHANNELS		64
> +#define EDMA_CHANS_PER_REG	(EDMA_CHANNELS / 2)
>  #define EDMA_MASK_CH(x)		((x) & GENMASK(5, 0))
>
>  static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
> @@ -42,33 +43,33 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>  {
>  	struct fsl_edma_engine *mcf_edma = dev_id;
>  	struct edma_regs *regs = &mcf_edma->regs;
> -	unsigned int err, ch;
> +	unsigned int ch;
> +	unsigned long err;
> +	bool handled = false;
>
> +	/* Check low 32 channels (0-31) */
>  	err = ioread32(regs->errl);
> -	if (!err)
> -		return IRQ_NONE;
> -
> -	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
> -		if (err & BIT(ch)) {
> +	if (err) {
> +		handled = true;
> +		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
>  			fsl_edma_disable_request(&mcf_edma->chans[ch]);
>  			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
>  			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
>  		}
>  	}
>
> +	/* Check high 32 channels (32-63) */
>  	err = ioread32(regs->errh);
> -	if (!err)
> -		return IRQ_NONE;
> -
> -	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
> -		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
> -			fsl_edma_disable_request(&mcf_edma->chans[ch]);
> -			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
> -			mcf_edma->chans[ch].status = DMA_ERROR;
> +	if (err) {
> +		handled = true;
> +		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
> +			fsl_edma_disable_request(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
> +			iowrite8(EDMA_CERR_CERR(ch + EDMA_CHANS_PER_REG), regs->cerr);
> +			fsl_edma_err_chan_handler(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
>  		}
>  	}
>
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>
>  static int mcf_edma_irq_init(struct platform_device *pdev,
>
> --
> 2.39.5
>
>

