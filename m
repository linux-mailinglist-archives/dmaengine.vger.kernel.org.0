Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC2469A5EB
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 08:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBQHHz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 02:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBQHHw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 02:07:52 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A715579
        for <dmaengine@vger.kernel.org>; Thu, 16 Feb 2023 23:07:47 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f22so61736lja.6
        for <dmaengine@vger.kernel.org>; Thu, 16 Feb 2023 23:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSwBYjZrNmln+ctA3/m+T2GVcsFUCJyV9W5bCg8FwVk=;
        b=WDYC5mLgBgby4IkaIx/erhiX6pHvAGJfn8AJ4Fg/PsJDfzV1FccE5bSHlt/k0neWN+
         5qavbew9Z52SAlMUJ96LibXdf5m1sH5ZOkRocvtrbl0TH3Xrmt/+XPkVPM59vvG1r+hn
         HbDNb/N+2xr7ig+uN972FTzu6d3SEDZyRlEFzAp6pA2US89GZjl/hBOEG/IEJWigdGPt
         Lst25/ZCiiIBlMlLrvVQVm+sR9pDzrACptLz81ApuVfu/gf+8sw7lo47LQefw6+eHJuV
         yD5/EGCJghbXSuVjvEL6I2t+czet84cYRS2HZBLOMylaDln80DXMzGttG3vaQR6V8971
         PI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSwBYjZrNmln+ctA3/m+T2GVcsFUCJyV9W5bCg8FwVk=;
        b=jigwZhIggxnGEQb7SkXzm9I7ONTlCEtYlEUXjX/AYARITJinHOYlJxWtHjLs/IHv73
         v3FbpTVo5qCwS1aiEZ2yJsdockFENtkMYcOCTqvWd7+2LJjVrKd3TD4XbMXKd2OP7qxy
         PxkrkHMixxOtMovNzbSZrV0V3Cz3LTp3hd7UPLQsV/2wnJuPgGQgO9qtLxzxY8lMud6K
         X2swNtkt1liEDqUlonMOuHA+9uymcjQpBY4eA1SZ7HWy1Yrb0VFNTkFxivr/5Vu18fH6
         rA3lhU1SRFR4J1QUYwgkPU+EBekTajxLNrwM15UIUIGFs3TcDcs4/XJtN7RQcjr88WpA
         hGJA==
X-Gm-Message-State: AO0yUKXDYEeZB4jZGNAjpwcJG9HSl8V8IyTeR0He2zBLF78ooHxUrkjx
        cXEzF5jTyI0wf2m+9BLxLZMKdA==
X-Google-Smtp-Source: AK7set/tAqwu8sxy4AE7vnmKG3xqNcDOKRCF7xpzyi9Ted3sLXbDrbOLyQwAqOQnLDHo62Xv/Vt9tQ==
X-Received: by 2002:a05:651c:b29:b0:290:7d15:464a with SMTP id b41-20020a05651c0b2900b002907d15464amr134730ljr.5.1676617665835;
        Thu, 16 Feb 2023 23:07:45 -0800 (PST)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id f2-20020a2e1f02000000b00294619d902dsm471489ljf.112.2023.02.16.23.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 23:07:44 -0800 (PST)
Message-ID: <767e4d8d-b691-1849-71ac-5d6cefbb8d6a@linaro.org>
Date:   Fri, 17 Feb 2023 09:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v7 1/1] dma: qcom: bam_dma: Add support to initialize
 interconnect path
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     dmaengine@vger.kernel.org, agross@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, vkoul@kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220921030649.1436434-1-bhupesh.sharma@linaro.org>
 <20220921030649.1436434-2-bhupesh.sharma@linaro.org>
 <a5b6255c-7282-32ed-8031-a4b841a78db7@linaro.org>
 <CAH=2Ntw6XcyB2zy-cs35z3eOf8iTa28hGerhLndOgARrG05gJw@mail.gmail.com>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <CAH=2Ntw6XcyB2zy-cs35z3eOf8iTa28hGerhLndOgARrG05gJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2/17/23 06:00, Bhupesh Sharma wrote:
