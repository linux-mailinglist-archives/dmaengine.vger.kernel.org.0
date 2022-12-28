Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA9658061
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiL1QRj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 11:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiL1QRM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 11:17:12 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598521A3AE
        for <dmaengine@vger.kernel.org>; Wed, 28 Dec 2022 08:15:22 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id bn6so7046998ljb.13
        for <dmaengine@vger.kernel.org>; Wed, 28 Dec 2022 08:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDZvkBvSrq1P74c4ojvaQa9MsowatpZHUMPzWldA71g=;
        b=PvScfYgvO3aKt+TMrMAphrHdT1QPEOwJ934NeEOIEm/AIH7IDlhU+biY4NyGOaTmHJ
         RJ/7qRlSvn9OVXYjsO3PIkSSoU3MAY46ACg3CyyymURWTyKvuypz8YTPvsIll6C5lQO/
         btXjEww9oaYKWMoiPJeYYwU8aKc3h+m6bdf3RrElHoOgH+0Udzhs+x6AwVoxm2B1WmaS
         B7iXQdJ/S95Pfy3i2Qlsl9LNuGKspn+SS2w3OlYqXFD/aImEb2HQPaSz+jzwpVPw4hNP
         2hCSMAYwi6dNaFHyKQp/2X001ibstnXadYYNFHTMMF2lVQWf8mtIOWWJiSisxlkqIyvE
         jB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDZvkBvSrq1P74c4ojvaQa9MsowatpZHUMPzWldA71g=;
        b=ws0wgCOvYnjg+Fr6g1MZ9twckHsxnxN3aLlhzlOVbxXB+JoPh+KLTfq2O4vTD/OCW5
         iYpXsSihiZP1SvRg0lQl0ajYrJfGfwTx2W0TFZjYBm9rk5Y5yi6BGRw9Elotlwcgak9q
         niKRsqu6tKt1gO30CwcbOf5JYzxUwTZFSCVJr7PgOTvj4ryxcFJ9Cjr2zXmU1luVY3mO
         632yCrNwqeUZMePWw6bzuiXxWe0wp4TgCSSoG2qvZLq/8sEAEVLrN8Sb/iKiBn9Wao9+
         +2LvhkoqSI5No432kNxSWL2ZxE63TIA6FmecnQAHQm5iXDPgtz5yI89GaO622RuIwGx5
         NB7w==
X-Gm-Message-State: AFqh2kpmZHmA+DC37P3XDLkPp0jmHeRqB31x+RD8yWlObsBPHgB5iBwE
        4PdR5UbBSVeJtkmcrvheGs5QPP0UBDpPgVMlBU8=
X-Google-Smtp-Source: AMrXdXsbQOkbDqKHCQD2ADOuTnn+8YWAjm92yxG1SkLaJfYWlVgau/fn51IQ0uv+YLr0mjQ81EAHdA==
X-Received: by 2002:a2e:8e2e:0:b0:27f:bcad:a770 with SMTP id r14-20020a2e8e2e000000b0027fbcada770mr3379097ljk.52.1672244120567;
        Wed, 28 Dec 2022 08:15:20 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id r18-20020a2e8e32000000b0027cf0ecab3fsm1995465ljk.138.2022.12.28.08.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 08:15:19 -0800 (PST)
Message-ID: <7a145132-181b-cf52-18f4-4fd1b8a565d8@linaro.org>
Date:   Wed, 28 Dec 2022 18:15:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 1/1] dma: qcom: bam_dma: Add support to initialize
 interconnect path
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     dmaengine@vger.kernel.org, agross@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, Rob Herring <robh@kernel.org>
References: <20220921030649.1436434-1-bhupesh.sharma@linaro.org>
 <20220921030649.1436434-2-bhupesh.sharma@linaro.org>
 <YyvKlWgaPVV3su8f@matsya>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YyvKlWgaPVV3su8f@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22/09/2022 05:38, Vinod Koul wrote:
> On 21-09-22, 08:36, Bhupesh Sharma wrote:
>> From: Thara Gopinath <thara.gopinath@gmail.com>
>>
>> BAM dma engine associated with certain hardware blocks could require
>> relevant interconnect pieces be initialized prior to the dma engine
>> initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
>> is passed on to the bam dma driver from dt via the "interconnects"
>> property. Add support in bam_dma driver to check whether the interconnect
>> path is accessible/enabled prior to attempting driver intializations.
>>
>> If interconnects are not yet setup, defer the BAM DMA driver probe().
>>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> [Bhupesh: Make header file inclusion alphabetical and use 'devm_of_icc_get()']
>> ---
>>   drivers/dma/qcom/bam_dma.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 2ff787df513e..a5b0cf28ffb7 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/io.h>
>>   #include <linux/init.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>>   #include <linux/interrupt.h>
>> @@ -394,6 +395,7 @@ struct bam_device {
>>   	const struct reg_offset_data *layout;
>>   
>>   	struct clk *bamclk;
>> +	struct icc_path *mem_path;
>>   	int irq;
>>   
>>   	/* dma start transaction tasklet */
>> @@ -1294,6 +1296,14 @@ static int bam_dma_probe(struct platform_device *pdev)
>>   	if (IS_ERR(bdev->bamclk))
>>   		return PTR_ERR(bdev->bamclk);
>>   
>> +	/* Ensure that interconnects are initialized */
>> +	bdev->mem_path = devm_of_icc_get(bdev->dev, "memory");
>> +	if (IS_ERR(bdev->mem_path)) {
>> +		ret = dev_err_probe(bdev->dev, PTR_ERR(bdev->mem_path),
>> +				    "failed to acquire icc path\n");
>> +		return ret;
>> +	}
> 
> So this makes us fail on older DT where icc path may not be present.
> Should this not be an optional thing?

If "interconnects" property is not present, of_icc_get() returns NULL. 
So the driver will not err out (correct). All ICC functions will treat 
NULL path correctly (by doing nothing). So this patch is correct.

However we'd need v8 anyway, there needs to be a bindings update.

Bhupesh, this has been lingering for some time. We need this for several 
platforms. Any chance for the v8?

> 
>> +
>>   	ret = clk_prepare_enable(bdev->bamclk);
>>   	if (ret) {
>>   		dev_err(bdev->dev, "failed to prepare/enable clock\n");
>> -- 
>> 2.37.1
> 

-- 
With best wishes
Dmitry

