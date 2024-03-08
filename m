Return-Path: <dmaengine+bounces-1320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C059876C1F
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 22:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D649628359D
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 21:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830D5F879;
	Fri,  8 Mar 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pj/741Cl"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D35E090
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931645; cv=none; b=WopVmp2izItxAFtVkocKe4tBPq5OR5w7Ae6ejFNhSGvOdRfPygQ2CIDQ8FrOPHbEK//mV72dIqSB6cyDxupIdVzDCw6zaJzKF31Ll18mVZw66f45Js/Qb3i587ktVi/VmldjY8bLd6vnltj07d93+w0bmHhZnESdQv6ynos8VhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931645; c=relaxed/simple;
	bh=5n3P80TuFK9h7hETWb35pmZ2YfC0orEb85UANrYscwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlEn1vIIuZuC9HYMLxTLg5drDdC67QSZ32PHfkXmz54KMvSn8V8xcNsuijliRwto84IFnz0JpEy/PF6TkMGyzuRRNXXE2Uo75sKJnTjm7LeIWE5p+lJoJ//B+mhpt/dNgjHrt8PtbCgwn/hrD4rTfUN92yFBNzTPxZpyS1752vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pj/741Cl; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709931641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZZlTtmAYhSYsdD4AVhRHcVqqgxhut5qRVX6YFKjyog=;
	b=Pj/741ClmbkHAA/5Oz1i/mchI2TGZrw1Td4707+0+Zsp1iI71JeFqLks53iPOjJ8EmYKVw
	DlEsCU2OcyxeHjH/gGRef5x4osZLDP77JFi1g3IkeijG3vWzKgynDPuXx8gMk+tJ4m0Ifa
	IB2YKrZ8SP6TXEcjqygxl3Io9LdNx7s=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Hyun Kwon <hyun.kwon@xilinx.com>,
	Tejas Upadhyay <tejasu@xilinx.com>
Subject: [PATCH 1/3] dma: xilinx_dpdma: Fix locking
Date: Fri,  8 Mar 2024 16:00:32 -0500
Message-Id: <20240308210034.3634938-2-sean.anderson@linux.dev>
In-Reply-To: <20240308210034.3634938-1-sean.anderson@linux.dev>
References: <20240308210034.3634938-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are several places where either chan->lock or chan->vchan.lock was
not held. Add appropriate locking. This fixes lockdep warnings like

