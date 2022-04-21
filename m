Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD550A46C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390188AbiDUPkm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351142AbiDUPkj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 11:40:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE3473B8;
        Thu, 21 Apr 2022 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555470; x=1682091470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pvlInBpDXmfZpNmV6tJBOiPX6jvMjdSbFEbI3I82ysM=;
  b=ZHt4rJnzAKon83HKxE7mOVau/Ve+faT8NpFeymbFdZSJYpKnOCmP8p7a
   5Z/FebXJ6AQYsgZfLwh6Z25l0+9Fj2bdRfdgQt6w794ZXvHD9Chsp8N6e
   YA8SH+eSzO1hKwGn5tOVz3HbvonV2LKjMUC9qtD7h94kyBYw/0mlfuL1n
   sdy2weP5hTailY8/ALxdIAIBlhuzw06bb/Lr0o1Mzq3KLEJZbCSgUM8Pr
   uSz4E8829FNPUd82XdotGCpyN6roZS0ioqyhPNORLcGlzoZscLpPnyL45
   uKI6xBy21Wd0RDCExwwHtYTxO1rAdUB+HWW712HU4/aoZ+4Yl4xL0alLJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327297266"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="327297266"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:34:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="533353357"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.94.100]) ([10.212.94.100])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:34:20 -0700
Message-ID: <f3261912-dc13-46ed-471f-046ba314365d@intel.com>
Date:   Thu, 21 Apr 2022 08:34:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dmaengine: idxd: Fix the error handling path in
 idxd_cdev_register()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <1b5033dcc87b5f2a953c413f0306e883e6114542.1650521591.git.christophe.jaillet@wanadoo.fr>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1b5033dcc87b5f2a953c413f0306e883e6114542.1650521591.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/20/2022 11:13 PM, Christophe JAILLET wrote:
> If a call to alloc_chrdev_region() fails, the already allocated resources
> are leaking.
>
> Add the needed error handling path to fix the leak.
>
> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks!

> ---
>   drivers/dma/idxd/cdev.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index b9b2b4a4124e..033df43db0ce 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -369,10 +369,16 @@ int idxd_cdev_register(void)
>   		rc = alloc_chrdev_region(&ictx[i].devt, 0, MINORMASK,
>   					 ictx[i].name);
>   		if (rc)
> -			return rc;
> +			goto err_free_chrdev_region;
>   	}
>   
>   	return 0;
> +
> +err_free_chrdev_region:
> +	for (i--; i >= 0; i--)
> +		unregister_chrdev_region(ictx[i].devt, MINORMASK);
> +
> +	return rc;
>   }
>   
>   void idxd_cdev_remove(void)
