Return-Path: <dmaengine+bounces-6193-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83922B33DFC
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 13:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F39206311
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E192E92C0;
	Mon, 25 Aug 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu8R6Ml8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0B2E92B5;
	Mon, 25 Aug 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121414; cv=none; b=l1ISB6TucJGC23CxOApoKt4kj0GPfNGcmjZXgXmE5lM17ObEg4bBpdvl5us3GDIQZ2K6bX/kNrQ0MMHJ0TK9il9sYNqvCWaliL3j3bG9a00FjfZ8ZOpO8IOxomgXsennHe2Jsy8fqEgxGh33jChgo0KgzuaO6DwiAk3ywWGGO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121414; c=relaxed/simple;
	bh=3IHQNx2wrG20tcpiuH47GBZaxIUHfLatzNtTwPWBAJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dehtlsfQxRDLO+lHzT/fMcZc/tN2azbL6IISym6U+t/9su3NxtkwYUwl67ztM+xZhi2RiY5QINC8nDpLXvBzbFAu2Fowm6EBLfmtFEbEqxdGyPX1w9h9jhl9o3xZN1sfzceF8tpjC2gTSCjfE4GrHZrtuf2UADy9sAolmNMY4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu8R6Ml8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE4C4CEED;
	Mon, 25 Aug 2025 11:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121414;
	bh=3IHQNx2wrG20tcpiuH47GBZaxIUHfLatzNtTwPWBAJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cu8R6Ml8hgPAFNXJ3urcJe2DA/DwaerKI9hS5K95Dj/iVuMKIl+WvKpmc91YAr/f3
	 KbQGqfuYwSNxbexZG+GBmsNpU0PH/FM3sGwHe2gSkv8f5AHuaLi4//ol7rxFIWKCI4
	 2Re4C593+G9oUPJXS8yJdwPUak+xt+Z4KiUyNiTnahE5YuZ1dPge//kDUUwmdn2vRp
	 sqF3Ku8TdWpiuczfb5gH68oLe3hiBjzRYKJoiwuqOzQMGyBAERvUrpfTMEgqatrwLp
	 zxG+rn5TVs2DbsBLwV1dXAtkxQMFasnKZxBDBGxFQ76FAdZpgS1N5esrE/uHXAjQTk
	 Htd3lrHS+/+fA==
Date: Mon, 25 Aug 2025 13:30:08 +0200
From: Vinod Koul <vkoul@kernel.org>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH V2 1/4] dmaengine: Add support to configure and read IRQ
 coalescing parameters
Message-ID: <aKxJQLx6yprNdU03@vaman>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-2-suraj.gupta2@amd.com>
 <aICPiS1_ITwELrxq@vaman>
 <BL3PR12MB65713879CB569E3B330C1E76C95FA@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB65713879CB569E3B330C1E76C95FA@BL3PR12MB6571.namprd12.prod.outlook.com>

On 23-07-25, 11:49, Gupta, Suraj wrote:
> > >  struct dma_slave_caps {
> > >       u32 src_addr_widths;
> > > @@ -520,6 +528,8 @@ struct dma_slave_caps {
> > >       bool cmd_terminate;
> > >       enum dma_residue_granularity residue_granularity;
> > >       bool descriptor_reuse;
> > > +     u32 coalesce_cnt;
> > > +     u32 coalesce_usecs;
> >
> > Why not selectively set interrupts for the descriptor. The dma descriptors are in order,
> > so one a descriptor is notified and complete, you can also complete the descriptors
> > before that. I would suggest to use that rather than define a new interface for this
> >
> 
> The reason I used struct dma_slave_config to pass coalesce and delay information to DMA driver is that the coalesce count is configured per channel in AXI DMA channel control register[1].
> AXI DMA IP doesn't have provision to set interrupt per descriptor[2].
> I can explore other ways to pass this information via struct dma_async_tx_descriptor or metadata, or any other way.
> Please let me know your thoughts.

dma_async_tx_descriptor has dma_ctrl_flags and one of them is
DMA_PREP_INTERRUPT which you can set for a descriptor and control when
you get the interrupt

I am not a fan of adding custom interfaces.

-- 
~Vinod

