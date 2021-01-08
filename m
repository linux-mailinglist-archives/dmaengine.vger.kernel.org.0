Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD162EF53C
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jan 2021 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAHP5u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jan 2021 10:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbhAHP5u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jan 2021 10:57:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13AC061381;
        Fri,  8 Jan 2021 07:57:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m25so23897704lfc.11;
        Fri, 08 Jan 2021 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eX2Ejpfa1tT2Xtq7diXrzD9ncCqtZ61jGO18fdH6Mc=;
        b=BH4XJpFbCIaggdol9Xkgu4odxGIdIXexUlBB4/lBiD7JEi+KlYSIAcDiDLEmFHWUf3
         Gp0yd/7TRTOInox4Jx7OnYC1JCbAjcO0Ovxw7eT/c3I0qUs4ZVYEFUkhqUMQ2AHX+FgP
         r4Rr+BPT6EXSCrZLb+ys++8WILY3exIresiXDB+hyXIUfgtjfAjgQaSzfaBG9jaNrUeq
         KbsAfbDzp9TA+lYO0FmhDJDEoGr487zPvkBbjswfbW7e90dAm68rYlq4iQX/qj/QiLch
         dfFHJfh8h6vxCEWkTzaAtJPiqxKfMSXOUqGRqBbUNXRUjk4LivWg4TjaAiRLGyWjxqFW
         gFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eX2Ejpfa1tT2Xtq7diXrzD9ncCqtZ61jGO18fdH6Mc=;
        b=OGh7rUIQ9giB9YLLSyQ35zs5dPvXNSKSg7jJpfpAlkQlnJbZw0veALnC6EQwlO34tV
         toF7KPLhb6VfgSk6ydO8eOhe7L5eAUWayI3WCWzBs+48z7RVTn4tzY4FmPSKp+mnQPHu
         86u5EDZMQRv9qqzIWQ26Fy6i7Adl8EjLPx6kr5Ilfd1WJmSbNHzfTywSK/y9zedo2uxk
         4f4CPIvFXahatGpaNqlO8rHI8JRB8cLO4DNsuEUII9w72h313ZV6jrQ+PvumjgJR/iwZ
         IdcMC2BaVLUlcgZQj2WBNR4VRgtcvXK01W6RLZj6FSbls5zQ8bVaoH+yyMwYeJM5tLnN
         y0FQ==
X-Gm-Message-State: AOAM531EC95OMwjKR8qlAAElwyJ1tDj6AVC0goTPjzjmM5XU8l/SvXho
        MuE/BhozBfk1B0FgEw7zk1kg/ZhnKZkY3vAjiuE=
X-Google-Smtp-Source: ABdhPJyTfxtdXJsKt2oXarUDnGiMoba60XCs8yBC8/KQaA8TJw8RC77iIh9Ytpt8iqQj4JuHtv1omuT/sNlmgCXyuFI=
X-Received: by 2002:a19:4148:: with SMTP id o69mr1763109lfa.610.1610121428177;
 Fri, 08 Jan 2021 07:57:08 -0800 (PST)
MIME-Version: 1.0
References: <CAD56B7dpewwJVttuk4GAcAsx62HP=vPF9jmxTFNG3Z9RP4u9zA@mail.gmail.com>
 <BY5PR02MB652004976C500CD4EA763047C7D20@BY5PR02MB6520.namprd02.prod.outlook.com>
 <BY5PR02MB6520C9083F072E6907534497C7AE0@BY5PR02MB6520.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB6520C9083F072E6907534497C7AE0@BY5PR02MB6520.namprd02.prod.outlook.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Fri, 8 Jan 2021 10:56:57 -0500
Message-ID: <CAD56B7f9D5HnN-rx2QRi4z4HA-bM1=oVpUv6XY35HxBQkAaXmQ@mail.gmail.com>
Subject: Re: dmaengine : xilinx_dma two issues
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Matthew Murrian <matthew.murrian@goctsi.com>,
        Romain Perier <romain.perier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Ferland <ferlandm@amotus.ca>,
        Sebastian von Ohr <vonohr@smaract.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        Shravya Kumbham <shravyak@xilinx.com>, git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

