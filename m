Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740596FB86D
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEHUoQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjEHUn7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 16:43:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543B1BF5;
        Mon,  8 May 2023 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578636; x=1715114636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+j2VG8K37FuYmxJ/yfGPvStthf7F4tgUlNY05wghgQw=;
  b=EqpvZk5YKy8JNqY42+w1//BoJ6dgCBVpoR/uah54MSYyVoNeo23yHXOA
   R0qqOQg/27FGbX4h2qqCyjtzLtV9OqS7BaR3fEPGHg7lsgtTRwPw8N2ks
   F50NbZRdIACTR9KWSir4hSrUi/8j2zZ8hWXqeYKbkBiqYgPXzvOxekhDq
   IV+zpNpN1YuR4XTQDKbly71mC2/eGx9weYlD3XvGrRYmVHpUlPsbV8FJQ
   pZhYC3smx8Tv5btXGP1WGIswYUXB8PYlePfFR87Gp09zTOfA8/w/upyZ2
   FETUqyQLtZpm9YyzzDm8KuHpVGrxDsEP/94eo0tYeIozR1eCx4cchaHLP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347219110"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="347219110"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="698648011"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="698648011"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.172.228]) ([10.213.172.228])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:43:50 -0700
Message-ID: <2618f557-01a5-f76b-ad09-6eb0871cdf00@intel.com>
Date:   Mon, 8 May 2023 13:43:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v4 06/15] dmaengine: idxd: Add wq private data accessors
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
References: <cover.1683573703.git.zanussi@kernel.org>
 <038db785a87dc59c0073989633eee0205958cb67.1683573703.git.zanussi@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <038db785a87dc59c0073989633eee0205958cb67.1683573703.git.zanussi@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/8/23 1:07 PM, Tom Zanussi wrote:
> Add the accessors set_idxd_wq_private() and idxd_wq_private() allowing
> users to set and retrieve a private void * associated with an idxd_wq.
> 
> The private data is stored in the idxd_dev.conf_dev associated with
> each idxd_wq.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>   drivers/dma/idxd/idxd.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 193552dea224..71cd4ca7d27a 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -552,6 +552,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
>   	return wq->client_count;
>   };
>   
> +static inline void set_idxd_wq_private(struct idxd_wq *wq, void *private)

I would go with the same kernel naming convention:

idxd_wq_set_private() and idxd_wq_get_private()?
> +{
> +	dev_set_drvdata(wq_confdev(wq), private);
> +}
> +
> +static inline void *idxd_wq_private(struct idxd_wq *wq)
> +{
> +	return dev_get_drvdata(wq_confdev(wq));
> +}
> +
>   /*
>    * Intel IAA does not support batch processing.
>    * The max batch size of device, max batch size of wq and
