Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74C3011A
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2019 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfE3RcX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 May 2019 13:32:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39201 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3RcX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 May 2019 13:32:23 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so5398557ite.4;
        Thu, 30 May 2019 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pKmEOfA6jUQ1ifSdiSIAMrHcs6zqoAn0Gtn6sTHRPiI=;
        b=d5+bc6Y5akW+fa5Hoke6kWvu0vyu03vP7dRu+bOGz73qJuRyVu9QnRTkOHMTdsgYXL
         ms6OwHAdLUDdDPWSnUkm3ozAED44zbHWVawtoLZBcDlTI4Tws1rgeHR33XOmM8KWopeo
         hdafFIbtsThw3r2n4FXQAHb8Dymne82HIl172SRhHYn7laekt+ogvoTJmtllAhWyj0dN
         AMqDwIH2yqqc2l02dNQlH47gozMl0atPCtRtF0Gd15bUe9NQ0aL3X3MD4luqN3wf037I
         +df1+uWNKf+sKMZi1dnZCC/wnGKCsASIn3mC6K1OXer9F/B2oNcJdj1dbpQVvWpnXUzj
         7h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pKmEOfA6jUQ1ifSdiSIAMrHcs6zqoAn0Gtn6sTHRPiI=;
        b=SkCrbSh2gIYVySn3K/WIVZHX5K4hKPJP291qfPwXOUFW1KbN6Yr37AwcHtVflcNckv
         gjrzzdwf8FYcm7yBU3fsjlEvdB+IjQTRZKIpu8VpL+rQIWs04ZNInBK0Cmwd433fCon1
         Y7ViFxKM5Fi5uc73WM74PTJc600QSYAS1cPeUWkM92TD471xkYEXM65aMqOGMoFggWQ0
         FxVqdPbRMvshTnUTgkkzGmObzmeWmVlMQJiIoP9Zgk2ZEsa+4z2AHPXgm6YdQLlfl2S8
         QARLfWSQyBPAc7TCZgAIX5LlGPGeEpdm//Mb/aJ/Z3tfYr8I+082kaltabyjoJRDZtiQ
         EhtQ==
X-Gm-Message-State: APjAAAVy71rHmyOTtO7vpVpLnZNlrxxzlZTlw2730ms0wOGsTnUWLZyj
        TEDQC1keyjW2qKsLBikHTPQJ7Sl3
X-Google-Smtp-Source: APXvYqzWalcDXeau3RDQT3d7nz3EyiT/OOhQOLICDbi9RNEmdsp2lSwPMxnZ4oViDzGHPI0E8NF1BA==
X-Received: by 2002:a24:fcc7:: with SMTP id b190mr4049196ith.122.1559237542407;
        Thu, 30 May 2019 10:32:22 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id a7sm574793iok.19.2019.05.30.10.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 10:32:21 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Error out if DMA_PREP_INTERRUPT
 flag is unset
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190529214355.15339-1-digetx@gmail.com>
 <9b0e0d20-6386-a38a-1347-4264d249cb44@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <359abcbb-b3bd-ad32-9f35-15bb9b25f3b0@gmail.com>
Date:   Thu, 30 May 2019 20:32:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9b0e0d20-6386-a38a-1347-4264d249cb44@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.05.2019 15:01, Jon Hunter пишет:
> 
> On 29/05/2019 22:43, Dmitry Osipenko wrote:
>> Apparently driver was never tested with DMA_PREP_INTERRUPT flag being
>> unset since it completely disables interrupt handling instead of skipping
>> the callbacks invocations, hence putting channel into unusable state.
>>
>> The flag is always set by all of kernel drivers that use APB DMA, so let's
>> error out in otherwise case for consistency. It won't be difficult to
>> support that case properly if ever will be needed.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index cf462b1abc0b..2c84a660ba36 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -988,8 +988,12 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>>  		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
>>  	}
>>  
>> -	if (flags & DMA_PREP_INTERRUPT)
>> +	if (flags & DMA_PREP_INTERRUPT) {
>>  		csr |= TEGRA_APBDMA_CSR_IE_EOC;
>> +	} else {
>> +		WARN_ON_ONCE(1);
>> +		return NULL;
>> +	}
>>  
>>  	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
>>  
>> @@ -1131,8 +1135,12 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
>>  		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
>>  	}
>>  
>> -	if (flags & DMA_PREP_INTERRUPT)
>> +	if (flags & DMA_PREP_INTERRUPT) {
>>  		csr |= TEGRA_APBDMA_CSR_IE_EOC;
>> +	} else {
>> +		WARN_ON_ONCE(1);
>> +		return NULL;
>> +	}
>>  
>>  	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
> 
> Looks good to me.
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Cheers
> Jon
> 

Thanks
