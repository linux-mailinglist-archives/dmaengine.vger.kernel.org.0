Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB68159498
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2020 17:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgBKQOL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Feb 2020 11:14:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:36060 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbgBKQOL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Feb 2020 11:14:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 08:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="233497223"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2020 08:14:08 -0800
Subject: Re: [PATCH -next] dmaengine: idxd: remove set but not used variable
 'group'
To:     YueHaibing <yuehaibing@huawei.com>, dan.j.williams@intel.com,
        vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200211135335.55924-1-yuehaibing@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <397d824a-8827-c5b8-4dda-60fe79c6512d@intel.com>
Date:   Tue, 11 Feb 2020 09:14:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200211135335.55924-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/11/20 6:53 AM, YueHaibing wrote:
> drivers/dma/idxd/sysfs.c: In function engine_group_id_store:
> drivers/dma/idxd/sysfs.c:419:29: warning: variable group set but not used [-Wunused-but-set-variable]
> 
> It is not used, so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/sysfs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d907fe..e4f35bd 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -416,7 +416,7 @@ static ssize_t engine_group_id_store(struct device *dev,
>   	struct idxd_device *idxd = engine->idxd;
>   	long id;
>   	int rc;
> -	struct idxd_group *prevg, *group;
> +	struct idxd_group *prevg;
>   
>   	rc = kstrtol(buf, 10, &id);
>   	if (rc < 0)
> @@ -436,7 +436,6 @@ static ssize_t engine_group_id_store(struct device *dev,
>   		return count;
>   	}
>   
> -	group = &idxd->groups[id];
>   	prevg = engine->group;
>   
>   	if (prevg)
> 
