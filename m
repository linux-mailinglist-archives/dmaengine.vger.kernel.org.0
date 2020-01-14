Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A620813B3B2
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 21:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgANUdq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 15:33:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39367 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgANUdq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 15:33:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so15879167lja.6;
        Tue, 14 Jan 2020 12:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sGJB+mL9w5RryZTl/aXG7CYZ8Jke0HmMH4InRACq8OQ=;
        b=XpxHgutxnXiuktU6MDY4Ii7ImEf4scE6uZSEYYDygjbXcQDXFlVMTZith8xL/5fOYj
         J/qGRYiHIWnrA+LQZ0GW7QyrXRe/yeYFaLlxx8T7LsIZIzSd4hgUx4z8rFfpehXTnXFI
         gOsy/UrOMmHNZiP0luLmRlNpXk5TUT9KSgRYsILL04W4jBPz7M5FrDGu96aurikEQ/H0
         axRxpFyl13G87BYb9bmWR0PditOQFBd5TzT15xpkwF5eelJv7dEN9fbmYghe4Ers0XSi
         kl+zTl59Uy4P/mBP/NrzS6wHFgLQO6mHcST70SxFlsAWf4kvrr7xGOxejP4ymUyLJm+m
         /eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sGJB+mL9w5RryZTl/aXG7CYZ8Jke0HmMH4InRACq8OQ=;
        b=NDcrK2yu+MT1jkUpiC8vIAGOERqjOso8p7ilO5/HCTN6jlkFW9EDEpUfO3h3Akr/vp
         UIecQlXQtwRRi1eGscT1T0ZE4lsa62gTKWtWklZLc9p9KTTK1ifiH+faMg5lin8Ewiiv
         2TbbhJdgqtInzyE3riVsUmIpgpKEnlL8062qeQtNCbM0mI1S02NO/0zv+83I2E2Mms5O
         71QMJct+j4GXhODXRhxNfYgWLySIqep70+zCaMmdKm4qLzkuXnVNKRWnrEBWT2KakjSJ
         KxdIjn1dw+IEx31ghnYZyLHZkiVQYbEEelBvcCob+qztdxBLmqsuZT3EhJjtaB0WPYAy
         FhoQ==
X-Gm-Message-State: APjAAAVOiUVpyA9zhq3nT6GNNbskz9RTpO/AIcWRx3fSorWRgca8J0SF
        25geZwzp9K0VSGx36U/j0KXfpjW5
X-Google-Smtp-Source: APXvYqxH/Mebti1Ak07y0xEyPS4es+5eW3EEwWSzz9HUExQUOqbePyZ5nZ1zyZpkDdMYhOWcnPv0xA==
X-Received: by 2002:a2e:b61a:: with SMTP id r26mr15831520ljn.72.1579034022766;
        Tue, 14 Jan 2020 12:33:42 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b1sm9278272ljp.72.2020.01.14.12.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 12:33:41 -0800 (PST)
Subject: Re: [PATCH v4 01/14] dmaengine: tegra-apb: Fix use-after-free
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-2-digetx@gmail.com>
 <4c1b9e48-5468-0c03-2108-158ee814eea8@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1327bb21-0364-da26-e6ed-ff6c19df03e6@gmail.com>
Date:   Tue, 14 Jan 2020 23:33:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <4c1b9e48-5468-0c03-2108-158ee814eea8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

14.01.2020 18:09, Jon Hunter пишет:
> 
> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>> I was doing some experiments with I2C and noticed that Tegra APB DMA
>> driver crashes sometime after I2C DMA transfer termination. The crash
>> happens because tegra_dma_terminate_all() bails out immediately if pending
>> list is empty, thus it doesn't release the half-completed descriptors
>> which are getting re-used before ISR tasklet kicks-in.
> 
> Can you elaborate a bit more on how these are getting re-used? What is
> the sequence of events which results in the panic? I believe that this
> was also reported in the past [0] and so I don't doubt there is an issue
> here, but would like to completely understand this.
> 
> Thanks!
> Jon
> 
> [0] https://lore.kernel.org/patchwork/patch/675349/
> 

In my case it happens in the touchscreen driver during of the
touchscreen's interrupt handling (in a threaded IRQ handler) + CPU is
under load and there is other interrupts activity. So what happens here
is that the TS driver issues one I2C transfer, which fails with
(apparently bogus) timeout (because DMA descriptor is completed and
removed from the pending list, but tasklet not executed yet), and then
TS immediately issues another I2C transfer that re-uses the
yet-incompleted descriptor. That's my understanding.