On Fri, Jan 8, 2021 at 2:13 AM Radhey Shyam Pandey <radheys@xilinx.com> wrote:
>
> > -----Original Message-----
> > From: Radhey Shyam Pandey
> > Sent: Monday, January 4, 2021 10:50 AM
> > To: Paul Thomas <pthomas8589@gmail.com>; Dan Williams
> > <dan.j.williams@intel.com>; Vinod Koul <vkoul@kernel.org>; Michal Simek
> > <michals@xilinx.com>; Matthew Murrian <matthew.murrian@goctsi.com>;
> > Romain Perier <romain.perier@gmail.com>; Krzysztof Kozlowski
> > <krzk@kernel.org>; Marc Ferland <ferlandm@amotus.ca>; Sebastian von Ohr
> > <vonohr@smaract.com>; dmaengine@vger.kernel.org; Linux ARM <linux-
> > arm-kernel@lists.infradead.org>; linux-kernel <linux-
> > kernel@vger.kernel.org>; Shravya Kumbham <shravyak@xilinx.com>; git
> > <git@xilinx.com>
> > Subject: RE: dmaengine : xilinx_dma two issues
> >
> > > -----Original Message-----
> > > From: Paul Thomas <pthomas8589@gmail.com>
> > > Sent: Monday, December 28, 2020 10:14 AM
> > > To: Dan Williams <dan.j.williams@intel.com>; Vinod Koul
> > > <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Radhey Shyam
> > > Pandey <radheys@xilinx.com>; Matthew Murrian
> > > <matthew.murrian@goctsi.com>; Romain Perier
> > <romain.perier@gmail.com>;
> > > Krzysztof Kozlowski <krzk@kernel.org>; Marc Ferland
> > > <ferlandm@amotus.ca>; Sebastian von Ohr <vonohr@smaract.com>;
> > > dmaengine@vger.kernel.org; Linux ARM <linux-
> > > arm-kernel@lists.infradead.org>; linux-kernel <linux-
> > > kernel@vger.kernel.org>
> > > Subject: dmaengine : xilinx_dma two issues
> > >
> > > Hello,
> > >
> > > I'm trying to get the 5.10 kernel up and running for our system, and
> > > I'm running into a couple of issues with xilinx_dma.
> > + (Xilinx mailing list)
> >
> > Thanks for bringing the issues to our notice. Replies inline.
> >
> > >
> > > First, commit 14ccf0aab46e 'dmaengine: xilinx_dma: In dma channel
> > > probe fix node order dependency' breaks our usage. Before this commit a
> > call to:
> > > dma_request_chan(&indio_dev->dev, "axi_dma_0"); returns fine, but
> > > after that commit it returns -19. The reason for this seems to be that
> > > the only channel that is setup is channel 1 (chan->id is 1 in
> > xilinx_dma_chan_probe()).
> > > However in
> > > of_dma_xilinx_xlate() chan_id is gets set to 0 (int chan_id =
> > > dma_spec-
> > > >args[0];), which causes the:
> > > !xdev->chan[chan_id]
> > > test to fail in of_dma_xilinx_xlate()
> >
> > What is the channel number passed in
> > dmaclient DT?
Is this a question for me?

>
> Any update on this issue?

