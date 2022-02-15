Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ABB4B6B60
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 12:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiBOLpP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 06:45:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiBOLpK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 06:45:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3760044
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 03:45:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFEAC6157C
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 11:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F2C340EB;
        Tue, 15 Feb 2022 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644925500;
        bh=hcq9M6E5NPKxqmN0q7SIqUkrVUAIuE/UWlN01I5pCMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZi+WCQof7L4IXjqWwfO8537UrxzeQn+dExh9b6NJVrivhj/mXuF3OV377rC3JBRQ
         qJzlzomK9Y2CX+I7oK31SK8vbTU/KDPqDrOZ4iapcXCewt9i7wzaLJ2bGZ6ROcFf/6
         bR49RhFb0/73NbH0mDxh0nfoRVEUh971LN6mztBRipC4UdHCBI8dGwy3aduucjUlII
         0DpjT2TBtSkF/vZeGOZOlyyKNQPljnh25lfA9RPYFIdvyLpJmu6Mv1sKm7rSla4V/b
         MmkLhbY69X865ELH8PtbJyE2rv5N1552e15l38rMv4t97Uqte2molFWyWXjwunqu1Y
         08XRef44CbuuA==
Date:   Tue, 15 Feb 2022 17:14:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com
Subject: Re: [RFC PATCH 1/4] dmaengine: Document dmaengine_prep_dma_memset
Message-ID: <YguSODvaNBKp/2O+@matsya>
References: <20220128183948.3924558-1-benjamin.walker@intel.com>
 <20220128183948.3924558-2-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128183948.3924558-2-benjamin.walker@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-01-22, 11:39, Ben Walker wrote:
> Document this function to make clear the expected behavior of the
> 'value' parameter. It was intended to match the behavior of POSIX memset
> as laid out here:
> 
> https://lore.kernel.org/dmaengine/YejrA5ZWZ3lTRO%2F1@matsya/

Can we add this to Documentation too? Documentation/driver-api/dmaengine/

> 
> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
> ---
>  include/linux/dmaengine.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 842d4f7ca752d..3d3e663e17ac7 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1031,6 +1031,14 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
>  	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
>  }
>  
> +/**
> + * dmaengine_prep_dma_memset() - Prepare a DMA memset descriptor.
> + * @chan: The channel to be used for this descriptor
> + * @dest: Address of buffer to be set
> + * @value: Treated as a single byte value that fills the destination buffer
> + * @len: The total size of dest
> + * @flags: DMA engine flags
> + */
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
>  		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
>  		unsigned long flags)
> -- 
> 2.33.1

-- 
~Vinod
