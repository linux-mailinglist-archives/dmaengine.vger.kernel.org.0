Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D89745F52
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jul 2023 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGCPA6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jul 2023 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGCPA5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jul 2023 11:00:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C36BE5E
        for <dmaengine@vger.kernel.org>; Mon,  3 Jul 2023 08:00:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so5777364a12.1
        for <dmaengine@vger.kernel.org>; Mon, 03 Jul 2023 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688396453; x=1690988453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYc7ssW76JbeyuIAYWb2z/AMKU9mWqY66zI1YvE3ht4=;
        b=rq3em3i2DhBtDJZbyPiiH/JcD1whzSHiFE+JJXBVtdQ7Tq3p/2ShBpJc/UnO79qBh4
         dAYkUPQ1m3NvvHRtkMH3gr/vV21L+K5D2Oaeysm1HKEU56G4eV0RWgmGs3Zug6JRw/uv
         NDODM6ZAIj83FeP3w8oKRGCLKlWZTD4GJ+9T8kg1SDDNmCV2rDMTm4X3HgSCsCy6NtfJ
         lxwevRsHXWM8SRP3n/IrG6nsLudj15VBgyQsxEulKpwMRoFDf35iMHqw8qkYUFc0x6EE
         uHW7NSSUAwzgxhgtZC2G5mqIQNeBP2swrKbq18kQrpKjvgEKQDmBVwqP80xWOTJUHgpI
         EAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396453; x=1690988453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYc7ssW76JbeyuIAYWb2z/AMKU9mWqY66zI1YvE3ht4=;
        b=VsoCckWCZPt3Ylxp2U46nyLWo1zaKFkChK7Zd0h1wMr8iF1nlvSiIhWJFSKv4CVgWn
         mxvpzZ5hjhAkskQQYOwdZHnouIXh0XfacPw/be37Gz0OXXZfxdZ5xbqXbhxwTpsQgJdG
         EYEWMwi/4S51L9nx3jgwi7jH2hoj8rPrC0KZzXAGjnclwBWMISVBIpZem/Aafp9pP4Ki
         WLyfk5HiVA4PkgLn0Fus1GCJrB6Hgm8oMJMad/J/MgTf8YV1nEtaFyCG5XkAP5ZGmT0+
         uNifwbHaS0D2ROhUUGVwjC3la9b3TNz3HM23R1Fr5PlScKHm9VZ6Mb73CzDI7t3yDyiX
         pktQ==
X-Gm-Message-State: ABy/qLY8nKkYn2r+7hdSxwmEhZ8Gf72c0fguQL1bKZtYui4tIg4kVt87
        Aksgdtv1NzZYe0ihJ8OsjHxmXQ==
X-Google-Smtp-Source: APBJJlFd14wiD2Xpe42nUkkf2jg9Ee7geplQ4o0gKJmte8k6StgWqm4Jvh5aw2ZOGo/GOSZbcFcCpQ==
X-Received: by 2002:aa7:d7ce:0:b0:51d:f37b:1b4e with SMTP id e14-20020aa7d7ce000000b0051df37b1b4emr7377991eds.19.1688396453073;
        Mon, 03 Jul 2023 08:00:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709063e1100b009875a6d28b0sm2266432eji.51.2023.07.03.08.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 08:00:52 -0700 (PDT)
Message-ID: <cf2978dc-9ef9-0b3c-911a-7da97977e412@linaro.org>
Date:   Mon, 3 Jul 2023 17:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 00/13] dmaengine: edma: add freescale edma v3 support
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
 <ZJxHc62V72eVMYu4@lizhi-Precision-Tower-5810>
 <3ce07ab8-9ed0-d5c0-e7da-bb24085cc3f8@linaro.org>
 <ZKLfB7putFfLlAoH@lizhi-Precision-Tower-5810>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZKLfB7putFfLlAoH@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03/07/2023 16:45, Frank Li wrote:
> On Sun, Jul 02, 2023 at 10:22:22PM +0200, Krzysztof Kozlowski wrote:
>> On 28/06/2023 16:45, Frank Li wrote:
>>> On Tue, Jun 20, 2023 at 04:12:08PM -0400, Frank Li wrote:
>>>> This patch series introduces support for the eDMA version 3 from
>>>> Freescale. The eDMA v3 brings alterations in the register layout,
>>>> particularly, the separation of channel control registers into
>>>> different channels. The Transfer Control Descriptor (TCD) layout,
>>>> however, remains identical with only the offset being changed.
>>>>
>>>> The first 11 patches aim at tidying up the existing Freescale
>>>> eDMA code and laying the groundwork for the integration of eDMA v3
>>>> support.
>>>>
>>>> Patch 1-11:
>>>> These patches primarily focus on cleaning up and refactoring the existing
>>>> fsl_edma driver code. This is to accommodate the upcoming changes and new
>>>> features introduced with the eDMA v3.
>>>>
>>>> Patch 12:
>>>> This patch introduces support for eDMA v3. In addition, this patch has
>>>> been designed with an eye towards future upgradability, specifically for
>>>> transitioning to eDMA v5. The latter involves a significant upgrade
>>>> where the TCD address would need to support 64 bits.
>>>>
>>>> Patch 13:
>>>> This patch focuses on the device tree bindings and their modifications
>>>> to properly handle and integrate the changes brought about by eDMA v3
>>>
>>> @vkoul:
>>>   Do you have chance to check these patches? Any chance to come into 6.5
>>>   All audio parts of i.MX8x and i.MX9 was dependent on these patches.
>>
>> Why do you ping during the merge window?
>>
>> v6.5? And what about having it in next for two weeks? One thing is to
>> ping for something forgotten, different thing is to try squeeze patches
>> skipping our process.
> 
> I saw dmaengine tree have not update over 5 weeks.
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/

Then you should have pinged during that time.

> And vkoul have not sent out pull request yet. So I just want to check
> if possible. 

It is merge window. Patches are supposed to be in next for two weeks
before merge window.



Best regards,
Krzysztof

