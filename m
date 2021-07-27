Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AE3D70A9
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhG0H4R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jul 2021 03:56:17 -0400
Received: from mail-eopbgr1400139.outbound.protection.outlook.com ([40.107.140.139]:64032
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235824AbhG0H4P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Jul 2021 03:56:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faW9hnxN0hA6ut8XPyk8UQLhnPyyYCWUPRLGEJrnRSz87llwG6Xwdi7V2bNBflEyJCY6DPCECVSDJugJDraJ7sjGP3Kavshx6J49IrHHntxM8LMWxF+MsIhquOJRXDFjhOzn6QldFYrTQPC/ZNSMRASbfEAWTK9Rt2VHZucVOzBWbSUtDivdCMtf5c33Te8ayhsVmGcEk9H2L0Gm9scD5/kmxsJu2mZdb365IfCWGnNTGf+7mC5MxsPioq9zwPhM5kMxcZh+ApcvRwL0eE384fzvJ7BRerGqEivdQxOjbSwCLhCR4X8mo0rdcNCFJJHekGZI85BcuLfoVBQJvfQimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAYUKtX3ANcjpJUEXf23+vC0uoOwFXPzymrpBBBNGhM=;
 b=X1aOY4H5ze5ELv062+uoxwT4s6W79G2kIdcVfOUXSdDhZ0AxELyLwhovDmM4CpCyInd4DtzF4kz+5dodzjWhv30f/OsNj5LtyztMXsvZYlOOQFQYF3ChU6aOiu+yNiatymMP05JUKfYRopEqBcC0bqWCyQxDU/fLeiclFK646CDdLYolRIbPbPxNc5CLr77t6mDsbuXn5xyKVdg3Jix4YI2MIvf0eKOtxZ6n/5N3uHMzVw0LM+GDfXlc4HEZN7Pvk5Gt7QwseY9Vb2DfjKKHnyrZYvTTTMKb4FdvhB5HUy5SWZs76bB9ABat+F1YvODK4TUy3Eq2Q4wdVw+Cjx1Org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAYUKtX3ANcjpJUEXf23+vC0uoOwFXPzymrpBBBNGhM=;
 b=AalVSYY5b4YLow1En8kcyVMeMGGqB9ewqzNGJxG7ohUVJDYhAgj144a3RRP3mO1w5tMvaABkC6/W7u90Qf5sfiaG26sIxTK283NA/fstuWgr7ufymOeAfofHE5vse+OzQfMgDsbj6Unb+4eOap0FdQTHxkF31lKnPbPNqcClGVc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB6481.jpnprd01.prod.outlook.com (2603:1096:604:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 07:56:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 07:56:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXfIANJc0R/9gnn0any8kXgzWfvKtWgIXg
Date:   Tue, 27 Jul 2021 07:56:11 +0000
Message-ID: <OS0PR01MB592222A94FDEC92FFA071A8086E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210719092535.4474-3-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c2c0292-6900-48ed-3697-08d950d4006f
x-ms-traffictypediagnostic: OS0PR01MB6481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB6481F08217404EAA6A98418F86E99@OS0PR01MB6481.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:151;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n199MSTV94EitLSsSMTl2J5dovu5A4kBAnnEIzccI7qC8QRimxar1/lnxviKQC08Hg4Iu87EVBFFtiC1Xie4LDuUihO4p4bb9fK3R6MHhWNYIdQsHt/gDtRlmq+a5bQBkA25kuHJ8DzBLYyYxnErbu/LefIemP/S7ERkzLPl+GohWeFChf7E8JWbmwOKU2AbYxTxglqf8/ciEpS8bkYLP0EbnMn+uoEd6BxrABKNBZ7w5+TNT4SO1DPIE79eD8gZXkmGBIWubffEj5OoLHYIm0UN4JJtf0sumu8ELwdFukrjM+coqnthFQkIW5yLCl/KXwqB4HkwP2Qm2Q/yLNTOcrNAIQSM2Diuw3qRK69rGcPlV//oZFPzl473+lB8kJE8OF07rqxg8ovzH2aAl29WuY/fmeMbpK9W8mHILB9tv3cC0Vc1k2Yimc8bk3p30AxZNmhseYWf7oXE4sl4/xwffCVhaZJj3TbxUSWqsgvNY+iRYO041plY5OY2YEGiOhzVOfXxrMMrLAzmRfwndjV/T54Y4NmTssimCiWOreR7T7xoGeni3w7OgpLE2ivvmw4+EHvA7ef5TKVjXSpDMhIKpPHoPaMxI9I+Jnmezgam/HyuhCvaYZM4uGE6f+Mn6W/8L+ZyrHVI3p/wUfv1CPO/kLg2JTICNNKcmlVh/Yjjh/hrok1gsbruuH6UBQeFWi0kHVngZwhp09UnevcoIH+eV1Wsd27QYYxPHiyLBEL3n/KoCWjdC7b323d1bIHqEcGbmeywPjLW6EzAehb0F7m12f3mgHdTT7F8F5Kqhi3BWFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39850400004)(6506007)(30864003)(9686003)(8676002)(86362001)(55016002)(26005)(52536014)(71200400001)(54906003)(110136005)(66476007)(64756008)(186003)(66556008)(7696005)(966005)(76116006)(66946007)(5660300002)(4326008)(83380400001)(66446008)(8936002)(478600001)(33656002)(2906002)(45080400002)(122000001)(38100700002)(316002)(38070700004)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MPw4dakxidyG6KZTc7zeN6aceB0vsaaqKEnzLXQCIVupu9i93wfpEvnoOfZy?=
 =?us-ascii?Q?6aGx/G9gwU062aDudav2LxiMHjroyGPMxunOuQ/fgcJXGTtjey3wSfxyOCLk?=
 =?us-ascii?Q?Z4g1X1urZ7vVQKW+3tU/RKruh02TSaN7mlAg3LhvLiDBaLN3k736N+YEZQS9?=
 =?us-ascii?Q?an5B0uT7cn9dlrXmiiBx9beIfUbWCWr2CN+MpuuXbCPA6ejQapGGI2mb4VVw?=
 =?us-ascii?Q?g7pYa0KoBso6XpbKdZBTuwqUtiLKQokMl2eTWw31Z44c9a+l4k1JVYmA3pG+?=
 =?us-ascii?Q?45psnTKW5cbB/Hy9WWoEBcsW3n7QbKlhU4LMlIyqkhl4kN3kVWFkIPFtk9Ny?=
 =?us-ascii?Q?OMM1a6+NhzD3b7SfMVwgHJqrfZEUTaIp9fjQs2SOovp/69X3W3N5kJ9oSGPo?=
 =?us-ascii?Q?eEnhwR8fBLNrAUx42TSfrWw+kJ4b8rInbrUpvvXiXVkGzs6e2fN0G499DYJd?=
 =?us-ascii?Q?Dkb6zU3xZVm1f8iE/1pykM377AvXLy5PL283r51XIsUen5TWY1hQbahPGp0h?=
 =?us-ascii?Q?JSzVYFwJwdDZcXrp1k7+nhPref+0kxPMZIrYWv8xxNP/boLF/jR5LNo6A+Jd?=
 =?us-ascii?Q?r8FluYlqei/Bu4sGPXizvkd7yp9snpjReAwyKcXDDp1qxn+Ejg5PDVg9TGDm?=
 =?us-ascii?Q?2YRMrnoBTSyrVJ8E7upZB8nazpUXfC3FysI8PUGvJm48ptRoJy765O0Q5mpI?=
 =?us-ascii?Q?EU+V2O6zNyJJ94fHGB6fHTcqy8T6lDwv+dKsnGPxYLdyJSip1uQU6a5QlGX+?=
 =?us-ascii?Q?W67mki2Xd/U4suEBhYrI+QwvSAePWpnKDVXYm90OgBUbg23MZTECfC3jJt/i?=
 =?us-ascii?Q?JynHMGZyYZHIHj3ZkW8W/iguaLnE1hGn/DqlC1WxXksSnKMmzlda8pbz3q+i?=
 =?us-ascii?Q?/rfALqLlaXttZ7++E+U4kysk+4BGRdEWHvE17KVfAXH+4+LnsHuRIjTjWtlX?=
 =?us-ascii?Q?45h91I8imFJKJxCEDygeiKPUGCW9wrmS+GGDIIQAZ+qnBAnRZCgLTyBt4U+4?=
 =?us-ascii?Q?zxz/JuSfJ9HevoTgGQjMQhlJ3gPs1uuu7rFn+1MIjLryoffIKxPqft2zAL3P?=
 =?us-ascii?Q?XC5TiwisHhNuAESLzN44q1TgUsYrs8x7w0F9tKyk0VGA7dwz9F4WdDUQCZDJ?=
 =?us-ascii?Q?tGP0BaOob5NQVLaNrIRYcibzYSXY1vI5VItGsLD+JeR9RYZ7gujsC+0Ll1oC?=
 =?us-ascii?Q?1vImRtRy9Pgr5qGdiDCytAdmo+iZwp6ZAxYzM+OMY3FMRuXfjXx9HR2txeom?=
 =?us-ascii?Q?WHvioKsi2gjlmmzy8UZ/2l2iJCdJ+uTwSfuTq7YNRV4qplhREWu8pAV7h2jf?=
 =?us-ascii?Q?bTnPohSYOIJTehcyYsfRrvWV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2c0292-6900-48ed-3697-08d950d4006f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 07:56:11.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5LxdY78++X7PhAMOJuQ9MKM4dLboeYI5RxBveyDAFvCB7PY+f0BHkuM/ftlj46CYY4D8vaP9FklGJnyagI1v3kyc2OZgq+nnH71dEcV/PQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6481
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

Gentle ping. Are we happy with this patch? Please let me know.

Regards,
Biju

> Subject: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
>=20
> Add DMA Controller driver for RZ/G2L SoC.
>=20
> Based on the work done by Chris Brandt for RZ/A DMA driver.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
>   * Incorporated Vinod and Geert's review comments.
> v2->v3:
>   * No change
> v1->v2:
>   * Started using virtual DMAC.
> v1:
>   *
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
wor
> k.kernel.org%2Fproject%2Flinux-renesas-soc%2Fpatch%2F20210611113642.18457=
-
> 4-
> biju.das.jz%40bp.renesas.com%2F&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.ren=
esa
> s.com%7Cb05c4bc173bc4fd6bdd608d94a972ef7%7C53d82571da1947e49cb4625a166a4a=
2
> a%7C0%7C0%7C637622835453526316%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD=
A
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D3e2%2B=
c8X
> 3mT9lTd7npE0rrHIwB8apy9OobPG1tq3k0Y8%3D&amp;reserved=3D0
> ---
>  drivers/dma/sh/Kconfig   |   9 +
>  drivers/dma/sh/Makefile  |   1 +
>  drivers/dma/sh/rz-dmac.c | 929 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 939 insertions(+)
>  create mode 100644 drivers/dma/sh/rz-dmac.c
>=20
> diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig index
> 13437323a85b..1942b0fa9291 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -47,3 +47,12 @@ config RENESAS_USB_DMAC
>  	help
>  	  This driver supports the USB-DMA controller found in the Renesas
>  	  SoCs.
> +
> +config RZ_DMAC
> +	tristate "Renesas RZ/G2L Controller"
> +	depends on ARCH_R9A07G044 || COMPILE_TEST
> +	select RENESAS_DMA
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  This driver supports the general purpose DMA controller found in
> the
> +	  Renesas RZ/G2L SoC variants.
> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile index
> abdf10341725..360ab6d25e76 100644
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_SH_DMAE) +=3D shdma.o
>=20
>  obj-$(CONFIG_RCAR_DMAC) +=3D rcar-dmac.o
>  obj-$(CONFIG_RENESAS_USB_DMAC) +=3D usb-dmac.o
> +obj-$(CONFIG_RZ_DMAC) +=3D rz-dmac.o
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c new file
> mode 100644 index 000000000000..60ba4fa7d0c7
> --- /dev/null
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -0,0 +1,929 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L Controller Driver
> + *
> + * Based on imx-dma.c
> + *
> + * Copyright (C) 2021 Renesas Electronics Corp.
> + * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + * Copyright 2012 Javier Martin, Vista Silicon
> +<javier.martin@vista-silicon.com>  */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +enum  rz_dmac_prep_type {
> +	RZ_DMAC_DESC_MEMCPY,
> +	RZ_DMAC_DESC_SLAVE_SG,
> +};
> +
> +struct rz_lmdesc {
> +	u32 header;
> +	u32 sa;
> +	u32 da;
> +	u32 tb;
> +	u32 chcfg;
> +	u32 chitvl;
> +	u32 chext;
> +	u32 nxla;
> +};
> +
> +struct rz_dmac_desc {
> +	struct virt_dma_desc vd;
> +	dma_addr_t src;
> +	dma_addr_t dest;
> +	size_t len;
> +	struct list_head node;
> +	enum dma_transfer_direction direction;
> +	enum rz_dmac_prep_type type;
> +	/* For slave sg */
> +	struct scatterlist *sg;
> +	unsigned int sgcount;
> +};
> +
> +#define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
> +
> +struct rz_dmac_chan {
> +	struct virt_dma_chan vc;
> +	void __iomem *ch_base;
> +	void __iomem *ch_cmn_base;
> +	unsigned int index;
> +	int irq;
> +	struct rz_dmac_desc *desc;
> +	int descs_allocated;
> +
> +	enum dma_slave_buswidth src_word_size;
> +	enum dma_slave_buswidth dst_word_size;
> +	dma_addr_t src_per_address;
> +	dma_addr_t dst_per_address;
> +
> +	u32 chcfg;
> +	u32 chctrl;
> +	int mid_rid;
> +
> +	struct list_head ld_free;
> +	struct list_head ld_queue;
> +	struct list_head ld_active;
> +
> +	struct {
> +		struct rz_lmdesc *base;
> +		struct rz_lmdesc *head;
> +		struct rz_lmdesc *tail;
> +		int valid;
> +		dma_addr_t base_dma;
> +	} lmdesc;
> +};
> +
> +#define to_rz_dmac_chan(c)	container_of(c, struct rz_dmac_chan,
> vc.chan)
> +
> +struct rz_dmac {
> +	struct dma_device engine;
> +	struct device *dev;
> +	void __iomem *base;
> +	void __iomem *ext_base;
> +
> +	unsigned int n_channels;
> +	struct rz_dmac_chan *channels;
> +
> +	DECLARE_BITMAP(modules, 1024);
> +};
> +
> +#define to_rz_dmac(d)	container_of(d, struct rz_dmac, engine)
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * Registers
> + */
> +
> +#define CHSTAT				0x0024
> +#define CHCTRL				0x0028
> +#define CHCFG				0x002c
> +#define NXLA				0x0038
> +
> +#define DCTRL				0x0000
> +
> +#define EACH_CHANNEL_OFFSET		0x0040
> +#define CHANNEL_0_7_OFFSET		0x0000
> +#define CHANNEL_0_7_COMMON_BASE		0x0300
> +#define CHANNEL_8_15_OFFSET		0x0400
> +#define CHANNEL_8_15_COMMON_BASE	0x0700
> +
> +#define CHSTAT_ER			BIT(4)
> +#define CHSTAT_EN			BIT(0)
> +
> +#define CHCTRL_CLRINTMSK		BIT(17)
> +#define CHCTRL_CLRSUS			BIT(9)
> +#define CHCTRL_CLRTC			BIT(6)
> +#define CHCTRL_CLREND			BIT(5)
> +#define CHCTRL_CLRRQ			BIT(4)
> +#define CHCTRL_SWRST			BIT(3)
> +#define CHCTRL_STG			BIT(2)
> +#define CHCTRL_CLREN			BIT(1)
> +#define CHCTRL_SETEN			BIT(0)
> +#define CHCTRL_DEFAULT			(CHCTRL_CLRINTMSK | CHCTRL_CLRSUS | \
> +					 CHCTRL_CLRTC |	CHCTRL_CLREND | \
> +					 CHCTRL_CLRRQ | CHCTRL_SWRST | \
> +					 CHCTRL_CLREN)
> +
> +#define CHCFG_DMS			BIT(31)
> +#define CHCFG_DEM			BIT(24)
> +#define CHCFG_DAD			BIT(21)
> +#define CHCFG_SAD			BIT(20)
> +#define CHCFG_SEL(bits)			((bits) & 0x07)
> +#define CHCFG_MEM_COPY			(0x80400008)
> +
> +#define DCTRL_LVINT			BIT(1)
> +#define DCTRL_PR			BIT(0)
> +#define DCTRL_DEFAULT			(DCTRL_LVINT | DCTRL_PR)
> +
> +/* LINK MODE DESCRIPTOR */
> +#define HEADER_LV			BIT(0)
> +
> +#define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
> +#define RZ_DMAC_MAX_CHANNELS		16
> +#define DMAC_NR_LMDESC			64
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * Device access
> + */
> +
> +static void rz_dmac_writel(struct rz_dmac *dmac, unsigned int val,
> +			   unsigned int offset)
> +{
> +	writel(val, dmac->base + offset);
> +}
> +
> +static void rz_dmac_ext_writel(struct rz_dmac *dmac, unsigned int val,
> +			       unsigned int offset)
> +{
> +	writel(val, dmac->ext_base + offset);
> +}
> +
> +static u32 rz_dmac_ext_readl(struct rz_dmac *dmac, unsigned int offset)
> +{
> +	return readl(dmac->ext_base + offset); }
> +
> +static void rz_dmac_ch_writel(struct rz_dmac_chan *channel, unsigned int
> val,
> +			      unsigned int offset, int which) {
> +	if (which)
> +		writel(val, channel->ch_base + offset);
> +	else
> +		writel(val, channel->ch_cmn_base + offset); }
> +
> +static u32 rz_dmac_ch_readl(struct rz_dmac_chan *channel,
> +			    unsigned int offset, int which)
> +{
> +	if (which)
> +		return readl(channel->ch_base + offset);
> +	else
> +		return readl(channel->ch_cmn_base + offset); }
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * Initialization
> + */
> +
> +static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
> +			    struct rz_lmdesc *lmdesc)
> +{
> +	u32 nxla;
> +
> +	channel->lmdesc.base =3D lmdesc;
> +	channel->lmdesc.head =3D lmdesc;
> +	channel->lmdesc.tail =3D lmdesc;
> +	channel->lmdesc.valid =3D 0;
> +	nxla =3D channel->lmdesc.base_dma;
> +	while (lmdesc < (channel->lmdesc.base + (DMAC_NR_LMDESC - 1))) {
> +		lmdesc->header =3D 0;
> +		nxla +=3D sizeof(*lmdesc);
> +		lmdesc->nxla =3D nxla;
> +		lmdesc++;
> +	}
> +
> +	lmdesc->header =3D 0;
> +	lmdesc->nxla =3D channel->lmdesc.base_dma; }
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * Descriptors preparation
> + */
> +
> +static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel) {
> +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
> +
> +	while (!(lmdesc->header & HEADER_LV)) {
> +		lmdesc->header =3D 0;
> +		channel->lmdesc.valid--;
> +		lmdesc++;
> +		if (lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
> +			lmdesc =3D channel->lmdesc.base;
> +	}
> +	channel->lmdesc.head =3D lmdesc;
> +}
> +
> +static void rz_dmac_enable_hw(struct rz_dmac_chan *channel) {
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	unsigned long flags;
> +	u32 nxla;
> +	u32 chctrl;
> +	u32 chstat;
> +
> +	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
> +
> +	local_irq_save(flags);
> +
> +	rz_dmac_lmdesc_recycle(channel);
> +
> +	nxla =3D channel->lmdesc.base_dma +
> +		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
> +					     channel->lmdesc.base));
> +
> +	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
> +	if (!(chstat & CHSTAT_EN)) {
> +		chctrl =3D (channel->chctrl | CHCTRL_SETEN);
> +		rz_dmac_ch_writel(channel, nxla, NXLA, 1);
> +		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
> +		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
> +		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
> +	}
> +
> +	local_irq_restore(flags);
> +}
> +
> +static void rz_dmac_disable_hw(struct rz_dmac_chan *channel) {
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	unsigned long flags;
> +
> +	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
> +
> +	local_irq_save(flags);
> +	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> +	local_irq_restore(flags);
> +}
> +
> +static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr,
> +u32 dmars) {
> +	u32 dmars_offset =3D (nr / 2) * 4;
> +	u32 shift =3D (nr % 2) * 16;
> +	u32 dmars32;
> +
> +	dmars32 =3D rz_dmac_ext_readl(dmac, dmars_offset);
> +	dmars32 &=3D ~(0xffff << shift);
> +	dmars32 |=3D dmars << shift;
> +
> +	rz_dmac_ext_writel(dmac, dmars32, dmars_offset); }
> +
> +static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan
> +*channel) {
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
> +	struct rz_dmac_desc *d =3D channel->desc;
> +	u32 chcfg =3D CHCFG_MEM_COPY;
> +
> +	lmdesc =3D channel->lmdesc.tail;
> +
> +	/* prepare descriptor */
> +	lmdesc->sa =3D d->src;
> +	lmdesc->da =3D d->dest;
> +	lmdesc->tb =3D d->len;
> +	lmdesc->chcfg =3D chcfg;
> +	lmdesc->chitvl =3D 0;
> +	lmdesc->chext =3D 0;
> +	lmdesc->header =3D HEADER_LV;
> +
> +	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +
> +	channel->chcfg =3D chcfg;
> +	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN; }
> +
> +static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan
> +*channel) {
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct rz_dmac_desc *d =3D channel->desc;
> +	struct scatterlist *sg, *sgl =3D d->sg;
> +	struct rz_lmdesc *lmdesc;
> +	unsigned int i, sg_len =3D d->sgcount;
> +
> +	channel->chcfg |=3D CHCFG_SEL(channel->index) | CHCFG_DEM | CHCFG_DMS;
> +
> +	if (d->direction =3D=3D DMA_DEV_TO_MEM)
> +		channel->chcfg |=3D CHCFG_SAD;
> +	else
> +		channel->chcfg |=3D CHCFG_DAD;
> +
> +	lmdesc =3D channel->lmdesc.tail;
> +
> +	for (i =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next(sg)) {
> +		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
> +			lmdesc->sa =3D channel->src_per_address;
> +			lmdesc->da =3D sg_dma_address(sg);
> +		} else {
> +			lmdesc->sa =3D sg_dma_address(sg);
> +			lmdesc->da =3D channel->dst_per_address;
> +		}
> +
> +		lmdesc->tb =3D sg_dma_len(sg);
> +		lmdesc->chitvl =3D 0;
> +		lmdesc->chext =3D 0;
> +		if (i =3D=3D (sg_len - 1)) {
> +			lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);
> +			lmdesc->header =3D HEADER_LV;
> +		} else {
> +			lmdesc->chcfg =3D channel->chcfg;
> +			lmdesc->header =3D HEADER_LV;
> +		}
> +		if (++lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
> +			lmdesc =3D channel->lmdesc.base;
> +	}
> +
> +	channel->lmdesc.tail =3D lmdesc;
> +
> +	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> +	channel->chctrl =3D CHCTRL_SETEN;
> +}
> +
> +static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan) {
> +	struct rz_dmac_desc *d =3D chan->desc;
> +	struct virt_dma_desc *vd;
> +
> +	vd =3D vchan_next_desc(&chan->vc);
> +	if (!vd)
> +		return 0;
> +
> +	list_del(&vd->node);
> +
> +	switch (d->type) {
> +	case RZ_DMAC_DESC_MEMCPY:
> +		rz_dmac_prepare_desc_for_memcpy(chan);
> +		break;
> +
> +	case RZ_DMAC_DESC_SLAVE_SG:
> +		rz_dmac_prepare_descs_for_slave_sg(chan);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rz_dmac_enable_hw(chan);
> +
> +	return 0;
> +}
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * DMA engine operations
> + */
> +
> +static int rz_dmac_alloc_chan_resources(struct dma_chan *chan) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +
> +	while (channel->descs_allocated < RZ_DMAC_MAX_CHAN_DESCRIPTORS) {
> +		struct rz_dmac_desc *desc;
> +
> +		desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
> +		if (!desc)
> +			break;
> +
> +		list_add_tail(&desc->node, &channel->ld_free);
> +		channel->descs_allocated++;
> +	}
> +
> +	if (!channel->descs_allocated)
> +		return -ENOMEM;
> +
> +	return channel->descs_allocated;
> +}
> +
> +static void rz_dmac_free_chan_resources(struct dma_chan *chan) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
> +	struct rz_dmac_desc *desc, *_desc;
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +
> +	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
> +		lmdesc[i].header =3D 0;
> +
> +	rz_dmac_disable_hw(channel);
> +	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> +	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> +
> +	if (channel->mid_rid >=3D 0) {
> +		clear_bit(channel->mid_rid, dmac->modules);
> +		channel->mid_rid =3D -EINVAL;
> +	}
> +
> +	spin_unlock_irqrestore(&channel->vc.lock, flags);
> +
> +	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
> +		kfree(desc);
> +		channel->descs_allocated--;
> +	}
> +
> +	INIT_LIST_HEAD(&channel->ld_free);
> +	vchan_free_chan_resources(&channel->vc);
> +}
> +
> +static struct dma_async_tx_descriptor * rz_dmac_prep_dma_memcpy(struct
> +dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> +			size_t len, unsigned long flags)
> +{
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct rz_dmac_desc *desc;
> +
> +	dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx len=3D%ld\=
n",
> +		__func__, channel->index, src, dest, len);
> +
> +	if (list_empty(&channel->ld_free))
> +		return NULL;
> +
> +	desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc,
> node);
> +
> +	desc->type =3D RZ_DMAC_DESC_MEMCPY;
> +	desc->src =3D src;
> +	desc->dest =3D dest;
> +	desc->len =3D len;
> +	desc->direction =3D DMA_MEM_TO_MEM;
> +
> +	list_move_tail(channel->ld_free.next, &channel->ld_queue);
> +	return vchan_tx_prep(&channel->vc, &desc->vd, flags); }
> +
> +static struct dma_async_tx_descriptor * rz_dmac_prep_slave_sg(struct
> +dma_chan *chan, struct scatterlist *sgl,
> +		      unsigned int sg_len,
> +		      enum dma_transfer_direction direction,
> +		      unsigned long flags, void *context) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct scatterlist *sg;
> +	int i, dma_length =3D 0;
> +	struct rz_dmac_desc *desc;
> +
> +	if (list_empty(&channel->ld_free))
> +		return NULL;
> +
> +	desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc,
> node);
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		dma_length +=3D sg_dma_len(sg);
> +	}
> +
> +	desc->type =3D RZ_DMAC_DESC_SLAVE_SG;
> +	desc->sg =3D sgl;
> +	desc->sgcount =3D sg_len;
> +	desc->len =3D dma_length;
> +	desc->direction =3D direction;
> +
> +	if (direction =3D=3D DMA_DEV_TO_MEM)
> +		desc->src =3D channel->src_per_address;
> +	else
> +		desc->dest =3D channel->dst_per_address;
> +
> +	list_move_tail(channel->ld_free.next, &channel->ld_queue);
> +	return vchan_tx_prep(&channel->vc, &desc->vd, flags); }
> +
> +static int rz_dmac_terminate_all(struct dma_chan *chan) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	LIST_HEAD(head);
> +
> +	rz_dmac_disable_hw(channel);
> +	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> +	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> +	vchan_get_all_descriptors(&channel->vc, &head);
> +	vchan_dma_desc_free_list(&channel->vc, &head);
> +
> +	return 0;
> +}
> +
> +static void rz_dmac_issue_pending(struct dma_chan *chan) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct rz_dmac_desc *desc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +
> +	if (!list_empty(&channel->ld_queue)) {
> +		desc =3D list_first_entry(&channel->ld_queue,
> +					struct rz_dmac_desc, node);
> +		channel->desc =3D desc;
> +		if (vchan_issue_pending(&channel->vc)) {
> +			if (rz_dmac_xfer_desc(channel) < 0)
> +				dev_warn(dmac->dev, "ch: %d couldn't issue DMA
> xfer\n",
> +					 channel->index);
> +			else
> +				list_move_tail(channel->ld_queue.next,
> +					       &channel->ld_active);
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&channel->vc.lock, flags); }
> +
> +static int rz_dmac_config(struct dma_chan *chan,
> +			  struct dma_slave_config *config)
> +{
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	u32 *ch_cfg;
> +
> +	channel->src_per_address =3D config->src_addr;
> +	channel->src_word_size =3D config->src_addr_width;
> +	channel->dst_per_address =3D config->dst_addr;
> +	channel->dst_word_size =3D config->dst_addr_width;
> +
> +	if (config->peripheral_config) {
> +		ch_cfg =3D config->peripheral_config;
> +		channel->chcfg =3D *ch_cfg;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd) {
> +	/*
> +	 * Place holder
> +	 * Descriptor allocation is done during alloc_chan_resources and
> +	 * get freed during free_chan_resources.
> +	 * list is used to manage the descriptors and avoid any memory
> +	 * allocation/free during DMA read/write.
> +	 */
> +}
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * IRQ handling
> + */
> +
> +static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel) {
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	u32 chstat, chctrl;
> +
> +	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
> +	if (chstat & CHSTAT_ER) {
> +		dev_err(dmac->dev, "DMAC err CHSTAT_%d =3D %08X\n",
> +			channel->index, chstat);
> +		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> +		goto done;
> +	}
> +
> +	chctrl =3D rz_dmac_ch_readl(channel, CHCTRL, 1);
> +	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
> +done:
> +	return;
> +}
> +
> +static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id) {
> +	struct rz_dmac_chan *channel =3D dev_id;
> +
> +	if (channel) {
> +		rz_dmac_irq_handle_channel(channel);
> +		return IRQ_WAKE_THREAD;
> +	}
> +	/* handle DMAERR irq */
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id) {
> +	struct rz_dmac_chan *channel =3D dev_id;
> +	struct rz_dmac_desc *desc =3D NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +
> +	if (list_empty(&channel->ld_active)) {
> +		/* Someone might have called terminate all */
> +		goto out;
> +	}
> +
> +	desc =3D list_first_entry(&channel->ld_active, struct rz_dmac_desc,
> node);
> +	spin_unlock_irqrestore(&channel->vc.lock, flags);
> +	vchan_cookie_complete(&desc->vd);
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +	list_move_tail(channel->ld_active.next, &channel->ld_free);
> +
> +	if (!list_empty(&channel->ld_queue)) {
> +		desc =3D list_first_entry(&channel->ld_queue, struct
> rz_dmac_desc,
> +					node);
> +		channel->desc =3D desc;
> +		if (rz_dmac_xfer_desc(channel) =3D=3D 0)
> +			list_move_tail(channel->ld_queue.next, &channel-
> >ld_active);
> +	}
> +out:
> +	spin_unlock_irqrestore(&channel->vc.lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * OF xlate and channel filter
> + */
> +
> +static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct of_phandle_args *dma_spec =3D arg;
> +
> +	channel->mid_rid =3D dma_spec->args[0];
> +
> +	return !test_and_set_bit(dma_spec->args[0], dmac->modules); }
> +
> +static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args
> *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	dma_cap_mask_t mask;
> +
> +	if (dma_spec->args_count !=3D 1)
> +		return NULL;
> +
> +	/* Only slave DMA channels can be allocated via DT */
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	return dma_request_channel(mask, rz_dmac_chan_filter, dma_spec); }
> +
> +/*
> + *
> +-----------------------------------------------------------------------
> +------
> + * Probe and remove
> + */
> +
> +static int rz_dmac_chan_probe(struct rz_dmac *dmac,
> +			      struct rz_dmac_chan *channel,
> +			      unsigned int index)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dmac->dev);
> +	struct rz_lmdesc *lmdesc;
> +	char pdev_irqname[5];
> +	char *irqname;
> +	int ret;
> +
> +	channel->index =3D index;
> +	channel->mid_rid =3D -EINVAL;
> +
> +	/* Request the channel interrupt. */
> +	sprintf(pdev_irqname, "ch%u", index);
> +	channel->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> +	if (channel->irq < 0)
> +		return channel->irq;
> +
> +	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> +				 dev_name(dmac->dev), index);
> +	if (!irqname)
> +		return -ENOMEM;
> +
> +	ret =3D devm_request_threaded_irq(dmac->dev, channel->irq,
> +					rz_dmac_irq_handler,
> +					rz_dmac_irq_handler_thread, 0,
> +					irqname, channel);
> +	if (ret) {
> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
> +			channel->irq, ret);
> +		return ret;
> +	}
> +
> +	/* Set io base address for each channel */
> +	if (index < 8) {
> +		channel->ch_base =3D dmac->base + CHANNEL_0_7_OFFSET +
> +			EACH_CHANNEL_OFFSET * index;
> +		channel->ch_cmn_base =3D dmac->base + CHANNEL_0_7_COMMON_BASE;
> +	} else {
> +		channel->ch_base =3D dmac->base + CHANNEL_8_15_OFFSET +
> +			EACH_CHANNEL_OFFSET * (index - 8);
> +		channel->ch_cmn_base =3D dmac->base + CHANNEL_8_15_COMMON_BASE;
> +	}
> +
> +	/* Allocate descriptors */
> +	lmdesc =3D dma_alloc_coherent(&pdev->dev,
> +				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> +				    &channel->lmdesc.base_dma, GFP_KERNEL);
> +	if (!lmdesc) {
> +		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
> +		return -ENOMEM;
> +	}
> +	rz_lmdesc_setup(channel, lmdesc);
> +
> +	/* Initialize register for each channel */
> +	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> +
> +	channel->vc.desc_free =3D rz_dmac_virt_desc_free;
> +	vchan_init(&channel->vc, &dmac->engine);
> +	INIT_LIST_HEAD(&channel->ld_queue);
> +	INIT_LIST_HEAD(&channel->ld_free);
> +	INIT_LIST_HEAD(&channel->ld_active);
> +
> +	return 0;
> +}
> +
> +static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac) {
> +	struct device_node *np =3D dev->of_node;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(np, "dma-channels", &dmac->n_channels);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to read dma-channels property\n");
> +		return ret;
> +	}
> +
> +	if (!dmac->n_channels || dmac->n_channels > RZ_DMAC_MAX_CHANNELS) {
> +		dev_err(dev, "invalid number of channels %u\n", dmac-
> >n_channels);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rz_dmac_probe(struct platform_device *pdev) {
> +	const char *irqname =3D "error";
> +	struct dma_device *engine;
> +	struct rz_dmac *dmac;
> +	int channel_num;
> +	unsigned int i;
> +	int ret;
> +	int irq;
> +
> +	dmac =3D devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> +	if (!dmac)
> +		return -ENOMEM;
> +
> +	dmac->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, dmac);
> +
> +	ret =3D rz_dmac_parse_of(&pdev->dev, dmac);
> +	if (ret < 0)
> +		return ret;
> +
> +	dmac->channels =3D devm_kcalloc(&pdev->dev, dmac->n_channels,
> +				      sizeof(*dmac->channels), GFP_KERNEL);
> +	if (!dmac->channels)
> +		return -ENOMEM;
> +
> +	/* Request resources */
> +	dmac->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dmac->base))
> +		return PTR_ERR(dmac->base);
> +
> +	dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(dmac->ext_base))
> +		return PTR_ERR(dmac->ext_base);
> +
> +	/* Register interrupt handler for error */
> +	irq =3D platform_get_irq_byname(pdev, irqname);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> +			       irqname, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> +			irq, ret);
> +		return ret;
> +	}
> +
> +	/* Initialize the channels. */
> +	INIT_LIST_HEAD(&dmac->engine.channels);
> +
> +	for (i =3D 0; i < dmac->n_channels; i++) {
> +		ret =3D rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
> +		if (ret < 0)
> +			goto err;
> +	}
> +
> +	/* Register the DMAC as a DMA provider for DT. */
> +	ret =3D of_dma_controller_register(pdev->dev.of_node,
> rz_dmac_of_xlate,
> +					 NULL);
> +	if (ret < 0)
> +		goto err;
> +
> +	/* Register the DMA engine device. */
> +	engine =3D &dmac->engine;
> +	dma_cap_set(DMA_SLAVE, engine->cap_mask);
> +	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE +
> DCTRL);
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE +
> DCTRL);
> +
> +	engine->dev =3D &pdev->dev;
> +
> +	engine->device_alloc_chan_resources =3D rz_dmac_alloc_chan_resources;
> +	engine->device_free_chan_resources =3D rz_dmac_free_chan_resources;
> +	engine->device_tx_status =3D dma_cookie_status;
> +	engine->device_prep_slave_sg =3D rz_dmac_prep_slave_sg;
> +	engine->device_prep_dma_memcpy =3D rz_dmac_prep_dma_memcpy;
> +	engine->device_config =3D rz_dmac_config;
> +	engine->device_terminate_all =3D rz_dmac_terminate_all;
> +	engine->device_issue_pending =3D rz_dmac_issue_pending;
> +
> +	engine->copy_align =3D DMAENGINE_ALIGN_1_BYTE;
> +	dma_set_max_seg_size(engine->dev, U32_MAX);
> +
> +	ret =3D dma_async_device_register(engine);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to register\n");
> +		goto dma_register_err;
> +	}
> +	return 0;
> +
> +dma_register_err:
> +	of_dma_controller_free(pdev->dev.of_node);
> +err:
> +	channel_num =3D i ? i - 1 : 0;
> +	for (i =3D 0; i < channel_num; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		dma_free_coherent(NULL,
> +				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> +				  channel->lmdesc.base,
> +				  channel->lmdesc.base_dma);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rz_dmac_remove(struct platform_device *pdev) {
> +	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	for (i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		dma_free_coherent(NULL,
> +				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> +				  channel->lmdesc.base,
> +				  channel->lmdesc.base_dma);
> +	}
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&dmac->engine);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_rz_dmac_match[] =3D {
> +	{ .compatible =3D "renesas,rz-dmac", },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
> +
> +static struct platform_driver rz_dmac_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "rz-dmac",
> +		.of_match_table =3D of_rz_dmac_match,
> +	},
> +	.probe		=3D rz_dmac_probe,
> +	.remove		=3D rz_dmac_remove,
> +};
> +
> +module_platform_driver(rz_dmac_driver);
> +
> +MODULE_DESCRIPTION("Renesas RZ/G2L DMA Controller Driver");
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.1

