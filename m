Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235007577D0
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jul 2023 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjGRJYZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jul 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjGRJYT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jul 2023 05:24:19 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB279FD;
        Tue, 18 Jul 2023 02:24:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-579dd20b1c8so52842977b3.1;
        Tue, 18 Jul 2023 02:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689672256; x=1692264256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wPQMXrZHHU4VHijmwsb5c+o14pJQBCyR6/K0nxLxeo=;
        b=kv5d5/s9xksVM+/RtyFy7j7iu+ckSCCqJeWE7xlEtjlQaERFYExpm2dyOkduX9CupM
         hyGEdKV3W5CJH5uHgZ0WeDRf+DBY4dNUKPs2VD0jsFwvqaTDTIGcY1ttnlbuKblIrN2N
         fY0lO5jsLcPB76hkZKganoJNe9orwqS2FrgtPK/hqNWaZNGzmPz5bBmGAwlH2l3/vleB
         4gNxfP0olKYZzsJtLEcerXZ97QRsf3qMtZ59tF7kk8ujYPkaCUER2RZV3sdjnzV0RuS1
         AZ2h7phk3SVUEKNvNjlQqw+PfcYlY4OeZYQJGoEVKgdYe6NaEUndmVTUSGqB7XjSBTec
         +5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689672256; x=1692264256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wPQMXrZHHU4VHijmwsb5c+o14pJQBCyR6/K0nxLxeo=;
        b=Ggiiroso8nBQ7HsdxKVZ5nk2/WhyhD/FE/N5ncDHHBBGb31LqMCIDtCvx1FBxBukyC
         WDm3DcmOjSz2suktTX0pIhXHXTtLRG95I+B7YdiQqleTFGvpN8rbqL9knFKLGFBioxNW
         G/QH3xDRXoQLg/pYvQYEUmcCCTzJPMuGrHM/1QF+V6ztWl4GMcwEvvCCvuBUE/OqJn7C
         4ssLTdu3M8RgYXUCMVC3ZPzEmRFTQHj7CF68zZ616Ls5fp2hhcWnqFqZPAodiiQLEOdQ
         iw10d20EIcVkF8F8rGQE3JGHzuL8QgGVboVifD2p+LN2gvrUB9ZVO3G6IeF39LmZGBTh
         cv3g==
X-Gm-Message-State: ABy/qLaLIP8ZgkdEr6DaoLv2VEzsim/ukNo6PUqSaFmwneBwtKNwF0VV
        umW0MfKcnwwISeQaFoaehxvMm7XDOJHjhJzE0NA=
X-Google-Smtp-Source: APBJJlFht+l+R3L9LPkc98A/HzSDVi7nrZFS6Gtm0h89//9xnxj88EVdqYNXJONpac4SfaOYcJDNSe5BUVO639LO3Og=
X-Received: by 2002:a81:54c2:0:b0:576:8d7f:d163 with SMTP id
 i185-20020a8154c2000000b005768d7fd163mr15557147ywb.8.1689672256006; Tue, 18
 Jul 2023 02:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689075791.git.zhoubinbin@loongson.cn> <b282ef7c5d1841886a80b2b6502c735f2f0254c9.1689075791.git.zhoubinbin@loongson.cn>
 <80A5D36E-0417-4048-8324-ACFC08FC2CED@gmail.com>
In-Reply-To: <80A5D36E-0417-4048-8324-ACFC08FC2CED@gmail.com>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Tue, 18 Jul 2023 17:24:04 +0800
Message-ID: <CAMpQs4LBz63bTRLq-zU-JosE2HS29vXStEZA5unCAXSQF=tz3g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: ls2x-apb: new driver for the Loongson
 LS2X APB DMA controller
To:     michael5hzg <michael5hzg@gmail.com>
Cc:     "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "mengyingkun@loongson.cn" <mengyingkun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 18, 2023 at 4:43=E2=80=AFPM michael5hzg <michael5hzg@gmail.com>=
 wrote:
