Return-Path: <dmaengine+bounces-1440-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECC587F647
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 05:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56F41C2189E
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 04:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1577BB1F;
	Tue, 19 Mar 2024 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AR2B8nIx"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2056.outbound.protection.outlook.com [40.92.23.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B377BAFE;
	Tue, 19 Mar 2024 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821320; cv=fail; b=IQWGq7jAOsgYpRRn8encTzFJLnNw9MpOiHLzFgMZo5v7PQJc4ZS1+/hyN4y4Drt7E5CcVAus1FFrrVyrlzNjmU6k/qo55BEyuF5qSN9BHAmEOluLygoY30T+siNkuOVAzQ7LaDGtlqB+LlXDZlSP8Ge8RCMPI2LjQbJviHIAfdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821320; c=relaxed/simple;
	bh=CSH68xc4+ygSGsQib0s+P33iWoC8GRycQMweyWH9rxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUSUSbJm3rZpALXT3JbDiqFL8KonD2OaqqHofH5uepO4yGOcRoAy0BChl7eCI/Xg7394tYORskbsRcX2OQEVcpEuVD3QNYefTX9teMC5OCTqWHHHDlppuep23tthMaxqZNUE1FGEswuGnoxX+yzAWvU+guGs7IqNzXuYAopKsEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AR2B8nIx; arc=fail smtp.client-ip=40.92.23.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyblsf2t5H5R9e50v8x3Lg/7myU5POQCQSChRxrmB96/ZIOJF2svykEc3BiHuQy/DeeOXdfO7NGwEdJ2vuSPwFjR7A/6RBQwPfqUPoTn9nz+dc0yoDb5kRs32uiSGWgze+GY4PIvL/erWr9ZbFE33fmmV6vHD+ULVgkNkaXS58d7gn1g8ku1IsyCiH26Fk6YI1D9L+OI+tPJtnGcDWtA0LT2gdrOGT8uzGt10QtGs+YWUf6ST41qeggUSI2LMrpbqMZXg5tqM5BBldyKMYGv2DLxVY5iwyWb3QXRzVXvJhyStl/Uv/Bmkaj/EyoAWgJUC3qL+eCf6OM/FhEnxp/i7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaxB8w1dcCJpIb+G2KDmuG/10oXZREFrxhJEtPrbS8M=;
 b=C5UcFN8W4AB2Q6qRhMSACiIateZQMf35GUSOXfVAXjhxO8dVnfRgR01GF/8ZTWBTBIeASGTQeTiyUfT06MYUWr4yZCGzvn1Hoto4KATKPwYUROfea8klLn5OJSrwHV4c71Qtm1b5u06yWAzI/P6YF8MeAo4G+jh67wHU/IRIw5uoP8qHOBuWTMHaimNTq9veCE1jK7zGJtrix2DYugE1HFSDhZYNVmkvZmc76N8KJDGj2eP8wZZhdJ5oCl4xFQ8/Z3JHwn5fdpAgWtv0KQThHxUVfmVlcH2OvD5lZZ2d1Qhju6dtQ/xjIpk0NvGZg62e8EiFwU6NEdajikxScC07HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaxB8w1dcCJpIb+G2KDmuG/10oXZREFrxhJEtPrbS8M=;
 b=AR2B8nIxS5eB+0Ql1I9ZHVvEFf5CByfCtB9wcXQHsEEPB1ulqsfgMsk1XRXXOV9ambitZvgRBjjsZdppCosI/82XkJL9fNtrn6SrucJpFJrNBLP/gV0xnp048Ur1aDo3AtZg6mAbG8TlWsHiq2Vda1Lguizcpm10yomu3aOWO+IOten9qMUwVC2FZxA0naDCZgKQTe42Q7ionTW0kqMZEeMAsUnOwbC1apskxExih0TyWhTCfLEelAfyxNL2ZVB5d3zAoaxkZyaTjWgWIwtb1pU9jfz3PIL30HyNXbs03n03pJQA2mAJypqw5YwvGsNUlRPre4a/HjgrqZFIRRUZaQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB7069.namprd20.prod.outlook.com (2603:10b6:510:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 04:08:35 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 04:08:34 +0000
Date: Tue, 19 Mar 2024 12:08:03 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Samuel Holland <samuel.holland@sifive.com>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 4/4] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
Message-ID:
 <IA1PR20MB49530BA6C3CBC3C59C1187FEBB2C2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49533E6C8C18337E5F6519D0BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <6d901851-ad57-4ba0-8503-076a0d3e430c@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d901851-ad57-4ba0-8503-076a0d3e430c@sifive.com>
