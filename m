Return-Path: <dmaengine+bounces-1347-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C092879A32
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66A1B24BEA
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3905139566;
	Tue, 12 Mar 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="UFJllf71"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D80137C22
	for <dmaengine@vger.kernel.org>; Tue, 12 Mar 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263127; cv=none; b=Qz/74RiKP92GZbIzoic6v3YyRanw1WOieeHLw9ZXdOV7SAdOBlU+ybUqBWSxY1uNXK7FZuOoVkYtq6ynK9JTTswhQIZ2wJ1Et/pW81MtETpmR1kEuQ9jm7d5whguKTyNurfXDkk9e1y96sCiXmf14fhwhEN/q3JOR99Lj0a5icM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263127; c=relaxed/simple;
	bh=nETdnNiXbfJYVcvR+8BdhDfh+cHHu3duiWQBr9gQ/cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOwLMDIe3dy6q3iBkToxXFOI6mi33wiyhWgFu2u4qflBMrYco9pcvhNgj/kux6tC7buCGdWHKbZdk9p+l85+ookuqEhUBVnigqCANF/89YvpbDiheFchoMDZKqbmb07o822qOzLfwzB572DcJsNM+479gIF1FfWZhqW6vdhgNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=UFJllf71; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc74435c428so5602203276.2
        for <dmaengine@vger.kernel.org>; Tue, 12 Mar 2024 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1710263124; x=1710867924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PImBKvEkplXQtr3VSaidgr6kxa6jFNk7CGiKtDSsyy8=;
        b=UFJllf718G4B9sOdF4Cfoihv1R5HDDsnaezlzN/8MOr1jbYZ//JBFBU0kqwKskxMZk
         YympBIQLyM9H98jhq9kEo2otYiuspmlhnhdWgNNugZrkMJE00syIqwwAWr9Re9zFPRuz
         b7MDBWY4rhd+uJFSMOQbFyMn5CZ/71GLzjNLF5oNFcX/TEViOS9PI05Y8ZVfzXMD6mpi
         N0VJlLMZwnbbe+7ob1CFbYiXnsDub5Bt5D052FIyyUVy5+c7bgpcCvtp0hWNc4/PpqLq
         wcuUMSb4fDMo6Uanoz3DbauwoKIs6gGCx9XW4KLok07MPPta1DtH0Qmmdf7wgJpVAUC9
         36qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263124; x=1710867924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PImBKvEkplXQtr3VSaidgr6kxa6jFNk7CGiKtDSsyy8=;
        b=ZExMPuwLmUoMlwsVpLOhwxJ8KVBsbQduXt/G8pqzUwF9NWZANJ/cyaqXGYDuPfAcde
         CpQLppYAWEXEEo8AUiq5AoCxetSl1nIgf+IDG4nu/jBsAbqOl7vwiMRlKeZ6OZCO3uIP
         dwbilVC/LRqNe3U7DaQKV15zV88h7orRHl9+A3Oa9EMMxJEA8lI8qSH5tmo95sPVyGyJ
         j5Ds+Rf6AyIp4CUGO1QPQ8d8wGTTsMFVZS5OQ7HTNT/3KzQfscCtof3UgDVjzgTLi+Y7
         DZ0Ah5RMreE7jIJB3FIQHlgsiKvUnjBoeMd1NdMnM0E1PsEn1VDTUF+AQObqaoQlCHUw
         7WWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbrjVzuk1tTZr4N/y1JekF4j7d9AINhLnAgZMAMKjdiCYFQVlt1LfmHWWLaza3ndoqi86zkY5t9ttkVvdrMQGZhKFopCXsZUyE
X-Gm-Message-State: AOJu0YytY40MOMnvRrkyrS6vdCAmtK1JJ5YizZ7E0Be+7lEWU0A13GFf
	C2LfUEWmrn+AodYLE4OsY1s3wQr7G8NyPTXcYahalu0+YsNvaZtMhzuLv6WFKwQLFTUrVofx+pn
	ZcGbyIpV+SoS771i9o4DVUQsYTIwgh3iIWTiBnw==
