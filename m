Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D589DF6E6A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 07:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfKKGJv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 01:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfKKGJv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 01:09:51 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDDF20679;
        Mon, 11 Nov 2019 06:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573452590;
        bh=qgj3ToNBsbbCIzf/cArvU0XfhuPYM0eDrqW+5UsfeMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehTDjrENf8AQoSP7oLkpm+Br34A+/wWRwJ0GSd5MLZResRbCwvtv13ZUU2Fpb9EIC
         dkBGrJfaWXZdAitp6fLDHCnn12aTSRm+xIO6qYmXArcEk7ckD1DWZIGthGufIDyVCF
         cpl28NaY67WaBvQ97FkwOSQuxzm/KId345SahEAI=
Date:   Mon, 11 Nov 2019 11:39:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 12/15] dmaengine: ti: New driver for K3 UDMA -
 split#4: dma_device callbacks 1
Message-ID: <20191111060943.GQ952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-13-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-13-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:

> +/* Not much yet */

?

> +static enum dma_status udma_tx_status(struct dma_chan *chan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *txstate)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uc->vc.lock, flags);
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +
> +	if (!udma_is_chan_running(uc))
> +		ret = DMA_COMPLETE;

so a paused channel will result in dma complete status?

-- 
~Vinod
