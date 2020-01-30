Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9D14DE7B
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3QJO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 11:09:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32781 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgA3QJO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 11:09:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so3988367lji.0;
        Thu, 30 Jan 2020 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gJegaF/2BtMkE3wbQDGNWIgkQsP+NVDH54Ixz6J/GXI=;
        b=UgE87oUO9lToM8ordqu/WcxSlYgKFPUk2g9vXCndltpuznlU0N+brMPh4dkT5aYPaM
         VzTlWFkDD/SiM6MeagHuL5u1k7XkFlVmF4Rz1K2y8tMsVkzDrfMyBJV9hC6LbWRfkBEo
         MvehNnoj2bWEClxl+ylwKmJm+Km+MjsXEPYnCyBYL9P8xLkdIfypHuiuublrpuMUSosm
         54Xew2EZptrYci0VdTWPx5qjSB+n9Zz0+GLNyGWRN+1FDiBIGAXN/bEl9yK8vt7GMfBi
         WsquWX1Xy3kncsbQ4s+ET5e2smiCUFWKyYoF2IlyeH/MuCtkWqWVT14bHNqeMN4Zq7hM
         sMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gJegaF/2BtMkE3wbQDGNWIgkQsP+NVDH54Ixz6J/GXI=;
        b=RhT4L9W0n9wjeVFzJRxcu3of25TqlfPFMzWzL0qMgYn+Xetr8eNtjH5JYbZchbFwfd
         sLLn5fG6uiGvTNwgqldFauTXyohx7EETuT0QF6MCGFgxnW0Lk/387LZli/7D7BTYxqNh
         +8n2p+Ho+pwyjkVl2DyGSw3GyYNh6hkRryPR4h5MP/yrjfdad0vPwo/r3R5DCAYtHo9l
         is4hXPkqAeXNZ9JlcLRU6KWJRBLbhL/3fOEzbURyIAdKJkRjZ+nps9fNP9e4Uya3KHYl
         BBflJeRLpopdnLLjeeRWCVDAp0tPv2KHtoOUU6+E6ns2hUPfwhnIQI5U2LLYatEmIXZZ
         9NZg==
X-Gm-Message-State: APjAAAWJA9kSUIEjwPm+WLAhfZLbtH74NMrQW40C+SuwpDvf2UjZO3MS
        8Ick8AaVm85jlEmuY+WsFdN2/w3p
X-Google-Smtp-Source: APXvYqyHRcP5PxJWp7pr7+fvBC8vG2UjBobRg/6i+tLhuYTB/t/GWRvL2Fzrm8SKR/H14/bYm5K5oQ==
X-Received: by 2002:a2e:865a:: with SMTP id i26mr3372290ljj.236.1580400551632;
        Thu, 30 Jan 2020 08:09:11 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n13sm3199453lji.91.2020.01.30.08.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:09:11 -0800 (PST)
Subject: Re: [PATCH v6 10/16] dmaengine: tegra-apb: Remove assumptions about
 unavailable runtime PM
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-11-digetx@gmail.com>
 <24ca0a86-032f-2686-4dd2-6e4c5cf60223@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <742415f3-8ef5-415d-e34d-eebd893235cb@gmail.com>
Date:   Thu, 30 Jan 2020 19:09:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <24ca0a86-032f-2686-4dd2-6e4c5cf60223@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2020 17:09, Jon Hunter пишет:
> 
> On 30/01/2020 04:37, Dmitry Osipenko wrote:
>> The runtime PM is always available on all Tegra SoCs since the commit
>> 40b2bb1b132a ("ARM: tegra: enforce PM requirement"), so there is no
>> need to handle the case of unavailable RPM in the code anymore.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 7158bd3145c4..22b88ccff05d 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -1429,11 +1429,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  	spin_lock_init(&tdma->global_lock);
>>  
>>  	pm_runtime_enable(&pdev->dev);
>> -	if (!pm_runtime_enabled(&pdev->dev))
>> -		ret = tegra_dma_runtime_resume(&pdev->dev);
>> -	else
>> -		ret = pm_runtime_get_sync(&pdev->dev);
>>  
>> +	ret = pm_runtime_get_sync(&pdev->dev);
>>  	if (ret < 0)
>>  		goto err_pm_disable;
>>  
>> @@ -1546,8 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  
>>  err_pm_disable:
>>  	pm_runtime_disable(&pdev->dev);
>> -	if (!pm_runtime_status_suspended(&pdev->dev))
>> -		tegra_dma_runtime_suspend(&pdev->dev);
>>  
>>  	return ret;
>>  }
>> @@ -1557,10 +1552,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
>>  	struct tegra_dma *tdma = platform_get_drvdata(pdev);
>>  
>>  	dma_async_device_unregister(&tdma->dma_dev);
>> -
>>  	pm_runtime_disable(&pdev->dev);
>> -	if (!pm_runtime_status_suspended(&pdev->dev))
>> -		tegra_dma_runtime_suspend(&pdev->dev);
>>  
>>  	return 0;
>>  }
> 
> I wonder if we need to make the pm_runtime_put a pm_runtime_put_sync or
> call pm_runtime_barrier() here, to ensure it has called the callback
> when freeing the channel? Otherwise this is fine.

The explicit RPM syncing shouldn't be needed because
pm_runtime_disable() takes care of doing that for us, please take a look at:

https://elixir.bootlin.com/linux/v5.5/source/drivers/base/power/runtime.c#L1360
