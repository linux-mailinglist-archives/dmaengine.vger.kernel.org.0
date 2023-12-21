Return-Path: <dmaengine+bounces-627-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08381BCE3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 18:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FE4281DE4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C535991F;
	Thu, 21 Dec 2023 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHRMUumz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD759919;
	Thu, 21 Dec 2023 17:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0A4C433C7;
	Thu, 21 Dec 2023 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179111;
	bh=na3rzBCDzzrE1fWEebLVq6pSc/yHaENpPtcr9w+HKlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHRMUumzUMZZWeQO/k4+2dNxy0QYbAaj+36VW+cCckTP54f3NYd9tQDEoCLeWysgd
	 VkKhwvKJxRhUzuX+o3o3uWFrK1rgJmkQUlba2NScFDUUIQZGivoJpkh+A8wSTM0ePt
	 JhqokoK+6ZUFWeR5qGGfGG3fWcqTnYzp6WtaT6cc0gdE8u0YIhDNYlynNbumJahigV
	 NIFbuOlu1E5gxO33K7kGv3bZZD06MWYKssQde/3Zpiww1tV55BJ3Qw9N19uUNNaFKj
	 bSOjgNwx+mWqM6OIy2XWLpGotgWE735d0yy2zwMf3f3rr0ZmZTm8b/k6zHs+hf9alE
	 gY8A6+nfI8oGw==
Date: Thu, 21 Dec 2023 22:48:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: add channel device name to channel
 registration
Message-ID: <ZYRzY3ul9UzD9d06@matsya>
References: <20231213174021.3074759-1-amelie.delaunay@foss.st.com>
 <ZYRkP-m_sra8qUNZ@matsya>
 <5e007fe4-d6cd-4ec3-b9c1-ef7841e29851@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e007fe4-d6cd-4ec3-b9c1-ef7841e29851@foss.st.com>

On 21-12-23, 18:11, Amelie Delaunay wrote:
> Hi Vinod,
> 
> On 12/21/23 17:13, Vinod Koul wrote:
> > On 13-12-23, 18:40, Amelie Delaunay wrote:
> > > Channel device name is used for sysfs, but also by dmatest filter function.
> > > 
> > > With dynamic channel registration, channels can be registered after dma
> > > controller registration. Users may want to have specific channel names.
> > > 
> > > If name is NULL, the channel name relies on previous implementation,
> > > dma<controller_device_id>chan<channel_device_id>.
> > 
> > lgtm, where is the user for this..?
> > 
> 
> I'll send beginning of next year a DMA controller driver for STM32MP25 SoC
> family. It relies on the dynamic channel registration. It will be a user of
> this dma_async_device_channel_register(struct dma_device *device, struct
> dma_chan *chan, const char *name).

Okay, I prefer to add a API with the user.

Thnx

-- 
~Vinod

