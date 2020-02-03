Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5B150B19
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 17:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgBCQYS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 11:24:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38266 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBCQYS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 11:24:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so10140582lfm.5;
        Mon, 03 Feb 2020 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUy4vRmg/IViSfkGS7qXoi1FXp8JHaRxb1uE8sd35YM=;
        b=lO1Qv4ObxLYQ3bk2N2Yp6wk6tzpUgSAyoFcwbDB+ZlcerRXtS02g3foHWfyKvspCEC
         U78JtqOfHWvnK7R16bK5gI5xnA4XGPEPA0PSAPRlwd9x+0m0isqhKUon063SSLH90EKs
         MuaWSyh3YoYLcYwyWek8NE30zpLELqxiaY/qFAFoHVPPe2Tj+T9hSU9iu6DX7vd7lEhI
         84HfVa3teHbeLvPTgQlWX/wrdpweT5bZVtXS9ADndO5O890nMz3D5i9IVR3mpyRsourv
         Ub410u8ZXkTaF3BOEu8h9LsmlT0yi8SwuQCZFpGsZEiAlfik6W5CHpUtyCJ5qsenewcz
         GiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUy4vRmg/IViSfkGS7qXoi1FXp8JHaRxb1uE8sd35YM=;
        b=C9I4KTQUXolzNcQCoQfUDioJkKLinW6UTObbTirp+gikqWgC+ZOQSR+u70au7eSdMq
         Nq3vS1vSrvyBeD7/yHYBz4b/tP97O1E+Y/AD8223V5PI4ujlaf56mMp7ch6oFz4PeuUk
         d54YIfmbZtX+DVqJLnSlcgddwa2eTporquDYpGh4bzj15qsh6z24ykQwBBYxoQEjQfzc
         QpbCIupb2kvPdnkkdUlTxjHqzoHeD2l0JziYRO0hw1iKYzW+Nt8oYe3ewS9UUn9JckOk
         EFfby/qeKugJq+QZD108U31j2EGs2TZfYOq1G6V4Y7VcKHGtXZycN7Uo/uvFaZngLjCE
         PKMw==
X-Gm-Message-State: APjAAAUsAphioRSvpOZ1CSnchtwoBIuBH8A2V8ibPRowJIijBsdS0qtY
        IhBZBVNDJR9I5pu8H1Eeci4HSuNW
X-Google-Smtp-Source: APXvYqyLQekPZ5gmtRp04/5q+OgQXMl1WI6Hb0OWuSm5NZJntHjjG5dk9Y3snSaGu/Qb4cFfqDs2LA==
X-Received: by 2002:a19:9d0:: with SMTP id 199mr12610493lfj.110.1580747055716;
        Mon, 03 Feb 2020 08:24:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id k24sm12055935ljj.27.2020.02.03.08.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 08:24:15 -0800 (PST)
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
 <1b64a3c6-a8b9-34d7-96cc-95b93ca1a392@gmail.com>
 <bf459b54-fa4c-b0ff-0af8-b7cb66b0a43c@gmail.com>
 <423eb28f-b5fc-c917-a7b2-72562183683f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1a1a52e1-8d75-93cd-b082-29846f9d2fb9@gmail.com>
Date:   Mon, 3 Feb 2020 19:24:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <423eb28f-b5fc-c917-a7b2-72562183683f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

03.02.2020 14:37, Jon Hunter пишет:
> 
> On 01/02/2020 15:13, Dmitry Osipenko wrote:
>> 31.01.2020 17:22, Dmitry Osipenko пишет:
>>> 31.01.2020 12:02, Jon Hunter пишет:
>>>>
>>>> On 30/01/2020 20:04, Dmitry Osipenko wrote:
>>>>
>>>> ...
>>>>
>>>>>>> The tegra_dma_stop() should put RPM anyways, which is missed in yours
>>>>>>> sample. Please see handle_continuous_head_request().
>>>>>>
>>>>>> Yes and that is deliberate. The cyclic transfers the transfers *should*
>>>>>> not stop until terminate_all is called. The tegra_dma_stop in
>>>>>> handle_continuous_head_request() is an error condition and so I am not
>>>>>> sure it is actually necessary to call pm_runtime_put() here.
>>>>>
>>>>> But then tegra_dma_stop() shouldn't unset the "busy" mark.
>>>>
>>>> True.
>>>>
>>>>>>> I'm also finding the explicit get/put a bit easier to follow in the
>>>>>>> code, don't you think so?
>>>>>>
>>>>>> I can see that, but I was thinking that in the case of cyclic transfers,
>>>>>> it should only really be necessary to call the get/put at the beginning
>>>>>> and end. So in my mind there should only be two exit points which are
>>>>>> the ISR handler for SG and terminate_all for SG and cyclic.
>>>>>
>>>>> Alright, I'll update this patch.
>>>>
>>>> Hmmm ... I am wondering if we should not mess with that and leave how
>>>> you have it.
>>>
>>> I took another look and seems my current v6 should be more correct because:
>>>
>>> 1. If "busy" is unset in tegra_dma_stop(), then the RPM should be put
>>> there since tegra_dma_terminate_all() won't put RPM in this case:
>>>
>>> 	if (!tdc->busy)
>>> 		goto skip_dma_stop;
>>>
>>> 2. We can't move the "busy" unsetting into the terminate because then
>>> tegra_dma_stop() will be invoked twice. Although, one option could be to
>>> remove the tegra_dma_stop() from the error paths of
>>> handle_continuous_head_request(), but I'm not sure that this is correct
>>> to do.
>>
>> Jon, I realized that my v6 variant is wrong too because
>> tegra_dma_terminate_all() -> tdc->isr_handler() will put RPM, and thus,
>> the RPM enable-count will be wrecked in this case.
> 
> Did you see my other suggestion to move the pm_runtime_put() outside of
> tegra_dma_stop?

Yes, but seems I skimmed too quickly through the lines and failed to
recognize the point you made.

> There are only a few call sites for tegra_dma_stop and
> so if we call pm_runtime_put() after calling tegra_dma_stop this should
> simplify matters.

This is somewhat similar to what I made in the v7. Instead of adding
pm_runtime_put() after each tegra_dma_stop(), I removed the
tegra_dma_stop().

Looking at it once again, perhaps indeed it will be better to leave the
relevant tegra_dma_stop() in place (the irrelevant could be removed).

Please take a look at the v7, I'll drop the "[PATCH v7 13/19] dmaengine:
tegra-apb: Don't stop cyclic DMA in a case of error condition" and make
v8 after yours review of the v7. Thanks in advance!
