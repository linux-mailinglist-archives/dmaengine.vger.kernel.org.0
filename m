Return-Path: <dmaengine+bounces-12340-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K5TyCCQnUWp4AAMAu9opvQ
	(envelope-from <dmaengine+bounces-12340-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:08:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4E73CEB5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:08:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fAQh0l53;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12340-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12340-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D381730568A3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406E943B4B1;
	Fri, 10 Jul 2026 17:04:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C21E520A;
	Fri, 10 Jul 2026 17:04:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703098; cv=none; b=HPiF8DkI5Pyhbyh4/enZnihTGv+zz/ccT3Mj6eJ3uubHcoT78tcBA4jXP5hf6HL2xfDVe54k+QwfXK0e4WQgRP2qDkW+/acCGKIQzHrlSasWcim5B+v4VCpaYfcR9j/mO1toR6nwA79M6HQB3+8clIDBhHstrzJrcScVixwAeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703098; c=relaxed/simple;
	bh=aOPA+2rzJc6k1emTSPQ+VoCQjfaDjTlUvZt85TIs3mY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n9tfTgd8C1pDXeS+eikz0L0JTRqK6L8k/4Z+fm2HrxnxPWJwy/dBrsjLIQEOgxpV1P7Aqv3VbA+2oDgM4X/wYZgMm8AHDsWd8pM2jZI5owt3jFkWYrl0hhr2B+H/o5VbWOtor7y5OJBf890zAuwItCQ/cmksxsgWG0DXSjvQuYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAQh0l53; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A311F000E9;
	Fri, 10 Jul 2026 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703096;
	bh=WXFEkMBaj5uYqqz5N3kzEHRbkVDV0azWEzJtjkfcMPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAQh0l53CFAA0JqzB+63j5U6Tb85uerusYGx3J3NTFs3VqmOTxNi4HWdb0Dbz0EF/
	 dGlqXTab89gv07Man+RtVYvNI07HPxLIlddSiIGlRwHSywhmE/jCw8J6GHuQjfNwhP
	 +UtvbLpFk1aPgeaz/ahYQ3/WsXr9Vu2SvAFjLK+l8wGoaaUOnGqyqRUD4dy2JxB8D/
	 SzhUej8FDvKQL0r1Y3b3EvmBhDBduPiL7j+RrhcpDiXWC9L2au2FUutuD/e3Lfx3/6
	 d1obrIm5v4VPmAW3oTTJyu/y7aczgGb5ATqAzSWdbZdK5MVTtvVYWyU5sVSAkTLT3t
	 e596AxqGveYxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] dmaengine: dw-edma: Add non_ll_start()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260710-edma_ll-v6-7-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-7-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:04:55 +0000
Message-Id: <20260710170455.A9A311F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12340-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,nxp.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADF4E73CEB5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The DMA engine control callbacks (dw_edma_device_resume, dw_edma_d=
evice_pause, and dw_edma_device_terminate_all) modify channel state lockles=
sly and perform unsafe virt-dma list operations without holding the require=
d virtual channel lock.
--

--- Patch [7]: [PATCH v6 07/10] dmaengine: dw-edma: Add non_ll_start() call=
back ---
commit 659e1f56ed5af4e60c5ded05c2fdc117d6a334f9
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add non_ll_start() callback

Add a non_ll_start() callback and move the common non-linked-list channel
handling into the EDMA core so it can be shared by both the EDMA and HDMA.
Prepare for the upcoming reorganization of the burst and chunk structures.

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
This is a pre-existing issue, but while refactoring the start routines, are
there some missing virt-dma lock protections in the broader EDMA core?

For instance, in drivers/dma/dw-edma/dw-edma-core.c, dw_edma_device_resume()
seems to call dw_edma_start_transfer() without holding the virtual channel
lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
    chan->status =3D EDMA_ST_BUSY;
    dw_edma_start_transfer(chan);
    ...
}

Because dw_edma_start_transfer() pops elements via vchan_next_desc(), could
this lead to list corruption on the virt-dma list when a client driver resu=
mes
the engine?

Similarly, does dw_edma_device_pause() modify the channel request state
locklessly?

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_pause() {
    ...
    } else {
        chan->request =3D EDMA_REQ_PAUSE;
    }
    ...
}

Could this cause a data race with the interrupt handler
dw_edma_done_interrupt() which runs concurrently?

Finally, in dw_edma_device_terminate_all() the state is also updated
locklessly:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
    ...
    } else {
        chan->request =3D EDMA_REQ_STOP;
    }
    ...
}

Does this fail to call vchan_get_all_descriptors() to clean up pending
virt-dma lists? Could this cause descriptors to leak or mistakenly execute
later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D7

