Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B555BB083
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIPPtp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPPtm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 11:49:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D50FBE3F;
        Fri, 16 Sep 2022 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343380; x=1694879380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lC+lisPnctxW8fbl5I48vEfsOwtf+ApJj255Bru2CxM=;
  b=ZymShsFXgPrM6N7htKgUzTcy74vtEF1SsURnShQ8FcS1ag0aD7d7nIgs
   5Lthutw0DaaRbX9UTcvXyQoMbNZHLD2izUt5iezrtahOth2u4MNrD2tmI
   thU5UkbmUGQEmPTas18QtghpFDVW5ny+tUZeUFGi7kKOMzjw+Ujkj3k/X
   KMGf6DtbcSktiu4CCHb911SO9VWnsj4eU615u/CDHlip0+hRmJ6eSusfm
   Fu+f61qA+4oFk4RkZjGKY73bMT7elvxqCkabK4k2mrG1JS4LPKhU7gFqr
   mH6T5zPGLP022esYIuXx/Ct3rUL4sYL9sU/XBOAzOKQ/0uCzemNVv053P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="362980333"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362980333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:49:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="686180806"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.64.121]) ([10.212.64.121])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:49:26 -0700
Message-ID: <a486a70a-6238-567a-d6a2-32e1269711cd@intel.com>
Date:   Fri, 16 Sep 2022 08:49:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
 <20220916153640.qtb74i63upcncpuw@cantor>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220916153640.qtb74i63upcncpuw@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/16/2022 8:36 AM, Jerry Snitselaar wrote:
> On Wed, Sep 14, 2022 at 08:08:14PM -0300, Rafael Mendonca wrote:
>> If the IDA id allocation fails, then the allocated memory for the
>> idxd_device struct doesn't get freed before returning NULL, which leads to
>> a memleak.
>>
>> Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
>> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> I think there needs to be a kfree(idxd) where it checks rc < 0 after the call to dev_set_name() as well, yes?
The idxd_conf_device_release() should take care of freeing idxd with the 
put_device(). So I think we are good here.
>
> Regards,
> Jerry
>
>> ---
>>   drivers/dma/idxd/init.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index aa3478257ddb..fdc97519b8fb 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -445,8 +445,10 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>>   	idxd->data = data;
>>   	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
>>   	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
>> -	if (idxd->id < 0)
>> +	if (idxd->id < 0) {
>> +		kfree(idxd);
>>   		return NULL;
>> +	}
>>   
>>   	device_initialize(conf_dev);
>>   	conf_dev->parent = dev;
>> -- 
>> 2.34.1
>>
