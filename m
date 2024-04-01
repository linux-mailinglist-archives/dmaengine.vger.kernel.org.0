Return-Path: <dmaengine+bounces-1680-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3D4893938
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51DD1F21AC1
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B43DF62;
	Mon,  1 Apr 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsbXNk8D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34672FBE9;
	Mon,  1 Apr 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962365; cv=none; b=cptjqRCwqnqbMtsC6KZUh1IXpMB07QErZlA6xzUY64QFr8wTIkNIuksQnecRS4gFcd4/yCzkFI700FB+kdCBXZjMyJGX5TPTYtfmndkwCtzaBJnzk06YMcoq/tOBjyRrIMaSMG1kziDFfVT4bU00jI0c165DgVuhSWjLyeEtJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962365; c=relaxed/simple;
	bh=VCA63iIdVp1AxcoPkWWyRJDWiuFyUhDQf04ch6yIbJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcqtElGcIDVy1GhI/IuIDB0HPPRfwUdk2VGP+tbvRI6Z7uzW/EUuVA+cXxn/M5HvOJSSEMuN3I2RBY4rmaiY736Tt4hLbQxQlrHr1uC7nVky9HB9FcQjl1kgBevOcS+uajzsJIjq8tJL9QzMswJak4srk9M+kd9sM6eUCXIi4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsbXNk8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E21C433C7;
	Mon,  1 Apr 2024 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711962364;
	bh=VCA63iIdVp1AxcoPkWWyRJDWiuFyUhDQf04ch6yIbJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fsbXNk8DEjbgYn13dPVDKAZeKGgT248NQgnNHj1NbdPv5orxDdJVSSIRtYuoM58K6
	 eGS5uaDwZTylkl2i6/rpYtN0vR/WY/3hPay7KWap0l3OTJCgKcKDME26N5B/ozgzbk
	 a5tW2FDU5joJezVmREdp4PtDG0AR8mSOA/O25K/p4fFgOq3PzPkADVdJRZQQcUvMSN
	 qHY67abIREvqVDsAwWLGDIPAtNnmkHIv4ZtBcjntNpJEO4Q1qakWIXXLvFKC2+7j2j
	 Sm1esAb8lW9JaXVH0n6SbcsD0axrl/ip9huMgka+GNrTV7HMfRrBzjNNhd18ViB8Mk
	 E8VGyonE+KDxw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so3797715a12.0;
        Mon, 01 Apr 2024 02:06:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJbLDfjadVJ9tQLKZBJo46YTSt8HXsIUhyRhuXfnh0RRFIitQ9crLlUiPZ9/0TvxOJjYijFVhz/fRNpOM4fx9ViWcHGH6BfkLKG5++20e6whnK7EEO3xNhbT4gDlWpd9shb/1sOQ2m7xBn1ag/kXDmW3xwoq5olDgGt9ZTh/P6DeO3AvWvME0NB5OdAc3GRIuSIZUM3SPV1SqyCmNPkD8=
X-Gm-Message-State: AOJu0YxCAv07T33CjD5O0UmBog3+/61LkU5DI6/2d1Kf+ENY5sqsqWHi
	OB2gxU01OemCbmYGHVrWqwb5EGuTcb7nm41j3UVtXt4h+21SOJ1Pw8szSHT+31cYIo3kAU5Hb/W
	n4fJEJnPem+gzA3k+Kelu/c6Lp/M=
X-Google-Smtp-Source: AGHT+IE61Iwn9PSC/zZXlsqPYFN/ndtDdpSb0XBe0uctw55K1KVUCOt9ODPhm6k4NBcc5nXYMpTaSW3bcbviL3gE9vE=
X-Received: by 2002:a17:906:144f:b0:a4e:26fc:542c with SMTP id
 q15-20020a170906144f00b00a4e26fc542cmr6708569ejc.43.1711962363028; Mon, 01
 Apr 2024 02:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
 <20240329-loongson1-dma-v7-2-37db58608de5@gmail.com> <CAAhV-H6gG5KGxku+aZPwfmqAVF9zfL-9-nNqCd2Z_swxgCe_HA@mail.gmail.com>
 <CAJhJPsXutxdZkhjWdc-JuJOaC_6+6zsDjbYT1Bg6Yuk8AQX1ug@mail.gmail.com>
