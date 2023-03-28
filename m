Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636246CC769
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjC1QEG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1QEF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:04:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CADD109;
        Tue, 28 Mar 2023 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680019444; x=1711555444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SfGRpCf7OIzFTMmIf1Wn3fEO6wTX8X/ZvQC/5/Sa2vQ=;
  b=MVUQFnz6302jsmdezMR3MK++pGj9sYT94Fr5CR+mz37KNihV4P8+k/3m
   3hK6081CtegIR0OMnKiXsejCLBNSrEOJYCqi+EYWWtQJxGqei2yOhBYDb
   TYcTHu/2ePcUK/Hb2qEdlRLMUdNdF+yum28tVhYa67LHqw3vHgRSPcyON
   UCTQjEqe5FM8xXsNAq6Um4sOXf7RAmyM88FxmZyQJ6zlZVjAoUUG77bFL
   P0oN6IBVdV/m9B883Qcpe/fCuzs1xqg3oYSwy+/0w5O2DzwGHyCkgcyxm
   WbLCQgmivzZmoC7h6crMs7KtdjTaR/3o1xSn82qP6fzdj3xXE86eAcnzF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403223354"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403223354"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="794882439"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="794882439"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.40.188]) ([10.212.40.188])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:02:46 -0700
Message-ID: <ff0d983c-ad72-6075-c0e3-a9cee1ac46f4@intel.com>
Date:   Tue, 28 Mar 2023 09:02:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 03/15] dmaengine: idxd: Export drv_enable/disable and
 related functions
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
 <20230328153535.126223-4-tom.zanussi@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230328153535.126223-4-tom.zanussi@linux.intel.com>
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
> To allow idxd sub-drivers to enable and disable wqs, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/device.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5f321f3b4242..af1aa88a66c1 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1406,6 +1406,7 @@ int drv_enable_wq(struct idxd_wq *wq)
>   err:
>   	return rc;
>   }
> +EXPORT_SYMBOL_NS_GPL(drv_enable_wq, IDXD);
>   
>   void drv_disable_wq(struct idxd_wq *wq)
>   {
> @@ -1427,6 +1428,7 @@ void drv_disable_wq(struct idxd_wq *wq)
>   	wq->type = IDXD_WQT_NONE;
>   	wq->client_count = 0;
>   }
> +EXPORT_SYMBOL_NS_GPL(drv_disable_wq, IDXD);
>   
>   int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
>   {
