Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8213E657
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 18:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbgAPRTy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 12:19:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46017 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391385AbgAPRSP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jan 2020 12:18:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so16053223lfa.12;
        Thu, 16 Jan 2020 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cuaekrQn9t7Wj/AF8dj3MhOapcvvLHIEhjAaNfRzTGg=;
        b=YeqtpcEn2IV/D8OXJFcE8Jwf4Jf5u0lcuquyAt+BbRQSOM/wxvpHkWOoKD0qy6YOie
         9dHspbuT06VGVoA3E0PbLe6tWs5+kTIUz8ZkVDy3/mO0/LEk0oM26QAQy9BuypSnnEhD
         qqAStYiLDCN9jgloEBLnmd6Nlef0pYcf1K04K7smMA05WBEAdAPMahNf9pJPKvPhhIda
         Ak3P6YljIUp2wRIalY3YIeHWrYa17sFFj6e2zgKElpQ536ZrBgV2Sc19gIwqi8JiXLdC
         fYjw9GChQHcYFPTUeRB2U1S+Axy3alvJ7swTG3kYbqobHJyvrf0BPqePsvyQ5jtnChKl
         YZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cuaekrQn9t7Wj/AF8dj3MhOapcvvLHIEhjAaNfRzTGg=;
        b=rG6a6rsucntkBqkZv23eKaV992eHVu9UTd6g1CtahMipdIAfGvlMr5jbHJKX/qzJel
         EudUdrlmFzUp0Ka0S++dxL5toQQB7+DZY5VcfFQ6YuNznktSS4FXrtBaK1rMisyuc74q
         4T2HE1smdldiV9MCvPiZQ2hTSRMA7oqLzDrMigMLuvmNecnI1+1h66ko/3PUYwXcPjIB
         9ke19yR+pSKT8MQGGZNJjxPbREG5HOEC+TVtcf8hUpySJl1lODNliWSXE+BJe3GgK8Jm
         bdjPS9Ey3vw0ZS0oImBDloCG6CRd0hsfZG2uhWUh1jhQuFUKpcX21ARD41Ovl/ASGXRm
         Bz5g==
X-Gm-Message-State: APjAAAUBtoV+kGIBbG3U/UxF/PFZ7CTjmwtq7iDnb7VloNyt6N65FmSp
        3i3oGIvy0iXyTM2V3HI772UMNS6O
X-Google-Smtp-Source: APXvYqy220VkFSTrKosDWOSCYosOmrkKL0p+neVS7EHUWpmuEjB9hGMhiTUcC+NgyGSjqCMQG3I39w==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr2935387lfa.70.1579195092626;
        Thu, 16 Jan 2020 09:18:12 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id j19sm12606841lfb.90.2020.01.16.09.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 09:18:12 -0800 (PST)
Subject: Re: [PATCH v4 09/14] dmaengine: tegra-apb: Clean up runtime PM
 teardown
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-10-digetx@gmail.com>
 <9a5c4f82-5653-8d81-e304-76675aff5d8f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <11cdf32b-23d5-8a4e-0832-3c75e90b8abe@gmail.com>
Date:   Thu, 16 Jan 2020 20:18:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9a5c4f82-5653-8d81-e304-76675aff5d8f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

15.01.2020 12:57, Jon Hunter пишет:
> 
> On 12/01/2020 17:30, Dmitry Osipenko wrote:
>> It's cleaner to teardown RPM by revering the enable sequence, which makes
>> code much easier to follow.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 22 +++++++++++++---------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 7158bd3145c4..cc4a9ca20780 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -1429,13 +1429,15 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  	spin_lock_init(&tdma->global_lock);
>>  
>>  	pm_runtime_enable(&pdev->dev);
>> -	if (!pm_runtime_enabled(&pdev->dev))
>> +	if (!pm_runtime_enabled(&pdev->dev)) {
>>  		ret = tegra_dma_runtime_resume(&pdev->dev);
>> -	else
>> +		if (ret)
>> +			return ret;
>> +	} else {
>>  		ret = pm_runtime_get_sync(&pdev->dev);
>> -
>> -	if (ret < 0)
>> -		goto err_pm_disable;
>> +		if (ret < 0)
>> +			goto err_pm_disable;
>> +	}
>>  
>>  	/* Reset DMA controller */
>>  	reset_control_assert(tdma->rst);
>> @@ -1545,9 +1547,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  	dma_async_device_unregister(&tdma->dma_dev);
>>  
>>  err_pm_disable:
>> -	pm_runtime_disable(&pdev->dev);
>> -	if (!pm_runtime_status_suspended(&pdev->dev))
>> +	if (!pm_runtime_enabled(&pdev->dev))
>>  		tegra_dma_runtime_suspend(&pdev->dev);
>> +	else
>> +		pm_runtime_disable(&pdev->dev);
>>  
>>  	return ret;
>>  }
>> @@ -1558,9 +1561,10 @@ static int tegra_dma_remove(struct platform_device *pdev)
>>  
>>  	dma_async_device_unregister(&tdma->dma_dev);
>>  
>> -	pm_runtime_disable(&pdev->dev);
>> -	if (!pm_runtime_status_suspended(&pdev->dev))
>> +	if (!pm_runtime_enabled(&pdev->dev))
>>  		tegra_dma_runtime_suspend(&pdev->dev);
>> +	else
>> +		pm_runtime_disable(&pdev->dev);
> 
> Looks like dma_async_device_unregister() will warn if a client still has
> a channel requested but does not prevent the unregister from completing.
> So it could be possible that we could be leaving the controller active now.

It's a drivers dependency bug if DMA driver's module isn't properly
refcounted and thus could be removed while it has active users. Nothing
we can do about it here, the actual source of the bug needs to be fixed.

Perhaps Tegra DMA driver could inc/dec module's refcounf on channel's
request/free, but I think it should be responsibility of the DMA core to
care about the refcounting (if it doesn't do it already).