In-Reply-To: <CAJhJPsXutxdZkhjWdc-JuJOaC_6+6zsDjbYT1Bg6Yuk8AQX1ug@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 1 Apr 2024 17:05:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H63wMMhVng=kn+XOHFL8sTchtGAMae0v50FEN6TO1kAhw@mail.gmail.com>
Message-ID: <CAAhV-H63wMMhVng=kn+XOHFL8sTchtGAMae0v50FEN6TO1kAhw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:45=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail.=
com> wrote:
>
> Hi Huacai,
>
> On Sat, Mar 30, 2024 at 9:59=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Keguang,
> >
> > On Fri, Mar 29, 2024 at 7:28=E2=80=AFPM Keguang Zhang via B4 Relay
> > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
> > >
> > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > >
> > > This patch adds APB DMA driver for Loongson-1 SoCs.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > > Changes in v7:
> > > - Change the comptible to 'loongson,ls1*-apbdma'
> > > - Update Kconfig and Makefile accordingly
> > > - Rename the file to loongson1-apb-dma.c to keep the consistency
> > >
> > > Changes in v6:
> > > - Implement .device_prep_dma_cyclic for Loongson1 audio driver,
> > > - as well as .device_pause and .device_resume.
> > > - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> > > - into one page to save memory
> > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> > > - Drop dma_slave_config structure
> > > - Use .remove_new instead of .remove
> > > - Use KBUILD_MODNAME for the driver name
> > > - Improve the debug information
> > >
> > > Changes in v5:
> > > - Add DT support
> > > - Use DT data instead of platform data
> > > - Use chan_id of struct dma_chan instead of own id
> > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> > > - Update the author information to my official name
> > >
> > > Changes in v4:
> > > - Use dma_slave_map to find the proper channel.
> > > - Explicitly call devm_request_irq() and tasklet_kill().
> > > - Fix namespace issue.
> > > - Some minor fixes and cleanups.
> > >
> > > Changes in v3:
> > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> > >
> > > Changes in v2:
> > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> > > - and rearrange it in alphabetical order in Kconfig and Makefile.
> > > - Fix comment style.
> > > ---
> > >  drivers/dma/Kconfig             |   9 +
> > >  drivers/dma/Makefile            |   1 +
> > >  drivers/dma/loongson1-apb-dma.c | 665 ++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 675 insertions(+)
> > >
> > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > index 002a5ec80620..f7b06c4cdf3f 100644
> > > --- a/drivers/dma/Kconfig
> > > +++ b/drivers/dma/Kconfig
> > > @@ -369,6 +369,15 @@ config K3_DMA
> > >           Support the DMA engine for Hisilicon K3 platform
> > >           devices.
> > >
> > > +config LOONGSON1_APB_DMA
> > > +       tristate "Loongson1 APB DMA support"
> > > +       depends on MACH_LOONGSON32 || COMPILE_TEST
> > > +       select DMA_ENGINE
> > > +       select DMA_VIRTUAL_CHANNELS
> > > +       help
> > > +         This selects support for the APB DMA controller in Loongson=
1 SoCs,
> > > +         which is required by Loongson1 NAND and audio support.
> > Why not rename to LS1X_APB_DMA and put it just before LS2X_APB_DMA
> > (and also the driver file name)?
> >
> So far all Kconfig entries of Loongson-1 drivers are named with the
> keyword "LOONGSON1".
> The same is true for these file names.
> Therefore, I need to keep the consistency.
But I see LS1X_IRQ in drivers/irqchip/Kconfig

Huacai