>
> >
> > dmas = <& axi_dma_0 1>
> > dma-names = "axi_dma_0"
> >
> > >
> > > Our device-tree entry looks like this:
> > >     axi_dma_0: dma@80002000 {
> > >         status = "okay";
> > >         #dma-cells = <1>;
> > >         compatible = "xlnx,axi-dma-1.00.a";
> > >         interrupt-parent = <&gic>;
> > >         interrupts = <0 89 4>;
> > >         reg = <0x0 0x80002000 0x0 0x1000>;
> > >         xlnx,addrwidth = <0x20>;
> > >         clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk LPD_LSBUS>,
> > > <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk LPD_LSBUS>;
> > >         clock-names = "s_axi_lite_aclk", "m_axi_sg_aclk",
> > > "m_axi_mm2s_aclk", "m_axi_s2mm_aclk";
> > >         dma-channel@80002030 {
> > >             compatible = "xlnx,axi-dma-s2mm-channel";
> > >             dma-channels = <0x1>;
> > >             interrupts = <0 89 4>;
> > >             xlnx,datawidth = <0x20>;
> > >             xlnx,device-id = <0x0>;
> > >         };
> > >     };
> > >
> > > This is on a 5.10.1 kernel on arm64 zynqmp hardware.
> > >
> > > The second issue goes a little further back to commit e81274cd6b526
> > > 'dmaengine: add support to dynamic register/unregister of channels'.
> > > After this commit even just removing the module 'rmmod xilinx_dma',
> > > without ever using it, results in a kernel oops like this:
> > > [   37.214568] xilinx-vdma 80002000.dma: ch 0: SG disabled
> > > [   37.219807] xilinx-vdma 80002000.dma: WARN: Device release is not
> > > defined so it is not safe to unbind this driver while in use
> > > [   37.231299] xilinx-vdma 80002000.dma: Xilinx AXI DMA Engine Driver
> > > Probed!!
> > > [   42.100660] Unable to handle kernel paging request at virtual
> > > address dead000000000108
> > > [   42.108598] Mem abort info:
> > > [   42.111393]   ESR = 0x96000044
> > > [   42.114443]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [   42.119744]   SET = 0, FnV = 0
> > > [   42.122794]   EA = 0, S1PTW = 0
> > > [   42.125918] Data abort info:
> > > [   42.128789]   ISV = 0, ISS = 0x00000044
> > > [   42.132617]   CM = 0, WnR = 1
> > > [   42.135577] [dead000000000108] address between user and kernel
> > > address ranges
> > > [   42.142705] Internal error: Oops: 96000044 [#1] SMP
> > > [   42.147566] Modules linked in: xilinx_dma(-) clk_xlnx_clock_wizard
> > > uio_pdrv_genirq
> > > [   42.155139] CPU: 1 PID: 2075 Comm: rmmod Not tainted
> > > 5.10.1-00026-g3a2e6dd7a05-dirty #192
> > > [   42.163302] Hardware name: Enclustra XU5 SOM (DT)
> > > [   42.167992] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> > > [   42.173996] pc : xilinx_dma_chan_remove+0x74/0xa0 [xilinx_dma]
> > > [   42.179815] lr : xilinx_dma_chan_remove+0x70/0xa0 [xilinx_dma]
> > > [   42.185636] sp : ffffffc01112bca0
> > > [   42.188935] x29: ffffffc01112bca0 x28: ffffff80402ea640
> > > [   42.194238] x27: 0000000000000000 x26: 0000000000000000
> > > [   42.199542] x25: 0000000000000000 x24: 0000000000000000
> > > [   42.204845] x23: 0000000000000000 x22: 0000000000000000
> > > [   42.210149] x21: ffffffc0088a2028 x20: ffffff8040c08410
> > > [   42.215452] x19: ffffff80423fa480 x18: ffffffffffffffff
> > > [   42.220756] x17: 0000000000000000 x16: 0000000000000000
> > > [   42.226059] x15: ffffffc010ce88c8 x14: 0000000000000040
> > > [   42.231363] x13: ffffff0000000000 x12: ffffffffffffffff
> > > [   42.236667] x11: 0000000000000028 x10: ffffffff7fffffff
> > > [   42.241970] x9 : ffffffff00f0dfe0 x8 : 0000000000000000
> > > [   42.247273] x7 : ffffffc010da4000 x6 : 0000000000000000
> > > [   42.252577] x5 : 0000000000210d00 x4 : ffffffc010da4da0
> > > [   42.257881] x3 : ffffff80423fa578 x2 : 0000000000000000
> > > [   42.263184] x1 : dead000000000100 x0 : dead000000000122
> > > [   42.268488] Call trace:
> > > [   42.270923]  xilinx_dma_chan_remove+0x74/0xa0 [xilinx_dma]
> > > [   42.276399]  xilinx_dma_remove+0x3c/0x70 [xilinx_dma]
> > > [   42.281446]  platform_drv_remove+0x24/0x38
> > > [   42.285530]  device_release_driver_internal+0xec/0x1a8
> > > [   42.290659]  driver_detach+0x64/0xd8
> > > [   42.294226]  bus_remove_driver+0x58/0xb8
> > > [   42.298133]  driver_unregister+0x30/0x60
> > > [   42.302048]  platform_driver_unregister+0x14/0x20
> > > [   42.306744]  xilinx_vdma_driver_exit+0x18/0x978 [xilinx_dma]
> > > [   42.312396]  __arm64_sys_delete_module+0x1e4/0x270
> > > [   42.317178]  el0_svc_common.constprop.4+0x68/0x170
> > > [   42.321959]  do_el0_svc+0x70/0x90
> > > [   42.325267]  el0_svc+0x14/0x20
> > > [   42.328313]  el0_sync_handler+0x90/0xb8
> > > [   42.332141]  el0_sync+0x158/0x180
> > > [   42.335442] Code: 95dfce29 9103c260 95de7ffb a9490261 (f9000420)
> > > [   42.341525] ---[ end trace dbd90aeb5ca71943 ]---
> > >
> > > So if I use the 04c2bc2bede1 (commit before 14ccf0aab46e) version of
> > > xilinx_dma.c and never remove the module then it is working with the
> > > 5.10.1 kernel.
> >
> > Ok, we will analyze this issue and report back the findings.
>
> + Dave
>
> I was able to reproduce this crash on the unloading xilinx_dma module.
> This is introduced due to the e81274cd6b526 mainline commit added
> in the 5.6 kernel version. The crash is coming from -
>
> xilinx_dma_chan_remove+0x74/0xa0:
> __list_del at ./include/linux/list.h:112
> (inlined by) __list_del_entry at./include/linux/list.h:135
> (inlined by) list_del at ./include/linux/list.h:146
> (inlined by) xilinx_dma_chan_remove at drivers/dma/xilinx/xilinx_dma.c:2546
>
> Looking into e81274cd6b526 commit - It deletes channel device_node entry.
> Same channel device_node entry is also deleted in  xilinx_dma_chan_remove
> as a result we see this crash.
>
> @@ -993,12 +1007,22 @@ static
> void __dma_async_device_channel_unregister(struct dma_device *device,
>                   "%s called while %d clients hold a reference\n",
>                   __func__, chan->client_count);
>         mutex_lock(&dma_list_mutex);
> +       list_del(&chan->device_node);
> +       device->chancnt--;
>
> I will let Dave comment on the background of this change.  In
> dmaengine driver - we are adding channel device node entry
> so deleting it in the exit path looks fine to me. Also, I checked
> other dma drivers are also deleting channel device_node entry
> in .remove so it likely a common problem.
>
> >
> > >
> > > Hopefully, this will be clear to someone how these issues can be
> > > resolved. In general we've been very happy using the xilinx dma.
> > >
> > > I'm not subscribed to the linux-kernel ML so if you need any further
> > > info or testing just keep me in the to: list.
> > >
> > > thanks,
> > > Paul

Thanks for looking at this! Let me know if anyone needs more info.

-Paul
