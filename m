Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6715776E805
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjHCMOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjHCMOt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 08:14:49 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D31B1;
        Thu,  3 Aug 2023 05:14:48 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d414540af6bso338959276.2;
        Thu, 03 Aug 2023 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691064887; x=1691669687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDuT/ZceFy+RPF7wIt+/G23NgbonYR6O1zrHoPM6fSY=;
        b=qGXJWhPwPSdTbH9Qzn61T9GB8Y5/kLa19K8uswdZ2unuEgxb/yFIIuP9KvfAPq5CBj
         4RkCAM97ZyNVVVDokKx9P7g2wtLPjxvz5zulagHbbVAajiFt9jz1kh6Rsx1/Ke54MPaj
         7+5FSedrEObHMhRu+YW4ArZGyTdTnL+daxqmb/Ge6sGxxCfsFr1hzuCQdWDWmjt5pMVK
         /NoFEnim1A/Gz6vNB8OyAU+6B5N00u2YuR5Zm+trvYFd9J5iLyh5SZaL6uWJKnCIgfHI
         v7UtUiYIhDsTLUlOaN2TaAwTBYuETmciU/o/1Ozb1gzQf3n56YfahTrweS1tu5i4GIj0
         kWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691064887; x=1691669687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDuT/ZceFy+RPF7wIt+/G23NgbonYR6O1zrHoPM6fSY=;
        b=QUctYVgO9KpGISvHc3ogvTUroM3E5DVc1Itordv1bjvK2OMRuetdIvJXsK1OAzR435
         0ZrV+AvEjZRF5TRVUTKFwXit4dEPw1TM4nmkJOmv+nR+qBW58Wf0nO2SCWm0KvV9w/4G
         iMs5/eoxoaj1jvTFfVoxeDvvRF4m9SplNSgzo52woNMzIyPizfbay39MAETB9NVBM4/R
         WCw9p2PlxoeFUb35zLYyukilntYcOVjh6FSJaUDL/o+UsltHdlJzz2/E7urgNq3JrOS3
         qgYivz2sosraUkH/PsLlghgIr7WgH5Q+yIm5feBQtmtZa4VxQXA30tegJQ2HBNKc7YXw
         fYPg==
X-Gm-Message-State: ABy/qLYx8kWjxRz2zlfoB3JSBM6h1qXSusuHrZ4w8VhLIQGDGlJV16Fh
        UUZyERrMcE+E8MEMojlwb3ek6WldQXRlwk+VxelyUB7pP96fDQ==
X-Google-Smtp-Source: APBJJlHOOIR8U6M4S+fm/6sfh3DD7dM87xu9oW+W6WCdhpmlcOhNrX4Mce+xysiWqSGiobiLs2pOuXcakW2zndR1LJA=
X-Received: by 2002:a25:f828:0:b0:d0f:6f1d:8a27 with SMTP id
 u40-20020a25f828000000b00d0f6f1d8a27mr15930324ybd.8.1691064887091; Thu, 03
 Aug 2023 05:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689075791.git.zhoubinbin@loongson.cn> <b282ef7c5d1841886a80b2b6502c735f2f0254c9.1689075791.git.zhoubinbin@loongson.cn>
 <ZMlOxZ1ML+tlRkna@matsya>
In-Reply-To: <ZMlOxZ1ML+tlRkna@matsya>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Thu, 3 Aug 2023 20:14:35 +0800
Message-ID: <CAMpQs4LnZZAtv0Z4LBd-4fg9WkV8jgPxZ8S2a6RA9mTb4Qj8GA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: ls2x-apb: new driver for the Loongson
 LS2X APB DMA controller
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod:

Thanks for your reply.

