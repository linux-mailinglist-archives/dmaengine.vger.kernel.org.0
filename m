Return-Path: <dmaengine+bounces-8132-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C8AD06D64
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 03:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C96E8300E612
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 02:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EB33002BB;
	Fri,  9 Jan 2026 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNQMs7As"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E092F60A3;
	Fri,  9 Jan 2026 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925055; cv=none; b=rTwwM9T8jz6bK84SXh5LO2jcuUDzEUzutYag8ciGzqQFhxIlI+KNvKDGzZT+CEZ1Fg5glgMLUyoyQyIFzLzrcjNbGLPPAVlUFENDgSzi3giJ96mNiEvyWbn5gP5OXNEKQKzY2M8X031SBYttgvrg/dfi08blKtFfEOjTfPgZuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925055; c=relaxed/simple;
	bh=+WVMphEXtphNalcDcHuuxSsvfBb3Fz9XJLJDOnptedI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5h0bDrYw+C1WvdN9foZdqycm8VAjnfXFmNebw+bSQnA0EFUXr16IL/T/nfLoLtY+lwqCinzCGAh9S8LfF+QoLbv3DekkPqS7wuZxUgESQE4BJbtART7rt2dV+JKTPtOcQRUeO5FhwwgIUeEvWRA0fgFX5LsniXxihJHnwvnBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNQMs7As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394DAC116C6;
	Fri,  9 Jan 2026 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767925054;
	bh=+WVMphEXtphNalcDcHuuxSsvfBb3Fz9XJLJDOnptedI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNQMs7AsdrqZO5aScqtEhVrA6DXVXt79IPmJTlY5CBiAea5dwFH1etXcdB89lhIf8
	 Eq+A6AJaPMYImNjY6r7IhDoSgnyR3nLSOCb1WJdW8tZvt6u3emhRgbhlJkFqDbbTNj
	 XuabPY2D1zRwVBRAsoJKsBAxuG9WCy0TCiK9F1Vcudu4vpKeAdS/uaEIVc7G7WKTcj
	 +xpYwq/1MPPE5zMs81ktTOkBbu4uvROKe2BR49Eus2FHMysxuswB9m5aHTXzfTsYSN
	 d0oRvHT68PPp47dXqEm16ZwZpjRIR0n3Vir78HQ12ccAIo1IZUiSsOYby2VJ8w/a1x
	 7mjGU43Z33yfQ==
Date: Fri, 9 Jan 2026 07:47:30 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/13] dmaengine: introduce sg_nents_for_dma() and
 convert users
Message-ID: <aWBlOjXio8w492lC@vaman>
References: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
 <aUFakHZL8viMN3WR@vaman>
 <aV9S2oAsIIIZoYnR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV9S2oAsIIIZoYnR@smile.fi.intel.com>

On 08-01-26, 08:46, Andy Shevchenko wrote:
> On Tue, Dec 16, 2025 at 06:41:44PM +0530, Vinod Koul wrote:
> > On 24-11-25, 13:09, Andy Shevchenko wrote:
> > > A handful of the DMAengine drivers use same routine to calculate the number of
> > > SG entries needed for the given DMA transfer. Provide a common helper for them
> > > and convert.
> > > 
> > > I left the new helper on SG level of API because brief grepping shows potential
> > > candidates outside of DMA engine, e.g.:
> > > 
> > >   drivers/crypto/chelsio/chcr_algo.c:154:  nents += DIV_ROUND_UP(less, entlen);
> > >   drivers/spi/spi-stm32.c:1495:  /* Count the number of entries needed */
> > > 
> > > Changelog v4:
> > > - fixed compilation errors (Vinod)
> > 
> > :-(
> > 
> > drivers/dma/altera-msgdma.c: In function ‘msgdma_prep_slave_sg’:
> > drivers/dma/altera-msgdma.c:399:29: error: unused variable ‘sg’ [-Werror=unused-variable]
> > 
> > Clearly your script is not working. I am surprised that you are not able
> > to compile these changes. Bit disappointed tbh!
> 
> This is W=1 build with WERROR=y, yet I agree that I must have tested this as
> well. Sorry, I will do v5 with carefully tested all modules to be compiled
> with `make W=1`.

I turned on in by builds after it was enabled mainline... so yes now it
is part of my tests

-- 
~Vinod

