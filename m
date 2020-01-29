Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C814CCA3
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 15:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgA2OjL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 09:39:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44046 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2OjL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 09:39:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so18668460ljj.11;
        Wed, 29 Jan 2020 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3K8g2R+qnN1al4PUDNLHepCk8IU3tYNbbOqjAxk66KQ=;
        b=aeb9sR283mF7M54b/P79A6sMBEAkyfi10bLIvLUYvCk614WErh7D810kPF7B2gk2HV
         S4gPFlkcDUXvT91O5HRacHkhXAorOxjYHMvl0VDG1KP8IoRlGcfgSjrW4klCXkOjv9EW
         WH8mNrsua6vUZtA+JbnVbTUSPnabN1s3Db9LGVfCehw2luiWDIvE8ayFzLRwc+7RE1S2
         ylQtSCGWRnF1vQwL77Vh6bg9gscf7zZMZNZqK+uQaemMIB2pkoTuXn5bGlgL4NTc7RWL
         DrjqRFY6pb82QfXeeRJRv69KloVzPEeSRGXI9QYndFeBJ1/c/EICIppcieugv9sKvewK
         tzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3K8g2R+qnN1al4PUDNLHepCk8IU3tYNbbOqjAxk66KQ=;
        b=BBt+VYWayAAsIdHRDEKIaRBApZrFzX6VloatyiWTnJqLZFGNp0Qcef+/9gcvO7+Ozs
         1HqMQKmMEHtjlPd+EommIYRRh5CliR1np8ZoPvhRq7HcEJYBF4ap0+aelo49en6M+0rO
         p8ySmmPGf/zGTfGnECqQbPOpMgwrf5hSCddSK3X8aEa4Ps/fwI1v93j1zIDPnzWU0KJ9
         oB/Kvwu1kfcaQWX5X8XKz+VM4LxRn6gtsnEPZKJZSGhh65p/SCLmQMDQxN9dokFLpYGi
         askjx0rczCSDP0MbYZJp3p6A6IAsf2M8X2tLhXAOuCCSHPk4WQJcvrXrhGLeQ2jwBbaf
         qOng==
X-Gm-Message-State: APjAAAWusBnFUZb8vEHKBXE5vVn/n4rINImYA936GygP0h1gTi0zyQCb
        890f2IF8ftrt5f3uKsxZ+xFjJLPp
X-Google-Smtp-Source: APXvYqzyT/z5WOwovxItfH/OmmixfX0sRMcE3L1GrJv50A2FO0AsNvSXw5MvYtPIoPvla35/zYC5Eg==
X-Received: by 2002:a2e:9b57:: with SMTP id o23mr17068194ljj.278.1580308748898;
        Wed, 29 Jan 2020 06:39:08 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p15sm1186393lfo.88.2020.01.29.06.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 06:39:08 -0800 (PST)
Subject: Re: [PATCH v5 05/14] dmaengine: tegra-apb: Prevent race conditions of
 tasklet vs free list
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200123230325.3037-1-digetx@gmail.com>
 <20200123230325.3037-6-digetx@gmail.com>
 <cd1da99a-e52e-e202-257d-17466132d088@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5f867023-d49a-aff5-8d7f-d682a3b32770@gmail.com>
Date:   Wed, 29 Jan 2020 17:39:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <cd1da99a-e52e-e202-257d-17466132d088@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

29.01.2020 14:01, Jon Hunter пишет:
> 
> On 23/01/2020 23:03, Dmitry Osipenko wrote:
>> The interrupt handler puts a half-completed DMA descriptor on a free list
>> and then schedules tasklet to process bottom half of the descriptor that
>> executes client's callback, this creates possibility to pick up the busy
>> descriptor from the free list. Thus let's disallow descriptor's re-use
>> until it is fully processed.
>>
>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 1b8a11804962..aafad50d075e 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -281,7 +281,7 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
>>  
>>  	/* Do not allocate if desc are waiting for ack */
>>  	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
>> -		if (async_tx_test_ack(&dma_desc->txd)) {
>> +		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
>>  			list_del(&dma_desc->node);
>>  			spin_unlock_irqrestore(&tdc->lock, flags);
>>  			dma_desc->txd.flags = 0;
>>
> 
> I think we should mark this for stable as well. I would make this the
> 2nd patch in the series as it is related to #1.

Okay!
