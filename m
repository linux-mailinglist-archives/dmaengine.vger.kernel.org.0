Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B86CC77D
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjC1QH5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjC1QHz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:07:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D79901C;
        Tue, 28 Mar 2023 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680019674; x=1711555674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ICf4i7CHa9goK8a6BkcrdNDcMYQ960/5IYY5hCdayfU=;
  b=Ml0NoIGBP/M6/TTyO8MHgMWug+CKQvv0zVnpuMWKuhisYBqYj+7ksXHu
   BrrlTSVFIEMMzxAmlt6koKzBLqOuPhdoqXolTqVpAP4ywTGNBKUPY+gVy
   ztEh3e+KWA+rNdIP30TPewxtz3JtnRGqz2a5jIhANC4V5KSOfD8ijn9UN
   RcSCiqOINN3zMVGXv29S20zp/SKjjP+epN3R/vV0EhycF1Z4c5C5zvf/B
   LyueiDmUaWIqO/yKfum8bCp7oV/pm9Sy2dlz+U2KI5o2s48l9jqh+tOUp
   hJ+cgLP63DY4jzoNSu2i6evNeB91zKDtwTZHb2JNnjdAfBYJRem/rTvLI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340633518"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340633518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="929966389"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="929966389"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.40.188]) ([10.212.40.188])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:04:50 -0700
Message-ID: <2b6bedf1-eb65-ac19-a172-bc0516335916@intel.com>
Date:   Tue, 28 Mar 2023 09:04:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 05/15] dmaengine: idxd: Export wq resource management
 functions
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
 <20230328153535.126223-6-tom.zanussi@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230328153535.126223-6-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/28/23 8:35 AM, Tom Zanussi wrote:
> To allow idxd sub-drivers to access the wq resource management
> functions, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/device.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index af1aa88a66c1..7837d0a56314 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -161,6 +161,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
>   	free_hw_descs(wq);
>   	return rc;
>   }
> +EXPORT_SYMBOL_NS_GPL(idxd_wq_alloc_resources, IDXD);
>   
>   void idxd_wq_free_resources(struct idxd_wq *wq)
>   {
> @@ -174,6 +175,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
>   	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
>   	sbitmap_queue_free(&wq->sbq);
>   }
> +EXPORT_SYMBOL_NS_GPL(idxd_wq_free_resources, IDXD);
>   
>   int idxd_wq_enable(struct idxd_wq *wq)
>   {
> @@ -422,6 +424,7 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq)
>   	reinit_completion(&wq->wq_resurrect);
>   	return 0;
>   }
> +EXPORT_SYMBOL_NS_GPL(idxd_wq_init_percpu_ref, IDXD);
>   
>   void __idxd_wq_quiesce(struct idxd_wq *wq)
>   {
> @@ -431,6 +434,7 @@ void __idxd_wq_quiesce(struct idxd_wq *wq)
>   	complete_all(&wq->wq_resurrect);
>   	wait_for_completion(&wq->wq_dead);
>   }
> +EXPORT_SYMBOL_NS_GPL(__idxd_wq_quiesce, IDXD);
>   
>   void idxd_wq_quiesce(struct idxd_wq *wq)
>   {
> @@ -438,6 +442,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq)
>   	__idxd_wq_quiesce(wq);
>   	mutex_unlock(&wq->wq_lock);
>   }
> +EXPORT_SYMBOL_NS_GPL(idxd_wq_quiesce, IDXD);
>   
>   /* Device control bits */
>   static inline bool idxd_is_enabled(struct idxd_device *idxd)
