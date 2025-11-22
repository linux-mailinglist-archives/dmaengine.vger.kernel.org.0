Return-Path: <dmaengine+bounces-7294-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7258FC7CAF7
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347D94E2872
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FFE27B34F;
	Sat, 22 Nov 2025 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6J00KD/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FD27A12B
	for <dmaengine@vger.kernel.org>; Sat, 22 Nov 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801601; cv=none; b=t1TzIZQ8fUhjTp3OaVm6PYlujCExVvpGKsS25ebgQo4IPYYC6kECdhHBIl3sh7PTz+qhqtQkilZRu+JdI1w1OuEUQTGra4LODBnwvb13uhY+ZseiFVFp/VRZ/4pLHCfaY7AGpNm7fzx5GHUtTFm5vWP+Q8d5Cf5gbK9EH6Tz7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801601; c=relaxed/simple;
	bh=7XuzTzZkqcbDfkb415OyB9Xj+2m+TUzrFm98NtxSxTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITePyQzV4mSVd6eDeqIEbjE+PUDPGquAev+Fu17ahl9cAgwByZmYTj4EJes00eSpcLMdYBYbdE6bj+p/gdf3E9yedcqecFOQas3kiI5CGEAwVPw/OnH3zi5IrA/pmEhG/smwbafKJE9CBybZQXrnAiHZC6mO8cXRNJHW3v9lKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6J00KD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E95C4CEF5;
	Sat, 22 Nov 2025 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801600;
	bh=7XuzTzZkqcbDfkb415OyB9Xj+2m+TUzrFm98NtxSxTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6J00KD/VWgbhEYwqFHtxRyoIZKezX+6OoGD+HdcnJFKw/MhgXobDui8R8XSTEbQU
	 1ZH5a3ZDd9XikhKxmOyxyT4ckSwAF1RelpkpBP81Aqv/3pWUBs8/r2eXsQArpMVq/v
	 3C1sE7ONPx0Mjgm7aZQuMqgESxhPHxey4SCgJSGuIMMrAZVbUtP7h+DFb05DdB41Xc
	 iBhVSOFRcRCNra2eF71iaGEChMTWyyWqXO0dGaBsu5RrgyPIKYYDtqCM/pyPLJMBwC
	 sUr33ZVteBf7Cr5v2osewwRR3wjPVTzYzSBJysCWVkMRSw1eUtIPF7dkZL7Aj4LanW
	 16K0wjATvZMqg==
Date: Sat, 22 Nov 2025 14:23:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
Message-ID: <aSF5_Go4bddAbx38@vaman>
References: <20251014192239.4770-1-logang@deltatee.com>
 <20251014192239.4770-3-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014192239.4770-3-logang@deltatee.com>

On 14-10-25, 13:22, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Initialize the hardware and create the dma channel queues.

This looks mostly okay. Any reason why virt-dma is not used in this
driver?

-- 
~Vinod

