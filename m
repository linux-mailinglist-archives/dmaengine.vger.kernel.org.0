Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92793640DBF
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 19:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiLBSqX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 13:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiLBSp5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 13:45:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F971B7BD;
        Fri,  2 Dec 2022 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006739; x=1701542739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XWxJdpquJhmjnEg+41kl3vTulfrJiGCU35Tza1QgcvI=;
  b=ZLqCuX9pbdsbDAtwCBJF8NXBqMlFRHJ+s6kl9N4nXG5NXr8FRzMjSoha
   Vq13orYQp17p3A5oj4IiKSbEmm5hsBU6KWFmI8QQVmNU5dLbmpCCQMrU5
   yw/koRIV8gdFWBYsQSZqSWuBamxjQV3O7iaCfW753ed3WAb9NCJLFKn4s
   /igAYkcO5PKd7dUYrQOh2WU6r/Gb28lgszHgWtOkUjEu9Fd3aCNXF1KPQ
   1oI6VLwocW5WdncuMdsEoY9f7lLKRHYDcs5BF89DAWxXs2olOs3Ucd1GC
   ChLs4D2pGHmfs2CkTI6LQS4Y4/kOc/37DwuzGjFfuG2cyJSm3yKJ2ertX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="402299324"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="402299324"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:45:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="890249286"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="890249286"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.59.223]) ([10.212.59.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:45:39 -0800
Message-ID: <044897a1-e6e1-b80a-e4cb-6b87423680fe@intel.com>
Date:   Fri, 2 Dec 2022 11:45:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] dmaengine: idxd: Do not call DMX TX callbacks during
 workqueue disable
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <93b5d144bfc16e0c0f640d5f7cfaeda6bf08753f.1670005163.git.reinette.chatre@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <93b5d144bfc16e0c0f640d5f7cfaeda6bf08753f.1670005163.git.reinette.chatre@intel.com>
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
> On driver unload any pending descriptors are flushed and pending
> DMA descriptors are explicitly completed:
> idxd_dmaengine_drv_remove() ->
> 	drv_disable_wq() ->
> 		idxd_wq_free_irq() ->
> 			idxd_flush_pending_descs() ->
> 				idxd_dma_complete_txd()
> 
> With this done during driver unload any remaining descriptor is
> likely stuck and can be dropped. Even so, the descriptor may still
> have a callback set that could no longer be accessible. An
> example of such a problem is when the dmatest fails and the dmatest
> module is unloaded. The failure of dmatest leaves descriptors with
> dma_async_tx_descriptor::callback pointing to code that no longer
> exist. This causes a page fault as below at the time the IDXD driver
> is unloaded when it attempts to run the callback:
>   BUG: unable to handle page fault for address: ffffffffc0665190
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0010) - not-present page
> 
> Fix this by clearing the callback pointers on the transmit
> descriptors only when workqueue is disabled.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> History of refactoring made the Fixes: hard to identify by me.
> 
>   drivers/dma/idxd/device.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index b4d7bb923a40..2ac71a34fa34 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1156,6 +1156,7 @@ int idxd_device_load_config(struct idxd_device *idxd)
>   
>   static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
>   {
> +	struct dma_async_tx_descriptor *tx;
>   	struct idxd_desc *desc, *itr;
>   	struct llist_node *head;
>   	LIST_HEAD(flist);
> @@ -1175,6 +1176,15 @@ static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
>   	list_for_each_entry_safe(desc, itr, &flist, list) {
>   		list_del(&desc->list);
>   		ctype = desc->completion->status ? IDXD_COMPLETE_NORMAL : IDXD_COMPLETE_ABORT;
> +		/*
> +		 * wq is being disabled. Any remaining descriptors are
> +		 * likely to be stuck and can be dropped. callback could
> +		 * point to code that is no longer accessible, for example
> +		 * if dmatest module has been unloaded.
> +		 */
> +		tx = &desc->txd;
> +		tx->callback = NULL;
> +		tx->callback_result = NULL;
>   		idxd_dma_complete_txd(desc, ctype, true);
>   	}
>   }
