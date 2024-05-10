Return-Path: <dmaengine+bounces-2022-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D18C29C1
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497EA1F22DFB
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394FB22EE3;
	Fri, 10 May 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2E0PkR5"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72D224FD
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365031; cv=fail; b=mE/HSvweVyDTPhdpfO01QDPfBoMnGtneY5VxwJLur1Up+LzDuWCrtKRYpK3G8T+kMGllSLeMXJSsbNYm/7whPnbjgAM+T4sKiupL4EEOTTSIxPUVHjn54v/93aXYZrjPS2NM90ROiuJAoL3d/BwF3UE6j/w+nIevp7GW38NMxa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365031; c=relaxed/simple;
	bh=wdypUFGPEOPDmXj+yQTj43Q29E+WzKSHFs9qb+2nzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r0e7fCt+++BwiGjnHq0vG93iku9rRy5/lrVaKmTNTtu8TD7qovrKIRkN1DSBJtj9uBPZYXHxubHBHvCdMinFdquKYg12IioA0rVFyh7JOk9Ps7aivrY1aC7FqfNAM9aouAjWlxdXw+HpYODkcWlPW4XFU09PCjVuOypPLDSd2YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a2E0PkR5; arc=fail smtp.client-ip=40.107.14.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEFlT9G0IRGZd/s8wZqJpFkuG9x49t5BwhMoJcfjK55+AhuGOsExGp9V3jVk/k8Cg8kfe9sc+AxlYEwGd37EoNT863Q37ImwdJGjd2/9k/foiaaOS1M9R5fB8ZTiUQRmYc5E45E0tM/TngvA8TJhUxsXS4mRDh49PTbe2euzciYP3v9m2PIMy7YfiEDNaZiae90jiiiaXL1XOQfQecLIWzQo8pDNEcf3IPB5YNaokxYL8a0vII/GiSIqBQLXr451uH4cFQgMqHXjkdH1KPV5Rqn5Aak33llGw+RXWmO3cwVKqB9PLK1vchg0MvB8WUkZXP6NR+zyNQ1VYXRvBL9rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV+ZeCHFxlEgz8V23RxywM2jBfQ/4EwahNjifaENjHw=;
 b=RvuAQzHYQiD6JEUkTBTiwtinUzAWzR9IpFirgVJ9m5f64nx8Tq9ryZsY918Jfz8qp2JanOujBKKGMdTOy+0z0QRjvYsv4pN54csMnVvIUzS63Gc4jnV13X7A7/6KaUatGeblObZTLijXTLYqe3XjbqQm+9otUpBzvsQ57noHqft88HB1KM8nUxFOC15cNx3NTWHMXVhxAM86rjJllcIc6ERSOCn+7BkBOJHGs2KA0gyiB88CIIslIoOPEsQZH7FezpKweUeVrMIYdXFF8n/CCvesO3lWQTgEcw6FOVmLtyXMTA0RZGTYmNWiKYVEQf5GRLe5gUy5nkk/EBQty1AHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV+ZeCHFxlEgz8V23RxywM2jBfQ/4EwahNjifaENjHw=;
 b=a2E0PkR5HEOz5NUsxhZKUq/J9YpV9KSFSmAo6X+hFL2uiOvuJofRW6K7kDuT475ZGoD0BNWIHSmy0Gdo7nNx24OiO7L5X6dxWHjg4JgWaBdOsN5JaRBSNzzzzS8UQuyr8gf3uvi9xDaorDTGBBilTbNMGk30G5+RMZk1AgPgu3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10297.eurprd04.prod.outlook.com (2603:10a6:800:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 18:17:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 18:17:04 +0000
Date: Fri, 10 May 2024 14:16:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com
Subject: Re: [PATCH 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
Message-ID: <Zj5kmc766qmOwjq1@lizhi-Precision-Tower-5810>
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
 <20240510082053.875923-3-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510082053.875923-3-Basavaraj.Natikar@amd.com>
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10297:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f09cb8-9d14-4d0c-9474-08dc711d64fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1HXpk3b8hIYP4uXEaEYyU+HI7JMBqNiC30veSxYs5ws4XhjjmuMGCDHGIYTF?=
 =?us-ascii?Q?zRM4GQnuS/UwolpjzqEpszgr01esveykcRf0uo++WBPZqoToyS3z6VU+cRAR?=
 =?us-ascii?Q?5zvWVJix8xT0hIEJR1hfiwVlpSumm2dBTFXp42HlkzQ+/Z3f6XArI0B+qPP2?=
 =?us-ascii?Q?f0p2YyLfiowI8GLFD5DsdnFS/LRA6Fefo0gckL59I50bLRB9UBiB3ZkkZiCi?=
 =?us-ascii?Q?rxC0DzAYEGS+ggUA7U4TfOIJE20FtKCJ+RxGJryQXxpfTSRQKkzEd15AwWH8?=
 =?us-ascii?Q?QK+rWZR+MlmYH4ItQLPzcdr/OM1i5IpbMbLFUKFuQsKrkgJfYpNmJVTTGmHv?=
 =?us-ascii?Q?IAmcJMU9mFta1fP7DSu8RNx8D8i/hur0fOKh2G0iMsCG6088nLUy7Yb4/EtJ?=
 =?us-ascii?Q?x5Qf5uxBa9hSCjTJkr2zzznrfoK29SW00Sdl+XHYq9QdtuUfLBH3mbf7tupf?=
 =?us-ascii?Q?qhdIRYvA52HVAJF05w2pcTDZzcdUrmHws0vpqy3jMJDuvBLcPC6F1ZvTeisr?=
 =?us-ascii?Q?Em1iIPcABTOti+83UG3m5RmpqmISZN1ZMiQ2M1tGJrDi3l8EelXOf1HEmLaD?=
 =?us-ascii?Q?VBEbofZUhQoC9jDVde2wIJTL/1HCvQdbYodlyLQwHYvzvons6CbfBzKg6Mpn?=
 =?us-ascii?Q?+Keeyang79zbPKCpcqcxYFVPC6nAI0u6sJB5Ptcd1mmQxUnAkxR1akTicncj?=
 =?us-ascii?Q?52gwSNYDD6R1yV4ju7L/VYWBJST5vk69ofz0EWwmXDj3dQYNRbbhCP+96Gcx?=
 =?us-ascii?Q?O6MgPcecNr/pC9CtLPwOs5q1S9PgxLgS4UIjtq60PVwtreSnzFyrQGfx9PIx?=
 =?us-ascii?Q?OOILGyKhBkcS17W3UmFTmhrchHIKnmkCN7VdCQsIxOJhm9iA4E89yLCF3ZJf?=
 =?us-ascii?Q?egbKuPgfMHqYf7dvpUc9ccZIPXb1LQWOCSaZfmHbklOepp3L+fam3c+AAJOW?=
 =?us-ascii?Q?pj/mZu8/hfF/6JSjM0wWw9iWdTftzmQ60RZo6u9rHPjWdNOyDKRLzauifxkp?=
 =?us-ascii?Q?1QuAbiyJa9h474oBeMVDYZOX14Qb3/TAz75N63DvxhkDL/rCiugJFtfTnrfq?=
 =?us-ascii?Q?FRYVEBma9is76NShA6hDGrtEtIl7ty/bSOrZHYp6T9389IGeI7nHxG8Mupdx?=
 =?us-ascii?Q?fLyvANBFDH05xnvp7DInrfBvl8jsDZgNJ+cZ2WVEHL+W2pYDWqCPvBIfgRFA?=
 =?us-ascii?Q?henCepJbiiiEeWj2Qr4tb8O4lffTbUVBHKmjXkY27fR7lK7NHSpMazu1Aq1z?=
 =?us-ascii?Q?nL4EviLbSmStttPSoXAoYUbSsxL6+Syar0jWt8+J6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VH90hNHaCMIqyL6y/I9wqOvoaAO2AL1Sro6Lw7UcWydF+he835Gs19FC2dF+?=
 =?us-ascii?Q?dJnftdwko86r87HNZ7kqQFn4R7NezHsdev1Q7N9G6bBkEaB2K146r69rQM+M?=
 =?us-ascii?Q?SmAQsyB0Bp6aWmTau5v7NB5goOIDz/T78tU8kYZbw2ANJo5qt4mJlzB5m/z7?=
 =?us-ascii?Q?bC4iC2XPWw0tRNKc8OYxeU/jDqOohtfyvmsYPamylGl7HnmLJB0B5uUT5TsL?=
 =?us-ascii?Q?Rkv4sOtuaqLRGrxAetE8WdhVMoZRIkZ8P0Fp3MN/8kvjRXsp9biGHU9cMHbs?=
 =?us-ascii?Q?NXTnMTDmQDc+zYDPjjhomdGrgZfU6R+GTr2rZ3tbb61BKn/VeklqS8p2HjyY?=
 =?us-ascii?Q?+s+HL0QLijfrbsiUFOZKyHYgBQ63nAQRZUqSoESBtWgXCz1QMByp40sLH64s?=
 =?us-ascii?Q?nKV/FVBlDKzYPMnEPquLmC+nAXXzRoDI57nZ83tnwPKHGoxVszWF7Hq/SZUD?=
 =?us-ascii?Q?VdmUqgOmiKGDt9ww/QvtkeXAoYOwDkk4cxi9Vng/f2tsWcDboXF0eLpsHPqt?=
 =?us-ascii?Q?a3cER2cN8w6sp+oGLhiRqic0hg7E9UrlwcahUhgkr0KW7VPjT4sYUQ+KKr7V?=
 =?us-ascii?Q?s8PPPZQACxRBfyViPVo+WIE3mWhGpDgHoHfu8XGDbJksoF2CE98nl7v6e6SY?=
 =?us-ascii?Q?y8XyzqvvuiPZccL54KIEbGj30bffj9jnlthbaWA/LB829B9lJ5sNLa5n/FK4?=
 =?us-ascii?Q?DaOvGZZVMh8dgaxqEhRY+yCV5Ag8vbBiLmyyq5hJe3w3gDg2hHPJjo0DL+uR?=
 =?us-ascii?Q?vH8kFruzmtiQc1eAsQiOP/7ngouxxVBJkvV3YBsVCxUvgXLa51RUUKkmiIlL?=
 =?us-ascii?Q?Tv3oCJL41Lco5kDj4APXjjxJfgptV783znFqCaBLjE0X4IDuQhKlNiJnex5U?=
 =?us-ascii?Q?wUD5fMmKsTlAY87Rx7Z6h1J9XyzRikUzG1F4KzIAggQc/8rEvFuHJQMxTHWJ?=
 =?us-ascii?Q?t+cpLpmPEWtjeNTBzAkkT4U/85I10Gr2m3E/ok+YZKW3hqFJDeqDC9AR/+ay?=
 =?us-ascii?Q?7PwFFFJ6jBdKnm5NFnYCefOy+DjL3AHwNk6lWLeBab9zdaSqjPPDYUceM23M?=
 =?us-ascii?Q?mxChUoIfh4N/3eZmeWNhT+eKF2TNl0cE7vX4u7yc9La6CYaLlybunqYD/hqq?=
 =?us-ascii?Q?xlkoibSVmVziyY4egw5dyHAOhG6C/t4S4hE16VtM/U2C0QOJAzU8XbidFqeo?=
 =?us-ascii?Q?JNxZL62JdI9WBR48dGR4E45wqXSMHWHjrXFukv7FAqc0kQJLWXQxmr4EZpit?=
 =?us-ascii?Q?2/+xhx1fFEBoj1v5IWjHV+Ys30X4ZKIqw7F9vENiykGZwM2LrAlFRdADM+8C?=
 =?us-ascii?Q?FRnZNzqMSONJZgZLALwUFop7PgDFrGtZNd3LEBTzgIGnWKwxFGMFBLciDOQJ?=
 =?us-ascii?Q?RlXKZLtBiHpHo1JuVaTI9oKRTtXrpaV9YcWM5It+AqjlTDukrecJrYcfhbg+?=
 =?us-ascii?Q?dcxQ5B+re2bPmO2WsmeFYJ6sSYhXJlI87BMd5ByY++abosHFJXeraJtu3L2J?=
 =?us-ascii?Q?TzzBIriX9kQsA9NXYwo/D1Q+/35HV/FvORu0G2VoNF1JP/p7cle2CHBrdHuJ?=
 =?us-ascii?Q?b3fBAVDjGZVCoBQmfu0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f09cb8-9d14-4d0c-9474-08dc711d64fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:17:04.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoBP2QI4z+QMwn2jJRYAkE2tBWnMzLL3yEqisAsUyssRtIy6OC9lo1CczKwI7oftluWZ2JT24VjRS5xbe9Cxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10297

On Fri, May 10, 2024 at 01:50:48PM +0530, Basavaraj Natikar wrote:
> Add support for AMD AE4DMA controller. It performs high-bandwidth
> memory to memory and IO copy operation. Device commands are managed
> via a circular queue of 'descriptors', each of which specifies source
> and destination addresses for copying a single buffer of data.
> 
> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  MAINTAINERS                         |   6 +
>  drivers/dma/amd/Kconfig             |   1 +
>  drivers/dma/amd/Makefile            |   1 +
>  drivers/dma/amd/ae4dma/Kconfig      |  13 ++
>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 206 ++++++++++++++++++++++++++++
>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 195 ++++++++++++++++++++++++++
>  drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
>  9 files changed, 535 insertions(+)
>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
>  create mode 100644 drivers/dma/amd/common/amd_dma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b190efda33ba..45f2140093b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -909,6 +909,12 @@ L:	linux-edac@vger.kernel.org
>  S:	Supported
>  F:	drivers/ras/amd/atl/*
>  
> +AMD AE4DMA DRIVER
> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/amd/ae4dma/
> +
>  AMD AXI W1 DRIVER
>  M:	Kris Chaplin <kris.chaplin@amd.com>
>  R:	Thomas Delev <thomas.delev@amd.com>
> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
> index 8246b463bcf7..8c25a3ed6b94 100644
> --- a/drivers/dma/amd/Kconfig
> +++ b/drivers/dma/amd/Kconfig
> @@ -3,3 +3,4 @@
>  # AMD DMA Drivers
>  
>  source "drivers/dma/amd/ptdma/Kconfig"
> +source "drivers/dma/amd/ae4dma/Kconfig"
> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
> index dd7257ba7e06..8049b06a9ff5 100644
> --- a/drivers/dma/amd/Makefile
> +++ b/drivers/dma/amd/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
> diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
> new file mode 100644
> index 000000000000..cf8db4dac98d
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config AMD_AE4DMA
> +	tristate  "AMD AE4DMA Engine"
> +	depends on X86_64 && PCI
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Enable support for the AMD AE4DMA controller. This controller
> +	  provides DMA capabilities to perform high bandwidth memory to
> +	  memory and IO copy operations. It performs DMA transfer through
> +	  queue-based descriptor management. This DMA controller is intended
> +	  to be used with AMD Non-Transparent Bridge devices and not for
> +	  general purpose peripheral DMA.
> diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
> new file mode 100644
> index 000000000000..e918f85a80ec
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# AMD AE4DMA driver
> +#
> +
> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
> +
> +ae4dma-objs := ae4dma-dev.o
> +
> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> new file mode 100644
> index 000000000000..fc33d2056af2
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD AE4DMA driver
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +
> +#include "ae4dma.h"
> +
> +static unsigned int max_hw_q = 1;
> +module_param(max_hw_q, uint, 0444);
> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");

Does it get from hardware register? you put to global variable. How about
system have two difference DMA controllers, one's max_hw_q is 1, the other
is 2.

> +
> +static char *ae4_error_codes[] = {
> +	"",
> +	"ERR 01: INVALID HEADER DW0",
> +	"ERR 02: INVALID STATUS",
> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> +	"ERR 06: INVALID ALIGNMENT",
> +	"ERR 07: INVALID DESCRIPTOR",
> +};
> +
> +static void ae4_log_error(struct pt_device *d, int e)
> +{
> +	if (e <= 7)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> +	else if (e > 7 && e <= 15)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	else if (e > 15 && e <= 31)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	else if (e > 31 && e <= 63)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	else if (e > 63 && e <= 127)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> +	else if (e > 127 && e <= 255)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> +	else
> +		dev_info(d->dev, "Unknown AE4DMA error");
> +}
> +
> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
> +{
> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> +	struct ae4dma_desc desc;
> +	u8 status;
> +
> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
> +	/* Synchronize ordering */
> +	mb();

does dma_wmb() enough? 

> +	status = desc.dw1.status;
> +	if (status && status != AE4_DESC_COMPLETED) {
> +		cmd_q->cmd_error = desc.dw1.err_code;
> +		if (cmd_q->cmd_error)
> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
> +	}
> +}
> +
> +static void ae4_pending_work(struct work_struct *work)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> +	struct pt_cmd *cmd;
> +	u32 cridx, dridx;
> +
> +	while (true) {
> +		wait_event_interruptible(ae4cmd_q->q_w,
> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
> +					   atomic64_read(&ae4cmd_q->intr_cnt)));

wait_event_interruptible_timeout() ? to avoid patental deadlock.

> +
> +		atomic64_inc(&ae4cmd_q->done_cnt);
> +
> +		mutex_lock(&ae4cmd_q->cmd_lock);
> +
> +		cridx = readl(cmd_q->reg_control + 0x0C);
> +		dridx = atomic_read(&ae4cmd_q->dridx);
> +
> +		while ((dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
> +			list_del(&cmd->entry);
> +
> +			ae4_check_status_error(ae4cmd_q, dridx);
> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
> +
> +			atomic64_dec(&ae4cmd_q->q_cmd_count);
> +			dridx = (dridx + 1) % CMD_Q_LEN;
> +			atomic_set(&ae4cmd_q->dridx, dridx);
> +			/* Synchronize ordering */
> +			mb();
> +
> +			complete_all(&ae4cmd_q->cmp);
> +		}
> +
> +		mutex_unlock(&ae4cmd_q->cmd_lock);
> +	}
> +}
> +
> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q = data;
> +	struct pt_cmd_queue *cmd_q;
> +	struct pt_device *pt;
> +	u32 status;
> +
> +	cmd_q = &ae4cmd_q->cmd_q;
> +	pt = cmd_q->pt;
> +
> +	pt->total_interrupts++;
> +	atomic64_inc(&ae4cmd_q->intr_cnt);
> +
> +	wake_up(&ae4cmd_q->q_w);
> +
> +	status = readl(cmd_q->reg_control + 0x14);
> +	if (status & BIT(0)) {
> +		status &= GENMASK(31, 1);
> +		writel(status, cmd_q->reg_control + 0x14);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void ae4_destroy_work(struct ae4_device *ae4)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q;
> +	int i;
> +
> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> +
> +		if (!ae4cmd_q->pws)
> +			break;
> +
> +		cancel_delayed_work(&ae4cmd_q->p_work);

do you need cancel_delayed_work_sync()?

> +		destroy_workqueue(ae4cmd_q->pws);
> +	}
> +}
> +
> +int ae4_core_init(struct ae4_device *ae4)
> +{
> +	struct pt_device *pt = &ae4->pt;
> +	struct ae4_cmd_queue *ae4cmd_q;
> +	struct device *dev = pt->dev;
> +	struct pt_cmd_queue *cmd_q;
> +	int i, ret = 0;
> +
> +	writel(max_hw_q, pt->io_regs);
> +
> +	for (i = 0; i < max_hw_q; i++) {
> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> +		ae4cmd_q->id = ae4->cmd_q_count;
> +		ae4->cmd_q_count++;
> +
> +		cmd_q = &ae4cmd_q->cmd_q;
> +		cmd_q->pt = pt;
> +
> +		/* Preset some register values (Q size is 32byte (0x20)) */
> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
> +
> +		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
> +				       dev_name(pt->dev), ae4cmd_q);
> +		if (ret)
> +			return ret;
> +
> +		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
> +
> +		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
> +						   GFP_KERNEL);
> +		if (!cmd_q->qbase)
> +			return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> +
> +		cmd_q = &ae4cmd_q->cmd_q;
> +
> +		/* Preset some register values (Q size is 32byte (0x20)) */
> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
> +
> +		/* Update the device registers with queue information. */
> +		writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
> +
> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x18);
> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x1C);
> +
> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
> +		init_waitqueue_head(&ae4cmd_q->q_w);
> +
> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);

