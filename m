Return-Path: <dmaengine+bounces-1558-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF788DCF7
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 12:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1813F1F2B129
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C512D216;
	Wed, 27 Mar 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NP2gKqRX"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6212D1E5;
	Wed, 27 Mar 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540633; cv=none; b=RWXIojbTgNMHfXjc0KU+1islxR56CxJtCH/7HkIJNOf/Ztu8agqbbem+QUIv90JhOmEIU5aAzO++yw4Si95yVtqmsC5buKprl9V96U+WamDkQdaQY50azo8yzNSaecENeX2JTFvUj5ZrBCYZGrhC+vahqi+pnH4elU3W65vYQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540633; c=relaxed/simple;
	bh=0Cg7icEUPvZou+c3LtWiGR7vV8Zd1VFUFsk5mO9Ryyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD5a9jAWm0+4ywLmFhPhp6V0tRkq1rb3VoC0VFFU+cXHDVn1rK3sS+2gU3m3eJ9ZtKCjkkNzcSsCd1oOYOlF7HC0IWeLWNvEVCu80Kj6qW9EHCXDPSO7s+XVhjl3SFVeifhcEfAxikM+lA5T5MNSqWZScCwCFgKCKMt9iBUZSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NP2gKqRX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5D37675;
	Wed, 27 Mar 2024 12:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711540596;
	bh=0Cg7icEUPvZou+c3LtWiGR7vV8Zd1VFUFsk5mO9Ryyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NP2gKqRX1+V3gYMJhc5WlETdl+PXWLE5qBIqSXOwBOPh9bArRX7e0JOxIOSujAJSy
	 RS5Oa6pIMoE7xWjD1Y/ewhGZr9YW/7B8g7E99LgTLEkIbDmKOzCR9slj9Q7CDGXxO6
	 AwCV8+gb2AjCdVCKQyymLeHVvPUwtRAaxWoCv26c=
Message-ID: <20ff3d36-d0fc-4970-bc31-c267d656eb2c@ideasonboard.com>
Date: Wed, 27 Mar 2024 13:57:04 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma: xilinx_dpdma: Fix locking
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Hyun Kwon <hyun.kwon@xilinx.com>,
 Tejas Upadhyay <tejasu@xilinx.com>
References: <20240308210034.3634938-1-sean.anderson@linux.dev>
 <20240308210034.3634938-2-sean.anderson@linux.dev>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240308210034.3634938-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 23:00, Sean Anderson wrote:
