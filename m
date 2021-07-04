Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D63BAD7E
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jul 2021 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGDOsT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jul 2021 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGDOsS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jul 2021 10:48:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15295C061574;
        Sun,  4 Jul 2021 07:45:42 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h6so20876619ljl.8;
        Sun, 04 Jul 2021 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/tn9GXsWXZzt6kLfMw0SMtKg8iPYOSHc9JqYwK69jOc=;
        b=rjZZAjNNmQUThWs4UGgxaOl0evHxqeFRVzr7mX/KdmA4xOJeXX77T/h7dVcRzGgWww
         8wXS0HlXkm+y2iokl8egwavzxIwYHxHzQk1AO7b73l4I07fjxAp/ULPA4Qy35NQbG5DA
         huXF0ndr+K0/4j7N4Jdm5/91i1ptVTXMXeq49R+f6pR8sfZrZ47q+eHEZ2oC4BhI5ZdJ
         UA+mo0+ldNb5oDxJm2pZuf+5dr6/DFMeOWFa94FY7z3IZpFXVLvZ80LsQF7k8XPi43B0
         xAgpa7ucxqAGaN30aPoYcdZ9+jxt4LxyuaE0mfLjrBuduqe/sgVQ0/pEGB28EDWlBI7E
         gbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/tn9GXsWXZzt6kLfMw0SMtKg8iPYOSHc9JqYwK69jOc=;
        b=QGvvpd02/qStuFB04VU3fhZjtKhIvBIh1I4Jd+66JMJcF9X0JAlb4ssAFsY+S8EHdj
         PSt/o4ypvGc/J0xC0hrDdyw/dGY6BqexFsVv43lwAH30yaRJTZGPTuwJ/Sqk+3k/aYYm
         jnHgwzhIqWdAPUIlJRy1c99ZaH3Y8f0KJftYG2VVCg1mJZgbMx+qNgsx/CPs1JGbkkHq
         bn5vP/ugIAggfmpDqdO5QZwxw+gaOUv6Oz0MYRzz3f1qgCvpynxGSQ3omeRfFItK9jel
         u6bzaCkqkMPsYKHUO4dxUglsofPJ5IXdNqVbNIzRHSQDbqbIlw/4bB5XB3MNCrRXmivo
         929Q==
X-Gm-Message-State: AOAM532e2FbV1Y1PfCooIuKHoRBrTpuq9Lbbii75OhIjddR3ScN8KRCp
        Ffnw2S7Rer+hS2Ha54I7rE+LIJcds56xGEPqSu8=
X-Google-Smtp-Source: ABdhPJyVHCYURMQGTzNjPBI5aI8Cb+OjONLnvZ2DadK37N2BRs6rHj/CogSBbPNHgV362lSYsTzsOcquckJSyaCsLAQ=
X-Received: by 2002:a05:651c:1689:: with SMTP id bd9mr7440099ljb.409.1625409940359;
 Sun, 04 Jul 2021 07:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210520230225.11911-1-keguang.zhang@gmail.com> <YL392y4a6iRf1UyQ@vkoul-mobl>
In-Reply-To: <YL392y4a6iRf1UyQ@vkoul-mobl>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Sun, 4 Jul 2021 22:45:28 +0800
Message-ID: <CAJhJPsXv42e23tyQjA52_my1Au6nP_VdLX3c_yzk5MxadQ95iw@mail.gmail.com>
Subject: Re: [PATCH V4 RESEND] dmaengine: Loongson1: Add Loongson1 dmaengine driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod Koul <vkoul@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On 21-05-21, 07:02, Keguang Zhang wrote:
>
> > +config LOONGSON1_DMA
> > +     tristate "Loongson1 DMA support"
> > +     depends on MACH_LOONGSON32
>
> Why does it have to do that? The dma driver is generic..

This driver is only available for LOONGSON32 CPUs.
>
> > +static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
> > +{
> > +     struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > +
> > +     chan->desc_pool =3D dma_pool_create(dma_chan_name(dchan),
> > +                                       dchan->device->dev,
> > +                                       sizeof(struct ls1x_dma_lli),
> > +                                       __alignof__(struct ls1x_dma_lli=
), 0);
> > +     if (!chan->desc_pool) {
> > +             dev_err(chan2dev(dchan),
> > +                     "failed to alloc DMA descriptor pool!\n");
>
> This can be dropped, allocators will warn you for the allocation
> failures

will do.
>
> > +             return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
> > +{
> > +     struct ls1x_dma_desc *desc =3D to_ls1x_dma_desc(vdesc);
> > +
> > +     if (desc->nr_descs) {
> > +             unsigned int i =3D desc->nr_descs;
> > +             struct ls1x_dma_hwdesc *hwdesc;
> > +
> > +             do {
> > +                     hwdesc =3D &desc->hwdesc[--i];
> > +                     dma_pool_free(desc->chan->desc_pool, hwdesc->lli,
> > +                                   hwdesc->phys);
> > +             } while (i);
> > +     }
> > +
> > +     kfree(desc);
> > +}
> > +
> > +static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan =
*chan,
> > +                                              int sg_len)
>
> single line now :)

