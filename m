Return-Path: <dmaengine+bounces-6717-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D058ABA09EB
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B34189F9BA
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF0286D60;
	Thu, 25 Sep 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TFBKg7nG"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8D1C75E2;
	Thu, 25 Sep 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817930; cv=fail; b=GmiGjyCrqoqJRGXSp/oQjf66laY8LQGWRlvGZUGJk7UGqVMskoJwTw1KruDQjsoO8qIoXuzpDmNhxJfCd9v4ltM+5zN2UwmqHsjE4nOehBgaZkOVxMwK72rf4gEGNacU8V+P/gbllRWvHWSF4j7ntcd30lDG8CVl4zf9/Esd6bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817930; c=relaxed/simple;
	bh=A0hn8ZPvGO4zQuTmnzzWaJ3e4bupThPXiLxBE9u8v2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sTa0mJqjv41T+86LU1cs5MCF2VpRsDkqP9lpllwj5S3jM6HsB8ts7x5w8pJIdJJq4oTumqAFZJvJ2Qn3e0f5nuwedsz+/EjtFhkMzl32Bp0PxGgPE1/nbY6S84erUVQmgphkaL6rZyo42uKCLs2uDKMTyDXWxQyKb2JyyPhcuY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TFBKg7nG; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3Eb9w/DvXtlUr4CRJSOrhXSQdr1Os1JkmS6pt26Pt9oEo/wQAKKm4UrpE9VS/WWWrYWTU5Yo0RJlxlu1Vbuht7kOwK4hH9UWG6DD5z6nWYLRLxbi8ZPMpW+AQHsotslCSJOnHlHMRJAT1Qz5m0DX3z9VWlBh9b9KoN3v9i3xDci9Mt1CtMCZefDRmr88p7T6f6nWHYCBlnyrTsXmg+Y/4bTtx97seOSRC/wT2T4Z3imAd4iwT6pKVyXaCylQftMBWlgeIC3D7mBlRum8/h9Cq5unopUMLXfaJhhJgqwe5tWCeQyEP4d/ah0Law2GkgDd75rUkRcfNb9/MX58F+rGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BqSmo4oTNSI0rfBFV5F839jJahSqK41aLfSZwO+V8E=;
 b=DmeFj/tkGBfqn/5JTXSdPDIsEITEdZeFbSi2AlL0ulNliUsiSPSVPpFnqehCATVusvLRET/SQhQ17mccl+wj/JQ9SWIFlt5dnj6HpJAtmwz/WkEgKHyzG6GyDXWxsVoquxPy/vWXye1CtDkKBqxB8sEAN08eOim09/0YDCfxDPGJWs03224RKxpp4bVZaX7f9yUPk5zCVlEUCQsmxeveQDeAkxh3ai6PA8LHOzQiCPBOc+jjx3oaHU1MM3afCs5vm3ItZLWZipz3kg7pLNQ+itfIqm2enUGkmsIhDjGjKeFTgE1aiUalLqhkBaNTMAM7o6OeeCeQqqNEZVtFj87Lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BqSmo4oTNSI0rfBFV5F839jJahSqK41aLfSZwO+V8E=;
 b=TFBKg7nGpgn0OKfvt/BACk+QoJCOVDwtgJo4BZl/alldKSLHGI9qY1E8rnWQRKNH1ws+G3SDMfp68jwJntfuCMBxf3QqZkJgMXTRtYbj/byL2rmcnF080LXEXmjbJbT+Z3afRzd2rNaaqYpZOEdd1UaCvin5Ts8AHDj+/tUEZiTOEowiJzclEVnhz8w8LcUi8vJe/89F2o5OdAzV0k+jFMa2w2g4eZRzS9skwUq581J04/E8fib5Gb/D/PZPPqEdYBX5OM9eZUPQdNn7gUUiDxHrajmgImC2WRM9QFqugKosPDTKBJ9AFTOCdcPEh7h0SAPzl7DhiifyJNLPjG1sjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB9220.eurprd04.prod.outlook.com (2603:10a6:102:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:32:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:32:04 +0000
Date: Thu, 25 Sep 2025 12:31:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, robh@kernel.org,
	laurent.pinchart@ideasonboard.com
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: add device_link support
Message-ID: <aNVufDmHjLRauKYo@lizhi-Precision-Tower-5810>
References: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
 <20250912-v6-16-topic-dma-devlink-v1-1-4debc2fbf901@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-v6-16-topic-dma-devlink-v1-1-4debc2fbf901@pengutronix.de>
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: b80886e0-a994-4d83-7887-08ddfc510ffe
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|366016|1800799024|7416014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?qPHtYCo9drIGy5a8d71noYIdAwIUnWSnDOmGIV1joTBB7itHTiEV2MbAnhaJ?=
 =?us-ascii?Q?MzUXYvU+MwkhEVpY/4xTlnUgKgjEos4OGrUAioZjZCiCwSY/WtKC8oHq5w+4?=
 =?us-ascii?Q?AoXdb8DTVf93S1upfxxuKWzhcTEF3eLtaRSh66uDMczybws98vGBsziIkz0r?=
 =?us-ascii?Q?6KmqBOGbpHbb6pKvUC8l9i4KVpJvNRWGI8bW+ATwJ+8u9AzM6mALPQFO+tbq?=
 =?us-ascii?Q?IPnk+85wPUT86rPX4aDio2Mhr00Q/1wiYyc6Wgr1TGHaXevDektKjS/GZtVn?=
 =?us-ascii?Q?u7jCmWuMIggCFPEjwOatqCaY6s8+duaoROtrwuJJKH8vfibXu1ldfiTRu289?=
 =?us-ascii?Q?5Cd2vJilRLByBbr2D1WEIhLfiyUqkXcSfUEXreIN3CuaobGERgcKdlP1ItLB?=
 =?us-ascii?Q?XhHpV9cjnPyFl9r69q/9cU07ZCo4xLJJW49Ki6rIaUI+GLMcZbM4CTIQYWUf?=
 =?us-ascii?Q?b4VD3P/TAkBu5PXJFE/Mrpq74dWtiit2oECTXO8JyLHYoYcYBUjLkQ0lOP9O?=
 =?us-ascii?Q?w+4fiu4Ar5J2AounGQtH7BREw10iTbM5N3kpvnMkEGsW/WIRtNjq0Fcx5eOP?=
 =?us-ascii?Q?1bSFHpv8M1Si1a8q5hkRLPyd6BzbX0yaiFsZ8mWJeDkepOG48vp01juJygtq?=
 =?us-ascii?Q?cQATBSSaV1Lgsakjz3ms2LrwXZF7Quh2wOtqTWiY6fDa5K+oTRmR+nRkqC9T?=
 =?us-ascii?Q?oYIlOGplIcPzZF01y7jAJ0s+LDliqgaA3198S/5XqwXfLd6fiU0FN/BWCEKe?=
 =?us-ascii?Q?73hVHvdkMKpnmeWNyjQ85mBx+nD36bW4SlTyK5MbB45BWBruawJ5RmYl5byC?=
 =?us-ascii?Q?8k4NihmmEsA00eVkyWw7Aojz4LIInmXoOk9rBGpfQdje9UgcbivasXZqeJ5o?=
 =?us-ascii?Q?ehwgB4fB5ayYrSgleL2B+4mGYwUPcppTbgYn9pwQjNtQOrkY8D8Y8Xjka1IY?=
 =?us-ascii?Q?s6RXM9MWg4YYfN0M4cc1xv/tKrJaD4SxpzeCC2JqkgpejFpdUyqbqP4pK3/H?=
 =?us-ascii?Q?spnEkrD59u23bOwx09JfvlJo6ek/uVtR4RhLp6ykSahT0sA1ASu3zMoN5sAi?=
 =?us-ascii?Q?Fw8j/knS25bJ2MCwgGH2qJCqroYjI6AhynrhFpHY/BuaxHxTolbjZDRCqIlq?=
 =?us-ascii?Q?Yw0DKkVXAvc2YeiHYt7crjzVcWuxUQABr+nUWob+GlTaXfgKI9k0TVFs3plU?=
 =?us-ascii?Q?kMoMpd72qDw9tXX1N69bXVNwAQfqgThEdb+eHv90h9XtpngdjvWNRFyHICg1?=
 =?us-ascii?Q?T4QCVh+5SxtwmSJMPLBWxHkrEl+BYyRSWLV0kwmhoSMiUua3X79w5OhQyIGM?=
 =?us-ascii?Q?7+7ldFdARR/BCNeQqJDfWnt43uOHI654CpB+17a293H/W8L7vndENKlFfIRJ?=
 =?us-ascii?Q?7+LWxXg+j9mZv+UxCZax7sDy0GLgKRS5JxPbY41JwWqK8BSWPU+lPMEZt084?=
 =?us-ascii?Q?nZ8kpxnEBvw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(7416014)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?R4tzGnxVomg2juEfOz9gsz4bk1G+tTwlKICoPCnGW3BqDwyIN3GFj24hbZ/U?=
 =?us-ascii?Q?RRdQ/MloVW1W+ZFxoX2pv5b0Gxupp5YNepRLz2SOnmnoQNp0cp2NhyAWQaWa?=
 =?us-ascii?Q?IFGlN9ukZADEZcl1tidR7C2cc2jegFvK4/lC9VrYcrFU9DQPNuJPZliHQXVc?=
 =?us-ascii?Q?rJlPLI6SqaXSXxWrzbfMbw/AZ/pHz8cZ+MdNyNVgSB7uIZeGv2371u/MI86d?=
 =?us-ascii?Q?pVQx0nmLvLqNGyd8E9wQVX2GiriWcJzk/uvn2JMtqUPwLRoBdRVLsJEyYKpn?=
 =?us-ascii?Q?Uq9IDprE0ID2n6hDFC21mdXalI5fGckXNnpsqG+ZRv7umXkYEt06jhcPDp02?=
 =?us-ascii?Q?C0P7b6k4t1Ji9EfeoQr65KjZfhGdg7isWZpe/KyBJbzQhZZCShDaEME4c2tb?=
 =?us-ascii?Q?MgshdBnhfHFijBqmGseupmDlHK99lvaYlf4qPXuiKo5opLcLLfYE34RFgWQ/?=
 =?us-ascii?Q?nnjKW5pqEGrh8nv7UOO6D7jp/Dwo81Cwrs2TrmkENZonHsQiUG8A1S5LoudY?=
 =?us-ascii?Q?zSSDqptodlLJA7PJ7RBY9q94zn6CyrrT+fglpkbJaqq1au6EIWfS/doM1dFR?=
 =?us-ascii?Q?YNqS7sfwu97l5vCh+iy4zWQsZ2QErb6Zs1APlL/wZQ6WnySoBelYCGnKjTQ8?=
 =?us-ascii?Q?3B30ntqQcr8T68lI7kFy5YBxaJ6i1zTanNvTDo5PKEroDB+YNA8Ej67/m7to?=
 =?us-ascii?Q?xoShqcVAfdOkaYlSMz+dQyaHFVvDz5KgVFQCyazr0kOl4WKYUrNUryzG2ENB?=
 =?us-ascii?Q?g+6ImBOTYStn+l99NJMPNkGwnvkDK5ZcVsTZkn1hxg+T2rYKg4TGzRWESS0x?=
 =?us-ascii?Q?gFrcMTf45jDqxBi6EjT7nUr1llqcw4eg/Vji889cQQRBoUvlo497mivMEBWi?=
 =?us-ascii?Q?LEg/YetkbR+yBOI7QtYKssP7NeOTvSwGbIzqw42afHaAmgaDZ85fLB57C1Ig?=
 =?us-ascii?Q?5dvafQUlmgWxmOpnLsLyQan04rXo/D4aS+je8CkjHREnEmX3sZ4oJNEJYgnQ?=
 =?us-ascii?Q?rRWYqYHTnt4rNBCWQaF3ii9q9vy5AbJoORXdtXt8pRMeyCzP1PMCysrVF6CQ?=
 =?us-ascii?Q?iFv8hfpczrzDhDcXe9qj9yjmH+IOzzRmy8huE/vVLPITjQWsbc0OAcG59yb+?=
 =?us-ascii?Q?wmTqIc1cvod4ZQzH1hAWyaKYp3bQk9/CwuiU2tAoj7OpUip8yMDJN5yYBIGX?=
 =?us-ascii?Q?MWiLmAoVs4by1vD18sPB4/4hwOKqjvarvAEzyIBWYsRLeXfozIO1a7DLgxzr?=
 =?us-ascii?Q?PfFn2oa+AuJPhOmu4I63mviAUl27vwNj1v7/7IMJ8vcRJpA6jzFaw30sVQyh?=
 =?us-ascii?Q?KuEndS5c05Go/w+hN5W1zg1m8KQ8kByYNgMsC7MKk9b7a2BUi43Fn1YGrqJ1?=
 =?us-ascii?Q?EIJ2koBPrzdXeIq4Rk7RvSQuwWaJCdAh+VVnIlSrzlqbH8RwDeyQIM3vmvvn?=
 =?us-ascii?Q?jown6aevq6NA2+egukAARHEm/hsebmG0SQBXsYtGnWPUAYWgdI1JRUFRTYxl?=
 =?us-ascii?Q?SpJ7eJb8OJuHpOSWKAmsNx8m22EkHAD22RDsdlYxO4St6FDmEwhPuF8CQV1g?=
 =?us-ascii?Q?JEcG9JUWZtsPvd58VNNzMimlNLZVVUZkYjibqZ74?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80886e0-a994-4d83-7887-08ddfc510ffe
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:32:04.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUlSRYxW4r/Iyf/FnKLZ7/nwI0pIM1K2TQUgfP9Dso2WkEglr4kTkmxGONb4kiHp5ettLwJse60uT5HVzIgWIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9220

On Fri, Sep 12, 2025 at 12:00:41AM +0200, Marco Felsch wrote:
> Shift the device dependency handling to the driver core by adding
> support for devlinks.
>
> The link between the consumer device and the dmaengine device is
> established by the consumer via the dma_request_chan() automatically if
> the dmaengine driver supports it (create_devlink flag set).
>
> By adding the devlink support it is ensured that the supplier can't be
> removed while the consumer still uses the dmaengine. Furthermore it
> ensures that the supplier driver is present and actual bound before the
> consumer is uses the supplier.
>
> Additional PM and runtime-PM dependency handling can be added easily too
> by setting the required flags (not implemented by this commit).
>
> The new create_devlink flag controlls the devlink creation to not cause
> any regressions with existing dmaengine drivers. This flag can be
> removed once all drivers are successfully tested to support devlinks.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Add previous discussion link:
https://lore.kernel.org/all/aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810/

Another thread
https://lore.kernel.org/dmaengine/20250801120007.GB4906@pendragon.ideasonboard.com/

Add Laurent Pinchart, who may instest this topic also.

Add Rob Herring, who may know why dma engine can't create dev_link default
like other provider (clk, phy, gpio ...)


>  drivers/dma/dmaengine.c   | 15 +++++++++++++++
>  include/linux/dmaengine.h |  3 +++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 758fcd0546d8bde8e8dddc6039848feeb1e24475..e81985ab806ae87ff3aa4739fe6f6328b2587f2e 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -858,6 +858,21 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  	/* No functional issue if it fails, users are supposed to test before use */
>  #endif
>
> +	/*
> +	 * Devlinks between the dmaengine device and the consumer device
> +	 * are optional till all dmaengine drivers are converted/tested.
> +	 */
> +	if (chan->device->create_devlink) {
> +		struct device_link *dl;
> +
> +		dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);

I suggest link to per channel device, instead dma engine devices.
chan->dev->device like phy drivers because some dma-engine have per channel
resources, like power domain and clocks.

Frank


> +		if (!dl) {
> +			dev_err(dev, "failed to create device link to %s\n",
> +					dev_name(chan->device->dev));
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
>  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>  	if (!chan->name)
>  		return chan;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index bb146c5ac3e4ccd7bc0afbf3b28e5b3d659ad62f..c67737a358df659f2bf050a9ccb8d23b17ceb357 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -817,6 +817,8 @@ struct dma_filter {
>   *	DMA tansaction with no software intervention for reinitialization.
>   *	Zero value means unlimited number of entries.
>   * @descriptor_reuse: a submitted transfer can be resubmitted after completion
> + * @create_devlink: create a devlink between a dma_chan_dev supplier and
> + *	dma-channel consumer device
>   * @residue_granularity: granularity of the transfer residue reported
>   *	by tx_status
>   * @device_alloc_chan_resources: allocate resources and return the
> @@ -894,6 +896,7 @@ struct dma_device {
>  	u32 max_burst;
>  	u32 max_sg_burst;
>  	bool descriptor_reuse;
> +	bool create_devlink;
>  	enum dma_residue_granularity residue_granularity;
>
>  	int (*device_alloc_chan_resources)(struct dma_chan *chan);
>
> --
> 2.47.3
>

