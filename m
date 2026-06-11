Return-Path: <dmaengine+bounces-11487-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XK0gMREnK2ow3QMAu9opvQ
	(envelope-from <dmaengine+bounces-11487-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:22:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57D6756A5
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:22:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aqMBpkMD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11487-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11487-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25DD307F513
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3F34EF0F;
	Thu, 11 Jun 2026 21:22:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAF2737F8
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212943; cv=none; b=k94uXzbbx2QbpnaY6ILoR8RZ5yetWGkm+YY/zNDRrUscRtcKzSJF0WLec0p940MS/mVYNsR8FKicRGO/gd9zNKoMFsXy5Dper6RMrIzm1gNlwQ1qv6urYPeX2Srb63SnWEyD2sJzMV4yr71VYWuxa1mggNn7DaOxZmE+vhNKel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212943; c=relaxed/simple;
	bh=YLVSA08r9nJ7KJsZZ+N6Ox/qHd18g1tMmIwWgNJbyXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D/J+HhDzF4jyZoiw4K4kwgHCMNS7Fd26wyzgObir7raKmsKDlceP4uk88PT1PmeFYQj9fFRiXNI5XKAmiwVgkhL0yROPMlcmgEhWAXYT5S/WAsflwqKoSSpDWEjlaYeExDeAfywZmPz4We3EFhWNrLWhQX4LLcHXio1s0kAdX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqMBpkMD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FCC1F00A3A;
	Thu, 11 Jun 2026 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781212941;
	bh=M9KQunStccTNqPnFBRBxYNDYuEtsVfT4pT/FBHxgc4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aqMBpkMDz55iw2NxwzVpfzLZrsn7GmaM21rAGcu9is2EmZd9/GiTimo9bbcHMAe2D
	 2ciPrKw1I//y59WEzNddmHAydyqVrRdkjytoPNIwc0wnjW22Gmnz61Elcl7MJ/aBWB
	 ZPq5ZAhy1Ihh/IXVuc3ZIzjgD6FlOOnvjD3io2+13gRp6ZR3pOTiNppyjL4itWyudz
	 qQJERXb8XdDz+CJ06n7m72EK/AiP2W0a04Wh/tJOtM24f6PjjiPJq6ufxXEO4DcKNx
	 eJw4MWB81VUiQbH271pYzbJFowZgwhg9Fo/YBB1dPDz1WDwTIc3tbaqQziXYP1zssg
	 7cAxEmi8XxA/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 3/9] dmaengine: mv_xor: bound maximum channels for
 Armada 37xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260611210721.81979-4-rosenp@gmail.com>
References: <20260611210721.81979-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 21:22:20 +0000
Message-Id: <20260611212221.35FCC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11487-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A57D6756A5

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `clk_prepare_enable()` is ignored, leading to =
potential warnings and hardware hangs if the clock fails to enable.
- [High] The driver fails to kill the scheduled `irq_tasklet` on error and =
teardown paths, leading to a Use-After-Free.
- [High] In `mv_xor_channel_remove()`, DMA memory is freed before the inter=
rupt handler is disabled, creating a race condition leading to Use-After-Fr=
ee.
- [High] The driver lacks a `.remove` callback and does not set `.suppress_=
bind_attrs =3D true`, causing severe resource leaks and use-after-free on s=
ysfs unbind.
- [High] The IRQ handler is requested and unmasked before the channel's spi=
nlock and lists are initialized, resulting in a race condition causing a NU=
LL pointer dereference.
- [High] The inline dummy buffers (`dummy_src`, `dummy_dst`) share cachelin=
es with struct members and their DMA mapping directions are reversed.
--

commit f06921d6568212d3de528ed83169a5d04733b815
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: mv_xor: bound maximum channels for Armada 37xx

