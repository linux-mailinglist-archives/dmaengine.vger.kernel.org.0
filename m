Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2E73E79A
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jun 2023 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFZSQz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jun 2023 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFZSQy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jun 2023 14:16:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CCD94;
        Mon, 26 Jun 2023 11:16:52 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.15]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N63NQ-1pyGlv1Q2S-016R6o; Mon, 26 Jun 2023 20:16:19 +0200
Message-ID: <47eac53a-8d93-16fa-a8db-68bbd40020a8@i2se.com>
Date:   Mon, 26 Jun 2023 20:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 7/7] dt-bindings: timer: convert bcm2835-system-timer
 bindings to YAML
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        dmaengine@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Vinod Koul <vkoul@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
 <20230617133620.53129-8-stefan.wahren@i2se.com>
 <02d1d74a-1476-41c8-6d94-3eb477352309@linaro.org>
 <543ca0c5-0051-3968-63cd-7982f95c06c6@i2se.com>
Content-Language: en-US
In-Reply-To: <543ca0c5-0051-3968-63cd-7982f95c06c6@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pf+nK9VlP6UkuRXw6XpNBDYvdhpAMd7zCnAyEYISBTYUuWfZsGA
 KhKvXGty+Tb7YBrwQDkiXzvssgyiuvbh1qNHvlEzU1uVAt5DaVXhSukj4YlEdnFCxs/Kc56
 3AMyVt0eNBGYqT6Mww9J1VWG19uSHT850Q67pFWJcxQ70YrI6gKDTGufkCQGnZf5q9B0Eef
 PkC3ZofiennUM481xaQrg==
UI-OutboundReport: notjunk:1;M01:P0:9baAdFLbfrw=;I04Bud++nv5QiIFcrr0i7NvorWL
 bmeG4KE1VO4eQSh+Wj84BLTzHYeNd7sAo9plxWLSlm6+wrJ6+eZSH5Tz5es+/silzRfMkHNvr
 QX7EBXAf3+4lnnI3dajXM5Bl/lntwtvh/wZlRUBrrYrejthXr6YQE160LSVzKSNCg5liKHvOl
 MtqTce1vS0xdsg2XNHdDarkIl3Q0yA4v/7tyl1VL+OgBcU92YQVyvzx7+4gq58wcc6vhAxyt5
 RvPgZ5+Fi/ui0GvojkXoMu4a40PhD4SrnI4gyfPOctRZc9EVW0YcNk5XRXXrNFZcrAOWYNR0n
 DLudhGKTeokM39AuofC6vHIvSS091Jm9S8XmwQVLhhMKdgw+AHAp5nq2EECpbgqu9/jRwTCH1
 AyUwgAz38xB9x4D9qJKC5vf7Z5duDMFLOhe0zjUYJxdxr5Es9nqHcdhwV1KgCh+xRELVs67dU
 A2e8NrLjZYOUovtmKtR+N7fa0tq0N7faVL8B/uwby3e9hCly8/UYPkUBKSWwfF9fFTIeVOqsL
 IFgnG0Dw/McbUSSnV9+RP3QEpvO3XLK9SiOF6p3HMZwbXaPe8OT5ec8kSkb6tAOjVDtVuB1nH
 4Mxn4KibjxdPfaKfCCG/vdsXETLLunRNoixCqqk8IwifTw7aL/NZ2Ukr9ZLELEbFkFJAYaww7
 aC56FuQq3AdG5s/Yt/gCc4ryMTEhg2wkLZmfXso8RA==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

Am 19.06.23 um 20:57 schrieb Stefan Wahren:
> Hi Daniel,
> 
> Am 19.06.23 um 19:00 schrieb Daniel Lezcano:
>> On 17/06/2023 15:36, Stefan Wahren wrote:
>>> Convert the DT binding document for bcm2835-system-timer from .txt
>>> to YAML.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   .../timer/brcm,bcm2835-system-timer.txt       | 22 ---------
>>>   .../timer/brcm,bcm2835-system-timer.yaml      | 48 +++++++++++++++++++
>>>   2 files changed, 48 insertions(+), 22 deletions(-)
>>>   delete mode 100644 
>>> Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>>> deleted file mode 100644
>>> index 844bd5fbd04c..000000000000
>>> --- 
>>> a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>>
>> Appliedp patch #7
> 
> i'm so sorry but i accidentially added a Reviewed-by from Rob, which is 
> wrong here. I should have added to the patch 6 :-(

did you noticed the problem about the accidentially wrong added Reviewed-by?

Best regards

> 
> Regards Stefan
> 
>>
>> Thanks
>>
