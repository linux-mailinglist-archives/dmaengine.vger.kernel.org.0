Return-Path: <dmaengine+bounces-11582-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ie5JcWsMmoJ3gUAu9opvQ
	(envelope-from <dmaengine+bounces-11582-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 16:18:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B2369A7B5
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 16:18:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nxJqk1gg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11582-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11582-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F22BF301D530
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC07A4418F0;
	Wed, 17 Jun 2026 14:18:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A1449EA9
	for <dmaengine@vger.kernel.org>; Wed, 17 Jun 2026 14:18:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705903; cv=none; b=Idt9mLIeXRmdv25p0fsGRcgJFCYb41lBirX0vzLCNYytLgilDCd/OwCP8CnkD733euX7NslKVuDatMwggeFmI0Br6KMLlhFDJZHC8i61Eh9DbWQo92UJZmZ9SjeVB6o0RNIxmWKQZjhL+ktw3/LRFgCubcA+SMmstb/UfTtkV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705903; c=relaxed/simple;
	bh=sA+Tle1vs414zE4TCmYbF75Vdjowlx7Ma0delr9FXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHUNUqvm6R4WPck+H/TvfnhEEmdzAV56wiTSxgbabpikyAeYP3uf+FGEDuIhCc/TiQR7RknVij5HDEKsDCTlkYfxZ31jVIZnoBFtCifa0W5orDsEJGu/ZNeMBmgIi4bNldj7mtT6Z5mevB4Sp4nlv6SlrsqOpuIb6aPrtyiRlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxJqk1gg; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4905529b933so58227295e9.0
        for <dmaengine@vger.kernel.org>; Wed, 17 Jun 2026 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781705900; x=1782310700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQSROIE/nRw8mnMESq2FVi6xdwggcJcKAlPZBkdjBkU=;
        b=nxJqk1gg1IBm8sEPQ7J9m232EoQryIGgOJlkmTp3wI5WUw3Hi0cQmRkGahVfT/aN4Y
         WqEVyI3RFX1C3RFmEwmakQXt+lapvhpL31BZDMWrxwOFt9bD8O0bH3z29kAN9a9Gd+9X
         NBLguU/UhPIA7EdzXqpLvQ2r+cgoSVTcB1WAzjeE5RAEbQedHusF9p8VzgEnA+z99ngH
         x1YC06xaOM7nbaASwMov4HfQwrApmCBQl65gtfAe8DnZmwN1mCSxL6Zf2vwiAeuGo5zY
         aKHsDk601OcwYJx0O42b/sF2D2j0bkDUpYqfJwREKKUDx5rFjXjjDmnnJGCkqdvd0uon
         vMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705900; x=1782310700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQSROIE/nRw8mnMESq2FVi6xdwggcJcKAlPZBkdjBkU=;
        b=Zlyrl2CgCF7jW+6LVBcDwieX8bc8njMWLQ0ddPU5pez/nyTQjhE3lEpDXOWTy86nJO
         kPYKpEa4470bz3QXjPxEg2209IETbc8LWmaHmSNAtJBpL6jDOjE/i7oq//kdCBuIN7oB
         qvQTw1FPZWGtEGo7ut+I1nwI2yu3BTCJqajaxCcogWTjf+qhFcD7NohI9lFpOppGFdgB
         /1kjPt+401cGJpj71JYExm+WF7fqhoPY3SYnihihtrJsBYyPN85oqH4XeLhwzt6HxOOc
         FzJnzgv5SLDXnmRj2RQxSm2uizFX657O6eT4qi7OE/ivxSiEFLTOh01SgwsMJFqdLaZV
         9uQg==
X-Forwarded-Encrypted: i=1; AFNElJ8nC3UYHo+3Pb0yIIteT4554kBaQn/QTAvTc0VVlqwaAZGhVcYlEJseJbHVcxmCWQg1vHwhg8JEVNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3Zs8r6dMlLN4BVGqgiJLJrIKGIKUUA6+71owgrj19RQz0g9R
	bqPGF0RIzKPqBfS6rnUDikXctiDsMPM1Khle1kcUqmeISlpX6eiTQKkc
X-Gm-Gg: Acq92OHPrffizXiL0TDyMgfONN53l8Zyq8pml+SxdRzV4qWn967s7CKua6wpGOckTKm
	+VC3k9ek0wCx1ZpfdbyBa+A8fy/uucTEP4Cfl+3Nb+axqi9wqeGuCbiotcvTfhubj4cm7Op3qwZ
	+B/jjlxqM5q1TY+/GplsCwr5L41WQu17gyhpWH6o3/FgAjpjWB5OTfA+H0/bCm+XlRD6So7QZww
	3QrLJIiY+44nNqLyAsVE11k/wAeW5TLxWTcQcZVyu6Ktr3VEscaIeWkr6/+w+OIQuXI+nD5C7wC
	jmcixzhdK47KblzXYV4r60V6wRitPgB/HtyybKXwGmyQB0bDAxiKSJIsTLOUaB51NMPI4XEdmOu
	RMUWkZCodF4MKZSZdkLgUj4+sYa8H1EoVfhWduiLq8K5eg7HxN0e2il0SAHsnd3/MsWiURYvTPV
	1UxEO0
X-Received: by 2002:a05:600c:4e02:b0:490:c2a3:1781 with SMTP id 5b1f17b1804b1-492333f7765mr73033755e9.34.1781705899755;
        Wed, 17 Jun 2026 07:18:19 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm287081775e9.14.2026.06.17.07.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:18:19 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:19:20 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 0/3] dmaengine: Support address bus widths of 32
 bytes and above