> On Thu, 16 Feb 2023 at 19:49, Vladimir Zapolskiy
> <vladimir.zapolskiy@linaro.org> wrote:
>>
>> On 9/21/22 06:06, Bhupesh Sharma wrote:
>>> From: Thara Gopinath <thara.gopinath@gmail.com>
>>>
>>> BAM dma engine associated with certain hardware blocks could require
>>> relevant interconnect pieces be initialized prior to the dma engine
>>> initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
>>
>> Apparently it's proven that the change description is incorrect, Qualcomm
>> crypto engine is working fine on SM8250 and even more recent platforms,
>> so far there is no obvious necessity in this change.
> 
> Since your v9 patchset produces no entry in $ cat /proc/crypto on
> either RB5 (qrb5165) or (with an additional patch) on sm8150-mtp or
> sa8115p-adp with the default arm64 defconfig with linux-next, I am not
> sure we can conclude QCE is working with these changes.

Hopefully someone else can conclude it independently.

You may notice that v9 patchset series does not contain sm8150 specific
changes, but sm8250 one (v9 11/14) is present, testing on RB5 is valid.

> Please share more details on how you tested this.

I do compile linux-next with v9 QCE series applied on top of it and run the
kernel on RB5 board, there is nothing really complicated about it.

If you missed it, the 'cryptobench benchmark' test etc. have been already
described, please find it here:

   https://lore.kernel.org/linux-crypto/731af3cf-6f18-caf9-ef65-ec73b0744ad9@linaro.org/

--
Best wishes,
Vladimir

>>> is passed on to the bam dma driver from dt via the "interconnects"
>>> property. Add support in bam_dma driver to check whether the interconnect
>>> path is accessible/enabled prior to attempting driver intializations.
>>>
>>> If interconnects are not yet setup, defer the BAM DMA driver probe().
>>>
>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> [Bhupesh: Make header file inclusion alphabetical and use 'devm_of_icc_get()']
>>> ---
>>>    drivers/dma/qcom/bam_dma.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>>> index 2ff787df513e..a5b0cf28ffb7 100644
>>> --- a/drivers/dma/qcom/bam_dma.c
>>> +++ b/drivers/dma/qcom/bam_dma.c
>>> @@ -26,6 +26,7 @@
>>>    #include <linux/kernel.h>
>>>    #include <linux/io.h>
>>>    #include <linux/init.h>
>>> +#include <linux/interconnect.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/module.h>
>>>    #include <linux/interrupt.h>
>>> @@ -394,6 +395,7 @@ struct bam_device {
>>>        const struct reg_offset_data *layout;
>>>
>>>        struct clk *bamclk;
>>> +     struct icc_path *mem_path;
>>>        int irq;
>>>
>>>        /* dma start transaction tasklet */
>>> @@ -1294,6 +1296,14 @@ static int bam_dma_probe(struct platform_device *pdev)
>>>        if (IS_ERR(bdev->bamclk))
>>>                return PTR_ERR(bdev->bamclk);
>>>
>>> +     /* Ensure that interconnects are initialized */
>>> +     bdev->mem_path = devm_of_icc_get(bdev->dev, "memory");
>>> +     if (IS_ERR(bdev->mem_path)) {
>>> +             ret = dev_err_probe(bdev->dev, PTR_ERR(bdev->mem_path),
>>> +                                 "failed to acquire icc path\n");
>>> +             return ret;
>>> +     }
>>> +
>>>        ret = clk_prepare_enable(bdev->bamclk);
>>>        if (ret) {
>>>                dev_err(bdev->dev, "failed to prepare/enable clock\n");
>>
>> I'm resurrecting the comments on this change to emphasize the observation
>> that the change is not needed at all to run QCE.
>>
>> --
>> Best wishes,
>> Vladimir
