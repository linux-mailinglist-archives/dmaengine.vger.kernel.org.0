Return-Path: <dmaengine+bounces-2142-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A98CCE99
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2024 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1DA1C22374
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9813B58D;
	Thu, 23 May 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="Z6czPYM2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB08339A0
	for <dmaengine@vger.kernel.org>; Thu, 23 May 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454281; cv=none; b=TP4ctpE9s48IYP9U8wce5pdNNrEYJloYgwL+YouTGk2e4UgfI2RGYsNw0PrUzpvCoCIcrLI/9pkOVmwtqW2TZ0ZFZz8ZDRHdaCUfSkjqVSSK2d6sphu1ZlgW27Q2vOTRmQxlM6mFLoAr1UfmJuIWtfN6rZHUT0CU3f2VCbfCHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454281; c=relaxed/simple;
	bh=DNfkDaBNjzFTS09FFbcXOQJrdlMYqBC+FOgxOucimKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEwCYaQYTXgIyuaz8KjikwmtPki79QYFELtxMq9ps4R507IMpWcjD6BuAd3NdmgWoQ12Gz4I1e1KufKImC5iQNIHtE6nd4UNOjxNY4/Fnj6KoZVn5KUBQk/q9uNgmuA5UCZNQR8cSrVVRao6YA1D6Goz0Qq0NC05SqdRLd54iVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=Z6czPYM2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354b722fe81so1794136f8f.3
        for <dmaengine@vger.kernel.org>; Thu, 23 May 2024 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1716454278; x=1717059078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt6dYwxxXN47aKIAKTX15LKRxDXigbbAdN2nSsT9SkA=;
        b=Z6czPYM2Tg6nNCdsY5BbNN9+b2cmPxu0f7Ymi+ANWT2asTjTfpev4Yw94hMa26u1YS
         5dlW9vvFBK7MS2BwPBrIc/pBOPtYMXQnX9CvNpoJStnW25EwIYooJYu1WjFSofS3O4F/
         4m5Xvmfdx8t5cYorSQKWPBc62aTdWstvLnS18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716454278; x=1717059078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mt6dYwxxXN47aKIAKTX15LKRxDXigbbAdN2nSsT9SkA=;
        b=b/IkVlfOGOiD+WCvoRqwZD8XI/VFwfsQpfacZrIjJWZCBFwhi4KESo+TQPU1gH175z
         md8IEiMJL5iiFHVOt2K4GZNNCsiTD+zDvp5LrRJ87rwclvjKZaolMZyixxynhfC4XprR
         jM/LZtxTTrvVeUjAXd4px+IoShZHxJuhHlwh1J3Ty8//DT26meYnbMuKvY0mdi7kimKw
         Y5HxzNrak4+etEzmZWugswDHMl9sJ1PRy7JlQVEAZakzrfh5Ytbwby8k+vLpgupFqwNb
         O/p6rvgHDoCasK5UmVquTA4Buk5PpiS2joeWcbmr55WGS6If2XgVSWQZMaaR5i1gu+e0
         ny0w==
X-Gm-Message-State: AOJu0Yz/s44yPuqs1AyzscUDFyuqjtNNhTInc7c3siEPhmakgDGcFTyG
	qyw7tsIGetU1SeqKZxWqU1jPLwmwuxq5cWXjSISWUtCY6tF/bBaBwl3Ccj+jH/WVTkR4JfEKUXM
	V+NfpLH72a5EMoVv45vI3kC1tqhRUOSmpxnVKCA==
X-Google-Smtp-Source: AGHT+IFKsXW2wGqMONSCclzdO+99dQMdDAI221wB+uBOmAzT09exQ/EWODkFkuVEYXUrwzN/sHARnBYPikL9iXOGSTE=
X-Received: by 2002:a5d:64ce:0:b0:354:f48e:dafe with SMTP id
 ffacd0b85a97d-354f48ede7emr2443309f8f.8.1716454277870; Thu, 23 May 2024
 01:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALYqZ9myK4rD6gds3j2WeuFq52i6_wghnZ9BVQAaEcVvZ6RxZA@mail.gmail.com>
 <f5d73b4b-ff2c-f94b-e75e-c9f60c657c11@amd.com>
