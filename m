Return-Path: <dmaengine+bounces-476-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB980E428
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 07:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E057B217F8
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 06:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983B156F3;
	Tue, 12 Dec 2023 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhXffBoS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5DBE;
	Mon, 11 Dec 2023 22:05:37 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5e180547bdeso8577177b3.1;
        Mon, 11 Dec 2023 22:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702361137; x=1702965937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF5NVD0bCYtZ+pDWy7Ij/dGxBzbwqr0cbMWOho14kc8=;
        b=hhXffBoS+QW8irkZQ8teSccJFUsIeSVpeMCF/L7OHV6Wpt2zF62OAjH6gYYxlmxmuZ
         WL/FyIOtJGvitVu60AiiVHjujvkaodCrJundnRMIQAjG5QcLRpit7oooJIAR/fWKVHu2
         AJAaZ8B56dJYvYrLNQ6Q2CDTQaGuHxKsmP61GH1+mJano+cczSTgbeuuufjSWJxO2xPu
         tp7/YhOymc21Q3hv4N3bZy9r+3foCdtxQFAbMpdN/2dH3QL4WTE5DmsITUuzldGXLjiP
         o93PZH8ZYDeWUPO/4FY+dUU8bqo7k5PqIOlekzXHosCQK79WXlg989aqT5P98GVEfOkq
         ARBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702361137; x=1702965937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF5NVD0bCYtZ+pDWy7Ij/dGxBzbwqr0cbMWOho14kc8=;
        b=Us60Q2IAF8mOngxDZ5Bi+2zUiV7ZqUD9L5hRfqyPW9QsSi+PxLadU3I25ONJwAnynW
         3ZnXQQIDwiDXq2UwfGZsBzvatc08sVyGoCe6CpIq7iajh+w39rU7MeYMNde1TuXjRStF
         qSyRuJ0XNLYhfIVc2pzM78XfKZQHHjaBuGrNRdWT2CG/0Zu6GupoBkJ1Q4G4QALucy63
         WYTyijbU7873yCiAyd962R60QE9ll8OrQgiEjxB/FQPJNus7/Fi43E5nHv7ZanIbq1b2
         bJ/5tH+024p41yw/zVzuHSUw+WeEE2ntVVLOQbOosjD3befUYubVu9vfnqYGkFt8RDhq
         y7GA==
X-Gm-Message-State: AOJu0YwOGzgIAxK+zaYzwVar6Hsd+9ub1Mq8v5tBi5Zwbmf5Z50AGRyD
	U6ux6eP2lqqJQffmLRKvgw6v/H1zjKwHWQZmvfmjMehvEEuj1Zjw
X-Google-Smtp-Source: AGHT+IFnPXt5wSozmcm9K/80KUpBmVSRYYV0ugRvjvjjyDp7ufMyuaB36D26oZcN+SS8PUnlTk1KwMbJClgReBiT4I0=
X-Received: by 2002:a05:6902:1b8a:b0:dbc:bbe7:b098 with SMTP id
 ei10-20020a0569021b8a00b00dbcbbe7b098mr125185ybb.10.1702361136548; Mon, 11
 Dec 2023 22:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700644483.git.zhoubinbin@loongson.cn> <00ca551194a5ee69840b1a1a556d7b954153f455.1700644483.git.zhoubinbin@loongson.cn>
 <ZXb03A3ID35BHwUS@matsya>
In-Reply-To: <ZXb03A3ID35BHwUS@matsya>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 12 Dec 2023 12:05:24 +0600
Message-ID: <CAMpQs4LEnjrToWmpotQKJWuh=VWgvS+4o105MAbeCDe2bYKD7A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dmaengine: ls2x-apb: new driver for the Loongson
 LS2X APB DMA controller
To: Vinod Koul <vkoul@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>, 
	loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vinod:

Thanks for your review.

