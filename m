Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4704A9914
	for <lists+dmaengine@lfdr.de>; Fri,  4 Feb 2022 13:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358855AbiBDMQI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Feb 2022 07:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbiBDMP7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Feb 2022 07:15:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59264C061749;
        Fri,  4 Feb 2022 04:15:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z19so12157167lfq.13;
        Fri, 04 Feb 2022 04:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aGEsA+scNOokEFQJ1vtoomSbPZotFKlQPXXV2eBzIvA=;
        b=Aen7EN8nyfl/ci2RwPxgfhYYo80aPrfoiwLdVRQ7ReTdXKYhLtQoUKG2EM7SiRczFK
         Z2xfk0LAYxcUqJECpd3dbO3QrNMZNOwevdgH9GlfrDEGcMgpwS1I95FY3rmn70J6/irN
         U2gWO9JHxlfGt6of6v0FhYJYWKuj7mCyz9OzQHZ4kNFfU6xs2eFx3hzui+FSKxdoqFdD
         Cpto2uF0g6JGOvOH2wL/bywc3HCmNk2xGSm7K4uhXisXFUMd+I6P6g5eGPfvpWTd1Qk9
         TnA1+n0Ez1ZZOZjXoULgjVOYoxeuiZPFuglq7ezQxNEMHJOEbx1wZ88DI5qWsetLeeTv
         tL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aGEsA+scNOokEFQJ1vtoomSbPZotFKlQPXXV2eBzIvA=;
        b=rhTBnpiU7G/xiaSCUF6Zb7XgqKmS5se5aBLXK2ZOGChRmbkMoSpIcIzXH2IbFs6zoe
         KY/Fd0rkfB9F2fh6AqJsIBvBqKTe3ew98aIyQwqB+GuCby0xHEdN1+NdX2z3pLHs15c/
         pHhmdM6A5JSyWEqDV/0QAaCvQ7sNEgdEZaEP6Jr0I0ybKn43p0qPpNP79yN/kh4Pw8Eg
         hWGuNddO1FyUCWQAUG94LRu3xveeAd6PgVyY9/Z7iFIUa1DiE+l07ce+9Ps1uiraU4KI
         hYMMkFVYu8fL4qsg/dwEEWF/+Jx9ttmAKVgYOHhDHEn9e84or72WqzRTfp4epWpt6IQB
         PKdg==
X-Gm-Message-State: AOAM532VhtWHE8QkXI9wgbldZsg5opI7hwBQfPPQHQp2AiI8WJ/tY+B9
        7TXfytt7SZuX5AfUDe6ed2c=
X-Google-Smtp-Source: ABdhPJy3MvrHFgG+Z9ja4JsGfZR0P4ohrWkNNy7SCj28+hp74nLhHYaItj5fQ+eiQB5t0Y9sZueWng==
X-Received: by 2002:a05:6512:3f8f:: with SMTP id x15mr2128386lfa.363.1643976947560;
        Fri, 04 Feb 2022 04:15:47 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id u21sm251171ljo.81.2022.02.04.04.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 04:15:47 -0800 (PST)
Message-ID: <07913f0e-1e17-a22b-615c-fff8ccad7f9b@gmail.com>
Date:   Fri, 4 Feb 2022 15:15:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
 <1643729199-19161-3-git-send-email-akhilrajeev@nvidia.com>
 <3feaa359-31bb-bb07-75d7-2a39c837a7a2@gmail.com>
 <DM5PR12MB18509939C17ABEB5EEA825FFC0289@DM5PR12MB1850.namprd12.prod.outlook.com>
 <d6d70e52-a984-d973-f3bb-f70f1a4ce95d@gmail.com>
 <DM5PR12MB18501E2343121A9FEE013F15C0299@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB18501E2343121A9FEE013F15C0299@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

04.02.2022 09:47, Akhil R пишет:
>> 03.02.2022 06:44, Akhil R пишет:
>>>> But why do you need to pause at all here and can't use
>>>> tegra_dma_stop_client() even if pause is supported?
>>> The recommended method to terminate a transfer in
>>> between is to pause the channel first and then disable it.
>>> This is more graceful and stable for the hardware.
>>> stop_client() is more abrupt, though it does the job.
>>
>> If there is no real practical difference, then I'd use the common method
>> only. This will make code cleaner and simpler a tad.
> This is the documented way of clean exit from a transfer, especially for
> cyclic transfers where the DMA is configured in continuous mode.
> I guess it might not be a good idea to deviate from that unless there is
> something demanding it compulsorily.
> 
> I agree that the code will be cleaner. I would try to see if I can find a cleaner
> way to do this. Please do let me know if you have any suggestion.

Will be great if you could find out and provide a detailed explanation
about the exact differences of the methods from software perspective.
Try to ask the hardware people.

If you won't be able to find out, then use both methods. Then you could
specify the "pause" callback within the tegra_dma_chip_data
[tdma->chip_data->pause(tdma)], instead of using condition in the code.
