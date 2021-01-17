Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB32F9126
	for <lists+dmaengine@lfdr.de>; Sun, 17 Jan 2021 07:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbhAQGwC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Jan 2021 01:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbhAQGwB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 17 Jan 2021 01:52:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40969225AB;
        Sun, 17 Jan 2021 06:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610866280;
        bh=vG+J9APes8J0m0f2grpuwLre6SuSqXYglFVwiE+/wDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/zl82NFy7D7HkDxE6YuvBiifGRjpqgy9nsP3H6Er/n3ZtC+0o9f0f+W0Z0sEn8/v
         hf2RpVuVYnRv7LnXltQBNhNK1C0Kdr2NsIfL41iw9NC0p14QJEX088a6bEQDaB29oN
         NiKzb7tqlSpEvbwWBDEAoqU58jRf52cQr0ncBQ12HpaUqMehk1as4y/Rw/y+D3E6On
         Piq1vVwmFtxO0dpMheYx8vwww+eanbUF14t71KWf/bydSGesuz9fXIoFbK+UIgkCxS
         4tJ/eC3LrrRFet0NzIvnucs7N0jrhHhQ0gxCeQA6cHeq19MSsuW3uz55TjHsW81X5v
         6Kl+SxfcbsAnA==
Date:   Sun, 17 Jan 2021 12:21:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add module parameter to force disable
 of SVA
Message-ID: <20210117065115.GL2771@vkoul-mobl>
References: <161074811013.2184257.13335125853932003159.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161074811013.2184257.13335125853932003159.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-21, 15:01, Dave Jiang wrote:
> Add a module parameter that overrides the SVA feature enabling. This keeps
> the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
> the descriptor fields must be programmed with dma_addr_t from the Linux DMA
> API for source, destination, and completion descriptors.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 25cc947c6179..9687a24ff982 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -26,6 +26,10 @@ MODULE_VERSION(IDXD_DRIVER_VERSION);
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
>  
> +static bool sva = true;
> +module_param(sva, bool, 0644);
> +MODULE_PARM_DESC(sva, "Toggle SVA support on/off");

Documentation for this please..

> +
>  #define DRV_NAME "idxd"
>  
>  bool support_enqcmd;
> @@ -338,12 +342,14 @@ static int idxd_probe(struct idxd_device *idxd)
>  	idxd_device_init_reset(idxd);
>  	dev_dbg(dev, "IDXD reset complete\n");
>  
> -	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM)) {
> +	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
>  		rc = idxd_enable_system_pasid(idxd);
>  		if (rc < 0)
>  			dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
>  		else
>  			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> +	} else if (!sva) {
> +		dev_warn(dev, "User forced SVA off via module param.\n");
>  	}
>  
>  	idxd_read_caps(idxd);
> 

-- 
~Vinod
