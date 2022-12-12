Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7194C64A42F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 16:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLLPct (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Dec 2022 10:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiLLPcs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Dec 2022 10:32:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163E10C1;
        Mon, 12 Dec 2022 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670859166; x=1702395166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nbBXjiWrVqp5rwGJtIFbpqvO7wCxphK+HIpxFcHMkiA=;
  b=UrjBKY6xoE+2ScAD7zneQLqrSbRTnq9Mi3eQYm9troBjK4GIEdpFs+vq
   JpGpVsAsXx6l9BVi6aOdkgexYRuVKdHHe0qWtuY3OBdAYPqupA2eNoowK
   cgjvpkpFeBSup6Wr6l8vUYLt+5YETQoyj6sZn6pNFm1rL1BRL+wqyZjX7
   KNy3NhHj1U48mUqrVDeozIa4TTnlRG6f07DYMEkp0vPYTcLWQ8wkwqZyb
   lQp6AlTyJaio3LcVvjwXqr2nr/kRa1Q410hg3M3rFmyNr9uCDhrO2wRzG
   +g+19y1AlvM7sDERY37owHslNrXJ5x0PmXoIEihUTnQrP58y+dQZrIzxF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="404135157"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="404135157"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 07:32:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="790533498"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="790533498"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.8.194]) ([10.212.8.194])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 07:32:44 -0800
Message-ID: <4ea86d83-610a-9a14-fda8-e25bd9d4addb@intel.com>
Date:   Mon, 12 Dec 2022 08:32:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] dmaengine: idxd: Remove the unused function
 set_completion_address()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        fenghua.yu@intel.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221212033514.5831-1-jiapeng.chong@linux.alibaba.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221212033514.5831-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/11/2022 8:35 PM, Jiapeng Chong wrote:
> The function set_completion_address is defined in the dma.c file, but not
> called elsewhere, so remove this unused function.
> 
> drivers/dma/idxd/dma.c:66:20: warning: unused function 'set_completion_address'.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3416
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>
Thanks for the cleanup
> ---
>   drivers/dma/idxd/dma.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index e0874cb4721c..eb35ca313684 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -63,12 +63,6 @@ static void op_flag_setup(unsigned long flags, u32 *desc_flags)
>   		*desc_flags |= IDXD_OP_FLAG_RCI;
>   }
>   
> -static inline void set_completion_address(struct idxd_desc *desc,
> -					  u64 *compl_addr)
> -{
> -		*compl_addr = desc->compl_dma;
> -}
> -
>   static inline void idxd_prep_desc_common(struct idxd_wq *wq,
>   					 struct dsa_hw_desc *hw, char opcode,
>   					 u64 addr_f1, u64 addr_f2, u64 len,
