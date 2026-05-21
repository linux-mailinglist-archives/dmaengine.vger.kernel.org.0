Return-Path: <dmaengine+bounces-10623-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMI6NKCwDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10623-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:13:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABF59FEFD
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F3C3005ADB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8E34CFAE;
	Thu, 21 May 2026 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4cv1rBi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63717B43F
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347563; cv=none; b=gY56lkZi7qVoqxoMina8S37DbBqZrrk/LNt2eCHlyghXP/nirpkkcMcm1XBiORacz5ZZ/jaJC7v1QB7x6/pTJm3YrYlx4tRmJSYG8eT8sD0IcfU2Yz/8NRhofdNt25vditW13zGJsR8XtIn/CU7UtG1hLd1RbftSVzYdLgeBoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347563; c=relaxed/simple;
	bh=F3xpCHydZrNhBaT7FVylpxOEOJBreZIfpCnvFatnvcc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q6Drm2RsW4IRDrIyN0+j8578qyVlZ3TzwkYCz4Ink8Y/LKC9uz8u1+bxzaIF6EBYkJM1A/C/Coms8fr/RUNLIatr0fJ2Os0Z5DelOuJuwD4SKXMqrmwWArdQEU04DZCBG/qHVtmeb9DCneZrI0SnmHwWKRta7j/kJ7BLxjfkSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4cv1rBi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FBC1F000E9;
	Thu, 21 May 2026 07:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779347561;
	bh=xEKGGl5/hhE9MRRNKQIhetoj+yM6eOpC0Is8OuDaurM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l4cv1rBi3i8ppIUZjy7lC9wW24eFIefWdGctM4EgGb7grMPLqZSizgT3EVMY2mNqD
	 OhAl9GFXJi1ulC8LiAzsS3omve1t/vUEb2gLBJLUpF21nLNTEoPyGuK6MMoPV2C+pY
	 zPXhaNj1f8sfK07qzVvcGl762nuh2jy6Bn7olRVCgigYRpid2w1ocsV1Kc1TcH81UO
	 X4yDZNPggwvUu+PXFycVybPzEEY1Jxwhc6iRxYM3W7MPdbpx7lPecasBujtEy5zNo2
	 Tx6OewQb5mzq8Gf1rJr8A0ug1YxehxUs+gDmyBDFYZuQ7VzlNYpwSxei1ObRHYf5TZ
	 V4mNx4B3s5sIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260521063115.2842238-4-den@valinux.co.jp>
References: <20260521063115.2842238-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 07:12:41 +0000
Message-Id: <20260521071241.B4FBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10623-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,valinux.co.jp:email]
X-Rspamd-Queue-Id: 25ABF59FEFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Type confusion between legacy integer and new struct config leadin=
g to DMA misconfiguration.
- [High] Configuring a local chip with remote IRQ mode causes a silent DMA =
stall.
- [High] Returning `IRQ_HANDLED` for explicitly ignored channels defeats sp=
urious interrupt detection and causes IRQ storms.
- [High] Lockless reset of `irq_mode` during channel teardown races with ac=
tive interrupt handlers.

Pre-existing issues:
- [High] Concurrent read-modify-write operations on shared `int_mask` regis=
ters cause lost interrupts.
--

commit 35570bb087f6cfd06ea3a1cd7849ae4a15c6dac5
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add per-channel interrupt routing control

This patch adds per-channel interrupt routing control to the DesignWare eDMA
driver. It introduces dw_edma_peripheral_config to allow a frontend to sele=
ct
local or remote interrupt routing for each channel. The v0 programming path
is updated to respect this configuration while maintaining legacy behavior.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 6660380a1bbc2..72dc8a60798a2 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -219,12 +219,56 @@ static void dw_edma_device_caps(struct dma_chan *dc=
han,
[ ... ]
> +static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
> +				  const struct dma_slave_config *config,
> +				  enum dw_edma_ch_irq_mode *mode)
> +{
> +	const struct dw_edma_peripheral_config *pcfg;
> +
> +	/* peripheral_config is optional, fall back to the frontend default. */
> +	*mode =3D dw_edma_get_default_irq_mode(chan);
> +	if (!config || !config->peripheral_config)
> +		return 0;
> +
> +	if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE)
> +		return -EOPNOTSUPP;
> +
> +	if (config->peripheral_size < sizeof(*pcfg))
> +		return -EINVAL;
> +
> +	pcfg =3D config->peripheral_config;
> +	switch (pcfg->irq_mode) {
> +	case DW_EDMA_CH_IRQ_DEFAULT:
> +	case DW_EDMA_CH_IRQ_LOCAL:
> +	case DW_EDMA_CH_IRQ_REMOTE:
> +		*mode =3D pcfg->irq_mode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}

