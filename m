Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0153A12E7EB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jan 2020 16:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgABPJt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jan 2020 10:09:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36691 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgABPJt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jan 2020 10:09:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so30085355lfe.3;
        Thu, 02 Jan 2020 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+a2O3hqTtaPiCx17fejjVd1UbANHtpnbuq4++Xop2H0=;
        b=BlgPHmcJR0DMimDWhTqezQJ7QKJF24oiSp9znFzUUvdhumfvoQyuh5CnOOKUtGhCVH
         5O43yr3JLfjoEi6otatMCmXTQR9Dhp36pqK8yc5sARoJpmGTxsRcPxKadKEtjDlVLTI2
         Rm0ljO+d5WKDIbgnD3TRGAdEyz5z2hkhLZCyz1WRPih7c6jMCBvrTtPSfKeGg4GynyBB
         ZPXBFL5zJiFp0zTKDUNSNaEgk5Gsol7y0RDEzP6Vz30nCiyHu791Nbe/yTdOozkGhbuI
         Ap9ZwI4DMe9MnoTGq5nUHN72H1CHhBllRHkVVrrpazTTa4/kqMRPQh7gYWymZDAKj0pw
         tn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+a2O3hqTtaPiCx17fejjVd1UbANHtpnbuq4++Xop2H0=;
        b=RTjQB2wXfn6CIuRHnp8x7qxP368WRGg3TsmJej/zRqIIz1BAIxwOf4pT8bALwcfIjA
         NMYYCJwFn6SZgO4oMlW0mX7vdBt7UpGqkaWNO1l5nnEyhr0457ZsIBvrMvGwlDjizGw1
         qama+yGLlxnjFvsKMaLDFPoVAY5tkpNetUh9RiUjMKz+ygeHGzDdZfPoUVD5GYd5vRqy
         kuwF59usLlfw/T12VMckVbHYoWtiBBYeNIR52YheYRbhYZWlJxxPw7ubkDlsO0pMNHcR
         O2ruc48LInQxJFUb/MfatzVCCfhaZmyuIYUotmNZGHDPKofaQxuCyUTZ7Tzy5jEIJHz0
         YtYg==
X-Gm-Message-State: APjAAAVeIwEvetXkBR2n3GAwx8Eh+HVNVhQG9j7lngJ5voX2kg+OjOxY
        qgHa57EXG7Q+s9+jZYvHInZxhE3M
X-Google-Smtp-Source: APXvYqzPCZN6+nbNfUaYLUQF2gFcF+kj4pbrsfs8NJ/v+bvHIv6Q7U/K7+juNJ8DNsx4bwq3J2fSqw==
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr46372820lfk.175.1577977786770;
        Thu, 02 Jan 2020 07:09:46 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a9sm23401356lfk.23.2020.01.02.07.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 07:09:46 -0800 (PST)
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
 <20191230204555.GB24135@qmqm.qmqm.pl> <20191230205054.GC24135@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4e1e4fef-f75c-f2e2-4d9e-29af69daf8db@gmail.com>
Date:   Thu, 2 Jan 2020 18:09:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230205054.GC24135@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.12.2019 23:50, Michał Mirosław пишет:
> On Mon, Dec 30, 2019 at 09:45:55PM +0100, Michał Mirosław wrote:
>> On Sat, Dec 28, 2019 at 11:46:36PM +0300, Dmitry Osipenko wrote:
>>> It's unsafe to check the channel's "busy" state without taking a lock,
>>> it is also unsafe to assume that tasklet isn't in-fly.
>>
>> 'in-flight'. Also, the patch seems to have two independent bug-fixes
>> in it. Second one doesn't look right, at least not without an explanation.
>>
>> First:
>>
>>> -	if (tdc->busy)
>>> -		tegra_dma_terminate_all(dc);
>>> +	tegra_dma_terminate_all(dc);
>>
>> Second:
>>
>>> +	tasklet_kill(&tdc->tasklet);
> 
> BTW, maybe you can convert the code to threaded interrupt handler and
> just get rid of the tasklet instead of fixing it?

This shouldn't bring much benefit because the the code's logic won't be
changed since we will still have to use the threaded ISR part as the
bottom-half and then IRQ API doesn't provide a nice way to synchronize
interrupt's execution, while tasklet_kill() is a nice way to sync it.
