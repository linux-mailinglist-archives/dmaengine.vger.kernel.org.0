Return-Path: <dmaengine+bounces-4710-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D830A5D919
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 10:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861AB3B2489
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DA8239085;
	Wed, 12 Mar 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5NkTz2T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2A2F43;
	Wed, 12 Mar 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771091; cv=none; b=n90zRJqHaGwFp84dsyyKfTAwKVKc57qLX3FZOzH/AcZn0cHI3lnQ96EtVB8B9vO6D7D62vQB0eP4M8acA9oExNRfzzLeg6yL2ph6Ft3D8GfKoCcoCrrzCo6TOKnAGBxhx8K5iUmhL9NFdzaYt7m9+cu7W2pMKxpmdci976WwPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771091; c=relaxed/simple;
	bh=MPhbOAlRmSQDrymRu11c022uCrA5qLlPMbyZ8sUlGQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp+/gOgYXRu1i/+Fx5FD0LIFhlXkhF8Q+wyvShYaH1vxHuNlC01BP0y2dU2EDJIk4DUOTagRPGgjfbabxlRjFCOhYwQAnh1qlJy4eAcyYJerULrZyj9vAu1TfDTrVveagEisRBRuuRuidTGlRAFvSQNKKUcZmAnjknbaH4A+ugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5NkTz2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCBBC4CEE3;
	Wed, 12 Mar 2025 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741771091;
	bh=MPhbOAlRmSQDrymRu11c022uCrA5qLlPMbyZ8sUlGQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5NkTz2TDhcxfgtafUw6PxH30PcDT+AUdcSrithUjNh2vzRiKPw3fAKP600UNrOmU
	 8fk3QTrgo4wd/xjqfOxC5QxpRyuhgo6g3cM984yceTTWvAS0LSfKlA5pWb+7R0BjQR
	 pl1wGI6hMKXP4VLHeWxTEe9elcSEUH44N+bpej1Y/9VwhgIhhe4y6kV6ecjABRkhKm
	 DDHnHK6rY/YMOXnJUJeKxQFx5fKNtCjXW0pi1W6vrfJ7wlcR1YM6Xdyt8yOygIbUmB
	 X7gSmCNfIL+vtxLK8sqfOVloneJrhx7ha7Nsvzv9qCvh0xYO3IFZ7tacOMdIB5yn8s
	 CKfN3x5W1o2sg==
Date: Wed, 12 Mar 2025 10:18:06 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
Message-ID: <Z9FRTtcfQK9m6NE7@vaman>
References: <cover.1740762136.git.robin.murphy@arm.com>
 <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>
 <Z89P461+Y6kQDOCX@vaman>
 <072d1d3a-2aeb-4ab0-9db1-476835a1131e@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072d1d3a-2aeb-4ab0-9db1-476835a1131e@arm.com>

On 11-03-25, 12:48, Robin Murphy wrote:
> On 2025-03-10 8:47 pm, Vinod Koul wrote:
> > On 28-02-25, 17:26, Robin Murphy wrote:
> > 
> > > +static u32 d350_get_residue(struct d350_chan *dch)
> > > +{
> > > +	u32 res, xsize, xsizehi, hi_new;
> > > +
> > > +	hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
> > > +	do {
> > > +		xsizehi = hi_new;
> > > +		xsize = readl_relaxed(dch->base + CH_XSIZE);
> > > +		hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
> > > +	} while (xsizehi != hi_new);
> > 
> > This can go forever, lets have some limits to this loop please
> 
> Sure, in practice I doubt we're ever going to be continually preempted
> faster than the controller can move another 64KB of data, but I concur
> there's no harm in making the code easier to reason about at a glance
> either.

Yes you are coreect but when things go bad, a bug in h/w or something, I
would like to see a fail safe

> > > +static int d350_alloc_chan_resources(struct dma_chan *chan)
> > > +{
> > > +	struct d350_chan *dch = to_d350_chan(chan);
> > > +	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
> > > +			      dev_name(&dch->vc.chan.dev->device), dch);
> > 
> > This is interesting, any reason why the irq is allocated here? Would it
> > be not better to do that in probe...
> 
> Well, I'd say technically the IRQ is a channel resource, and quite a few
> other drivers do the same... Here it's mostly so I can get the channel name
> - so the IRQs are nice and identifiable in /proc/interrupts - easily without
> making a big mess in probe, since the names don't exist until after the
> device is registered.

Ok

-- 
~Vinod

