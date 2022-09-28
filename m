Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB85EE0F1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiI1PzA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiI1Py7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 11:54:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93D6CD35;
        Wed, 28 Sep 2022 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664380497; x=1695916497;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9MKHF7JkWunOqxKkhskGg+gBY8oemgkga1v6mW2c5o4=;
  b=cr11p44tKyjGKvgqbI3BkMN0P747c4rcV2YEvuJS4z7Sf/chrihurO4p
   LzjkmSz6RjK8K3sXeEwNG1sOOuejC6othRLwd786DAeZjuL/syfVOb6EJ
   sMWz8fNVPdE+0SXaKe4l1V3q57TlVuKJREei5+FRo0RXqAopcVggfQZQr
   heVmJHqI/BVWJ404rNMxRgvOVwG/evVl9pi9hprk3/K1MgoWeHCOIMeHz
   lMn8ChOBbOYHuUx/7F2ApV7CT2UV/Zs5hXk4ggidfvh4XBUdEMnWcqK9J
   sRQMv+UQtQVaLBneyiJE/KLS8rkUQ3g3MBSRjztI17pkvCpM1ITBDSZC2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="281354778"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="281354778"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:54:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="573084272"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="573084272"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.153]) ([10.212.108.153])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:54:54 -0700
Message-ID: <77b8714b-aa3f-3866-72a2-e706428d2657@intel.com>
Date:   Wed, 28 Sep 2022 08:54:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] dmaengine: idxd: Set wq state to disabled in
 idxd_wq_disable_cleanup()
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220928154856.623545-1-jsnitsel@redhat.com>
 <20220928154856.623545-2-jsnitsel@redhat.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220928154856.623545-2-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/28/2022 8:48 AM, Jerry Snitselaar wrote:
> If we are calling idxd_wq_disable_cleanup(), the workqueue should be
> in a disabled state. So set the workqueue state to IDXD_WQ_DISABLED so
> that the state reflects that. Currently if there is a device failure,
> and a software reset is attempted the workqueues will not be
> re-enabled due to idxd_wq_enable() seeing that state as already being
> IDXD_WQ_ENABLED.
>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/dma/idxd/device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5a8cc52c1abf..31911e255ac1 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -258,7 +258,6 @@ void idxd_wq_reset(struct idxd_wq *wq)
>   	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
>   	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
>   	idxd_wq_disable_cleanup(wq);
> -	wq->state = IDXD_WQ_DISABLED;
>   }
>   
>   int idxd_wq_map_portal(struct idxd_wq *wq)
> @@ -378,6 +377,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>   	struct idxd_device *idxd = wq->idxd;
>   
>   	lockdep_assert_held(&wq->wq_lock);
> +	wq->state = IDXD_WQ_DISABLED;
>   	memset(wq->wqcfg, 0, idxd->wqcfg_size);
>   	wq->type = IDXD_WQT_NONE;
>   	wq->threshold = 0;
