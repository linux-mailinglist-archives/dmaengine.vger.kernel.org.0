Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34961705A0C
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjEPV6K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 17:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEPV6J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 17:58:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6071987;
        Tue, 16 May 2023 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684274285; x=1715810285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NSB1DDJvWd6GUYsrQHxUG9mD9q935otky3mP/KcLA58=;
  b=PiOKO5J2oxO+DsRolmgXZiA3mldTkF+CXxu4HgKd7mB5M512mmVl6Y/l
   Q+gFc9NLlqSFZHOpxMVRgx/b7zFAybX6xPwrckkLxaHxhai/Mr06FpJDI
   iPbQU7WhVwMb3/DwPVywJ7IzE0T4TIqmYdIn4qsziq29Y4wlL3eG2sfnq
   ag3RmMd/ki3lAPbPf0zaitPoXJRveQRb8PxQtuUhKiCKgo0+lqb3MQs/Y
   j87sxczLUEaj2JInDiuUcOomcNWIxnpEXkjCRrRwORGN/oMXVRO28D2Cf
   5R2P6klIrzuQ/zfB+AXHTsbd8GLZzBumR+Y+xj76sDvQDf2x9aPZRegTl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="437946915"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="437946915"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="732132627"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="732132627"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.5.122]) ([10.212.5.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:57:52 -0700
Message-ID: <c6becc30-ce5d-8290-54c7-f2a6497f4200@intel.com>
Date:   Tue, 16 May 2023 14:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 06/15] dmaengine: idxd: Add wq private data accessors
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
References: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
 <20230516215009.51794-7-tom.zanussi@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230516215009.51794-7-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/16/23 2:50 PM, Tom Zanussi wrote:
> Add the accessors idxd_wq_set_private() and idxd_wq_get_private()
> allowing users to set and retrieve a private void * associated with an
> idxd_wq.
> 
> The private data is stored in the idxd_dev.conf_dev associated with
> each idxd_wq.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/idxd.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 276b5f9cf967..971daf323655 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -609,6 +609,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
>   	return wq->client_count;
>   };
>   
> +static inline void idxd_wq_set_private(struct idxd_wq *wq, void *private)
> +{
> +	dev_set_drvdata(wq_confdev(wq), private);
> +}
> +
> +static inline void *idxd_wq_get_private(struct idxd_wq *wq)
> +{
> +	return dev_get_drvdata(wq_confdev(wq));
> +}
> +
>   /*
>    * Intel IAA does not support batch processing.
>    * The max batch size of device, max batch size of wq and