Message-ID: <ajKqOaDcmGbSSap1@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <ajJvouBANqhVaHXJ@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajJvouBANqhVaHXJ@ashevche-desk.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11582-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@intel.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86B2369A7B5

On Wed, Jun 17, 2026 at 12:57:54PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 04:40:51PM +0100, Nuno Sá via B4 Relay wrote:
> > The DMA engine slave capabilities advertise the supported source and
> > destination bus widths in src_addr_widths / dst_addr_widths. These are
> > plain u32 bitmasks where a set bit's position equals the corresponding
> > enum dma_slave_buswidth value, e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
> > bit 4.
> > 
> > The consequence is that widths of 32 bytes and above cannot be
> > represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> > 32, 64 and 128, which simply do not fit in a u32. Hardware with wider
> > data paths is becoming common, so we need a representation that can
> > express these widths while still using enum dma_slave_buswidth.
> > 
> > This series switches the masks to bitmaps that span the full enum
> > range. Because there are many producers (DMA controllers) and a number
> > of consumers spread across the tree, converting everything in one go is
> > not realistic. To allow an incremental migration, the legacy u32 fields
> > are kept alongside the new bitmaps:
> > 
> > - producers set the bitmap via the new dma_set_{src,dst}_addr_mask()
> > helpers, which also mirror the low 32 bits back into the legacy u32;
> > - legacy producers that still assign the u32 directly keep working, and
> > dma_get_slave_caps() folds such a u32 into the bitmap it returns, so
> > new consumers always see a complete bitmap;
> > - consumers can read either the legacy u32 or the new bitmap during the
> > transition.
> > 
> > The axi-dmac controller and the IIO dmaengine buffer are converted as
> > examples of a producer and a consumer. And this actually fixes a very
> > open coded path to undefined behavior in the axi-dmac driver and
> > possibly others.
> > 
> > The end goal is to convert every producer and consumer, then drop the
> > legacy u32 src/dst_addr_widths fields and rename the *_mask members.
> > I cannot commit to a timeline for that conversion (it touches a lot of
> > drivers across several subsystems), but I do intend to see it through.
> > 
> > Sending as RFC mainly to agree on the approach!
> 
> I have another idea. Why not having 8-bit mask for power-of-two and 8-bit mask
> for non-standard ones?
> 
> So, u8 power_of_2_mask represents the respective sizes directly as ORed values
> and u8 non_standard_mask (only to cover 3, 5, 6, and 7) does the original
> approach for it, id est ORed BIT():s of the sizes? And yes, I understand that
> it's not so KISS as above from data type point of view, but I think wei should
> never need to have a heavy bitmap() API calls just for them.

Well, that looks like much more disruptive than what we have now. Might
also make the transition not so simple. I'm also not too worried about
the heavy bitmap() as I don't think we need to handle this at any
fastpath. I think this is handled either in probe or at some preparatory
step, so not sure the churn of not doing it simpler is justifiable.

So personally, I'm not that keen in changing the approach unless Vinod
or Frank really ask for it.

- Nuno Sá

> 
> The whole exercise seems due to DMA_SLAVE_BUSWIDTH_3_BYTES. and we have less
> than dozen drivers that use it.
> 
> > I'm also not sure if the dma_slave_caps_get_{src,dst}_width_min() accessors
> > are worth having? Their purpose is purely to keep consumers from touching
> > the representation directly, so that the eventual u32 removal + mask
> > rename is a no-op for consumers. The alternative is to let consumers use
> > the bitmap directly (find_first_bit()/test_bit()/etc.) and just delete the
> > u32 members at the end. I mean, now we do have a bitmask so the _mask
> > suffix can of makes sense.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

