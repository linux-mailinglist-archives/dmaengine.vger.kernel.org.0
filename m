Return-Path: <dmaengine+bounces-7589-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF45CB98CE
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 19:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BEFF30698E9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F3301498;
	Fri, 12 Dec 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYmfYxp6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EA2FFF84;
	Fri, 12 Dec 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563700; cv=none; b=oSF4LiSZGuvsH57TmLj2U7OwLE34tQdQT/uKwZMWvJbgPAiTK8JYSEE+QQhWGwvOO6b7vQQoRMFUa4WXeJLBUNm9Nk5MBvWCPvSsrVv39idLHyDtdxV5PfihnpgzO8rOyS/5FMJXIewxuZG6mCKRH11e+9K3FB7+xNzBsdebNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563700; c=relaxed/simple;
	bh=auBHVt6Bs5Uj8wAmn+6EhNutVPqnMs4Y/ARfoKLGBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S54u3LUOGXjrN6GzNcwHSXV3tYz5u5zoBurIcZqjYyrBljMOkVSzoQpNmAKz05di2JrF1d+1kHuwTgr3wbPKJFXg852H5rOhx8vLiwzQM003jjBkbbInOmchpEum+K5hrNgA5+pwyrKk92Da3xhVtLWfBC9CgRQIbkCNokh57BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYmfYxp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B129C4CEF1;
	Fri, 12 Dec 2025 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765563699;
	bh=auBHVt6Bs5Uj8wAmn+6EhNutVPqnMs4Y/ARfoKLGBXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CYmfYxp6pzzr1opEBmZtvHp83nO5mOTFEcVykGgRB3f39k6RyYzTMYl3UbjwsS35M
	 CP/SMvI3CmBsXYZe7xYjdnZzT5UQRFlYKd4Nvi+dfy1Hkx0ER9i9QeLV2RA0waGH41
	 aZM/orR3jVQDtApj6MmOuN/3mKSRXiLf+8+FDACy2YKzQbSYR7WBoC0ZDVOe0nat9L
	 Jyhrg2QTRgRZChbn7NrGV4GX+hSW5yUjmfBavSUL3IgDwAEukrSaKgdZVRkR6wSYNC
	 K//aTyXqL3m37C6dbYPWijRrYRV0FtqmDjluPdq2dTXAwZSbgp5lVmULjtCYEJcU6q
	 UmiP/lXG27oAg==
Date: Fri, 12 Dec 2025 12:21:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <20251212182138.GA3649445@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212122056.8153-3-devendra.verma@amd.com>

On Fri, Dec 12, 2025 at 05:50:56PM +0530, Devendra K Verma wrote:
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - For the AMD (Xilinx) only, when a valid physical base address of
>   the device side DDR is not configured, then the IP can still be
>   used in non-LL mode. For all the channels DMA transactions will
>   be using the non-LL mode only. This, the default non-LL mode,
>   is not applicable for Synopsys IP with the current code addition.
> 
> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>   and if user wants to use non-LL mode then user can do so via
>   configuring the peripheral_config param of dma_slave_config.
> ...

> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int non_ll = 0;

Other "non_ll" uses below are bool, so a little bit of an int/bool
mix.

The name also leads to a lot of double negative use ("!non_ll", etc),
which is hard to read.  I suppose "non-LL" corresponds to some spec
language, but it would be nice if we could avoid some of the negation
by testing for "ll_mode" or calling the other mode "single_burst" or
similar.

> +	 * When there is no valid LLP base address available then the default
> +	 * DMA ops will use the non-LL mode.
> +	 * Cases where LL mode is enabled and client wants to use the non-LL
> +	 * mode then also client can do so via providing the peripheral_config
> +	 * param.

Add blank line between paragraphs.

