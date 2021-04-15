Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D67360B7B
	for <lists+dmaengine@lfdr.de>; Thu, 15 Apr 2021 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhDOOKR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 10:10:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:62047 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOOKQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 10:10:16 -0400
IronPort-SDR: tjWuhqocqVlRaGKm8UG+L0A35L8TSR9RZ0LNgX+gR3OX27Yhh/uncvYoOshBFuuwsiTE1KQbwr
 RpuHrtPVG8Sg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194885666"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194885666"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:09:41 -0700
IronPort-SDR: 31qFUbJplDmJcJwbCE3slOYca0ZnN/+3E7vaX73S8oZ8hG759bsYGZty0n8AJ9jl8jJYrGaPv3
 7pDU1oWPxbQw==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="461627273"
Received: from ckgurumu-mobl3.amr.corp.intel.com (HELO [10.212.35.10]) ([10.212.35.10])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:09:41 -0700
Subject: Re: [PATCH] dmaengine: idxd: Fix potential null dereference on
 pointer status
To:     Colin King <colin.king@canonical.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210415110654.1941580-1-colin.king@canonical.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <4e545597-8fe5-411d-6bb7-0c5e8eea5b23@intel.com>
Date:   Thu, 15 Apr 2021 07:09:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415110654.1941580-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/15/2021 4:06 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are calls to idxd_cmd_exec that pass a null status pointer however
> a recent commit has added an assignment to *status that can end up
> with a null pointer dereference.  The function expects a null status
> pointer sometimes as there is a later assignment to *status where
> status is first null checked.  Fix the issue by null checking status
> before making the assignment.
>
> Addresses-Coverity: ("Explicit null dereferenced")
> Fixes: 89e3becd8f82 ("dmaengine: idxd: check device state before issue command")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks!

> ---
>   drivers/dma/idxd/device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 31c819544a22..78d2dc5e9bd8 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -451,7 +451,8 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>   
>   	if (idxd_device_is_halted(idxd)) {
>   		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
> -		*status = IDXD_CMDSTS_HW_ERR;
> +		if (status)
> +			*status = IDXD_CMDSTS_HW_ERR;
>   		return;
>   	}
>   
