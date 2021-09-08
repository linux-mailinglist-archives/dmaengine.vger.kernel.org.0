Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B47403DBC
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbhIHQoW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 12:44:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:11308 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352100AbhIHQoU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 12:44:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220568725"
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="220568725"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 09:43:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="538868167"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.120.104]) ([10.212.120.104])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 09:43:09 -0700
Subject: Re: [PATCH -next] dmaengine: idxd: Use list_move_tail instead of
 list_del/list_add_tail
To:     Bixuan Cui <cuibixuan@huawei.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc:     vkoul@kernel.org, john.wanghui@huawei.com
References: <20210908092826.67765-1-cuibixuan@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <54e2f5a5-9593-85f8-e00a-8638de5bbc60@intel.com>
Date:   Wed, 8 Sep 2021 09:43:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908092826.67765-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/8/2021 2:28 AM, Bixuan Cui wrote:
> Using list_move_tail() instead of list_del() + list_add_tail()
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>

Thanks!

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/dma/idxd/irq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index ca88fa7a328e..79fcfc4883e4 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -221,8 +221,7 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
>   
>   	list_for_each_entry_safe(desc, n, &irq_entry->work_list, list) {
>   		if (desc->completion->status) {
> -			list_del(&desc->list);
> -			list_add_tail(&desc->list, &flist);
> +			list_move_tail(&desc->list, &flist);
>   		}
>   	}
>   
