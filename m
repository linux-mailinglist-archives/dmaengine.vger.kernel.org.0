Return-Path: <dmaengine+bounces-4680-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6739A5A544
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F47A123F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA461DF258;
	Mon, 10 Mar 2025 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGvSE7A4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172511DE4C8;
	Mon, 10 Mar 2025 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639655; cv=none; b=J5emJCYrAZZeBbuWa1BCJsooGno2G6sa/fwUEnYLYPsPPzsmNtKuchsN/KV+2R3bL133Csvp6WcD0znEMdZH3wT5n5Q1w38EDnX1N/bNlwxUJHaSKhDoJRMNRImTvtzDHq6XXB1w3TUbR3/21ztzPCco0t2axAuHekuP1JO2G44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639655; c=relaxed/simple;
	bh=Zf01IC7iv4wbCJ+aR/Htct+Ew44gIeHiBJl2ieaEMok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PspHw7qKclBw9nYcIe3zPpDu2xxYEUoD73kx07GLqiiE5CwvPIyjhXmaRN+mk1Exj4YfSpDBSczUg70547S0cZTHXz6NxlPB3pvOZ1w2TUe561aUNWRCzXkemJ2zmTTQQUQjkmAqNS7HPpYyeTDzvkp+OFohCY9PTBgXtgi+WEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGvSE7A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669ABC4CEE5;
	Mon, 10 Mar 2025 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639655;
	bh=Zf01IC7iv4wbCJ+aR/Htct+Ew44gIeHiBJl2ieaEMok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGvSE7A42EbJnZRC1hj4/bjyygUZL4fmxWqVrW82nr1a43xeLEKBkaSzymJuwhzC4
	 q7SVWHZKkcaGlOhxtuKjYy0e9VDLfSCSL68uaid7zbT/14TQ+X7QxVCXHm26oQW0sZ
	 73EKYeMW0V6eJGlEsQMznD4aRvzDg2lGpTJwesXHxCtCGepNxW2tHJrazIXPqxkNmH
	 t5Cxruckx6/CCw1r6jLz+e3fFgO2Wm6e0wgA22g2RuxTROLw8i508aaTkKvpbOLTgl
	 H4NP0zQl/geIqNhmGkYWNItfZgMfYl0UtOa3pkuNiqcfUR5jj+dwa5kW0qUMlJY/Ol
	 QBly887wQlpdQ==
Date: Tue, 11 Mar 2025 02:17:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
Message-ID: <Z89P461+Y6kQDOCX@vaman>
References: <cover.1740762136.git.robin.murphy@arm.com>
 <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>

On 28-02-25, 17:26, Robin Murphy wrote:

> +static u32 d350_get_residue(struct d350_chan *dch)
> +{
> +	u32 res, xsize, xsizehi, hi_new;
> +
> +	hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
> +	do {
> +		xsizehi = hi_new;
> +		xsize = readl_relaxed(dch->base + CH_XSIZE);
> +		hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
> +	} while (xsizehi != hi_new);

This can go forever, lets have some limits to this loop please

> +static int d350_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct d350_chan *dch = to_d350_chan(chan);
> +	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
> +			      dev_name(&dch->vc.chan.dev->device), dch);

This is interesting, any reason why the irq is allocated here? Would it
be not better to do that in probe...

-- 
~Vinod

