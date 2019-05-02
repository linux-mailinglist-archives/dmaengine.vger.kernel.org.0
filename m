Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA44911303
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 08:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEBGE5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 02:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfEBGE4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 May 2019 02:04:56 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271722081C;
        Thu,  2 May 2019 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556777096;
        bh=AIbpzp/IDy0CStv4gzV133Vm7XU8kRQPpGQnibvVotw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKBQrLQySLJTXow2/VlS55JsED+AA0f7bOfytCZHFjpB+81Mrp4W4PZmQ5VzKz3iv
         5lUhRZuxmmkQLE5ZmC1Jz0SofYDFJXS1CNrFtJ0TI42F3IWztOWnBn9f2RTzEWsfNS
         JVKk8WAxc3/+TYCgRAseNK1G9HYnaO9nFse2+Mzw=
Date:   Thu, 2 May 2019 11:34:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     dan.j.williams@intel.com, tiwai@suse.com, jonathanh@nvidia.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190502060446.GI3845@vkoul-mobl.Dlink>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-04-19, 17:00, Sameer Pujar wrote:
> During the DMA transfers from memory to I/O, it was observed that transfers
> were inconsistent and resulted in glitches for audio playback. It happened
> because fifo size on DMA did not match with slave channel configuration.
> 
> currently 'dma_slave_config' structure does not have a field for fifo size.
> Hence the platform pcm driver cannot pass the fifo size as a slave_config.
> Note that 'snd_dmaengine_dai_dma_data' structure has fifo_size field which
> cannot be used to pass the size info. This patch introduces fifo_size field
> and the same can be populated on slave side. Users can set required size
> for slave peripheral (multiple channels can be independently running with
> different fifo sizes) and the corresponding sizes are programmed through
> dma_slave_config on DMA side.

FIFO size is a hardware property not sure why you would want an
interface to program that?

On mismatch, I guess you need to take care of src/dst_maxburst..

> 
> Request for feedback/suggestions.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  include/linux/dmaengine.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index d49ec5c..9ec198b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -351,6 +351,8 @@ enum dma_slave_buswidth {
>   * @slave_id: Slave requester id. Only valid for slave channels. The dma
>   * slave peripheral will have unique id as dma requester which need to be
>   * pass as slave config.
> + * @fifo_size: Fifo size value. The dma slave peripheral can configure required
> + * fifo size and the same needs to be passed as slave config.
>   *
>   * This struct is passed in as configuration data to a DMA engine
>   * in order to set up a certain channel for DMA transport at runtime.
> @@ -376,6 +378,7 @@ struct dma_slave_config {
>  	u32 dst_port_window_size;
>  	bool device_fc;
>  	unsigned int slave_id;
> +	u32 fifo_size;
>  };
>  
>  /**
> -- 
> 2.7.4

-- 
~Vinod