will do.
>
> > +{
> > +     struct ls1x_dma_desc *desc;
> > +     struct dma_chan *dchan =3D &chan->vchan.chan;
> > +
> > +     desc =3D kzalloc(struct_size(desc, hwdesc, sg_len), GFP_NOWAIT);
> > +     if (!desc)
> > +             dev_err(chan2dev(dchan), "failed to alloc DMA descriptor!=
\n");
>
> this can be dropped too..

will do.
>
> > +static struct dma_async_tx_descriptor *
> > +ls1x_dma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl=
,
> > +                    unsigned int sg_len,
> > +                    enum dma_transfer_direction direction,
> > +                    unsigned long flags, void *context)
> > +{
> > +     struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > +     struct dma_slave_config *cfg =3D &chan->cfg;
> > +     struct ls1x_dma_desc *desc;
> > +     struct scatterlist *sg;
> > +     unsigned int dev_addr, bus_width, cmd, i;
> > +
> > +     if (!is_slave_direction(direction)) {
> > +             dev_err(chan2dev(dchan), "invalid DMA direction!\n");
> > +             return NULL;
> > +     }
> > +
> > +     dev_dbg(chan2dev(dchan), "sg_len=3D%d, dir=3D%s, flags=3D0x%lx\n"=
, sg_len,
> > +             direction =3D=3D DMA_MEM_TO_DEV ? "to device" : "from dev=
ice",
> > +             flags);
> > +
> > +     switch (direction) {
> > +     case DMA_MEM_TO_DEV:
> > +             dev_addr =3D cfg->dst_addr;
> > +             bus_width =3D cfg->dst_addr_width;
> > +             cmd =3D LS1X_DMA_RAM2DEV | LS1X_DMA_INT;
> > +             break;
> > +     case DMA_DEV_TO_MEM:
> > +             dev_addr =3D cfg->src_addr;
> > +             bus_width =3D cfg->src_addr_width;
> > +             cmd =3D LS1X_DMA_INT;
> > +             break;
> > +     default:
> > +             dev_err(chan2dev(dchan),
> > +                     "unsupported DMA transfer mode! %d\n", direction)=
;
> > +             return NULL;
>
> will this be ever executed?

just in case.
>
> > +static int ls1x_dma_slave_config(struct dma_chan *dchan,
> > +                              struct dma_slave_config *config)
> > +{
> > +     struct ls1x_dma_chan *chan =3D to_ls1x_dma_chan(dchan);
> > +
> > +     if (!dchan)
> > +             return -EINVAL;
>
> should this not be checked before you dereference this to get chan

will drop this check.
>
> > +static void ls1x_dma_trigger(struct ls1x_dma_chan *chan)
> > +{
> > +     struct dma_chan *dchan =3D &chan->vchan.chan;
> > +     struct ls1x_dma_desc *desc;
> > +     struct virt_dma_desc *vdesc;
> > +     unsigned int val;
> > +
> > +     vdesc =3D vchan_next_desc(&chan->vchan);
> > +     if (!vdesc) {
> > +             dev_warn(chan2dev(dchan), "No pending descriptor\n");
>
> Hmm, I would not log that... this is called from
> ls1x_dma_issue_pending() and which can be called from client driver but
> previous completion would push and this can find empty queue so it can
> happen quite frequently

will drop this warning.
>
> > +static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
> > +{
> > +     struct ls1x_dma_chan *chan =3D data;
> > +     struct dma_chan *dchan =3D &chan->vchan.chan;
> > +
> > +     dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\n", irq, chan-=
>id);
> > +     if (!chan->desc) {
> > +             dev_warn(chan2dev(dchan),
> > +                      "DMA IRQ with no active descriptor on channel %d=
\n",
> > +                      chan->id);
>
> single line pls

will do.
>
> > +             return IRQ_NONE;
> > +     }
> > +
> > +     spin_lock(&chan->vchan.lock);
> > +
> > +     if (chan->desc->type =3D=3D DMA_CYCLIC) {
> > +             vchan_cyclic_callback(&chan->desc->vdesc);
> > +     } else {
> > +             list_del(&chan->desc->vdesc.node);
> > +             vchan_cookie_complete(&chan->desc->vdesc);
> > +             chan->desc =3D NULL;
> > +     }
>
> not submitting next txn, defeats the purpose of dma if we dont push txns
> as fast as possible..

will fix it.
>
> > +static struct platform_driver ls1x_dma_driver =3D {
> > +     .probe  =3D ls1x_dma_probe,
> > +     .remove =3D ls1x_dma_remove,
> > +     .driver =3D {
> > +             .name   =3D "ls1x-dma",
> > +     },
>
> No device tree?

Because the LOONGSON32 platform doesn't support DT yet.
>
> --
> ~Vinod



--=20
Best regards,

Kelvin Cheung