This commit adds a missing bounds check for the max_channels calculation
on Armada 37xx. It ensures max_channels does not exceed MV_XOR_MAX_CHANNELS
based on num_present_cpus(), preventing the probe loop from writing past
the end of the xordev->channels[] array.

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 25ed61f1b0899..68f0880ad441f 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
[ ... ]
> @@ -1376,7 +1376,8 @@ static int mv_xor_probe(struct platform_device *pde=
v)
>  	 */
>  	max_engines =3D num_present_cpus();
>  	if (xordev->xor_type =3D=3D XOR_ARMADA_37XX)
> -		max_channels =3D	num_present_cpus();
> +		max_channels =3D min_t(unsigned int, MV_XOR_MAX_CHANNELS,
> +				     num_present_cpus());
>  	else
>  		max_channels =3D min_t(unsigned int,
>  				     MV_XOR_MAX_CHANNELS,

While reviewing this patch, I noticed a few pre-existing issues in the
surrounding code that might need attention.

[Severity: High]
This isn't a bug introduced by this patch, but looking at mv_xor_probe()
the return value of clk_prepare_enable() appears to be ignored:

    if (!IS_ERR(xordev->clk))
        clk_prepare_enable(xordev->clk);

If the clock fails to enable, would the driver continue probing and
subsequently hang the hardware bus during I/O accesses?

Additionally, the error path unconditionally executes clk_disable_unprepare=
():

    if (!IS_ERR(xordev->clk)) {
        clk_disable_unprepare(xordev->clk);
        clk_put(xordev->clk);
    }

Could this trigger a state imbalance warning in the clock core if the clock
was never successfully enabled?

[Severity: High]
This is a pre-existing issue, but does mv_xor_channel_remove() miss killing
the irq_tasklet before freeing the channel?

drivers/dma/mv_xor.c:mv_xor_channel_remove() {
    ...
    free_irq(mv_chan->irq, mv_chan);

    return 0;
}

Could a pending tasklet run after mv_chan is freed by devres, leading to
a use-after-free? It looks like the err_free_irq path in mv_xor_channel_add=
()
has a similar pattern and might also need a tasklet_kill() before returning.

[Severity: High]
This is a pre-existing issue, but is there a race condition in
mv_xor_channel_remove() when freeing DMA memory?

drivers/dma/mv_xor.c:mv_xor_channel_remove() {
    ...
    dma_free_wc(dev, MV_XOR_POOL_SIZE,
                mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
    dma_unmap_single(dev, mv_chan->dummy_src_addr,
                     MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
    dma_unmap_single(dev, mv_chan->dummy_dst_addr,
                     MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
    ...
    free_irq(mv_chan->irq, mv_chan);
}

Since dma_free_wc() and dma_unmap_single() are called before free_irq(), co=
uld
an interrupt fire during this window and schedule the tasklet to access the
freed descriptor buffers?

[Severity: High]
This isn't a bug introduced by this patch, but does the driver lack a
.remove callback and omit .suppress_bind_attrs =3D true?

drivers/dma/mv_xor.c:
static struct platform_driver mv_xor_driver =3D {
    .probe          =3D mv_xor_probe,
    .suspend        =3D mv_xor_suspend,
    .resume         =3D mv_xor_resume,
    .driver         =3D {
        .name           =3D MV_XOR_NAME,
        .of_match_table =3D mv_xor_dt_ids,
    },
};

If the root user manually unbinds the device via sysfs, would this leak DMA
device registrations and hardware interrupts? Could a subsequent interrupt
access the devm-freed mv_chan and cause a use-after-free?

[Severity: High]
This is a pre-existing issue, but does requesting and unmasking the
interrupt before initializing the channel's lock and lists risk a NULL
pointer dereference?

drivers/dma/mv_xor.c:mv_xor_channel_add() {
    ...
    ret =3D request_irq(mv_chan->irq, mv_xor_interrupt_handler,
                      0, dev_name(&pdev->dev), mv_chan);
    if (ret)
        goto err_free_dma;

    mv_chan_unmask_interrupts(mv_chan);

    ...

    spin_lock_init(&mv_chan->lock);
    INIT_LIST_HEAD(&mv_chan->chain);
    INIT_LIST_HEAD(&mv_chan->completed_slots);
}

If an interrupt fires immediately after being unmasked, wouldn't the tasklet
attempt to acquire an uninitialized spinlock and iterate over the
uninitialized mv_chan->chain list?

[Severity: High]
This isn't a bug introduced by this patch, but do the inline dummy buffers
share cachelines with adjacent struct members?

drivers/dma/mv_xor.h:struct mv_xor_chan {
    ...
    int                     op_in_desc;
    char                    dummy_src[MV_XOR_MIN_BYTE_COUNT];
    char                    dummy_dst[MV_XOR_MIN_BYTE_COUNT];
    dma_addr_t              dummy_src_addr, dummy_dst_addr;
}

In mv_xor_channel_add(), the mapping directions appear to be reversed:

    mv_chan->dummy_src_addr =3D dma_map_single(dma_dev->dev,
        mv_chan->dummy_src, MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
    ...
    mv_chan->dummy_dst_addr =3D dma_map_single(dma_dev->dev,
        mv_chan->dummy_dst, MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);

Could mapping dummy_src as DMA_FROM_DEVICE cause the DMA API to perform
a cache invalidation that clobbers dirty, unflushed CPU writes to adjacent
members like op_in_desc?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611210721.8197=
9-4-rosenp@gmail.com?part=3D1

