Return-Path: <dmaengine+bounces-4582-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461C3A47745
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 09:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6CA173F66
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB92248AC;
	Thu, 27 Feb 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEaHK2Yp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AC2222B8;
	Thu, 27 Feb 2025 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643298; cv=none; b=gRiVtpwOuEzFpt0CGI9kZUCxf0OR/4ZDSmoBIo9ujF5ieZoqTkdSrjHq9w/mQKzaqR/mzUYMw1etBPM7PfJY2KMjFNzHw2ISA14s22DoErCpsmClOrY0XXIJtr0vuRVdCohL7SHxebbf2czKOytn8FCAyq3EgmiUrOoCNP52pyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643298; c=relaxed/simple;
	bh=rY6O7rl7q5TGUuXnHmdbCgAOzabHOiYHNL8f+UCcSks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+6gDdEjNh8rUXnTJqPxty6bQrmLwrmp9VAC/D2Jb9oJO6zZr3jYOcVTFh49jhttloft4yu4jQ9OZ0tDU7YdQXbPowR+dnFwG/Il9AjUXVkuG9/y18x7PhirvoW7PCB048s5EY2N0FRaKc516CwPjKhk9A8udLQnncM0kpDuwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEaHK2Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DE2C4CEDD;
	Thu, 27 Feb 2025 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740643297;
	bh=rY6O7rl7q5TGUuXnHmdbCgAOzabHOiYHNL8f+UCcSks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEaHK2Yp94FJop1vxomqXTGu0arrQbGodbfAY1qTW39qgg3DiBk+mZAdToqCEx1vq
	 HL8T/8IWkca2iERcC8NwGYXsLoARuKU/XiQXj4KTmvW5147S606VGvRR9BijGnZhaU
	 3ybEHrPKPDgqOi+QYXaTIyinndkL5rUCHfCF2PXuhR4YEmDBLwk0ck3MZVD8QBTa5T
	 n6PDW6i3P+5GCsCAOldgdpY4ph09aT8oMxa788RJz94Fb9TezJCq/i0vlNmes9iVf2
	 SEPTyWJ3ujVdybTXh1le2hcWO65Xv3smgFzIHTyvZ0rJxh0s/H5BLEk+F/wecam3W1
	 vjGZ28Hr+KlUQ==
Date: Thu, 27 Feb 2025 13:31:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Aatif Mushtaq <aatif4.m@samsung.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, aswani.reddy@samsung.com
Subject: Re: [PATCH 1/3] dmaengine: Add support for 2D DMA operation
Message-ID: <Z8Ab3VcAXf5z7UqE@vaman>
References: <20250210061915.26218-1-aatif4.m@samsung.com>
 <CGME20250210062247epcas5p4ce208ba2806454c48a68ef25d0a326cc@epcas5p4.samsung.com>
 <20250210061915.26218-2-aatif4.m@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210061915.26218-2-aatif4.m@samsung.com>

On 10-02-25, 11:49, Aatif Mushtaq wrote:
> Add a new dma engine API to support 2D DMA operations.
> The API will be used to get the descriptor for 2D transfer based on
> the 16-bit immediate to define the stride length between consecuitive
> source address or destination address after every DMA load and
> store instruction is processed.

Why should we define a new API for this...? Why not use the sg or
interleaved api for this?

> 
> Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
> ---
>  include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b137fdb56093..8a73b2147983 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -833,6 +833,7 @@ struct dma_filter {
>   *	be called after period_len bytes have been transferred.
>   * @device_prep_interleaved_dma: Transfer expression in a generic way.
>   * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
> + * @device_prep_2d_dma_memcpy: prepares a 2D memcpy operation
>   * @device_caps: May be used to override the generic DMA slave capabilities
>   *	with per-channel specific ones
>   * @device_config: Pushes a new configuration to a channel, return 0 or an error
> @@ -938,6 +939,9 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
>  		struct dma_chan *chan, dma_addr_t dst, u64 data,
>  		unsigned long flags);
> +	struct dma_async_tx_descriptor *(*device_prep_2d_dma_memcpy)(
> +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags);
>  
>  	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps *caps);
>  	int (*device_config)(struct dma_chan *chan, struct dma_slave_config *config);
> @@ -1087,6 +1091,27 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
>  						    len, flags);
>  }
>  
> +/**
> + * device_prep_2d_dma_memcpy() - Prepare a DMA 2D memcpy descriptor.
> + * @chan: The channel to be used for this descriptor
> + * @dest: Address of the destination data for a DMA channel
> + * @src: Address of the source data for a DMA channel
> + * @len: The total size of data
> + * @src_imm: The immediate value to be added to the src address register
> + * @dest_imm: The immediate value to be added to the dst address register
> + * @flags: DMA engine flags
> + */
> +static inline struct dma_async_tx_descriptor *device_prep_2d_dma_memcpy(
> +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> +		size_t len, u16 src_imm, u16 dest_imm, unsigned long flags)
> +{
> +	if (!chan || !chan->device || !chan->device->device_prep_2d_dma_memcpy)
> +		return NULL;
> +
> +	return chan->device->device_prep_2d_dma_memcpy(chan, dest, src, len,
> +						       src_imm, dest_imm, flags);
> +}
> +
>  static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
>  		enum dma_desc_metadata_mode mode)
>  {
> -- 
> 2.17.1

-- 
~Vinod