X-TMN: [zDcy2PQJPQ0CGfXz6cPZE0lWGJ1ligIzf/CvJhtV1Cg=]
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <6v74syza2mffyk5avsgy5db5jolind7s74xzqy6tyc5h4exfgy@ztwvptlplmlm>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2e44a4-0102-4a71-3af2-08dc47ca3136
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qUQWS8lN22nUCivNlPfDo3sNiWk0dXlEJg+ZrB/z/O5Vhr4lCyc8XxMLEP+B5bTabCBXi7k5EnBa+z0io304sFQzpaCSEMvK52IcCDzZ4yjd77DxXSQqZcTghSmYsomPXPFeOq0cRGf+p7tKd3Oalp/4UQ2x+sUIsx1p97IGVuZAkjf52vrVxBv/FFckNqOq/idvJs2MCjFydjGmauLRp7FBLNSr1nJDU9uSklTrQDRMIMPceVONH2HzrzlIbWDfwAMiycmnKxjTHjtsU9CrwbwfE8gIgN8WBPj3v+4IRgSX6ciSSFTCxnIIGdRD1ofrsmeKpU+6FrZQjTE1Qkf2lM7jbcZYHcQ/qljsbA3BLOz+KMBzhEN/uUl71Jl/bhCLtg4OIL6DQGgJ3bXwGCa9gEm51MJxIWbJO2cehqbOclbtPtjmUjrGJrt72rsVML7I33GRGeewcqLAbG+ooEHsNbEwaNWEoh5y/0r+QaV5TFQDWXc0cLx9Vy8FU7S79Oyt81NwLAF5QY4kwuuJ1Ggbb4qYV3GNrafrqWVBrdQ17/7idLVGaC2qLSTxoFAuJ3VTxD48p0+g2HMAQH0vopFDLERPKV/mFgBaLIQPAbeRG419byw2+fxVX1xfpLSjRg4T2Fe55tnntxbEnofDyPj8fcG4M2O7XdzJKNiijBAD2AMCyBXwu4HEyydFttVOPmZlmI+9OyDtH4tUfN9Uzg3bG/hl0wwFm7dt4gJw6G7mmZYzp6i9JUXOAgHwCHYrjiTa7oHYZXqnZXM63i1eLZzor9xh4zWjWnZ5uep9MhIunkyTsUabEUYo500Qh9d4sddfqwnxNPVVDdzsk7KjX7LyGsL
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tkuu3aG/bP6yCvsIkD+JMkdIxHZMiO48itXK8HQfDK3JnmbbG66N3D10cYSUoSLiE2iXN/2JpTAaGe1Ba17wiHwN4l6jNX5bFjlSxOmfMdlvTvriuEhOgFsCKKPoTJHuL+C5YfXXrDIgdn6AB2ctu1PbsyLOnqxvV05ofU6tfuTZGTrGbUBZitCxGUoikjr++tLdvn1778ehenvnADTMc5AAdFBQ/j6wcmAGN4yKCErBOyf7Ltm+wpffQ7hCB8HnBGehvh9t7PPT9vDYgjqCjQHsAqZ10o4UdFYJDfxqfo/RInNjeC8BSIg0PKNr0qSLZ98Bcl9JKx9BT2bEqKQy6t9nl2x2QhBsAH6Kra+tvjFrB2Xi3aDbQUFHvmSvtOraG+xTWxPQvn/69CmrQr4gYHwAR9VlfP5kX+eKtnUzFB8cMmLM3SOotjWHtsuYwhw45SNPM7aEwN9skrirne0+x31MPXj2tiKgJydGL+8FgNoXHnTWS4RtzmAZloRkZQOexjQe+Ftv/QUSmj0k5D6SXEOClUObTbbBPvYTECBr3Pq1So4/XkDTdLKghf2JKG8PqC5p9PPc9uhUxs+doGvGskMavalKmfgy/E7NWMwCn0jBYwwkTHGrS9zhblGFXyrqaCSYkkxhA9G35YzOnF1xiKHOEuk97vR9fh5uHmQED7gYQCtgdEcDFuy989JLby03
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/u7dXKFS9EO0cWlWR1SxVFU4KOLIOr8Grq8+8lEUO4MIKMgIQWvAfhoNIOL8?=
 =?us-ascii?Q?Y6JcOcI10m7oalVdUOK062tlKqZiGLH8AutMT/dbZFhD/LjWRnYErDK84VJX?=
 =?us-ascii?Q?pLabP/4KMexOWiNwzeTnwWnp9jYiftxmS91MFKr9nZP/ZYUvucLlnI54Hs0d?=
 =?us-ascii?Q?DJjlI4rQlVFZ6KKsw1DT3uUp0ruatjfthF2i7xwRHefxuSkXvZfJgLmNCo5i?=
 =?us-ascii?Q?23XxKnaamUoUKAWZzevvqVqviucFg70lkP5p4o1MdmIZ0meLONN1+3Rcutr1?=
 =?us-ascii?Q?cLoMrBxtIq06G0M4ULWSaTcNbDo+Hau3tdTC1Xj/Z77U13l12XO0JnnAg6Qc?=
 =?us-ascii?Q?rit5XfF0rs9jlA+CT8R1p6FOXubUihx20HCqpYcPx6OK7oLGgy8T2aG4LMCT?=
 =?us-ascii?Q?IObglqCFXOEME56SMwWc1Jut3rL7zannERebkeTa2WwcPCpRH4AfPxQEmZE9?=
 =?us-ascii?Q?t9cZZSfyyXtQW7MpGrc8FKy1FvcOjJEYf9qTk29Beh9Qgv3fv702LFm0tKeN?=
 =?us-ascii?Q?1uGb8LSr+qCbbZJ8QO2du8jsG926EzjjZGfDT923RkeYTAJvgS35L3YMVbYp?=
 =?us-ascii?Q?6vqm7KCx8kbqVPOx/fm981Yo7tcVFtrnZkQ7IcWjgEiKH4IX36QOlbAKErqW?=
 =?us-ascii?Q?PNi9y4YjaUdLWwbbmLsTdfynDDfugrnor0V97XV/VjEMohuRW9AtLLfsV+oR?=
 =?us-ascii?Q?+3wDRrH6Rw2VRTeuDPw03oclOjdiHp02L/pBJ66UDpTx0sgu7Iw0i88Fk98X?=
 =?us-ascii?Q?wrwOBfJ5HU96TzPmaZ0pgYzV2y01kunSwu3b3x5uuvUl3i7y7LlDiKV4scvd?=
 =?us-ascii?Q?3/xKDNmaAvJdAf3rAQQEIoJ91NSddmLK+IbgFPEij40lBOoZ5/SwCAQXavTY?=
 =?us-ascii?Q?yguzEyt+6kQbHNf8JgC+y9o+kx8lI8r29xbHEQf1pkYTbeHNycWJowRNrT3Q?=
 =?us-ascii?Q?rmm/o843FFfwS3FVOKCVJeW+kMSluNaitXMfn4trpM175yY4fEQ9JI43DmR9?=
 =?us-ascii?Q?3+OM3VekAhzFeLXKP4ZjCP+hoOCdSNai/vXCgDbB72tN00HiOSnQeUD/Cie8?=
 =?us-ascii?Q?sDwsi2u0kz0RpQAVrEDE5oItg82UClwdc+wJuCFIWT9GvLdVnqwWdQjA024E?=
 =?us-ascii?Q?PDylfm1QxKl6R/Kxs/j9xs6D/fDJs8jf7ZhnTiu48f2BHnrkZ9i461LdJaK+?=
 =?us-ascii?Q?ieB8op8PAiprDR71ARbkgiGrXTi26o1auvt9lf58uRpK11sMRaUmbd6WMquv?=
 =?us-ascii?Q?GMFcJ9Qel0WrautqvHoF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2e44a4-0102-4a71-3af2-08dc47ca3136
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 04:08:11.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB7069