On Wed, Aug 2, 2023 at 2:28=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 11-07-23, 20:19, Binbin Zhou wrote:
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
> >  drivers/dma/ls2x-apb-dma.c | 684 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 700 insertions(+)
> >  create mode 100644 drivers/dma/ls2x-apb-dma.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 60a411936ba7..709c2e9d5f5f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12248,6 +12248,7 @@ M:    Binbin Zhou <zhoubinbin@loongson.cn>
> >  L:   dmaengine@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > +F:   drivers/dma/ls2x-apb-dma.c
> >
> >  LOONGSON LS2X I2C DRIVER
> >  M:   Binbin Zhou <zhoubinbin@loongson.cn>
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 644c188d6a11..9b41b59ba2b4 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -376,6 +376,20 @@ config LPC18XX_DMAMUX
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
> > index a4fd1ce29510..9b28ddb1ea3b 100644
> > --- a/drivers/dma/Makefile
> > +++ b/drivers/dma/Makefile
> > @@ -46,6 +46,7 @@ obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> >  obj-y +=3D idxd/
> >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > +obj-$(CONFIG_LS2X_APB_DMA) +=3D ls2x-apb-dma.o
> >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> >  obj-$(CONFIG_MILBEAUT_XDMAC) +=3D milbeaut-xdmac.o
> >  obj-$(CONFIG_MMP_PDMA) +=3D mmp_pdma.o
> > diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
> > new file mode 100644
> > index 000000000000..b3efe86e4330
> > --- /dev/null
> > +++ b/drivers/dma/ls2x-apb-dma.c
> > @@ -0,0 +1,684 @@
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
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
>
> drop this header, of.h should suffice

OK, I wil fix it.
>
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
>
> why not use dma_addr_t for this?

apb_addr is the address of the register in the APB device that is used
for DMA access, it is 32-bit.
>
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
> > +static void ls2x_dma_fill_desc(struct ls2x_dma_chan *lchan, u32 i,
> > +                            struct ls2x_dma_desc *desc)
>
> pls align this one to precceding open brace (hint: checkpatch.pl
> --strict would warn you about this)

OK, I'll check again.
>
> > +{
> > +     struct ls2x_dma_sg *ldma_sg =3D &desc->sg[i];
> > +
> > +     ldma_sg->hw->mem_addr =3D lower_32_bits(ldma_sg->phys);
> > +     ldma_sg->hw->high_mem_addr =3D upper_32_bits(ldma_sg->phys);
> > +     /* Word count register takes input in words */
> > +     ldma_sg->hw->len =3D ldma_sg->len >> 2;
> > +     ldma_sg->hw->step_len =3D 0;
> > +     ldma_sg->hw->step_times =3D 1;
> > +
> > +     if (desc->direction =3D=3D DMA_MEM_TO_DEV) {
> > +             ldma_sg->hw->cmd =3D LDMA_INT | LDMA_DATA_DIRECTION;
> > +             ldma_sg->hw->apb_addr =3D lchan->sconfig.dst_addr;
> > +     } else {
> > +             ldma_sg->hw->cmd =3D LDMA_INT;
> > +             ldma_sg->hw->apb_addr =3D lchan->sconfig.src_addr;
>
> only addr are used here, what about data width, why is that ignored?

LS2X DMAC limits data handling to words (4 Bytes).
Therefore, our solution is to assign the data length at the slave side
directly to hw->len (converted to word) and give it to the DMA
controller for one-time processing.
In which, hw->len represents the length of a piece of content being
carried in words. It is 32 bits, and the max can be up to 4G words.
>
> > +     }
> > +
> > +     /* lets make a link list */
> > +     if (i) {
>
> what does i refer to here..?

The 'i' represents the sg item in the scatterlist.
If there is only one item in the scatterlist (i =3D=3D 0), nothing is
done. Otherwise, let's make a linked list.
Perhaps I should have used a more meaningful name, e.g., sg_index.
>
> > +/*
> > + * of_ls2x_dma_xlate - Translation function
> > + * @dma_spec: Pointer to DMA specifier as found in the device tree
> > + * @ofdma: Pointer to DMA controller data
> > + *
> > + * Return: DMA channel pointer on success and NULL on error
> > + */
> > +static struct dma_chan *of_ls2x_dma_xlate(struct of_phandle_args *dma_=
spec,
> > +                                       struct of_dma *ofdma)
> > +{
> > +     struct ls2x_dma_priv *priv =3D ofdma->of_dma_data;
> > +     struct ls2x_dma_chan *lchan;
> > +
> > +     /* We are single channel DMA, just get the channel from priv. */
> > +     lchan =3D &priv->lchan;
> > +     if (!lchan)
> > +             return NULL;
> > +
> > +     return dma_get_slave_channel(&lchan->vchan.chan);
> > +}
>
> why not use generic xlate?

Yes, of_dma_xlate_by_chan_id() is a better choice, I will fix it in
the next version.

Thanks.
Binbin

> --
> ~Vinod
