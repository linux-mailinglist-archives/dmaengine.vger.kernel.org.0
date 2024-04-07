Return-Path: <dmaengine+bounces-1757-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D589B0A4
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456A02823E6
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5A200C3;
	Sun,  7 Apr 2024 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X4Wz4jRV"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2070.outbound.protection.outlook.com [40.92.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008820DCB;
	Sun,  7 Apr 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712489796; cv=fail; b=EDTcZtZFoH/503GWYTdLxen5a7q54DeMURuZtGsQALUO2KBz7F75wMDFRzpdJxMrXhq5fGDiQSdN4mAFpg16XV/zJ+JDpCdgiin3YmqCBq/ayrRNQh8Iny8RsOz5lXRxaeS2EFOd+Ln2xojXFyPade7k2RHyCXk/6YZqTTiuJNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712489796; c=relaxed/simple;
	bh=mvWMIuQOFlMghNisKUH2uJZmTTs0PXrN1jF9FpFy0rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aflAtscusFbMUSSkxIDuhJXRhipSfBAopnNRlCAKdFJWKZHKON1i++3wEjW/L6fiSBqdWwTHx91If2l2Z7mkEkBY+DpZ6Yc4d5y8eWX6Ee1jtu+SnvzDBn1v61AUE9BBXrRpEqmzo7Oc4cPrTqHErn/Z0vwWrED+5/lDjxL+YKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X4Wz4jRV; arc=fail smtp.client-ip=40.92.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo9lqIS2ZEtAXGfMWI+SxFpM2vqle00c82SdkHocudG6TVlGgFif9/IuB5eUThv7pR365AC6WX/rKDjtgtoxXxzGcLJ7RIlxBkjb8sCtJN+azK+BggGFCBUxkXIwGcQVfyrzj0Qf59SS+ftFiztFa0gqMFyJjkQ3toU681Vp6b9TJNz5d8J9ndEPOa5wu3yu4odLT7fIhpINKRgLqweqRAu6HRcN2sNkysl8RGunPv0GxAUDm4Xu66iHnv8t7jDVa+Ye7UtwMl5//OVqTjmx0rwvZXDl48e5pXlT0nRXEWRYjcSfiysr+dAs79bYudGNtO+dtj/mW/MuNO+Xyu3RpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzuQcScm06m66ilK3+8qeU27XOQkDJagxgV7WkJTy9M=;
 b=OMC1P8iI04rw7g6XxfDAogh8PL4OaUFkyMbCGiGHHddinqytngQw/WZC3UPju9n+HKMN8SqJ2EnjAgPJaKDckM86Sxf5e6swg5pac36R4GXOIuPT7dn9J2fZpGGQYtv1Iah/Z0gKyxyV0a8LKiydqliYvTBJrpGQbndsbIyovawO3axHcm7qwJPGHGKPy2OmkB11AKY7rsw3WhCAThGXg81L0sB44AcTrP8i912Zav4xvDDHV/dth9xxSB++feYq1Mkt16ky/YWPwRRZ0s0UuV3HsBFMHYmOqZ+4AEZ99uoufxypoCzBVCgsDyyz/Gbo2zJHFZFXjD1kxlF6UXuSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzuQcScm06m66ilK3+8qeU27XOQkDJagxgV7WkJTy9M=;
 b=X4Wz4jRVaW16yUeS2A7Qs7RQXWmFHSKkxZEVwLZzgH/9aiL06+ZjMbduMMpntcF2guaB2Sr90JAmCRXBo//+O2Z5R6jPLjCn/ExSLnYh4QpsT5hnbejMJMIzxDAJpw2UBU94e/Hdu9pjsleVXMFFPbAVRqYdPZKb16SMrEpAj7KZcnipHUn7GaxuAk798EiB6bdKeN6Vy1gjKDvZ33uxH+3LxFlJmwp0x5fMWkHs4ooQt/kSsomxlxyUSQW01UXlOZXsb/M0ZWzo2K3a+kY/DUOZB8kYKRvoXu3aka9tDpN9Frj+EIHxEh/iaWVRrV/RVQetuf9oNIAN2W1836fC8Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB5177.namprd20.prod.outlook.com (2603:10b6:303:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 11:36:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 11:36:32 +0000
Date: Sun, 7 Apr 2024 19:36:46 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID:
 <IA1PR20MB4953A753379B286AFF2D7742BB012@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49532FB358A842A2ACC5E878BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZhKCHlAYxnhhcKnt@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhKCHlAYxnhhcKnt@matsya>
