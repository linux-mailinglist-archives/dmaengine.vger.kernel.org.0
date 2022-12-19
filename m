Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF565091A
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 10:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiLSJKL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 04:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiLSJJq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 04:09:46 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CABB1E5;
        Mon, 19 Dec 2022 01:09:43 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B101684A16;
        Mon, 19 Dec 2022 10:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671440982;
        bh=8JKmjp9hX6HGLJXVyNffROHSCvDh9ExIvvXnp6l9sAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nixxN/9AGVflVQaedIMf9BWavwHdZebP2xMUa2TWm7epXx03g1azrYYwATvV2eHhA
         Y+fJJyxWTEvX+X/Z8qC+iUC03D4uoup+t0ngHkhcQyfQ1b4NWXpKQORZNPsG6GsQHC
         uQH6gWrV9y7hawOFad1Z/YglU/JBH7NdAv8FdmiDgBfpq10GFT7xkVqhqgwh1eeAcd
         kEO7spmlemo2yViLbLNFhOxm/4UTpzbxLdTF/a+4vOvZr4zAWTEPFusQpEXb42x1wq
         0e9mUJMb5F7eHX2kOAqTfXomArEHMSIt2zLk4iHhu9IqTXz8kN082DzZEutsNdNaGG
         N6VJe2T+AI7DQ==
Message-ID: <2e56cbcf-cf10-93a1-bfbd-f3a39cc5717c@denx.de>
Date:   Mon, 19 Dec 2022 10:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT
 schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221217010724.632088-1-marex@denx.de>
 <b74776b4-0885-f519-8ef7-e01048a8be15@linaro.org>
 <ba05612d-fd3b-3e49-4ada-21f3b3c74e23@denx.de>
 <a5bb28a7-c7d3-be98-9621-996d38656d98@linaro.org>
 <58b96f52-30ae-c868-8434-a0ca9e996bcd@denx.de>
 <40956c61-ed9e-2ca3-868b-445510ea1c05@linaro.org>
 <9f2a068b-9275-659f-b1ae-0b6046fea18b@denx.de>
 <04914294-0d1b-d6ab-a3da-c8fd8e35b3b9@linaro.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <04914294-0d1b-d6ab-a3da-c8fd8e35b3b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/19/22 09:57, Krzysztof Kozlowski wrote:
> On 19/12/2022 09:46, Marek Vasut wrote:
> 
>>>>>> if does not match on 6q/6sx/7d/23-apbx/28-abbh/28-apbx then 8
>>>>>>
>>>>>> if does not match on 6q/6sx/7d/23-apbh then 16
>>>>>>
>>>>>> But if there is a better way to validate the above, please do tell.
>>>>>
>>>>> Then your existing if:then: is also not correct because you require for
>>>>> fsl,imx28-dma-apbh (as it is not in second if:then:) const:16. Just
>>>>> don't require it.
>>>>
>>>> So, shall I just drop the entire allOf: section ?
>>>
>>> No, what about the interrupts?
>>
>> The interrupts and dma-channels are matched 1:1 for this controller, 1
>> DMA channel, 1 interrupt. 16 dma channels means 16 interrupts .
> 
> Ah, then probably you need to drop entire allOf,.

Oh well ... too bad.
