Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAB6CC779
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjC1QHp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC1QHo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:07:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A25510F6;
        Tue, 28 Mar 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680019663; x=1711555663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Pk4FiBJjOSPuOw+RSmdkla7bOOKf+jR/X63CAOR1Mc=;
  b=MGOaRiXwOA9+JbIMKlAoqH6rfrwuDnSnGytaYh37J5mXAKx0hzlAsez4
   NilUIvtq8/lkBEjY5sq/2u/vMuD3DVY46NKi4LYP5ARRS+ryV8gmt/2jY
   zZ2gjAhV6Qz/2mZiENKZk/GlrZ8BQxVx0jik7HrUClETCh4HELMwhhSAi
   x0i9WWhgOFQAQfis94s1+Hj3tBre9hg4mbonYP57PggA7srXx1vcHNXPY
   csG4REmOTqtuPDrAcIulwg8bvInYtnepaDyyRdzc5Ia38KAhoVTItAAlx
   BkrMEtan9y3UnOeC+uaj4gSqWmFPpDlGU6XsE6bRrMgCZSXmdfFKkLRbh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="329068987"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="329068987"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686477021"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="686477021"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.40.188]) ([10.212.40.188])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:06:39 -0700
Message-ID: <c90984be-a426-7658-b128-67f90e4262da@intel.com>
Date:   Tue, 28 Mar 2023 09:06:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 06/15] dmaengine: idxd: Add private_data to struct
 idxd_wq
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
 <20230328153535.126223-7-tom.zanussi@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230328153535.126223-7-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/28/23 8:35 AM, Tom Zanussi wrote:
> Add a void * to idxd_wqs for user-defined context data.

I wonder if we should add accessor functions like get and set private 
data for the wq.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>   drivers/dma/idxd/idxd.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 719f9f1662ad..e55213b5153e 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -216,6 +216,8 @@ struct idxd_wq {
>   	u32 max_batch_size;
>   
>   	char driver_name[WQ_NAME_SIZE + 1];
> +
> +	void *private_data;
>   };
>   
>   struct idxd_engine {
