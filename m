Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7752C508753
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiDTLus (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359409AbiDTLur (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376FE41FB8
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C896661944
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 11:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3112C385A0;
        Wed, 20 Apr 2022 11:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455281;
        bh=dvRBsHE8IGdVTS+79WI/ToqW69BH3d9dkDQSrYtpHqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhZ8Tf7ZO9+xKivWLEbvt/STxO3+dwoPX9JpecT/WjKubH1bfHQJ639d90Xja86OX
         QJDCZqFiGP6Ed1lyLUBqzHmKNd5AK2i/6o9vBm14ZrgxW3tXQnEi3+V3CCmspZVgzv
         TTPnhvYcfpZRjSrHb1G4oqOxMLXJOtOEof3qE1Yg3a8zozbu9jbdb1cwQ3eFpqXJ1J
         v2qfpO1wuofw8FTeuXYYHZ+Lh7N7ImFv7plF2K0kXGeM5q0Y3dqr2E7nHAaQ1kDVD2
         sLzGtdqCYJIX7nRtO2TXfO5Iv/CuwgEmU6XGzZtaklyPnWHV+u1L3lDcZfkG5pLFr+
         8v3ZXXj3FTvYg==
Date:   Wed, 20 Apr 2022 17:17:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add RO check for wq max_transfer_size
 write
Message-ID: <Yl/y7dN7w05ea2o0@matsya>
References: <164971488154.2200913.10706665404118545941.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971488154.2200913.10706665404118545941.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 15:08, Dave Jiang wrote:
> Block wq_max_transfer_size_store() when the device is configured as
> read-only and not configurable.

Applied, thanks

> 
> Fixes: d7aad5550eca ("dmaengine: idxd: add support for configurable max wq xfer size")
> Reported-by: Bernice Zhang <bernice.zhang@intel.com>
> Tested-by: Bernice Zhang <bernice.zhang@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/sysfs.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 7e19ab92b61a..ec13ca4808f9 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -905,6 +905,9 @@ static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attr
>  	u64 xfer_size;
>  	int rc;
>  
> +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> +		return -EPERM;
> +
>  	if (wq->state != IDXD_WQ_DISABLED)
>  		return -EPERM;
>  
> 

-- 
~Vinod
