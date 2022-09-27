Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F113D5ECAA0
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiI0RSq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiI0RSp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 13:18:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E91CE92B;
        Tue, 27 Sep 2022 10:18:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a8so16676204lff.13;
        Tue, 27 Sep 2022 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=hWuiH2hjxC60eC5NEhC3+DexXo0A/AK2nCFDvClrTJY=;
        b=C9pYu4xjGTyRzIhiy8D6sxPH9dpek5a7wxQgp5djUt/uF80k9sz2xGsqohYFX7VccG
         AE2ysiiZTMKx8wg4UHl1wU3Okr7d7OQymRuRkWT4yzZs0A35NsRzdXttg3k5RjjPOZ8z
         iIdyGAvT/qnie/DE6T/kwkimKL1teVIwdsmPFhFRs8yVRox1ObdVzdSpS59tpLcJyeWP
         y3QcLSQJz9QZJc3TQXe/j9SIvoib3fW33nY+viUgN3wDkIuLFgf8lHn9q+DNqw3IpR1i
         jPc0BksjtnYDte6gB0R4Vq7GEajTzvXwgnUzt2LUwRtMPe78LMZBTA/CKxUxJSpMDMAg
         9Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hWuiH2hjxC60eC5NEhC3+DexXo0A/AK2nCFDvClrTJY=;
        b=obdqd/JmfehTxmof8oe+u/qlGo6037EsL+pw4P/iFnW3cZ2h25SrATdQ5VpJf85rzC
         lLIMFB3EAL68Z2ydgxWCq5S50eWotw3x5e7ptEHEgEg6vhkf0xw7EJ8N/g8jzl1JZAUb
         +sBEmlARN+e5IZpsdAp7/ETPuCR9wtDReg345N+1Pm7kz+5274VOAkTKaoID+FQUl6cN
         BwOo58dd5BbE0R7TM9EzCgDl7RB44Jun2Xqb3DFgvTrt07eFpmsrFOof9GZf4KXoNuko
         IAQw9TBsOOWd4GCRP7Nm58dtulfYHGS7jgtMi0DowZ7aremzYjBG7daTHEfRFy9wbwJP
         P31A==
X-Gm-Message-State: ACrzQf0g2eDUiWfPt3S3y9AX6FjJnF4ypPeQa6PucBTmhDRVgfHnLDFI
        1VGqg8OWk9avgFiS1ssj5so0XdOhAchZ5A==
X-Google-Smtp-Source: AMsMyM6rBckm/aXEFHLdFTohaLyCJZdIsUhyEpQ27JbXbLbxgFISy7TWwkjhOqENC8R4BNbf/TjxJw==
X-Received: by 2002:ac2:52b1:0:b0:499:f7ac:14da with SMTP id r17-20020ac252b1000000b00499f7ac14damr12324889lfm.597.1664299122925;
        Tue, 27 Sep 2022 10:18:42 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id n25-20020a05651203f900b004a05837103csm213902lfq.196.2022.09.27.10.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 10:18:42 -0700 (PDT)
Message-ID: <390efbdd-6bb2-b1bb-7c4f-9c6f9032876a@gmail.com>
Date:   Tue, 27 Sep 2022 20:19:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <20220926181848.2917639-4-khilman@baylibre.com>
 <4c9f0284-f8d0-75e5-8bc9-944b040f9edb@gmail.com>
 <7hfsgeezqx.fsf@baylibre.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 3/3] dma/ti: convert PSIL to be buildable as module
In-Reply-To: <7hfsgeezqx.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 26/09/2022 21:50, Kevin Hilman wrote:
> Péter Ujfalusi <peter.ujfalusi@gmail.com> writes:
> 
>> Hi Kevin,
>>
>> On 9/26/22 21:18, Kevin Hilman wrote:
>>> map symbols need EXPORT_SYMBOL and files need MODULE_LICENSE.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>>> ---
>>>   drivers/dma/ti/Kconfig          | 3 ++-
>>>   drivers/dma/ti/k3-psil-am62.c   | 4 ++++
>>>   drivers/dma/ti/k3-psil-am64.c   | 4 ++++
>>>   drivers/dma/ti/k3-psil-am654.c  | 4 ++++
>>>   drivers/dma/ti/k3-psil-j7200.c  | 4 ++++
>>>   drivers/dma/ti/k3-psil-j721e.c  | 4 ++++
>>>   drivers/dma/ti/k3-psil-j721s2.c | 4 ++++
>>>   drivers/dma/ti/k3-psil.c        | 2 ++
>>>   8 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
>>> index f196be3b222f..2adc2cca10e9 100644
>>> --- a/drivers/dma/ti/Kconfig
>>> +++ b/drivers/dma/ti/Kconfig
>>> @@ -56,7 +56,8 @@ config TI_K3_UDMA_GLUE_LAYER
>>>   	  If unsure, say N.
>>>   
>>>   config TI_K3_PSIL
>>> -	bool
>>> +       tristate
>>> +       default TI_K3_UDMA
>>>   
>>>   config TI_DMA_CROSSBAR
>>>   	bool
>>> diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
>>> index 2b6fd6e37c61..7c4ca85f68b1 100644
>>> --- a/drivers/dma/ti/k3-psil-am62.c
>>> +++ b/drivers/dma/ti/k3-psil-am62.c
>>> @@ -4,6 +4,7 @@
>>>    */
>>>   
>>>   #include <linux/kernel.h>
>>> +#include <linux/module.h>
>>>   
>>>   #include "k3-psil-priv.h"
>>>   
>>> @@ -184,3 +185,6 @@ struct psil_ep_map am62_ep_map = {
>>>   	.dst = am62_dst_ep_map,
>>>   	.dst_count = ARRAY_SIZE(am62_dst_ep_map),
>>>   };
>>> +EXPORT_SYMBOL_GPL(am62_ep_map);
>>
>> Wouldn't it be better to build one module (k3-psil.ko) and link all the
>> platform libs into that?
>> They are unconditionally built in all cases anyways and makes the lsmod
>> under control.
>> And no need to export these maps at all is a plus.
> 
> I guess that's one option, but seems to be to be the wrong direction for
> a modular kernel.  To me, it seems like the next step would be to make
> it so only the SoC specific module is loaded instead of always loading
> them all.

The PSI-L map is a library atm and exporting all the maps outside of the 
PSI-L library is wrong. We shall have fixed API to look up (and update) 
a PSI-L endpoint configuration and only that API shall be allowed.

I prefer to have a single .ko binary for the PSI-L library/database for 
now. Optionally the individual SoC maps could be marked as init data and 
we could make a copy of the one that is needed on the booted device.

For SoC only loading this whole library way must be reworked to a 
platform or a bus driver (the bus description via DT was shot down 
during the initial UDMA submission, fyi). So you need to find a 'device' 
which would probe the PSI-L map and only load the map that is needed.

Furthermore: having the individual maps as separate .ko objects does not 
make much sense as none of them can be removed runtime, the symbols are 
used in the 'core' library.

-- 
Péter
