Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7A13B3EA
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 22:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgANVC1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 16:02:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43540 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVC1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 16:02:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so10948170lfq.10;
        Tue, 14 Jan 2020 13:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SmAx2f7k3Ij3neL/MyfZDa8+WsebXDA2adTqPGqEPIM=;
        b=MTO8GWrT4GitWr4OxLHGYRHo+3id3P63o270W53od3VO//wseGrpecPk/IuPo6lLT4
         vJSp+m2Bci9gw/06PdhSUXvclMwd/u86UanjNjI1uTM6nNqq+lekDNlm3OyHPqC36e5c
         hQ3U94tLG6OyudadRdBNF3PfOnZUHMESc9fVDHMtfZGbRBpB28MCwpHXUckG+d98Wd3M
         VQ+6cbX2IQFRwbUm51dpgXFeYhp2UNE1aUrGiGyGj/RFvt6Bl6zgBmhUdF07jPA6Jzm/
         aF04nFsq/ZxvYrq1+YQKoQtKSqHwd6RKm70r0wz5Zepe9iWpc2PwBI8FeGA80SJre8rC
         4MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SmAx2f7k3Ij3neL/MyfZDa8+WsebXDA2adTqPGqEPIM=;
        b=ASqU1tazX1wBoVoXBYUWn0gbRVuPpK0rhBi0hMrOvYXoqP0fe8/kmLAVa/x+nZb4KL
         4iZH/gfbQ7upy0/hfOMB1n/1otJepkphQiuwcRBro50fltD0yhvvvWVqJnEvi+3ey/ve
         VKjcQ0HiCnUFL6puieXeAZNZlhKuqgB/HBehRWOzk165MqBlszlBKmrpvePnaviFlvG2
         QxcPBmZ0peGruoY2lYnOj9CLwc6dXoen3b52PYvNopcBeJwrOCUJqwWcgca1hEj25P8y
         /pmeCtuLWdZBK6FqSsP4Ak6tw/eoqx3nvN0m4aO7tygG2wdu/6paaY05QZ4VqE9TUmoV
         fAHw==
X-Gm-Message-State: APjAAAUa9DJkjdEz5U92XXgHsQvFl5lxYGQhznNGdiSIzgF+/24yxMxn
        ydBCOh4k5A13Kc9OykK/QmvG5jb8
X-Google-Smtp-Source: APXvYqzVT22BVrFVVB1quzA9X/JLpkt6ig0KghbFMTU+n1gTpGc+KGQsfTCwAn8TL0uwFzXXqU/tGQ==
X-Received: by 2002:a19:491a:: with SMTP id w26mr2849845lfa.98.1579035744481;
        Tue, 14 Jan 2020 13:02:24 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l7sm7698307lfc.80.2020.01.14.13.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:02:23 -0800 (PST)
Subject: Re: [PATCH v4 02/14] dmaengine: tegra-apb: Implement synchronization
 callback
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-3-digetx@gmail.com>
 <c225399c-f032-8001-e67b-b807dcda748c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <627f996c-1487-1b9a-e953-f5737f3ad32a@gmail.com>
Date:   Wed, 15 Jan 2020 00:02:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <c225399c-f032-8001-e67b-b807dcda748c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

14.01.2020 18:15, Jon Hunter пишет:
> 
> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>> The ISR tasklet could be kept scheduled after DMA transfer termination,
>> let's add synchronization callback which blocks until tasklet is finished.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 319f31d27014..664e9c5df3ba 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -798,6 +798,13 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>  	return 0;
>>  }
>>  
>> +static void tegra_dma_synchronize(struct dma_chan *dc)
>> +{
>> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>> +
>> +	tasklet_kill(&tdc->tasklet);
>> +}
>> +
> 
> Wouldn't there need to be some clean-up here? If the tasklet is
> scheduled, seems that there would be some other house-keeping that needs
> to be done after killing it.

I'm not seeing anything to clean-up, could you please clarify?