X-TMN: [cFCt/A2uZCt6UpleQzKRs6S22X87BCkR+wkLMwzqyhU=]
X-ClientProxiedBy: PS2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:300:55::27) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <cuovund3btb2ltpx5yzdcdom2yh5vasjvce674qdw4kkt3mgf4@dc7t32tcowv3>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 963edc1b-8b1e-4b0d-ff96-08dc56f6f91f
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3gprAXocQ+93nSdO0fpEPu75E5lWyuNe1m7z6PT1a0ar2xvEQ0TLTNlJgYv9/meye+qgMWv8+EOD2fZkE9//NuS5di6x6aotTcVSwBqS/2pfaw7DNnUAN0XuOJOxqVTP33RypBrpRgRQAC2xkxcE1T7IhoLDl93b0HZNVcka9R9hekFRoQL87PrlPJWXnuEZVo1l4SEeE50U/J8o5L4GgpbMVAO1x8lhpPA3/l4sjHR/lBKGxTorFA2ucF5Dt5LfmLb295jJQC0qPcyi7Sv31QYWqhp2J+4yKy2oSPMx42cI8BnAUcjp+Cfu31RLm/jkOLMB4+HfigFCV96rkpoLI7C65tAe3Avv7WPJhMXqi8otNlyS7/95hzbunhloVax/sXxiJl5s0o0aY2FrpWzRzVvcQz//Dw6vhERf79FlAWhC5WHF5ZvdT6mFGFStfIH6R1RllVsZHHND3qNgJFD7/Ko+wbMJ406mUVcYJAzr5qKsPBI4owQGoHa38YpR5glAhUc8U5TiZ4PCp8ktivuQofX7lf2Uhn5DmkWlTZiABp996PSrcpsKL7aWVIBh3tDNBOMfRyVvKdBs2MiRnoJKts+AC2m2yckA8wCHJgLw41nqIJlXyAX+dlwUcZvCQQC7IlODS1qcZW8ED+rK0C2ZvJhLdRdcFNZtc7uhMsw9AKbWIHXB6BqKLVZei8pqgD7qq46YpZeFRPCPOD1vDT18B7cjm9Cs4pH+j2HGGYw67LErCjSBU3+s0NL9Q8di1VNXV4JK2i9oSwpY25Ax9nYuZHgVKBbEwkm6JM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xgbvpRYBQBPrejOGgNMQSPTntcilmx6Xi4qwRGDXFoHAbpUZhh5USngF6flms6eJFIZkZmvjRlRtGQpG1aW/7PSgwvXeNhtvyNJc385rCkXS9l6oQyKmfIfgFPaFaXBjYJl98Rf0F4iqztycHmZZ2l5+rgxSzcHGsTHp7qC5PjXcbGje5JJqxornQlXFS5K8FXOyE3p66M0EsZCpSnGSMhw3H4k0G/voVrmMNY1FU1qYnT6Jn0eqxUaz8Cwa1VXFUEO+j8TtqJ7CKlRg8eRKshDPpZsR1+/tFR4lQ33OzSAtbBAVdP0cjuwqqTk7ANMnXKajCE/tyGkOdxIbJkv7pfV905MN83WXIKwNKv+mRDdcLSLqhjonr4SB3rOPDnoEW6gM8yTIVw8yffvF+zbiV3b/jb7V71DsmMLwl+X9NK2dqhfemkn3lVIrkwFZjdKGNZgyk7SLzJjfrOkOiRA7J5J92Eaan4ahyIedVdR3Yn2wkKsrXLTMppyFLngMyHtt5TI5KIqmcwYl/RN/3Bvjvyb8lOrjb6OZpuw+fx8F9RBU2x0JZRmr+YX+o6MgeghuEbofwdH8dAr4YREtId4ImYpw2FJL1NaQifgNwq2qXCYr2w0B/Tw0+CjBM+sIUbA4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XqjcLyD4oc9w3f44AjtAyCepCUhY3RwjH08yP1MkDvx4zLkswagKAabF3YC/?=
 =?us-ascii?Q?fdSKgSmhaXBElDBUR99bmCqFdr98US+QFSYFAObdVOM6vzL9mnD4dBSU0UwH?=
 =?us-ascii?Q?Rvngg56Or6l7oO+tE6s2Nc5FsGPnir2UkJBfmEe9hvdFM8X00gNGxrY/cqcE?=
 =?us-ascii?Q?9MlVPxGLIOflhUOi6hNVoJW++VhC7etuJa+s/T1Q+kKZr2ZgXZWwFYa74UzQ?=
 =?us-ascii?Q?IQy9sKnYhI4Kz21uNV1DT0o/VfNDvucXG6MIQVCzaSrb35eNlDcq/WTrQGa1?=
 =?us-ascii?Q?eSl/5XU8+iSMnbYTAsAXF+OTEQnW0EeOXcVpwHfyB+vCIQ7/DgS1Qk5IfzsT?=
 =?us-ascii?Q?AP0oCzzwf8nnlY701YMAEZsqK9Vro37H2fROeVk71964iErSH3FDUEGVoS4K?=
 =?us-ascii?Q?sENsYYH/FQWZoEdtxRbeLUeBjdRfD+bw13uLRAap9J8kiBZJ5sI6uyGwr+1a?=
 =?us-ascii?Q?GUsgqf3/lQlOClSCWe/XqeY0pTxbcRxLBAuNNn855HiQn36B0NbX37jdWPOQ?=
 =?us-ascii?Q?Y1UR+n4Wq1DBuIrBPQdLs8kzHCA+DkGGG6LZZv/HF3OWNfr3oBZQS28nD66K?=
 =?us-ascii?Q?FgNKCt6TmJXGB3S7T3jSUL20uy9Uir08agY/+v63xadUNRaGwsAznhcz4BUB?=
 =?us-ascii?Q?C4BPCDapt1pabQJcC5p5Q8+6HRM0XZ64INKL+YW4MMsBl7ozSVVITJwGdBeG?=
 =?us-ascii?Q?Fyu7d9HheZpM7aLMHX2XtJlM/K2rk1FUNKWDGpbAz5mvpFMX13YzoAas5/Ku?=
 =?us-ascii?Q?ES5PD6CKANUfOiBSiZvKOcEtOWUq+UB8l95taat2b+ofsq202qRilG5x1rkb?=
 =?us-ascii?Q?N2wk2kLcAm0WzFxZGGVprAeJp6zUA3lS2YwIRLtlm67iyxSr1u7FRpV25gP2?=
 =?us-ascii?Q?eOYioEY3x5RcIwufrId90XLsYgazWF3GkI/Rb6X96r6deP8Yv8kzrSU8oWxM?=
 =?us-ascii?Q?IQH3u0dtt+qIeu6rsbO57bWW0E94XSIPwzthNh+EXsM6uaIHuu0Ew0hP3Sbv?=
 =?us-ascii?Q?YYf84bYhqsEzBMWGjsTriMbGp3H/Y+ZWpEQrkQx3+OyaUy8twiUi7DBRkUds?=
 =?us-ascii?Q?tsyZHxBGmquK/LiZiaa9hIdKxl1nc+wwL8CM2sa8bEY6iSAp5PVsOoel4nYm?=
 =?us-ascii?Q?gBK4iUIzKMRUg6U8mrJtS5STukseNH9zG9LtuTN3vUF096UFvwr9zw3XzpwG?=
 =?us-ascii?Q?YqxzAD+f/0B+ePeCFrL+H9OgfaGZxT1Yd1DKwZM4o5ksNRbRiVqWfDjLJc9k?=
 =?us-ascii?Q?1F8Tv44HR8ylB3z02+b2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963edc1b-8b1e-4b0d-ff96-08dc56f6f91f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 11:36:32.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5177

