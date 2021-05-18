Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6891B387C90
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350249AbhERPja (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350245AbhERPj3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 May 2021 11:39:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511EC061760
        for <dmaengine@vger.kernel.org>; Tue, 18 May 2021 08:38:11 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o27so9655906qkj.9
        for <dmaengine@vger.kernel.org>; Tue, 18 May 2021 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHk8jTLjGRhBkosG/Y9mmV4IXiwYJNJWhiEHtFbYDBE=;
        b=KL8aoq2dBknGdwjLoxfcvrplt+zbdX4cbam2aZQNX1/s4a3hyLLKwCL570ng4FkciW
         caehR6MGKn8Jz6XiEa5lcmt+/9BX+B8mJBcgl9LSiD4UWG9UsnzX40ErxOeUnaNbBQQz
         9Y+Yn83CBn0i8D/AH4OsAwGCEsDLShH9uzUevV2+AaHC95xUJhgGsC2oKcfNpDuUSgaI
         beZF5lY9Ga/E97/OoUd/G77UkrnKBseOWRBsnr0zWAAriMrqSanKC/a1+uT5Yg5yU0L2
         A/eSTy4mgkHx9KiTf9AuQQ/HqD7RhNspwhPF0DL7BG2jCf+hfgvX3nAFk8xWUkd7POrf
         PJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHk8jTLjGRhBkosG/Y9mmV4IXiwYJNJWhiEHtFbYDBE=;
        b=GIToejJjfE2Hv4XoNEviznsF3x3EkAuf+R4QW5aq0hOebGI2r6y2rRPZyJnxFvAoih
         AR92eFX1T6l6WJ6n7Lv+6VD2HFpfIzd5d5CXCaAuJXH54JGspH1I20csNxTaFzsJxfGv
         jDdodpkYbTOzft1llgX6WWUXeAv5RlZ/rqFt6USJuy22vAz/gYgrMHrfSXwK/zVnGs4t
         X87iEqctCmorsCIQ3ArYagL3mynTRaoRwsRpORFZhvPS2KA38tKoZwxowR0nfiPvpvrA
         RK1UkCjSoYCK3PdwBTBLcM2qv78dPZMimAsBY6dP3hegc4EQLcjdXbzXT5EtYs5HYLYM
         zzlw==
X-Gm-Message-State: AOAM533Fh4O0xrkJSNWzA5koqS1VIqdBCSYC0chHaf/21EYIbPRZNMJC
        i8PYUwNiCqsjJW4/do4Rkf/DxQ==
X-Google-Smtp-Source: ABdhPJzDZ3tqdXRScQz088nvn5Uj75hTZPqJ2TQAAvPz7G51zpOw4SlYxu/1Iko+aKuPUXfhFo0aCQ==
X-Received: by 2002:a05:620a:2291:: with SMTP id o17mr6071185qkh.150.1621352290394;
        Tue, 18 May 2021 08:38:10 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id o4sm7155973qkb.29.2021.05.18.08.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 08:38:09 -0700 (PDT)
Subject: Re: [PATCH v2 09/17] crypto: qce: core: Add support to initialize
 interconnect path
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
 <20210505213731.538612-10-bhupesh.sharma@linaro.org>
 <20210518150702.GW2484@yoga>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <180046b9-35fb-f7c1-fc92-a0fb5eecace5@linaro.org>
Date:   Tue, 18 May 2021 11:38:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518150702.GW2484@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/18/21 11:07 AM, Bjorn Andersson wrote:
> On Wed 05 May 16:37 CDT 2021, Bhupesh Sharma wrote:
> 
>> From: Thara Gopinath <thara.gopinath@linaro.org>
>>
>> Crypto engine on certain Snapdragon processors like sm8150, sm8250, sm8350
>> etc. requires interconnect path between the engine and memory to be
>> explicitly enabled and bandwidth set prior to any operations. Add support
>> in the qce core to enable the interconnect path appropriately.
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Andy Gross <agross@kernel.org>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: dmaengine@vger.kernel.org
>> Cc: linux-clk@vger.kernel.org
>> Cc: linux-crypto@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: bhupesh.linux@gmail.com
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> [Make header file inclusion alphabetical]
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> This says that you prepared the patch, then Thara picked up the patch
> and sorted the includes. But somehow you then sent the patch.
> 
> I.e. you name should be the last - unless you jointly wrote the path, in
> which case you should also add a "Co-developed-by: Thara".
> 
>> ---
>>   drivers/crypto/qce/core.c | 35 ++++++++++++++++++++++++++++-------
>>   drivers/crypto/qce/core.h |  1 +
>>   2 files changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
>> index 80b75085c265..92a0ff1d357e 100644
>> --- a/drivers/crypto/qce/core.c
>> +++ b/drivers/crypto/qce/core.c
>> @@ -5,6 +5,7 @@
>>   
>>   #include <linux/clk.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>> @@ -21,6 +22,8 @@
>>   #define QCE_MAJOR_VERSION5	0x05
>>   #define QCE_QUEUE_LENGTH	1
>>   
>> +#define QCE_DEFAULT_MEM_BANDWIDTH	393600
> 
> Do we know what this rate is?
> 
>> +
>>   static const struct qce_algo_ops *qce_ops[] = {
>>   #ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
>>   	&skcipher_ops,
>> @@ -202,21 +205,35 @@ static int qce_crypto_probe(struct platform_device *pdev)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> +	qce->mem_path = of_icc_get(qce->dev, "memory");
> 
> Using devm_of_icc_get() would save you some changes to the error path.

Right. I keep forgetting to use the devm_ version! Bhupesh, will you do 
these changes or do you want me to ?

-- 
Warm Regards
Thara



