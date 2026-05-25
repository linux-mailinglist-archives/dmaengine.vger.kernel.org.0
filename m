Return-Path: <dmaengine+bounces-10831-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAFpIjLzE2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10831-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:58:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE75C6D5F
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09A33032768
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF13A83BF;
	Mon, 25 May 2026 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAUxA6hT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130192D6409
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692078; cv=none; b=AA494SGH/QN6SCwGlwXffyxupIfkRckNGZ+0DLCI6xbkbO304Z7cEad7BmOVORbLVfVYw2oYNmM8JhayrvxDzcmZ36PZlaZD5hr0XEiNZbg1UjkDTdONDPpdTRGqtngtnyMlaew0B1T5T7jbID7eKGyque+YZR42nrvlKt2bJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692078; c=relaxed/simple;
	bh=q9PGP0f+N0AkuAR46kBDfd66juIflcmWfNEz/3Ijmgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBy1+3BHmCXrRCoHPCF76QQ2Os7S44AbJhzJgHDXIeGGz+gpVmDdH6QBH1iHgtsVu+U1JbHp9fQ7wxuehW7XIHGdAObtlpS/rBffnVI1dyzFBncOtDEhhAuCPOD2/HEeIkYHkTuDJS7d1LYP1dOmFAqPXcEIV8UWCcKlTJ1zNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAUxA6hT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBCE1F000E9;
	Mon, 25 May 2026 06:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779692075;
	bh=jji0jxVMuZ9AiGjs8JE+R7aDL/BM7Wl+GljFL068z88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nAUxA6hTULUwCCpgRD5DDci/s4/KrTVVv4GM+Qwv5JVXbp9TkO1BGPMEZspmEfhcP
	 lZ4pfsKO26uiaX7/bw4cFspzwj2zscL1Cwr3Ebee2H3Hi87Sh2dCqkiBebnL2rnXu9
	 fdBYrrLmpWXSx9am1o0mTozjM5ZhmxN+T0SYCr0qMlLIR5CrD/37w5Xkw1rXOb8dHC
	 NZ/LJ0pt0fq9cCGEKnENNQNyiLAmqrUV5wCxHvCjU6ccchLjfPUnNgH/tpkyZuO9oG
	 2VHszV/r4vJAc8PhU5ben0Sd/gZj6aah2XbTaSGS5+eOg3EtIT0REhRPChSZrZBLXp
	 xqXE+AbCqKWYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260525062420.3315904-3-den@valinux.co.jp>
References: <20260525062420.3315904-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:54:34 +0000
Message-Id: <20260525065434.DEBCE1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10831-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: DEBE75C6D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Unreachable check for `EDMA_MF_HDMA_NATIVE` in `dw_edma_parse_irq_m=
ode()`.

Pre-existing issues:
- [High] Concurrent read-modify-write on shared global hardware registers w=
ithout synchronization leads to data corruption.
--

commit 6b65a0e4ed091bf22ca8e45283b55b75a452841e
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add per-channel interrupt routing control

DesignWare eDMA can signal completion locally through edma_int[] and
remotely through IMWr/MSI. This commit adds dw_edma_irq_config to allow
frontends to choose default, local, or remote IRQ handling per channel.
The v0 path is updated to follow the selected mode for linked-list
interrupt generation and DONE/ABORT masking.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 80b4a168225b5..a70e0640d082c 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -219,12 +219,66 @@ static void dw_edma_device_caps(struct dma_chan *dc=
han,
[ ... ]
> +static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
> +				  const struct dma_slave_config *config,
> +				  enum dw_edma_ch_irq_mode *mode)
> +{
> +	const struct dw_edma_irq_config *pcfg;
> +
> +	/* peripheral_config is optional, fall back to the frontend default. */
> +	*mode =3D dw_edma_get_default_irq_mode(chan);
> +	if (!config || !config->peripheral_config)
> +		return 0;
> +
> +	if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE)
> +		return -EOPNOTSUPP;

[Severity: Low]
Is this EDMA_MF_HDMA_NATIVE check dead code?

Looking at dw_edma_device_config() below, dw_edma_parse_irq_mode() is
only called in the else branch of the EDMA_MF_HDMA_NATIVE check, so this
condition would seemingly never evaluate to true.

> +
> +	if (config->peripheral_size !=3D sizeof(*pcfg))
> +		return -EINVAL;
[ ... ]
> @@ -255,10 +309,11 @@ static int dw_edma_device_config(struct dma_chan *d=
chan,
> =20
>  		if (cfg_non_ll || non_ll)
>  			chan->non_ll =3D true;
> -	} else if (config->peripheral_config) {
> -		dev_err(dchan->device->dev,
> -			"peripheral config param applicable only for HDMA\n");
> -		return -EINVAL;
> +	} else {
> +		ret =3D dw_edma_parse_irq_mode(chan, config, &mode);
> +		if (ret)
> +			return ret;
> +		chan->irq_mode =3D mode;
>  	}
> =20
>  	memcpy(&chan->config, config, sizeof(*config));
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 69e8279adec81..08ec2bd7856ec 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
[ ... ]
> @@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_ch=
unk *chunk, bool first)
>  				break;
>  			}
>  		}
> -		/* Interrupt unmask - done, abort */
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
This is a pre-existing issue, but does this read-modify-write sequence on
shared global registers lack proper synchronization?

It appears int_mask and linked_list_err_en are controller-wide registers.
If dw_edma_v0_core_start() is called concurrently for different channels
in the same direction, they would only be protected by their respective
per-channel virtual DMA lock (chan->vc.lock) instead of a global lock.

Could concurrent updates from multiple CPUs overwrite each other's mask
values, leading to permanently lost interrupts or DMA timeouts?

>  		/* Linked list error */
>  		tmp =3D GET_RW_32(dw, chan->dir, linked_list_err_en);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D2

