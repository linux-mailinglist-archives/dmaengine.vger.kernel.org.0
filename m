Return-Path: <dmaengine+bounces-12006-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cDS+AOLZRmpmegsAu9opvQ
	(envelope-from <dmaengine+bounces-12006-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:36:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80126FCFDC
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:36:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kAvhhaUm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12006-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12006-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73F50300E17C
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF503890FC;
	Thu,  2 Jul 2026 21:36:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E2353A86;
	Thu,  2 Jul 2026 21:36:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028188; cv=none; b=gJldB4Zdr8FWMHpYN6wT/UNQNKXdCbBsp1v0BY4eiyVFhuHXT9Jw2X0u01/ocQu1oJozRhoEbYDcTORyhshZs0ExjTX6KHQesdqpm557NSc+zloKDea7zF9T4IaOTdWztFvTIKcEpuaZuf1n1nBuV4TtizMjZufhG98Qj2vs4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028188; c=relaxed/simple;
	bh=BhPVnK9QdIKo3G+Y/KKEFfp/HcgPgBsGXjYfEkeNd+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3IE4PrNwQRPFc35stdjich4v29p30O34PIK17idWRqfpreXPZoTUbNEFNSmAZUtlucnjv9Tyw4Xy/7G4twIS/XWjoLewypk4uWwZ9Tz4rJFEdaM6la+T1WpZ4JzyWdixqRadKPbs8yuyoFT4PpcFR7pvaammayEyG7tWRUauRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAvhhaUm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968BC1F000E9;
	Thu,  2 Jul 2026 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028186;
	bh=x9xLxt16KaWmv4YSNxHIt5MqRLbZk2k/2yQ/9yq7dA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAvhhaUmquKRzYSIH6ua0PaLVz9s5jQ/zpUSmA7mKrgHVbdGIGxL+NY7bogOWdNEN
	 HzB5t98j/khFSbz79j8/jkQdDZSjxqrp3daJVPLCC6i9MgjktsTjDIlfxVksdwMTQf
	 SS8Gh9sdZ7ou7/wIo9FtceuIIotZ1OR8o/BIjsaw6AnAtXl4eYnbCi6NDMnjWUIDin
	 UZQNDKbV4QOw8V1gHzwlQtzYweGi0QP+OEBY6Ah5DvmbTwMNhWmurx1AmHdu+6ed+x
	 DwZkvUqtLwcgXDO32TKwKyuB6RsoKnRxJWSXRFv8AZCNEO8CLgwzO2Ojv5t0G5wmP5
	 DFjgRQ3vsma5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] dmaengine: dw-edma: Add non_ll_start()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260702-edma_ll-v3-7-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-7-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:36:25 +0000
Message-Id: <20260702213626.968BC1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12006-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,nxp.com:email,smtp.kernel.org:mid,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C80126FCFDC

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless channel state modification and list manipulation in dmaen=
gine callbacks.
--

commit 962243519d7014f0b711fe65a08901734b5c7e22
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add non_ll_start() callback

This commit adds a non_ll_start() callback and moves the common
non-linked-list channel handling into the EDMA core so it can be shared
by both the EDMA and HDMA.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index bab4d49c92feb..e18d6e827c2c9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h

[ ... ]

> @@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, =
enum dw_edma_dir dir,
>  static inline
>  void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk,=
 bool first)
>  {
> -	dw->core->start(chunk, first);
> +	if (chunk->chan->non_ll) {
> +		struct dw_edma_burst *child;
> +
> +		child =3D list_first_entry_or_null(&chunk->burst->list,
> +						 struct dw_edma_burst, list);
> +		if (child)
> +			dw->core->non_ll_start(chunk->chan, child);
> +	} else {
> +		dw->core->start(chunk, first);
> +	}
>  }

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_resume() modify
channel state and invoke dw_edma_start_transfer() locklessly?

Looking at drivers/dma/dw-edma/dw-edma-core.c, if a client driver invokes
dmaengine_resume() (which calls dw_edma_device_resume()) concurrently with
the channel's interrupt handler dw_edma_done_interrupt() or dmaengine_submi=
t(),
dw_edma_device_resume() modifies chan->status and calls
dw_edma_start_transfer() without acquiring chan->vc.lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
    chan->status =3D EDMA_ST_BUSY;
    dw_edma_start_transfer(chan);
    ...
}

Meanwhile, dw_edma_done_interrupt() and dw_edma_device_issue_pending()
execute dw_edma_start_transfer() with chan->vc.lock held.

If dw_edma_device_resume() and dw_edma_done_interrupt() run concurrently,
both can invoke dw_edma_start_transfer() on the same channel, read the same
descriptor via vchan_next_desc(&chan->vc), and perform state modifications =
on
it:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_start_transfer() {
    ...
    vd =3D vchan_next_desc(&chan->vc);
    ...
    list_del(&child->list);
    kfree(child);
    ...
}

Could this sequence lead to a double-free and list corruption?

Other functions like dw_edma_device_pause() and dw_edma_device_terminate_al=
l()
appear to similarly manipulate channel state locklessly:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_pause() {
    ...
    chan->request =3D EDMA_REQ_PAUSE;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D7

