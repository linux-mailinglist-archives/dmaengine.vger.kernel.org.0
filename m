Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC56CC773
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjC1QGX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1QGW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:06:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2603C20;
        Tue, 28 Mar 2023 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680019581; x=1711555581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eNtaKXmkmrkIbyVUtNATNkoD7JNG1MAIWOW5v+8QpyM=;
  b=EtbQSveAS4Qgntvqk2Jnwp8AAu6nc1jLtRn2PsFQDAKJRXtNCQ5M9Qnm
   1DWIBn2MXd7PHdvYJZGOVFdGhc2GS7ZLbx8gZEfbMZJi/rZ+lTcnO6fvo
   aguZ2n0HiO2DrKNhX6OMyM2DYaLaWcu5V1TSmZyRa2uZTUOLlZJcc+Rt7
   gBiKgqxHjl3wDvTb/vw2qPvLNY5MP4h3IqOX09vXIhiRn5YgEtzqBbVp9
   pjmZeYccUDnyCqB0hh+RjBFhFt/raE5t+iqMgbUs3nxrb0MTTTOlgLqlX
   8ltT3vFHtzWS+WSlVmFCwQlBAuCNppMfnJ4wEQyFjWOmXLcZ8dvrYIguD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403224085"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403224085"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="794882781"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="794882781"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.40.188]) ([10.212.40.188])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:04:22 -0700
Message-ID: <79d0618f-950c-f2f0-7286-41e199ba0edb@intel.com>
Date:   Tue, 28 Mar 2023 09:04:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 04/15] dmaengine: idxd: Export descriptor management
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
 <20230328153535.126223-5-tom.zanussi@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230328153535.126223-5-tom.zanussi@linux.intel.com>
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
> To allow idxd sub-drivers to access the descriptor management
> functions, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>   drivers/dma/idxd/submit.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> index c01db23e3333..9d9ec0b76ccd 100644
> --- a/drivers/dma/idxd/submit.c
> +++ b/drivers/dma/idxd/submit.c
> @@ -61,6 +61,7 @@ struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
>   
>   	return __get_desc(wq, idx, cpu);
>   }
> +EXPORT_SYMBOL_NS_GPL(idxd_alloc_desc, IDXD);
>   
>   void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>   {
> @@ -69,6 +70,7 @@ void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>   	desc->cpu = -1;
>   	sbitmap_queue_clear(&wq->sbq, desc->id, cpu);
>   }
> +EXPORT_SYMBOL_NS_GPL(idxd_free_desc, IDXD);
>   
>   static struct idxd_desc *list_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
>   					 struct idxd_desc *desc)
> @@ -215,3 +217,4 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>   	percpu_ref_put(&wq->wq_active);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(idxd_submit_desc);

This one should use the EXPORT_SYMBOL_NS_GPL() as above?
