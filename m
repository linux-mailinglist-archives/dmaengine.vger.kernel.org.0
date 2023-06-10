Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792E172AAF6
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jun 2023 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFJKxG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Jun 2023 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFJKxF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Jun 2023 06:53:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E135B6;
        Sat, 10 Jun 2023 03:53:00 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9ntb-1qBURf2Fev-005sX6; Sat, 10 Jun 2023 12:52:22 +0200
Message-ID: <b136fa0f-90da-7b9e-0063-5cc5c707c56e@i2se.com>
Date:   Sat, 10 Jun 2023 12:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/10] dmaengine: bcm2835: also support generic
 dma-channel-mask
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        John Stultz <john.stultz@linaro.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-3-stefan.wahren@i2se.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230604121223.9625-3-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q5Jl6qU2SK4Kqc08MDj83Q7VeHPW2oH+F42r9Ja3i8Jt2NqFTEp
 207dBZCODTkNl3CYbpCOvoMMo5OVa1EwJSHHxA+MiyONRLQYPjrTpYtx0koJftZzZqQB9pz
 tpJmtrj3EdJK7v3HwazwkZgQtvOhyfnvyemqm+XO23D9+zasmE4chm0bpq8Dx/7brFgPLct
 eozFezWhXCmaVFGi3YFbg==
UI-OutboundReport: notjunk:1;M01:P0:Mgi3m5CEhpY=;pAB4tqu0X+HRn9qkD6Qk0S6B4yQ
 fVw6KEV+sH/nAvcRIssO9+JmPDoDtpPGWDbP5vQydxeGQEWW7VhLbFp2nU+vOg+KX1QEIAn2j
 ZNp3CQk3NHM9WlFE6jDdRI6xTs/5rqtTnHG9zldrygHabK0G8MJULCsMUK6c0pX9xnh8wNq70
 FnPPLMFC/tLCMMI1ZkNZxA24zgmsSj1erwgG7vtjcJLnTLuzroDX5bMHL2xLrCP2E6q93f3H1
 iGh78sxppBN4wHylBVUed5H38QbVL0+uuTWA9M1pbunVVrtwWTqlPHmkbsephS+OvlTrjYzWs
 VLTObe6TpI5Y8ieg3HtmhVU4qznOD5qOcUoiAvo36GmcovMdp7TM7emm68ZuExYSpY20RFYlX
 tSdLg2/nFP2QIPZpDfOyG7VY7lbprVluI49g2H4XiOSHIbmYNJ/o2vm2GIH2rTph2t015cMih
 gB0ACmCfJ2Itnmup9ZP1kpssLcopE+HPmB1/0cukffAIEA1oi3s4GJ46M+pzrAB59bYme46m3
 YPF8PcCGkAQ4pt4WnVbJB5dimutfVU7SQisSgdCWHBaWi+oMztLGIIwab2Xh8/paUoXuXYb7+
 umLdbOuABJz4oGVrzq+Dh5qUxHRkfybyCjy03NgR5mt0apOSXQMRb2mA+OY8PHlVmh2ZUvVAQ
 a7cFg5LTvrtixx+5+4HhtaSL21r+xztdB8+AqOgucg==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Am 04.06.23 um 14:12 schrieb Stefan Wahren:
> Since commit e2d896c08ca3 ("Documentation: bindings: dma: Add
> binding for dma-channel-mask") there is a generic property to list
> available DMA channels for the kernel to use. The generic property
> has been implemented by some other platforms.
> So implement support for the generic one and consider the
> vendor specific one as deprecated. This also simplifies the YAML
> conversion of the BCM2835 DMA DT bindings a little bit.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

as Rob Herring pointed out that the matching DTS change (patch 4) breaks 
ABI compatibility, i will drop this patch and rework patch 4 in V2 of 
this series. This should make everything smoother ...
