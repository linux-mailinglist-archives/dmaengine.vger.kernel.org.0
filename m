Return-Path: <dmaengine+bounces-11744-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDZCGWNcOmpW7AcAu9opvQ
	(envelope-from <dmaengine+bounces-11744-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 12:13:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2C6B6253
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 12:13:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=n5Mw18MU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11744-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11744-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3F2C300A10D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50D0370D65;
	Tue, 23 Jun 2026 10:13:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1836F90C
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 10:13:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209632; cv=none; b=XZ9/X6cupdbS4T0aX6KVcEBEEDA7n2tJKK2eYEmvgVLG/++5BeOCZhF3jvrOYVtvj7w7e0xLf0rdJgVnWS8MIAb6ZusDtlyHFnwBy9UIsHl3n038dQI/PgOnbg6ynXfO8YXFOBN06OYiomzuUSULHL2GzrjKDsFLzUuH9eRObP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209632; c=relaxed/simple;
	bh=tnl7GLt1lMnQdAToYGCWBnvZQISBDvAS4IfsxYwkecQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUSNI6YQfiI/X4YgONiHBY4Ny4deh81wgzFX28BoqFB7eUSMvAjqTI5sfjCNgXbr3SyFE2T7+oETIQiOLRw++XPRq7SeAZQzDyhZwCHsY6Pw1rUQ1XOGgrD4YPvIpPYEkAPkDykZtkvUHTDZo49gABGVbtR9ITQnsCPtiYH82XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5Mw18MU; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3738526f8f.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782209629; x=1782814429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXlxUZFPy1UXDAGOZwdnhyv0lKMkiBKFrADH8UIznYk=;
        b=n5Mw18MUejCdeyf9+M7tEe59V9G3DR/txDtA5mducpQn5dbzWhp+3VxTbhXQHNk9rR
         bbFMHdOVKWScZURIjvMCRexkS9gVAkA2T7L+j63/a23fpR79vXmCzrevL3AxnnjLyJxp
         GTnLA0swYcDj1wKu4KiAXI6P3L+P7dtbVkjtxMN1lhP1MmW3J/E8eNBhInVEAmVb4y3o
         GvKfBDfJP+5OE421hdT5FdRg1NX2OM922jFjahCYinEmVT08+1aIeag5QAQyj7uT3Ppu
         PrTfT8mo4keNTd2tNdJqecxj4/3KObx9fdKwFPbzNnIG4Sgu50DYLwverxUv2ef0/CYs
         AMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209629; x=1782814429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXlxUZFPy1UXDAGOZwdnhyv0lKMkiBKFrADH8UIznYk=;
        b=SZZJ+44qGFG/7pCI3ekqi2zsY+smDgX/4HTlvPZ1dJdTMl8FT5jaOoIuRLz6D3XvBS
         JFJPU399M5B8CCGvgpnmyVmI7hVts+eVPCXxnAQj7dd3eTXkLol7ynmFpc7FHt9wFJwZ
         pNb9Wo6N2lEApGFuFKR7QuGAJ9sYcXiONUss1An03uJS56X0mwv5GNo/tUVLxG3ouELO
         L8NyVqpb/nDsUkBHiHIUhv5uP9EwVx2kEYHPbxL35n3Z+iDPNHKwBfUVIKgoziKcVp6x
         SMDVyRbt/vQJTfwZ6JCqy3OY/sv4hNXRqjsDeyEqwEuUFA4+u9GBZGf3PcV8MZHD41Lr
         praw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/NfCjlr6pmtyEGR37OygFDVAYGnGvdH2sqrZXN2BbiAgzeRc/JS/PpF2bdWIv/Wyukzt/8ob++K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzXWLL1dyqY4g5i7vTfuAcOiKV2AlvATD7p1klMbCbasj+PPP
	6iOst7oykGGH38C5Z/Sj1NI2uLZfN+f2Y532FzDT6mGdD+i3Tbnlx7bF
X-Gm-Gg: AfdE7cnDJO3P4PVJDDZNS9cvCjsfMYWnHxZ+OxASBU2u5IzoRrNyDpQy51EYBI2or8Z
	jBOSFEn6Iiu3RSQ0+CqdWniXeOTX979SFNVCV7zVdsdtK0fOYBNznhTTT0uGvXHkQY6Bt07mShK
	4OkhHby3x2wNQGL1Ju782JPUEX+k5B2xFPrcdXG3eayn/PJSCkdN2ThK2bi9cUckaGiR0HoAvo0
	lo533BIm5cptT522EBw+E1xdcIVWHWDrbP/YvZSiI2l/bWVkB4gQDd4amBvWLsumWbAUfU5A90/
	+39kCrwNV/FC0Zp9ac4Vx/SKy5G8bNyqHLMLm6/Q+NI9lv4ftQv8gm57GfSkzA/APmvqq36kRxN
	+jbpEjb2yugdvyStZOnlrEIrhbAlJwJyh+qaVsx3MlAmUCmFCpdO3syPYaV1yjkw8k6F0s53lc5
	YkO6fx
X-Received: by 2002:adf:f6cd:0:b0:45e:ec17:430a with SMTP id ffacd0b85a97d-46507102de3mr25581996f8f.11.1782209629222;
        Tue, 23 Jun 2026 03:13:49 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4ee6sm33129868f8f.5.2026.06.23.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:13:48 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:14:51 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajpYvzlHSPiJRvnX@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajmAP2nKzi2dPEVx@SMW015318>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11744-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:url,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0E2C6B6253

On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> > > > On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> > > > > On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > > > > > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > > > > > [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > > >
> > > > > > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > > > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > > > > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > > > > >
> > > > > > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > > > > >
> > > > > > > > > Advertise the source and destination bus widths through the new
> > > > > > > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > > > > > > BIT() mask. This moves the driver onto the representation that can
> > > > > > > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > > > > > > be removed once all users are converted.
> > > > > > > > >
> > > > > > > > > While at it, give the channel width members their proper
> > > > > > > > > enum dma_slave_buswidth type.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > > > > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > > > > > index d47ff27e1408..19c258d511ca 100644
> > > > > > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > > > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > > > > > > >         struct list_head active_descs;
> > > > > > > > >         enum dma_transfer_direction direction;
> > > > > > > > >
> > > > > > > > > -       unsigned int src_width;
> > > > > > > > > -       unsigned int dest_width;
> > > > > > > > > +       enum dma_slave_buswidth src_width;
> > > > > > > > > +       enum dma_slave_buswidth dest_width;
> > > > > > > > >         unsigned int src_type;
> > > > > > > > >         unsigned int dest_type;
> > > > > > > > >
> > > > > > > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > > > > > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > > > > > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > > > > > > >         dma_dev->dev = &pdev->dev;
> > > > > > > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > > > > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > > > > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > > > > > > +       if (ret)
> > > > > > > > > +               return ret;
> > > > > > > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > > > > > > +       if (ret)
> > > > > > > > > +               return ret;
> > > > > > > >
> > > > > > > >
> > > > > > > > This patch is okay.  I think most system only set one width once, do we
> > > > > > > > really need pass down arrary.
> > > > > > >
> > > > > > > I think so. See:
> > > > > > >
> > > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> > > > > > >
> > > > > > > And likely there are more. To fully support all widths I'm not seeing
> > > > > > > any other obvious way.
> > > > > >
> > > > > > I need more time to understand why need src_addr_width, which looks like
> > > > > > address alignmenet requirment.
> > > > > >
> > > > > > If it is address alginment requirement, only need lowest one, like suport
> > > > > > byte, must be support other alignments.
> > > > > >
> > > > > > if it is total address space, which should be controller by dma-ranges.
> > > > >
> > > > > I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
> > > > > (I think src/dsk_bus_width is more reasonable). because the name is the
> > > > > same as dma_slave_cfg, it is easy to cause confuse.
> > > >
> > > > No complains for the new naming. If everyone agrees on that, I'm fine.
> > > >
> > > > >
> > > > > So far, still have not seen user case, which more than 8byte for cap.
> > > >
> > > > On the consumer side the IIO dmaengine will use more than that (we have
> > > > designs for that - that's how I found the issue). But yeah, it just uses the
> > > > min value (it is just that dma-axi-dmac only sets one).
> > > >
> > > > >
> > > > > Add it should only set min value should be enougth, if update only user
> > > > > sound/core/pcm_dmaegine.c
> > > > >
> > > >
> > > > Not sure how that works on the pcm_dmaegine.c. It sets more 'hw->formats' than the minimum.
> > > > And IIRC, this ends up being configurable from userspace so we might
> > > > really want all the available options.
> > > >
> > > > Hence, given that we do need more than 32bytes and some users (seems
> > > > like 1 only) do look for more than the minimum width,
> > >
> > > If FIFO space require 32bytes data bus width,  4Bytes DMA engine should be
> > > match requirmment, cap just help filter dma channel.
> >
> > I'm not sure I'm getting your point but on dma caps, the src/dst addr
> > widths is a mask. So for 32bytes widths, we need to set bit 32 (which
> > currently is an open path for undefined behavior)
> 
> Bitmask does make sense, I don't think DMAEngine only support 32byte bus
> width for slave FIFO.
> 
> If support 4Byte, it native supportted any N*4Byte.
> 
> So needn't bit mask to indicate all support bytes.


> 
> > >
> > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > >
> > > If memory have requirement for 32bytes, typical cache line length for
> > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > >
> > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > >
> >
> > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > there... The code seems to use the dma bus width to match against PCM
> > formats supported and filter only the ones we can support (per dma cap).
> 
> if cap is one byte, it should support 8, 16, 24, 32, 64
> if cap is two byte, it should support 16, 32, 64
> if cap is 4 byte,  it only support 32 and 64.

Well, Now I see your point but not exactly. Because we do have

DMA_SLAVE_BUSWIDTH_3_BYTES

and it might be used by the pcm_dmaengine code,

There are also some controllers that set it. But it looks like all that
set it also set 1byte.

So your suggestion might still hold and work but I'm not too convinced
that having the array complicates things that bad when compared with the
risk of breaking existing code.

- Nuno Sá

> 
> Needn't mask each bit.
> 
> Frank
> 
> > If we only set the min, that means the PCM code all of the sudden only
> > supports one format and I'm not sure that should be always the case or
> > that we won't break any user.
> >
> > I mean the dmaengine src/dst_addr_widths must be a mask for a reason,
> > no?
> >
> > - Nuno Sá
> >
> > > Frank
> > >
> > > > I would say the
> > > > array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
> > > > complicated at all so I would just not risk it.
> > >
> > >
> > >
> > > >
> > > > (we can also have one liner helpers for the case where only width is
> > > > set).
> > > >
> > > > - Nuno Sá
> > > >
> > > > >
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > >
> > > > > > > - Nuno Sá
> > > > > > > >
> > > > > > > > Frank
> > > > > > > >
> > > > > > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > > > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > > > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.54.0
> > > > > > > > >
> > > > > > > > >

