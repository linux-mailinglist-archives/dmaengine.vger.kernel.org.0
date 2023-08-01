Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6176A9E0
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjHAHU4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHAHUz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 03:20:55 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546EDA
        for <dmaengine@vger.kernel.org>; Tue,  1 Aug 2023 00:20:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C0C4FF802;
        Tue,  1 Aug 2023 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690874451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qDPxUkBRSC6g6QGK/oFvOXYQ+Yax+tO5DnQhHJWMZ0=;
        b=dDjQ539jZysxC1eA+8Pos0njyYJu6mHKm6SDSX7bPM5zqrDPUQ341nD8ZgHSyQ8ZEMqK0Q
        0/+EeZhyjGzDcPXevfoCr27NdsT6n6MO2brEQp1DKT1SjUAu3OFUwXrcLaU8B6+dkCyUBe
        QaCyXKzA7ELBbvyiLnonWKtlAyQOa6Im4LmziahqxPo1I5o9z4pVyzscQaXFyjkoCtXY/F
        nX1SCMQ3spl73yoCXpnTArlxvYDskIIQpxWyO7a4NmLuzJrQ54MyEbIx0u2UA9dkoejm0M
        GoSgBwVxhw5ZYhiNcE0zNX7UceLhuOIKL7NNADDhOZv7ie3OvtfvCjm7Nbm4oQ==
Date:   Tue, 1 Aug 2023 09:20:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Max Zhen <max.zhen@amd.com>,
        "Sonal Santan" <sonal.santan@amd.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/4] dmaengine: xilinx: xdma: Support cyclic transfers
Message-ID: <20230801092048.326d0ee1@xps-13>
In-Reply-To: <e6535253-e298-1f42-3363-760955953a22@amd.com>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
        <20230731101442.792514-5-miquel.raynal@bootlin.com>
        <e6535253-e298-1f42-3363-760955953a22@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lizhi,

