Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4630C22E8AF
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgG0JSC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 05:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgG0JSC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 05:18:02 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B4B20658;
        Mon, 27 Jul 2020 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595841481;
        bh=eyJKLa91a/lAAH/k3bNjDjvwABdcV+l0GGw6ixrMurI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwX8NS/ZkqNn9Y+JLGQ2W2ydBtj6b1ST6IfFWRt0qHk4yhk9HSQ8RF+CqFyOrpU+h
         raufTX3clV/NJ1/Q5MzL7OUuX+0NnqQ3QDUqJ+glbeKN/Ctv4c1QCFIGxnRMvO+aAE
         vD5IcPsd3CXAWO3fYAChnArCztxkootUUKb3Oja8=
Date:   Mon, 27 Jul 2020 14:47:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Mona Hossain <mona.hossain@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: reset states after device disable or
 reset
Message-ID: <20200727091757.GT12965@vkoul-mobl>
References: <159535783121.44497.13003335997381621798.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159535783121.44497.13003335997381621798.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-07-20, 11:57, Dave Jiang wrote:
> The state for WQs should be reset to disabled when a device is reset or
> disabled.
> 
> Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
> Reported-by: Mona Hossain <mona.hossain@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 14b45853aa5f..d0290072d558 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -414,6 +414,7 @@ int idxd_device_disable(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
>  	u32 status;
> +	int i;
>  
>  	if (!idxd_is_enabled(idxd)) {
>  		dev_dbg(dev, "Device is not enabled\n");
> @@ -429,13 +430,33 @@ int idxd_device_disable(struct idxd_device *idxd)
>  		return -ENXIO;
>  	}
>  
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		struct idxd_wq *wq = &idxd->wqs[i];
> +
> +		if (wq->state == IDXD_WQ_ENABLED) {
> +			idxd_wq_disable_cleanup(wq);
> +			wq->state = IDXD_WQ_DISABLED;
> +		}
> +	}
>  	idxd->state = IDXD_DEV_CONF_READY;
>  	return 0;
>  }
>  
>  void idxd_device_reset(struct idxd_device *idxd)
>  {
> +	int i;
> +
>  	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		struct idxd_wq *wq = &idxd->wqs[i];
> +
> +		if (wq->state == IDXD_WQ_ENABLED) {
> +			idxd_wq_disable_cleanup(wq);
> +			wq->state = IDXD_WQ_DISABLED;
> +		}
> +	}

Repeated, how about a helper for this?

> +	idxd->state = IDXD_DEV_CONF_READY;
>  }
>  
>  /* Device configuration bits */

-- 
~Vinod