On Mon, Mar 18, 2024 at 10:36:01PM -0500, Samuel Holland wrote:
> On 2024-03-18 1:38 AM, Inochi Amaoto wrote:
> > Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
> > its request lines. The multiplexer supports at most 8 request lines.
> > 
> > Add driver for Sophgo CV18XX/SG200X DMA multiplexer.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  drivers/dma/Kconfig         |   9 ++
> >  drivers/dma/Makefile        |   1 +
> >  drivers/dma/cv1800-dmamux.c | 232 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 242 insertions(+)
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
> > index 000000000000..b41c39f2e338
> > --- /dev/null
> > +++ b/drivers/dma/cv1800-dmamux.c
> > @@ -0,0 +1,232 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/module.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/mfd/syscon.h>
> > +
> > +#include <soc/sophgo/cv1800-sysctl.h>
> > +#include <dt-bindings/dma/cv1800-dma.h>
> > +
> > +#define DMAMUX_NCELLS			3
> > +#define MAX_DMA_MAPPING_ID		DMA_SPI_NOR1
> > +#define MAX_DMA_CPU_ID			DMA_CPU_C906_1
> > +#define MAX_DMA_CH_ID			7
> > +
> > +#define DMAMUX_INTMUX_REGISTER_LEN	4
> > +#define DMAMUX_NR_CH_PER_REGISTER	4
> > +#define DMAMUX_BIT_PER_CH		8
> > +#define DMAMUX_CH_MASk			GENMASK(5, 0)
> > +#define DMAMUX_INT_BIT_PER_CPU		10
> > +#define DMAMUX_CH_UPDATE_BIT		BIT(31)
> > +
> > +#define DMAMUX_CH_SET(chid, val) \
> > +	(((val) << ((chid) * DMAMUX_BIT_PER_CH)) | DMAMUX_CH_UPDATE_BIT)
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
> > +	(DMAMUX_INT_BIT(chid, DMA_CPU_A53) | \
> > +	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_0) | \
> > +	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_1))
> > +#define DMAMUX_INT_CH_MASK(chid, cpuid) \
> > +	(DMAMUX_INT_MASK(chid) | DMAMUX_INTEN_BIT(cpuid))
> > +
> > +struct cv1800_dmamux_data {
> > +	struct dma_router	dmarouter;
> > +	struct regmap		*regmap;
> > +	spinlock_t		lock;
> > +	DECLARE_BITMAP(used_chans, MAX_DMA_CH_ID);
> > +	DECLARE_BITMAP(mapped_peripherals, MAX_DMA_MAPPING_ID);
> > +};
> > +
> > +struct cv1800_dmamux_map {
> > +	unsigned int channel;
> > +	unsigned int peripheral;
> > +	unsigned int cpu;
> > +};
> > +
> > +static void cv1800_dmamux_free(struct device *dev, void *route_data)
> > +{
> > +	struct cv1800_dmamux_data *dmamux = dev_get_drvdata(dev);
> > +	struct cv1800_dmamux_map *map = route_data;
> > +	u32 regoff = map->channel % DMAMUX_NR_CH_PER_REGISTER;
> > +	u32 regpos = map->channel / DMAMUX_NR_CH_PER_REGISTER;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&dmamux->lock, flags);
> > +
> > +	regmap_update_bits(dmamux->regmap,
> > +			   regpos + CV1800_SDMA_DMA_CHANNEL_REMAP0,
> > +			   DMAMUX_CH_MASK(regoff),
> > +			   DMAMUX_CH_UPDATE_BIT);
> > +
> > +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> > +			   DMAMUX_INT_CH_MASK(map->channel, map->cpu),
> > +			   DMAMUX_INTEN_BIT(map->cpu));
> > +
> > +	clear_bit(map->channel, dmamux->used_chans);
> > +	clear_bit(map->peripheral, dmamux->mapped_peripherals);
> > +
> > +	spin_unlock_irqrestore(&dmamux->lock, flags);
> > +
> > +	kfree(map);
> > +}
> > +
> > +static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> > +					  struct of_dma *ofdma)
> > +{
> > +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> > +	struct cv1800_dmamux_data *dmamux = platform_get_drvdata(pdev);
> > +	struct cv1800_dmamux_map *map;
> > +	unsigned long flags;
> > +	unsigned int chid, devid, cpuid;
> > +	u32 regoff, regpos;
> > +
> > +	if (dma_spec->args_count != DMAMUX_NCELLS) {
> > +		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	chid = dma_spec->args[0];
> > +	devid = dma_spec->args[1];
> > +	cpuid = dma_spec->args[2];
> > +	dma_spec->args_count -= 2;
> > +
> > +	if (chid > MAX_DMA_CH_ID) {
> > +		dev_err(&pdev->dev, "invalid channel id: %u\n", chid);
> > +		return ERR_PTR(-EINVAL);
> > +	}
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
> > +	map = kzalloc(sizeof(*map), GFP_KERNEL);
> > +	if (!map)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	map->channel = chid;
> > +	map->peripheral = devid;
> > +	map->cpu = cpuid;
> > +
> > +	regoff = chid % DMAMUX_NR_CH_PER_REGISTER;
> > +	regpos = chid / DMAMUX_NR_CH_PER_REGISTER;
> > +
> > +	spin_lock_irqsave(&dmamux->lock, flags);
> > +
> > +	if (test_and_set_bit(devid, dmamux->mapped_peripherals)) {
> > +		dev_err(&pdev->dev, "already used device mapping: %u\n", devid);
> > +		goto failed;
> > +	}
> > +
> > +	if (test_and_set_bit(chid, dmamux->used_chans)) {
> > +		clear_bit(devid, dmamux->mapped_peripherals);
> > +		dev_err(&pdev->dev, "already used channel id: %u\n", chid);
> > +		goto failed;
> > +	}
> > +
> > +	regmap_set_bits(dmamux->regmap,
> > +			regpos + CV1800_SDMA_DMA_CHANNEL_REMAP0,
> > +			DMAMUX_CH_SET(regoff, devid));
> > +
> > +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> > +			   DMAMUX_INT_CH_MASK(chid, cpuid),
> > +			   DMAMUX_INT_CH_BIT(chid, cpuid));
> > +
> > +	spin_unlock_irqrestore(&dmamux->lock, flags);
> > +
> > +	dev_info(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
> > +		 chid, devid, cpuid);
> > +
> > +	return map;
> > +
> > +failed:
> > +	spin_unlock_irqrestore(&dmamux->lock, flags);
> > +	dev_err(&pdev->dev, "already used channel id: %u\n", chid);
> 
> This error is already logged above.
> 
> > +	return ERR_PTR(-EBUSY);
> > +}
> > +
> > +static int cv1800_dmamux_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *mux_node = dev->of_node;
> > +	struct cv1800_dmamux_data *data;
> > +	struct device *parent = dev->parent;
> > +	struct device_node *dma_master;
> > +	struct regmap *map = NULL;
> > +
> > +	if (!parent)
> > +		return -ENODEV;
> > +
> > +	map = device_node_to_regmap(parent->of_node);
> > +	if (IS_ERR(map))
> > +		return PTR_ERR(map);
> > +
> > +	dma_master = of_parse_phandle(mux_node, "dma-masters", 0);
> > +	if (!dma_master) {
> > +		dev_err(dev, "invalid dma-requests property\n");
> 
> This error message doesn't match the property the code looks at.
> 
> > +		return -ENODEV;
> > +	}
> > +	of_node_put(dma_master);
> > +
> > +	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&data->lock);
> > +	data->regmap = map;
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
> > +static const struct of_device_id cv1800_dmamux_ids[] = {
> > +	{ .compatible = "sophgo,cv1800-dmamux", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, cv1800_dmamux_ids);
> > +
> > +static struct platform_driver cv1800_dmamux_driver = {
> > +	.driver = {
> > +		.name = "fsl-raideng",
> 
> copy-paste error?

Thanks for point it out.

> 
> > +		.of_match_table = cv1800_dmamux_ids,
> > +	},
> > +	.probe = cv1800_dmamux_probe,
> > +};
> > +module_platform_driver(cv1800_dmamux_driver);
> 
> This driver can be built as an unloadable module, so it needs a .remove_new
> function calling at least of_dma_controller_free().
> 

Thanks.

> Regards,
> Samuel
> 
> > +
> > +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> > +MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series Soc DMAMUX driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.44.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