>
>
> > Huacai
> >
> > > +
> > >  config LPC18XX_DMAMUX
> > >         bool "NXP LPC18xx/43xx DMA MUX for PL080"
> > >         depends on ARCH_LPC18XX || COMPILE_TEST
> > > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > > index dfd40d14e408..b26f6677978a 100644
> > > --- a/drivers/dma/Makefile
> > > +++ b/drivers/dma/Makefile
> > > @@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma64.o
> > >  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> > >  obj-y +=3D idxd/
> > >  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> > > +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> > >  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
> > >  obj-$(CONFIG_LS2X_APB_DMA) +=3D ls2x-apb-dma.o
> > >  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> > > diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-=
apb-dma.c
> > > new file mode 100644
> > > index 000000000000..d474a2601e6e
> > > --- /dev/null
> > > +++ b/drivers/dma/loongson1-apb-dma.c
> > > @@ -0,0 +1,665 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Driver for Loongson-1 APB DMA Controller
> > > + *
> > > + * Copyright (C) 2015-2024 Keguang Zhang <keguang.zhang@gmail.com>
> > > + */
> > > +
> > > +#include <linux/dmapool.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/init.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_dma.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include "dmaengine.h"
> > > +#include "virt-dma.h"
> > > +
> > > +/* Loongson-1 DMA Control Register */
> > > +#define DMA_CTRL                       0x0
> > > +
> > > +/* DMA Control Register Bits */
> > > +#define DMA_STOP                       BIT(4)
> > > +#define DMA_START                      BIT(3)
> > > +#define DMA_ASK_VALID                  BIT(2)
> > > +
> > > +#define DMA_ADDR_MASK                  GENMASK(31, 6)
> > > +
> > > +/* DMA Next Field Bits */
> > > +#define DMA_NEXT_VALID                 BIT(0)
> > > +
> > > +/* DMA Command Field Bits */
> > > +#define DMA_RAM2DEV                    BIT(12)
> > > +#define DMA_INT                                BIT(1)
> > > +#define DMA_INT_MASK                   BIT(0)
> > > +
> > > +#define LS1X_DMA_MAX_CHANNELS          3
> > > +
> > > +/* Size of allocations for hardware descriptors */
> > > +#define LS1X_DMA_DESCS_SIZE            PAGE_SIZE
> > > +#define LS1X_DMA_MAX_DESC              \
> > > +       (LS1X_DMA_DESCS_SIZE / sizeof(struct ls1x_dma_hwdesc))
> > > +
> > > +struct ls1x_dma_hwdesc {
> > > +       u32 next;               /* next descriptor address */
> > > +       u32 saddr;              /* memory DMA address */
> > > +       u32 daddr;              /* device DMA address */
> > > +       u32 length;
> > > +       u32 stride;
> > > +       u32 cycles;
> > > +       u32 cmd;
> > > +       u32 stats;
> > > +};
> > > +
> > > +struct ls1x_dma_desc {
> > > +       struct virt_dma_desc vdesc;
> > > +       enum dma_transfer_direction dir;
> > > +       enum dma_transaction_type type;
> > > +       unsigned int bus_width;
> > > +
> > > +       unsigned int nr_descs;  /* number of descriptors */
> > > +
> > > +       struct ls1x_dma_hwdesc *hwdesc;
> > > +       dma_addr_t hwdesc_phys;
> > > +};
> > > +
> > > +struct ls1x_dma_chan {
> > > +       struct virt_dma_chan vchan;
> > > +       struct dma_pool *desc_pool;
> > > +       phys_addr_t src_addr;
> > > +       phys_addr_t dst_addr;
> > > +       enum dma_slave_buswidth src_addr_width;
> > > +       enum dma_slave_buswidth dst_addr_width;
> > > +
> > > +       void __iomem *reg_base;
> > > +       int irq;
> > > +
> > > +       struct ls1x_dma_desc *desc;
> > > +
> > > +       struct ls1x_dma_hwdesc *curr_hwdesc;
> > > +       dma_addr_t curr_hwdesc_phys;
> > > +};
> > > +
> > > +struct ls1x_dma {
> > > +       struct dma_device ddev;
> > > +       void __iomem *reg_base;
> > > +
> > > +       unsigned int nr_chans;
> > > +       struct ls1x_dma_chan chan[];
> > > +};
> > > +
> > > +#define to_ls1x_dma_chan(dchan)                \
> > > +       container_of(dchan, struct ls1x_dma_chan, vchan.chan)
> > > +
> > > +#define to_ls1x_dma_desc(vd)           \
> > > +       container_of(vd, struct ls1x_dma_desc, vdesc)
> > > +
> > > +/* macros for registers read/write */
> > > +#define chan_readl(chan, off)          \
> > > +       readl((chan)->reg_base + (off))
> > > +
> > > +#define chan_writel(chan, off, val)    \
> > > +       writel((val), (chan)->reg_base + (off))
> > > +
> > > +static inline struct device *chan2dev(struct dma_chan *chan)
> > > +{
> > > +       return &chan->dev->device;
> > > +}
> > > +
> > > +static inline int ls1x_dma_query(struct ls1x_dma_chan *chan,
> > > +                                dma_addr_t *hwdesc_phys)
> > > +{
> > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > +       int val, ret;
> > > +
> > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > +       val |=3D DMA_ASK_VALID;
> > > +       val |=3D dchan->chan_id;
> > > +       chan_writel(chan, DMA_CTRL, val);
> > > +       ret =3D readl_poll_timeout_atomic(chan->reg_base + DMA_CTRL, =
val,
> > > +                                       !(val & DMA_ASK_VALID), 0, 30=
00);
> > > +       if (ret)
> > > +               dev_err(chan2dev(dchan), "failed to query DMA\n");
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static inline int ls1x_dma_start(struct ls1x_dma_chan *chan,
> > > +                                dma_addr_t *hwdesc_phys)
> > > +{
> > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > +       int val, ret;
> > > +
> > > +       dev_dbg(chan2dev(dchan), "cookie=3D%d, starting hwdesc=3D%x\n=
",
> > > +               dchan->cookie, *hwdesc_phys);
> > > +
> > > +       val =3D *hwdesc_phys & DMA_ADDR_MASK;
> > > +       val |=3D DMA_START;
> > > +       val |=3D dchan->chan_id;
> > > +       chan_writel(chan, DMA_CTRL, val);
> > > +       ret =3D readl_poll_timeout(chan->reg_base + DMA_CTRL, val,
> > > +                                !(val & DMA_START), 0, 3000);
> > > +       if (ret)
> > > +               dev_err(chan2dev(dchan), "failed to start DMA\n");
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static inline void ls1x_dma_stop(struct ls1x_dma_chan *chan)
> > > +{
> > > +       chan_writel(chan, DMA_CTRL, chan_readl(chan, DMA_CTRL) | DMA_=
STOP);
> > > +}
> > > +
> > > +static void ls1x_dma_free_chan_resources(struct dma_chan *dchan)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +
> > > +       dma_free_coherent(chan2dev(dchan), sizeof(struct ls1x_dma_hwd=
esc),
> > > +                         chan->curr_hwdesc, chan->curr_hwdesc_phys);
> > > +       vchan_free_chan_resources(&chan->vchan);
> > > +       dma_pool_destroy(chan->desc_pool);
> > > +       chan->desc_pool =3D NULL;
> > > +}
> > > +
> > > +static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +
> > > +       chan->desc_pool =3D dma_pool_create(dma_chan_name(dchan),
> > > +                                         chan2dev(dchan),
> > > +                                         sizeof(struct ls1x_dma_hwde=
sc),
> > > +                                         __alignof__(struct ls1x_dma=
_hwdesc),
> > > +                                         0);
> > > +       if (!chan->desc_pool)
> > > +               return -ENOMEM;
> > > +
> > > +       /* allocate memory for querying current HW descriptor */
> > > +       dma_set_coherent_mask(chan2dev(dchan), DMA_BIT_MASK(32));
> > > +       chan->curr_hwdesc =3D dma_alloc_coherent(chan2dev(dchan),
> > > +                                              sizeof(struct ls1x_dma=
_hwdesc),
> > > +                                              &chan->curr_hwdesc_phy=
s,
> > > +                                              GFP_KERNEL);
> > > +       if (!chan->curr_hwdesc)
> > > +               return -ENOMEM;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
> > > +{
> > > +       struct ls1x_dma_desc *desc =3D to_ls1x_dma_desc(vdesc);
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(vdesc->tx.cha=
n);
> > > +
> > > +       dma_pool_free(chan->desc_pool, desc->hwdesc, desc->hwdesc_phy=
s);
> > > +       chan->desc =3D NULL;
> > > +       kfree(desc);
> > > +}
> > > +
> > > +static struct ls1x_dma_desc *
> > > +ls1x_dma_alloc_desc(struct dma_chan *dchan, int sg_len,
> > > +                   enum dma_transfer_direction direction,
> > > +                   enum dma_transaction_type type)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       struct ls1x_dma_desc *desc;
> > > +
> > > +       if (sg_len > LS1X_DMA_MAX_DESC) {
> > > +               dev_err(chan2dev(dchan), "sg_len %u exceeds limit %lu=
",
> > > +                       sg_len, LS1X_DMA_MAX_DESC);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       desc =3D kzalloc(sizeof(*desc), GFP_NOWAIT);
> > > +       if (!desc)
> > > +               return NULL;
> > > +
> > > +       /* allocate HW descriptors */
> > > +       desc->hwdesc =3D dma_pool_zalloc(chan->desc_pool, GFP_NOWAIT,
> > > +                                      &desc->hwdesc_phys);
> > > +       if (!desc->hwdesc) {
> > > +               dev_err(chan2dev(dchan), "failed to alloc HW descript=
ors\n");
> > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       desc->dir =3D direction;
> > > +       desc->type =3D type;
> > > +       desc->nr_descs =3D sg_len;
> > > +
> > > +       return desc;
> > > +}
> > > +
> > > +static int ls1x_dma_setup_hwdescs(struct dma_chan *dchan,
> > > +                                 struct ls1x_dma_desc *desc,
> > > +                                 struct scatterlist *sgl, unsigned i=
nt sg_len)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       dma_addr_t next_hwdesc_phys =3D desc->hwdesc_phys;
> > > +
> > > +       struct scatterlist *sg;
> > > +       unsigned int dev_addr, cmd, i;
> > > +
> > > +       switch (desc->dir) {
> > > +       case DMA_MEM_TO_DEV:
> > > +               dev_addr =3D chan->dst_addr;
> > > +               desc->bus_width =3D chan->dst_addr_width;
> > > +               cmd =3D DMA_RAM2DEV | DMA_INT;
> > > +               break;
> > > +       case DMA_DEV_TO_MEM:
> > > +               dev_addr =3D chan->src_addr;
> > > +               desc->bus_width =3D chan->src_addr_width;
> > > +               cmd =3D DMA_INT;
> > > +               break;
> > > +       default:
> > > +               dev_err(chan2dev(dchan), "unsupported DMA direction: =
%s\n",
> > > +                       dmaengine_get_direction_text(desc->dir));
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       /* setup HW descriptors */
> > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > +               dma_addr_t buf_addr =3D sg_dma_address(sg);
> > > +               size_t buf_len =3D sg_dma_len(sg);
> > > +               struct ls1x_dma_hwdesc *hwdesc =3D &desc->hwdesc[i];
> > > +
> > > +               if (!is_dma_copy_aligned(dchan->device, buf_addr, 0, =
buf_len)) {
> > > +                       dev_err(chan2dev(dchan), "buffer is not align=
ed!\n");
> > > +                       return -EINVAL;
> > > +               }
> > > +
> > > +               hwdesc->saddr =3D buf_addr;
> > > +               hwdesc->daddr =3D dev_addr;
> > > +               hwdesc->length =3D buf_len / desc->bus_width;
> > > +               hwdesc->stride =3D 0;
> > > +               hwdesc->cycles =3D 1;
> > > +               hwdesc->cmd =3D cmd;
> > > +
> > > +               if (i) {
> > > +                       next_hwdesc_phys +=3D sizeof(*hwdesc);
> > > +                       desc->hwdesc[i - 1].next =3D next_hwdesc_phys
> > > +                           | DMA_NEXT_VALID;
> > > +               }
> > > +       }
> > > +
> > > +       if (desc->type =3D=3D DMA_CYCLIC)
> > > +               desc->hwdesc[i - 1].next =3D desc->hwdesc_phys | DMA_=
NEXT_VALID;
> > > +
> > > +       for_each_sg(sgl, sg, sg_len, i) {
> > > +               struct ls1x_dma_hwdesc *hwdesc =3D &desc->hwdesc[i];
> > > +
> > > +               print_hex_dump_debug("HW DESC: ", DUMP_PREFIX_OFFSET,=
 16, 4,
> > > +                                    hwdesc, sizeof(*hwdesc), false);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static struct dma_async_tx_descriptor *
> > > +ls1x_dma_prep_slave_sg(struct dma_chan *dchan,
> > > +                      struct scatterlist *sgl, unsigned int sg_len,
> > > +                      enum dma_transfer_direction direction,
> > > +                      unsigned long flags, void *context)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       struct ls1x_dma_desc *desc;
> > > +
> > > +       dev_dbg(chan2dev(dchan), "sg_len=3D%u flags=3D0x%lx dir=3D%s\=
n",
> > > +               sg_len, flags, dmaengine_get_direction_text(direction=
));
> > > +
> > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, direction, DMA_SL=
AVE);
> > > +       if (!desc)
> > > +               return NULL;
> > > +
> > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg_len)) {
> > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> > > +}
> > > +
> > > +static struct dma_async_tx_descriptor *
> > > +ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan,
> > > +                        dma_addr_t buf_addr, size_t buf_len, size_t =
period_len,
> > > +                        enum dma_transfer_direction direction,
> > > +                        unsigned long flags)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       struct ls1x_dma_desc *desc;
> > > +       struct scatterlist *sgl;
> > > +       unsigned int sg_len;
> > > +       unsigned int i;
> > > +
> > > +       dev_dbg(chan2dev(dchan),
> > > +               "buf_len=3D%d period_len=3D%zu flags=3D0x%lx dir=3D%s=
\n", buf_len,
> > > +               period_len, flags, dmaengine_get_direction_text(direc=
tion));
> > > +
> > > +       sg_len =3D buf_len / period_len;
> > > +       desc =3D ls1x_dma_alloc_desc(dchan, sg_len, direction, DMA_CY=
CLIC);
> > > +       if (!desc)
> > > +               return NULL;
> > > +
> > > +       /* allocate the scatterlist */
> > > +       sgl =3D kmalloc_array(sg_len, sizeof(*sgl), GFP_NOWAIT);
> > > +       if (!sgl)
> > > +               return NULL;
> > > +
> > > +       sg_init_table(sgl, sg_len);
> > > +       for (i =3D 0; i < sg_len; ++i) {
> > > +               sg_set_page(&sgl[i], pfn_to_page(PFN_DOWN(buf_addr)),
> > > +                           period_len, offset_in_page(buf_addr));
> > > +               sg_dma_address(&sgl[i]) =3D buf_addr;
> > > +               sg_dma_len(&sgl[i]) =3D period_len;
> > > +               buf_addr +=3D period_len;
> > > +       }
> > > +
> > > +       if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg_len)) {
> > > +               ls1x_dma_free_desc(&desc->vdesc);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       kfree(sgl);
> > > +
> > > +       return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> > > +}
> > > +
> > > +static int ls1x_dma_slave_config(struct dma_chan *dchan,
> > > +                                struct dma_slave_config *config)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +
> > > +       chan->src_addr =3D config->src_addr;
> > > +       chan->src_addr_width =3D config->src_addr_width;
> > > +       chan->dst_addr =3D config->dst_addr;
> > > +       chan->dst_addr_width =3D config->dst_addr_width;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int ls1x_dma_pause(struct dma_chan *dchan)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       unsigned long flags;
> > > +       int ret;
> > > +
> > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +       ret =3D ls1x_dma_query(chan, &chan->curr_hwdesc_phys);
> > > +       if (!ret)
> > > +               ls1x_dma_stop(chan);
> > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int ls1x_dma_resume(struct dma_chan *dchan)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       unsigned long flags;
> > > +       int ret;
> > > +
> > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +       ret =3D ls1x_dma_start(chan, &chan->curr_hwdesc_phys);
> > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int ls1x_dma_terminate_all(struct dma_chan *dchan)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       unsigned long flags;
> > > +       LIST_HEAD(head);
> > > +
> > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +       ls1x_dma_stop(chan);
> > > +       vchan_get_all_descriptors(&chan->vchan, &head);
> > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +
> > > +       vchan_dma_desc_free_list(&chan->vchan, &head);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static enum dma_status ls1x_dma_tx_status(struct dma_chan *dchan,
> > > +                                         dma_cookie_t cookie,
> > > +                                         struct dma_tx_state *state)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       struct virt_dma_desc *vdesc;
> > > +       enum dma_status status;
> > > +       size_t bytes =3D 0;
> > > +       unsigned long flags;
> > > +
> > > +       status =3D dma_cookie_status(dchan, cookie, state);
> > > +       if (status =3D=3D DMA_COMPLETE)
> > > +               return status;
> > > +
> > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +       vdesc =3D vchan_find_desc(&chan->vchan, cookie);
> > > +       if (chan->desc && cookie =3D=3D chan->desc->vdesc.tx.cookie) =
{
> > > +               struct ls1x_dma_desc *desc =3D chan->desc;
> > > +               int i;
> > > +
> > > +               if (ls1x_dma_query(chan, &chan->curr_hwdesc_phys))
> > > +                       return status;
> > > +
> > > +               /* locate the current HW descriptor */
> > > +               for (i =3D 0; i < desc->nr_descs; i++)
> > > +                       if (desc->hwdesc[i].next =3D=3D chan->curr_hw=
desc->next)
> > > +                               break;
> > > +
> > > +               /* count the residues */
> > > +               for (; i < desc->nr_descs; i++)
> > > +                       bytes +=3D desc->hwdesc[i].length * desc->bus=
_width;
> > > +
> > > +               dma_set_residue(state, bytes);
> > > +       }
> > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +
> > > +       return status;
> > > +}
> > > +
> > > +static void ls1x_dma_issue_pending(struct dma_chan *dchan)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > > +       struct virt_dma_desc *vdesc;
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +       if (vchan_issue_pending(&chan->vchan) && !chan->desc) {
> > > +               vdesc =3D vchan_next_desc(&chan->vchan);
> > > +               if (!vdesc) {
> > > +                       chan->desc =3D NULL;
> > > +                       return;
> > > +               }
> > > +               chan->desc =3D to_ls1x_dma_desc(vdesc);
> > > +               ls1x_dma_start(chan, &chan->desc->hwdesc_phys);
> > > +       }
> > > +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +}
> > > +
> > > +static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
> > > +{
> > > +       struct ls1x_dma_chan *chan =3D data;
> > > +       struct ls1x_dma_desc *desc =3D chan->desc;
> > > +       struct dma_chan *dchan =3D &chan->vchan.chan;
> > > +
> > > +       if (!desc) {
> > > +               dev_warn(chan2dev(dchan),
> > > +                        "IRQ %d with no active descriptor on channel=
 %d\n",
> > > +                        irq, dchan->chan_id);
> > > +               return IRQ_NONE;
> > > +       }
> > > +
> > > +       dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\n", irq,
> > > +               dchan->chan_id);
> > > +
> > > +       spin_lock(&chan->vchan.lock);
> > > +
> > > +       if (desc->type =3D=3D DMA_CYCLIC) {
> > > +               vchan_cyclic_callback(&desc->vdesc);
> > > +       } else {
> > > +               list_del(&desc->vdesc.node);
> > > +               vchan_cookie_complete(&desc->vdesc);
> > > +               chan->desc =3D NULL;
> > > +       }
> > > +
> > > +       spin_unlock(&chan->vchan.lock);
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int ls1x_dma_chan_probe(struct platform_device *pdev,
> > > +                              struct ls1x_dma *dma, int chan_id)
> > > +{
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct ls1x_dma_chan *chan =3D &dma->chan[chan_id];
> > > +       char pdev_irqname[4];
> > > +       char *irqname;
> > > +       int ret;
> > > +
> > > +       sprintf(pdev_irqname, "ch%u", chan_id);
> > > +       chan->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> > > +       if (chan->irq < 0)
> > > +               return -ENODEV;
> > > +
> > > +       irqname =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
> > > +                                dev_name(dev), pdev_irqname);
> > > +       if (!irqname)
> > > +               return -ENOMEM;
> > > +
> > > +       ret =3D devm_request_irq(dev, chan->irq, ls1x_dma_irq_handler=
,
> > > +                              IRQF_SHARED, irqname, chan);
> > > +       if (ret)
> > > +               return dev_err_probe(dev, ret,
> > > +                                    "failed to request IRQ %u!\n", c=
han->irq);
> > > +
> > > +       chan->reg_base =3D dma->reg_base;
> > > +       chan->vchan.desc_free =3D ls1x_dma_free_desc;
> > > +       vchan_init(&chan->vchan, &dma->ddev);
> > > +       dev_info(dev, "%s (irq %d) initialized\n", pdev_irqname, chan=
->irq);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void ls1x_dma_chan_remove(struct ls1x_dma *dma, int chan_id)
> > > +{
> > > +       struct device *dev =3D dma->ddev.dev;
> > > +       struct ls1x_dma_chan *chan =3D &dma->chan[chan_id];
> > > +
> > > +       devm_free_irq(dev, chan->irq, chan);
> > > +       list_del(&chan->vchan.chan.device_node);
> > > +       tasklet_kill(&chan->vchan.task);
> > > +}
> > > +
> > > +static int ls1x_dma_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct dma_device *ddev;
> > > +       struct ls1x_dma *dma;
> > > +       int nr_chans, ret, i;
> > > +
> > > +       nr_chans =3D platform_irq_count(pdev);
> > > +       if (nr_chans <=3D 0)
> > > +               return nr_chans;
> > > +       if (nr_chans > LS1X_DMA_MAX_CHANNELS)
> > > +               return dev_err_probe(dev, -EINVAL,
> > > +                                    "nr_chans=3D%d exceeds the maxim=
um\n",
> > > +                                    nr_chans);
> > > +
> > > +       dma =3D devm_kzalloc(dev, struct_size(dma, chan, nr_chans), G=
FP_KERNEL);
> > > +       if (!dma)
> > > +               return -ENOMEM;
> > > +
> > > +       /* initialize DMA device */
> > > +       dma->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> > > +       if (IS_ERR(dma->reg_base))
> > > +               return PTR_ERR(dma->reg_base);
> > > +
> > > +       ddev =3D &dma->ddev;
> > > +       ddev->dev =3D dev;
> > > +       ddev->copy_align =3D DMAENGINE_ALIGN_4_BYTES;
> > > +       ddev->src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_=
4_BYTES);
> > > +       ddev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > +           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_=
4_BYTES);
> > > +       ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV=
);
> > > +       ddev->max_sg_burst =3D LS1X_DMA_MAX_DESC;
> > > +       ddev->residue_granularity =3D DMA_RESIDUE_GRANULARITY_SEGMENT=
;
> > > +       ddev->device_alloc_chan_resources =3D ls1x_dma_alloc_chan_res=
ources;
> > > +       ddev->device_free_chan_resources =3D ls1x_dma_free_chan_resou=
rces;
> > > +       ddev->device_prep_slave_sg =3D ls1x_dma_prep_slave_sg;
> > > +       ddev->device_prep_dma_cyclic =3D ls1x_dma_prep_dma_cyclic;
> > > +       ddev->device_config =3D ls1x_dma_slave_config;
> > > +       ddev->device_pause =3D ls1x_dma_pause;
> > > +       ddev->device_resume =3D ls1x_dma_resume;
> > > +       ddev->device_terminate_all =3D ls1x_dma_terminate_all;
> > > +       ddev->device_tx_status =3D ls1x_dma_tx_status;
> > > +       ddev->device_issue_pending =3D ls1x_dma_issue_pending;
> > > +
> > > +       dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > > +       INIT_LIST_HEAD(&ddev->channels);
> > > +
> > > +       /* initialize DMA channels */
> > > +       for (i =3D 0; i < nr_chans; i++) {
> > > +               ret =3D ls1x_dma_chan_probe(pdev, dma, i);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +       dma->nr_chans =3D nr_chans;
> > > +
> > > +       ret =3D dmaenginem_async_device_register(ddev);
> > > +       if (ret) {
> > > +               dev_err(dev, "failed to register DMA device! %d\n", r=
et);
> > > +               return ret;
> > > +       }
> > > +
> > > +       ret =3D
> > > +           of_dma_controller_register(dev->of_node, of_dma_xlate_by_=
chan_id,
> > > +                                      ddev);
> > > +       if (ret) {
> > > +               dev_err(dev, "failed to register DMA controller! %d\n=
", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       platform_set_drvdata(pdev, dma);
> > > +       dev_info(dev, "Loongson1 DMA driver registered\n");
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void ls1x_dma_remove(struct platform_device *pdev)
> > > +{
> > > +       struct ls1x_dma *dma =3D platform_get_drvdata(pdev);
> > > +       int i;
> > > +
> > > +       of_dma_controller_free(pdev->dev.of_node);
> > > +
> > > +       for (i =3D 0; i < dma->nr_chans; i++)
> > > +               ls1x_dma_chan_remove(dma, i);
> > > +}
> > > +
> > > +static const struct of_device_id ls1x_dma_match[] =3D {
> > > +       { .compatible =3D "loongson,ls1b-apbdma" },
> > > +       { .compatible =3D "loongson,ls1c-apbdma" },
> > > +       { /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ls1x_dma_match);
> > > +
> > > +static struct platform_driver ls1x_dma_driver =3D {
> > > +       .probe =3D ls1x_dma_probe,
> > > +       .remove_new =3D ls1x_dma_remove,
> > > +       .driver =3D {
> > > +               .name =3D KBUILD_MODNAME,
> > > +               .of_match_table =3D ls1x_dma_match,
> > > +       },
> > > +};
> > > +
> > > +module_platform_driver(ls1x_dma_driver);
> > > +
> > > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> > > +MODULE_DESCRIPTION("Loongson-1 APB DMA Controller driver");
> > > +MODULE_LICENSE("GPL");
> > >
> > > --
> > > 2.40.1
> > >
> > >
>
>
>
> --
> Best regards,
>
> Keguang Zhang
>

