Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F00355C07
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 21:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhDFTNi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhDFTNi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 15:13:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BEC06174A;
        Tue,  6 Apr 2021 12:13:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d13so24471409lfg.7;
        Tue, 06 Apr 2021 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FhFTdFDdGwtDL8WY3HaGkOD3A8VWyO84+61OymRMX6I=;
        b=WIB6XW/TiJRxHSNFzvZ89RPfRmdEtET5o80KxRx1DZ4VN1BtYk1JplyRzZSYu8ROSd
         i7k1kNwKkoRSKRyBvarg8CZNNxcz0Q38byR3zYlIGZuZc7Bi+oMgCpvfyDYg0lRdtFxh
         PXNiH0Pvkz9Lh8rISYecHCBbKQbHRzL0z52zOZCA51beXvABDhSek1JzrTXLpRJjsboO
         mT4Wlr4XdKrSOPa7nellz0tTKuqNkxsBTvUNiej0cCcZrlYOHmv7pSU9s586aatbfOft
         ywaLW1b1MuCiEXZ6RapvjMxaPKmAMoLAUa8C1zg+4SznYZgZNBqMiTQPqTHbl4BuLyJm
         dJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FhFTdFDdGwtDL8WY3HaGkOD3A8VWyO84+61OymRMX6I=;
        b=rGKZ4BmnezCN3UGaecT8TfDjPzwxpkDy2hejxt7f/VxNXAn1xJrHxzga4x7BsTNW1z
         nUyMNIehnXo9+qrhzSp5h4WoV/zhzNIYnz2FYDtem3kW8izXRe6TvkiyCLWy6N27QThr
         Z/z85hw0nnhJCUX+zaVBV44qD21ltbFOvd6SdYcA7fkSpRfJijflS3EdSqImWnuPO74+
         0aA+IIryDrnVxzHm+OOiyDGA+qtL5TyPWE0ZGvbujORUEdgVtiS8q8LuRMeY+xZSCRPS
         ilJlLCVH6DqejJvW9CvS3IiWAPQOvgZC8PXXPUcF1Gj8rFwV63SqNgovu/mdYFUTWw3e
         2B5g==
X-Gm-Message-State: AOAM531M4roY2oMG/L24PvVBS9OEzq1qA0+988BMpHF5ClmH+x1RLoIj
        YFUebXMNnF0HSM8fWyQjfhQ=
X-Google-Smtp-Source: ABdhPJy8SprgTYVC07ZYxq7KFVBM738NYdUpa/R4brmPLEBRaVtsE39u4bAX874SyJSO5VoObxpC1Q==
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr21291336lfv.262.1617736408327;
        Tue, 06 Apr 2021 12:13:28 -0700 (PDT)
Received: from [10.0.0.113] (91-157-86-200.elisa-laajakaista.fi. [91.157.86.200])
        by smtp.gmail.com with ESMTPSA id z30sm46687lfg.162.2021.04.06.12.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 12:13:27 -0700 (PDT)
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
 <54b0846e-d633-2a03-2c64-f1f0a85c2410@gmail.com>
 <20210406165554.5mhn4u5enbf2tvaz@ti.com>
 <20210406171029.nku6hrmw7pohr5ri@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <81cce247-b06c-1aef-0dc0-3c592f6ef393@gmail.com>
Date:   Tue, 6 Apr 2021 22:13:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406171029.nku6hrmw7pohr5ri@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/6/21 8:10 PM, Pratyush Yadav wrote:
> On 06/04/21 10:25PM, Pratyush Yadav wrote:
>> On 06/04/21 06:33PM, Péter Ujfalusi wrote:
>>>
>>>
>>> On 4/6/21 6:09 PM, Pratyush Yadav wrote:
>>>> On 04/04/21 04:24PM, Péter Ujfalusi wrote:
>>>>> Hi Pratyush,
>>>>>
>>>>> On 3/30/21 8:33 PM, Pratyush Yadav wrote:
>>>>>> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
>>>>>> have up to 32 threads but the current driver only supports using one. So
>>>>>> add an entry for that one thread.
>>>>>
>>>>> If you are absolutely sure that the other threads are not going to be
>>>>> used, then:
>>>>
>>>> The opposite in fact. I do expect other threads to be used in the 
>>>> future. But the current driver can only use one so I figured it is 
>>>> better to add just the thread that is currently needed and then I can 
>>>> always add the rest later.
>>>>
>>>> Why does this have to be a one-and-done deal? Is there anything wrong 
>>>> with adding the other threads when the driver can actually use them?
>>>
>>> You can skip CCing DMAengine (and me ;) ). Less subsystems is the better
>>> when sending patches...
>>
>> I'm a bit confused here. If you are no longer interested in maintaining 
>> the TI DMA drivers then that's fine, I can skip CCing you. But the patch 
>> is still relevant to the dmaengine list so why should I skip CCing it? 
>> And if I don't CC the dmaengine list then on which list would I get 
>> comments/reviews for the patch?
> 
> Ignore this. Got your point. Will do it in v2.

If you know that you will be adding the other threads in the near future
then do it with one patch. When you add the support in the csi2rx driver
then you don't need to change the DMAengine files, thus no need to CC
dmaengine or me, thus you need to gather less acked-bys, thus the time
to mainline might be shorter.

-- 
Péter