>
> The Loongson LS2X APB DMA controller is available on Loongson-2K chips.
>
> It is a single-channel, configurable DMA controller IP core based on the
> AXI bus, whose main function is to integrate DMA functionality on a chip
> dedicated to carrying data between memory and peripherals in APB bus
> (e.g. nand).
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
> ---
> MAINTAINERS                |   1 +
> drivers/dma/Kconfig        |  14 +
> drivers/dma/Makefile       |   1 +
> drivers/dma/ls2x-apb-dma.c | 684 +++++++++++++++++++++++++++++++++++++
> 4 files changed, 700 insertions(+)
> create mode 100644 drivers/dma/ls2x-apb-dma.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60a411936ba7..709c2e9d5f5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12248,6 +12248,7 @@ M:  Binbin Zhou <zhoubinbin@loongson.cn>
> L:  dmaengine@vger.kernel.org
> S:  Maintained
> F:  Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> +F:  drivers/dma/ls2x-apb-dma.c
>
> LOONGSON LS2X I2C DRIVER
> M:  Binbin Zhou <zhoubinbin@loongson.cn>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 644c188d6a11..9b41b59ba2b4 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -376,6 +376,20 @@ config LPC18XX_DMAMUX
> Enable support for DMA on NXP LPC18xx/43xx platforms
> with PL080 and multiplexed DMA request lines.
>
> +config LS2X_APB_DMA
> +  tristate "Loongson LS2X APB DMA support"
> +  depends on LOONGARCH || COMPILE_TEST
> +  select DMA_ENGINE
> +  select DMA_VIRTUAL_CHANNELS
> +  help
> +    Support for the Loongson LS2X APB DMA controller driver. The
> +    DMA controller is having single DMA channel which can be
> +    configured for different peripherals like audio, nand, sdio
> +    etc which is in APB bus.
> +
> +    This DMA controller transfers data from memory to peripheral fifo.
> +    It does not support memory to memory data transfer.
> +
> config MCF_EDMA
> tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
> depends on M5441x || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a4fd1ce29510..9b28ddb1ea3b 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> obj-y +=3D idxd/
> obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> +obj-$(CONFIG_LS2X_APB_DMA) +=3D ls2x-apb-dma.o
> obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> obj-$(CONFIG_MILBEAUT_XDMAC) +=3D milbeaut-xdmac.o
> obj-$(CONFIG_MMP_PDMA) +=3D mmp_pdma.o
> diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
> new file mode 100644
> index 000000000000..b3efe86e4330
> --- /dev/null
> +++ b/drivers/dma/ls2x-apb-dma.c
> @@ -0,0 +1,684 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for the Loongson LS2X APB DMA Controller
> + *
> + * Copyright (C) 2017-2023 Loongson Corporation
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +
> +#include "dmaengine.h"
> +#include "virt-dma.h"
> +
> +/* Global Configuration Register */
> +#define LDMA_ORDER_ERG    0x0
> +
> +/* Bitfield definitions */
> +
> +/* Bitfields in Global Configuration Register */
> +#define LDMA_64BIT_EN    BIT(0) /* 1: 64 bit support */
> +#define LDMA_UNCOHERENT_EN  BIT(1) /* 0: cache, 1: uncache */
> +#define LDMA_ASK_VALID    BIT(2)
> +#define LDMA_START    BIT(3) /* DMA start operation */
> +#define LDMA_STOP    BIT(4) /* DMA stop operation */
> +#define LDMA_CONFIG_MASK  GENMASK(4, 0) /* DMA controller config bits ma=
sk */
> +
> +/* Bitfields in ndesc_addr field of HW decriptor */
> +#define LDMA_DESC_EN    BIT(0) /*1: The next descriptor is valid */
> +#define LDMA_DESC_ADDR_LOW  GENMASK(31, 1)
> +
> +/* Bitfields in cmd field of HW decriptor */
> +#define LDMA_INT    BIT(1) /* Enable DMA interrupts */
> +#define LDMA_DATA_DIRECTION  BIT(12) /* 1: write to device, 0: read from=
 device */