On Mon, Dec 11, 2023 at 5:39=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 22-11-23, 17:27, Binbin Zhou wrote:
> > The Loongson LS2X APB DMA controller is available on Loongson-2K chips.
> >
> > It is a single-channel, configurable DMA controller IP core based on th=
e
> > AXI bus, whose main function is to integrate DMA functionality on a chi=
p
> > dedicated to carrying data between memory and peripherals in APB bus
> > (e.g. nand).
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
> > ---
> >  MAINTAINERS                |   1 +
> >  drivers/dma/Kconfig        |  14 +
> >  drivers/dma/Makefile       |   1 +
> >  drivers/dma/ls2x-apb-dma.c | 705 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 721 insertions(+)
> >  create mode 100644 drivers/dma/ls2x-apb-dma.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index eb1d9c4f85d0..6b8d7f5b241b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12511,6 +12511,7 @@ M:    Binbin Zhou <zhoubinbin@loongson.cn>
> >  L:   dmaengine@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > +F:   drivers/dma/ls2x-apb-dma.c
> >
> >  LOONGSON LS2X I2C DRIVER
> >  M:   Binbin Zhou <zhoubinbin@loongson.cn>
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 70ba506dabab..e928f2ca0f1e 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -378,6 +378,20 @@ config LPC18XX_DMAMUX
> >         Enable support for DMA on NXP LPC18xx/43xx platforms
> >         with PL080 and multiplexed DMA request lines.
> >
> > +config LS2X_APB_DMA
> > +     tristate "Loongson LS2X APB DMA support"
> > +     depends on LOONGARCH || COMPILE_TEST
> > +     select DMA_ENGINE
> > +     select DMA_VIRTUAL_CHANNELS
> > +     help
> > +       Support for the Loongson LS2X APB DMA controller driver. The
> > +       DMA controller is having single DMA channel which can be
> > +       configured for different peripherals like audio, nand, sdio
> > +       etc which is in APB bus.
> > +
> > +       This DMA controller transfers data from memory to peripheral fi=
fo.
> > +       It does not support memory to memory data transfer.
> > +
> >  config MCF_EDMA
> >       tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
> >       depends on M5441x || COMPILE_TEST
> > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > index 83553a97a010..dfd40d14e408 100644
> > --- a/drivers/dma/Makefile
> > +++ b/drivers/dma/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> >  obj-y +=3D idxd/
> >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > +obj-$(CONFIG_LS2X_APB_DMA) +=3D ls2x-apb-dma.o
> >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> >  obj-$(CONFIG_MILBEAUT_XDMAC) +=3D milbeaut-xdmac.o
> >  obj-$(CONFIG_MMP_PDMA) +=3D mmp_pdma.o
> > diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
> > new file mode 100644
> > index 000000000000..f60dbeae627f
> > --- /dev/null
> > +++ b/drivers/dma/ls2x-apb-dma.c
> > @@ -0,0 +1,705 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for the Loongson LS2X APB DMA Controller
> > + *
> > + * Copyright (C) 2017-2023 Loongson Corporation
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include "dmaengine.h"
> > +#include "virt-dma.h"
> > +
> > +/* Global Configuration Register */
> > +#define LDMA_ORDER_ERG               0x0
> > +
> > +/* Bitfield definitions */
> > +
> > +/* Bitfields in Global Configuration Register */
> > +#define LDMA_64BIT_EN                BIT(0) /* 1: 64 bit support */
> > +#define LDMA_UNCOHERENT_EN   BIT(1) /* 0: cache, 1: uncache */
> > +#define LDMA_ASK_VALID               BIT(2)
> > +#define LDMA_START           BIT(3) /* DMA start operation */
> > +#define LDMA_STOP            BIT(4) /* DMA stop operation */
> > +#define LDMA_CONFIG_MASK     GENMASK(4, 0) /* DMA controller config bi=
ts mask */
> > +
> > +/* Bitfields in ndesc_addr field of HW decriptor */
> > +#define LDMA_DESC_EN         BIT(0) /*1: The next descriptor is valid =
*/
> > +#define LDMA_DESC_ADDR_LOW   GENMASK(31, 1)
> > +
> > +/* Bitfields in cmd field of HW decriptor */
> > +#define LDMA_INT             BIT(1) /* Enable DMA interrupts */
> > +#define LDMA_DATA_DIRECTION  BIT(12) /* 1: write to device, 0: read fr=
om device */
> > +
> > +#define LDMA_SLAVE_BUSWIDTHS (BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
> > +                              BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
> > +
> > +#define LDMA_MAX_TRANS_LEN   U32_MAX
> > +
> > +/*--  descriptors  ---------------------------------------------------=
--*/
> > +
> > +/*
> > + * struct ls2x_dma_hw_desc - DMA HW descriptor
> > + * @ndesc_addr: the next descriptor low address.
> > + * @mem_addr: memory low address.
> > + * @apb_addr: device buffer address.
> > + * @len: length of a piece of carried content, in words.
> > + * @step_len: length between two moved memory data blocks.
> > + * @step_times: number of blocks to be carried in a single DMA operati=
on.
> > + * @cmd: descriptor command or state.
> > + * @stats: DMA status.
> > + * @high_ndesc_addr: the next descriptor high address.
> > + * @high_mem_addr: memory high address.
> > + * @reserved: reserved
> > + */
> > +struct ls2x_dma_hw_desc {
> > +     u32 ndesc_addr;
> > +     u32 mem_addr;
> > +     u32 apb_addr;
> > +     u32 len;
> > +     u32 step_len;
> > +     u32 step_times;
> > +     u32 cmd;
> > +     u32 stats;
> > +     u32 high_ndesc_addr;
> > +     u32 high_mem_addr;
> > +     u32 reserved[2];
> > +} __packed;
> > +
> > +/*
> > + * struct ls2x_dma_sg - ls2x dma scatter gather entry
> > + * @hw: the pointer to DMA HW descriptor.
> > + * @llp: physical address of the DMA HW descriptor.
> > + * @phys: destination or source address(mem).
> > + * @len: number of Bytes to read.
> > + */
> > +struct ls2x_dma_sg {
> > +     struct ls2x_dma_hw_desc *hw;
> > +     dma_addr_t              llp;
> > +     dma_addr_t              phys;
> > +     u32                     len;
> > +};
> > +
> > +/*
> > + * struct ls2x_dma_desc - software descriptor
> > + * @vdesc: pointer to the virtual dma descriptor.
> > + * @cyclic: flag to dma cyclic
> > + * @burst_size: burst size of transaction, in words.
> > + * @desc_num: number of sg entries.
> > + * @direction: transfer direction, to or from device.
> > + * @status: dma controller status.
> > + * @sg: array of sgs.
> > + */
> > +struct ls2x_dma_desc {
> > +     struct virt_dma_desc            vdesc;
> > +     bool                            cyclic;
> > +     size_t                          burst_size;
> > +     u32                             desc_num;
> > +     enum dma_transfer_direction     direction;
> > +     enum dma_status                 status;
> > +     struct ls2x_dma_sg              sg[] __counted_by(desc_num);
> > +};
> > +
> > +/*--  Channels  ------------------------------------------------------=
--*/
> > +
> > +/*
> > + * struct ls2x_dma_chan - internal representation of an LS2X APB DMA c=
hannel
> > + * @vchan: virtual dma channel entry.
> > + * @desc: pointer to the ls2x sw dma descriptor.
> > + * @pool: hw desc table
> > + * @irq: irq line
> > + * @sconfig: configuration for slave transfers, passed via .device_con=
fig
> > + */
> > +struct ls2x_dma_chan {
> > +     struct virt_dma_chan    vchan;
> > +     struct ls2x_dma_desc    *desc;
> > +     void                    *pool;
> > +     int                     irq;
> > +     struct dma_slave_config sconfig;
> > +};
> > +
> > +/*--  Controller  ----------------------------------------------------=
--*/
> > +
> > +/*
> > + * struct ls2x_dma_priv - LS2X APB DMAC specific information
> > + * @ddev: dmaengine dma_device object members
> > + * @dma_clk: DMAC clock source
> > + * @regs: memory mapped register base
> > + * @lchan: channel to store ls2x_dma_chan structures
> > + */
> > +struct ls2x_dma_priv {
> > +     struct dma_device       ddev;
> > +     struct clk              *dma_clk;
> > +     void __iomem            *regs;
> > +     struct ls2x_dma_chan    lchan;
> > +};
> > +
> > +/*--  Helper functions  ----------------------------------------------=
--*/
> > +
> > +static inline struct ls2x_dma_desc *to_ldma_desc(struct virt_dma_desc =
*vdesc)
> > +{
> > +     return container_of(vdesc, struct ls2x_dma_desc, vdesc);
> > +}
> > +
> > +static inline struct ls2x_dma_chan *to_ldma_chan(struct dma_chan *chan=
)
> > +{
> > +     return container_of(chan, struct ls2x_dma_chan, vchan.chan);
> > +}
> > +
> > +static inline struct ls2x_dma_priv *to_ldma_priv(struct dma_device *dd=
ev)
> > +{
> > +     return container_of(ddev, struct ls2x_dma_priv, ddev);
> > +}
> > +
> > +static struct device *chan2dev(struct dma_chan *chan)
> > +{
> > +     return &chan->dev->device;
> > +}
> > +
> > +static void ls2x_dma_desc_free(struct virt_dma_desc *vdesc)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(vdesc->tx.chan);
> > +     struct ls2x_dma_desc *desc =3D to_ldma_desc(vdesc);
> > +     int i;
> > +
> > +     for (i =3D 0; i < desc->desc_num; i++) {
> > +             if (desc->sg[i].hw)
> > +                     dma_pool_free(lchan->pool, desc->sg[i].hw,
> > +                                   desc->sg[i].llp);
> > +     }
> > +
> > +     kfree(desc);
> > +}
> > +
> > +static void ls2x_dma_write_cmd(struct ls2x_dma_chan *lchan, bool cmd)
> > +{
> > +     u64 val =3D 0;
>
> superfluous init
Got it.
>
> > +     struct ls2x_dma_priv *priv =3D to_ldma_priv(lchan->vchan.chan.dev=
ice);
> > +
> > +     val =3D lo_hi_readq(priv->regs + LDMA_ORDER_ERG) & ~LDMA_CONFIG_M=
ASK;
> > +     val |=3D LDMA_64BIT_EN | cmd;
>
> should this be LDMA_64BIT_EN & cmd ?

Emm.. I think it should be "|" here.
The cmd parameter represents the DMAC state we expect to set, e.g.,
STOP, which along with 64BIT_EN belongs to the configuration-related
bits in the order register.

The definition is as follows:
#define LDMA_64BIT_EN BIT(0) /* 1: 64 bit support */
#define LDMA_UNCOHERENT_EN BIT(1) /* 0: cache, 1: uncache */
#define LDMA_ASK_VALID BIT(2)
#define LDMA_START BIT(3) /* DMA start operation */
#define LDMA_STOP BIT(4) /* DMA stop operation */

>
> > +     lo_hi_writeq(val, priv->regs + LDMA_ORDER_ERG);
> > +}
> > +
> > +static void ls2x_dma_start_transfer(struct ls2x_dma_chan *lchan)
> > +{
> > +     struct ls2x_dma_priv *priv =3D to_ldma_priv(lchan->vchan.chan.dev=
ice);
> > +     struct ls2x_dma_sg *ldma_sg;
> > +     struct virt_dma_desc *vdesc;
> > +     u64 val;
> > +
> > +     /* Get the next descriptor */
> > +     vdesc =3D vchan_next_desc(&lchan->vchan);
> > +     if (!vdesc) {
> > +             lchan->desc =3D NULL;
> > +             return;
> > +     }
> > +
> > +     list_del(&vdesc->node);
> > +     lchan->desc =3D to_ldma_desc(vdesc);
> > +     ldma_sg =3D &lchan->desc->sg[0];
> > +
> > +     /* Start DMA */
> > +     lo_hi_writeq(0, priv->regs + LDMA_ORDER_ERG);
> > +     val =3D (ldma_sg->llp & ~LDMA_CONFIG_MASK) | LDMA_64BIT_EN | LDMA=
_START;
> > +     lo_hi_writeq(val, priv->regs + LDMA_ORDER_ERG);
> > +}
> > +
> > +static size_t ls2x_dmac_detect_burst(struct ls2x_dma_chan *lchan)
> > +{
> > +     u32 maxburst, buswidth;
> > +
> > +     /* Reject definitely invalid configurations */
> > +     if ((lchan->sconfig.src_addr_width & LDMA_SLAVE_BUSWIDTHS) &&
> > +         (lchan->sconfig.dst_addr_width & LDMA_SLAVE_BUSWIDTHS))
> > +             return 0;
> > +
> > +     if (lchan->sconfig.direction =3D=3D DMA_MEM_TO_DEV) {
> > +             maxburst =3D lchan->sconfig.dst_maxburst;
> > +             buswidth =3D lchan->sconfig.dst_addr_width;
> > +     } else {
> > +             maxburst =3D lchan->sconfig.src_maxburst;
> > +             buswidth =3D lchan->sconfig.src_addr_width;
> > +     }
> > +
> > +     /* If maxburst is zero, fallback to LDMA_MAX_TRANS_LEN */
> > +     return maxburst ? (maxburst * buswidth) >> 2 : LDMA_MAX_TRANS_LEN=
;
> > +}
> > +
> > +static void ls2x_dma_fill_desc(struct ls2x_dma_chan *lchan, u32 sg_ind=
ex,
> > +                            struct ls2x_dma_desc *desc)
> > +{
> > +     struct ls2x_dma_sg *ldma_sg =3D &desc->sg[sg_index];
> > +     u32 num_segments, segment_size;
> > +
> > +     if (desc->direction =3D=3D DMA_MEM_TO_DEV) {
> > +             ldma_sg->hw->cmd =3D LDMA_INT | LDMA_DATA_DIRECTION;
> > +             ldma_sg->hw->apb_addr =3D lchan->sconfig.dst_addr;
> > +     } else {
> > +             ldma_sg->hw->cmd =3D LDMA_INT;
> > +             ldma_sg->hw->apb_addr =3D lchan->sconfig.src_addr;
> > +     }
> > +
> > +     ldma_sg->hw->mem_addr =3D lower_32_bits(ldma_sg->phys);
> > +     ldma_sg->hw->high_mem_addr =3D upper_32_bits(ldma_sg->phys);
> > +
> > +     /* Split into multiple equally sized segments if necessary */
> > +     num_segments =3D DIV_ROUND_UP((ldma_sg->len + 3) >> 2, desc->burs=
t_size);
> > +     segment_size =3D DIV_ROUND_UP((ldma_sg->len + 3) >> 2, num_segmen=
ts);
> > +
> > +     /* Word count register takes input in words */
> > +     ldma_sg->hw->len =3D segment_size;
> > +     ldma_sg->hw->step_times =3D num_segments;
> > +     ldma_sg->hw->step_len =3D 0;
> > +
> > +     /* lets make a link list */
> > +     if (sg_index) {
> > +             desc->sg[sg_index - 1].hw->ndesc_addr =3D ldma_sg->llp | =
LDMA_DESC_EN;
> > +             desc->sg[sg_index - 1].hw->high_ndesc_addr =3D upper_32_b=
its(ldma_sg->llp);
> > +     }
> > +}
> > +
> > +/*--  DMA Engine API  ------------------------------------------------=
--*/
> > +
> > +/*
> > + * ls2x_dma_alloc_chan_resources - allocate resources for DMA channel
> > + * @chan: allocate descriptor resources for this channel
> > + *
> > + * return - the number of allocated descriptors
> > + */
> > +static int ls2x_dma_alloc_chan_resources(struct dma_chan *chan)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +
> > +     /* Create a pool of consistent memory blocks for hardware descrip=
tors */
> > +     lchan->pool =3D dma_pool_create(dev_name(chan2dev(chan)),
> > +                                   chan->device->dev, PAGE_SIZE,
> > +                                   __alignof__(struct ls2x_dma_hw_desc=
), 0);
> > +     if (!lchan->pool) {
> > +             dev_err(chan2dev(chan), "No memory for descriptors\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     return 1;
> > +}
> > +
> > +/*
> > + * ls2x_dma_free_chan_resources - free all channel resources
> > + * @chan: DMA channel
> > + */
> > +static void ls2x_dma_free_chan_resources(struct dma_chan *chan)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +
> > +     vchan_free_chan_resources(to_virt_chan(chan));
> > +     dma_pool_destroy(lchan->pool);
> > +     lchan->pool =3D NULL;
> > +}
> > +
> > +/*
> > + * ls2x_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transa=
ction
> > + * @chan: DMA channel
> > + * @sgl: scatterlist to transfer to/from
> > + * @sg_len: number of entries in @scatterlist
> > + * @direction: DMA direction
> > + * @flags: tx descriptor status flags
> > + * @context: transaction context (ignored)
> > + *
> > + * Return: Async transaction descriptor on success and NULL on failure
> > + */
> > +static struct dma_async_tx_descriptor *
> > +ls2x_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > +                    u32 sg_len, enum dma_transfer_direction direction,
> > +                    unsigned long flags, void *context)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +     struct ls2x_dma_desc *desc;
> > +     struct scatterlist *sg;
> > +     size_t burst_size;
> > +     int i;
> > +
> > +     if (unlikely(!sg_len || !is_slave_direction(direction)))
> > +             return NULL;
> > +
> > +     burst_size =3D ls2x_dmac_detect_burst(lchan);
> > +     if (!burst_size)
> > +             return NULL;
> > +
> > +     desc =3D kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
>
> GFP_NOWAIT pls
got it.
>
> > +     if (!desc)
> > +             return NULL;
> > +
> > +     desc->desc_num =3D sg_len;
> > +     desc->direction =3D direction;
> > +     desc->burst_size =3D burst_size;
> > +
> > +     for_each_sg(sgl, sg, sg_len, i) {
> > +             struct ls2x_dma_sg *ldma_sg =3D &desc->sg[i];
> > +
> > +             /* Allocate DMA capable memory for hardware descriptor */
> > +             ldma_sg->hw =3D dma_pool_alloc(lchan->pool, GFP_NOWAIT, &=
ldma_sg->llp);
> > +             if (!ldma_sg->hw) {
> > +                     desc->desc_num =3D i;
> > +                     ls2x_dma_desc_free(&desc->vdesc);
> > +                     return NULL;
> > +             }
> > +
> > +             ldma_sg->phys =3D sg_dma_address(sg);
> > +             ldma_sg->len =3D sg_dma_len(sg);
> > +
> > +             ls2x_dma_fill_desc(lchan, i, desc);
> > +     }
> > +
> > +     /* Setting the last descriptor enable bit */
> > +     desc->sg[sg_len - 1].hw->ndesc_addr &=3D ~LDMA_DESC_EN;
> > +     desc->status =3D DMA_IN_PROGRESS;
> > +
> > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > +}
> > +
> > +/*
> > + * ls2x_dma_prep_dma_cyclic - prepare the cyclic DMA transfer
> > + * @chan: the DMA channel to prepare
> > + * @buf_addr: physical DMA address where the buffer starts
> > + * @buf_len: total number of bytes for the entire buffer
> > + * @period_len: number of bytes for each period
> > + * @direction: transfer direction, to or from device
> > + * @flags: tx descriptor status flags
> > + *
> > + * Return: Async transaction descriptor on success and NULL on failure
> > + */
> > +static struct dma_async_tx_descriptor *
> > +ls2x_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, s=
ize_t buf_len,
> > +                      size_t period_len, enum dma_transfer_direction d=
irection,
> > +                      unsigned long flags)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +     struct ls2x_dma_desc *desc;
> > +     u32 num_periods;
> > +     size_t burst_size;
> > +     int i;
> > +
> > +     if (unlikely(!buf_len || !period_len))
> > +             return NULL;
> > +
> > +     if (unlikely(!is_slave_direction(direction)))
> > +             return NULL;
> > +
> > +     burst_size =3D ls2x_dmac_detect_burst(lchan);
> > +     if (!burst_size)
> > +             return NULL;
> > +
> > +     num_periods =3D buf_len / period_len;
> > +     desc =3D kzalloc(struct_size(desc, sg, num_periods), GFP_ATOMIC);
>
> here too
got it.

