Return-Path: <dmaengine+bounces-1373-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CD87A9BF
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8271F22A5A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACBF46BA6;
	Wed, 13 Mar 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G/IFVmhq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604946544
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341349; cv=none; b=LxiKMMlv1NoW14qOFimFIpWt4ai5ZuuUFfuHm6A0ehrJ4lkMDWqfzfIb8B4mN8DW4ZolpEvhBMFRD9RiEoqY4dBsagWpS5QcSm4rPgySTQny+7zE56IjAgw58nur3ywKf0fUp0dwLrF2R4nz83JHs5s7aGdnTGEBZjYxWdBieMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341349; c=relaxed/simple;
	bh=qNvHt4qXvFR9i1e4OWyMS9v3NaLUmqAkjzNOiGYBe88=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYvQ/RKPg3uOO/e/T2S5b3yHyqAR6wq3cBT4pDWa94jyUlk4sbueqIuoTM5bIjMojzyEaHESONYoj6Bx9hPdPg7rrEHr5ZqfQ2ZaNd3vmgtiYmgutnZSpdXS25bb4I1S0AWW1yTf/mWP4lc73gKDMiP+p0gv/NI5TbW/CpLNeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G/IFVmhq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45f257b81fso663607466b.0
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710341346; x=1710946146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3eQum80NNnCkG6phw9dHYDaS2ANjJ+Hfdu++iY8NGk=;
        b=G/IFVmhqxUABgIVQBb37zagMzWgUnVb7AaJr9B2Ag6I+s92tC9atc0zv7GN2PsUTKg
         XHoyAjNg2KyaMpuyt2b+thaiBP7QF8hR3H4Mw5LcglW14xDpKfwt2+UogbEmq1zAz2fT
         31+Sz/Y+sPOm1LWLOiEyBn+o322rrSm8VXl2/16QvkiNCr3HYx8QPORM43+qn23DtI2W
         +7iAxHqF8osqmAotIhHJ73pMZXgpg9IitTOhLI8PA4V3YOjs8vWh2P9PSUsM9nv8NfxP
         Od72pDLxQ15TTO+DYl1GAmwOrXqvQvzgLcVuyUWDHR29EJvNY6M/Qv9aOnXuXTdElNWK
         IsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710341346; x=1710946146;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3eQum80NNnCkG6phw9dHYDaS2ANjJ+Hfdu++iY8NGk=;
        b=YbYpwfkaQhL1tgxSRVN4h6/vBTXL9O8Zlg8ZNzddMFoooksLhf3MKnTVQkJAqn+ciN
         2k/Wm3Suu4bbaL5VWA2AtbEJaQP604xEUfiJN/NMMkkw15HOFciHePMaQlif0MeZILyd
         Qff8Z3hXZlZbBN1SLdj1UMLbsuPg4UZP1hr9gYVpK3spOuz7vYhTgz3mgXd9qllj6PIM
         QxlEs31CeZiPUuyaUTsGQZkX5VuG17OkYn4b22Oy/nOKGqdXiosf5UEWyz9Nv20qZ2y+
         5613TEimC6PExXNeA9a1hlWgy4aXUXHGyWDRkuAaZ0tf8Vma3zG9XTUq7k51S2FGDNDl
         vchQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkahefnxg/nIFSEk26jwco97ni+9T3jW/QASB0GJyk4mlXdIK7U7/a4VRdofPjBA1QjcXimlWBr6+KMOHwyMV26yp7yKXACX4L
X-Gm-Message-State: AOJu0YyFMrgh6cP7ALhvuFJlJa/rosFZohnMwYNvnTuWfe1YNIusBSO+
	awUpFVuvIk9WqMyb8E3IxItZvyqfil32VvXP2fITmlhfEny/fQN44v7mAxWtVh8=
