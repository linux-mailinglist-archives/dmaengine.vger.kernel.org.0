Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59435300B0D
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jan 2021 19:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbhAVSUG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Jan 2021 13:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbhAVPow (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Jan 2021 10:44:52 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE9C0613D6
        for <dmaengine@vger.kernel.org>; Fri, 22 Jan 2021 07:44:11 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e17so4394388qto.3
        for <dmaengine@vger.kernel.org>; Fri, 22 Jan 2021 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJ5Mm7jDvt8rYYjqfuGcAKVlF1C7OcwWb/rDTKJ5d/Q=;
        b=wcWMa2FpEYwa9IT1fn9c6WjOp7s8r0ejmanTOS4UW7OvflsrFUpCD6F4pcKzYPFC81
         17nnqVC3NCknrcdEJcqD4nSWJOb+uY33GwliYT+O8wKc/5qi4Jc1FjAEwoeNzn1exNHs
         qIw/6/Z+T8FGuv24jzsa+eRU6XI4fCK8I1qUe7CfR1QNNxegep2k6Yc/DFJ+sga+gJwJ
         7w87e3YSYF48VPfreqMzKl/dTsEI5IV5x5K8M2LHTHdRAa7D67JMah8uKz1k8Pj3Kwvr
         G9gue26Ip4oMikjTsZf541S5wI+4/icsGylvKMYDB9Zf5kfJLOy79t6PG43MtcxlV+dH
         Yddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJ5Mm7jDvt8rYYjqfuGcAKVlF1C7OcwWb/rDTKJ5d/Q=;
        b=pHhCwKdPu5Afm7kiXD1ANxm2hyvLK64MgvI+vUMZnwFacb2LBgLbqKxUVypvKStgSe
         YFGtJyMbB8gOzZF5ovcekUwmbMOo2z662M/khKygBR4Q41nR+2cyTnNy+c7a02RFWcky
         1uY2sg6dDz3fcg96ecVdv6O3jmB0aDuwzOl+c7j8YjTRmVoODPAy4HbcazEXBZxhW20M
         O3RPsd6WdwrU7F2GtFJYsTqQXNdTkZTLrUSYZPDYy8sE+FQbhqegvyopAuho4FdKWVcZ
         h+vVaqLf9VB84YKQxd0/ngQn6VTBoikWyLBu4EKZL7datpxKTtjmfMeNzi+oLmtmrgKP
         bKKg==
X-Gm-Message-State: AOAM531eb6GyZ6I/FVJnuruiNxA+KOfodjv37Vxl2dZuYPbl9xDHacfe
        OuVGCrIsmJMBmDJslM1dN+df3A==
X-Google-Smtp-Source: ABdhPJwRZyDqa9tInh1QS8BuhgaOJCcFWxaygOKtTTGW608RraEiVWrtKYW+ODZ0VLA+FLfMgCDVzA==
X-Received: by 2002:aed:2be7:: with SMTP id e94mr4817414qtd.110.1611330250814;
        Fri, 22 Jan 2021 07:44:10 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p75sm6616661qka.72.2021.01.22.07.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:44:10 -0800 (PST)
Subject: Re: [PATCH] drivers: dma: qcom: bam_dma: Manage clocks when
 controlled_remotely is set
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, vkoul@kernel.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210122025251.3501362-1-thara.gopinath@linaro.org>
 <20210122051013.GE2479@dragon>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <d1f1724c-39f1-7b6e-8cd4-638a44608d9c@linaro.org>
Date:   Fri, 22 Jan 2021 10:44:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122051013.GE2479@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shawn,

Thanks for the review

On 1/22/21 12:10 AM, Shawn Guo wrote:
> On Thu, Jan 21, 2021 at 09:52:51PM -0500, Thara Gopinath wrote:
>> When bam dma is "controlled remotely", thus far clocks were not controlled
>> from the Linux. In this scenario, Linux was disabling runtime pm in bam dma
>> driver and not doing any clock management in suspend/resume hooks.
>>
>> With introduction of crypto engine bam dma, the clock is a rpmh resource
>> that can be controlled from both Linux and TZ/remote side.  Now bam dma
>> clock is getting enabled during probe even though the bam dma can be
>> "controlled remotely". But due to clocks not being handled properly,
>> bam_suspend generates a unbalanced clk_unprepare warning during system
>> suspend.
>>
>> To fix the above issue and to enable proper clock-management, this patch
>> enables runtim-pm and handles bam dma clocks in suspend/resume hooks if
>> the clock node is present irrespective of controlled_remotely property.
> 
> Shouldn't the following probe code need some update?  Now we have both
> controlled_remotely and clocks handle for cryptobam node.  For example,
> if devm_clk_get() returns -EPROBE_DEFER, we do not want to continue with
> bamclk forcing to be NULL, right?

We still will have to set bdev->bamclk to NULL in certain scenarios. For 
eg slimbus bam dma is controlled-remotely and the clocks are handled by 
the remote s/w. Linux does not handle the clocks at all and  there is no 
clock specified in the dt node.This is the norm for the devices that are 
also controlled by remote s/w. Crypto bam dma is a special case where 
the clock is actually a rpmh resource and hence can be independently 
handled from both remote side and Linux by voting. In this case, the dma 
is controlled remotely but clock can be turned off and on in Linux. 
Hence the need for this patch.

Yes, the probe code needs updating to handle -EPROBE_DEFER (esp if the 
clock driver is built in as a module) I am not sure if the clock 
framework handles -EPROBE_DEFER properly either. So that
might need updating too. This is a separate activity and not part of 
this patch.

> 
>          bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
>          if (IS_ERR(bdev->bamclk)) {
>                  if (!bdev->controlled_remotely)
>                          return PTR_ERR(bdev->bamclk);
> 
>                  bdev->bamclk = NULL;
>          }
> 
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/dma/qcom/bam_dma.c | 20 +++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 88579857ca1d..b3a34be63e99 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -1350,7 +1350,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_unregister_dma;
>>   
>> -	if (bdev->controlled_remotely) {
>> +	if (!bdev->bamclk) {
>>   		pm_runtime_disable(&pdev->dev);
>>   		return 0;
>>   	}
>> @@ -1438,10 +1438,10 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
>>   {
>>   	struct bam_device *bdev = dev_get_drvdata(dev);
>>   
>> -	if (!bdev->controlled_remotely)
>> +	if (bdev->bamclk) {
>>   		pm_runtime_force_suspend(dev);
>> -
>> -	clk_unprepare(bdev->bamclk);
>> +		clk_unprepare(bdev->bamclk);
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -1451,12 +1451,14 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
>>   	struct bam_device *bdev = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> -	ret = clk_prepare(bdev->bamclk);
>> -	if (ret)
>> -		return ret;
>> +	if (bdev->bamclk) {
>> +		ret = clk_prepare(bdev->bamclk);
>> +		if (ret)
>> +			return ret;
>>   
>> -	if (!bdev->controlled_remotely)
>> -		pm_runtime_force_resume(dev);
>> +		if (!bdev->controlled_remotely)
> 
> Why do we still need controlled_remotely check here?

Yes you are right. This should be removed.I will send v2.

-- 
Warm Regards
Thara
