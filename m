Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC2316057
	for <lists+dmaengine@lfdr.de>; Wed, 10 Feb 2021 08:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhBJHux (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Feb 2021 02:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhBJHuf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Feb 2021 02:50:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4614C061574;
        Tue,  9 Feb 2021 23:49:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h26so1469054lfm.1;
        Tue, 09 Feb 2021 23:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KrGrH6t05k64IsQs/ldEY9uBloIfB5vP9tb8tT8h4Nc=;
        b=LRZZvqXQcv/nTOvQQGhlBHu2Kl0aWpXy2RHPKcDBX9BNhceLrc6mpbI2YNbVOWWoXE
         kZg/S6j2nj1Gnl/Gw7fdql5Oz0cmhNF2496DRXPdDrFXGY/nTLis+S+PlEka5s3nHWTP
         nGXybpttlcdgyUsuwtfV7V7TPvjQRSbC3BJ98z9riQoNdSDWPxBUplE8xB7Wyphc9/D4
         3dALD0HLFM4zc6LyvF6RiWE+NKjchh6jikOUnAxGi4uQnRHBdgUvsMn/S2MoujgIRUJM
         wJ2D2oDPvmRJ/a70CTeqkxtgwtjOQhzQ5G65ZjlLkwlOEugyn3g3qwVfGK2lbNnz+O4T
         Fw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KrGrH6t05k64IsQs/ldEY9uBloIfB5vP9tb8tT8h4Nc=;
        b=QjzmoqF2yVadvwOeOHmCL7z6stSfGqrrYq9J38jO7bkFBXgw0tGkMXp41OL0E+vV6a
         +ByKkn8ILFpUcbo6mG0n9Pu9CVkzjEaXig3NRlSIN8S4GhzyyBVF4dddL9np3/Wy7+7v
         seNTq/lTmH9ILFWE+rJgf8mqbNBV1pEejiEN0jUna9RvfPKqAhHYrUSx5T7FVV32LkKF
         YqOVycIGW0DurvLefm4wVCzzMA9FrUTh9KWoEkGpui3VLowFsXe6hYdi4bgKInppwAh/
         78jQxjz1e2YPXSFMvYlHJxbjlTNOLUT/nOI9NVFVETqmnAXJEGLewiSaMOLaVUp8UNbW
         esAA==
X-Gm-Message-State: AOAM533DMTv8QNP1llxyWQiFaBEYubRPii+cTHNPSor/UqEOv9CqKGk0
        IvpgMslMUQLuo7g772fbjDs5aKWNgwubyQiS
X-Google-Smtp-Source: ABdhPJxjB1qUPzrLvy3VOy7tYDacE8uTzFaZg6oWEQGQzgFvz/yAM9nrnICPlA3cvDhQ6CGY7SBeFw==
X-Received: by 2002:a19:38e:: with SMTP id 136mr1051183lfd.170.1612943393053;
        Tue, 09 Feb 2021 23:49:53 -0800 (PST)
Received: from [10.0.0.113] (91-157-86-155.elisa-laajakaista.fi. [91.157.86.155])
        by smtp.gmail.com with ESMTPSA id v23sm182573lfo.43.2021.02.09.23.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 23:49:52 -0800 (PST)
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210209090036.30832-1-kishon@ti.com>
 <19488154-22d5-33b4-06a1-17e9a896ae04@gmail.com>
 <7e06c63d-606b-be78-84ff-d5a5c72f7ad7@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix NULL pointer dereference
 error
Message-ID: <35a0a9a0-e938-da54-a500-624b2b6fcdeb@gmail.com>
Date:   Wed, 10 Feb 2021 09:50:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7e06c63d-606b-be78-84ff-d5a5c72f7ad7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kishon,

On 2/9/21 2:45 PM, Kishon Vijay Abraham I wrote:
> Hi Peter,
> 
> On 09/02/21 5:53 pm, Péter Ujfalusi wrote:
>> Hi Kishon,
>>
>> On 2/9/21 11:00 AM, Kishon Vijay Abraham I wrote:
>>> bcdma_get_*() and udma_get_*() checks if bchan/rchan/tchan/rflow is
>>> already allocated by checking if it has a NON NULL value. For the
>>> error cases, bchan/rchan/tchan/rflow will have error value
>>> and bcdma_get_*() and udma_get_*() considers this as already allocated
>>> (PASS) since the error values are NON NULL. This results in
>>> NULL pointer dereference error while de-referencing
>>> bchan/rchan/tchan/rflow.
>>
>> I think this can happen when a channel request fails and we get a second
>> request coming and faces with the not cleanup up tchan/rchan/bchan/rflow
>> from the previous failure.
>> Interesting that I have not faced with this, but it is a valid oversight
>> from me.
> 
> Thank you for reviewing.
> 
> Got into this issue when all the PCIe endpoint functions were requesting
> for a MEMCOPY channel (total 22 endpoint functions) specifically in
> bcdma_get_bchan() where the scenario you mentioned above happened.

I see, do we even have 22 bchan allocated for Linux out from the 40? ;)

> Vignesh asked me to fix it for all udma_get_*().

Yes, that is the right thing to do, thank you!

>>
>>> Reset the value of bchan/rchan/tchan/rflow to NULL if the allocation
>>> actually fails.
>>>
>>> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
>>> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
>>
>> Will this patch apply at any of these?
>> 25dcb5dd7b7c does not have BCDMA (bchan)
>> 017794739702 does not contain PKTDMA (tflow)
> 
> I can probably split this patch
> 017794739702 for bchan and 25dcb5dd7b7c for bchan/rchan/tchan/rflow

the tflow support for PKTDMA makes the tchan fix a bit problematic for
backporting, but it might worth a try to split to bcdma and
rchan/tchan/rflow patch.

-- 
Péter
