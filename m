Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2955BB085
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiIPPuF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIPPuC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 11:50:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0413DE9;
        Fri, 16 Sep 2022 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343401; x=1694879401;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ptEF5ZhxsMrhv6+alJwEvLA23XOcH9/AWp09Jw7I6fU=;
  b=hAkvHAAd91RkYcPai5U2Iv060A8bf5DgMrAYNocOCNQRrMFbfOGcasj9
   08c6vLJK5Zw2QDv5AsKIUtwKURbdMAce6bUSEI/KRhPH/VeXxVvpcPOwW
   O5wb7i0NSLn+8scXfGZXgXM33XSFXRWQeX3Ll6pEXcfqCI8cE8nEDqKtM
   gdoMZLk2OHro1gRKtXvkUhyGT7qPdZzIWxrhdUUoxW/kWtYATAVakurge
   yrFivYYJLn6xVnFH7y9eAZyGOM85pLlyPC+wdER6r73ZheRXQT+9gENxB
   NOTTMPWO4DAYB0WwbUHFUhlTiSe2oNEO8GY0hiZHLKOWfVLWDz2ONz+oh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299010931"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="299010931"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:50:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="686181003"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.64.121]) ([10.212.64.121])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:50:00 -0700
Message-ID: <92f29edd-9027-5950-10ac-37bbda1d583a@intel.com>
Date:   Fri, 16 Sep 2022 08:50:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Content-Language: en-US
To:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220914230815.700702-1-rafaelmendsr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/14/2022 4:08 PM, Rafael Mendonca wrote:
> If the IDA id allocation fails, then the allocated memory for the
> idxd_device struct doesn't get freed before returning NULL, which leads to
> a memleak.
>
> Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Thanks!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index aa3478257ddb..fdc97519b8fb 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -445,8 +445,10 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>   	idxd->data = data;
>   	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
>   	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
> -	if (idxd->id < 0)
> +	if (idxd->id < 0) {
> +		kfree(idxd);
>   		return NULL;
> +	}
>   
>   	device_initialize(conf_dev);
>   	conf_dev->parent = dev;
