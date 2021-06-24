Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213353B32B2
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhFXPi0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhFXPi0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Jun 2021 11:38:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66561C061574
        for <dmaengine@vger.kernel.org>; Thu, 24 Jun 2021 08:36:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lwROe-0005zk-Uh; Thu, 24 Jun 2021 17:36:04 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lwROe-0006MU-3W; Thu, 24 Jun 2021 17:36:04 +0200
Date:   Thu, 24 Jun 2021 17:36:04 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     michal.simek@xilinx.com, appanad@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: dmaengine: zynqmp_dma: lockdep warning
Message-ID: <20210624153604.GA24339@pengutronix.de>
References: <20210601130108.GA12967@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601130108.GA12967@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:35:24 up 126 days, 18:59, 125 users,  load average: 0.02, 0.07,
 0.12
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 01 Jun 2021 15:01:08 +0200, Michael Tretter wrote:
> I get a lockdep warning in the zynqmp dma driver and I am not entirely sure
> how to fix it.
> 
> The code in drivers/dma/xilinx/zynqmp_dma.c looks as follows:
> 
> 604 static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
> 605 {
> [...]
> 612	callback = desc->async_tx.callback;
> 613	callback_param = desc->async_tx.callback_param;
> 614	if (callback) {
> 615		spin_unlock(&chan->lock);
> 616		callback(callback_param);
> 617		spin_lock(&chan->lock);
> 618	}
> [...]
> 626 }
> [...]
> 747 static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
> 748 {
> [...]
> 753	spin_lock_irqsave(&chan->lock, irqflags);
> [...]
> 763	while (count) {
> 764		zynqmp_dma_complete_descriptor(chan);
> 765		zynqmp_dma_chan_desc_cleanup(chan);
> 766		count--;
> 767	}
> [...]
> 773	spin_unlock_irqrestore(&chan->lock, irqflags);
> 774 }
> 
> Lockdep reports that in line 617 spin_lock() is called from a non-hardirq
> context, while the same lock is used from a hardirq context. During runtime,
> the sequence is as follows:
> 
> line 753: acquire lock and disable interrupts
> line 615: release lock without enabling interrupts
> line 617: re-acquire lock with still disabled interrupts
> line 773: released lock and re-enable interrupts
> 
> Is this a false positive of lockdep, because it does not know that the irqs
> are still disabled in line 617? Is it actually OK to leave interrupts disabled
> over a spin_unlock() -> spin_lock() sequence or is this a problem?
> 
> Additionally, the lock is held for the entire tasklet that handles the
> finished dma transfer. This is conflict to the rule that spin locks should be
> held only for a short time. Is it necessary to hold the lock that long? I
> understand that the lock is only used to protect the descriptor lists and it
> would be better to only get the lock when descriptors are moved between lists.
> 
> Any guidance would be helpful.

Gentle ping.

Michael
