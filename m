Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72114EE4D
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2020 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgAaOXQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jan 2020 09:23:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38202 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgAaOXQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jan 2020 09:23:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id p23so7954317edr.5;
        Fri, 31 Jan 2020 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5v/d9VEU5KVu0UWojc/o6Bq3UTZ8IALs0zvn7lGcGR0=;
        b=GNCWAHC897q5L4mOmLaEKcJ36kfrbD7nc915n7AYBjv5VVrqM2p0SJV6I1G503IEwI
         5s3s4e9piyBcCzRrvd0FBux4nDz/3kBTJxhdwPZJ5icNn5+x1/Q/0etbKYSrMgPCGIDR
         0hy/7nYYFsEccgKaPJrjPsTFJX6WpWqLCyTodIWlVG2lzF9QDYQ9fgmjnPjz8LOWFlil
         YRetIN3HuLjcmZybdds1l6ldA60nAR8Xzfg6B5HFC1gNW3lVJ29516DgZysK7Q3qVxv8
         IttTAfJ5kXfSRcx/4gFEQOYVzS80wKpLs7JF0/GQbKaj90nw0jtiG42UgPEZhsYI+Umf
         q20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5v/d9VEU5KVu0UWojc/o6Bq3UTZ8IALs0zvn7lGcGR0=;
        b=KBTvRN0v2+O6k/RgZw0UR2l3bLNRPmrGleRU1PhbFP2YUI8X/F7Fw4fY95X760XEV7
         3uSwms3DTE/MbYubUqzT3VDK0JMub15d21lBxNVAa4sQ9ShG9kvWX1xgA8MNh6vlJGEr
         Xr5UnHQ58HxLo422hOz0nn+vNp7Ug1r8f0ufkoYn3p0kCfqtl3so6FUeHv3BpedRKvNy
         2jyoCxkpSVhbeqx10k0PUin1pRRIi2vqYxD+QcCiygk+01R9mnjOFZJLA/vCnfimvX9m
         5qGDNNWR4CCurVK3l2K6FB32q6dEnjGR06HCpipcp99y/rI5yHa8kjb//6hxuFDpSACU
         JZfg==
X-Gm-Message-State: APjAAAVnKjsKDJ3BAouqo4pTYBuMIpEF9/CNMkReMAMOL5bMP4JiS3Oi
        vXlbZRof/zxeyjdrlcTw0/KucoVG
X-Google-Smtp-Source: APXvYqxhihbO1V/ApC6dcntrBYql5ALy0cEUpX+6WD+kmEokCbWvXOksq1JUZbpx7esaU77XJGqG+Q==
X-Received: by 2002:a17:906:848e:: with SMTP id m14mr8850516ejx.152.1580480594349;
        Fri, 31 Jan 2020 06:23:14 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id c24sm522225eds.40.2020.01.31.06.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:23:13 -0800 (PST)
Subject: Re: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-12-digetx@gmail.com>
 <2442aee7-2c2a-bacc-7be9-8eed17498928@nvidia.com>
 <0c766352-700a-68bf-cf7b-9b1686ba9ca9@gmail.com>
 <e72d00ee-abee-9ae2-4654-da77420b440e@nvidia.com>
 <cedbf558-b15b-81ca-7833-c94aedce5c5c@gmail.com>
 <315241b5-f5a2-aaa0-7327-24055ff306c7@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1b64a3c6-a8b9-34d7-96cc-95b93ca1a392@gmail.com>
Date:   Fri, 31 Jan 2020 17:22:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <315241b5-f5a2-aaa0-7327-24055ff306c7@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

31.01.2020 12:02, Jon Hunter пишет:
> 
> On 30/01/2020 20:04, Dmitry Osipenko wrote:
> 
> ...
> 
>>>> The tegra_dma_stop() should put RPM anyways, which is missed in yours
>>>> sample. Please see handle_continuous_head_request().
>>>
>>> Yes and that is deliberate. The cyclic transfers the transfers *should*
>>> not stop until terminate_all is called. The tegra_dma_stop in
>>> handle_continuous_head_request() is an error condition and so I am not
>>> sure it is actually necessary to call pm_runtime_put() here.
>>
>> But then tegra_dma_stop() shouldn't unset the "busy" mark.
> 
> True.
> 
>>>> I'm also finding the explicit get/put a bit easier to follow in the
>>>> code, don't you think so?
>>>
>>> I can see that, but I was thinking that in the case of cyclic transfers,
>>> it should only really be necessary to call the get/put at the beginning
>>> and end. So in my mind there should only be two exit points which are
>>> the ISR handler for SG and terminate_all for SG and cyclic.
>>
>> Alright, I'll update this patch.
> 
> Hmmm ... I am wondering if we should not mess with that and leave how
> you have it.

I took another look and seems my current v6 should be more correct because:

1. If "busy" is unset in tegra_dma_stop(), then the RPM should be put
there since tegra_dma_terminate_all() won't put RPM in this case:

	if (!tdc->busy)
		goto skip_dma_stop;

2. We can't move the "busy" unsetting into the terminate because then
tegra_dma_stop() will be invoked twice. Although, one option could be to
remove the tegra_dma_stop() from the error paths of
handle_continuous_head_request(), but I'm not sure that this is correct
to do.
