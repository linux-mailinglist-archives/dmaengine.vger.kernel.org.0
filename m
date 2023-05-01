Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5A6F3246
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjEAOuH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 10:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjEAOuE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 10:50:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE4170F;
        Mon,  1 May 2023 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682952604; x=1714488604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gym2ezxaHcZQuFdNdpyJJWZDpiA/Sh4ZC61IYFghcnQ=;
  b=m36tAQcWosfHImEkcrdagHTsV3ZYeKk2OpB0hSOM7T2T8GqnN65PxC3b
   TEsMZh+xGwpYnNvH1MBPL+s7H3dHswClynO46JIUTa52x/lzJxRlXEB7E
   QK86gO0umP1S2/XyOAFllIzlwgMBsGyfj8nL1cR6MVWFvlQeTDz2yWZNy
   bhxsjCib2I4CeGzQ1P4P0BFkSRo5o5P8+1lKvkzbosMpFa0sYClpyrjAQ
   gkKBvQ1dsY+GuBsA4FyhFGHexMvboJhjJdNorqB0FwFfIQMh785JSd5jf
   fcGEXhSpJ8yDHyCucVPGRCFy8ICTVblLVxknWeiPH61wDrhIKPlIbEOJn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="413592238"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="413592238"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="698558186"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="698558186"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.85.208]) ([10.212.85.208])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:50:02 -0700
Message-ID: <f15d37e6-a352-9f5b-2cb7-ef2d48b2c977@intel.com>
Date:   Mon, 1 May 2023 07:50:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 06/15] dmaengine: idxd: Add private_data to struct
 idxd_wq
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
 <20230428205539.113902-7-tom.zanussi@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230428205539.113902-7-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/28/23 1:55 PM, Tom Zanussi wrote:
> Add a void * to idxd_wqs for user-defined context data, along with
> accessors set_idxd_wq_private() and idxd_wq_private().
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/idxd.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 719f9f1662ad..0402f97d6ff8 100644
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
> @@ -550,6 +552,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
>   	return wq->client_count;
>   };
>   
> +static inline void set_idxd_wq_private(struct idxd_wq *wq, void *private)
> +{
> +	wq->private_data = private;
> +}
> +
> +static inline void *idxd_wq_private(struct idxd_wq *wq)
> +{
> +	return wq->private_data;
> +}
> +
>   /*
>    * Intel IAA does not support batch processing.
>    * The max batch size of device, max batch size of wq and
