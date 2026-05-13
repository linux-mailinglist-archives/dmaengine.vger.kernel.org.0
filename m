Return-Path: <dmaengine+bounces-10452-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOycJGcQBWrvRwIAu9opvQ
	(envelope-from <dmaengine+bounces-10452-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:59:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0794853C332
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1A43014BE0
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEDC39FCB9;
	Wed, 13 May 2026 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsEkfWEc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADC1EFFA1
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716772; cv=none; b=gp5pnYdQ7QaB+NFq+GJfYK9NsGmCrD15Lxc/3QI/pxcxPD4Oqn1SHL4jCgGzm8Ta3q54Sck/MSCatPC1uG9/u+IeJRMIwnMIlbsdxUe6UJs9Tg48zquQlvqVh4oWCgnYOcXC2G0I3t1T3oBgY279XCAGnxycN6L5gcD1gTsdXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716772; c=relaxed/simple;
	bh=GignoxCNpSCZECNk4USOCXgHDQ6+zVbOU0NUoxYxweM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9CralL6tOU2YIR5kO8RlZ/wkJTL9+20rFXMo1sBNd3YUf2Rsa0ftIxSmcz7KWiBPkV9oLzRunP4tk4IfpNdNHhHmuPC5BIW2gIa7sr5+7bjlKjU/TijDrTMeHdMDeHeao8Rtu8X0fvnuhmdED7mYnEVjn3IZL1fhNEgN4jB/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsEkfWEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD02FC2BCB3;
	Wed, 13 May 2026 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716772;
	bh=GignoxCNpSCZECNk4USOCXgHDQ6+zVbOU0NUoxYxweM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OsEkfWEc8/e2fHdBjd7QPxafH5HicBoYORr6jNRKuFl0WDfRVzS3c9vi6CikchghC
	 YLgS4vgcj4k/iXxKHb+JJw2w7Uu/oIGv7co/Ngy8m+PEcxkkLz2TBYTnZTXiAK1MC4
	 HRflPuHEyBx+NhUSeIfmSz4846Tc/rYgNCSsBjvel4SWf4dfsEXG1uDEVRekpDhxFE
	 H1tAUIRw7Tx4eH9aTLwNBZl5uWEjdP43SwjiHidEigm8zysNcfXfytB4wGlmuMGj6B
	 jF/wsxqIR58SQNe4jFXeQOo57/XcdWEbdVnuvOiASd3KXKicq17aH1XFAV/raCiW72
	 cOhKfGGQzVeVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] dmaengine: sh: rz-dmac: Add helper to check if
 the channel is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260512121219.216159-8-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-8-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:59:31 +0000
Message-Id: <20260513235931.DD02FC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0794853C332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10452-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Incomplete refactoring: the `rz_dmac_chan_is_enabled` helper is not=
 used in `rz_dmac_enable_hw()`.
- [Low] Parameter naming convention mismatch in `rz_dmac_chan_is_enabled()`.
- [Low] Redundant double-negation operator (`!!`) used with a `bool` return=
 type.
--

commit c927e2bf558812607e323c4466ef5f913dc31b55
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled

This commit adds a helper function to check if a DMA channel is enabled.
The new helper is then used to refactor the device pause operation.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d3926ecd63ac1..c7337cf271369 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -279,6 +279,13 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_ch=
an *channel)
>  	channel->lmdesc.head =3D lmdesc;
>  }
> =20
> +static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *chan)

This isn't a bug, but could we use "channel" instead of "chan" for the
parameter name?

Throughout the rest of the driver, "chan" seems reserved for
struct dma_chan *, while "channel" is used for struct rz_dmac_chan *.

> +{
> +	u32 val =3D rz_dmac_ch_readl(chan, CHSTAT, 1);
> +
> +	return !!(val & CHSTAT_EN);

Is the double negation necessary here?

Since the function returns a bool, the compiler will automatically convert
any non-zero value to true, so returning val & CHSTAT_EN should be
sufficient.

> +}
> +
>  static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)

Could the new helper be used here in rz_dmac_enable_hw() as well?

Looking at rz_dmac_enable_hw(), it has an identical open-coded check:

static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
{
        ...
        chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
        if (!(chstat & CHSTAT_EN)) {
        ...

Using the helper there would allow removing the local chstat variable and
improve consistency.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D7