On Sun, Apr 07, 2024 at 04:53:10PM +0530, Vinod Koul wrote:
> On 29-03-24, 10:04, Inochi Amaoto wrote:
> > The "top" system controller of CV18XX/SG200X exposes control
> > register access for various devices. Add soc header file to
> > describe it.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 include/soc/sophgo/cv1800-sysctl.h
> > 
> > diff --git a/include/soc/sophgo/cv1800-sysctl.h b/include/soc/sophgo/cv1800-sysctl.h
> > new file mode 100644
> > index 000000000000..b9396d33e240
> > --- /dev/null
> > +++ b/include/soc/sophgo/cv1800-sysctl.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> > + */
> > +
> > +#ifndef CV1800_SYSCTL_H
> > +#define CV1800_SYSCTL_H
> > +
> > +/*
> > + * SOPHGO CV1800/SG2000 SoC top system controller registers offsets.
> > + */
> > +
> > +#define CV1800_CONF_INFO		0x004
> > +#define CV1800_SYS_CTRL_REG		0x008
> > +#define CV1800_USB_PHY_CTRL_REG		0x048
> > +#define CV1800_SDMA_DMA_CHANNEL_REMAP0	0x154
> > +#define CV1800_SDMA_DMA_CHANNEL_REMAP1	0x158
> > +#define CV1800_TOP_TIMER_CLK_SEL	0x1a0
> > +#define CV1800_TOP_WDT_CTRL		0x1a8
> > +#define CV1800_DDR_AXI_URGENT_OW	0x1b8
> > +#define CV1800_DDR_AXI_URGENT		0x1bc
> > +#define CV1800_DDR_AXI_QOS_0		0x1d8
> > +#define CV1800_DDR_AXI_QOS_1		0x1dc
> > +#define CV1800_SD_PWRSW_CTRL		0x1f4
> > +#define CV1800_SD_PWRSW_TIME		0x1f8
> > +#define CV1800_DDR_AXI_QOS_OW		0x23c
> > +#define CV1800_SD_CTRL_OPT		0x294
> > +#define CV1800_SDMA_DMA_INT_MUX		0x298
> 
> Why are these register defines in soc, all the dma registers should
> belong to dma driver and other IPs, why do you need a common header??
> 
> -- 
> ~Vinod

This multiplexer is not a standalone device, instead, it is a 
subdevice of the syscon. Although it is better to add this 
header to the syscon series, the dma multiplexer driver itself 
depends this header. So I add the header to this series.

Regards,
Inochi

