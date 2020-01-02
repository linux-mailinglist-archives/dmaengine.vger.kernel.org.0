Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0503412E7C5
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jan 2020 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgABPDM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jan 2020 10:03:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33869 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgABPDM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jan 2020 10:03:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so36178280ljg.1;
        Thu, 02 Jan 2020 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HH6eDm5kQk8wJiajeYqrN/FAF6ogq9rMreLvIteTjRU=;
        b=le0OxNIBlBAccUfxnlnv5DOv1ZyOwZODQUbm0VHZQ/OwMNLwMy15np2t3qhUq7FEJP
         +82QrInMfRPdYx8vwZpAJlAykNV9JzjIl1BdE732PzZqtX58g5uUjOivB22n5I964zUU
         I1UjTu197EIbQROekUioen7az7beXixGp0kZlbig54ZmIBgsg92LTDXKFhKJvelFXzvM
         EkQRRMi3syV4koheRKKJaiB7Fs3McAHzAez9Cc90a5RnGOySactGibODqSrbKnZHNcf0
         A7KvJfp6SYIdSTq2BQVDJQal0jpERUJfYrULXSBQbuGfQHxpl3IC5yefI6DruU7Fjsbr
         +YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HH6eDm5kQk8wJiajeYqrN/FAF6ogq9rMreLvIteTjRU=;
        b=TCzoHIZma0fzdU4jMLyI1ZR4liB8DimHU8FjwjD+/D138vJQnGglCLdsh0pBDRXxO6
         NmbN22bdY9SVUimathAGj+N479TKJxSd2j75Qk0K/6vn2FJjIsrkqJol9MepzlKVglkg
         AW7ABQweBT8KrH1edl8tDmMM4GkgBJLJ1a6gMWNBzHc6OxJVbmZgVCvTWqrnB7MWdpv0
         DZZB9b19sZohyopWZglPS4COplfrIvzObD/KZm//0BOOZTK7zb61vrBAwZ+UtY5YwHdQ
         4PNpx50QEYnAjY0TETUWD1hM0Liy1s9weN8AcOCn06XvkptUyticoJKTwdVOg0k8zr/r
         Me5g==
X-Gm-Message-State: APjAAAVLkHMLZcWUhVXZZsZ7+bzMzC5A6SlO5DHBYPNOCrppVkuhYe8M
        dXws6xcKPSYpjExhd2ELYNhy3pSf
X-Google-Smtp-Source: APXvYqyFoYmtJNBTX9xawgIiOLVa8uzW+9I2z/FDGUauajq02zs4PyKsTDNR0Uw7MB0JKWqSK4OxyA==
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr43189783ljn.85.1577977390285;
        Thu, 02 Jan 2020 07:03:10 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l28sm23199797lfk.21.2020.01.02.07.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 07:03:09 -0800 (PST)
Subject: Re: [PATCH v1 3/7] dmaengine: tegra-apb: Prevent race conditions on
 channel's freeing
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191228204640.25163-1-digetx@gmail.com>
 <20191228204640.25163-4-digetx@gmail.com>
 <20191230204555.GB24135@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ac0c861-0497-3961-026b-8c05b739df7d@gmail.com>
Date:   Thu, 2 Jan 2020 18:03:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230204555.GB24135@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.12.2019 23:45, Michał Mirosław пишет:
> On Sat, Dec 28, 2019 at 11:46:36PM +0300, Dmitry Osipenko wrote:
>> It's unsafe to check the channel's "busy" state without taking a lock,
>> it is also unsafe to assume that tasklet isn't in-fly.
> 
> 'in-flight'. Also, the patch seems to have two independent bug-fixes
> in it. Second one doesn't look right, at least not without an explanation.

Technically, this all shouldn't be needed at all since it should be a
responsibility of the DMA client drivers to make sure that channel is
idling before releasing it. But, AFAIK, the behavior of channel's
releasing isn't strictly defined by the DMA API, so it should be better
to keep the original behavior in place.

> First:
> 
>> -	if (tdc->busy)
>> -		tegra_dma_terminate_all(dc);
>> +	tegra_dma_terminate_all(dc);
> 
> Second:
> 
>> +	tasklet_kill(&tdc->tasklet);

Yes, it could be a separate change. Actually, this is not a fix, but a
clean-up change that simply stops tasklet instead of trying to work
around the fact that tasklet could be scheduled at the time channel's
freeing.

>>  	spin_lock_irqsave(&tdc->lock, flags);

I now see that missed to remove this locking since it's not needed now,
given that tasklet is already stopped after killing it by the above change.

I'll update and split this patch into two in v3.

>>  	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
>> @@ -1543,7 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
>>  
>>  		free_irq(tdc->irq, tdc);
>> -		tasklet_kill(&tdc->tasklet);
>>  	}
>>  
>>  	pm_runtime_disable(&pdev->dev);
>> @@ -1563,7 +1562,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
>>  	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
>>  		tdc = &tdma->channels[i];
>>  		free_irq(tdc->irq, tdc);
>> -		tasklet_kill(&tdc->tasklet);
>>  	}
>>  
>>  	pm_runtime_disable(&pdev->dev);

Thank you very much for taking a look at it!
