Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8E1C2550
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2020 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEBMcy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 May 2020 08:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgEBMcx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 2 May 2020 08:32:53 -0400
Received: from localhost (unknown [117.99.89.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662812495F;
        Sat,  2 May 2020 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588422772;
        bh=CaJB6DBVyGlr/9xAlH4HqYuo52o/ACr5ode7VcyTKvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXixllMtmdY2HFmni4yV9QnTKpN/QdjFc8YBFFPdwu3QXeTPz41oui3x5Za14SI/G
         wjFqi+uF7fjVKA5IBd/B1xW9PA/rD0NrrLsNkYinqE7HQZftDJmjA6e3eUWV8dITpB
         7s50WwTV8A9dh7aHcZDOD5JQPD6EpnhKX/451/fA=
Date:   Sat, 2 May 2020 18:02:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWC?= Hibner <rafal.hibner@secom.com.pl>
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma: zynqmp_dma: Initialize descriptor list after
 freeing during reset
Message-ID: <20200502123242.GB1375924@vkoul-mobl>
References: <20200428143225.3357-1-rafal.hibner@secom.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428143225.3357-1-rafal.hibner@secom.com.pl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Rafał,

On 28-04-20, 16:32, Rafał Hibner wrote:
> List elements are not formally removed from list therefore
> list head is not initialized during zynqmp_dma_reset.
> 
> Signed-off-by: Rafal Hibner <rafal.hibner@secom.com.pl>
> 
> This BUG causes kernel panic when transaction is unsuccessful:
>  ------------[ cut here ]------------
> [   62.710730] list_add corruption. prev->next should be next (ffffffc07d308040), but was dead000000000100. (prev=ffffffc0540b40b8).
> [   62.727960] WARNING: CPU: 0 PID: 1845 at /home/rafalh11/zynq_proj/zynq_platform/KERNEL/linux-xlnx/lib/list_debug.c:28 __list_add_valid+0x74/0xa0
> [   62.746374] Modules linked in: secom_mx_rpmsg(O) rpmsg_char secom_mx_retune(O) ad9680(O) ad5686_spi(O) ad5686(O) ad7298(O) ltc5594(O) lmx2594(O) ad8366(O) secom_mx(O) axi_jesd204_rx(O) axi_adxcvr(O) xilinx_transceiver(O) cf_axi_adc_core(O) hmc7044(O)
> [   62.768546] CPU: 0 PID: 1845 Comm: mx Tainted: G           O      4.19.0 #10
> [   62.775582] Hardware name: xlnx,zynqmp (DT)
> [   62.779750] pstate: 60000005 (nZCv daif -PAN -UAO)
> [   62.784524] pc : __list_add_valid+0x74/0xa0
> [   62.788690] lr : __list_add_valid+0x74/0xa0
> [   62.792855] sp : ffffff8008003da0
> [   62.796154] x29: ffffff8008003da0 x28: 0000000000000020
> [   62.801457] x27: 0000000000000000 x26: dead000000000100
> [   62.806760] x25: ffffffc07d308040 x24: ffffffc0540b40a0
> [   62.812064] x23: ffffffc07d308018 x22: 0000000000000000
> [   62.817359] x21: ffffffc07d308018 x20: ffffffc0540b40b8
> [   62.822654] x19: ffffffc0540b40b8 x18: ffffffffffffffff
> [   62.827957] x17: 0000000000000000 x16: 0000000000000000
> [   62.833252] x15: ffffff8008f88648 x14: 3034303830336437
> [   62.838546] x13: ffffff8008f88670 x12: ffffff80085d0ec0
> [   62.843841] x11: ffffff8008f65018 x10: 0000000000000006
> [   62.849136] x9 : 657270202e6e6f69 x8 : 3462303435306366
> [   62.854431] x7 : 66666666663d7665 x6 : 00000000000001a2
> [   62.859726] x5 : 0000000000000064 x4 : 0000000000000000
> [   62.865020] x3 : 0000000000000000 x2 : ffffffffffffffff
> [   62.870315] x1 : 0cbee765ba0ec900 x0 : 0000000000000000
> [   62.875611] Call trace:
> [   62.878042]  __list_add_valid+0x74/0xa0
> [   62.881864]  zynqmp_dma_free_descriptor+0x48/0x100
> [   62.886644]  zynqmp_dma_chan_desc_cleanup+0xb4/0xf8
> [   62.891505]  zynqmp_dma_do_tasklet+0x68/0x110
> [   62.895847]  tasklet_action_common.isra.3+0x7c/0x168
> [   62.900801]  tasklet_action+0x24/0x30
> [   62.904447]  __do_softirq+0x10c/0x200
> [   62.908092]  irq_exit+0xac/0xc0
> [   62.911219]  __handle_domain_irq+0x60/0xb0
> [   62.915305]  gic_handle_irq+0x64/0xc0
> [   62.918951]  el1_irq+0xb0/0x140
> [   62.922078]  schedule_timeout+0x218/0x3a0
> [   62.926077]  wait_for_common+0x170/0x268
> [   62.929983]  wait_for_completion_timeout+0x10/0x18
> [   62.934761]  ioctl+0x64/0x270 [secom_mx_retune]
> [   62.939281]  do_vfs_ioctl+0xb8/0x900
> [   62.942838]  ksys_ioctl+0x44/0x90
> [   62.946137]  __arm64_sys_ioctl+0x1c/0x28
> [   62.950044]  el0_svc_common+0x60/0xe8
> [   62.953689]  el0_svc_handler+0x6c/0x88
> [   62.957421]  el0_svc+0x8/0xc
> [   62.960284] ---[ end trace 91b4fdfe685446c4 ]---
> [   62.964934] ------------[ cut here ]------------
> 
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 931e41a72..a2b0be07e 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -453,6 +453,7 @@ static void zynqmp_dma_free_desc_list(struct zynqmp_dma_chan *chan,
>  
>  	list_for_each_entry_safe(desc, next, list, node)
>  		zynqmp_dma_free_descriptor(chan, desc);
> +	INIT_LIST_HEAD(list);

Would it not be better to use list_del_init() where we delete it rather
than do the init here?

Thanks
-- 
~Vinod
