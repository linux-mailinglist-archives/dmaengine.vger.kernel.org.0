Return-Path: <dmaengine+bounces-11718-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SrjpBfv/OGrHlAcAu9opvQ
	(envelope-from <dmaengine+bounces-11718-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 11:27:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7216AE31B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 11:27:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZhV9bJFz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11718-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11718-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 954213001040
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B323D7F0;
	Mon, 22 Jun 2026 09:25:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3F3672A9
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 09:25:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120343; cv=none; b=tpvLO7pQ1Ixsyjirbn/a2kvpm2dOuMA0iLlXysw9agCujKsinKUGvzCbOeYZSqL30xse2UwgIcv+GpTmIAhYnGfecb45haNFMjdz+3G3p2Rp8uDsOkSyded9UMJ/5bPcH0NILMCD9r479rWNPMOTgZETK02OiJBsyNC1PH1K4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120343; c=relaxed/simple;
	bh=Y6Td5KWnNW2jhqaxsvjarPPHJA2xevanPTsc7EJGaYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9HHdNjMKVKVWhm0wj8qjN09Kgw5uGUPejFqSlN/0Bl9Ggv7YjqnbEKSKD9mseqADcqTlepFpB7A5o5ZBqkCzGtzDaJnOCoPVak2eLkRHhJwMIGq2u59i4R+gpobccPjvHnbcJXx7Qgsp0ohfaFirnFA9ytm1IMtyW3zK7On4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhV9bJFz; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso2018057f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782120339; x=1782725139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gTNaglsuT50Ihg7ladjK7v55JZCOz4iDdCHaBxElsvI=;
        b=ZhV9bJFz23ATLnYEgV31NnU5D8TJtb9IDh6fMY6vEyLv9AVPE0CISgBkSmx8sIkuRO
         xan9b5zyJo7SiHVvoAGGU5vMYJbtEGiYTGK6WVJ+MCfOQu0aqDTqQOKqLxEIdETdKbBW
         5vpFI8HoO4hLrXCslsIRALPKRGVLc0ljTv/N+/KzwshGBeayU2WX7ItYaitXWz/zDmCX
         nnENLIQZ8EKhZj53pxvVwEWLelZS40vDBuy2NxpjwyVHwJDV3+W3zDMVse7rcBBu8UYb
         6qlJJlUgMxe+2BV+7c5nmdJobF4GdUlisxoR6/+eUVo85t8/RUTh5LhaHyNQQe8QbnWc
         uNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782120339; x=1782725139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTNaglsuT50Ihg7ladjK7v55JZCOz4iDdCHaBxElsvI=;
        b=QEHvWr1GPkrR317gY8t2fJTLo62SRJfuD0RWPr0epbkykFLQ0pudD07/k7eSASpW4M
         zrXAj647gtwMVjjNu4Ia9gS+tv3275g6u/48aR9Vy1AOJrBn4X3zxLELZydPa3wDFvuI
         dFCX1zocL/U41BCjn7dLtREaXhbLpt6NX1/87k6Jm12qvBjU3V7FFVxo3yVwHH6/B7zu
         wDidQzDh8Eiqgoosiet68yJjOSDUhgtUOfgTm6IRU8x9RkbHTJ4shWKCS3Jb5FtcAiZq
         qAKlCC3jHaPGPDzkfHBQHnub4Kc3VNqysZMbUblsujlRJZCl9VAFPnWGwC9kPyNpqy2h
         aD7A==
X-Forwarded-Encrypted: i=1; AHgh+RojkKGLu8cURCRZQt7iDu1GKprPpqAawAmR4x5mzKg0EQIH/2NQNuwXM3GPGXwXLIQNnW00I3o39Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3WR6fA2+LRRve89yJTwlXYvorHhdYWcGJlaaQ+e3YkmPkie0e
	IbdVaMlTynsc+eqcMu+RZYIXVoI1Vy46JExDj/s1Xhp7mrs4s7cgyxDm
X-Gm-Gg: AfdE7cmcKpqOanQg0Nb89HqDuYpRw+ZvaIqySgo3aIdkYyABkNHIErnijq39Jt/DVXM
	nkq+m1SW95hJzYLqXhT2bggRokpI6KXy+NlEINc7P8Qx7P0qfdMG1D1N1kW5YLoc7HOFE2nmWcJ
	GQD3cZ/c/jTIqgaxwag9GmtjNwbPWvC/b7qo8FtEzbLoq4+4G+Pd8TdNWdujMRea4o0+65zA1YO
	yDDgOMsabPKjZr3XsBDC/0CfmVQCPgP7kNP3czzlAyDwt6iZJxth9isXyq7JpJyKVyZiTELyu9l
	GdaAXkGuUIR5DcJWzQUql3u0nRXTz2v68/MgLpRVQjAtonnmoEzvA8I4RnLKz4ROYGk5Bav2ewc
	tz8gBTF/BV42mclEE8hPa+caNaxUIE5A3Wm0ToeXcwmPPrXNtdEvwQxzhsirvyuCW5bailga4JF
	lhpzoK
X-Received: by 2002:a05:6000:606:b0:460:e0f:8d19 with SMTP id ffacd0b85a97d-4656d643cbfmr16475957f8f.9.1782120338802;
        Mon, 22 Jun 2026 02:25:38 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57b8asm25223370f8f.26.2026.06.22.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:25:38 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:26:41 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajj8AhN1YC3uvuLb@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11718-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D7216AE31B

On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > >
> > > > > Advertise the source and destination bus widths through the new
> > > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > > BIT() mask. This moves the driver onto the representation that can
> > > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > > be removed once all users are converted.
> > > > >
> > > > > While at it, give the channel width members their proper
> > > > > enum dma_slave_buswidth type.
> > > > >
> > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > ---
> > > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > index d47ff27e1408..19c258d511ca 100644
> > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > > >         struct list_head active_descs;
> > > > >         enum dma_transfer_direction direction;
> > > > >
> > > > > -       unsigned int src_width;
> > > > > -       unsigned int dest_width;
> > > > > +       enum dma_slave_buswidth src_width;
> > > > > +       enum dma_slave_buswidth dest_width;
> > > > >         unsigned int src_type;
> > > > >         unsigned int dest_type;
> > > > >
> > > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > > >         dma_dev->dev = &pdev->dev;
> > > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > >
> > > >
> > > > This patch is okay.  I think most system only set one width once, do we
> > > > really need pass down arrary.
> > >
> > > I think so. See:
> > >
> > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> > >
> > > And likely there are more. To fully support all widths I'm not seeing
> > > any other obvious way.
> >
> > I need more time to understand why need src_addr_width, which looks like
> > address alignmenet requirment.
> >
> > If it is address alginment requirement, only need lowest one, like suport
> > byte, must be support other alignments.
> >
> > if it is total address space, which should be controller by dma-ranges.
> 
> I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
> (I think src/dsk_bus_width is more reasonable). because the name is the
> same as dma_slave_cfg, it is easy to cause confuse.

No complains for the new naming. If everyone agrees on that, I'm fine.

> 
> So far, still have not seen user case, which more than 8byte for cap.

On the consumer side the IIO dmaengine will use more than that (we have
designs for that - that's how I found the issue). But yeah, it just uses the
min value (it is just that dma-axi-dmac only sets one).

> 
> Add it should only set min value should be enougth, if update only user
> sound/core/pcm_dmaegine.c
> 

Not sure how that works on the pcm_dmaegine.c. It sets more 'hw->formats' than the minimum.
And IIRC, this ends up being configurable from userspace so we might
really want all the available options.

Hence, given that we do need more than 32bytes and some users (seems
like 1 only) do look for more than the minimum width, I would say the
array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
complicated at all so I would just not risk it.

(we can also have one liner helpers for the case where only width is
set).

- Nuno Sá

> 
> >
> > Frank
> >
> > >
> > > - Nuno Sá
> > > >
> > > > Frank
> > > >
> > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > > >
> > > > > --
> > > > > 2.54.0
> > > > >
> > > > >

