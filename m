Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B718508755
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378243AbiDTLvB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378248AbiDTLu7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:50:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E20A42490
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52A96B81D0B
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 11:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D273C385A4;
        Wed, 20 Apr 2022 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455290;
        bh=RsOa34uW8IIiG4T8FkGIGAHvHihs8l5moPx/ob4Ljr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJg2JmmIraCHulh3m2LqsLEqZqu1DCV61JmEkDLhkOy2r9exarYrIibo69Ybm84l/
         y1AZBDdV7lBAy3YdHUJ4VQ0ZKJdqyiOEhQLm+Att6MrTyOMoLM+Mbonlbv0OdY9g9b
         eDsQFdrJ9BOEjXwcKUAqsfro+da8jVbKJRa172MjkNJRNw47YuiclazPFw7BYizHuh
         GtWX+HcMM3Dz8ANo6zfvL0pmqSspZoWsAQQ+Gy+PeMoClXELfg/WpTkJTKqXqar3LL
         7W5/977xn0bjCspTcLYFumuCAqs+iuBiQl8A+AgjphVDe6ZSwC6fOpjtTabzrVXG1Q
         Dtpu5jYrugdkg==
Date:   Wed, 20 Apr 2022 17:18:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add RO check for wq max_batch_size write
Message-ID: <Yl/y93YXk5tLZg+n@matsya>
References: <164971493551.2201159.1942042593642155209.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971493551.2201159.1942042593642155209.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 15:08, Dave Jiang wrote:
> Block wq_max_batch_size_store() when the device is configured as read-only
> and not configurable.

Applied, thanks

> 
> Fixes: e7184b159dd3 ("dmaengine: idxd: add support for configurable max wq batch size")
> Reported-by: Bernice Zhang <bernice.zhang@intel.com>
> Tested-by: Bernice Zhang <bernice.zhang@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/sysfs.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index ec13ca4808f9..dfd549685c46 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -942,6 +942,9 @@ static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribu
>  	u64 batch_size;
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
