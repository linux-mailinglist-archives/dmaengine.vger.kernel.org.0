Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127371227F8
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 10:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfLQJx6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 04:53:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57748 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfLQJx6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 04:53:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBH9rMam036474;
        Tue, 17 Dec 2019 03:53:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576576402;
        bh=sjC9P+5EGLfEaiANywJJax5JS2fNv1hugy8emXNG8es=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x3rJkdm+BWQfvIbzJ1oVnL+WizxYrcddeo8dddy3pHYLbip8uDL+Qe6mOoFryyQlv
         oihaMycMv9T6MEr0528rlcSAqsA7Gdzkh3DxqqEAVgbV3iu5yodw6d3HQ/SVlIE5D7
         rYbqsjj0WX5gYj9PwV9DGL4l8zuTJlmaUyCClj0k=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBH9rMIa009450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 03:53:22 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 03:53:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 03:53:21 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBH9rJn7073216;
        Tue, 17 Dec 2019 03:53:19 -0600
Subject: Re: [PATCH 00/14] Remove legacy sdma code for dt booting omaps
To:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
CC:     Vinod Koul <vinod.koul@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>
References: <20191217001925.44558-1-tony@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a62d8087-afad-fd04-bfe2-79ce6ea08ffe@ti.com>
Date:   Tue, 17 Dec 2019 11:53:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tony,

On 17/12/2019 2.19, Tony Lindgren wrote:
> Hi all,
> 
> This series finally removes the legacy sdma code for omaps booting with
> devicetree. The legacy sdma code is still left for omap1, but makes
> further work a bit easier.
> 
> We do the removal of legacy sdma code with the following steps:
> 
> - Prepare for platform data removal by probing sdma with device tree
>   data for the interconnect target module
> 
> - Drop unused code and legacy interrupt code for omap2 and later
> 
> - Update dmaengine driver to use device tree match data and add
>   missing features
> 
> - Allocate logical channels directly in the dmaengine driver
> 
> - Drop legacy platform init and data

Thanks for doing this!
First things first:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

But I was only able to test it with CPU_IDLE=n otherwise (even w/o this series)
I got a flood of (PandaBoard-ES):

[  315.995819] ------------[ cut here ]------------
[  316.000457] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:141 l3_interrupt_handler+0x264/0x384
[  316.009613] 44000000.ocp:L3 Standard Error: MASTER USBHOSTHS TARGET ABE (Read Link): At Address: 0x00000000 : Data Access in User mode during Functional access
[  316.023925] Modules linked in:
[  316.027008] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.5.0-rc1-00016-g239582d9ad0c #1078
[  316.036590] Hardware name: Generic OMAP4 (Flattened Device Tree)
[  316.042633] [<c01105ac>] (unwind_backtrace) from [<c010b81c>] (show_stack+0x10/0x14)
[  316.050415] [<c010b81c>] (show_stack) from [<c092dbf4>] (dump_stack+0xc0/0xdc)
[  316.057678] [<c092dbf4>] (dump_stack) from [<c01366b0>] (__warn+0xa8/0xd4)
[  316.064575] [<c01366b0>] (__warn) from [<c0136770>] (warn_slowpath_fmt+0x94/0xbc)
[  316.072204] [<c0136770>] (warn_slowpath_fmt) from [<c04b27c4>] (l3_interrupt_handler+0x264/0x384)
[  316.081176] [<c04b27c4>] (l3_interrupt_handler) from [<c018b420>] (__handle_irq_event_percpu+0x3c/0x128)
[  316.090698] [<c018b420>] (__handle_irq_event_percpu) from [<c018b53c>] (handle_irq_event_percpu+0x30/0x84)
[  316.100433] [<c018b53c>] (handle_irq_event_percpu) from [<c018b5c8>] (handle_irq_event+0x38/0x5c)
[  316.109344] [<c018b5c8>] (handle_irq_event) from [<c018fdec>] (handle_fasteoi_irq+0xc8/0x180)
[  316.117889] [<c018fdec>] (handle_fasteoi_irq) from [<c018a674>] (generic_handle_irq+0x20/0x34)
[  316.127197] [<c018a674>] (generic_handle_irq) from [<c018ac44>] (__handle_domain_irq+0x64/0xdc)
[  316.135955] [<c018ac44>] (__handle_domain_irq) from [<c04b0c44>] (gic_handle_irq+0x40/0x84)
[  316.144317] [<c04b0c44>] (gic_handle_irq) from [<c0101aac>] (__irq_svc+0x6c/0xa8)
[  316.151855] Exception stack(0xc0f01e10 to 0xc0f01e58)
[  316.157348] 1e00:                                     ffffabcf 2e645000 00000000 c0e64040
[  316.166107] 1e20: 00000082 c0e63ffc c0f052c0 c0f00000 00000001 ee80c000 c0f052c0 c0fa19c4
[  316.174316] 1e40: 00000000 c0f01e60 c013bc44 c0102278 60000153 ffffffff
[  316.181121] [<c0101aac>] (__irq_svc) from [<c0102278>] (__do_softirq+0x78/0x280)
[  316.188568] [<c0102278>] (__do_softirq) from [<c013bc44>] (irq_exit+0xa8/0xec)
[  316.195831] [<c013bc44>] (irq_exit) from [<c018ac4c>] (__handle_domain_irq+0x6c/0xdc)
[  316.203674] [<c018ac4c>] (__handle_domain_irq) from [<c04b0c44>] (gic_handle_irq+0x40/0x84)
[  316.213134] [<c04b0c44>] (gic_handle_irq) from [<c0101aac>] (__irq_svc+0x6c/0xa8)
[  316.221130] Exception stack(0xc0f01ee8 to 0xc0f01f30)
[  316.226196] 1ee0:                   00000000 00000000 00010001 ffffffff eef01580 00000002
[  316.234405] 1f00: ef4a8678 c0f0b750 c0f05124 eef0158c c0f05244 c0fa19c4 00000010 c0f01f38
[  316.242645] 1f20: ef4a86e8 c0773734 60000153 ffffffff
[  316.247711] [<c0101aac>] (__irq_svc) from [<c0773734>] (cpuidle_enter_state_coupled+0x2e4/0x428)
[  316.256530] [<c0773734>] (cpuidle_enter_state_coupled) from [<c0770be8>] (cpuidle_enter+0x44/0x5c)
[  316.265533] [<c0770be8>] (cpuidle_enter) from [<c0163818>] (do_idle+0x1d8/0x2a4)
[  316.272949] [<c0163818>] (do_idle) from [<c0163bc0>] (cpu_startup_entry+0x18/0x20)
[  316.280578] [<c0163bc0>] (cpu_startup_entry) from [<c0e00d04>] (start_kernel+0x3d0/0x46c)
[  316.288787] ---[ end trace be4a25d25ab32771 ]---

- Péter

> The patches are against v5.5-rc1, and need the following fixes:
> 
> 2c81f0f6d3f5 ("bus: ti-sysc: Fix iterating over clocks")
> e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
> 93c60483b5fe ("bus: ti-sysc: Fix missing force mstandby quirk handling")
> 90bdfa0b05e3 ("ARM: OMAP2+: Fix ti_sysc_find_one_clockdomain to check for to_clk_hw_omap")
> 
> To make testing easier, I've also pushed out a testing branch at [0][1].
> 
> Regards,
> 
> Tony
> 
> 
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v5.6/sdma-testing
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v5.6/sdma-testing
> 
> 
> Tony Lindgren (14):
>   ARM: dts: Add generic compatible for omap sdma instances
>   ARM: dts: Configure interconnect target module for omap2 sdma
>   ARM: dts: Configure interconnect target module for omap3 sdma
>   ARM: OMAP2+: Drop unused sdma functions
>   ARM: OMAP2+: Drop sdma interrupt handling for mach-omap2
>   ARM: OMAP2+: Configure sdma capabilities directly
>   ARM: OMAP2+: Configure dma_plat_info directly and drop dma_dev_attr
>   dmaengine: ti: omap-dma: Add device tree match data and use it for
>     cpu_pm
>   dmaengine: ti: omap-dma: Configure global priority register directly
>   dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it
>   dmaengine: ti: omap-dma: Allocate channels directly
>   dmaengine: ti: omap-dma: Use cpu notifier to block idle for omap2
>   ARM: OMAP2+: Drop legacy init for sdma
>   ARM: OMAP2+: Drop legacy platform data for sdma
> 
>  arch/arm/boot/dts/dra7-l4.dtsi                |   3 +-
>  arch/arm/boot/dts/omap2.dtsi                  |  43 +-
>  arch/arm/boot/dts/omap2430.dtsi               |   4 +
>  arch/arm/boot/dts/omap3-n900.dts              |   5 +
>  arch/arm/boot/dts/omap3.dtsi                  |  46 +-
>  arch/arm/boot/dts/omap36xx.dtsi               |   4 +
>  arch/arm/boot/dts/omap4-l4.dtsi               |   3 +-
>  arch/arm/boot/dts/omap5-l4.dtsi               |   3 +-
>  arch/arm/mach-omap2/common.h                  |   3 +
>  arch/arm/mach-omap2/dma.c                     | 119 +----
>  arch/arm/mach-omap2/omap_device.c             | 170 -------
>  arch/arm/mach-omap2/omap_device.h             |   4 -
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  34 --
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c    |  34 --
>  .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  18 -
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  61 ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  69 ---
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |  61 ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c     |  61 ---
>  arch/arm/mach-omap2/omap_hwmod_common_data.h  |   1 -
>  arch/arm/mach-omap2/pdata-quirks.c            |   1 +
>  arch/arm/mach-omap2/pm24xx.c                  |  22 +-
>  arch/arm/mach-omap2/pm34xx.c                  |   5 -
>  arch/arm/plat-omap/dma.c                      | 471 +-----------------
>  drivers/dma/ti/omap-dma.c                     | 288 ++++++++++-
>  include/linux/omap-dma.h                      |  18 -
>  26 files changed, 391 insertions(+), 1160 deletions(-)
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
