Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD672DD3B
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbjFMJDM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbjFMJDK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 05:03:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E861B0;
        Tue, 13 Jun 2023 02:03:08 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hIl-1qDeka0hE1-004lYy; Tue, 13 Jun 2023 11:02:41 +0200
Message-ID: <3b868924-9d9c-ae0a-a7b8-0afbd01c4a4b@i2se.com>
Date:   Tue, 13 Jun 2023 11:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] dt-bindings: pwm: convert pwm-bcm2835 bindings to
 YAML
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-6-stefan.wahren@i2se.com>
 <20230607075602.s2pfs7dl7fwkyevm@pengutronix.de>
 <20230609215932.GA2531610-robh@kernel.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230609215932.GA2531610-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wxebQsh+fQdLM/O5aHXaUpZItuLptFkBN2rvVclkEo3Bp8GEKR3
 X6I2DtvCMgKqy9kSY81It0h/h6MP7shw2ankru1f8xolFnfsGNwr/gdURjP2vhZ6DkyT9rL
 j373KVRGH42bYxKr18Cqv5bZqRM7p71jReJ+qCnyH7M+XbwWMpTy61nBDQJxobOwjyZldsU
 RU2HM7ZHeYPIf1R5LV6Tg==
UI-OutboundReport: notjunk:1;M01:P0:/vyMsFrDTWU=;yu+4WWlRUw7Eic4EVdnPupkpN8Z
 XKWXppWE/Bd+PWomLTBL5Rj0O1JhrxlNpO/lozFYnaHojViyW3S3RnOH03etqjOZ5q0snWxzy
 VU3F5qN75/lb8/wZB3zleVKMMnRpR+2o08HVTbgjJepviur80DDkiFYQoJQgD3oWGmW/A9bFT
 XWgygMn2WQSlT4/AAG1MjcEKIeFYAXGEnJS3ZZwHzRvRBr3SH4kghGwkL9VNe5lcC7jsKYC4/
 tbisOJgNoBu1FVWFjiKPvf7XFTXxZWuqdI2KlgJsJrQkl8dKMoNRLe7rtzWzBdM2fvdSeYObv
 qeS6BHuNXYvEGMr93rRg2+d98Vt1JGzEC6Zrw3MJ+/R47P9tf6lBVxjIfK9HQ0v/Io1hjwCPv
 kn5KyrCdHK9Zwf9v+5v1FiLnEI2m/88pfDqOST3b70X+KwplyJxYwrTSuXg8rFx0BwuZZ5X7r
 ggDC4KcMK5/DHw6SE5C28eEAsk0QdQz5yFp6s2dWmgc11g3K4283rj2c/CRzUb7OtQyf71lNU
 Dl4hb7e7Hud0t8zPk6B1IfG5+XAjkgrnt4BvB5fxUPR1eFHpXobegrBpycEYX2gNddqhp/77d
 2KJH25reEWK8Tz2DxFhmikvGOZxn8KZAeQaTnMS4aUXpI0qbLwd5Y9Rncx6pPYvJODD0en94f
 YvOAyEfZWFbLH5ttoLQEOBreKOtH+JEGYxNd/bFCLA==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Am 09.06.23 um 23:59 schrieb Rob Herring:
> On Wed, Jun 07, 2023 at 09:56:02AM +0200, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Sun, Jun 04, 2023 at 02:12:18PM +0200, Stefan Wahren wrote:
>>> Convert the DT binding document for pwm-bcm2835 from .txt to YAML.
>>
>> Both dt_binding_check and dtbs_check (for ARCH=arm) are happy, apart
>> from errors like:
>>
>> arch/arm/boot/dts/bcm2711-rpi-4-b.dtb: pwm@7e20c000: #pwm-cells:0:0: 3 was expected
>>          From schema: Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
>>
>> which is fixed in patch #6. So:
>>
>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> Who will pick up this patch? Is it supposed to go in via pwm or
>> arm/broadcom? (I suggest the latter.)
> 
> The default is the subsystem (pwm). Why not here?

i think Uwe's concern is about the fact, that the series is late in 
cycle. So the chance that the fixing DTS patch 6 miss Linux 6.5 is very 
high.

> 
> Rob
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
