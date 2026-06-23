Return-Path: <dmaengine+bounces-11743-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9tZZKNJXOmpO6gcAu9opvQ
	(envelope-from <dmaengine+bounces-11743-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 11:54:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35B6B5F6A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 11:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QvtppI88;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11743-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11743-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C6230B13F0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720ED367B86;
	Tue, 23 Jun 2026 09:50:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C2364028;
	Tue, 23 Jun 2026 09:50:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208213; cv=none; b=doKlCum7Lm4r4bZBDnwxY2ZdTDN7CaJGmLLXY5b6r+SDmdpZaSHyr/QFAEEQpScYsYJuazZp+6R60iYD3vZlrqv8gUU6Y+dyMhr+IMY79wJsCDuJOXN9+PRslS7TK+cYxaZnl6JXoOroXlhF3zGStJ3yX1xDbChPgUE6lGZljqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208213; c=relaxed/simple;
	bh=E8ME3jUr5NZJ1u/pCLY21u1GJkbr4nhtiz3fxeYF7rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHSh4JYD47TRMLUgw8W2kQaY7lfFM6DrNE32imFmM3Awt8R+T+7vUsoGsZyT8E7MGfsiKRxaNcCyQuIms97qEA/6aPyXFzWE7Ch5ClhTqN/iss1pLo2yYX61ExayMyGxDCtwh8h2TAwM9cbY9Dy2mYbEX1FnFgjLBBzWftfa18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvtppI88; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782208212; x=1813744212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E8ME3jUr5NZJ1u/pCLY21u1GJkbr4nhtiz3fxeYF7rU=;
  b=QvtppI88qA793xtjVD/0e6n+DaP8F5NoQ/F5NG9CRqw4OFhR4l4O2SJO
   mtZxekXnwny+9A6ETzF71bBgyoOnOHPiOHntZpbSX4oK02KByLVS6JX1I
   K5brzlDqGJf93Cr4tQLWxuA218Fu0MnL0pfyOl6a5xxWNw4/7I6pFUyjX
   McqVdAly8cp6u6FluqZZn5HeBnXJqqIPNJ2vf+CdWBgVLhQME1zEk2mmX
   zp1k7cWe18mtMvBvFYP1hIpSs2EOr6NpMDrta+c0iZ9e6ojUtQ/xKpNw5
   iWVcLxKuxQLUiazXN8s/HxlNrcZdSihgJewUlocIQ06a7xmAqDSi35IR7
   g==;
X-CSE-ConnectionGUID: dEyVXKGySiO63xN1G5I+cA==
X-CSE-MsgGUID: 5QhCHgioTxqLhUwt4EQEGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94336765"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="94336765"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:50:11 -0700
X-CSE-ConnectionGUID: IH26D8UmRLCopMGYbxH9Hw==
X-CSE-MsgGUID: 2DN7P0YPSxSLKcavwrDRcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245333747"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:50:08 -0700
Date: Tue, 23 Jun 2026 12:50:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajpWzimx-5jlczpp@ashevche-desk.local>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajmAP2nKzi2dPEVx@SMW015318>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11743-lists,dmaengine=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,analog.com,vger.kernel.org,kernel.org,metafoo.de,baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,analog.com:email,intel.com:dkim,intel.com:from_mime,ashevche-desk.local:mid,bootlin.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB35B6B5F6A

On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> > > > On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> > > > > On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > > > > > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > > > > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > > > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
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

> > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > >
> > > If memory have requirement for 32bytes, typical cache line length for
> > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > >
> > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> >
> > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > there... The code seems to use the dma bus width to match against PCM
> > formats supported and filter only the ones we can support (per dma cap).
> 
> if cap is one byte, it should support 8, 16, 24, 32, 64
> if cap is two byte, it should support 16, 32, 64
> if cap is 4 byte,  it only support 32 and 64.
> 
> Needn't mask each bit.

I think you missed the point completely. It's other way around. If the HW
supports say 32-byte bus width, one _might_ assume it supports lower sizes.

It's similar to what we have with MMIO. Some HW, for example, may only operate
with 32-bit accesses, while only transferring a single byte (8 bits).

> > If we only set the min, that means the PCM code all of the sudden only
> > supports one format and I'm not sure that should be always the case or
> > that we won't break any user.
> >
> > I mean the dmaengine src/dst_addr_widths must be a mask for a reason,
> > no?

> > > > I would say the
> > > > array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
> > > > complicated at all so I would just not risk it.
> > >
> > > > (we can also have one liner helpers for the case where only width is
> > > > set).

> > > > > > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > > > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > > > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
With Best Regards,
Andy Shevchenko