> > + * xdma_prep_dma_cyclic - prepare for cyclic DMA transactions
> > + * @chan: DMA channel pointer
> > + * @address: Device DMA address to access
> > + * @size: Total length to transfer
> > + * @period_size: Period size to use for each transfer
> > + * @dir: Transfer direction
> > + * @flags: Transfer ack flags
> > + */
> > +static struct dma_async_tx_descriptor *
> > +xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t address,
> > +		     size_t size, size_t period_size,
> > +		     enum dma_transfer_direction dir,
> > +		     unsigned long flags)
> > +{
> > +	struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
> > +	struct xdma_device *xdev =3D xdma_chan->xdev_hdl;
> > +	unsigned int periods =3D size / period_size; =20

> What if size is not multiple of period_size?

Can this really happen? I would have expected a bug if size was not a
multiple of period_size, because the headers explicitly tell that we
should expect an interrupt after each period and we should loop over
when we reach the last one. This makes it very impractical to handle
the situation you mention.

> > +	struct dma_async_tx_descriptor *tx_desc;
> > +	u64 addr, dev_addr, *src, *dst;
> > +	struct xdma_desc_block *dblk;
> > +	struct xdma_hw_desc *desc;
> > +	struct xdma_desc *sw_desc;
> > +	unsigned int i;
> > +
> > +	/*
> > +	 * Simplify the whole logic by preventing an abnormally high number of
> > +	 * periods and periods size.
> > +	 */
> > +	if (period_size > XDMA_DESC_BLEN_MAX) {
> > +		xdma_err(xdev, "period size limited to %lu bytes\n", XDMA_DESC_BLEN_=
MAX);
> > +		return NULL;
> > +	}
> > +
> > +	if (periods > XDMA_DESC_ADJACENT) {
> > +		xdma_err(xdev, "number of periods limited to %u\n", XDMA_DESC_ADJACE=
NT);
> > +		return NULL;
> > +	}
> > +
> > +	sw_desc =3D xdma_alloc_desc(xdma_chan, periods, true);
> > +	if (!sw_desc)
> > +		return NULL;
> > +
> > +	sw_desc->periods =3D periods;
> > +	sw_desc->period_size =3D period_size;
> > +	sw_desc->dir =3D dir;
> > +
> > +	if (dir =3D=3D DMA_MEM_TO_DEV) {
> > +		dev_addr =3D xdma_chan->cfg.dst_addr;
> > +		src =3D &addr;
> > +		dst =3D &dev_addr;
> > +	} else {
> > +		dev_addr =3D xdma_chan->cfg.src_addr;
> > +		src =3D &dev_addr;
> > +		dst =3D &addr;
> > +	}
> > +
> > +	dblk =3D sw_desc->desc_blocks;
> > +	desc =3D dblk->virt_addr;
> > +	for (i =3D 0; i < periods; i++) {
> > +		addr =3D address;
> > +
> > +		/* fill hardware descriptor */
> > +		desc->bytes =3D cpu_to_le32(period_size);
> > +		desc->src_addr =3D cpu_to_le64(*src);
> > +		desc->dst_addr =3D cpu_to_le64(*dst);
> > +
> > +		desc++;
> > +		address +=3D period_size;
> > +	}
> > +
> > +	tx_desc =3D vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);
> > +	if (!tx_desc)
> > +		goto failed;
> > +
> > +	return tx_desc;
> > +
> > +failed:
> > +	xdma_free_desc(&sw_desc->vdesc);
> > +
> > +	return NULL;
> > +}
> > +
> >   /**
> >    * xdma_device_config - Configure the DMA channel
> >    * @chan: DMA channel
> > @@ -583,7 +698,36 @@ static int xdma_alloc_chan_resources(struct dma_ch=
an *chan)
> >   static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cook=
ie_t cookie,
> >   				      struct dma_tx_state *state)
> >   {
> > -	return dma_cookie_status(chan, cookie, state);
> > +	struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
> > +	struct virt_dma_desc *vd;
> > +	struct xdma_desc *desc;
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +	unsigned int period_idx;
> > +	u32 residue =3D 0;
> > +
> > +	ret =3D dma_cookie_status(chan, cookie, state);
> > +	if (ret =3D=3D DMA_COMPLETE || !state) =20
>
> probably do not need to check state. Or at least check before calling dma=
_cookie_status.

Good idea.

> > +		return ret;
> > +
> > +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> > +
> > +	vd =3D vchan_find_desc(&xdma_chan->vchan, cookie);
> > +	if (vd)
> > +		desc =3D to_xdma_desc(vd);
> > +	if (!desc || !desc->cyclic) { =20
>
> desc is un-initialized if vd is NULL.

Yes, handled in v2.

> > +		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> > +		return ret;
> > +	}
> > +
> > +	period_idx =3D desc->completed_desc_num % desc->periods;
> > +	residue =3D (desc->periods - period_idx) * desc->period_size;
> > +
> > +	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> > +
> > +	dma_set_residue(state, residue);
> > +
> > +	return ret;
> >   } =20
> >   >   /** =20
> > @@ -599,6 +743,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
dev_id)
> >   	struct virt_dma_desc *vd;
> >   	struct xdma_desc *desc;
> >   	int ret;
> > +	u32 st; =20
> >   >   	spin_lock(&xchan->vchan.lock);
> >   > @@ -617,6 +762,19 @@ static irqreturn_t xdma_channel_isr(int irq, v=
oid *dev_id) =20
> >   		goto out; =20
> >   >   	desc->completed_desc_num +=3D complete_desc_num; =20
> > +
> > +	if (desc->cyclic) {
> > +		ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,
> > +				  &st);
> > +		if (ret)
> > +			goto out;
> > +
> > +		regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_STATUS, st); =20
>=20
> What does reading/writing channel status register do here?

It clears the status register to allow the next interrupt to trigger.

Thanks,
Miqu=C3=A8l