X-Google-Smtp-Source: AGHT+IGoZ5fJmL+zK19ZDe5D2rupsNcSyxqwyd2LWie0z6AU4dn5RVQinylPT0ATlRNZsuyAtUx0KQ==
X-Received: by 2002:a17:907:7b06:b0:a46:5b72:6d38 with SMTP id mn6-20020a1709077b0600b00a465b726d38mr1168654ejc.63.1710341345777;
        Wed, 13 Mar 2024 07:49:05 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id bh21-20020a170906a0d500b00a44efa48c24sm4933249ejb.117.2024.03.13.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:49:05 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 13 Mar 2024 15:49:04 +0100
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 12/15] dmaengine: bcm2835: introduce multi platform
 support
Message-ID: <ZfG84EGlh8MTPAbA@apocalypse>
Mail-Followup-To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
 <5826eba6ab78b9cdba21c12853a85d5f9a6aab76.1710226514.git.andrea.porta@suse.com>
 <CAPY8ntDkRVhz-1Go3QdYPihqAsjBDFy2De=q+i2C8rzK7hcV_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntDkRVhz-1Go3QdYPihqAsjBDFy2De=q+i2C8rzK7hcV_g@mail.gmail.com>

On 17:05 Tue 12 Mar     , Dave Stevenson wrote:
> Hi Andrea
> 
> On Tue, 12 Mar 2024 at 09:13, Andrea della Porta <andrea.porta@suse.com> wrote:
> >
> > This finally moves all platform specific stuff into a separate structure,
> > which is initialized on the OF compatible during probing. Since the DMA
> > control block is different on the BCM2711 platform, we introduce a common
> > control block to reserve the necessary space and adequate methods for
> > access.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  drivers/dma/bcm2835-dma.c | 336 +++++++++++++++++++++++++++++---------
> >  1 file changed, 260 insertions(+), 76 deletions(-)
> >
> > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > index 88ae5d05402e..b015eae29b08 100644
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -48,6 +48,11 @@ struct bcm2835_dmadev {
> >         struct dma_device ddev;
> >         void __iomem *base;
> >         dma_addr_t zero_page;
> > +       const struct bcm2835_dma_cfg *cfg;
> > +};
> > +
> > +struct bcm_dma_cb {
> > +       uint32_t rsvd[8];
> >  };
> >
> >  struct bcm2835_dma_cb {
> > @@ -61,7 +66,7 @@ struct bcm2835_dma_cb {
> >  };
> >
> >  struct bcm2835_cb_entry {
> > -       struct bcm2835_dma_cb *cb;
> > +       struct bcm_dma_cb *cb;
> >         dma_addr_t paddr;
> >  };
> >
> > @@ -82,6 +87,44 @@ struct bcm2835_chan {
> >         bool is_lite_channel;
> >  };
> >
> > +struct bcm2835_dma_cfg {
> > +       dma_addr_t addr_offset;
> > +       u32 cs_reg;
> > +       u32 cb_reg;
> > +       u32 next_reg;
> > +       u32 ti_reg;
> > +
> > +       u32 wait_mask;
> > +       u32 reset_mask;
> > +       u32 int_mask;
> > +       u32 active_mask;
> > +       u32 abort_mask;
> > +       u32 s_dreq_mask;
> > +       u32 d_dreq_mask;
> > +
> > +       u32 (*cb_get_length)(void *data);
> > +       dma_addr_t (*cb_get_addr)(void *data, enum dma_transfer_direction);
> > +
> > +       void (*cb_init)(void *data, struct bcm2835_chan *c,
> > +                       enum dma_transfer_direction, u32 src, u32 dst,
> > +                       bool zero_page);
> > +       void (*cb_set_src)(void *data, enum dma_transfer_direction, u32 src);
> > +       void (*cb_set_dst)(void *data, enum dma_transfer_direction, u32 dst);
> > +       void (*cb_set_next)(void *data, u32 next);
> > +       void (*cb_set_length)(void *data, u32 length);
> > +       void (*cb_append_extra)(void *data,
> > +                               struct bcm2835_chan *c,
> > +                               enum dma_transfer_direction direction,
> > +                               bool cyclic, bool final, unsigned long flags);
> > +
> > +       dma_addr_t (*to_cb_addr)(dma_addr_t addr);
> > +
> > +       void (*chan_plat_init)(struct bcm2835_chan *c);
> > +       dma_addr_t (*read_addr)(struct bcm2835_chan *c,
> > +                               enum dma_transfer_direction);
> > +       u32 (*cs_flags)(struct bcm2835_chan *c);
> > +};
> > +
> >  struct bcm2835_desc {
> >         struct bcm2835_chan *c;
> >         struct virt_dma_desc vd;
> > @@ -215,6 +258,13 @@ static inline struct bcm2835_dmadev *to_bcm2835_dma_dev(struct dma_device *d)
> >         return container_of(d, struct bcm2835_dmadev, ddev);
> >  }
> >
> > +static inline const struct bcm2835_dma_cfg *to_bcm2835_cfg(struct dma_device *d)
> > +{
> > +       struct bcm2835_dmadev *od = container_of(d, struct bcm2835_dmadev, ddev);
> > +
> > +       return od->cfg;
> > +}
> > +
> >  static inline struct bcm2835_chan *to_bcm2835_dma_chan(struct dma_chan *c)
> >  {
> >         return container_of(c, struct bcm2835_chan, vc.chan);
> > @@ -292,6 +342,109 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
> >         return false;
> >  }
> >
> > +static inline u32 bcm2835_dma_cb_get_length(void *data)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       return cb->length;
> > +}
> > +
> > +static inline dma_addr_t
> > +bcm2835_dma_cb_get_addr(void *data, enum dma_transfer_direction direction)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       if (direction == DMA_DEV_TO_MEM)
> > +               return cb->dst;
> > +
> > +       return cb->src;
> > +}
> > +
> > +static inline void
> > +bcm2835_dma_cb_init(void *data, struct bcm2835_chan *c,
> > +                   enum dma_transfer_direction direction, u32 src, u32 dst,
> > +                   bool zero_page)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       cb->info = bcm2835_dma_prepare_cb_info(c, direction, zero_page);
> > +       cb->src = src;
> > +       cb->dst = dst;
> > +       cb->stride = 0;
> > +       cb->next = 0;
> > +}
> > +
> > +static inline void
> > +bcm2835_dma_cb_set_src(void *data, enum dma_transfer_direction direction,
> > +                      u32 src)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       cb->src = src;
> > +}
> > +
> > +static inline void
> > +bcm2835_dma_cb_set_dst(void *data, enum dma_transfer_direction direction,
> > +                      u32 dst)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       cb->dst = dst;
> > +}
> > +
> > +static inline void bcm2835_dma_cb_set_next(void *data, u32 next)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       cb->next = next;
> > +}
> > +
> > +static inline void bcm2835_dma_cb_set_length(void *data, u32 length)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       cb->length = length;
> > +}
> > +
> > +static inline void
> > +bcm2835_dma_cb_append_extra(void *data, struct bcm2835_chan *c,
> > +                           enum dma_transfer_direction direction,
> > +                           bool cyclic, bool final, unsigned long flags)
> > +{
> > +       struct bcm2835_dma_cb *cb = data;
> > +
> > +       cb->info |= bcm2835_dma_prepare_cb_extra(c, direction, cyclic, final,
> > +                                                flags);
> > +}
> > +
> > +static inline dma_addr_t bcm2835_dma_to_cb_addr(dma_addr_t addr)
> > +{
> > +       return addr;
> > +}
> > +
> > +static void bcm2835_dma_chan_plat_init(struct bcm2835_chan *c)
> > +{
> > +       /* check in DEBUG register if this is a LITE channel */
> > +       if (readl(c->chan_base + BCM2835_DMA_DEBUG) & BCM2835_DMA_DEBUG_LITE)
> > +               c->is_lite_channel = true;
> > +}
> > +
> > +static dma_addr_t bcm2835_dma_read_addr(struct bcm2835_chan *c,
> > +                                       enum dma_transfer_direction direction)
> > +{
> > +       if (direction == DMA_MEM_TO_DEV)
> > +               return readl(c->chan_base + BCM2835_DMA_SOURCE_AD);
> > +       else if (direction == DMA_DEV_TO_MEM)
> > +               return readl(c->chan_base + BCM2835_DMA_DEST_AD);
> > +
> > +       return 0;
> > +}
> > +
> > +static u32 bcm2835_dma_cs_flags(struct bcm2835_chan *c)
> > +{
> > +       return BCM2835_DMA_CS_FLAGS(c->dreq);
> > +}
> > +
> >  static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
> >  {
> >         size_t i;
> > @@ -309,16 +462,19 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
> >  }
> >
> >  static bool bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
> > -                                            struct bcm2835_dma_cb *control_block,
> > +                                            void *data,
> >                                              size_t len,
> >                                              size_t period_len,
> >                                              size_t *total_len)
> >  {
> > +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
> >         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >         size_t max_len = bcm2835_dma_max_frame_length(c);
> >
> >         /* set the length taking lite-channel limitations into account */
> > -       control_block->length = min_t(u32, len, max_len);
> > +       u32 length = min_t(u32, len, max_len);
> > +
> > +       cfg->cb_set_length(data, length);
> >
> >         /* finished if we have no period_length */
> >         if (!period_len)
> > @@ -333,14 +489,14 @@ static bool bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
> >          */
> >
> >         /* have we filled in period_length yet? */
> > -       if (*total_len + control_block->length < period_len) {
> > +       if (*total_len + length < period_len) {
> >                 /* update number of bytes in this period so far */
> > -               *total_len += control_block->length;
> > +               *total_len += length;
> >                 return false;
> >         }
> >
> >         /* calculate the length that remains to reach period_length */
> > -       control_block->length = period_len - *total_len;
> > +       cfg->cb_set_length(data, period_len - *total_len);
> >
> >         /* reset total_length for next period */
> >         *total_len = 0;
> > @@ -388,15 +544,14 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
> >                                         size_t buf_len, size_t period_len,
> >                                         gfp_t gfp, unsigned long flags)
> >  {
> > +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
> >         struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
> >         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >         size_t len = buf_len, total_len;
> >         size_t frame;
> >         struct bcm2835_desc *d;
> >         struct bcm2835_cb_entry *cb_entry;
> > -       struct bcm2835_dma_cb *control_block;
> > -       u32 extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic,
> > -                                                    false, flags);
> > +       struct bcm_dma_cb *control_block;
> >         bool zero_page = false;
> >
> >         if (!frames)
> > @@ -432,12 +587,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
> >
> >                 /* fill in the control block */
> >                 control_block = cb_entry->cb;
> > -               control_block->info = bcm2835_dma_prepare_cb_info(c, direction,
> > -                                                                 zero_page);
> > -               control_block->src = src;
> > -               control_block->dst = dst;
> > -               control_block->stride = 0;
> > -               control_block->next = 0;
> > +               cfg->cb_init(control_block, c, src, dst, direction, zero_page);
> 
> Can I ask how you've been testing these patches?

Sure, most of these issues were easily spotted by mem to mem transactions, using dmatest. 
> 
> This line was one of the bugs that I found during my work. The
> prototype for cb_init is
>  +       void (*cb_init)(void *data, struct bcm2835_chan *c,
>  +                       enum dma_transfer_direction, u32 src, u32 dst,
>  +                       bool zero_page);
> So this call has direction in the wrong place, which leads to quite
> comical failures.

Exactly, that was one of the funniest. This is indeed resolved in patch number 14.
The others being related to address shifting in the 40 bit case, basically I've just 
replaced << 8 with << 32 on srci and dsti control block fields. 

Many thanks,
Andrea

> 
> Thanks
>   Dave
> 

