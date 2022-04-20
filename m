Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63572508758
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357175AbiDTLvY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiDTLvX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:51:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EF41FBB
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07F0BB81D1B
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 11:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45235C385A0;
        Wed, 20 Apr 2022 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455315;
        bh=ui1CbVkkIymz7nGS7kB9s1/3U4u2fusBw1hNDos0xAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxNtZguE09kAF8TTTekU/v3o84D4ESBTz+ywzVfErNNE7JbAdI/fx+SquOR5pJeMO
         vwoI0MijOBNlrf8hWH5/GCi0nKdN6sOhWEQDZ6Zc7ywruae5HhuVMrgd1r+z+nGAvp
         /qODHJDfjhGUM18JVpx904SmelI+kS+aUfJOo7RIx9vsL4pI/RgABLOPyVUGawMrTS
         VPIy1iuueRGJ5G3MuvIpQj4hzOvBEQA0KUtjBWF2nZMBUM/RrG1Qb40770V22oWjWT
         QNEICZz4dN1Wpduv3K5KQ1/Lid8O9zlA4WPAjk/pRHqUZsCPy7mPUtfFJccInMvZFp
         Eg1iBaXr4FQbg==
Date:   Wed, 20 Apr 2022 17:18:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: set max_xfer and max_batch for RO device
Message-ID: <Yl/zEJN0oCkCYUGa@matsya>
References: <164971507673.2201761.11244446608988838897.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971507673.2201761.11244446608988838897.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 15:11, Dave Jiang wrote:
> Load the max_xfer_size and max_batch_size values from the values read from
> registers to the shadow variables. This will allow the read-only device to
> display the correct values for the sysfs attributes.

Applied, thanks

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index f652da6ab47d..95c8c7d8d419 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1018,6 +1018,9 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
>  
>  	wq->priority = wq->wqcfg->priority;
>  
> +	wq->max_xfer_bytes = 1ULL << wq->wqcfg->max_xfer_shift;
> +	wq->max_batch_size = 1ULL << wq->wqcfg->max_batch_shift;
> +
>  	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
>  		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
>  		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n", wq->id, i, wqcfg_offset, wq->wqcfg->bits[i]);
> 

-- 
~Vinod
