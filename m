Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C16F3240
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjEAOtd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjEAOtc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 10:49:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DEA6;
        Mon,  1 May 2023 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682952571; x=1714488571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vH5oPa5VEfnYKxkeFDN20IVsNpD96NPIEcwDEoKUY4U=;
  b=CxhCuD5Aq8ifhzwD3W/f7MEiwnktyChhDyu0bTXiANQJViELbs36T6rJ
   TX9xsj4a0yGABg6q6liqC27oiKoC+nv6GfsCDJmezzYjNyI48USV8CAcO
   7dUJOrJMRPVFcPFz6EuErTH1P3BYfJT/kfU8jEuHQOuXAMpke+pjM7iZ+
   LZ+1e2/AgYZf0TfUSQfGfxaWlw0imgx7e0kIzDx8UgKf0MlC9NYtJUQ7l
   UiG3O+dIUBxeroJKuIk1PLxr2QITvd3caEjsrABcscHaT1J+Z6pLRnRMv
   4sP6GaUy8r1Qw9xq1F1Sp8QABaRnU07s83zjn862nqD5YYWCJo/4a8Io9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="413592119"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="413592119"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="698558032"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="698558032"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.85.208]) ([10.212.85.208])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:49:29 -0700
Message-ID: <f16a6889-2f84-3f97-c6a7-981f2a255b42@intel.com>
Date:   Mon, 1 May 2023 07:49:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 04/15] dmaengine: idxd: Export descriptor management
 functions
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
 <20230428205539.113902-5-tom.zanussi@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230428205539.113902-5-tom.zanussi@linux.intel.com>
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
> To allow idxd sub-drivers to access the descriptor management
> functions, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/submit.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> index c01db23e3333..5e651e216094 100644
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
> +EXPORT_SYMBOL_NS_GPL(idxd_submit_desc, IDXD);