> +
> +/*--  descriptors  -----------------------------------------------------=
*/
> +
> +/*
> + * struct ls2x_dma_hw_desc - DMA HW descriptor
> + * @ndesc_addr: the next descriptor low address.
> + * @mem_addr: memory low address.
> + * @apb_addr: device buffer address.
> + * @len: length of a piece of carried content, in words.
> + * @step_len: length between two moved memory data blocks.
> + * @step_times: number of blocks to be carried in a single DMA operation=
.
> + * @cmd: descriptor command or state.
> + * @stats: DMA status.
> + * @high_ndesc_addr: the next descriptor high address.
> + * @high_mem_addr: memory high address.
> + * @reserved: reserved
> + */
> +struct ls2x_dma_hw_desc {
> +  u32 ndesc_addr;
> +  u32 mem_addr;
> +  u32 apb_addr;
> +  u32 len;
> +  u32 step_len;
> +  u32 step_times;
> +  u32 cmd;
> +  u32 stats;
> +  u32 high_ndesc_addr;
> +  u32 high_mem_addr;
> +  u32 reserved[2];
> +} __packed;
> +
> +/*
> + * struct ls2x_dma_sg - ls2x dma scatter gather entry
> + * @hw: the pointer to DMA HW descriptor.
> + * @llp: physical address of the DMA HW descriptor.
> + * @phys: destination or source address(mem).
> + * @len: number of Bytes to read.
> + */
> +struct ls2x_dma_sg {
> +  struct ls2x_dma_hw_desc  *hw;
> +  dma_addr_t    llp;
> +  dma_addr_t    phys;
> +  u32      len;
> +};
> +
> +/*
> + * struct ls2x_dma_desc - software descriptor
> + * @vdesc: pointer to the virtual dma descriptor.
> + * @cyclic: flag to dma cyclic
> + * @sglen: number of sg entries.
> + * @direction: transfer direction, to or from device.
> + * @status: dma controller status.
> + * @sg: array of sgs.
> + */
> +struct ls2x_dma_desc {
> +  struct virt_dma_desc    vdesc;
> +  bool        cyclic;
> +  u32        sglen;
> +  enum dma_transfer_direction  direction;
> +  enum dma_status      status;
> +  struct ls2x_dma_sg    sg[];
> +};
> +
> +/*--  Channels  --------------------------------------------------------=
*/
> +
> +/*
> + * struct ls2x_dma_chan - internal representation of an LS2X APB DMA cha=
nnel
> + * @vchan: virtual dma channel entry.
> + * @desc: pointer to the ls2x sw dma descriptor.
> + * @pool: hw desc table
> + * @irq: irq line
> + * @sconfig: configuration for slave transfers, passed via .device_confi=
g
> + */
> +struct ls2x_dma_chan {
> +  struct virt_dma_chan  vchan;
> +  struct ls2x_dma_desc  *desc;
> +  void      *pool;
> +  int      irq;
> +  struct dma_slave_config  sconfig;
> +};
> +
> +/*--  Controller  ------------------------------------------------------=
*/
> +
> +/*
> + * struct ls2x_dma_priv - LS2X APB DMAC specific information
> + * @ddev: dmaengine dma_device object members
> + * @dma_clk: DMAC clock source
> + * @regs: memory mapped register base
> + * @lchan: channel to store ls2x_dma_chan structures
> + */
> +struct ls2x_dma_priv {
> +  struct dma_device  ddev;
> +  struct clk    *dma_clk;
> +  void __iomem    *regs;
> +  struct ls2x_dma_chan  lchan;
> +};
> +
> +/*--  Helper functions  ------------------------------------------------=
*/
> +
> +static inline struct ls2x_dma_desc *to_ldma_desc(struct virt_dma_desc *v=
desc)
> +{
> +  return container_of(vdesc, struct ls2x_dma_desc, vdesc);
> +}
> +
> +static inline struct ls2x_dma_chan *to_ldma_chan(struct dma_chan *chan)
> +{
> +  return container_of(chan, struct ls2x_dma_chan, vchan.chan);
> +}
> +
> +static inline struct ls2x_dma_priv *to_ldma_priv(struct dma_device *ddev=
)
> +{
> +  return container_of(ddev, struct ls2x_dma_priv, ddev);
> +}
> +
> +static struct device *chan2dev(struct dma_chan *chan)
> +{
> +  return &chan->dev->device;
> +}
> +
> +static void ls2x_dma_desc_free(struct virt_dma_desc *vdesc)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(vdesc->tx.chan);
> +  struct ls2x_dma_desc *desc =3D to_ldma_desc(vdesc);
> +  int i;
> +
> +  for (i =3D 0; i < desc->sglen; i++) {
> +    if (desc->sg[i].hw)
> +      dma_pool_free(lchan->pool, desc->sg[i].hw,
> +              desc->sg[i].llp);
> +  }
> +
> +  kfree(desc);
> +}
> +
> +static void ls2x_dma_write_cmd(struct ls2x_dma_chan *lchan, bool cmd)
> +{
> +  u64 val =3D 0;
> +  struct ls2x_dma_priv *priv =3D to_ldma_priv(lchan->vchan.chan.device);
> +
> +  val =3D lo_hi_readq(priv->regs + LDMA_ORDER_ERG) & ~LDMA_CONFIG_MASK;
> +  val |=3D LDMA_64BIT_EN | cmd;
> +  lo_hi_writeq(val, priv->regs + LDMA_ORDER_ERG);
> +}
> +
> +static void ls2x_dma_start_transfer(struct ls2x_dma_chan *lchan)
> +{
> +  struct ls2x_dma_priv *priv =3D to_ldma_priv(lchan->vchan.chan.device);
> +  struct ls2x_dma_sg *ldma_sg;
> +  struct virt_dma_desc *vdesc;
> +  u64 val;
> +
> +  /* Get the next descriptor */
> +  vdesc =3D vchan_next_desc(&lchan->vchan);
> +  if (!vdesc) {
> +    lchan->desc =3D NULL;
> +    return;
> +  }
> +
> +  list_del(&vdesc->node);
> +  lchan->desc =3D to_ldma_desc(vdesc);
> +  ldma_sg =3D &lchan->desc->sg[0];
> +
> +  /* Start DMA */
> +  lo_hi_writeq(0, priv->regs + LDMA_ORDER_ERG);
> +  val =3D (ldma_sg->llp & ~LDMA_CONFIG_MASK) | LDMA_64BIT_EN | LDMA_STAR=
T;
> +  lo_hi_writeq(val, priv->regs + LDMA_ORDER_ERG);
> +}
> +
> +static void ls2x_dma_fill_desc(struct ls2x_dma_chan *lchan, u32 i,
> +             struct ls2x_dma_desc *desc)
> +{
> +  struct ls2x_dma_sg *ldma_sg =3D &desc->sg[i];
> +
> +  ldma_sg->hw->mem_addr =3D lower_32_bits(ldma_sg->phys);
> +  ldma_sg->hw->high_mem_addr =3D upper_32_bits(ldma_sg->phys);
> +  /* Word count register takes input in words */
> +  ldma_sg->hw->len =3D ldma_sg->len >> 2;
> +  ldma_sg->hw->step_len =3D 0;
> +  ldma_sg->hw->step_times =3D 1;
> +
> +  if (desc->direction =3D=3D DMA_MEM_TO_DEV) {
> +    ldma_sg->hw->cmd =3D LDMA_INT | LDMA_DATA_DIRECTION;
> +    ldma_sg->hw->apb_addr =3D lchan->sconfig.dst_addr;
> +  } else {
> +    ldma_sg->hw->cmd =3D LDMA_INT;
> +    ldma_sg->hw->apb_addr =3D lchan->sconfig.src_addr;
> +  }
> +
> +  /* lets make a link list */
> +  if (i) {
> +    desc->sg[i - 1].hw->ndesc_addr =3D ldma_sg->llp | LDMA_DESC_EN;
> +    desc->sg[i - 1].hw->high_ndesc_addr =3D upper_32_bits(ldma_sg->llp);
> +  }
> +}
> +
> +/*--  DMA Engine API  --------------------------------------------------=
*/
> +
> +/*
> + * ls2x_dma_alloc_chan_resources - allocate resources for DMA channel
> + * @chan: allocate descriptor resources for this channel
> + *
> + * return - the number of allocated descriptors
> + */
> +static int ls2x_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +
> +  /* Create a pool of consistent memory blocks for hardware descriptors =
*/
> +  lchan->pool =3D dma_pool_create(dev_name(chan2dev(chan)),
> +              chan->device->dev, PAGE_SIZE,
> +              __alignof__(struct ls2x_dma_hw_desc), 0);
> +  if (!lchan->pool) {
> +    dev_err(chan2dev(chan), "No memory for descriptors\n");
> +    return -ENOMEM;
> +  }
> +
> +  return 1;
> +}
> +
> +/*
> + * ls2x_dma_free_chan_resources - free all channel resources
> + * @chan: DMA channel
> + */
> +static void ls2x_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +
> +  vchan_free_chan_resources(to_virt_chan(chan));
> +  dma_pool_destroy(lchan->pool);
> +  lchan->pool =3D NULL;
> +}
> +
> +/*
> + * ls2x_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transact=
ion
> + * @chan: DMA channel
> + * @sgl: scatterlist to transfer to/from
> + * @sg_len: number of entries in @scatterlist
> + * @direction: DMA direction
> + * @flags: tx descriptor status flags
> + * @context: transaction context (ignored)
> + *
> + * Return: Async transaction descriptor on success and NULL on failure
> + */
> +static struct dma_async_tx_descriptor *
> +ls2x_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +           u32 sg_len, enum dma_transfer_direction direction,
> +           unsigned long flags, void *context)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +  struct ls2x_dma_desc *desc;
> +  struct scatterlist *sg;
> +  int i;
> +
> +  if (unlikely(!sg_len || !is_slave_direction(direction)))
> +    return NULL;
> +
> +  desc =3D kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
> +  if (!desc)
> +    return NULL;
> +  desc->sglen =3D sg_len;
> +  desc->direction =3D direction;
> +
> +  for_each_sg(sgl, sg, sg_len, i) {
> +    struct ls2x_dma_sg *ldma_sg =3D &desc->sg[i];
> +
> +    /* Allocate DMA capable memory for hardware descriptor */
> +    ldma_sg->hw =3D dma_pool_alloc(lchan->pool, GFP_NOWAIT, &ldma_sg->ll=
p);
> +    if (!ldma_sg->hw) {
> +      desc->sglen =3D i;
> +      ls2x_dma_desc_free(&desc->vdesc);
> +      return NULL;
> +    }
> +
> +    ldma_sg->phys =3D sg_dma_address(sg);
> +    ldma_sg->len =3D sg_dma_len(sg);
> +
> +    ls2x_dma_fill_desc(lchan, i, desc);
> +  }
> +
> +  /* Setting the last descriptor enable bit */
> +  desc->sg[sg_len - 1].hw->ndesc_addr &=3D ~LDMA_DESC_EN;
> +  desc->status =3D DMA_IN_PROGRESS;
> +
> +  return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +/*
> + * ls2x_dma_prep_dma_cyclic - prepare the cyclic DMA transfer
> + * @chan: the DMA channel to prepare
> + * @buf_addr: physical DMA address where the buffer starts
> + * @buf_len: total number of bytes for the entire buffer
> + * @period_len: number of bytes for each period
> + * @direction: transfer direction, to or from device
> + * @flags: tx descriptor status flags
> + *
> + * Return: Async transaction descriptor on success and NULL on failure
> + */
> +static struct dma_async_tx_descriptor *
> +ls2x_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, siz=
e_t buf_len,
> +       size_t period_len, enum dma_transfer_direction direction,
> +       unsigned long flags)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +  struct ls2x_dma_desc *desc;
> +  u32 periods;
> +  int i;
> +
> +  if (unlikely(!buf_len || !period_len))
> +    return NULL;
> +
> +  if (unlikely(!is_slave_direction(direction)))
> +    return NULL;
> +
> +  periods =3D buf_len / period_len;
> +  desc =3D kzalloc(struct_size(desc, sg, periods), GFP_ATOMIC);
> +  if (!desc)
> +    return NULL;
> +  desc->sglen =3D periods;
> +  desc->direction =3D direction;
> +
> +  /* Build cyclic linked list */
> +  for (i =3D 0; i < periods; i++) {
> +    struct ls2x_dma_sg *ldma_sg =3D &desc->sg[i];
> +
> +    /* Allocate DMA capable memory for hardware descriptor */
> +    ldma_sg->hw =3D dma_pool_alloc(lchan->pool, GFP_NOWAIT, &ldma_sg->ll=
p);
> +    if (!ldma_sg->hw) {
> +      desc->sglen =3D i;
> +      ls2x_dma_desc_free(&desc->vdesc);
> +      return NULL;
> +    }
> +
> +    ldma_sg->phys =3D buf_addr + period_len * i;
> +    ldma_sg->len =3D period_len;
> +
> +    ls2x_dma_fill_desc(lchan, i, desc);
> +  }
> +
> +  /* Lets make a cyclic list */
> +  desc->sg[periods - 1].hw->ndesc_addr =3D desc->sg[0].llp | LDMA_DESC_E=
N;
> +  desc->sg[periods - 1].hw->high_ndesc_addr =3D upper_32_bits(desc->sg[0=
].llp);
> +  desc->cyclic =3D true;
> +  desc->status =3D DMA_IN_PROGRESS;
> +
> +  return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +/*
> + * ls2x_slave_config - set slave configuration for channel
> + * @chan: dma channel
> + * @cfg: slave configuration
> + *
> + * Sets slave configuration for channel
> + */
> +static int ls2x_dma_slave_config(struct dma_chan *chan,
> +         struct dma_slave_config *config)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +
> +  memcpy(&lchan->sconfig, config, sizeof(*config));
> +  return 0;
> +}
> +
> +/*
> + * ls2x_dma_issue_pending - push pending transactions to the hardware
> + * @chan: channel
> + *
> + * When this function is called, all pending transactions are pushed to =
the
> + * hardware and executed.
> + */
> +static void ls2x_dma_issue_pending(struct dma_chan *chan)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +  unsigned long flags;
> +
> +  spin_lock_irqsave(&lchan->vchan.lock, flags);
> +  if (vchan_issue_pending(&lchan->vchan) && !lchan->desc)
> +    ls2x_dma_start_transfer(lchan);
> +  spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +}
> +
> +/*
> + * ls2x_dma_terminate_all - terminate all transactions
> + * @chan: channel
> + *
> + * Stops all DMA transactions.
> + */
> +static int ls2x_dma_terminate_all(struct dma_chan *chan)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +  unsigned long flags;
> +  LIST_HEAD(head);
> +
> +  spin_lock_irqsave(&lchan->vchan.lock, flags);
> +  /* Setting stop cmd */
> +  ls2x_dma_write_cmd(lchan, LDMA_STOP);
> +  if (lchan->desc) {
> +    vchan_terminate_vdesc(&lchan->desc->vdesc);
> +    lchan->desc =3D NULL;
> +  }
> +
> +  vchan_get_all_descriptors(&lchan->vchan, &head);
> +  spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +
> +  vchan_dma_desc_free_list(&lchan->vchan, &head);
> +  return 0;
> +}
> +
> +/*
> + * ls2x_dma_synchronize - Synchronizes the termination of transfers to t=
he
> + * current context.
> + * @chan: channel
> + */
> +static void ls2x_dma_synchronize(struct dma_chan *chan)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +
> +  vchan_synchronize(&lchan->vchan);
> +}
> +
> +static int ls2x_dma_pause(struct dma_chan *chan)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +  unsigned long flags;
> +
> +  spin_lock_irqsave(&lchan->vchan.lock, flags);
> +  if (lchan->desc && lchan->desc->status =3D=3D DMA_IN_PROGRESS) {
> +    ls2x_dma_write_cmd(lchan, LDMA_STOP);
> +    lchan->desc->status =3D DMA_PAUSED;
> +  }
> +  spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +
> +  return 0;
> +}
> +
> +static int ls2x_dma_resume(struct dma_chan *chan)
> +{
> +  struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> +  unsigned long flags;
> +
> +  spin_lock_irqsave(&lchan->vchan.lock, flags);
> +  if (lchan->desc && lchan->desc->status =3D=3D DMA_PAUSED) {
> +    lchan->desc->status =3D DMA_IN_PROGRESS;
> +    ls2x_dma_write_cmd(lchan, LDMA_START);
> +  }
> +  spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +
> +  return 0;
> +}
> +
> +/*
> + * of_ls2x_dma_xlate - Translation function
> + * @dma_spec: Pointer to DMA specifier as found in the device tree
> + * @ofdma: Pointer to DMA controller data
> + *
> + * Return: DMA channel pointer on success and NULL on error
> + */
> +static struct dma_chan *of_ls2x_dma_xlate(struct of_phandle_args *dma_sp=
ec,
> +            struct of_dma *ofdma)
> +{
> +  struct ls2x_dma_priv *priv =3D ofdma->of_dma_data;
> +  struct ls2x_dma_chan *lchan;
> +
> +  /* We are single channel DMA, just get the channel from priv. */
> +  lchan =3D &priv->lchan;
> +  if (!lchan)
> +    return NULL;
> +
> +  return dma_get_slave_channel(&lchan->vchan.chan);
> +}
> +
> +/*
> + * ls2x_dma_isr - LS2X DMA Interrupt handler
> + * @irq: IRQ number
> + * @dev_id: Pointer to ls2x_dma_chan
> + *
> + * Return: IRQ_HANDLED/IRQ_NONE
> + */
> +static irqreturn_t ls2x_dma_isr(int irq, void *dev_id)
> +{
> +  struct ls2x_dma_chan *lchan =3D dev_id;
> +  struct ls2x_dma_desc *desc;
> +
> +  spin_lock(&lchan->vchan.lock);
> +  desc =3D lchan->desc;
> +  if (desc) {
> +    if (desc->cyclic) {
> +      vchan_cyclic_callback(&desc->vdesc);
> +    } else {
> +      desc->status =3D DMA_COMPLETE;
> +      vchan_cookie_complete(&desc->vdesc);
> +      ls2x_dma_start_transfer(lchan);
> +    }
> +
> +    /* ls2x_dma_start_transfer() updates lchan->desc */
> +    if (!lchan->desc)
> +      ls2x_dma_write_cmd(lchan, LDMA_STOP);
> +  }
> +  spin_unlock(&lchan->vchan.lock);
> +
> +  return IRQ_HANDLED;
> +}
> +
> +static int ls2x_dma_chan_init(struct platform_device *pdev,
> +            struct ls2x_dma_priv *priv)
> +{
> +  struct device *dev =3D &pdev->dev;
> +  struct ls2x_dma_chan *lchan =3D &priv->lchan;
> +  int ret;
> +
> +  lchan->irq =3D platform_get_irq(pdev, 0);
> +  if (lchan->irq < 0)
> +    return lchan->irq;
> +
> +  ret =3D devm_request_irq(dev, lchan->irq, ls2x_dma_isr, IRQF_TRIGGER_R=
ISING,
> +             dev_name(&pdev->dev), lchan);
> +  if (ret)
> +    return ret;
> +
> +  /* Initialize channels related values */
> +  INIT_LIST_HEAD(&priv->ddev.channels);
> +  lchan =3D &priv->lchan;
> +  lchan->vchan.desc_free =3D ls2x_dma_desc_free;
> +  vchan_init(&lchan->vchan, &priv->ddev);
> +
> +  return 0;
> +}
> +
> +/*
> + * ls2x_dma_probe - Driver probe function
> + * @pdev: Pointer to the platform_device structure
> + *
> + * Return: '0' on success and failure value on error
> + */
> +static int ls2x_dma_probe(struct platform_device *pdev)
> +{
> +  int ret;
> +  struct dma_device *ddev;
> +  struct ls2x_dma_priv *priv;
> +  struct device *dev =3D &pdev->dev;
> +
> +  priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +  if (!priv)
> +    return -ENOMEM;
> +
> +  priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +  if (IS_ERR(priv->regs))
> +    return dev_err_probe(dev, PTR_ERR(priv->regs),
> +             "devm_platform_ioremap_resource failed.\n");
> +
> +  priv->dma_clk =3D devm_clk_get(&pdev->dev, NULL);
> +  if (IS_ERR(priv->dma_clk))
> +    return dev_err_probe(dev, PTR_ERR(priv->dma_clk), "devm_clk_get fail=
ed.\n");
> +
> +  ret =3D clk_prepare_enable(priv->dma_clk);
> +  if (ret)
> +    return dev_err_probe(dev, ret, "clk_prepare_enable failed.\n");
> +
> +  ret =3D ls2x_dma_chan_init(pdev, priv);
> +  if (ret)
> +    goto disable_clk;
> +
> +  ddev =3D &priv->ddev;
> +  ddev->dev =3D dev;
> +  dma_cap_zero(ddev->cap_mask);
> +  dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> +  dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> +
> +  ddev->device_alloc_chan_resources =3D ls2x_dma_alloc_chan_resources;
> +  ddev->device_free_chan_resources =3D ls2x_dma_free_chan_resources;
> +  ddev->device_tx_status =3D dma_cookie_status;
> +  ddev->device_issue_pending =3D ls2x_dma_issue_pending;
> +  ddev->device_prep_slave_sg =3D ls2x_dma_prep_slave_sg;
> +  ddev->device_prep_dma_cyclic =3D ls2x_dma_prep_dma_cyclic;
> +  ddev->device_config =3D ls2x_dma_slave_config;
> +  ddev->device_terminate_all =3D ls2x_dma_terminate_all;
> +  ddev->device_synchronize =3D ls2x_dma_synchronize;
> +  ddev->device_pause =3D ls2x_dma_pause;
> +  ddev->device_resume =3D ls2x_dma_resume;
> +
> +  ddev->src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +  ddev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +  ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +
> +  ret =3D dma_async_device_register(&priv->ddev);
> +  if (ret < 0)
> +    goto disable_clk;
> +
> +  ret =3D of_dma_controller_register(dev->of_node, of_ls2x_dma_xlate, pr=
iv);
> +  if (ret < 0)
> +    goto unregister_dmac;
> +
> +  platform_set_drvdata(pdev, priv);
> +
> +  dev_info(dev, "Loongson LS2X APB DMA driver registered successfully.\n=
");
> +  return 0;
> +
> +unregister_dmac:
> +  dma_async_device_unregister(&priv->ddev);
> +disable_clk:
> +  clk_disable_unprepare(priv->dma_clk);
> +
> +  return ret;
> +}
> +
> +/*
> + * ls2x_dma_remove - Driver remove function
> + * @pdev: Pointer to the platform_device structure
> + *
> + * Return: Always '0'
> + */
> +static int ls2x_dma_remove(struct platform_device *pdev)
> +{
> +  struct ls2x_dma_priv *priv =3D platform_get_drvdata(pdev);
> +
> +  of_dma_controller_free(pdev->dev.of_node);
> +  dma_async_device_unregister(&priv->ddev);
> +  clk_disable_unprepare(priv->dma_clk);
> +
> +  return 0;
> +}
> +
> +static const struct of_device_id ls2x_dma_of_match_table[] =3D {
> +  { .compatible =3D "loongson,ls2k1000-apbdma" },
> I think it can works with both  2k500 and 2k1000  without any distinction=
=EF=BC=8C use "loongson,ls2k-apbdma" maybe more suitable ?

Hi:

Yes, they really don't differ at the driver level.

But, firstly, I think the compatible attribute should be used to
describe the specific SOC.
Besides,  the Loongson-2K series has more than just the LS2K0500 and
LS2K1000. For example, LS2K2000, and it doesn't apply to this driver.

So, the fallback compatibles might be a better choice for us.

Thanks.
Binbin


>
> +  { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ls2x_dma_of_match_table);
> +
> +static struct platform_driver ls2x_dmac_driver =3D {
> +  .probe    =3D ls2x_dma_probe,
> +  .remove    =3D ls2x_dma_remove,
> +  .driver =3D {
> +    .name  =3D "ls2x-apbdma",
> +    .of_match_table  =3D ls2x_dma_of_match_table,
> +  },
> +};
> +module_platform_driver(ls2x_dmac_driver);
> +
> +MODULE_DESCRIPTION("Loongson LS2X APB DMA Controller driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_LICENSE("GPL");
> --
> 2.39.3
>
>
