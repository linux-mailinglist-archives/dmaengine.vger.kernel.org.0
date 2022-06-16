Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63F154D64D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 02:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbiFPAwy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 20:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348640AbiFPAww (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 20:52:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF126133
        for <dmaengine@vger.kernel.org>; Wed, 15 Jun 2022 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655340771; x=1686876771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f1pcFp345Ly/M7Mkkv+H/7wNMi6/EQFnEy5JaE3dl38=;
  b=nw4IMQgCZDTqiDpEPAk4gE4l+Uif85lyvdtcmni6Qys05xLUmHIAwlSN
   H9d9oxwOcYOluD/CDbU3rOdw18Vk5WCKNuAgy5SVKOu6q4FirCnYznmFj
   dEiqs/+zRt0J0leFqItZA5TCIbqTQxBJZ82Q3JvCQnXi7pHZU4zwWU4Xj
   Md50B4IM7vuJhUVEoDSZpj1dBEMU48EYVUekQumbheRwxohTuhRt4GlVc
   fe/Kwd/wIvqOiXzDMVe5jQENSl4df2Njrd4SgLqP+IUH82IyxKqMZHHSJ
   Q0bJTRTJYWHzzi/JoTyAfJzkUfcu3PPRddm2Bf/6RvJtakWA7BPIzmm5N
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304573676"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="304573676"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 17:52:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="727667352"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 17:52:50 -0700
Date:   Wed, 15 Jun 2022 17:53:12 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: force wq context cleanup on device
 disable path
Message-ID: <Yqp++PKEmV8GNvye@fyu1.sc.intel.com>
References: <20220615234219.178186-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615234219.178186-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 15, 2022 at 04:42:19PM -0700, Fenghua Yu wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Testing shown that when a wq mode is setup to be dedicated and then torn
> down and reconfigured to shared, the wq configured end up being dedicated
> anyays. The root cause is when idxd_device_wqs_clear_state() gets called
> during idxd_driver removal, idxd_wq_disable_cleanup() does not get called
> vs when the wq driver is removed first. The check of wq state being
> "enabled" causes the cleanup to be bypassed. However, idxd_driver->remove()
> releases all wq drivers. So the wqs goes to "disabled" state and will never
> be "enabled". By that point, the driver has no idea if the wq was
> previously configured or clean. So force call idxd_wq_disable_cleanup() on
> all wqs always to make sure everything gets cleaned up.
> 
> Reported-by: Tony Zhu <tony.zhu@intel.com>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> Fixes: 0dcfe41e9a4c ("dmanegine: idxd: cleanup all device related bits after disabling device")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
> Change Log:
> v2:
> - Re-based to 5.19-rc2 so that it can be applied cleanly. No functionality
>   change.
> 
> v1:
> https://patchwork.kernel.org/project/linux-dmaengine/patch/165090959239.1376825.18183942742142655091.stgit@djiang5-desk3.ch.intel.com/
> 
>  drivers/dma/idxd/device.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index ff0ea60051f0..5a8cc52c1abf 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -716,10 +716,7 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
>  		struct idxd_wq *wq = idxd->wqs[i];
>  
>  		mutex_lock(&wq->wq_lock);
> -		if (wq->state == IDXD_WQ_ENABLED) {
> -			idxd_wq_disable_cleanup(wq);
> -			wq->state = IDXD_WQ_DISABLED;
> -		}
> +		idxd_wq_disable_cleanup(wq);
>  		idxd_wq_device_reset_cleanup(wq);
>  		mutex_unlock(&wq->wq_lock);
>  	}
> -- 
> 2.32.0
> 
