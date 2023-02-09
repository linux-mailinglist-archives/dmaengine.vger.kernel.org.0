Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2169021B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Feb 2023 09:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBIIZ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 03:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBIIZz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 03:25:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9225549402
        for <dmaengine@vger.kernel.org>; Thu,  9 Feb 2023 00:25:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g17so2022255ply.11
        for <dmaengine@vger.kernel.org>; Thu, 09 Feb 2023 00:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWHfrncAO0fNEEl3cNIkJHh2nBhIpt0IcwJOPSV0vP8=;
        b=raBLAs5bGi3stjIdz6i9KJUeJgI81pjHlztiBEcT+0RElRcALFmQDpEkVidXVUXGT2
         /Tycp+/kCxDqt80huMS0blh06ZcwMPbo8FguNLhWvHzT7af9x+fiOBTRLZ4Zb1TnfPH/
         SBgNYwxtDBNZ1NBcPOcVFjy6rXDS1xQGq4aDwuXmBD/P4RZZoZaWpdoy97jNPWlor6Q7
         0AFCtjp6kcjtDKTOz/rQ6w3C+YaDrafPP13CDioi4qOKtevA/Hr2nbxTXtyKSgK3DDck
         azYf0EbGei6ICydovGkGXLbnF+NTPeRm8wqnPV+KvdDPNRPq62CQpaValElJ70b2gwFC
         fAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWHfrncAO0fNEEl3cNIkJHh2nBhIpt0IcwJOPSV0vP8=;
        b=pgUHCPjFrS5VeGKuV9JvV2UmM88v1XLJ6E6hkQenuO75F0iEwNfx9egqCnUuaGtpGs
         RvqI7laxN2q/ytUMhaTamn3qiBUPn6I3YTCCGPy7YCTxNzdVRJ3RcsnxTpiz9PAVCSrY
         RrWbaB1/hUtvNj0YD/Muinbseq3R4ymiIc70M/8XtWDgekrJTi9VTpmfWBTQmYUfQ8GT
         6JCtwigLK14/PrV1rQVFehWxlkr9Frovb2W94+mswG65luYOo0OIxEYSa18YhOEyClUC
         Dr7/VqIr15sf1du5xI1+8EqTPeDWQS4WCWswvvX3nG/2KO8gEPIKToPiIqadkO4wdpFW
         QMRA==
X-Gm-Message-State: AO0yUKVoxInvnRMvNhb8ySmHeKk0tapPbiiUfhO9JW0+Y7eBqbXFfwbl
        HvE1o7WocIJlMpEXJ2v58wT4CZCj72EycdLo
X-Google-Smtp-Source: AK7set+MQ/qgI81XBrcGunla1TWkQiw9offCfb1mAWCZzIwQDkFhjjSXSPu+VCRkEDsWSUiGFoDeGw==
X-Received: by 2002:a17:90b:3904:b0:22c:b2bf:e462 with SMTP id ob4-20020a17090b390400b0022cb2bfe462mr12062988pjb.34.1675931151006;
        Thu, 09 Feb 2023 00:25:51 -0800 (PST)
Received: from ?IPV6:2401:4900:1c5f:7a7d:9c44:b2ee:ae34:5374? ([2401:4900:1c5f:7a7d:9c44:b2ee:ae34:5374])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a744b00b002311f887aeasm1992634pjk.1.2023.02.09.00.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:25:50 -0800 (PST)
Message-ID: <32153a4b-9974-a42a-ef30-c0bd8cbc732b@linaro.org>
Date:   Thu, 9 Feb 2023 13:55:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam-dma: add optional memory
 interconnect properties
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org>
 <a188a52e-6327-f0ea-a54e-a23b88bca82f@linaro.org>
 <a8112f61-f8d3-c1e0-9549-a9036a7e7894@linaro.org>
 <88c31e71-55b6-a20d-1fcf-07804eace54b@linaro.org>
 <eda179e1-4cd1-0d1b-4e27-2fe92e959cf2@linaro.org>
 <0f16d63f-3bb0-54aa-bcb4-4c666d4b2846@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <0f16d63f-3bb0-54aa-bcb4-4c666d4b2846@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2/8/23 2:38 PM, neil.armstrong@linaro.org wrote:
> On 08/02/2023 10:03, Krzysztof Kozlowski wrote:
>> On 07/02/2023 16:27, Dmitry Baryshkov wrote:
>>> On 07/02/2023 15:35, Neil Armstrong wrote:
>>>> On 07/02/2023 11:32, Dmitry Baryshkov wrote:
>>>>> On 07/02/2023 12:03, Neil Armstrong wrote:
>>>>>> Recents SoCs like the SM8450 or SM8550 requires memory interconnect
>>>>>> in order to have functional DMA.
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>>    Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 6 ++++++
>>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> I suspect this will not work without a change for a driver.
>>>>>
>>>>
>>>> I had the impression single interconnect entries would be taken in 
>>>> account
>>>> by the platform core, but it doesn't seem to be the case, anyway I 
>>>> can;t
>>>> find
>>>> any code doing that.
>>>
>>> Probably you mixed interconnects and power-domains here.
>>>
>>
>> The driver change was submitted some time ago:
>> https://lore.kernel.org/all/20210505213731.538612-10-bhupesh.sharma@linaro.org/
>>
>> There is already DTS user of it and we expect driver to be resubmitted
>> at some point.
>>
>> What I don't really get is that crypto driver sets bandwidth for
>> interconnects, not the BAM. Why BAM needs interconnect? Usually you do
>> not need to initialize some middle paths. Getting the final interconnect
>> path (e.g. crypto-memory) is enough, because it includes everything in
>> between.
> 
> Indeed the interconnect on BAM may be redundant since QCE sets the BW,
> I'll investigate to understand if it's also necessary on BAM.

Since we are already doing this via QCE driver (since crypto block on 
qcom SoCs employs BAM DMA services) via [1], this change is not needed 
for sm8150, sm8250, sm8350 and subsequent qcom SoCs (available 
presently), so this patch can be dropped.

[1]. https://www.spinics.net/lists/linux-arm-msm/msg142957.html

Thanks,
Bhupesh
