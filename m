Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54564A9944
	for <lists+dmaengine@lfdr.de>; Fri,  4 Feb 2022 13:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358596AbiBDM2g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Feb 2022 07:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiBDM2g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Feb 2022 07:28:36 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6AAC061714;
        Fri,  4 Feb 2022 04:28:35 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t14so8239957ljh.8;
        Fri, 04 Feb 2022 04:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Ne8/8XjxQvQVikhbv7k/8kICaz4qUeVx8XxcLTjMyBE=;
        b=MpozesqZWKL9L8Kq3hGuSTY98Olh5bmSh7fETkonsRfovgtF5PjqKkWlLcasriuaoF
         btBDpR5YWjMqAR50N25mSoui68vOc/H0j5u3/I8Mz7A/d+Jv7gvD6mtDySpafSRheFZh
         pP0Ma9kd1vlO3HDGiz5re4A4uEZbKxcJakf2C8R6fECwTkgNoEBmy+l02PFKbgPc+vkj
         /0sRdEs2Sae61r7Cj0ZfhJ5TNToAHiZmhka7YPpGuYOzVaWhSMlTlcSB36THaJgRO0o9
         zOl2byHILTu0zyAJgTQGHd7+pf+yFJpGTIMmiE0P1/3RnedqDSNM1MqPanoTaLAH61MT
         F2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Ne8/8XjxQvQVikhbv7k/8kICaz4qUeVx8XxcLTjMyBE=;
        b=HxWW8VpfBAgLXf/z68dlcGQHf0obZCjA5WVS0BspZzAJu1KP1NoxBLeUgw0neEZWk9
         jccW12lwtYWl7lu7xhUNX3dkEJ5V22E+XdM7b4C8f3PGHVuh0PnkZ7sm43tZKSUU1AN+
         6coSTuOOkUFPWEpA4bjKnakkXBcoepUHzTX4mrAdl7NXWSWPtVeuT4u3oomrCYLHcM/b
         T6zVfN5HBibsgIX1LzJsEPe/PUk1GSRTfM81ryjllkA6kaEkR185xKMcdJYhjB1qynzn
         VV81PnwO/Qa471DsZQn7f8A62lmsEXNr3jR4s1UcQ417W8G2bP+pZMKEEvox9brJjidj
         c72A==
X-Gm-Message-State: AOAM532Bb4sBqL5IbdsVdqaVPQ0KGDxvyokwEqQBT7xvWOzSixbk/26j
        +o8g2AbrdtDbhGzLemA2trk=
X-Google-Smtp-Source: ABdhPJyH4NxPtNiTjx9AdBmOV7v1e/mQttIv0y9Q5MVhxPnyJ/0dpmfFOqjQ5ky4gsKnvJFY7Zff9Q==
X-Received: by 2002:a05:651c:1a07:: with SMTP id by7mr1654064ljb.317.1643977713765;
        Fri, 04 Feb 2022 04:28:33 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id bt22sm292617lfb.262.2022.02.04.04.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 04:28:33 -0800 (PST)
Message-ID: <a6d6ded6-5317-8aec-9021-461c7dfc5b4f@gmail.com>
Date:   Fri, 4 Feb 2022 15:28:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <07913f0e-1e17-a22b-615c-fff8ccad7f9b@gmail.com>
In-Reply-To: <07913f0e-1e17-a22b-615c-fff8ccad7f9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

04.02.2022 15:15, Dmitry Osipenko пишет:
> 04.02.2022 09:47, Akhil R пишет:
>>> 03.02.2022 06:44, Akhil R пишет:
>>>>> But why do you need to pause at all here and can't use
>>>>> tegra_dma_stop_client() even if pause is supported?
>>>> The recommended method to terminate a transfer in
>>>> between is to pause the channel first and then disable it.
>>>> This is more graceful and stable for the hardware.
>>>> stop_client() is more abrupt, though it does the job.
>>>
>>> If there is no real practical difference, then I'd use the common method
>>> only. This will make code cleaner and simpler a tad.
>> This is the documented way of clean exit from a transfer, especially for
>> cyclic transfers where the DMA is configured in continuous mode.
>> I guess it might not be a good idea to deviate from that unless there is
>> something demanding it compulsorily.
>>
>> I agree that the code will be cleaner. I would try to see if I can find a cleaner
>> way to do this. Please do let me know if you have any suggestion.
> 
> Will be great if you could find out and provide a detailed explanation
> about the exact differences of the methods from software perspective.
> Try to ask the hardware people.
> 
> If you won't be able to find out, then use both methods. Then you could
> specify the "pause" callback within the tegra_dma_chip_data
> [tdma->chip_data->pause(tdma)], instead of using condition in the code.

s/pause/terminate/
