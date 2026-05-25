Return-Path: <dmaengine+bounces-10841-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GayD1v7E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10841-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:33:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F125C72F2
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 932E53003812
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4093D1CA4;
	Mon, 25 May 2026 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWjiqyPS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58A36E469;
	Mon, 25 May 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694423; cv=none; b=rbf5RP8GchNw8JRRu291uHlgjKnRS+EVTTvetatGXSWr+RNJjYB4cQs38LLr1STQ9ylVBwYqhmB/4uJ0cgqABemYSMQXN56eokFnAxycKA17P9RM2UldTB+40VUYeGAHRwQyZLvpWcQEF9bQeS0eyiJNKwFTfITl7KRXLzfcYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694423; c=relaxed/simple;
	bh=tSV7SQd0EWTymtLoyCIduOOv2+iAlufFcDJfxDL7yLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrWos+K0hCq3FhDmE7bbfOKcr2Buo85tNncTQBJ1onfAHak6mETp2v5WgpbPzr7/dCVn6g1kzUfRqNpwj3xCGObQBs3RDawKyFL0/Zri5v6FTrkWapXxBBqEoMk4Vdyf0hBww5Hvz865OgdJQFAOWufL6UzYXTL0kORCrvU7nFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWjiqyPS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F0C1F000E9;
	Mon, 25 May 2026 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779694421;
	bh=pnmbkMl2xDu/8awN4SRZnDiwM/lHHq169JfBYgrjKUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FWjiqyPSYYs/HbFGyzFRa2Hmda3l8FU7O7Af8p9bBnQnwsqZNExHPdpjshjoXDaS3
	 X2FulI7i2GXdbWAnXCestjSty/54UrrvOkAwllCGXQLv8N7l0jV3eRtxXoyPRz/Tsi
	 D500A2TI9Q7vT1BeROuHEbxK489+rhgg+MJfzHAMrPTar+gcWEhPDI7mtEaLQpsJ76
	 ewaa3Osuvc/IdKC2FG6pfo0v7K08PmcoPk1pyxPWSABXQxOnqU41GIpdus925vtgR8
	 dTDA1azHkUJ04r9rUCd1PYdOgBv6QITQp0QCgwI22Ojw1JhtDa1ByKgFu4pgrMUPSk
	 UNnFxzWSbNmUQ==
Message-ID: <4c266a28-1d43-4453-a776-2c2f022f5c85@kernel.org>
Date: Mon, 25 May 2026 10:33:34 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: sashiko review (Re: [PATCH v5 14/17] dmaengine: sh: rz-dmac: Add
 suspend to RAM support)
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, fabrizio.castro.jz@renesas.com,
 kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-15-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260512121219.216159-15-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10841-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 28F125C72F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 >commit 536ec6e9c07fa47423de7d20ebc829e45cbcedfb
 >Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 >Subject: dmaengine: sh: rz-dmac: Add suspend to RAM support
 >This commit adds suspend to RAM support for the Renesas RZ/G3S SoC by
 >saving and restoring the DMA IP registers. It adds specific suspend and
 >resume handling for cyclic channels, and waits for non-cyclic channels
 >to finish before suspending.
 >> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
 >> index df91657fd5e3d..b0a8590f4a9da 100644
 >> --- a/drivers/dma/sh/rz-dmac.c
 >> +++ b/drivers/dma/sh/rz-dmac.c
 >[ ... ]
 >> @@ -1002,20 +1008,57 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
 >>      return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
 >>  }
 >>
 >[ ... ]
 >>  static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 >>                                   unsigned long clear_bitmask)
 >>  {
 >> -    int ret = 0;
 >>      u32 val;
 >> +    int ret;
 >>
 >>      lockdep_assert_held(&channel->vc.lock);
 >>
 >[ ... ]
 >> +    rz_dmac_ch_writel(channel, CHCTRL_CLRSUS | CHCTRL_SETEN, CHCTRL, 1);
 >>
 >> -    rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
 >>      ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
 >> -                                   !(val & CHSTAT_SUS), 1, 1024, false,
 >> -                                   channel, CHSTAT, 1);
 >> +                                   ((val & (CHSTAT_SUS | CHSTAT_EN)) == 
CHSTAT_EN),
 >> +                                   1, 1024, false, channel, CHSTAT, 1);
 >Can this condition time out spuriously for short non-cyclic DMA transfers? If
 >a transfer finishes successfully before the first poll read, the hardware
 >would clear CHSTAT_EN to 0. The polling condition would then evaluate to
 >false, causing the macro to incorrectly return -ETIMEDOUT.

