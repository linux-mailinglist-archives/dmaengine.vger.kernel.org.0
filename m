Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86414640DB4
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 19:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiLBSpQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 13:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiLBSo6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 13:44:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40551ECA12;
        Fri,  2 Dec 2022 10:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006652; x=1701542652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z/uoUePeBIOKWcysNyPx10MaSIwqemrIxfZ48MiErAQ=;
  b=mh8yAAPqLmw7vPsB1GC6Z1HQeOHZ1vDmyZGEKSuBPDu6+czYESLctrO/
   0ojLTLHWQNAL5USiKPTu6Npp6kI5nyaaNROo2JFVNEKFt1D972EJKPLJT
   OQbewmabXyW6rKQTW8UvFHnB6Nh1/2pp8d8A6l3QP2hcOHkyMlQfVRpv4
   2uHWsNIx5wi/SUd5d0lH6/t4NrmQu770asvYgNsxnq/op4PQ2/uUEEuR+
   u2darmcDa2uVhrbFThp99nNJfZMo4g23FbVw5O6lOxBSowalFjfXQdq7c
   9UadS+F2+TAc8thE7qc7AchA9y0vHTshgb20ESpGep9spkOCDV6oE20CW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="380308321"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="380308321"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:44:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="647266583"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="647266583"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.59.223]) ([10.212.59.223])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:44:11 -0800
Message-ID: <13d4bbcb-244e-df72-4281-755d4bc51274@intel.com>
Date:   Fri, 2 Dec 2022 11:44:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] dmaengine: idxd: Let probe fail when workqueue cannot
 be enabled
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <1e74e8d74255ff47271c4c9eada7635676ccd320.1670005163.git.reinette.chatre@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1e74e8d74255ff47271c4c9eada7635676ccd320.1670005163.git.reinette.chatre@intel.com>
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
> The workqueue is enabled when the appropriate driver is loaded and
> disabled when the driver is removed. When the driver is removed it
> assumes that the workqueue was enabled successfully and proceeds to
> free allocations made during workqueue enabling.
> 
> Failure during workqueue enabling does not prevent the driver from
> being loaded. This is because the error path within drv_enable_wq()
> returns success unless a second failure is encountered
> during the error path. By returning success it is possible to load
> the driver even if the workqueue cannot be enabled and
> allocations that do not exist are attempted to be freed during
> driver remove.
> 
> Some examples of problematic flows:
> (a)
> 
>   idxd_dmaengine_drv_probe() -> drv_enable_wq() -> idxd_wq_request_irq():
>   In above flow, if idxd_wq_request_irq() fails then
>   idxd_wq_unmap_portal() is called on error exit path, but
>   drv_enable_wq() returns 0 because idxd_wq_disable() succeeds. The
>   driver is thus loaded successfully.
> 
>   idxd_dmaengine_drv_remove()->drv_disable_wq()->idxd_wq_unmap_portal()
>   Above flow on driver unload triggers the WARN in devm_iounmap() because
>   the device resource has already been removed during error path of
>   drv_enable_wq().
> 
> (b)
> 
>   idxd_dmaengine_drv_probe() -> drv_enable_wq() -> idxd_wq_request_irq():
>   In above flow, if idxd_wq_request_irq() fails then
>   idxd_wq_init_percpu_ref() is never called to initialize the percpu
>   counter, yet the driver loads successfully because drv_enable_wq()
>   returns 0.
> 
>   idxd_dmaengine_drv_remove()->__idxd_wq_quiesce()->percpu_ref_kill():
>   Above flow on driver unload triggers a BUG when attempting to drop the
>   initial ref of the uninitialized percpu ref:
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
> 
> Fix the drv_enable_wq() error path by returning the original error that
> indicates failure of workqueue enabling. This ensures that the probe
> fails when an error is encountered and the driver remove paths are only
> attempted when the workqueue was enabled successfully.
> 
> Fixes: 1f2bb40337f0 ("dmaengine: idxd: move wq_enable() to device.c")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/device.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 6f44fa8f78a5..fcd03d29a941 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1391,8 +1391,7 @@ int drv_enable_wq(struct idxd_wq *wq)
>   err_irq:
>   	idxd_wq_unmap_portal(wq);
>   err_map_portal:
> -	rc = idxd_wq_disable(wq, false);
> -	if (rc < 0)
> +	if (idxd_wq_disable(wq, false))
>   		dev_dbg(dev, "wq %s disable failed\n", dev_name(wq_confdev(wq)));
>   err:
>   	return rc;
