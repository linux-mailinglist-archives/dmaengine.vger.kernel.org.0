Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46947362CB
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 06:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjFTEv0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 00:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTEvZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 00:51:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6710C8;
        Mon, 19 Jun 2023 21:51:24 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M42zo-1qBTKN2n5M-00054G; Tue, 20 Jun 2023 06:50:51 +0200
Message-ID: <10083068-fab1-3e51-c183-e2a435167ad2@i2se.com>
Date:   Tue, 20 Jun 2023 06:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/7] dt-bindings: dma: convert bcm2835-dma bindings to
 YAML
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        linux-pwm@vger.kernel.org
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
 <20230617133620.53129-3-stefan.wahren@i2se.com>
 <168721491312.1673983.7120570846265839418.robh@kernel.org>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <168721491312.1673983.7120570846265839418.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VKWLyx96kIFaTCi0ZFhPdTmk8Mv0uYKT8yyjMylyRQeFhlZr2zB
 0SCgVtkvHlqNX7+3pwohYn9u37nMq1Neu3hbSFJdFXTGn00hKvkjGmIMtuaI9oKbuW6Gapm
 kqOyY/9XwgQbUwizhQ246lxUDN3QoYy8Cicxk2jbmIh4mBtM9/5b4qPtkqK6hY/8pgND1zd
 bUoIpNdIQzmSLZ3gp1fWA==
UI-OutboundReport: notjunk:1;M01:P0:CaJX/oWs7lE=;ECsu5Sz0cJwgPABRHlq1vITW5Mm
 3DACX5F/VSYi31OW6WeGpAEnh96lvJkX1jmZcd2fk3RtAa9Uutck52w1MotLWaerWqbr8fzik
 Nk8bZkcZKvZ6MUYYFwrkin5agUBRJ5E0stwYpmmnBj5Zc+SeyhqbNXC35AZXooaXC7SsyeCOx
 r6oJ55aJ01aNd2dVFY1Gz6Xp6jOKzIjS7fap7tLoOsdWbINDlOtQBbvN4Z7sozc1yJDsiPcDV
 WyeZkTPUmJIehNZKtXqSATVun+rNfhYTWfMjNjf3PK+mc5wO9sw2/IcRK0GdwVSdTvtsu01gR
 Lc4V6Vvvh5Zix95nWcpORzEFFSt5B69XWHMtyeOW9cQqrv1CP/mp4lWqRnZ2m1sWkhCLR+ii8
 dK9+PK0yfnZLVABtcMcpSaN551ZFerUrng+1mCLYXLCn60SxOW3fDHA76gPG+h20M7vrjiVLD
 tHgrPDWwmwfqAci4gOGbey+ZfLawGB0lBB3Jpouu83v2GNsx/R7obysGh78yeWFcZ9SzyL05O
 cNrWbsVOtiRJfBLGPkDLqFpnUf72FB+pZHteBQjI99CCkdJy9caK1r3n0P0V9RBNpgGulx2pT
 lq8pVtUPwbc8/6lnhlVMYQr1w4PIuQLT1cSJoNzxWrYSnLzAv8/tWZtpG2nFsK6ZsIEHicweR
 x9+nW1i7/sG9KszDVxVdV6l5yW0N75AgiemyMBONsg==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

Am 20.06.23 um 00:49 schrieb Rob Herring:
> On Sat, 17 Jun 2023 15:36:15 +0200, Stefan Wahren wrote:
>> Convert the DT binding document for bcm2835-dma from .txt to YAML.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>   .../bindings/dma/brcm,bcm2835-dma.txt         |  83 --------------
>>   .../bindings/dma/brcm,bcm2835-dma.yaml        | 102 ++++++++++++++++++
>>   2 files changed, 102 insertions(+), 83 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>>   create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

i was uncertain after replacing the generic dma-channel-mask with the 
vendor ones. So i decided to drop the reviewed-by.

Best regards

> 
> Missing tags:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> 
> 