Can existed workqueue match your requirement? 

Frank

> +		if (!ae4cmd_q->pws) {
> +			ae4_destroy_work(ae4);
> +			return -ENOMEM;
> +		}
> +		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
> +		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
> +
> +		init_completion(&ae4cmd_q->cmp);
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> new file mode 100644
> index 000000000000..4cd537af757d
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD AE4DMA driver
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +
> +#include "ae4dma.h"
> +
> +static int ae4_get_msi_irq(struct ae4_device *ae4)
> +{
> +	struct pt_device *pt = &ae4->pt;
> +	struct device *dev = pt->dev;
> +	struct pci_dev *pdev;
> +	int ret, i;
> +
> +	pdev = to_pci_dev(dev);
> +	ret = pci_enable_msi(pdev);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> +		ae4->ae4_irq[i] = pdev->irq;
> +
> +	return 0;
> +}
> +
> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
> +{
> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
> +	struct pt_device *pt = &ae4->pt;
> +	struct device *dev = pt->dev;
> +	struct pci_dev *pdev;
> +	int v, i, ret;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
> +		ae4_msix->msix_entry[v].entry = v;
> +
> +	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
> +	if (ret < 0)
> +		return ret;
> +
> +	ae4_msix->msix_count = ret;
> +
> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> +		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
> +
> +	return 0;
> +}
> +
> +static int ae4_get_irqs(struct ae4_device *ae4)
> +{
> +	struct pt_device *pt = &ae4->pt;
> +	struct device *dev = pt->dev;
> +	int ret;
> +
> +	ret = ae4_get_msix_irqs(ae4);
> +	if (!ret)
> +		return 0;
> +
> +	/* Couldn't get MSI-X vectors, try MSI */
> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> +	ret = ae4_get_msi_irq(ae4);
> +	if (!ret)
> +		return 0;
> +
> +	/* Couldn't get MSI interrupt */
> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static void ae4_free_irqs(struct ae4_device *ae4)
> +{
> +	struct ae4_msix *ae4_msix;
> +	struct pci_dev *pdev;
> +	struct pt_device *pt;
> +	struct device *dev;
> +	int i;
> +
> +	if (ae4) {
> +		pt = &ae4->pt;
> +		dev = pt->dev;
> +		pdev = to_pci_dev(dev);
> +
> +		ae4_msix = ae4->ae4_msix;
> +		if (ae4_msix && ae4_msix->msix_count)
> +			pci_disable_msix(pdev);
> +		else if (pdev->irq)
> +			pci_disable_msi(pdev);
> +
> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> +			ae4->ae4_irq[i] = 0;
> +	}
> +}
> +
> +static void ae4_deinit(struct ae4_device *ae4)
> +{
> +	ae4_free_irqs(ae4);
> +}
> +
> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ae4_device *ae4;
> +	struct pt_device *pt;
> +	int bar_mask;
> +	int ret = 0;
> +
> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
> +	if (!ae4)
> +		return -ENOMEM;
> +
> +	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
> +	if (!ae4->ae4_msix)
> +		return -ENOMEM;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		goto ae4_error;
> +
> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
> +	if (ret)
> +		goto ae4_error;
> +
> +	pt = &ae4->pt;
> +	pt->dev = dev;
> +
> +	pt->io_regs = pcim_iomap_table(pdev)[0];
> +	if (!pt->io_regs) {
> +		ret = -ENOMEM;
> +		goto ae4_error;
> +	}
> +
> +	ret = ae4_get_irqs(ae4);
> +	if (ret)
> +		goto ae4_error;
> +
> +	pci_set_master(pdev);
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			goto ae4_error;
> +	}