X-Google-Smtp-Source: AGHT+IEDFsfukXF8rg7Ln60CYi6RrTxm0YaS2AzL2IJHok17CPVJXtv4CE8Vxy01xJIslm8jgi3qc9dpqSBuZ7FaXOw=
X-Received: by 2002:a5b:945:0:b0:dcf:288e:21ca with SMTP id
 x5-20020a5b0945000000b00dcf288e21camr38042ybq.11.1710263123841; Tue, 12 Mar
 2024 10:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710226514.git.andrea.porta@suse.com> <5826eba6ab78b9cdba21c12853a85d5f9a6aab76.1710226514.git.andrea.porta@suse.com>
In-Reply-To: <5826eba6ab78b9cdba21c12853a85d5f9a6aab76.1710226514.git.andrea.porta@suse.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 12 Mar 2024 17:05:07 +0000
Message-ID: <CAPY8ntDkRVhz-1Go3QdYPihqAsjBDFy2De=q+i2C8rzK7hcV_g@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] dmaengine: bcm2835: introduce multi platform support
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Saenz Julienne <nsaenz@kernel.org>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea

On Tue, 12 Mar 2024 at 09:13, Andrea della Porta <andrea.porta@suse.com> wrote:
>
> This finally moves all platform specific stuff into a separate structure,
> which is initialized on the OF compatible during probing. Since the DMA
> control block is different on the BCM2711 platform, we introduce a common
> control block to reserve the necessary space and adequate methods for
> access.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/dma/bcm2835-dma.c | 336 +++++++++++++++++++++++++++++---------
>  1 file changed, 260 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 88ae5d05402e..b015eae29b08 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -48,6 +48,11 @@ struct bcm2835_dmadev {
>         struct dma_device ddev;
>         void __iomem *base;
>         dma_addr_t zero_page;
> +       const struct bcm2835_dma_cfg *cfg;
> +};
> +
> +struct bcm_dma_cb {
> +       uint32_t rsvd[8];
>  };
>
>  struct bcm2835_dma_cb {
> @@ -61,7 +66,7 @@ struct bcm2835_dma_cb {
>  };
>
>  struct bcm2835_cb_entry {
> -       struct bcm2835_dma_cb *cb;
> +       struct bcm_dma_cb *cb;
>         dma_addr_t paddr;
>  };
>
> @@ -82,6 +87,44 @@ struct bcm2835_chan {
>         bool is_lite_channel;
>  };
>
> +struct bcm2835_dma_cfg {
> +       dma_addr_t addr_offset;
> +       u32 cs_reg;
> +       u32 cb_reg;
> +       u32 next_reg;
> +       u32 ti_reg;
> +
> +       u32 wait_mask;
> +       u32 reset_mask;
> +       u32 int_mask;
> +       u32 active_mask;
> +       u32 abort_mask;
> +       u32 s_dreq_mask;
> +       u32 d_dreq_mask;
> +
> +       u32 (*cb_get_length)(void *data);
> +       dma_addr_t (*cb_get_addr)(void *data, enum dma_transfer_direction);
> +
> +       void (*cb_init)(void *data, struct bcm2835_chan *c,
> +                       enum dma_transfer_direction, u32 src, u32 dst,
> +                       bool zero_page);
> +       void (*cb_set_src)(void *data, enum dma_transfer_direction, u32 src);
> +       void (*cb_set_dst)(void *data, enum dma_transfer_direction, u32 dst);
> +       void (*cb_set_next)(void *data, u32 next);
> +       void (*cb_set_length)(void *data, u32 length);
> +       void (*cb_append_extra)(void *data,
> +                               struct bcm2835_chan *c,
> +                               enum dma_transfer_direction direction,
> +                               bool cyclic, bool final, unsigned long flags);
> +
> +       dma_addr_t (*to_cb_addr)(dma_addr_t addr);
> +
> +       void (*chan_plat_init)(struct bcm2835_chan *c);
> +       dma_addr_t (*read_addr)(struct bcm2835_chan *c,
> +                               enum dma_transfer_direction);
> +       u32 (*cs_flags)(struct bcm2835_chan *c);
> +};
> +
>  struct bcm2835_desc {
>         struct bcm2835_chan *c;
>         struct virt_dma_desc vd;
> @@ -215,6 +258,13 @@ static inline struct bcm2835_dmadev *to_bcm2835_dma_dev(struct dma_device *d)
>         return container_of(d, struct bcm2835_dmadev, ddev);
>  }
>
> +static inline const struct bcm2835_dma_cfg *to_bcm2835_cfg(struct dma_device *d)
> +{
> +       struct bcm2835_dmadev *od = container_of(d, struct bcm2835_dmadev, ddev);
> +
> +       return od->cfg;
> +}
> +
>  static inline struct bcm2835_chan *to_bcm2835_dma_chan(struct dma_chan *c)
>  {
>         return container_of(c, struct bcm2835_chan, vc.chan);
> @@ -292,6 +342,109 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
>         return false;
>  }
>
> +static inline u32 bcm2835_dma_cb_get_length(void *data)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       return cb->length;
> +}
> +
> +static inline dma_addr_t
> +bcm2835_dma_cb_get_addr(void *data, enum dma_transfer_direction direction)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       if (direction == DMA_DEV_TO_MEM)
> +               return cb->dst;
> +
> +       return cb->src;
> +}
> +
> +static inline void
> +bcm2835_dma_cb_init(void *data, struct bcm2835_chan *c,
> +                   enum dma_transfer_direction direction, u32 src, u32 dst,
> +                   bool zero_page)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       cb->info = bcm2835_dma_prepare_cb_info(c, direction, zero_page);
> +       cb->src = src;
> +       cb->dst = dst;
> +       cb->stride = 0;
> +       cb->next = 0;
> +}
> +
> +static inline void
> +bcm2835_dma_cb_set_src(void *data, enum dma_transfer_direction direction,
> +                      u32 src)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       cb->src = src;
> +}
> +
> +static inline void
> +bcm2835_dma_cb_set_dst(void *data, enum dma_transfer_direction direction,
> +                      u32 dst)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       cb->dst = dst;
> +}
> +
> +static inline void bcm2835_dma_cb_set_next(void *data, u32 next)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       cb->next = next;
> +}
> +
> +static inline void bcm2835_dma_cb_set_length(void *data, u32 length)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       cb->length = length;
> +}
> +
> +static inline void
> +bcm2835_dma_cb_append_extra(void *data, struct bcm2835_chan *c,
> +                           enum dma_transfer_direction direction,
> +                           bool cyclic, bool final, unsigned long flags)
> +{
> +       struct bcm2835_dma_cb *cb = data;
> +
> +       cb->info |= bcm2835_dma_prepare_cb_extra(c, direction, cyclic, final,
> +                                                flags);
> +}
> +
> +static inline dma_addr_t bcm2835_dma_to_cb_addr(dma_addr_t addr)
> +{
> +       return addr;
> +}
> +
> +static void bcm2835_dma_chan_plat_init(struct bcm2835_chan *c)
> +{
> +       /* check in DEBUG register if this is a LITE channel */
> +       if (readl(c->chan_base + BCM2835_DMA_DEBUG) & BCM2835_DMA_DEBUG_LITE)
> +               c->is_lite_channel = true;
> +}
> +
> +static dma_addr_t bcm2835_dma_read_addr(struct bcm2835_chan *c,
> +                                       enum dma_transfer_direction direction)
> +{
> +       if (direction == DMA_MEM_TO_DEV)
> +               return readl(c->chan_base + BCM2835_DMA_SOURCE_AD);
> +       else if (direction == DMA_DEV_TO_MEM)
> +               return readl(c->chan_base + BCM2835_DMA_DEST_AD);
> +
> +       return 0;
> +}
> +
> +static u32 bcm2835_dma_cs_flags(struct bcm2835_chan *c)
> +{
> +       return BCM2835_DMA_CS_FLAGS(c->dreq);
> +}
> +
>  static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
>  {
>         size_t i;
> @@ -309,16 +462,19 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
>  }
>
>  static bool bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
> -                                            struct bcm2835_dma_cb *control_block,
> +                                            void *data,
>                                              size_t len,
>                                              size_t period_len,
>                                              size_t *total_len)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         size_t max_len = bcm2835_dma_max_frame_length(c);
>
>         /* set the length taking lite-channel limitations into account */
> -       control_block->length = min_t(u32, len, max_len);
> +       u32 length = min_t(u32, len, max_len);
> +
> +       cfg->cb_set_length(data, length);
>
>         /* finished if we have no period_length */
>         if (!period_len)
> @@ -333,14 +489,14 @@ static bool bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
>          */
>
>         /* have we filled in period_length yet? */
> -       if (*total_len + control_block->length < period_len) {
> +       if (*total_len + length < period_len) {
>                 /* update number of bytes in this period so far */
> -               *total_len += control_block->length;
> +               *total_len += length;
>                 return false;
>         }
>
>         /* calculate the length that remains to reach period_length */
> -       control_block->length = period_len - *total_len;
> +       cfg->cb_set_length(data, period_len - *total_len);
>
>         /* reset total_length for next period */
>         *total_len = 0;
> @@ -388,15 +544,14 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
>                                         size_t buf_len, size_t period_len,
>                                         gfp_t gfp, unsigned long flags)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         size_t len = buf_len, total_len;
>         size_t frame;
>         struct bcm2835_desc *d;
>         struct bcm2835_cb_entry *cb_entry;
> -       struct bcm2835_dma_cb *control_block;
> -       u32 extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic,
> -                                                    false, flags);
> +       struct bcm_dma_cb *control_block;
>         bool zero_page = false;
>
>         if (!frames)
> @@ -432,12 +587,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
>
>                 /* fill in the control block */
>                 control_block = cb_entry->cb;
> -               control_block->info = bcm2835_dma_prepare_cb_info(c, direction,
> -                                                                 zero_page);
> -               control_block->src = src;
> -               control_block->dst = dst;
> -               control_block->stride = 0;
> -               control_block->next = 0;
> +               cfg->cb_init(control_block, c, src, dst, direction, zero_page);

