Return-Path: <dmaengine+bounces-1759-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B289B0AA
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AF41C20A1A
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C1210FF;
	Sun,  7 Apr 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oIx+jguy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2022.outbound.protection.outlook.com [40.92.41.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0801CAA4;
	Sun,  7 Apr 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712491036; cv=fail; b=MPUfyccKVCXWQgUNS6TY0xJV5y3oLVp56mJJWLGoJhrA1REApnURkk7QKgH9xOMMSbVG4dAVrRkQv9SlmVE3S4f5+0eFAM1mgeLQQk4oRUvSeYqU+Nipit3cbnn2M6wYXBLxKLNJX/AeIlA8XlnhklU2Fq+upKAf+i3E9YL9+P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712491036; c=relaxed/simple;
	bh=O/ngNPJ54PiVEcFo7OrH4cp459xY5vX37DSTPVnOof8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJ0QXSFFDczuiotl+wqn5ej3t42R9nRLBm2J201xNtEUTDjHrekjGAZp9mAiPjI7jYlMcGSIMenpoO9C6dEF3HhdOU7RRVjZShjW45hJhJwzxYq+3OUuGdTLFvDaNdsAkFGcZ3EEAPuLj/RYSQKxLRpdCGHr4ydOv7j1gMrj9Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oIx+jguy; arc=fail smtp.client-ip=40.92.41.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T421hfO0osofMwi8MWNUnCLtA3jKV/LjqjJxgzGbZHPKznF/QQDCdfRJE3EHGy3HXzkZY2j4cx+BZMGX4pORyBSQkcEl49ivuAdLTqPWmrIYpRNYdwJTzxce83F5a+tBvO+HPg//COqk1lbkwosGzLWHW7Ld5mn7u24SBeRpwmfbe0B9w/IPQ4mkVO9lts4usOwvAUIRqxCoq73tyifw63cZ5/bDpxvPQ+r8zGn/SXqokfItV5PE1PZicINP6l0mJXgejY0NaPunEKggx8y8F/svnlJS/LQAb3NmEdJrxmkONizfzK0hSM2/G+jkFm3Mh6o3c0po5YqAxkTE8nKZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrcdxBdwnqS49+6YTZzCy01GVDvlboMJQi94sHuyvF8=;
 b=InjTiUAkro8bS7YSvv19wpkiR3hAJQ3qFYqUj89jthpUN8vpq6zG/GIaqoXPX+ya+DRstywQBAbZ6BY8dM/hLj5EZI8/D67YnG4NrjOjAdGBVTmYpeO9YHFsy7o2aJDCNp3MlAtWQsNME7/NEGoAFQj2DZFD75KaNQ4fDSFRMZuTygF5uwau1xuR5f74VvVYscBzoYm95vsQqVh+9JmtQuh+yyWNukiQEOPA7J3UPBIM44bw6HizYLR+DhNyDLdWz1txzf/Ut2mSoZQcyFLr2vbnfTpXvnW5D/jVVGJykuyQhRGku2YNz0oNRh4uyyMvKx9AZ/5A7oLArslGQIL7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrcdxBdwnqS49+6YTZzCy01GVDvlboMJQi94sHuyvF8=;
 b=oIx+jguy/kfxO4YlI4dQqReGVzzn21x8WxWjjcGc7/IoK/2B8Vm2o9qoUDYn7ic4yI36RPnngglq+M58U8cfX79ipZbW4uNN8jPUB41EGX57scdrpemp/bs1Yx1AROoafUOccLcGK3UM6Ys7jagEEOLTqGdHLttXvmjIaVHWLwNuHa7nVGl3yxsCD02JEy6h9C5jBTIqn5Ufg4Hp+9bCayEqz15o1WDpCnNbuG/eOABJohDcsnrZmG9KeDurFVwNGyO12i3db3OxnLkC3RO+ryEUPDE8KNVM8oVHD9+uiocS++73dvpNjJMRXI1xBtiAkBhYMO96cNWNXBA2fQCEWw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6353.namprd20.prod.outlook.com (2603:10b6:510:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 11:57:11 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 11:57:11 +0000
Date: Sun, 7 Apr 2024 19:57:25 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
Message-ID:
 <IA1PR20MB4953677A917684B2E4085E45BB012@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953AE1184DD09F9203C665CBB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZhKDo0GCpvffUcd8@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhKDo0GCpvffUcd8@matsya>
X-TMN: [gMWzprJcCTwSf2gJ7Sl0jQUuTgfHxOabo1JSyp+jKfE=]
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <k4hpgx3ou5krjtn2nf5nrzx5abhvws4ey5a775laeutpfgz7yr@e6pssxjrqoyp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 787e49b1-24d7-4f13-10be-08dc56f9db75
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a3gqkv9dyppda60k+NA85XOOCmegGrZs2NWd6DN5rwltVjDz5GL3ps8e+8pPAHLZALGS6qJUF2hspT4ThD8faoU4rE8rwjGQoftqAZ46NFtwBJvXQxR926iZpGVyWBLmjGWio1X55toUsbclaci7YnkKrH2Q8JBKmzeYWj/wW+zGnrNbFAmALfWIBR4Adc/kMR3vpTK+waNxDyHEkiBFDYWStV3vyqgltm/H8hFrnX/wjmgHu8VnEfEnp7nyGi9C/wayptvFuEJq1LBMHvvVUzrO7YP8oT+ou/6Nz59o1LfVuK/pLQv+EZ3fwjd5i6IraLKEmeOX30IRCOg3pjUbqWUeWdPvUWib8i+LYVqat07uuQ9Xe0kaA/ub7Q4WGGIgmuRmHneJ2dNWvunqJ0QdaRMSCSMMzdzHdparDxkouHIXlHUJ2AxWay6yJ4BwWKCI/HfkTaHbLVNBVJUbEJO03AhrM8vfjE0ap+yix2H/yotafWKTtQsarEckntmpeUI25rqoy4MUZutgY3ygqG/IMsfzz7iUktJFA355VM/NX+Q14GPVudW9/gkscfB5hHImK20bYmUmvvL54mmzctfNy6tuK68fMk3HIPK+TIL6fx90xJBuxnVRzOjqBzxLGBrE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U7PSqkEm34JpoM7kaDTaqRs28y+OpKu7I2WwzV7W3OOAOPxvAXO8KKnTnUDl?=
 =?us-ascii?Q?3iGoVMAsaopu1VwZZvwWwNzm2uQYO6SMZU1DNcuOTtvJ5aMrUUnSSNSLps9h?=
 =?us-ascii?Q?Grzr/75XuabsqpWR8AdOZf4opT8NjitWJmgO6lhNwyNotsbyCFfHZXgGO/cp?=
 =?us-ascii?Q?kgBi0qgtamZzFJtuVt6QlFcnn3hfD3kFO3rv9QLdXVotjRSzcEu3qvwQapI3?=
 =?us-ascii?Q?02kmcMidjZJ3OJKp5wQFsBNITVp1VijHS/d6u5QV9NaF0rwY1erpoeOYzlVf?=
 =?us-ascii?Q?vElCNEQ3ymOokB5lMEFonOqN3/IRg7wtvCbYBh7PLgtkwghOIfWCETkpnBEb?=
 =?us-ascii?Q?AyaNo0iPuH5PHVgZtdeZFdp/Qmmojz1lfSM8Ki11lMcfa+XeFz4/nFkWPQQE?=
 =?us-ascii?Q?l5ovplHXr3ymutbig1kjERd/4aY3BlXm0hvVdY4eF4kQGB4rhLHDkDnr10Op?=
 =?us-ascii?Q?U8oYJWrmZ9vaBPFzBMM0XVH+qS9wkLlkARTjR8fwyQcUAOlK7QnkLpuiePFL?=
 =?us-ascii?Q?iKAwZFUBFsuoMlDMJDDaX+LpzKSivGlLQxrZQuI3SFxhN3/Ue/1SkiMiohsJ?=
 =?us-ascii?Q?MitEsR9/6/a7EdSt5dUlib9o+E0mG4e8EfEOqFst7h4/8Fuqw09iX6rPkdeL?=
 =?us-ascii?Q?dAERjxtUpaSs+6FAi9CLnHXjXYW0QHjJy4ncbY1FUaqHbXmXL6KZW4tEHFiW?=
 =?us-ascii?Q?MRS6Bv5S0KR5XkrSnWXy1CZzL3wcJIh+F+dVb3g9r6YB3ZDT60joKpcCaqk8?=
 =?us-ascii?Q?V1xTdukM26C7/Et5/T/lBvKGBC/MMzsJmNxPKoLc6hu70nFHLo4pXNUkVrvr?=
 =?us-ascii?Q?MJNS+fZaNcO6TyIZE9lv4Vys/Z5VqGJGIfcEDidH3cyuRU2jYsZk6Y0/BHqI?=
 =?us-ascii?Q?UhOQe0sVghV6e8ije85UcCteWyRitSW0/jHVoWhdltlw8Tozz8QeiVKydhPD?=
 =?us-ascii?Q?UqnA3ZBaoPAWtQP30Fn12ZlBpxwhvQBs+TQHcQUAlTNcVES7mjIFRnrqoFnR?=
 =?us-ascii?Q?KyOz6Lk9GmPSaEa8vrOOR2zGU8oq3j0ETe6MNsUH/0eO2ujrmihDOzIp04h6?=
 =?us-ascii?Q?r9lLtK+JgOVakeqnuZZF0fsiteAfhRw53rk+5Ap7YPwO5cRwrQhwxEzFg0UP?=
 =?us-ascii?Q?hIpY1sWENn3kwckq2suPnK4Pq5eIyDEpGYqO4RybaFe4pV0FBz3QxujuYHNi?=
 =?us-ascii?Q?71nHXgKtDJOGKh6pPZvnuDtfNiH9eKZXPZZc8ex6ymIVWcwZB6JfCK8OBIqe?=
 =?us-ascii?Q?z03qSXHg1VTFgUXQV0Ji?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787e49b1-24d7-4f13-10be-08dc56f9db75
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 11:57:11.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6353

On Sun, Apr 07, 2024 at 04:59:39PM +0530, Vinod Koul wrote:
> On 29-03-24, 10:04, Inochi Amaoto wrote:
> > Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
> > its request lines. The multiplexer supports at most 8 request lines.
> > 
> > Add driver for Sophgo CV18XX/SG200X DMA multiplexer.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  drivers/dma/Kconfig         |   9 ++
> >  drivers/dma/Makefile        |   1 +
> >  drivers/dma/cv1800-dmamux.c | 267 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 277 insertions(+)
> >  create mode 100644 drivers/dma/cv1800-dmamux.c
> > 
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 002a5ec80620..cb31520b9f86 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -546,6 +546,15 @@ config PLX_DMA
> >  	  These are exposed via extra functions on the switch's
> >  	  upstream port. Each function exposes one DMA channel.
> > 
> > +config SOPHGO_CV1800_DMAMUX
> > +	tristate "Sophgo CV1800/SG2000 series SoC DMA multiplexer support"
> > +	depends on MFD_SYSCON
> > +	depends on ARCH_SOPHGO
> > +	help
> > +	  Support for the DMA multiplexer on Sophgo CV1800/SG2000
> > +	  series SoCs.
> > +	  Say Y here if your board have this soc.
> > +
> >  config STE_DMA40
> >  	bool "ST-Ericsson DMA40 support"
> >  	depends on ARCH_U8500
> > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > index dfd40d14e408..7465f249ee47 100644
> > --- a/drivers/dma/Makefile
> > +++ b/drivers/dma/Makefile
> > @@ -67,6 +67,7 @@ obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
> >  obj-$(CONFIG_PXA_DMA) += pxa_dma.o
> >  obj-$(CONFIG_RENESAS_DMA) += sh/
> >  obj-$(CONFIG_SF_PDMA) += sf-pdma/
> > +obj-$(CONFIG_SOPHGO_CV1800_DMAMUX) += cv1800-dmamux.o
> >  obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
> >  obj-$(CONFIG_STM32_DMA) += stm32-dma.o
> >  obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
> > diff --git a/drivers/dma/cv1800-dmamux.c b/drivers/dma/cv1800-dmamux.c
> > new file mode 100644
> > index 000000000000..709414898b67
> > --- /dev/null
> > +++ b/drivers/dma/cv1800-dmamux.c
> > @@ -0,0 +1,267 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> 
> 2024
> 
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/module.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/llist.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/mfd/syscon.h>
> > +
> > +#include <soc/sophgo/cv1800-sysctl.h>
> > +
> > +#define DMAMUX_NCELLS			2
> > +#define MAX_DMA_MAPPING_ID		42
> > +#define MAX_DMA_CPU_ID			2
> > +#define MAX_DMA_CH_ID			7
> > +
> > +#define DMAMUX_INTMUX_REGISTER_LEN	4
> > +#define DMAMUX_NR_CH_PER_REGISTER	4
> > +#define DMAMUX_BIT_PER_CH		8
> > +#define DMAMUX_CH_MASk			GENMASK(5, 0)
> > +#define DMAMUX_INT_BIT_PER_CPU		10
> > +#define DMAMUX_CH_UPDATE_BIT		BIT(31)
> > +
> > +#define DMAMUX_CH_REGPOS(chid) \
> > +	((chid) / DMAMUX_NR_CH_PER_REGISTER)
> > +#define DMAMUX_CH_REGOFF(chid) \
> > +	((chid) % DMAMUX_NR_CH_PER_REGISTER)
> > +#define DMAMUX_CH_REG(chid) \
> > +	((DMAMUX_CH_REGPOS(chid) * sizeof(u32)) + \
> > +	 CV1800_SDMA_DMA_CHANNEL_REMAP0)
> > +#define DMAMUX_CH_SET(chid, val) \
> > +	(((val) << (DMAMUX_CH_REGOFF(chid) * DMAMUX_BIT_PER_CH)) | \
> > +	 DMAMUX_CH_UPDATE_BIT)
> > +#define DMAMUX_CH_MASK(chid) \
> > +	DMAMUX_CH_SET(chid, DMAMUX_CH_MASk)
> > +
> > +#define DMAMUX_INT_BIT(chid, cpuid) \
> > +	BIT((cpuid) * DMAMUX_INT_BIT_PER_CPU + (chid))
> > +#define DMAMUX_INTEN_BIT(cpuid) \
> > +	DMAMUX_INT_BIT(8, cpuid)
> > +#define DMAMUX_INT_CH_BIT(chid, cpuid) \
> > +	(DMAMUX_INT_BIT(chid, cpuid) | DMAMUX_INTEN_BIT(cpuid))
> > +#define DMAMUX_INT_MASK(chid) \
> > +	(DMAMUX_INT_BIT(chid, 0) | \
> > +	 DMAMUX_INT_BIT(chid, 1) | \
> > +	 DMAMUX_INT_BIT(chid, 2))
> > +#define DMAMUX_INT_CH_MASK(chid, cpuid) \
> > +	(DMAMUX_INT_MASK(chid) | DMAMUX_INTEN_BIT(cpuid))
> > +
> > +struct cv1800_dmamux_data {
> > +	struct dma_router	dmarouter;
> > +	struct regmap		*regmap;
> > +	spinlock_t		lock;
> > +	struct llist_head	free_maps;
> > +	struct llist_head	reserve_maps;
> > +	DECLARE_BITMAP(mapped_peripherals, MAX_DMA_MAPPING_ID);
> > +};
> > +
> > +struct cv1800_dmamux_map {
> > +	struct llist_node node;
> > +	unsigned int channel;
> > +	unsigned int peripheral;
> > +	unsigned int cpu;
> > +};
> > +
> > +static void cv1800_dmamux_free(struct device *dev, void *route_data)
> > +{
> > +	struct cv1800_dmamux_data *dmamux = dev_get_drvdata(dev);
> > +	struct cv1800_dmamux_map *map = route_data;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&dmamux->lock, flags);
> > +
> > +	regmap_update_bits(dmamux->regmap,
> > +			   DMAMUX_CH_REG(map->channel),
> > +			   DMAMUX_CH_MASK(map->channel),
> > +			   DMAMUX_CH_UPDATE_BIT);
> > +
> > +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> > +			   DMAMUX_INT_CH_MASK(map->channel, map->cpu),
> > +			   DMAMUX_INTEN_BIT(map->cpu));
> > +
> > +	spin_unlock_irqrestore(&dmamux->lock, flags);
> > +
> > +	dev_info(dev, "free channel %u for req %u (cpu %u)\n",
> > +		 map->channel, map->peripheral, map->cpu);
> 
> debug at most please
> 
> > +}
> > +
> > +static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> > +					  struct of_dma *ofdma)
> > +{
> > +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> > +	struct cv1800_dmamux_data *dmamux = platform_get_drvdata(pdev);
> > +	struct cv1800_dmamux_map *map;
> > +	struct llist_node *node;
> > +	unsigned long flags;
> > +	unsigned int chid, devid, cpuid;
> > +	int ret;
> > +
> > +	if (dma_spec->args_count != DMAMUX_NCELLS) {
> > +		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	devid = dma_spec->args[0];
> > +	cpuid = dma_spec->args[1];
> > +	dma_spec->args_count = 1;
> > +
> > +	if (devid > MAX_DMA_MAPPING_ID) {
> > +		dev_err(&pdev->dev, "invalid device id: %u\n", devid);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	if (cpuid > MAX_DMA_CPU_ID) {
> > +		dev_err(&pdev->dev, "invalid cpu id: %u\n", cpuid);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
> > +	if (!dma_spec->np) {
> > +		dev_err(&pdev->dev, "can't get dma master\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	spin_lock_irqsave(&dmamux->lock, flags);
> > +
> > +	if (test_bit(devid, dmamux->mapped_peripherals)) {
> > +		llist_for_each_entry(map, dmamux->reserve_maps.first, node) {
> > +			if (map->peripheral == devid && map->cpu == cpuid)
> > +				goto found;
> > +		}
> > +
> > +		ret = -EINVAL;
> > +		goto failed;
> > +	} else {
> > +		node = llist_del_first(&dmamux->free_maps);
> > +		if (!node) {
> > +			ret = -ENODEV;
> > +			goto failed;
> > +		}
> > +
> > +		map = llist_entry(node, struct cv1800_dmamux_map, node);
> > +		llist_add(&map->node, &dmamux->reserve_maps);
> > +		set_bit(devid, dmamux->mapped_peripherals);
> > +	}
> > +
> > +found:
> > +	chid = map->channel;
> > +	map->peripheral = devid;
> > +	map->cpu = cpuid;
> > +
> > +	regmap_set_bits(dmamux->regmap,
> > +			DMAMUX_CH_REG(chid),
> > +			DMAMUX_CH_SET(chid, devid));
> > +
> > +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> > +			   DMAMUX_INT_CH_MASK(chid, cpuid),
> > +			   DMAMUX_INT_CH_BIT(chid, cpuid));
> > +
> > +	spin_unlock_irqrestore(&dmamux->lock, flags);
> > +
> > +	dma_spec->args[0] = chid;
> > +
> > +	dev_info(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
> > +		 chid, devid, cpuid);
> 
> Here as well
> 
> > +
> > +	return map;
> > +
> > +failed:
> > +	spin_unlock_irqrestore(&dmamux->lock, flags);
> > +	of_node_put(dma_spec->np);
> > +	dev_err(&pdev->dev, "errno %d\n", ret);
> > +	return ERR_PTR(ret);
> > +
> > +}
> > +
> > +static int cv1800_dmamux_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *mux_node = dev->of_node;
> > +	struct cv1800_dmamux_data *data;
> > +	struct cv1800_dmamux_map *tmp;
> > +	struct device *parent = dev->parent;
> > +	struct device_node *dma_master;
> > +	struct regmap *regmap = NULL;
> > +	unsigned int i;
> > +
> > +	if (!parent)
> > +		return -ENODEV;
> > +
> > +	regmap = device_node_to_regmap(parent->of_node);
> > +	if (IS_ERR(regmap))
> > +		return PTR_ERR(regmap);
> > +
> > +	dma_master = of_parse_phandle(mux_node, "dma-masters", 0);
> > +	if (!dma_master) {
> > +		dev_err(dev, "invalid dma-requests property\n");
> > +		return -ENODEV;
> > +	}
> > +	of_node_put(dma_master);
> 
> why do this if you dont need it??
> 

This is a pre check. It will issue an error if no valid dma-master.
The dma-master is used in the route callback. Is it better to just
leave this check in the callback?

> > +
> > +	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&data->lock);
> > +	init_llist_head(&data->free_maps);
> > +
> > +	for (i = 0; i <= MAX_DMA_CH_ID; i++) {
> > +		tmp = devm_kmalloc(dev, sizeof(*tmp), GFP_KERNEL);
> > +		if (!tmp) {
> > +			/* It is OK for not allocating all channel */
> > +			dev_warn(dev, "can not allocate channel %u\n", i);
> > +			continue;
> > +		}
> > +
> > +		init_llist_node(&tmp->node);
> > +		tmp->channel = i;
> > +		llist_add(&tmp->node, &data->free_maps);
> > +	}
> > +
> > +	/* if no channel is allocated, the probe must fail */
> > +	if (llist_empty(&data->free_maps))
> > +		return -ENOMEM;
> > +
> > +	data->regmap = regmap;
> > +	data->dmarouter.dev = dev;
> > +	data->dmarouter.route_free = cv1800_dmamux_free;
> > +
> > +	platform_set_drvdata(pdev, data);
> > +
> > +	return of_dma_router_register(mux_node,
> > +				      cv1800_dmamux_route_allocate,
> > +				      &data->dmarouter);
> > +}
> > +
> > +static void cv1800_dmamux_remove(struct platform_device *pdev)
> > +{
> > +	of_dma_controller_free(pdev->dev.of_node);
> > +}
> > +
> > +static const struct of_device_id cv1800_dmamux_ids[] = {
> > +	{ .compatible = "sophgo,cv1800-dmamux", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, cv1800_dmamux_ids);
> > +
> > +static struct platform_driver cv1800_dmamux_driver = {
> > +	.driver = {
> > +		.name = "cv1800-dmamux",
> > +		.of_match_table = cv1800_dmamux_ids,
> > +	},
> > +	.probe = cv1800_dmamux_probe,
> > +	.remove_new = cv1800_dmamux_remove,
> > +};
> > +module_platform_driver(cv1800_dmamux_driver);
> > +
> > +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> > +MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series Soc DMAMUX driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.44.0
> 
> -- 
> ~Vinod