Yes, in theory that can happen.

 >>
 >>      channel->status &= ~clear_bitmask;
 >>
 >[ ... ]
 >> @@ -1406,6 +1459,151 @@ static void rz_dmac_remove(struct platform_device *pdev)
 >>      pm_runtime_disable(&pdev->dev);
 >>  }
 >>
 >> +static int rz_dmac_suspend_prepare(struct device *dev)
 >> +{
 >> +    struct rz_dmac *dmac = dev_get_drvdata(dev);
 >> +    int ret;
 >> +
 >> +    PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
 >> +    ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 >> +    if (ret)
 >> +            return ret;
 >> +
 >> +    for (unsigned int i = 0; i < dmac->n_channels; i++) {
 >> +            struct rz_dmac_chan *channel = &dmac->channels[i];
 >> +
 >> +            guard(spinlock_irqsave)(&channel->vc.lock);
 >> +
 >> +            /* Wait for transfer completion, except in cyclic case. */
 >> +            if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
 >> +                    continue;
 >> +
 >> +            if (rz_dmac_chan_is_enabled(channel))
 >> +                    return -EAGAIN;
 >Could returning -EAGAIN here cause a CPU livelock? In dpm_prepare(), an
 >-EAGAIN error is cleared and retried continuously in a while
 >(!list_empty(&dpm_list)) loop. Since the device is not advanced on error,
 >the PM core might loop infinitely without any backoff until the transfer
 >completes.
 >Also, is there a race condition with non-cyclic channels after this callback
 >returns 0? Since the DMA controller's prepare callback runs before consumer
 >peripherals, an active consumer could immediately submit new non-cyclic
 >transfers before the actual suspend phase begins.

The expectation was to wait until all the transfers complete. But, indeed, there 
might be some issues with this approach. E.g., the serial driver simulates 
cyclic transfers for rx by enqueuing individual SG transfers, and, after each SG 
is completed a new SG is enqueued. So, at any time, the channel is enabled. That 
would lead to the suspend being blocked at this point. As I don't see a way to 
go out of this, for the moment I will drop the prepare callback until the serial 
RX DMA will be adjusted (maybe, to use the cyclic support).


 >> +    }
 >> +
 >> +    return 0;
 >> +}
 >> +
 >[ ... ]
 >> +static int rz_dmac_suspend(struct device *dev)
 >> +{
 >> +    struct rz_dmac *dmac = dev_get_drvdata(dev);
 >> +    int ret = 0;
 >> +
 >> +    for (unsigned int i = 0; i < dmac->n_channels; i++) {
 >> +            struct rz_dmac_chan *channel = &dmac->channels[i];
 >> +
 >> +            guard(spinlock_irqsave)(&channel->vc.lock);
 >This isn't a bug, but does this function mix scope-based guard() cleanup
 >with goto-based error handling? The cleanup guidelines suggest that
 >functions should either convert all resources to scope-based cleanup or
 >convert none of them to avoid confusing ownership semantics.
 >> +
 >> +            if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
 >> +                    continue;
 >> +
 >> +            ret = rz_dmac_device_pause_internal(channel);
 >> +            if (ret) {
 >> +                    dev_err(dev, "Failed to suspend channel %s\n",
 >> +                            dma_chan_name(&channel->vc.chan));
 >> +                    break;
 >> +            }
 >> +
 >> +            channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
 >Does saving only the NXLA register result in data loss for cyclic channels?
 >When a cyclic channel is paused, it stops at its current descriptor. Without
 >saving and restoring the Current Link Address and Current Transfer Byte
 >count, resuming the channel might force it to skip the remaining bytes of the
 >interrupted descriptor and start fetching the next one.

This is something expected, hardware have no capability to overcome this issue.

 >> +    }
 >> +
 >> +    if (ret)
 >> +            goto suspend_recover;
 >> +
 >> +    ret = reset_control_assert(dmac->rstc);
 >Since non-cyclic channels are unconditionally skipped in the loop above and
 >the hardware reset is asserted here, could newly queued non-cyclic requests
 >from consumers be violently interrupted mid-transfer?

The expectation is that non-cyclic transfers have already been paused by the 
time this code executes.

 >> +    if (ret)
 >> +            goto suspend_recover;
 >> +
 >> +    ret = pm_runtime_put_sync(dev);
 >> +    if (ret < 0)
 >> +            goto reset_deassert;
 >> +
 >> +    return 0;
 >> +
 >> +reset_deassert:
 >> +    reset_control_deassert(dmac->rstc);
 >> +suspend_recover:
 >> +    rz_dmac_suspend_recover(dmac);
 >> +    return ret;
 >> +}
 >> +
 >[ ... ]
 >> +static const struct dev_pm_ops rz_dmac_pm_ops = {
 >> +    .prepare = rz_dmac_suspend_prepare,
 >This isn't a bug, but should rz_dmac_suspend_prepare be wrapped in
 >pm_sleep_ptr() here? The power management subsystem guidelines recommend
 >using pm_sleep_ptr() for individual callbacks within the ops structure to
 >prevent dead code and unused variable warnings when CONFIG_PM_SLEEP is
 >disabled.

I will drop this function here in the next version as I discovered some issues 
with it and the serial RX DMA.

 >> +    SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
 >> +};
 >> +
 >>  static const struct rz_dmac_info rz_dmac_v2h_info = {
 >>      .icu_register_dma_req = rzv2h_icu_register_dma_req,
 >>      .default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
 >> @@ -1432,6 +1630,7 @@ static struct platform_driver rz_dmac_driver = {
 >>      .driver         = {
 >>              .name   = "rz-dmac",
 >>              .of_match_table = of_rz_dmac_match,
 >> +            .pm     = pm_sleep_ptr(&rz_dmac_pm_ops),
 >This isn't a bug, but should pm_ptr() be used for the dev_pm_ops structure
 >pointer instead of pm_sleep_ptr()? The power management guidelines recommend
 >using pm_ptr() for the structure pointer, while reserving pm_sleep_ptr() for
 >the individual sleep callbacks inside the structure.

OK, will switch to pm_ptr()

 >>      },
 >>      .probe          = rz_dmac_probe,
 >>      .remove         = rz_dmac_remove,

