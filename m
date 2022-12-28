Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DC65736F
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 08:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiL1HAh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 02:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiL1HAY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 02:00:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F32EB9B;
        Tue, 27 Dec 2022 23:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD2F612F5;
        Wed, 28 Dec 2022 07:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9442BC433EF;
        Wed, 28 Dec 2022 07:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672210822;
        bh=UTg1APtDgewyvsjCQ8Y8Vtlggt5/wTplwHDPwJWVb3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlxYyAtuOhViZbuRX+1zpaLmHfe8JNduRlYiLvnb1cMwgaG37Lcj3BYrsLdbxYWVV
         /JNEZOCnU954+YL+i6LAUVh6+PL2u6HcBh2b4rjXuC5T+IteHOKkwcY810q3Q+iZwR
         xP1KICzcob1dw2giy28iRzBhm17flyXw8Nh/OcnIS64dYC0dsMtZzIC2o80fJp44ST
         XJN/pNRY2FfpD/hJ7jhReQPaYIutPV3NOlDBpLAlUdYSbRwA/ke9UuPoIpWZC8msMU
         vKz/W+wat0kTudkB2HyE+4f4MPXn+FntIdTy4eq7aeSbB6UsqgK20zpY4PBK/AVq7M
         8U2oF/yhTQTtw==
Date:   Wed, 28 Dec 2022 12:30:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Set traffic class values in GRPCFG on
 DSA 2.0
Message-ID: <Y6vpgh4cGFBG0PB9@matsya>
References: <20221209172141.562648-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209172141.562648-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-22, 09:21, Fenghua Yu wrote:
> On DSA/IAX 1.0, TC-A and TC-B in GRPCFG are set as 1 to have best
> performance and cannot be changed through sysfs knobs unless override
> option is given.
> 
> The same values should be set on DSA 2.0 as well.

Applied, thanks

> 
> Fixes: ea7c8f598c32 ("dmaengine: idxd: restore traffic class defaults after wq reset")
> Fixes: ade8a86b512c ("dmaengine: idxd: Set defaults for GRPCFG traffic class")
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c | 2 +-
>  drivers/dma/idxd/init.c   | 2 +-
>  drivers/dma/idxd/sysfs.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index b55405efd4ab..901257081524 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -834,7 +834,7 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
>  		group->use_rdbuf_limit = false;
>  		group->rdbufs_allowed = 0;
>  		group->rdbufs_reserved = 0;
> -		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
> +		if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override) {
>  			group->tc_a = 1;
>  			group->tc_b = 1;
>  		} else {
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 1053e2bb4e9f..4ecd34200998 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -314,7 +314,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>  		}
>  
>  		idxd->groups[i] = group;
> -		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
> +		if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override) {
>  			group->tc_a = 1;
>  			group->tc_b = 1;
>  		} else {
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 632166538458..9db35011037f 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -388,7 +388,7 @@ static ssize_t group_traffic_class_a_store(struct device *dev,
>  	if (idxd->state == IDXD_DEV_ENABLED)
>  		return -EPERM;
>  
> -	if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override)
> +	if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override)
>  		return -EPERM;
>  
>  	if (val < 0 || val > 7)
> @@ -430,7 +430,7 @@ static ssize_t group_traffic_class_b_store(struct device *dev,
>  	if (idxd->state == IDXD_DEV_ENABLED)
>  		return -EPERM;
>  
> -	if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override)
> +	if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override)
>  		return -EPERM;
>  
>  	if (val < 0 || val > 7)
> -- 
> 2.32.0

-- 
~Vinod
