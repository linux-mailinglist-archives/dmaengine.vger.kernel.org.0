Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09972127745
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 09:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfLTIhS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 03:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfLTIhS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Dec 2019 03:37:18 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A0A2467F;
        Fri, 20 Dec 2019 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576831037;
        bh=MwmGwgRhGq+RQ75KDzhynCsOSx4RNN1uA6bAbx7zxGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs3ZUFjS2s6IKXqXMNe+xw4oHPJ0ryil98Uvc7u2PQ7Vlev7g9+6xq/DEPvCZFwea
         itZLuk5mM64Ij3Hn4v4sB/iA3mixlNGx4D0to0STKet4Wcg2U1i/18E8c4/8mqoa1W
         UX4KFY3+4mNitKcgQe1be5pFxHiy69NyNLkammhQ=
Date:   Fri, 20 Dec 2019 14:07:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v7 05/12] dmaengine: Add support for reporting DMA cached
 data amount
Message-ID: <20191220083713.GL2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-6-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209094332.4047-6-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-19, 11:43, Peter Ujfalusi wrote:
> A DMA hardware can have big cache or FIFO and the amount of data sitting in
> the DMA fabric can be an interest for the clients.
> 
> For example in audio we want to know the delay in the data flow and in case
> the DMA have significantly large FIFO/cache, it can affect the latenc/delay
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/dma/dmaengine.h   | 8 ++++++++
>  include/linux/dmaengine.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 501c0b063f85..b0b97475707a 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -77,6 +77,7 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
>  		state->last = complete;
>  		state->used = used;
>  		state->residue = 0;
> +		state->in_flight_bytes = 0;
>  	}
>  	return dma_async_is_complete(cookie, complete, used);
>  }
> @@ -87,6 +88,13 @@ static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
>  		state->residue = residue;
>  }
>  
> +static inline void dma_set_in_flight_bytes(struct dma_tx_state *state,
> +					   u32 in_flight_bytes)
> +{
> +	if (state)
> +		state->in_flight_bytes = in_flight_bytes;
> +}

This would be used by dmaengine drivers right, so lets move it to drivers/dma/dmaengine.h

lets not expose this to users :)

-- 
~Vinod