In-Reply-To: <f5d73b4b-ff2c-f94b-e75e-c9f60c657c11@amd.com>
From: Eric Debief <debief@digigram.com>
Date: Thu, 23 May 2024 10:50:52 +0200
Message-ID: <CALYqZ9mgeKdH6Lpghs3qhh9=ysZWUg3DqyXmw4p6WPMkxP0ygg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] : Fix DMAR Error NO_PASID when IOMMU is enabled
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lizhi,

Thanks for your reply.

Stream mode : I was told it was supported since the 6.8 or even since
the 6.7 kernel. I'll check my sources.
I now understand why this was not done.
On our side, we use the XDMA in stream mode as you suppose. At the
moment, it works fine with the patched genuine xdma driver.
I totally agree with your suggestion.
Let me correct this. It will take me a few weeks. Tell me if it is ok for y=
ou.

Best regards,
Eric.

Le mer. 22 mai 2024 =C3=A0 18:59, Lizhi Hou <lizhi.hou@amd.com> a =C3=A9cri=
t :
>
> Hi Eric,
>
>
> Current xdma driver supports only Memory Mapped (writeback polling is
> off) channel. And it is tested with iommu on. With this configuration,
> the hardware should not generate any writeback.
>
> So, what you are working on is  something like "add stream channel suppor=
t".
>
> To support stream channel, I would suggest to add "bool stream_mode" in
> struct xdma_chan and set it based on identifer register in
> xdma_alloc_channels().
>
> The C2H writeback allocations and other stream specific operation should
> be based on stream_mode flag.
>
> At last, the wb buf should be per descriptor instead of per channel. And
> the interrupt handler routine should look at the length and EOP in wb
> buf. With stream mode, the C2H desc may partially filled up due to an
> end of packet.
>
>
> Thanks,
>
> Lizhi
>
> On 5/22/24 05:12, Eric Debief wrote:
> > Hi,
> >
> > We had a "DMAR Error  NO PASID" error reported in the kernel's log
> > when the IOMMU was enabled.
> >
> > This is due to the missing WriteBack area for the C2H stream.
> > Below my patch.
> > One point : I didn't compile it within the latest kernel's sources'
> > tree as it is an extract of our backport of the XDMA support.
> > Feel free to contact me on any issue with this.
> >
> > Hope this helps,
> > Eric.
> >
> > Below my patch (corrected).
> >
> >  From b8d71851e6a146dcb448b01a671f455afb09ae90 Mon Sep 17 00:00:00 2001
> > From: Eric DEBIEF <debief@digigram.com>
> > Date: Wed, 22 May 2024 12:33:06 +0200
> > Subject: FIX: DMAR Error with IO_MMU enabled.
> >
> > C2H write-back area was not allocated and set.
> > This leads to the DMAR Error.
> >
> > Add the Writeback structure, allocate and set it as
> > the descriptors's Src field.
> > Done for all preps functions.
> >
> > Signed-off-by: Eric DEBIEF <debief@digigram.com>
> > ---
> >   drivers/dma/xilinx/xdma.c | 44 +++++++++++++++++++++++++++++++++++---=
-
> >   1 file changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> > index 74d4a953b50f..9ae615165cb6 100644
> > --- a/drivers/dma/xilinx/xdma.c
> > +++ b/drivers/dma/xilinx/xdma.c
> > @@ -51,6 +51,20 @@ struct xdma_desc_block {
> >       dma_addr_t    dma_addr;
> >   };
> >
> > +/**
> > + * struct xdma_c2h_write_back  - Write back block , written by the XDM=
A.
> > + * @magic_status_bit : magic (0x52B4) once written
> > + * @length: effective transfer length (in bytes)
> > + * @PADDING to be aligned on 32 bytes
> > + * @associated dma address
> > + */
> > +struct xdma_c2h_write_back {
> > +    __le32 magic_status_bit;
> > +    __le32 length;
> > +    u32 padding_1[6];
> > +    dma_addr_t dma_addr;
> > +};
> > +
> >   /**
> >    * struct xdma_chan - Driver specific DMA channel structure
> >    * @vchan: Virtual channel
> > @@ -61,6 +75,8 @@ struct xdma_desc_block {
> >    * @dir: Transferring direction of the channel
> >    * @cfg: Transferring config of the channel
> >    * @irq: IRQ assigned to the channel
> > + * @write_back : C2H meta data write back
> > +
> >    */
> >   struct xdma_chan {
> >       struct virt_dma_chan        vchan;
> > @@ -73,6 +89,7 @@ struct xdma_chan {
> >       u32                irq;
> >       struct completion        last_interrupt;
> >       bool                stop_requested;
> > +    struct xdma_c2h_write_back *write_back;
> >   };
> >
> >   /**
> > @@ -628,7 +645,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
> > scatterlist *sgl,
> >           src =3D &addr;
> >           dst =3D &dev_addr;
> >       } else {
> > -        dev_addr =3D xdma_chan->cfg.src_addr;
> > +        dev_addr =3D xdma_chan->cfg.src_addr ?
> > +            xdma_chan->cfg.src_addr : xdma_chan->write_back->dma_addr;
> >           src =3D &dev_addr;
> >           dst =3D &addr;
> >       }
> > @@ -705,7 +723,8 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
> > dma_addr_t address,
> >           src =3D &addr;
> >           dst =3D &dev_addr;
> >       } else {
> > -        dev_addr =3D xdma_chan->cfg.src_addr;
> > +        dev_addr =3D xdma_chan->cfg.src_addr ?
> > +            xdma_chan->cfg.src_addr : xdma_chan->write_back->dma_addr;
> >           src =3D &dev_addr;
> >           dst =3D &addr;
> >       }
> > @@ -803,6 +822,9 @@ static void xdma_free_chan_resources(struct dma_cha=
n *chan)
> >       struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
> >
> >       vchan_free_chan_resources(&xdma_chan->vchan);
> > +    dma_pool_free(xdma_chan->desc_pool,
> > +                xdma_chan->write_back,
> > +               xdma_chan->write_back->dma_addr);
> >       dma_pool_destroy(xdma_chan->desc_pool);
> >       xdma_chan->desc_pool =3D NULL;
> >   }
> > @@ -816,6 +838,7 @@ static int xdma_alloc_chan_resources(struct dma_cha=
n *chan)
> >       struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
> >       struct xdma_device *xdev =3D xdma_chan->xdev_hdl;
> >       struct device *dev =3D xdev->dma_dev.dev;
> > +    dma_addr_t write_back_addr;
> >
> >       while (dev && !dev_is_pci(dev))
> >           dev =3D dev->parent;
> > @@ -824,13 +847,26 @@ static int xdma_alloc_chan_resources(struct
> > dma_chan *chan)
> >           return -EINVAL;
> >       }
> >
> > -    xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan), dev,
> > XDMA_DESC_BLOCK_SIZE,
> > -                           XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUN=
DARY);
> > +    //Allocate the pool WITH the H2C write back
> > +    xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan),
> > +                            dev,
> > +                            XDMA_DESC_BLOCK_SIZE +
> > +                                sizeof(struct xdma_c2h_write_back),
> > +                            XDMA_DESC_BLOCK_ALIGN,
> > +                            XDMA_DESC_BLOCK_BOUNDARY);
> >       if (!xdma_chan->desc_pool) {
> >           xdma_err(xdev, "unable to allocate descriptor pool");
> >           return -ENOMEM;
> >       }
> >
> > +    /* Allocate the C2H write back out of the pool*/
> > +    xdma_chan->write_back =3D dma_pool_alloc(xdma_chan->desc_pool,
> > GFP_NOWAIT, &write_back_addr);
> > +    if (!xdma_chan->write_back) {
> > +        xdma_err(xdev, "unable to allocate C2H write back block");
> > +        return -ENOMEM;
> > +    }
> > +    xdma_chan->write_back->dma_addr =3D write_back_addr;
> > +
> >       return 0;
> >   }
> >
> > --
> > 2.34.1