Thanks.
Binbin
>
> > +     if (!desc)
> > +             return NULL;
> > +
> > +     desc->desc_num =3D num_periods;
> > +     desc->direction =3D direction;
> > +     desc->burst_size =3D burst_size;
> > +
> > +     /* Build cyclic linked list */
> > +     for (i =3D 0; i < num_periods; i++) {
> > +             struct ls2x_dma_sg *ldma_sg =3D &desc->sg[i];
> > +
> > +             /* Allocate DMA capable memory for hardware descriptor */
> > +             ldma_sg->hw =3D dma_pool_alloc(lchan->pool, GFP_NOWAIT, &=
ldma_sg->llp);
> > +             if (!ldma_sg->hw) {
> > +                     desc->desc_num =3D i;
> > +                     ls2x_dma_desc_free(&desc->vdesc);
> > +                     return NULL;
> > +             }
> > +
> > +             ldma_sg->phys =3D buf_addr + period_len * i;
> > +             ldma_sg->len =3D period_len;
> > +
> > +             ls2x_dma_fill_desc(lchan, i, desc);
> > +     }
> > +
> > +     /* Lets make a cyclic list */
> > +     desc->sg[num_periods - 1].hw->ndesc_addr =3D desc->sg[0].llp | LD=
MA_DESC_EN;
> > +     desc->sg[num_periods - 1].hw->high_ndesc_addr =3D upper_32_bits(d=
esc->sg[0].llp);
> > +     desc->cyclic =3D true;
> > +     desc->status =3D DMA_IN_PROGRESS;
> > +
> > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > +}
> > +
> > +/*
> > + * ls2x_slave_config - set slave configuration for channel
> > + * @chan: dma channel
> > + * @cfg: slave configuration
> > + *
> > + * Sets slave configuration for channel
> > + */
> > +static int ls2x_dma_slave_config(struct dma_chan *chan,
> > +                              struct dma_slave_config *config)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +
> > +     memcpy(&lchan->sconfig, config, sizeof(*config));
> > +     return 0;
> > +}
> > +
> > +/*
> > + * ls2x_dma_issue_pending - push pending transactions to the hardware
> > + * @chan: channel
> > + *
> > + * When this function is called, all pending transactions are pushed t=
o the
> > + * hardware and executed.
> > + */
> > +static void ls2x_dma_issue_pending(struct dma_chan *chan)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > +     if (vchan_issue_pending(&lchan->vchan) && !lchan->desc)
> > +             ls2x_dma_start_transfer(lchan);
> > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > +}
> > +
> > +/*
> > + * ls2x_dma_terminate_all - terminate all transactions
> > + * @chan: channel
> > + *
> > + * Stops all DMA transactions.
> > + */
> > +static int ls2x_dma_terminate_all(struct dma_chan *chan)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +     unsigned long flags;
> > +     LIST_HEAD(head);
> > +
> > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > +     /* Setting stop cmd */
> > +     ls2x_dma_write_cmd(lchan, LDMA_STOP);
> > +     if (lchan->desc) {
> > +             vchan_terminate_vdesc(&lchan->desc->vdesc);
> > +             lchan->desc =3D NULL;
> > +     }
> > +
> > +     vchan_get_all_descriptors(&lchan->vchan, &head);
> > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > +
> > +     vchan_dma_desc_free_list(&lchan->vchan, &head);
> > +     return 0;
> > +}
> > +
> > +/*
> > + * ls2x_dma_synchronize - Synchronizes the termination of transfers to=
 the
> > + * current context.
> > + * @chan: channel
> > + */
> > +static void ls2x_dma_synchronize(struct dma_chan *chan)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +
> > +     vchan_synchronize(&lchan->vchan);
> > +}
> > +
> > +static int ls2x_dma_pause(struct dma_chan *chan)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > +     if (lchan->desc && lchan->desc->status =3D=3D DMA_IN_PROGRESS) {
> > +             ls2x_dma_write_cmd(lchan, LDMA_STOP);
> > +             lchan->desc->status =3D DMA_PAUSED;
> > +     }
> > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls2x_dma_resume(struct dma_chan *chan)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > +     if (lchan->desc && lchan->desc->status =3D=3D DMA_PAUSED) {
> > +             lchan->desc->status =3D DMA_IN_PROGRESS;
> > +             ls2x_dma_write_cmd(lchan, LDMA_START);
> > +     }
> > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * ls2x_dma_isr - LS2X DMA Interrupt handler
> > + * @irq: IRQ number
> > + * @dev_id: Pointer to ls2x_dma_chan
> > + *
> > + * Return: IRQ_HANDLED/IRQ_NONE
> > + */
> > +static irqreturn_t ls2x_dma_isr(int irq, void *dev_id)
> > +{
> > +     struct ls2x_dma_chan *lchan =3D dev_id;
> > +     struct ls2x_dma_desc *desc;
> > +
> > +     spin_lock(&lchan->vchan.lock);
> > +     desc =3D lchan->desc;
> > +     if (desc) {
> > +             if (desc->cyclic) {
> > +                     vchan_cyclic_callback(&desc->vdesc);
> > +             } else {
> > +                     desc->status =3D DMA_COMPLETE;
> > +                     vchan_cookie_complete(&desc->vdesc);
> > +                     ls2x_dma_start_transfer(lchan);
> > +             }
> > +
> > +             /* ls2x_dma_start_transfer() updates lchan->desc */
> > +             if (!lchan->desc)
> > +                     ls2x_dma_write_cmd(lchan, LDMA_STOP);
> > +     }
> > +     spin_unlock(&lchan->vchan.lock);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int ls2x_dma_chan_init(struct platform_device *pdev,
> > +                           struct ls2x_dma_priv *priv)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct ls2x_dma_chan *lchan =3D &priv->lchan;
> > +     int ret;
> > +
> > +     lchan->irq =3D platform_get_irq(pdev, 0);
> > +     if (lchan->irq < 0)
> > +             return lchan->irq;
> > +
> > +     ret =3D devm_request_irq(dev, lchan->irq, ls2x_dma_isr, IRQF_TRIG=
GER_RISING,
> > +                            dev_name(&pdev->dev), lchan);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Initialize channels related values */
> > +     INIT_LIST_HEAD(&priv->ddev.channels);
> > +     lchan->vchan.desc_free =3D ls2x_dma_desc_free;
> > +     vchan_init(&lchan->vchan, &priv->ddev);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * ls2x_dma_probe - Driver probe function
> > + * @pdev: Pointer to the platform_device structure
> > + *
> > + * Return: '0' on success and failure value on error
> > + */
> > +static int ls2x_dma_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct dma_device *ddev;
> > +     struct ls2x_dma_priv *priv;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(priv->regs))
> > +             return dev_err_probe(dev, PTR_ERR(priv->regs),
> > +                                  "devm_platform_ioremap_resource fail=
ed.\n");
> > +
> > +     priv->dma_clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(priv->dma_clk))
> > +             return dev_err_probe(dev, PTR_ERR(priv->dma_clk), "devm_c=
lk_get failed.\n");
> > +
> > +     ret =3D clk_prepare_enable(priv->dma_clk);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "clk_prepare_enable failed=
.\n");
> > +
> > +     ret =3D ls2x_dma_chan_init(pdev, priv);
> > +     if (ret)
> > +             goto disable_clk;
> > +
> > +     ddev =3D &priv->ddev;
> > +     ddev->dev =3D dev;
> > +     dma_cap_zero(ddev->cap_mask);
> > +     dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > +     dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> > +
> > +     ddev->device_alloc_chan_resources =3D ls2x_dma_alloc_chan_resourc=
es;
> > +     ddev->device_free_chan_resources =3D ls2x_dma_free_chan_resources=
;
> > +     ddev->device_tx_status =3D dma_cookie_status;
> > +     ddev->device_issue_pending =3D ls2x_dma_issue_pending;
> > +     ddev->device_prep_slave_sg =3D ls2x_dma_prep_slave_sg;
> > +     ddev->device_prep_dma_cyclic =3D ls2x_dma_prep_dma_cyclic;
> > +     ddev->device_config =3D ls2x_dma_slave_config;
> > +     ddev->device_terminate_all =3D ls2x_dma_terminate_all;
> > +     ddev->device_synchronize =3D ls2x_dma_synchronize;
> > +     ddev->device_pause =3D ls2x_dma_pause;
> > +     ddev->device_resume =3D ls2x_dma_resume;
> > +
> > +     ddev->src_addr_widths =3D LDMA_SLAVE_BUSWIDTHS;
> > +     ddev->dst_addr_widths =3D LDMA_SLAVE_BUSWIDTHS;
> > +     ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > +
> > +     ret =3D dma_async_device_register(&priv->ddev);
> > +     if (ret < 0)
> > +             goto disable_clk;
> > +
> > +     ret =3D of_dma_controller_register(dev->of_node, of_dma_xlate_by_=
chan_id, priv);
> > +     if (ret < 0)
> > +             goto unregister_dmac;
> > +
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     dev_info(dev, "Loongson LS2X APB DMA driver registered successful=
ly.\n");
> > +     return 0;
> > +
> > +unregister_dmac:
> > +     dma_async_device_unregister(&priv->ddev);
> > +disable_clk:
> > +     clk_disable_unprepare(priv->dma_clk);
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * ls2x_dma_remove - Driver remove function
> > + * @pdev: Pointer to the platform_device structure
> > + */
> > +static void ls2x_dma_remove(struct platform_device *pdev)
> > +{
> > +     struct ls2x_dma_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +     of_dma_controller_free(pdev->dev.of_node);
> > +     dma_async_device_unregister(&priv->ddev);
> > +     clk_disable_unprepare(priv->dma_clk);
> > +}
> > +
> > +static const struct of_device_id ls2x_dma_of_match_table[] =3D {
> > +     { .compatible =3D "loongson,ls2k1000-apbdma" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ls2x_dma_of_match_table);
> > +
> > +static struct platform_driver ls2x_dmac_driver =3D {
> > +     .probe          =3D ls2x_dma_probe,
> > +     .remove_new     =3D ls2x_dma_remove,
> > +     .driver =3D {
> > +             .name   =3D "ls2x-apbdma",
> > +             .of_match_table =3D ls2x_dma_of_match_table,
> > +     },
> > +};
> > +module_platform_driver(ls2x_dmac_driver);
> > +
> > +MODULE_DESCRIPTION("Loongson LS2X APB DMA Controller driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.39.3
>
> --
> ~Vinod

