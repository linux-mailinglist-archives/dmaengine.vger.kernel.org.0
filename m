Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892751345BB
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2020 16:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgAHPHu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jan 2020 10:07:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36652 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgAHPHu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jan 2020 10:07:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so3695970ljg.3;
        Wed, 08 Jan 2020 07:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u5SmdITCKMEKPneZov69KtMiHrO4tZStOl7yO7V+oLk=;
        b=iC3USYQ59rt9xaIHzk9ewwL3VYVB+w5wkc6HeDZamKio+cZpXKsY9W/I59DGvEtW1M
         8X32BcatVFe2/TR52ddV3vev7wD6zbIO7D4uXhMjHMH7Ez9gYgOc7oBEe3BMi/zMdZUm
         k/2dbriOSWgrpLjY3d4jj5trjjZwLr/xG947yNw0mA46qqBC68YmwE95V+xZU+VAa8B2
         waDbwF5H/rxVDnLzhisAuJfnovfYt3uQ4k27m1cD1Ata+BOYjQIj1Ak5qfnJA+Tzhshq
         hX8R68luZP2XHHmMdQ25K3YdRc0F6UYM9vhw5LjsPljsntHVGcTFt8lOiE1qmvVHA2RL
         MgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u5SmdITCKMEKPneZov69KtMiHrO4tZStOl7yO7V+oLk=;
        b=aMLFMqij5oTIjg2+S/5VnKz2hNsMj98QE4iDfAGYu2so4krw2N1uc2Mx1aUJOZYx6Q
         ZcwUH0txaETKqLFf9XhXu7DL1S3se/1hXXOLtsTjGM6Yv4p73X5W4yxueGuBNjwSVRMs
         3w3uKhhyJRsXAz31L08/fPCEWazEDiIeJsgP8evw+5LZnJI/lSl1GkM3foPicg9BvZxY
         y913syQqht+vkojO0uAcmE8+mQBvxm9+yLxl4ciGQsRWPIyAMhzs1La7Otc084YZH5uR
         LuO8sOUwRl0DXOH0CWNNWpkvGMqEXBzbIF8vp+mFhYk1waw0IRar0Tl5sFBOcZKtGmmc
         dO8Q==
X-Gm-Message-State: APjAAAWFy7YsI4tmNeqOEy9UjJNg96MC1mX5lsAuVfVWhuefh7M3FfhV
        zOvMdlIho33Fl81OgIpkjvVTBT+R
X-Google-Smtp-Source: APXvYqyvrtR2bE4TQRBFiKxKlgkmLbztTTXxl1IQDl8wrtGIpkv0LyX9pWEdaIPp316CVXGPiiON5Q==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr3249134ljg.3.1578496067718;
        Wed, 08 Jan 2020 07:07:47 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id c8sm1516414lfm.65.2020.01.08.07.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:07:47 -0800 (PST)
Subject: Re: [PATCH v3 00/13] NVIDIA Tegra APB DMA driver fixes and
 improvements
To:     Thierry Reding <treding@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCIGF3?= <mirq-linux@rere.qmqm.pl>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200106011708.7463-1-digetx@gmail.com>
 <85d8ea335734417081399a082d44024c@HQMAIL105.nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c68cde59-0571-f58f-bf3c-8ce1cbdcc387@gmail.com>
Date:   Wed, 8 Jan 2020 18:07:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <85d8ea335734417081399a082d44024c@HQMAIL105.nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

08.01.2020 15:51, Thierry Reding пишет:
> On Mon, 06 Jan 2020 04:16:55 +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This is series fixes some problems that I spotted recently, secondly the
>> driver's code gets a cleanup. Please review and apply, thanks in advance!
>>
>> Changelog:
>>
>> v3: - In the review comment to v1 Michał Mirosław suggested that "Prevent
>>       race conditions on channel's freeing" does changes that deserve to
>>       be separated into two patches. I factored out and improved tasklet
>>       releasing into this new patch:
>>
>>         dmaengine: tegra-apb: Clean up tasklet releasing
>>
>>     - The "Fix use-after-free" patch got an improved commit message.
>>
>> v2: - I took another look at the driver and spotted few more things that
>>       could be improved, which resulted in these new patches:
>>
>>         dmaengine: tegra-apb: Remove runtime PM usage
>>         dmaengine: tegra-apb: Clean up suspend-resume
>>         dmaengine: tegra-apb: Add missing of_dma_controller_free
>>         dmaengine: tegra-apb: Allow to compile as a loadable kernel module
>>         dmaengine: tegra-apb: Remove MODULE_ALIAS
>>
>> Dmitry Osipenko (13):
>>   dmaengine: tegra-apb: Fix use-after-free
>>   dmaengine: tegra-apb: Implement synchronization callback
>>   dmaengine: tegra-apb: Prevent race conditions on channel's freeing
>>   dmaengine: tegra-apb: Clean up tasklet releasing
>>   dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
>>   dmaengine: tegra-apb: Use devm_platform_ioremap_resource
>>   dmaengine: tegra-apb: Use devm_request_irq
>>   dmaengine: tegra-apb: Fix coding style problems
>>   dmaengine: tegra-apb: Remove runtime PM usage
>>   dmaengine: tegra-apb: Clean up suspend-resume
>>   dmaengine: tegra-apb: Add missing of_dma_controller_free
>>   dmaengine: tegra-apb: Allow to compile as a loadable kernel module
>>   dmaengine: tegra-apb: Remove MODULE_ALIAS
>>
>>  drivers/dma/Kconfig           |   2 +-
>>  drivers/dma/tegra20-apb-dma.c | 481 ++++++++++++++++------------------
>>  2 files changed, 220 insertions(+), 263 deletions(-)
> 
> Test results:
>   13 builds: 13 pass, 0 fail
>   12 boots:  11 pass, 1 fail

I'm not sure how to interpret this result. Could you please explain what
that fail means?

>   38 tests:  38 pass, 0 fail
> 
> Linux version: 5.5.0-rc5-gf9d40c056c0f
> Boards tested: tegra20-ventana, tegra30-cardhu-a04, tegra124-jetson-tk1,
>                tegra186-p2771-0000, tegra194-p2972-0000,
>                tegra210-p2371-2180
> 

Will be awesome to see the detailed testing results, at least console
log like it was with NVTB.