needn't failback to 32bit.  never return failure when bit >= 32.

Detail see: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f7ae20f2fc4e6a5e32f43c4fa2acab3281a61c81

if (support_48bit)
	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48))
else
	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))

you decide if support_48bit by hardware register or PID/DID


> +
> +	dev_set_drvdata(dev, ae4);
> +
> +	ret = ae4_core_init(ae4);
> +	if (ret)
> +		goto ae4_error;
> +
> +	return 0;
> +
> +ae4_error:
> +	ae4_deinit(ae4);
> +
> +	return ret;
> +}
> +
> +static void ae4_pci_remove(struct pci_dev *pdev)
> +{
> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> +
> +	ae4_destroy_work(ae4);
> +	ae4_deinit(ae4);
> +}
> +
> +static const struct pci_device_id ae4_pci_table[] = {
> +	{ PCI_VDEVICE(AMD, 0x14C8), },
> +	{ PCI_VDEVICE(AMD, 0x14DC), },
> +	{ PCI_VDEVICE(AMD, 0x149B), },
> +	/* Last entry must be zero */
> +	{ 0, }
> +};
> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
> +
> +static struct pci_driver ae4_pci_driver = {
> +	.name = "ae4dma",
> +	.id_table = ae4_pci_table,
> +	.probe = ae4_pci_probe,
> +	.remove = ae4_pci_remove,
> +};
> +
> +module_pci_driver(ae4_pci_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD AE4DMA driver");
> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> new file mode 100644
> index 000000000000..24b1253ad570
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD AE4DMA driver
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +#ifndef __AE4DMA_H__
> +#define __AE4DMA_H__
> +
> +#include "../common/amd_dma.h"
> +
> +#define MAX_AE4_HW_QUEUES		16
> +
> +#define AE4_DESC_COMPLETED		0x3
> +
> +struct ae4_msix {
> +	int msix_count;
> +	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
> +};
> +
> +struct ae4_cmd_queue {
> +	struct ae4_device *ae4;
> +	struct pt_cmd_queue cmd_q;
> +	struct list_head cmd;
> +	/* protect command operations */
> +	struct mutex cmd_lock;
> +	struct delayed_work p_work;
> +	struct workqueue_struct *pws;
> +	struct completion cmp;
> +	wait_queue_head_t q_w;
> +	atomic64_t intr_cnt;
> +	atomic64_t done_cnt;
> +	atomic64_t q_cmd_count;
> +	atomic_t dridx;
> +	unsigned int id;
> +};
> +
> +union dwou {
> +	u32 dw0;
> +	struct dword0 {
> +	u8	byte0;
> +	u8	byte1;
> +	u16	timestamp;
> +	} dws;
> +};
> +
> +struct dword1 {
> +	u8	status;
> +	u8	err_code;
> +	u16	desc_id;
> +};
> +
> +struct ae4dma_desc {
> +	union dwou dwouv;
> +	struct dword1 dw1;
> +	u32 length;
> +	u32 rsvd;
> +	u32 src_hi;
> +	u32 src_lo;
> +	u32 dst_hi;
> +	u32 dst_lo;
> +};
> +
> +struct ae4_device {
> +	struct pt_device pt;
> +	struct ae4_msix *ae4_msix;
> +	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
> +	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
> +	unsigned int cmd_q_count;
> +};
> +
> +int ae4_core_init(struct ae4_device *ae4);
> +void ae4_destroy_work(struct ae4_device *ae4);
> +#endif
> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
> new file mode 100644
> index 000000000000..31c35b3bc94b
> --- /dev/null
> +++ b/drivers/dma/amd/common/amd_dma.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD DMA Driver common
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +
> +#ifndef AMD_DMA_H
> +#define AMD_DMA_H
> +
> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/wait.h>
> +#include <linux/dmapool.h>

order by alphabet

> +
> +#include "../ptdma/ptdma.h"
> +#include "../../virt-dma.h"
> +
> +#endif
> -- 
> 2.25.1
> 

