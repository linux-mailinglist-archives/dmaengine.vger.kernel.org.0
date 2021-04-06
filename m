Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70F35580D
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243787AbhDFPfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345791AbhDFPdT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 11:33:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC2BC0613DF;
        Tue,  6 Apr 2021 08:32:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a1so17006815ljp.2;
        Tue, 06 Apr 2021 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ezZNk4sv/EZWbQ+FrDDVFe1cGPk81iOpvFjH5bRIvIE=;
        b=Q/fJsnOqdM/Luj+magEcEmdw1nOnRxNLtMR2wRRPmtFZmCufD35Qwr7VPofLH5GLNl
         SinibKnUJJQ5SBShGafaQx1pejB1wTZYNnQiN09XeAbGfBR/rzRHcXW3koJip580045T
         kYD5LjfwG687Hy1bPxNQ/R5QxGjBcfKmrM3Lvp8uI77ZPoHZYNHp3U1o6Vw8qbnY9bwf
         c4tqwUfvaXwLQYC7x1+XdG6JVhpcsE5YAQw78xx8lYE9VyDU7dJgXYf+j708F42/hBcG
         05dGvqvhTBPhdhF1VH3TWeFPNC1WsaqqK9ZUCeNpp4B40UQ33w0Ms6QMwlunMXH6Au8a
         9d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ezZNk4sv/EZWbQ+FrDDVFe1cGPk81iOpvFjH5bRIvIE=;
        b=Bb7zUQKSJinDwQLVYAXMfmmzsPpb3DDbv1dK2htY4j7y8rwM/QV36Io6ppFwLeKVRb
         ffCjKQqIfU/CpcBo7fMJXLEs9CR/9p391+f7VA2vtD5PK29QPONLOqJb+qqDcebWAl/y
         pHWzLBg9hQBP3E+K9DqYDTfuC/Gao8nF9rrrj2tVG5o0OvNChX9kPlVajg2XH3ECsY1i
         IEoteh9+rDLo4HQMlRQVeTeJdygxs2WF5IANfzthnltzFnVlXIOBNXhaKrwLetEosulW
         b64CkQi47SAq5U5hX5g8dXgiiGM95ACnyoDcjgqycqX/rhBCoU4W3AqcEu4oPDd/O1L5
         I7Tg==
X-Gm-Message-State: AOAM5333YFEcBHJ4iTT085FYZks16pebZpOQ/lRbi50GMNCn6LsOk6bK
        kBQdpubKVjwy8qgwVIn54gw=
X-Google-Smtp-Source: ABdhPJyFQnVLW01zqbivc9dqKMhXgYuxnkRmqSE5gT0eKQlOu9jOiBT2GBXa6Cu06NOk/lEW8XAefQ==
X-Received: by 2002:a2e:9143:: with SMTP id q3mr19804523ljg.378.1617723175021;
        Tue, 06 Apr 2021 08:32:55 -0700 (PDT)
Received: from [10.0.0.42] (91-157-86-200.elisa-laajakaista.fi. [91.157.86.200])
        by smtp.gmail.com with ESMTPSA id f11sm2251868lfm.230.2021.04.06.08.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:32:54 -0700 (PDT)
Subject: Re: [PATCH 11/16] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-12-p.yadav@ti.com>
 <78a5983c-04c8-4a4c-04fe-bb1f31e87375@gmail.com>
 <20210406150942.4kyjh2ehsvklupjr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <54b0846e-d633-2a03-2c64-f1f0a85c2410@gmail.com>
Date:   Tue, 6 Apr 2021 18:33:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406150942.4kyjh2ehsvklupjr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/6/21 6:09 PM, Pratyush Yadav wrote:
> On 04/04/21 04:24PM, Péter Ujfalusi wrote:
>> Hi Pratyush,
>>
>> On 3/30/21 8:33 PM, Pratyush Yadav wrote:
>>> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
>>> have up to 32 threads but the current driver only supports using one. So
>>> add an entry for that one thread.
>>
>> If you are absolutely sure that the other threads are not going to be
>> used, then:
> 
> The opposite in fact. I do expect other threads to be used in the 
> future. But the current driver can only use one so I figured it is 
> better to add just the thread that is currently needed and then I can 
> always add the rest later.
> 
> Why does this have to be a one-and-done deal? Is there anything wrong 
> with adding the other threads when the driver can actually use them?

You can skip CCing DMAengine (and me ;) ). Less subsystems is the better
when sending patches...

> 
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>>
>> but I would consider adding the other threads if there is a chance that
>> the cs2rx will need to support it in the future.
>>
>>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>>> ---
>>>  drivers/dma/ti/k3-psil-j721e.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
>>> index 7580870ed746..19ffa31e6dc6 100644
>>> --- a/drivers/dma/ti/k3-psil-j721e.c
>>> +++ b/drivers/dma/ti/k3-psil-j721e.c
>>> @@ -58,6 +58,14 @@
>>>  		},					\
>>>  	}
>>>  
>>> +#define PSIL_CSI2RX(x)					\
>>> +	{						\
>>> +		.thread_id = x,				\
>>> +		.ep_config = {				\
>>> +			.ep_type = PSIL_EP_NATIVE,	\
>>> +		},					\
>>> +	}
>>> +
>>>  /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
>>>  static struct psil_ep j721e_src_ep_map[] = {
>>>  	/* SA2UL */
>>> @@ -138,6 +146,8 @@ static struct psil_ep j721e_src_ep_map[] = {
>>>  	PSIL_PDMA_XY_PKT(0x4707),
>>>  	PSIL_PDMA_XY_PKT(0x4708),
>>>  	PSIL_PDMA_XY_PKT(0x4709),
>>> +	/* CSI2RX */
>>> +	PSIL_CSI2RX(0x4940),
>>>  	/* CPSW9 */
>>>  	PSIL_ETHERNET(0x4a00),
>>>  	/* CPSW0 */
>>>
>>
>> -- 
>> Péter
> 

-- 
Péter
