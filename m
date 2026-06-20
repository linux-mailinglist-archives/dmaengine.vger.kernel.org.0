Return-Path: <dmaengine+bounces-11669-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ygfOlfKNmrCEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11669-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:13:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E54976A955A
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:13:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mudhcx1Q;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11669-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11669-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2196F30046AD
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459F23E324;
	Sat, 20 Jun 2026 17:13:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A3233932
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:13:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975634; cv=none; b=DqQRc1CZ6O5vrRUKeJnPyUxhMAhM6X+iZLi9T/KQb5b1vfTc3tfdBSlVmrukQ4einjw0AQq2waNICIZDAp9Sk9q9tcuYvwSpaP58i+XgTSYSmVpS2NvzTX9z8EmA/D6I0B4eT1BMkpyXAFMi52t4G63fi6itAn9jd0inKANgHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975634; c=relaxed/simple;
	bh=4BYYG98ku5mojrH4sicICXijOZScjUeji3Qodjlb7Y4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OHalRJZEpFEAUo6u+BppcfUNW/qMPAX+jWFbWxWlpbbaawPm7yXcPH2di4wjJ6Ug3/gp0BIK5/XHRbnuL9dUWSmxULvFgyEKgHX+M9rH/YbdilljlIMTxdLbUAwN0CHCgk5lX5A/oPYo7Z1dSGREaFOwaKRArgtb+lSoPwdVj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mudhcx1Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436AE1F000E9;
	Sat, 20 Jun 2026 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975633;
	bh=snEN5SU3E6Lk5hDleRdXbZrrzS8qsOvRAp7IBmFIdpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mudhcx1QOJdsuqW/ilVdLX0sYYzcExt+ervJMtTqA5gro5v0XZefSzqu07MdXKRKq
	 q/zXhP9Fk/I6IloKbkvvjMb7dXcN06ktd/aon4CybgCbaqF4Z3NbsqEFlqhaB50d1p
	 H83Y7hlGTO2eih8V1lakj4VrjBp6C0WjobluiBF7FoYOW6aenrgMLROaXrNJ8rWRHq
	 Dh+TUG2YadZ/mVVcPWtQUk9qH6VhfxLww818Wr5Jh1K5gRX55F2dmiMIbMqUDv4hrQ
	 t/vfHn+mpXmRkLYXb9VNnInZeBLhoWGv1fE6uAcR77+Hp7P0XtX+i3yJhSJT+nOXMx
	 CJRxP7cqc9DJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/13] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260620170040.3756043-2-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:13:52 +0000
Message-Id: <20260620171353.436AE1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11669-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,valinux.co.jp:email,lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E54976A955A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] V0 eDMA fails to set the Remote Interrupt Enable (RIE) bit for rem=
ote-routed channels on a local endpoint controller.
--

commit df5a2947e52cc02cfc126b63bc365277ac3752fa
Author: Koichiro Den <den@valinux.co.jp>
dmaengine: dw-edma: Add per-channel interrupt routing control

This commit adds per-channel interrupt routing control to the DesignWare
eDMA driver, allowing channels to route completion signals locally or
remotely. It updates the v0 eDMA and HDMA paths to configure interrupt masks
and generation based on the selected mode.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
[ ... ]
> @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edm=
a_chunk *chunk)
>  		j--;
>  		if (!j) {
>  			control |=3D DW_EDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> +			    chan->irq_mode !=3D DW_EDMA_CH_IRQ_LOCAL)
>  				control |=3D DW_EDMA_V0_RIE;
>  		}

[Severity: High]
When a local endpoint controller delegates a channel to a remote host, the
irq_mode is set to DW_EDMA_CH_IRQ_REMOTE, but DW_EDMA_CHIP_LOCAL is also
present in the chip flags.

Because the check in dw_edma_v0_core_write_chunk() explicitly requires that
DW_EDMA_CHIP_LOCAL is not present, the first condition evaluates to false
and DW_EDMA_V0_RIE is never set.

According to the commit message, requesting a remote-only interrupt requires
setting both LIE and RIE while masking the local interrupt. Since
dw_edma_v0_core_start() correctly masks the local interrupt for these
channels, does this prevent the DMA completion event from being sent
entirely, potentially causing the remote host to wait forever?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D1

