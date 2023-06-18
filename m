Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5B734885
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjFRVPT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 17:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFRVPS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 17:15:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDDE13D;
        Sun, 18 Jun 2023 14:15:17 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N49Ul-1q1x8z1GuP-0102WV; Sun, 18 Jun 2023 23:14:56 +0200
Message-ID: <13ec386b-2305-27da-9765-8fa3ad71146c@i2se.com>
Date:   Sun, 18 Jun 2023 23:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 00/11] dmaengine: bcm2835: add BCM2711 40-bit DMA
 support
Content-Language: en-US
To:     Shengyu Qu <wiagn233@outlook.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
 <OS3P286MB259736F317E80CBAA2658853985EA@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <OS3P286MB259736F317E80CBAA2658853985EA@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TIm3R3XPlUbydU1vM5V4ahYsqGo22AdiXsrRxOaOlWU9yeSHu9k
 BnFuxrMMKsdukwnss/8wvNbnpvebOU94j8vCP18EBzGpJOCdXGykXjDXCnSzCGmkyYNblME
 qqhmERJEpCXiFV6tC/AEYT46fKK1q9jUCPQA+W7L1ejz1IrwlhSNSfcbaA9cLiDpgqePxDn
 vEIHs2qJspz9W0O62S6lQ==
UI-OutboundReport: notjunk:1;M01:P0:Xch+nh9eO/Y=;2Slx9wsa2DFcky3IfpoB+BeWYDG
 a6ua9lH8S88U/rSzU2pjJV/CX2hpT9T7iTCQYZ8LW3WjkACIr/TTKl5VCubUBZo52m/+vfdDN
 N31jtUiOUiaG5cIrhXXiEZu6IwVP00iixusExsakUFVxDmOh6dSMlbExnStl0uB+J2Ddx7uEq
 9glhZBwdo4y8+Wh3/pyAS7Vy1nVXA9I5PydDVgzmJKQzRlquoVLCxCI+MYm1UqD4CD4UjGA/O
 m+q6+Y7fji53TokomhadfkMnVCcrtDWoPl5gtROLE19su1uh0A7vwuI5t3aXgejslkxH2tnHb
 Ubnq6urUsDT7jGWjSAUhJKefW8djAXE9OhaMT7SkDt0PCLL5T7GGM8xEYiuWlFCqMFTEZg+6q
 71JREDfIX/J8NAxfIrMKrpL3bh1g/BjozeeZGWmOS0iehbafn/KqNhxLULHg8FkF5hVB4u/ut
 eaoFsjccUcHzzM1W9n3HC7WT6zUSDwOb9KymZRTbTGX0iC+cPoIHfJ1yeD9/CFS8t6xet5T7o
 QSesjWiHHw7qMGGm8fdDFfBEk5esdC8KD2kHM/VdMfSQwRoP5wvVpaW88gYEnJfYKnmHFQO3r
 VmqF/1c+WeZiHW1fzmaK4DdVWbUBn+fHHzT9t2riqyS7bNFBh10ccam9vWyJMPAsd0h+kWOC9
 qb39kdq/J8Hn8A7Ffdd0lEW1HDUsW84RzDG/+Al4sQ==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sengyu,

Am 18.06.23 um 21:43 schrieb Shengyu Qu:
> Hello Stefan,
> 
> Sorry to reply to this old series, but I wonder what happens to this 
> series?

i never found the time to prepare a newer version. Unfortunately the 
downstream kernel had a lot of changes regarding this feature recently.

> 
> Best regards,
> 
> Shengyu
> 
>> The BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
>> to access the full 4GB of memory on a Pi 4. This patch series serves as a
>> basis for a discussion (just compile tested, so don't expect anything 
>> working)
>> which include the following points:
>>
>> * correct DT binding and representation for BCM2711
>>
>> According to the vendor DTS [1] the 4 DMA channels are connected to SCB.
>> I'm not sure how this is properly adapted to the mainline DT.
>>
>> * general implementation approach
>>
>> The vendor approach mapped all the BCM2835 control block bits to the 
>> BCM2711
>> layout and the rest of the differences are handled by a lot of 
>> is_40bit_channel
>> conditions. An advantage of this is the small amount of changes to the 
>> driver.
>> But on the down side the code is now much harder to understand and 
>> maintain.
>>
>> This series tries to implement this feature in a more cleaner way
>> while keeping it in the bcm2835-dma driver. Before this series the driver
>> has ~ 1000 lines and after that ~ 1500 lines.
>>
>> So the question is this approach acceptable?
>>
>> Patches 1 - 3 are just clean-ups.
>>
>> Disclaimer: my knowledge about the DMA controller is very limited
>>
>> More information:
>>
>> https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
>>
>> [1] - 
>> https://github.com/raspberrypi/linux/blob/561deffcf471ba0f7bd48541d06a79d5aa38d297/arch/arm/boot/dts/bcm2711-rpi-ds.dtsi#L47
>> [2] - 
>> https://github.com/raspberrypi/linux/commit/44364bd140b0bc9187c881fbdc4ee358961059d5
>>
>> Stefan Wahren (11):
>>    ARM: dts: bcm283x: Update DMA node name per DT schema
>>    dt-bindings: dma: Convert brcm,bcm2835-dma to json-schema
>>    dmaengine: bcm2835: Support common dma-channel-mask
>>    dmaengine: bcm2835: move CB info generation into separate function
>>    dmaengine: bcm2835: move CB final extra info generation into function
>>    dmaengine: bcm2835: make address increment platform independent
>>    dmaengine: bcm2385: drop info parameters
>>    dmaengine: bcm2835: pass dma_chan to generic functions
>>    dmaengine: bcm2835: introduce multi platform support
>>    dmaengine: bcm2835: add BCM2711 40-bit DMA support
>>    ARM: dts: bcm2711: add bcm2711-dma node
>>
>>   .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |  83 ---
>>   .../devicetree/bindings/dma/brcm,bcm2835-dma.yaml  | 107 +++
>>   arch/arm/boot/dts/bcm2711.dtsi                     |  18 +-
>>   arch/arm/boot/dts/bcm2835-common.dtsi              |   2 +-
>>   drivers/dma/bcm2835-dma.c                          | 745 
>> +++++++++++++++++----
>>   5 files changed, 734 insertions(+), 221 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>>   create mode 100644 
>> Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
>>