Can I ask how you've been testing these patches?

This line was one of the bugs that I found during my work. The
prototype for cb_init is
 +       void (*cb_init)(void *data, struct bcm2835_chan *c,
 +                       enum dma_transfer_direction, u32 src, u32 dst,
 +                       bool zero_page);
So this call has direction in the wrong place, which leads to quite
comical failures.

Thanks
  Dave

>                 /* set up length in control_block if requested */
>                 if (buf_len) {
>                         /* calculate length honoring period_length */
> @@ -445,31 +595,33 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
>                                 chan, control_block,
>                                 len, period_len, &total_len)) {
>                                 /* add extrainfo bits in info */
> -                               control_block->info |= extrainfo;
> +                               bcm2835_dma_cb_append_extra(control_block, c,
> +                                                           direction, cyclic,
> +                                                           false, flags);
>                         }
>
>                         /* calculate new remaining length */
> -                       len -= control_block->length;
> +                       len -= cfg->cb_get_length(control_block);
>                 }
>
>                 /* link this the last controlblock */
>                 if (frame)
> -                       d->cb_list[frame - 1].cb->next = cb_entry->paddr;
> +                       cfg->cb_set_next(d->cb_list[frame - 1].cb,
> +                                        cb_entry->paddr);
>
>                 /* update src and dst and length */
>                 if (src && need_src_incr(direction))
> -                       src += control_block->length;
> +                       src += cfg->cb_get_length(control_block);
>                 if (dst && need_dst_incr(direction))
> -                       dst += control_block->length;
> +                       dst += cfg->cb_get_length(control_block);
>
>                 /* Length of total transfer */
> -               d->size += control_block->length;
> +               d->size += cfg->cb_get_length(control_block);
>         }
>
>         /* the last frame requires extra flags */
> -       extrainfo = bcm2835_dma_prepare_cb_extra(c, direction, cyclic, true,
> -                                                flags);
> -       d->cb_list[d->frames - 1].cb->info |= extrainfo;
> +       cfg->cb_append_extra(d->cb_list[d->frames - 1].cb, c, direction, cyclic,
> +                            true, flags);
>
>         /* detect a size mismatch */
>         if (buf_len && d->size != buf_len)
> @@ -489,6 +641,7 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
>         struct scatterlist *sgl,
>         unsigned int sg_len)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         size_t len, max_len;
>         unsigned int i;
> @@ -499,18 +652,19 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
>         for_each_sg(sgl, sgent, sg_len, i) {
>                 for (addr = sg_dma_address(sgent), len = sg_dma_len(sgent);
>                      len > 0;
> -                    addr += cb->cb->length, len -= cb->cb->length, cb++) {
> +                    addr += cfg->cb_get_length(cb->cb), len -= cfg->cb_get_length(cb->cb), cb++) {
>                         if (direction == DMA_DEV_TO_MEM)
> -                               cb->cb->dst = addr;
> +                               cfg->cb_set_dst(cb->cb, direction, addr);
>                         else
> -                               cb->cb->src = addr;
> -                       cb->cb->length = min(len, max_len);
> +                               cfg->cb_set_src(cb->cb, direction, addr);
> +                       cfg->cb_set_length(cb->cb, min(len, max_len));
>                 }
>         }
>  }
>
>  static void bcm2835_dma_abort(struct dma_chan *chan)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         void __iomem *chan_base = c->chan_base;
>         long timeout = 100;
> @@ -519,41 +673,42 @@ static void bcm2835_dma_abort(struct dma_chan *chan)
>          * A zero control block address means the channel is idle.
>          * (The ACTIVE flag in the CS register is not a reliable indicator.)
>          */
> -       if (!readl(chan_base + BCM2835_DMA_ADDR))
> +       if (!readl(chan_base + cfg->cb_reg))
>                 return;
>
>         /* We need to clear the next DMA block pending */
> -       writel(0, chan_base + BCM2835_DMA_NEXTCB);
> +       writel(0, chan_base + cfg->next_reg);
>
>         /* Abort the DMA, which needs to be enabled to complete */
> -       writel(readl(chan_base + BCM2835_DMA_CS) | BCM2835_DMA_ABORT | BCM2835_DMA_ACTIVE,
> -              chan_base + BCM2835_DMA_CS);
> +       writel(readl(chan_base + cfg->cs_reg) | cfg->abort_mask | cfg->active_mask,
> +              chan_base + cfg->cs_reg);
>
>         /* wait for DMA to be aborted */
> -       while ((readl(chan_base + BCM2835_DMA_CS) & BCM2835_DMA_ABORT) && --timeout)
> +       while ((readl(chan_base + cfg->cs_reg) & cfg->abort_mask) && --timeout)
>                 cpu_relax();
>
>         /* Write 0 to the active bit - Pause the DMA */
> -       writel(readl(chan_base + BCM2835_DMA_CS) & ~BCM2835_DMA_ACTIVE,
> -              chan_base + BCM2835_DMA_CS);
> +       writel(readl(chan_base + cfg->cs_reg) & ~cfg->active_mask,
> +              chan_base + cfg->cs_reg);
>
>         /*
>          * Peripheral might be stuck and fail to complete
>          * This is expected when dreqs are enabled but not asserted
>          * so only report error in non dreq case
>          */
> -       if (!timeout && !(readl(chan_base + BCM2835_DMA_TI) &
> -          (BCM2835_DMA_S_DREQ | BCM2835_DMA_D_DREQ)))
> +       if (!timeout && !(readl(chan_base + cfg->ti_reg) &
> +          (cfg->s_dreq_mask | cfg->d_dreq_mask)))
>                 dev_err(c->vc.chan.device->dev,
>                         "failed to complete pause on dma %d (CS:%08x)\n", c->ch,
> -                       readl(chan_base + BCM2835_DMA_CS));
> +                       readl(chan_base + cfg->cs_reg));
>
>         /* Set CS back to default state and reset the DMA */
> -       writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
> +       writel(cfg->reset_mask, chan_base + cfg->cs_reg);
>  }
>
>  static void bcm2835_dma_start_desc(struct dma_chan *chan)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
>
> @@ -566,14 +721,15 @@ static void bcm2835_dma_start_desc(struct dma_chan *chan)
>
>         c->desc = to_bcm2835_dma_desc(&vd->tx);
>
> -       writel(c->desc->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
> -       writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
> -              c->chan_base + BCM2835_DMA_CS);
> +       writel(cfg->to_cb_addr(c->desc->cb_list[0].paddr), c->chan_base + cfg->cb_reg);
> +       writel(cfg->active_mask | cfg->cs_flags(c),
> +              c->chan_base + cfg->cs_reg);
>  }
>
>  static irqreturn_t bcm2835_dma_callback(int irq, void *data)
>  {
>         struct dma_chan *chan = data;
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         struct bcm2835_desc *d;
>         unsigned long flags;
> @@ -581,9 +737,9 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
>         /* check the shared interrupt */
>         if (c->irq_flags & IRQF_SHARED) {
>                 /* check if the interrupt is enabled */
> -               flags = readl(c->chan_base + BCM2835_DMA_CS);
> +               flags = readl(c->chan_base + cfg->cs_reg);
>                 /* if not set then we are not the reason for the irq */
> -               if (!(flags & BCM2835_DMA_INT))
> +               if (!(flags & cfg->int_mask))
>                         return IRQ_NONE;
>         }
>
> @@ -596,9 +752,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
>          * if this IRQ handler is threaded.) If the channel is finished, it
>          * will remain idle despite the ACTIVE flag being set.
>          */
> -       writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE |
> -              BCM2835_DMA_CS_FLAGS(c->dreq),
> -              c->chan_base + BCM2835_DMA_CS);
> +       writel(cfg->int_mask | cfg->active_mask | cfg->cs_flags(c), c->chan_base + cfg->cs_reg);
>
>         d = c->desc;
>
> @@ -606,7 +760,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
>                 if (d->cyclic) {
>                         /* call the cyclic callback */
>                         vchan_cyclic_callback(&d->vd);
> -               } else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
> +               } else if (!readl(c->chan_base + cfg->cb_reg)) {
>                         vchan_cookie_complete(&c->desc->vd);
>                         bcm2835_dma_start_desc(chan);
>                 }
> @@ -629,7 +783,7 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
>          * (32 byte) aligned address (BCM2835 ARM Peripherals, sec. 4.2.1.1).
>          */
>         c->cb_pool = dma_pool_create(dev_name(dev), dev,
> -                                    sizeof(struct bcm2835_dma_cb), 32, 0);
> +                                    sizeof(struct bcm_dma_cb), 32, 0);
>         if (!c->cb_pool) {
>                 dev_err(dev, "unable to allocate descriptor pool\n");
>                 return -ENOMEM;
> @@ -655,20 +809,16 @@ static size_t bcm2835_dma_desc_size(struct bcm2835_desc *d)
>         return d->size;
>  }
>
> -static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> +static size_t bcm2835_dma_desc_size_pos(const struct bcm2835_dma_cfg *cfg,
> +                                       struct bcm2835_desc *d, dma_addr_t addr)
>  {
>         unsigned int i;
>         size_t size;
>
>         for (size = i = 0; i < d->frames; i++) {
> -               struct bcm2835_dma_cb *control_block = d->cb_list[i].cb;
> -               size_t this_size = control_block->length;
> -               dma_addr_t dma;
> -
> -               if (d->dir == DMA_DEV_TO_MEM)
> -                       dma = control_block->dst;
> -               else
> -                       dma = control_block->src;
> +               struct bcm_dma_cb *control_block = d->cb_list[i].cb;
> +               size_t this_size = cfg->cb_get_length(control_block);
> +               dma_addr_t dma = cfg->cb_get_addr(control_block, d->dir);
>
>                 if (size)
>                         size += this_size;
> @@ -683,6 +833,7 @@ static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
>                                              dma_cookie_t cookie,
>                                              struct dma_tx_state *txstate)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         struct virt_dma_desc *vd;
>         enum dma_status ret;
> @@ -701,14 +852,8 @@ static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
>                 struct bcm2835_desc *d = c->desc;
>                 dma_addr_t pos;
>
> -               if (d->dir == DMA_MEM_TO_DEV)
> -                       pos = readl(c->chan_base + BCM2835_DMA_SOURCE_AD);
> -               else if (d->dir == DMA_DEV_TO_MEM)
> -                       pos = readl(c->chan_base + BCM2835_DMA_DEST_AD);
> -               else
> -                       pos = 0;
> -
> -               txstate->residue = bcm2835_dma_desc_size_pos(d, pos);
> +               pos = cfg->read_addr(c, d->dir);
> +               txstate->residue = bcm2835_dma_desc_size_pos(cfg, d, pos);
>         } else {
>                 txstate->residue = 0;
>         }
> @@ -761,6 +906,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
>         enum dma_transfer_direction direction,
>         unsigned long flags, void *context)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         struct bcm2835_desc *d;
>         dma_addr_t src = 0, dst = 0;
> @@ -775,11 +921,11 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
>         if (direction == DMA_DEV_TO_MEM) {
>                 if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>                         return NULL;
> -               src = c->cfg.src_addr;
> +               src = cfg->addr_offset + c->cfg.src_addr;
>         } else {
>                 if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>                         return NULL;
> -               dst = c->cfg.dst_addr;
> +               dst = cfg->addr_offset + c->cfg.dst_addr;
>         }
>
>         /* count frames in sg list */
> @@ -803,6 +949,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>         size_t period_len, enum dma_transfer_direction direction,
>         unsigned long flags)
>  {
> +       const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
>         struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>         struct bcm2835_desc *d;
>         dma_addr_t src, dst;
> @@ -836,12 +983,12 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>         if (direction == DMA_DEV_TO_MEM) {
>                 if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>                         return NULL;
> -               src = c->cfg.src_addr;
> +               src = cfg->addr_offset + c->cfg.src_addr;
>                 dst = buf_addr;
>         } else {
>                 if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>                         return NULL;
> -               dst = c->cfg.dst_addr;
> +               dst = cfg->addr_offset + c->cfg.dst_addr;
>                 src = buf_addr;
>         }
>
> @@ -862,7 +1009,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>                 return NULL;
>
>         /* wrap around into a loop */
> -       d->cb_list[d->frames - 1].cb->next = d->cb_list[0].paddr;
> +       cfg->cb_set_next(d->cb_list[d->frames - 1].cb,
> +                        cfg->to_cb_addr(d->cb_list[0].paddr));
>
>         return vchan_tx_prep(&c->vc, &d->vd, flags);
>  }
> @@ -923,10 +1071,7 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
>         c->irq_number = irq;
>         c->irq_flags = irq_flags;
>
> -       /* check in DEBUG register if this is a LITE channel */
> -       if (readl(c->chan_base + BCM2835_DMA_DEBUG) &
> -               BCM2835_DMA_DEBUG_LITE)
> -               c->is_lite_channel = true;
> +       d->cfg->chan_plat_init(c);
>
>         return 0;
>  }
> @@ -945,8 +1090,40 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
>                              DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
>  }
>
> +static const struct bcm2835_dma_cfg bcm2835_data = {
> +       .addr_offset = 0,
> +
> +       .cs_reg = BCM2835_DMA_CS,
> +       .cb_reg = BCM2835_DMA_ADDR,
> +       .next_reg = BCM2835_DMA_NEXTCB,
> +       .ti_reg = BCM2835_DMA_TI,
> +
> +       .wait_mask = BCM2835_DMA_WAITING_FOR_WRITES,
> +       .reset_mask = BCM2835_DMA_RESET,
> +       .int_mask = BCM2835_DMA_INT,
> +       .active_mask = BCM2835_DMA_ACTIVE,
> +       .abort_mask = BCM2835_DMA_ABORT,
> +       .s_dreq_mask = BCM2835_DMA_S_DREQ,
> +       .d_dreq_mask = BCM2835_DMA_D_DREQ,
> +
> +       .cb_get_length = bcm2835_dma_cb_get_length,
> +       .cb_get_addr = bcm2835_dma_cb_get_addr,
> +       .cb_init = bcm2835_dma_cb_init,
> +       .cb_set_src = bcm2835_dma_cb_set_src,
> +       .cb_set_dst = bcm2835_dma_cb_set_dst,
> +       .cb_set_next = bcm2835_dma_cb_set_next,
> +       .cb_set_length = bcm2835_dma_cb_set_length,
> +       .cb_append_extra = bcm2835_dma_cb_append_extra,
> +
> +       .to_cb_addr = bcm2835_dma_to_cb_addr,
> +
> +       .chan_plat_init = bcm2835_dma_chan_plat_init,
> +       .read_addr = bcm2835_dma_read_addr,
> +       .cs_flags = bcm2835_dma_cs_flags,
> +};
> +
>  static const struct of_device_id bcm2835_dma_of_match[] = {
> -       { .compatible = "brcm,bcm2835-dma", },
> +       { .compatible = "brcm,bcm2835-dma", .data = &bcm2835_data },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
> @@ -978,6 +1155,12 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>         u32 chans_available;
>         char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
>
> +        const void *cfg_data = device_get_match_data(&pdev->dev);
> +        if (!cfg_data) {
> +                dev_err(&pdev->dev, "Failed to match compatible string\n");
> +                return -EINVAL;
> +        }
> +
>         if (!pdev->dev.dma_mask)
>                 pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>
> @@ -998,6 +1181,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>                 return PTR_ERR(base);
>
>         od->base = base;
> +       od->cfg = cfg_data;
>
>         dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
>         dma_cap_set(DMA_PRIVATE, od->ddev.cap_mask);
> --
> 2.35.3
>
>