[Severity: High]
Does this code allow configuring a local chip with remote IRQ mode?

If DW_EDMA_CH_IRQ_REMOTE is accepted for DW_EDMA_CHIP_LOCAL chips, it appea=
rs
dw_edma_v0_core_start() will mask local done/abort interrupts. However,
dw_edma_v0_core_write_chunk() explicitly gates setting DW_EDMA_V0_RIE behind
!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL).

If a local chip is configured for remote IRQ mode, does this mean local
interrupts are masked while remote interrupts are never enabled, causing
the channel to hang indefinitely?

> +
>  static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +	enum dw_edma_ch_irq_mode mode;
>  	bool cfg_non_ll;
>  	int non_ll =3D 0;
> +	int ret;
> =20
>  	chan->non_ll =3D false;
>  	if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {

[Severity: High]
Can this code misinterpret the new config struct as the non_ll flag?

When the chip is EDMA_MF_HDMA_NATIVE, the existing driver expects
config->peripheral_config to be an int * denoting the non_ll flag, and
validates it using config->peripheral_size !=3D sizeof(int).

Because sizeof(struct dw_edma_peripheral_config) is equal to sizeof(int),
could a frontend passing the new struct to an HDMA backend bypass the size
check? If so, the driver might cast the struct to int * and incorrectly
interpret the irq_mode enum value as the non_ll flag, inadvertently toggling
non-LL mode and corrupting linked-list execution.

[ ... ]
> @@ -871,6 +919,8 @@ static void dw_edma_free_chan_resources(struct dma_ch=
an *dchan)
> =20
>  		cpu_relax();
>  	}
> +
> +	chan->irq_mode =3D dw_edma_get_default_irq_mode(chan);
>  }

[Severity: High]
Does this lockless reset of irq_mode race with active interrupt handlers?

During teardown, dw_edma_device_terminate_all() asynchronously requests
stopping the channel and returns 0 immediately if the channel was running.
The loop then breaks, and chan->irq_mode is reset without synchronization.

Because the hardware and interrupt handlers might still be actively process=
ing
the stop request, modifying chan->irq_mode locklessly races with the ISR.
For instance, could dw_edma_core_ch_ignore_irq() read the reset mode
mid-execution and erroneously process an interrupt during teardown?

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 69e8279adec81..2e95da0d6fc2c 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_ir=
q, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan =3D &dw->chan[pos + off];
> =20
> -		dw_edma_v0_core_clear_done_int(chan);
> -		done(chan);
> +		if (!dw_edma_core_ch_ignore_irq(chan)) {
> +			dw_edma_v0_core_clear_done_int(chan);
> +			done(chan);
> +		}
> =20
>  		ret =3D IRQ_HANDLED;
>  	}

[Severity: High]
Does returning IRQ_HANDLED for explicitly ignored channels defeat spurious
interrupt detection?

If dw_edma_core_ch_ignore_irq(chan) returns true, the code skips clearing t=
he
interrupt but still executes ret =3D IRQ_HANDLED.

Returning IRQ_HANDLED without actually clearing the interrupt condition tel=
ls
the kernel the interrupt was successfully serviced. Doesn't this prevent th=
e IRQ
subsystem from disabling a faulty or shared IRQ line, potentially resulting=
 in
an interrupt storm and a kernel lockup if the uncleared status bit causes a
level-triggered IRQ to remain asserted?

[ ... ]
> @@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_ch=
unk *chunk, bool first)
>  				break;
>  			}
>  		}
> -		/* Interrupt unmask - done, abort */
> +		/* Interrupt mask/unmask - done, abort */
>  		tmp =3D GET_RW_32(dw, chan->dir, int_mask);
> -		tmp &=3D ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> -		tmp &=3D ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		if (chan->irq_mode =3D=3D DW_EDMA_CH_IRQ_REMOTE) {
> +			tmp |=3D FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp |=3D FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		} else {
> +			tmp &=3D ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp &=3D ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		}
>  		SET_RW_32(dw, chan->dir, int_mask, tmp);

[Severity: High]
This isn't a bug introduced by this patch, but does the read-modify-write
sequence here race on shared registers?

The global int_mask register is updated using Read-Modify-Write operations.
Because these registers control the interrupt masks for all channels in a
given direction, and dw_edma_v0_core_start() is only protected by the
per-channel vchan spinlock, concurrent channel starts on different CPUs cou=
ld
race.

Can this data race cause a channel's interrupt unmask operation to be
overwritten and lost, permanently stalling that DMA channel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D3

