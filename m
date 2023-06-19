Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418BE735D9E
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjFSS6U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFSS6T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 14:58:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11295198;
        Mon, 19 Jun 2023 11:58:17 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhDIw-1pY9pj0HLu-00eNvT; Mon, 19 Jun 2023 20:58:01 +0200
Message-ID: <543ca0c5-0051-3968-63cd-7982f95c06c6@i2se.com>
Date:   Mon, 19 Jun 2023 20:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 7/7] dt-bindings: timer: convert bcm2835-system-timer
 bindings to YAML
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
 <20230617133620.53129-8-stefan.wahren@i2se.com>
 <02d1d74a-1476-41c8-6d94-3eb477352309@linaro.org>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <02d1d74a-1476-41c8-6d94-3eb477352309@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kyqNE6onSUIAGhdWOX7TEcOYSR9nJY4ipIuWMVmuruSxsIhOzwG
 q2igMagosSZnA+2D5Kel9Loe+7DhBLxfTmKCiPEihrjZqP2wLmOQ4mPwN8xV7sNi50MwTkE
 prt3SUqEjQqTNM5Gv1SwnMq/Qy5ogyoddMH60xBORXDxz2cmavEarrQxgtg/L84b8IzSe+N
 /SAGdh+B88crbEZ0Lo0hg==
UI-OutboundReport: notjunk:1;M01:P0:4sXSGuBBSEU=;YtGjuqafvYp7ClZgbhTSoPOUjgV
 a/BjjruTJSMjPW/mkG/kLTZG/sWk/ZwWo5AhYl6tYh0ApfaIjZLbzpWFZLU4q9pYkp2c+8YuU
 GppZRT9AkClPW1oWYArwQxkgjb8canfsk26sGIhAnGOxvOs4daBZ8C3lxCR7yaTd/rLqvwFwj
 SWTe1+57XzDTElV16gVqXBRlMiM2qhq2TP1i7L9uQgK425FJ6CgWiknkFRBgtAVgWTNBhg0z6
 BTRRho+o4YNXh7suwDbJDgpOeAN3ylI/nDv4LQt/kI6Zk2eyF1vGSO8cnK1WhUR7tT7WO0pke
 yMXXX1gPPOR4NK/ejqR3cC8vkmdmcyuz7FvK1xej+tKL/1lPvrisSS1gW2tPIB5Uy5+YmBE1p
 8bzoLYC/0/qb3x/PWSowRD2OwilFpZyHjrlW5Nd7hi81IGeUuoZehaxZDOuxHDE7b7md/F0HV
 8Cdlx6G/H/xsXby+zZk2uP77/I6e+Rv0JgF7y+tIMOFgIr0a94ELeRZhKro+KKKh5+bYjbp2C
 PkK98bQw6d1X//miCxqfr+cN4V2+/S20RsuQHUVSbl+UypNO/82PnjpG4WQaZRyPl22C1hp6l
 pqpRgWcu/0sVPW2julRijjaSfZvZxLf/el6nGCmURE3kBcUhsCqZgpTE04JYAE72FhQlw5+e0
 ru/vMoB5yxRtM/Puu0qhzzBHOjVU6O1JMIEC4hpOhQ==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Daniel,

Am 19.06.23 um 19:00 schrieb Daniel Lezcano:
> On 17/06/2023 15:36, Stefan Wahren wrote:
>> Convert the DT binding document for bcm2835-system-timer from .txt
>> to YAML.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../timer/brcm,bcm2835-system-timer.txt       | 22 ---------
>>   .../timer/brcm,bcm2835-system-timer.yaml      | 48 +++++++++++++++++++
>>   2 files changed, 48 insertions(+), 22 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>>   create mode 100644 
>> Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>> deleted file mode 100644
>> index 844bd5fbd04c..000000000000
>> --- 
>> a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
> 
> Appliedp patch #7

i'm so sorry but i accidentially added a Reviewed-by from Rob, which is 
wrong here. I should have added to the patch 6 :-(

Regards Stefan

> 
> Thanks
> 
