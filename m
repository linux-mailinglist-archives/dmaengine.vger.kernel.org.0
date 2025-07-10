Return-Path: <dmaengine+bounces-5759-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1012B0007E
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 13:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B75A3A0E
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C592C15B7;
	Thu, 10 Jul 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faLhZDzg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF321944F;
	Thu, 10 Jul 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146816; cv=none; b=npxCQ7Rbi3tubhaAaEJAYJrxfTi5rYutHnIyD9dwpovxazGMFfUpLpRsRlyEK5f63PpzXvXA8vtVkYsZYnnnjDuUvp1QxFL8FCpGFCJdlMNBW2DqfILvPkZMcaKWBg9hLezrY2MJuGxSfeYCPumjASda1E7U0NAE4NiADxsAW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146816; c=relaxed/simple;
	bh=YsnzDVQg/DVkrhs774taeeXQ+MFgNHcGDxgkiSjhU6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqs/kLiPc5zP+IlLRlXrwi4wOV9ly5aDPhTO4R7TM5nLJw5MXrLcGsDnZlBJngbwj/F/5A/eVKV4Y2ShPxp72SO7mhL7qfjq/07s0iSs7mP8bUIdoY23JqviDlCXpUOJ9E/MIKw1c2xYa1H5IJs9kTkf+SaWfl+TqyLUpAS7ksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faLhZDzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0AEC4CEE3;
	Thu, 10 Jul 2025 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752146815;
	bh=YsnzDVQg/DVkrhs774taeeXQ+MFgNHcGDxgkiSjhU6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faLhZDzgdqb/3jBhBBX/zTH/N4QurnqFsyCi048n7aREzmjV8pBAl1a5w4HHtcQ0A
	 D1OYkmMiNpVVb+i1oP9aOd7MLe7pxkJ/UVYNZkksz/AU6h4tgMkDLA+h25YFxL6UCp
	 fMjjRNpCPWB9pwJOwaMr22x6f2IEvg1r8cQqNZP4pxjtwmvXsgTxroowFWV9/5QUbs
	 uqfpPIp/ht01Qf3q2h3P+O4j3/TPA0DPBNlzJKEAVukOlB3A0nUTn9wQ6ctbZHci/6
	 nLkUcu3Mm/lEBSfKX40ZlVtubMskrW4VR9bP/hfTxZrGwLD6175HGyjNSaV2RuTqo7
	 e0HUNzAALuVtg==
Date: Thu, 10 Jul 2025 12:26:50 +0100
From: Simon Horman <horms@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com, vkoul@kernel.org,
	radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, harini.katakam@amd.com
Subject: Re: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start
 transfer path for AXI DMA
Message-ID: <20250710112650.GS721198@horms.kernel.org>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710101229.804183-3-suraj.gupta2@amd.com>

On Thu, Jul 10, 2025 at 03:42:27PM +0530, Suraj Gupta wrote:
> AXI DMA driver incorrectly assumes complete transfer completion upon
> IRQ reception, particularly problematic when IRQ coalescing is active.
> Updating the tail pointer dynamically fixes it.
> Remove existing idle state validation in the beginning of
> xilinx_dma_start_transfer() as it blocks valid transfer initiation on
> busy channels with queued descriptors.
> Additionally, refactor xilinx_dma_start_transfer() to consolidate coalesce
> and delay configurations while conditionally starting channels
> only when idle.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Fixes: Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")

Hi, 

This is not a proper review.
And there is probably no need to repost just becuse of it.
But:

s/Fixes: Fixes: /Fixes: /

...

