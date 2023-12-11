Return-Path: <dmaengine+bounces-436-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CF80C751
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 11:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF83F2816CA
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2B2D60C;
	Mon, 11 Dec 2023 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ2xmnKN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323925547
	for <dmaengine@vger.kernel.org>; Mon, 11 Dec 2023 10:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A1C433C7;
	Mon, 11 Dec 2023 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702292045;
	bh=Mew19YXARFjy0JbYv18LDqEwa392ENZRfLl+eSvOMKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJ2xmnKNSkDBALZLpUjhCE29HPVqxORPSTSbZ46jS2m+jtpo7r2n4BUX0Xm4zvOTH
	 YO6lfYSyBivPT45enhCace80oThVdPEhEZEJYn0MZp9oKA1FTQh47NItT2oQV2KZjQ
	 wyfZAZXpCQ2DGEdq0HEf/ax/d61eVh6BFo3fpdKdQgM6pR4w1Uekomk54AxzcGz7w0
	 0YJ0t67KITwfy6FW8SkEs3PSMEqCO0o1ipj9vPM0TigyFZgRHxuj7QrDHXh+6bvxUi
	 ywroaL9KQdcVubnmIOpoV4uW+UsVhxjOi3v4x99zDQ1lkA/Ehr5TGlRptO25obv3RO
	 ju07LyRJ7ZK3Q==
Date: Mon, 11 Dec 2023 16:24:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jan Kuliga <jankul@alatek.krakow.pl>
Cc: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
	michal.simek@amd.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v4 4/8] dmaengine: xilinx: xdma: Rework
 xdma_terminate_all()
Message-ID: <ZXbqSQ9W/VrAA0ZE@matsya>
References: <20231208134838.49500-1-jankul@alatek.krakow.pl>
 <20231208134929.49523-5-jankul@alatek.krakow.pl>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208134929.49523-5-jankul@alatek.krakow.pl>

On 08-12-23, 14:49, Jan Kuliga wrote:
> Simplify xdma_xfer_stop(). Stop the dma engine and clear its status
> register unconditionally - just do what its name states. This change
> also allows to call it without grabbing a lock, which minimizes
> the total time spent with a spinlock held.
> 
> Delete the currently processed vd.node from the vc.desc_issued list
> prior to passing it to vchan_terminate_vdesc(). In case there's more
> than one descriptor pending on vc.desc_issued list, calling
> vchan_terminate_desc() results in losing the link between
> vc.desc_issued list head and the second descriptor on the list. Doing so
> results in resources leakege, as vchan_dma_desc_free_list() won't be
> able to properly free memory resources attached to descriptors,
> resulting in dma_pool_destroy() failure.
> 
> Don't call vchan_dma_desc_free_list() from within xdma_terminate_all().
> Move all terminated descriptors to the vc.desc_terminated list instead.
> This allows to postpone freeing memory resources associated with
> descriptors until the call to vchan_synchronize(), which is called from
> xdma_synchronize() callback. This is the right way to do it -
> xdma_terminate_all() should return as soon as possible, while freeing
> resources (that may be time consuming in case of large number of
> descriptors) can be done safely later.
> 
> Fixes: 290bb5d2d1e2
> ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")
> 
> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
> ---
>  drivers/dma/xilinx/xdma.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 1bce48e5d86c..521ba2a653b6 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -379,20 +379,20 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
>   */
>  static int xdma_xfer_stop(struct xdma_chan *xchan)
>  {
> -	struct virt_dma_desc *vd = vchan_next_desc(&xchan->vchan);
> -	struct xdma_device *xdev = xchan->xdev_hdl;
>  	int ret;
> -
> -	if (!vd || !xchan->busy)
> -		return -EINVAL;
> +	u32 val;
> +	struct xdma_device *xdev = xchan->xdev_hdl;
> 
>  	/* clear run stop bit to prevent any further auto-triggering */
>  	ret = regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
> -			   CHAN_CTRL_RUN_STOP);
> +							CHAN_CTRL_RUN_STOP);

Why this change, checkpatch would tell you this is not expected
alignment (run with strict)

>  	if (ret)
>  		return ret;
> 
> -	xchan->busy = false;
> +	/* Clear the channel status register */
> +	ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val);
> +	if (ret)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -505,25 +505,25 @@ static void xdma_issue_pending(struct dma_chan *chan)
>  static int xdma_terminate_all(struct dma_chan *chan)
>  {
>  	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> -	struct xdma_desc *desc = NULL;
>  	struct virt_dma_desc *vd;
>  	unsigned long flags;
>  	LIST_HEAD(head);
> 
> -	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>  	xdma_xfer_stop(xdma_chan);
> 
> +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> +
> +	xdma_chan->busy = false;
>  	vd = vchan_next_desc(&xdma_chan->vchan);
> -	if (vd)
> -		desc = to_xdma_desc(vd);
> -	if (desc) {
> -		dma_cookie_complete(&desc->vdesc.tx);
> -		vchan_terminate_vdesc(&desc->vdesc);
> +	if (vd) {
> +		list_del(&vd->node);
> +		dma_cookie_complete(&vd->tx);
> +		vchan_terminate_vdesc(vd);
>  	}
> -
>  	vchan_get_all_descriptors(&xdma_chan->vchan, &head);
> +	list_splice_tail(&head, &xdma_chan->vchan.desc_terminated);
> +
>  	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> -	vchan_dma_desc_free_list(&xdma_chan->vchan, &head);
> 
>  	return 0;
>  }
> --
> 2.34.1

-- 
~Vinod

