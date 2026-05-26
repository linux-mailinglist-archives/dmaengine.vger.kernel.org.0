Return-Path: <dmaengine+bounces-10921-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALU3GMpnFWqtUwcAu9opvQ
	(envelope-from <dmaengine+bounces-10921-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:28:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 591925D352A
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F3B230028F9
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DA336ED2;
	Tue, 26 May 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcQ/5z4i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD233FE02
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787712; cv=none; b=aklSDAqw5gdWwQXpktY2CVD9OXn8ueviwyPl45J1DKXjF0Pkt+A6nJ0Srt+3qGZpKwNefYrc3qJPMoh+RCDYO3kjJNZ9z9Qjp+WMQZAtc9UGEvlOzFbHHUTooDPqnONzbki8Qmgv88ePkjLexPNFGXBel6MYMvuzkdMIP77OqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787712; c=relaxed/simple;
	bh=zYrhVd7TOC806dry2q67Exm5p44Q6vJeAi/2ZQDSO2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j8bwyiPXsE2yHHjGI74LC/bTzbD0Y1dEBS/80y8Ru3iNoQbcgQ6PAgF9STBOrGQOX50GTRtcAfULfcKDz6HwHjdvLZ89e8TsvR0g5/B/AHbAaK2NOtwmkb4MQFJQZD5zohkwpNahKzado3KujQPRzQEg9YhM4iYA6KVZVUMUnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcQ/5z4i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F321F000E9;
	Tue, 26 May 2026 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787711;
	bh=2nQVUb7BmP1CsTwCyCiugUucUrJWlHy68zgQYD76JEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcQ/5z4ivENpqGbgWkksVhnM4oqbtUp66nGPX/stoyX8KBsscLt6rnirORh8j8MIS
	 S7CD/cTxw/4a8LR2HpPLpBR+zgoDXUW7zsTrTknhuKZSq/GEdL59lP+F3JHf9fCwYN
	 Qi3L17g+cII/H/9dLHC4I7Db/NHXwOXvZqF2Ah7lJoQXz5erx+PzzCuCpepN3pHK7k
	 A4/CA/1wdn8TZjhkJWWcNOC3yV/Jn3KQDo1tlpAM1pa+S2xjSN5B8pZ4rqVIwwPl6m
	 6/+hnUGzjoqzOsk7Gr1DNK8YNm0QObzY/vKzzFTFDNiI5BpAnUWAVhwY5rQKCFqJFm
	 m8kX30NLphdxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/18] dmaengine: sh: rz-dmac: Refactor pause/resume
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260526084710.3491480-11-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-11-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:28:30 +0000
Message-Id: <20260526092830.E5F321F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,renesas.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10921-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Queue-Id: 591925D352A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Software status tracking becomes inconsistent if hardware pause/re=
sume operations time out.
- [High] Unconditional hardware resume ignores other active pause requests.
--

commit 9f2ce07d8501ca3cb4ac77194345402583e5ba4b
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Refactor pause/resume code

This refactors the pause/resume support in the rz-dmac driver.
It introduces a bitmask-based status field to allow reusing the pause
and resume code for system suspend/resume and cyclic DMA operations.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 1f884ec101f80..557364443a5fd 100644
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

[Severity: High]
Does this unconditional hardware resume ignore other active pause requests?

The bitmask-based status tracking appears to be designed to handle multiple
independent pause conditions. However, writing CHCTRL_CLRSUS happens
regardless of the remaining state.

If a channel is paused for multiple reasons, clearing one condition will
immediately unpause the hardware while other constraints are still active.
Could this regression lead to unexpected DMA execution and data corruption?

> +	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +				       !(val & CHSTAT_SUS), 1, 1024, false,
> +				       channel, CHSTAT, 1);
> +
> +	channel->status &=3D ~clear_bitmask;

[Severity: High]
Should channel->status be cleared if the hardware resume operation times ou=
t?

If read_poll_timeout_atomic returns an error like -ETIMEDOUT, the status
bitmask is still unconditionally cleared.

If a caller later attempts to retry the resume operation, it will exit early
because the status bit is already gone, leaving the hardware permanently
suspended while the software stack thinks it is active. Does this create a
regression where the channel can no longer be resumed?

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D10

