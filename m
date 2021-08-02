Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7360E3DDED6
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhHBSC3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 14:02:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:55556 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSC3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 14:02:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="211636374"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="211636374"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:02:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="419388191"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.45.122]) ([10.212.45.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:02:19 -0700
Subject: Re: [PATCH] dmaengine: idxd: Remove unused status variable in
 irq_process_work_list()
To:     Nathan Chancellor <nathan@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210802175820.3153920-1-nathan@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <d03981eb-67da-55fe-bc82-d83b00a22944@intel.com>
Date:   Mon, 2 Aug 2021 11:02:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802175820.3153920-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/2/2021 10:58 AM, Nathan Chancellor wrote:
> status is no longer used within this block:
>
> drivers/dma/idxd/irq.c:255:6: warning: unused variable 'status'
> [-Wunused-variable]
>                  u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
>                     ^
> 1 warning generated.
>
> Fixes: b60bb6e2bfc1 ("dmaengine: idxd: fix abort status check")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks.


> ---
>   drivers/dma/idxd/irq.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 65dc7bbb0a13..91e46ca3a0ad 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -252,8 +252,6 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
>   	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
>   
>   	list_for_each_entry(desc, &flist, list) {
> -		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
> -
>   		/*
>   		 * Check against the original status as ABORT is software defined
>   		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
>
> base-commit: e9c5b0b53ccca81dd0a35c62309e243a57c7959d
