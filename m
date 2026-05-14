Return-Path: <dmaengine+bounces-10456-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDzpMfEdBWoASwIAu9opvQ
	(envelope-from <dmaengine+bounces-10456-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:57:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC453C7B1
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 844973008FFC
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5C2F3600;
	Thu, 14 May 2026 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVi6CRRz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51682F5A12
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720227; cv=none; b=J111g4DJKL9DuDFjgWSev02Bz95hQy7T7m6PpZ9VrAUhvy3n4qmXZHrNm7tJqvEkrTuCn/BBDh5PuAHA297rHAvCWPAn07nHWGJ/sZI5kdtETm06TpO79QMLyGhUW1MTWazwTFi6Ty+8DhD7o5SWSyN29Y2WeiysIrqKmhRa+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720227; c=relaxed/simple;
	bh=79PLLt3H5bZJ+Igkwi4VuK86lvaseSatQnS/uvwPxWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e6eY3R9x8ye0PIJHKTKN32199xtvA+FD1SmvKtB7o+hdgXYoxIt2BFNwa/Mw3RIHhPqeqg+yFCSMvL+GNUgO5dXOeUryIbLPF72Oz+9q+XtpuMOD7T/BXYgQyCdPK6JNTpspNYsVVxbshPl8oehSTFcvRxp1u2xZjdlsEO+fOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVi6CRRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ECEC19425;
	Thu, 14 May 2026 00:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720227;
	bh=79PLLt3H5bZJ+Igkwi4VuK86lvaseSatQnS/uvwPxWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uVi6CRRz8mBKiqfQbIfKvgBrU/haoRcw50PR4w7mRAotztvVw5sMzUpR5VXn0V8t6
	 2vMA77Ioqzwu2XEWjU4LNQ2QVtu23bcSjwLl0XmeXt4tXe0BLEVR2Wnn6E9skH2fXd
	 SxSGz8COMDgwZphNWxy+uGoPNRQzWBcIm+kX1gaujsz/ajY3z++ydpSrUTn7XV7xPY
	 187eYzmddgQ40fGeC2WfjM20rulxktQID2lJGQUGevJ6KXuG7Tsds2iA5YkAgB1gUy
	 xrtjlIfpGutEjVUYNosYRM1G2Rud9LMsCFTq6F29H/j1PgZ8WvK3ceKLapNYg50e4G
	 Kky0M2BzLx5ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] dmaengine: sh: rz-dmac: Refactor pause/resume
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260512121219.216159-11-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-11-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:57:06 +0000
Message-Id: <20260514005707.63ECEC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C0EC453C7B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10456-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware is prematurely resumed when multiple pause sources are ac=
tive.
- [High] Software status bitmask is incorrectly updated even if the hardwar=
e resume operation times out.
--

commit 6c32a478012b8f47e162dfe05b689182e89ba6c2
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Refactor pause/resume code

This commit refactors the pause/resume functionality to introduce _set
variants using a channel->status bitmask. This prepares the driver for
suspend/resume and cyclic DMA support where multiple pause sources might
exist.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
[ ... ]
> @@ -795,35 +811,70 @@ static enum dma_status rz_dmac_tx_status(struct dma=
_chan *chan,
[ ... ]
> +static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
> +				     unsigned long clear_bitmask)
> +{
> +	int ret =3D 0;
> +	u32 val;
> +
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
> +
> +	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);

If there are multiple active pause sources (for example, paused by the DMA
client and by system suspend), will writing CHCTRL_CLRSUS here resume the
hardware prematurely?

Since this function is designed to clear a specific bitmask from the channel
status, should the hardware resume operation only be performed if there are
no other pause bits remaining in channel->status?

> +	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +				       !(val & CHSTAT_SUS), 1, 1024, false,
> +				       channel, CHSTAT, 1);
> +
> +	channel->status &=3D ~clear_bitmask;

If the hardware resume operation times out and returns an error, is it
expected to clear the status bitmask anyway?

If a caller receives an error and attempts to retry the resume operation,
the channel->status bit will already be cleared. Does this prevent the retry
from succeeding, leaving the hardware stuck in a paused state?

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D10

