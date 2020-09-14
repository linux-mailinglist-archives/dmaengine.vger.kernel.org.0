Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8726901E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 17:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgINPhB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 11:37:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:2370 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgINPgW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Sep 2020 11:36:22 -0400
IronPort-SDR: Wmy2HpShbffFgnZcbBr3TSCYmILOJ+pVjnJosBd2zV5auHDnxANEe5GlUDqKMIBAZNa0DuKuvm
 B55Zpqwn8vjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146835603"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="146835603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 08:36:11 -0700
IronPort-SDR: sjKNty2vSpJgk4RzzTd1nt84VtDUAcz8a26Q5Qw+02iv6NBNiYVWJ6i+MFGRkIzxCIer8A5Yhx
 GnyPDp4voscA==
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="345469584"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.30.142]) ([10.251.30.142])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 08:36:11 -0700
Subject: Re: [PATCH] dmaengine: ioat: Make two symbols static
To:     Jason Yan <yanaijie@huawei.com>, dan.j.williams@intel.com,
        vkoul@kernel.org, Leonid.Ravich@emc.com, dmaengine@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200912072158.602585-1-yanaijie@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <fa3d6c0c-68f5-3578-ed1a-92ce86aae5af@intel.com>
Date:   Mon, 14 Sep 2020 08:36:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200912072158.602585-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/12/2020 12:21 AM, Jason Yan wrote:
> This eliminates the following sparse warning:
> 
> drivers/dma/ioat/dma.c:29:5: warning: symbol 'completion_timeout' was
> not declared. Should it be static?
> drivers/dma/ioat/dma.c:33:5: warning: symbol 'idle_timeout' was not
> declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/ioat/dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index a814b200299b..8cce4e059b7a 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -26,11 +26,11 @@
>   
>   #include "../dmaengine.h"
>   
> -int completion_timeout = 200;
> +static int completion_timeout = 200;
>   module_param(completion_timeout, int, 0644);
>   MODULE_PARM_DESC(completion_timeout,
>   		"set ioat completion timeout [msec] (default 200 [msec])");
> -int idle_timeout = 2000;
> +static int idle_timeout = 2000;
>   module_param(idle_timeout, int, 0644);
>   MODULE_PARM_DESC(idle_timeout,
>   		"set ioat idel timeout [msec] (default 2000 [msec])");
> 
