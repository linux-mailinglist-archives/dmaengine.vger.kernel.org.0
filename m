Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E13640DB7
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 19:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiLBSpn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 13:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiLBSpR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 13:45:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1265ED692;
        Fri,  2 Dec 2022 10:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006689; x=1701542689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=taKiwsGEnARe6PdQIcFBdyd/qfTN56kU+jLa9R4yhOE=;
  b=ZRLKhSYgPmbtXemcjjmpN5QS0xSb+nNNG2RxgraqJDm/9Dm+tJ/cKPaQ
   aNLCQGvdIHbF7Wdfv1eov18gZY/aiLzUMBKsuo+QykPJNGRTkgawA2T/P
   8c80IfXrcjhzKUsAxsRjkWKruerwODcfQHQZ/9JmkAZr/mKWtu3Zajkff
   dxdJqAFgRrKxc9MX0kzOlf4ynSTq7ssHEa1mzjkcETPRBu0IMT6TJ33Cf
   9O+5KVS1A+/Noy7qYn41xai5WDD6zILa/3nK1Y3iAshBpjB6Q468EX0iA
   SK46tT1567iM9EL9csSFQVBvRToHkJyfHcm12kgQzuHi/8jvLsClCGv85
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="380308446"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="380308446"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:44:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="647266661"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="647266661"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.59.223]) ([10.212.59.223])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:44:44 -0800
Message-ID: <cef94a59-6291-4af3-4677-3a3772571667@intel.com>
Date:   Fri, 2 Dec 2022 11:44:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] dmaengine: idxd: Prevent use after free on completion
 memory
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <96e5bcd4b97445227837c3a73e1a1abd93d26175.1670005163.git.reinette.chatre@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <96e5bcd4b97445227837c3a73e1a1abd93d26175.1670005163.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/2/2022 11:25 AM, Reinette Chatre wrote:
> On driver unload any pending descriptors are flushed at the
> time the interrupt is freed:
> idxd_dmaengine_drv_remove() ->
> 	drv_disable_wq() ->
> 		idxd_wq_free_irq() ->
> 			idxd_flush_pending_descs().
> 
> If there are any descriptors present that need to be flushed this
> flow triggers a "not present" page fault as below:
> 
>   BUG: unable to handle page fault for address: ff391c97c70c9040
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
> 
> The address that triggers the fault is the address of the
> descriptor that was freed moments earlier via:
> drv_disable_wq()->idxd_wq_free_resources()
> 
> Fix the use after free by freeing the descriptors after any possible
> usage. This is done after idxd_wq_reset() to ensure that the memory
> remains accessible during possible completion writes by the device.
> 
> Fixes: 63c14ae6c161 ("dmaengine: idxd: refactor wq driver enable/disable operations")
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index fcd03d29a941..b4d7bb923a40 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1408,11 +1408,11 @@ void drv_disable_wq(struct idxd_wq *wq)
>   		dev_warn(dev, "Clients has claim on wq %d: %d\n",
>   			 wq->id, idxd_wq_refcount(wq));
>   
> -	idxd_wq_free_resources(wq);
>   	idxd_wq_unmap_portal(wq);
>   	idxd_wq_drain(wq);
>   	idxd_wq_free_irq(wq);
>   	idxd_wq_reset(wq);
> +	idxd_wq_free_resources(wq);
>   	percpu_ref_exit(&wq->wq_active);
>   	wq->type = IDXD_WQT_NONE;
>   	wq->client_count = 0;