> There are several places where either chan->lock or chan->vchan.lock was
> not held. Add appropriate locking. This fixes lockdep warnings like
>

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> [   31.077578] ------------[ cut here ]------------
> [   31.077831] WARNING: CPU: 2 PID: 40 at drivers/dma/xilinx/xilinx_dpdma.c:834 xilinx_dpdma_chan_queue_transfer+0x274/0x5e0
> [   31.077953] Modules linked in:
> [   31.078019] CPU: 2 PID: 40 Comm: kworker/u12:1 Not tainted 6.6.20+ #98
> [   31.078102] Hardware name: xlnx,zynqmp (DT)
> [   31.078169] Workqueue: events_unbound deferred_probe_work_func
> [   31.078272] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   31.078377] pc : xilinx_dpdma_chan_queue_transfer+0x274/0x5e0
> [   31.078473] lr : xilinx_dpdma_chan_queue_transfer+0x270/0x5e0
> [   31.078550] sp : ffffffc083bb2e10
> [   31.078590] x29: ffffffc083bb2e10 x28: 0000000000000000 x27: ffffff880165a168
> [   31.078754] x26: ffffff880164e920 x25: ffffff880164eab8 x24: ffffff880164d480
> [   31.078920] x23: ffffff880165a148 x22: ffffff880164e988 x21: 0000000000000000
> [   31.079132] x20: ffffffc082aa3000 x19: ffffff880164e880 x18: 0000000000000000
> [   31.079295] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   31.079453] x14: 0000000000000000 x13: ffffff8802263dc0 x12: 0000000000000001
> [   31.079613] x11: 0001ffc083bb2e34 x10: 0001ff880164e98f x9 : 0001ffc082aa3def
> [   31.079824] x8 : 0001ffc082aa3dec x7 : 0000000000000000 x6 : 0000000000000516
> [   31.079982] x5 : ffffffc7f8d43000 x4 : ffffff88003c9c40 x3 : ffffffffffffffff
> [   31.080147] x2 : ffffffc7f8d43000 x1 : 00000000000000c0 x0 : 0000000000000000
> [   31.080307] Call trace:
> [   31.080340]  xilinx_dpdma_chan_queue_transfer+0x274/0x5e0
> [   31.080518]  xilinx_dpdma_issue_pending+0x11c/0x120
> [   31.080595]  zynqmp_disp_layer_update+0x180/0x3ac
> [   31.080712]  zynqmp_dpsub_plane_atomic_update+0x11c/0x21c
> [   31.080825]  drm_atomic_helper_commit_planes+0x20c/0x684
> [   31.080951]  drm_atomic_helper_commit_tail+0x5c/0xb0
> [   31.081139]  commit_tail+0x234/0x294
> [   31.081246]  drm_atomic_helper_commit+0x1f8/0x210
> [   31.081363]  drm_atomic_commit+0x100/0x140
> [   31.081477]  drm_client_modeset_commit_atomic+0x318/0x384
> [   31.081634]  drm_client_modeset_commit_locked+0x8c/0x24c
> [   31.081725]  drm_client_modeset_commit+0x34/0x5c
> [   31.081812]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x104/0x168
> [   31.081899]  drm_fb_helper_set_par+0x50/0x70
> [   31.081971]  fbcon_init+0x538/0xc48
> [   31.082047]  visual_init+0x16c/0x23c
> [   31.082207]  do_bind_con_driver.isra.0+0x2d0/0x634
> [   31.082320]  do_take_over_console+0x24c/0x33c
> [   31.082429]  do_fbcon_takeover+0xbc/0x1b0
> [   31.082503]  fbcon_fb_registered+0x2d0/0x34c
> [   31.082663]  register_framebuffer+0x27c/0x38c
> [   31.082767]  __drm_fb_helper_initial_config_and_unlock+0x5c0/0x91c
> [   31.082939]  drm_fb_helper_initial_config+0x50/0x74
> [   31.083012]  drm_fbdev_dma_client_hotplug+0xb8/0x108
> [   31.083115]  drm_client_register+0xa0/0xf4
> [   31.083195]  drm_fbdev_dma_setup+0xb0/0x1cc
> [   31.083293]  zynqmp_dpsub_drm_init+0x45c/0x4e0
> [   31.083431]  zynqmp_dpsub_probe+0x444/0x5e0
> [   31.083616]  platform_probe+0x8c/0x13c
> [   31.083713]  really_probe+0x258/0x59c
> [   31.083793]  __driver_probe_device+0xc4/0x224
> [   31.083878]  driver_probe_device+0x70/0x1c0
> [   31.083961]  __device_attach_driver+0x108/0x1e0
> [   31.084052]  bus_for_each_drv+0x9c/0x100
> [   31.084125]  __device_attach+0x100/0x298
> [   31.084207]  device_initial_probe+0x14/0x20
> [   31.084292]  bus_probe_device+0xd8/0xdc
> [   31.084368]  deferred_probe_work_func+0x11c/0x180
> [   31.084451]  process_one_work+0x3ac/0x988
> [   31.084643]  worker_thread+0x398/0x694
> [   31.084752]  kthread+0x1bc/0x1c0
> [   31.084848]  ret_from_fork+0x10/0x20
> [   31.084932] irq event stamp: 64549
> [   31.084970] hardirqs last  enabled at (64548): [<ffffffc081adf35c>] _raw_spin_unlock_irqrestore+0x80/0x90
> [   31.085157] hardirqs last disabled at (64549): [<ffffffc081adf010>] _raw_spin_lock_irqsave+0xc0/0xdc
> [   31.085277] softirqs last  enabled at (64503): [<ffffffc08001071c>] __do_softirq+0x47c/0x500
> [   31.085390] softirqs last disabled at (64498): [<ffffffc080017134>] ____do_softirq+0x10/0x1c
> [   31.085501] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/dma/xilinx/xilinx_dpdma.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index b82815e64d24..eb0637d90342 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -214,7 +214,8 @@ struct xilinx_dpdma_tx_desc {
>    * @running: true if the channel is running
>    * @first_frame: flag for the first frame of stream
>    * @video_group: flag if multi-channel operation is needed for video channels
> - * @lock: lock to access struct xilinx_dpdma_chan
> + * @lock: lock to access struct xilinx_dpdma_chan. Must be taken before
> + *        @vchan.lock, if both are to be held.
>    * @desc_pool: descriptor allocation pool
>    * @err_task: error IRQ bottom half handler
>    * @desc: References to descriptors being processed
> @@ -1097,12 +1098,14 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
>   	 * Complete the active descriptor, if any, promote the pending
>   	 * descriptor to active, and queue the next transfer, if any.
>   	 */
> +	spin_lock(&chan->vchan.lock);
>   	if (chan->desc.active)
>   		vchan_cookie_complete(&chan->desc.active->vdesc);
>   	chan->desc.active = pending;
>   	chan->desc.pending = NULL;
>   
>   	xilinx_dpdma_chan_queue_transfer(chan);
> +	spin_unlock(&chan->vchan.lock);
>   
>   out:
>   	spin_unlock_irqrestore(&chan->lock, flags);
> @@ -1264,10 +1267,12 @@ static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
>   	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&chan->vchan.lock, flags);
> +	spin_lock_irqsave(&chan->lock, flags);
> +	spin_lock(&chan->vchan.lock);
>   	if (vchan_issue_pending(&chan->vchan))
>   		xilinx_dpdma_chan_queue_transfer(chan);
> -	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +	spin_unlock(&chan->vchan.lock);
> +	spin_unlock_irqrestore(&chan->lock, flags);
>   }
>   
>   static int xilinx_dpdma_config(struct dma_chan *dchan,
> @@ -1495,7 +1500,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
>   		    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
>   
>   	spin_lock_irqsave(&chan->lock, flags);
> +	spin_lock(&chan->vchan.lock);
>   	xilinx_dpdma_chan_queue_transfer(chan);
> +	spin_unlock(&chan->vchan.lock);
>   	spin_unlock_irqrestore(&chan->lock, flags);
>   }
>   