[   31.077578] ------------[ cut here ]------------
[   31.077831] WARNING: CPU: 2 PID: 40 at drivers/dma/xilinx/xilinx_dpdma.c:834 xilinx_dpdma_chan_queue_transfer+0x274/0x5e0
[   31.077953] Modules linked in:
[   31.078019] CPU: 2 PID: 40 Comm: kworker/u12:1 Not tainted 6.6.20+ #98
[   31.078102] Hardware name: xlnx,zynqmp (DT)
[   31.078169] Workqueue: events_unbound deferred_probe_work_func
[   31.078272] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.078377] pc : xilinx_dpdma_chan_queue_transfer+0x274/0x5e0
[   31.078473] lr : xilinx_dpdma_chan_queue_transfer+0x270/0x5e0
[   31.078550] sp : ffffffc083bb2e10
[   31.078590] x29: ffffffc083bb2e10 x28: 0000000000000000 x27: ffffff880165a168
[   31.078754] x26: ffffff880164e920 x25: ffffff880164eab8 x24: ffffff880164d480
[   31.078920] x23: ffffff880165a148 x22: ffffff880164e988 x21: 0000000000000000
[   31.079132] x20: ffffffc082aa3000 x19: ffffff880164e880 x18: 0000000000000000
[   31.079295] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   31.079453] x14: 0000000000000000 x13: ffffff8802263dc0 x12: 0000000000000001
[   31.079613] x11: 0001ffc083bb2e34 x10: 0001ff880164e98f x9 : 0001ffc082aa3def
[   31.079824] x8 : 0001ffc082aa3dec x7 : 0000000000000000 x6 : 0000000000000516
[   31.079982] x5 : ffffffc7f8d43000 x4 : ffffff88003c9c40 x3 : ffffffffffffffff
[   31.080147] x2 : ffffffc7f8d43000 x1 : 00000000000000c0 x0 : 0000000000000000
[   31.080307] Call trace:
[   31.080340]  xilinx_dpdma_chan_queue_transfer+0x274/0x5e0
[   31.080518]  xilinx_dpdma_issue_pending+0x11c/0x120
[   31.080595]  zynqmp_disp_layer_update+0x180/0x3ac
[   31.080712]  zynqmp_dpsub_plane_atomic_update+0x11c/0x21c
[   31.080825]  drm_atomic_helper_commit_planes+0x20c/0x684
[   31.080951]  drm_atomic_helper_commit_tail+0x5c/0xb0
[   31.081139]  commit_tail+0x234/0x294
[   31.081246]  drm_atomic_helper_commit+0x1f8/0x210
[   31.081363]  drm_atomic_commit+0x100/0x140
[   31.081477]  drm_client_modeset_commit_atomic+0x318/0x384
[   31.081634]  drm_client_modeset_commit_locked+0x8c/0x24c
[   31.081725]  drm_client_modeset_commit+0x34/0x5c
[   31.081812]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x104/0x168
[   31.081899]  drm_fb_helper_set_par+0x50/0x70
[   31.081971]  fbcon_init+0x538/0xc48
[   31.082047]  visual_init+0x16c/0x23c
[   31.082207]  do_bind_con_driver.isra.0+0x2d0/0x634
[   31.082320]  do_take_over_console+0x24c/0x33c
[   31.082429]  do_fbcon_takeover+0xbc/0x1b0
[   31.082503]  fbcon_fb_registered+0x2d0/0x34c
[   31.082663]  register_framebuffer+0x27c/0x38c
[   31.082767]  __drm_fb_helper_initial_config_and_unlock+0x5c0/0x91c
[   31.082939]  drm_fb_helper_initial_config+0x50/0x74
[   31.083012]  drm_fbdev_dma_client_hotplug+0xb8/0x108
[   31.083115]  drm_client_register+0xa0/0xf4
[   31.083195]  drm_fbdev_dma_setup+0xb0/0x1cc
[   31.083293]  zynqmp_dpsub_drm_init+0x45c/0x4e0
[   31.083431]  zynqmp_dpsub_probe+0x444/0x5e0
[   31.083616]  platform_probe+0x8c/0x13c
[   31.083713]  really_probe+0x258/0x59c
[   31.083793]  __driver_probe_device+0xc4/0x224
[   31.083878]  driver_probe_device+0x70/0x1c0
[   31.083961]  __device_attach_driver+0x108/0x1e0
[   31.084052]  bus_for_each_drv+0x9c/0x100
[   31.084125]  __device_attach+0x100/0x298
[   31.084207]  device_initial_probe+0x14/0x20
[   31.084292]  bus_probe_device+0xd8/0xdc
[   31.084368]  deferred_probe_work_func+0x11c/0x180
[   31.084451]  process_one_work+0x3ac/0x988
[   31.084643]  worker_thread+0x398/0x694
[   31.084752]  kthread+0x1bc/0x1c0
[   31.084848]  ret_from_fork+0x10/0x20
[   31.084932] irq event stamp: 64549
[   31.084970] hardirqs last  enabled at (64548): [<ffffffc081adf35c>] _raw_spin_unlock_irqrestore+0x80/0x90
[   31.085157] hardirqs last disabled at (64549): [<ffffffc081adf010>] _raw_spin_lock_irqsave+0xc0/0xdc
[   31.085277] softirqs last  enabled at (64503): [<ffffffc08001071c>] __do_softirq+0x47c/0x500
[   31.085390] softirqs last disabled at (64498): [<ffffffc080017134>] ____do_softirq+0x10/0x1c
[   31.085501] ---[ end trace 0000000000000000 ]---

Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/dma/xilinx/xilinx_dpdma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index b82815e64d24..eb0637d90342 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -214,7 +214,8 @@ struct xilinx_dpdma_tx_desc {
  * @running: true if the channel is running
  * @first_frame: flag for the first frame of stream
  * @video_group: flag if multi-channel operation is needed for video channels
- * @lock: lock to access struct xilinx_dpdma_chan
+ * @lock: lock to access struct xilinx_dpdma_chan. Must be taken before
+ *        @vchan.lock, if both are to be held.
  * @desc_pool: descriptor allocation pool
  * @err_task: error IRQ bottom half handler
  * @desc: References to descriptors being processed
@@ -1097,12 +1098,14 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
 	 * Complete the active descriptor, if any, promote the pending
 	 * descriptor to active, and queue the next transfer, if any.
 	 */
+	spin_lock(&chan->vchan.lock);
 	if (chan->desc.active)
 		vchan_cookie_complete(&chan->desc.active->vdesc);
 	chan->desc.active = pending;
 	chan->desc.pending = NULL;
 
 	xilinx_dpdma_chan_queue_transfer(chan);
+	spin_unlock(&chan->vchan.lock);
 
 out:
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -1264,10 +1267,12 @@ static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
 	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chan->vchan.lock, flags);
+	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->vchan.lock);
 	if (vchan_issue_pending(&chan->vchan))
 		xilinx_dpdma_chan_queue_transfer(chan);
-	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+	spin_unlock(&chan->vchan.lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 static int xilinx_dpdma_config(struct dma_chan *dchan,
@@ -1495,7 +1500,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
 		    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
 
 	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->vchan.lock);
 	xilinx_dpdma_chan_queue_transfer(chan);
+	spin_unlock(&chan->vchan.lock);
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
-- 
2.35.1.1320.gc452695387.dirty


