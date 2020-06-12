Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CD1F75AF
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2020 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFLJGE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jun 2020 05:06:04 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:43756 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgFLJGE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jun 2020 05:06:04 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 05:06:01 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 6DEDE39D;
        Fri, 12 Jun 2020 16:58:48 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.19] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P25386T140143252899584S1591952327081440_;
        Fri, 12 Jun 2020 16:58:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <88e6e92c3fdead2ba859d612ff7a405a>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: papadakospan@gmail.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 0/13] Patches to improve transfer efficiency for
 Rockchip SoCs.
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, Carlos de Paula <me@carlosedp.com>,
        dmaengine@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>
References: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
 <CAMdYzYr+NF7L3KKzcGano=j9V844Gy8gH03hD++CoPe8Ao1QxQ@mail.gmail.com>
 <CAMdYzYqRTbePLKZ6q39Ao3sgLU0xUvrLmwYTVU3feEb4ob6FuQ@mail.gmail.com>
From:   sugar zhang <sugar.zhang@rock-chips.com>
Message-ID: <2b12edc3-bd89-e103-f6cb-cdd47fcabb49@rock-chips.com>
Date:   Fri, 12 Jun 2020 16:58:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMdYzYqRTbePLKZ6q39Ao3sgLU0xUvrLmwYTVU3feEb4ob6FuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

Thanks for testing! but, as I know, GMAC does not use the general 
dma(pl330) for data transfer,

so, these patchs should not be helpful for your case.

在 2020/6/12 9:15, Peter Geis 写道:
> On Thu, Jun 11, 2020 at 9:06 PM Peter Geis <pgwipeout@gmail.com> wrote:
>> Good Evening,
>>
>> I am currently testing this on the rk3399-rockpro64, and it appears to
>> fully fix the gmac problem without using txpbl.
>> PCIe also seems to be more stable at high load.
>> I need to conduct long term testing, but it seems to be doing very well.
> Belay that, it does make it harder to trigger, but the issue still
> remains on the rk3399.
>
>> Unfortunately it doesn't fix the rk3328 gmac controller.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>
>> On Mon, Jun 8, 2020 at 9:15 PM Sugar Zhang <sugar.zhang@rock-chips.com> wrote:
>>>
>>>
>>> Changes in v2:
>>> - fix FATAL ERROR: Unable to parse input tree
>>>
>>> Sugar Zhang (13):
>>>    dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
>>>    dmaengine: pl330: Add quirk 'arm,pl330-periph-burst'
>>>    dt-bindings: dma: pl330: Document the quirk 'arm,pl330-periph-burst'
>>>    ARM: dts: rk3036: Add 'arm,pl330-periph-burst' for dmac
>>>    ARM: dts: rk322x: Add 'arm,pl330-periph-burst' for dmac
>>>    ARM: dts: rk3288: Add 'arm,pl330-periph-burst' for dmac
>>>    ARM: dts: rk3xxx: Add 'arm,pl330-periph-burst' for dmac
>>>    ARM: dts: rv1108: Add 'arm,pl330-periph-burst' for dmac
>>>    arm64: dts: px30: Add 'arm,pl330-periph-burst' for dmac
>>>    arm64: dts: rk3308: Add 'arm,pl330-periph-burst' for dmac
>>>    arm64: dts: rk3328: Add 'arm,pl330-periph-burst' for dmac
>>>    arm64: dts: rk3368: Add 'arm,pl330-periph-burst' for dmac
>>>    arm64: dts: rk3399: Add 'arm,pl330-periph-burst' for dmac
>>>
>>>   .../devicetree/bindings/dma/arm-pl330.txt          |  1 +
>>>   arch/arm/boot/dts/rk3036.dtsi                      |  1 +
>>>   arch/arm/boot/dts/rk322x.dtsi                      |  1 +
>>>   arch/arm/boot/dts/rk3288.dtsi                      |  3 ++
>>>   arch/arm/boot/dts/rk3xxx.dtsi                      |  3 ++
>>>   arch/arm/boot/dts/rv1108.dtsi                      |  1 +
>>>   arch/arm64/boot/dts/rockchip/px30.dtsi             |  1 +
>>>   arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  2 +
>>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  1 +
>>>   arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  2 +
>>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  2 +
>>>   drivers/dma/pl330.c                                | 44 +++++++++++++++-------
>>>   12 files changed, 49 insertions(+), 13 deletions(-)
>>>
>>> --
>>> 2.7.4
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
-- 
Best Regards!
张学广/Sugar
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd



