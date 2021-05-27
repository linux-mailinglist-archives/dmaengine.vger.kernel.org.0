Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39242392E2C
	for <lists+dmaengine@lfdr.de>; Thu, 27 May 2021 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhE0Mns (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 May 2021 08:43:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37250 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhE0Mns (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 May 2021 08:43:48 -0400
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3AE72B2C;
        Thu, 27 May 2021 14:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622119333;
        bh=AjWVmr0EYNCkt1EGXFm1RnUI3oKIHEaEt9jfoOrvaz0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S0S7QWdhhWPMex6nG1Hc2b/yiqvHgQPKIiAjfen7pAqeVH7WG6vl8NhQ6hmwK4jh0
         q/uHo80NrFF60EQ43RcWg5HIZOOR7CPObzDzViE1ntKpUE+RwcUuNK4k1QrOzt0ZdB
         IQ0ImDkb2KSL0m9jWyMRjDYtu07ngD38rUEueUM0=
Subject: Re: [PATCH v2 00/18] CSI2RX support on J721E
To:     Pratyush Yadav <p.yadav@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <b5d4105b-f53b-4941-ea2d-77f47540b240@ideasonboard.com>
Date:   Thu, 27 May 2021 15:42:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526152308.16525-1-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

On 26/05/2021 18:22, Pratyush Yadav wrote:
> Hi,
> 
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
> driver, and finally adds the TI CSI2RX wrapper driver.
> 
> Tested on TI's J721E with OV5640 sensor.

I'm having some trouble unloading and reloading the modules:

rmmod ti_cal
rmmod j721e_csi2rx
rmmod cdns_csi2rx
rmmod cdns_dphy
rmmod ov5640
[   37.943128] ------------[ cut here ]------------
[   37.947752] WARNING: CPU: 1 PID: 628 at drivers/media/v4l2-core/v4l2-ctrls-core.c:1807 __v4l2_ctrl_handler_setup+0x15c/0x170
[   37.958963] Modules linked in: ov5640(-) v4l2_fwnode tidss ti_tfp410 tc358767 display_connector cdns_mhdp8546 panel_simple drm_kms_helper drm drm_panel_orientation_quirks cfbfill
rect cfbimgblt cfbcopyarea phy_j721e_wiz phy_cadence_torrent [last unloaded: cdns_dphy]
[   37.982455] CPU: 1 PID: 628 Comm: rmmod Not tainted 5.13.0-rc1-00205-g93acc23badc8 #3
[   37.990271] Hardware name: Texas Instruments K3 J721E SoC (DT)
[   37.996090] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   38.002085] pc : __v4l2_ctrl_handler_setup+0x15c/0x170
[   38.007214] lr : __v4l2_ctrl_handler_setup+0x158/0x170
[   38.012343] sp : ffff80001476fae0
[   38.015648] x29: ffff80001476fae0 x28: ffff000806780000 x27: 0000000000000000
[   38.022781] x26: ffff00080300b448 x25: ffff000804ad4ac0 x24: 0000000000000001
[   38.029912] x23: 0000000000000000 x22: 0000000000000005 x21: ffff000801fa7880
[   38.037043] x20: ffff000801fa7888 x19: ffff000801fa7ba8 x18: 0000000000000000
[   38.044173] x17: 0000000000000000 x16: 0000000000000010 x15: 0000000000000001
[   38.051305] x14: 000000000000003b x13: 00000000aaaaaaab x12: ffff800011a915b8
[   38.058436] x11: 00000000000c001c x10: 000000008260a2b7 x9 : ffff800009362d9c
[   38.065566] x8 : ffff800011887100 x7 : 0000000000000000 x6 : 0000000000000001
[   38.072698] x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800011260000
[   38.079829] x2 : 00000000000000c0 x1 : 00000000000000c0 x0 : 0000000000000000
[   38.086960] Call trace:
[   38.089399]  __v4l2_ctrl_handler_setup+0x15c/0x170
[   38.094181]  ov5640_resume+0x1fc/0x270 [ov5640]
[   38.098709]  __rpm_callback+0x98/0x160
[   38.102452]  rpm_callback+0x2c/0x90
[   38.105934]  rpm_resume+0x45c/0x6f4
[   38.109415]  __pm_runtime_resume+0x54/0xc0
[   38.113503]  __device_release_driver+0x40/0x240
[   38.118025]  driver_detach+0xd0/0x160
[   38.121680]  bus_remove_driver+0x68/0xe0
[   38.125595]  driver_unregister+0x3c/0x6c
[   38.129509]  i2c_del_driver+0x64/0xb0
[   38.133166]  ov5640_i2c_driver_exit+0x1c/0xc948 [ov5640]
[   38.138469]  __arm64_sys_delete_module+0x1b0/0x27c
[   38.143251]  invoke_syscall+0x50/0x120
[   38.146995]  el0_svc_common.constprop.0+0x68/0x104
[   38.151777]  do_el0_svc+0x30/0x9c
[   38.155086]  el0_svc+0x2c/0x54
[   38.158135]  el0_sync_handler+0x1a8/0x1ac
[   38.162136]  el0_sync+0x198/0x1c0
[   38.165444] irq event stamp: 11302
[   38.168837] hardirqs last  enabled at (11301): [<ffff800010bf4e40>] _raw_spin_unlock_irq+0x50/0xa0
[   38.177781] hardirqs last disabled at (11302): [<ffff800010be7a64>] el1_dbg+0x24/0xa0
[   38.185595] softirqs last  enabled at (10378): [<ffff800010010ba0>] __do_softirq+0x500/0x6bc
[   38.194017] softirqs last disabled at (10373): [<ffff80001005d4c4>] __irq_exit_rcu+0x1d4/0x1e0
[   38.202614] ---[ end trace 7037324a951cb149 ]---
rmmod v4l2_fwnode
insmod /root/nfs/work/linux/drivers/media/v4l2-core/v4l2-fwnode.ko
insmod /root/nfs/work/linux/drivers/phy/cadence/cdns-dphy.ko
insmod /root/nfs/work/linux/drivers/media/platform/cadence/cdns-csi2rx.ko
ERROR:   Unhandled External Abort received on 0x80000001 from S-EL1
ERROR:   exception reason=0 syndrome=0xbf000000
Unhandled Exception from EL1
x0             = 0x0000000000000000
x1             = 0xffff000804d59800
x2             = 0xffff8000146c4000
x3             = 0xffff800011260000
x4             = 0x0000000000000001
x5             = 0x0000000000000001
x6             = 0x0000000000000001
x7             = 0x0000000000000000
x8             = 0xffff800011887100
x9             = 0xffff800010bf5190
x10            = 0x000000008260a2b7
x11            = 0x00000000000c821d
x12            = 0xffff800011a915b8
x13            = 0x0000000000000001
x14            = 0x0000000000000000
x15            = 0x0000000000000020
x16            = 0x0000000000000000
x17            = 0x0000000000000000
x18            = 0x00000000fffffffb
x19            = 0xffff000806d44c00
x20            = 0x0000000000000000
x21            = 0xffff800009280058
x22            = 0xffff00080583c810
x23            = 0xffff00080583c800
x24            = 0xffff800009280058
x25            = 0x0000000000000047
x26            = 0xffff8000116d71d8
x27            = 0xffff800009280350
x28            = 0xffff800009280148
x29            = 0xffff80001432f850
x30            = 0xffff8000092506b8
scr_el3        = 0x000000000000073d
sctlr_el3      = 0x0000000030cd183f
cptr_el3       = 0x0000000000000000
tcr_el3        = 0x0000000080803520
daif           = 0x00000000000002c0
mair_el3       = 0x00000000004404ff
spsr_el3       = 0x0000000000000005
elr_el3        = 0xffff80000925043c
ttbr0_el3      = 0x0000000070010b00
esr_el3        = 0x00000000bf000000
far_el3        = 0x0000000000000000
spsr_el1       = 0x0000000060000005
elr_el1        = 0xffff800010be8cb0
spsr_abt       = 0x0000000000000000
spsr_und       = 0x0000000000000000
spsr_irq       = 0x0000000000000000
spsr_fiq       = 0x0000000000000000
sctlr_el1      = 0x0000000034d4d91d
actlr_el1      = 0x0000000000000000
cpacr_el1      = 0x0000000000300000
csselr_el1     = 0x0000000000000000
sp_el1         = 0xffff80001432f850
esr_el1        = 0x0000000056000000
ttbr0_el1      = 0x0000000882773200
ttbr1_el1      = 0x06d8000083180000
mair_el1       = 0x000c0400bb44ffff
amair_el1      = 0x0000000000000000
tcr_el1        = 0x00000034f5d07590
tpidr_el1      = 0xffff80086e790000
tpidr_el0      = 0x0000ffff895c6910
tpidrro_el0    = 0x0000000000000000
par_el1        = 0x0000000000000000
mpidr_el1      = 0x0000000080000001
afsr0_el1      = 0x0000000000000000
afsr1_el1      = 0x0000000000000000
contextidr_el1 = 0x0000000000000000
vbar_el1       = 0xffff800010011000
cntp_ctl_el0   = 0x0000000000000005
cntp_cval_el0  = 0x000000023f77b7a1
cntv_ctl_el0   = 0x0000000000000000
cntv_cval_el0  = 0x0000000000000000
cntkctl_el1    = 0x00000000000000d6
sp_el0         = 0x000000007000abd0
isr_el1        = 0x0000000000000040
dacr32_el2     = 0x0000000000000000
ifsr32_el2     = 0x0000000000000000
cpuectlr_el1   = 0x0000001b00000040
cpumerrsr_el1  = 0x0000000000000000
l2merrsr_el1   = 0x0000000000000000
