Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5936DCB110
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2019 23:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfJCV0g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Oct 2019 17:26:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59283 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfJCV0f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Oct 2019 17:26:35 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iG8cL-0006f6-S6; Thu, 03 Oct 2019 23:26:34 +0200
Message-ID: <1daf496b14c9682a52e06592471ca37a5abb72e7.camel@pengutronix.de>
Subject: Re: kernel freeze regression relating to imx-sdma
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Kevin Groeneveld <KGroeneveld@lenbrook.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Date:   Thu, 03 Oct 2019 23:26:27 +0200
In-Reply-To: <BF6B9AADDDF11740967545E971C7C0DE6BAAEB86@MAIL1.pickering.lenbrook.com>
References: <BF6B9AADDDF11740967545E971C7C0DE6BAAEB86@MAIL1.pickering.lenbrook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

Am Donnerstag, den 03.10.2019, 21:11 +0000 schrieb Kevin Groeneveld:
> We have recently come across an issue which can cause the linux kernel to freeze on an iMX6 based system.  After bisecting the issue I have found the issue is related to the following imx-sdma commits:
> 
> 64068853bc77786d1a28abb4087d6a3e93aedbe2 dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor allocations
> b8603d2a5795c42f78998e70dc792336e0dc20c9 dmaengine: imx-sdma: implement channel termination via worker
> ebb853b1bd5f659b92c71dc6a9de44cfc37c78c0 Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"
> c06abca69218ac42fa58d1ba7a7b0d9bab5f1b18 Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations"
> 
> If I revert these four commits the freeze does not happen.  The issue is still present up to at least v5.3.
> 
> The problem seems to be related to overruns when doing an SPDIF capture, particularly when there is not actually a valid SPDIF input to the iMX6.  When the issue occurs the following is (usually) printed on the console (using a v5.0 based kernel):
> 
> [ 1251.944877] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [ 1251.950823] rcu:     (detected by 0, t=2102 jiffies, g=220425, q=0)
> [ 1251.956866] rcu: All QSes seen, last rcu_sched kthread activity 2102 (95117-93015), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [ 1251.968266] arecord         S    0  1916   1908 0x00000002
> [ 1251.973816] [<8010dcec>] (unwind_backtrace) from [<8010a4c4>] (show_stack+0x10/0x14)
> [ 1251.981596] [<8010a4c4>] (show_stack) from [<8016b314>] (rcu_check_callbacks+0x57c/0x5d8)
> [ 1251.989806] [<8016b314>] (rcu_check_callbacks) from [<8016fe84>] (update_process_times+0x30/0x5c)
> [ 1251.998709] [<8016fe84>] (update_process_times) from [<8017e960>] (tick_sched_timer+0x44/0x94)
> [ 1252.007353] [<8017e960>] (tick_sched_timer) from [<80170a84>] (__hrtimer_run_queues+0xd8/0x160)
> [ 1252.016081] [<80170a84>] (__hrtimer_run_queues) from [<8017103c>] (hrtimer_interrupt+0xdc/0x284)
> [ 1252.024891] [<8017103c>] (hrtimer_interrupt) from [<8010d6c0>] (twd_handler+0x2c/0x38)
> [ 1252.032839] [<8010d6c0>] (twd_handler) from [<80160b34>] (handle_percpu_devid_irq+0x70/0x11c)
> [ 1252.041401] [<80160b34>] (handle_percpu_devid_irq) from [<8015c234>] (generic_handle_irq+0x18/0x28)
> [ 1252.050480] [<8015c234>] (generic_handle_irq) from [<8015c814>] (__handle_domain_irq+0xa0/0xb4)
> [ 1252.059211] [<8015c814>] (__handle_domain_irq) from [<8039098c>] (gic_handle_irq+0x58/0x90)
> [ 1252.067590] [<8039098c>] (gic_handle_irq) from [<80101a0c>] (__irq_svc+0x6c/0x90)
> [ 1252.075085] Exception stack(0x848afe30 to 0x848afe78)
> [ 1252.080155] fe20:                                     8decf200 00000000 00000000 80b84ac8
> [ 1252.088354] fe40: 00000000 8decf200 892f7800 00001589 892f7800 00000000 00000000 848ae000
> [ 1252.096549] fe60: 8d8cf000 848afe80 805721e8 8056aae4 60000013 ffffffff
> [ 1252.103200] [<80101a0c>] (__irq_svc) from [<8056aae4>] (__snd_pcm_stream_unlock_mode+0xc0/0xd8)
> [ 1252.111925] [<8056aae4>] (__snd_pcm_stream_unlock_mode) from [<00000000>] (  (null))
> [ 1252.119695] rcu: rcu_sched kthread starved for 2102 jiffies! g220425 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> [ 1252.129877] rcu: RCU grace-period kthread stack dump:
> [ 1252.134938] rcu_sched       R  running task        0    10      2 0x00000000
> [ 1252.142034] [<806eee5c>] (__schedule) from [<806eef80>] (schedule+0x90/0xa0)
> [ 1252.149116] [<806eef80>] (schedule) from [<806f2244>] (schedule_timeout+0x1f0/0x238)
> [ 1252.156891] [<806f2244>] (schedule_timeout) from [<8016940c>] (rcu_gp_kthread+0x550/0x8f0)
> [ 1252.165183] [<8016940c>] (rcu_gp_kthread) from [<8013a358>] (kthread+0x110/0x128)
> [ 1252.172693] [<8013a358>] (kthread) from [<801010e8>] (ret_from_fork+0x14/0x2c)
> [ 1252.179925] Exception stack(0x8f877fb0 to 0x8f877ff8)
> [ 1252.184991] 7fa0:                                     00000000 00000000 00000000 00000000
> [ 1252.193187] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [ 1252.201380] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> I suspect the issue may not actually be a bug with imx-sdma but a
> race condition elsewhere that is exposed by the four mentioned
> commits.
> 
> I did notice that when an SPDIF overrun occurs
> dmaengine_terminate_async is called but dmaengine_synchronize is
> not.  Should these calls always be paired? Or is it okay to call
> dmaengine_terminate_async without dmaengine_synchronize in some
> cases?
> 

Yes, it seems this uncovered a bug in the SPDIF driver. Before those
commits the dmaengine_terminate_async in the SDMA driver wasn't really
async, now it is. The API requires that you call dmaengine_synchronize
eventually after the terminate_async before starting any new operations
on the dmaengine. It doesn't necessarily need to be in the same
codepath, but the the async terminate always needs to be paired up with
a synchronize.

Regards,
Lucas

