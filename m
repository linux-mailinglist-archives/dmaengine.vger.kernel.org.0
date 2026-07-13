Return-Path: <dmaengine+bounces-12417-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7BpkE6AeVWq+kAAAu9opvQ
	(envelope-from <dmaengine+bounces-12417-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:21:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4A74DF71
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:21:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EkzObDg4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12417-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12417-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF52F30779D6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBD2773DE;
	Mon, 13 Jul 2026 17:17:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB496274658;
	Mon, 13 Jul 2026 17:17:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963027; cv=none; b=pcqF7FIL9ty+Milv+5a0FQyD/nxw+uDCr6D7duvZIouT0sHeGBY8zghBVdv1FqxeCKmgnW4rgnKrvEKcuGeuwuIEeyrm5xdVqtJgUEq80roEfa6UE7FLmvGUB/9IdO7F5wbnkYKYvakbgwxUyaYMZ5UFiAEUeNOcxw8FbIXzwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963027; c=relaxed/simple;
	bh=s28AuOkjvL/i/HLAAPcBiO0lo7VFWcfVu4n7H8RvWEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X81di3B05lPmD4W6s+hqUXIvKMSlYYJ3Arxg2YFo84uDAE0KybYl6Yx8vjJQxqDRePFGhi/DGPoOCJUCfOKt1b1RzPe1M71r4vai0zE+O/WFnrNWBdz7BY5JV/88c3CRC0tsJUWI+Rx58dM7H0wN15ZvadnsFSs0+a6rvVhA5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkzObDg4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90E71F00A3F;
	Mon, 13 Jul 2026 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963025;
	bh=SVjSsyjKWmruGaWb6WysXjlU9sgpPQ4o3YxHOnQG0BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkzObDg4BbgBWICgis6MyX684zpNmQYy6RQJoeA2HizLaRheeeu/f+OEaaM9pB1wr
	 PPvlcSs9z1rmcQ4EYsKYNlcwenkV9bVwyWfcKxPttgQtDhSS5UQgGXzR9OdAfr6hhm
	 lATzuS0xUB0SGAFK6RQcxIDzj6u2QZa5/TfrwkzY/2xwvnX+vpdIz7P1yHV266Hfo2
	 hGyCt7iUdG/uCpm7Ajzb3pAA5ER08jKKT1xkag4NFtRD72c8+Z5cFvJb74OaDQGfwn
	 oTlbFtYmYXLorCQPflaf+0JL7hnwjhk809Jf9gD6bM88afQllbkl1R9lXwhh0ftGhp
	 okVqmM9EGcvQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] dmaengine: dw-edma: Add xfer_sz field to
 struct dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260713-edma_ll-v7-2-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-2-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:17:04 +0000
Message-Id: <20260713171704.C90E71F00A3F@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12417-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91C4A74DF71

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The dmaengine API functions `dw_edma_device_resume`, `dw_edma_devi=
ce_pause`, and `dw_edma_device_terminate_all` modify shared channel state a=
nd process descriptor lists without holding the `chan->vc.lock`.
- [High] The driver improperly handles `DMA_CYCLIC` transfers by treating t=
hem as finite transfers that complete after `cnt` periods, rather than runn=
ing continuously. It calls `vchan_cookie_complete()` instead of `vchan_cycl=
ic_callback()`, causing the transfer to terminate and the descriptor to be =
freed.
- [High] The `dw_edma_device_terminate_all()` function fails to remove and =
free pending descriptors from the virt-dma queues. It only sets a state fla=
g (`EDMA_REQ_STOP`) for the active transfer without flushing the `desc_subm=
itted` or `desc_issued` lists.
--

--- Patch [2]: [PATCH v7 02/10] dmaengine: dw-edma: Add xfer_sz field to st=
ruct dw_edma_chunk ---
commit 1deb608bf55aafc03752bddfec980c583d0db45e
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk

This commit adds a new xfer_sz field to struct dw_edma_chunk to explicitly
track the total transfer size. It replaces the misleading use of
ll_region.sz, which represents the memory size of the EDMA link list rather
than the data payload. The core start and setup functions are updated to
use this new field to correctly calculate transfer sizes.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 1fec1b52e3d47..53469c8c8b82e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan=
 *chan)
>  		return 0;
> =20
>  	dw_edma_core_start(dw, child, !desc->xfer_sz);
> -	desc->xfer_sz +=3D child->ll_region.sz;
> +	desc->xfer_sz +=3D child->xfer_sz;

[Severity: High]
This is a pre-existing issue, but since dw_edma_start_transfer() is being
modified here, is it safe to call this function without holding
chan->vc.lock?

When a client driver calls dmaengine_resume(), it invokes
dw_edma_device_resume(), which directly calls dw_edma_start_transfer()
without acquiring the lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
        ...
        chan->status =3D EDMA_ST_BUSY;
        dw_edma_start_transfer(chan);
        ...
}

Inside dw_edma_start_transfer(), vchan_next_desc() is called, which has a
strict lockdep_assert_held(&vc->lock) requirement. Since
dw_edma_device_pause() and dw_edma_device_terminate_all() also modify
shared channel state without the lock, could this lead to list corruption
or use-after-free when competing with the hardirq handler
(dw_edma_done_interrupt) that does hold the lock?

>  	dw_edma_free_burst(child);
>  	list_del(&child->list);

[ ... ]

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_terminate_all()
leave stale descriptors in the virt-dma queues?

When termination happens, the driver sets a state flag but skips flushing
the lists:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
        ...
        } else if (chan->status =3D=3D EDMA_ST_PAUSE) {
                chan->request =3D EDMA_REQ_STOP;
        }
        ...
}

Without calling vchan_get_all_descriptors() and vchan_dma_desc_free_list(),
if a client calls dmaengine_terminate_all() while descriptors are pending
and then reuses the channel, will those old descriptors be erroneously
executed and cause data corruption?

[Severity: High]
This is a pre-existing issue, but does the DMA_CYCLIC implementation
correctly support continuous hardware looping?

In dw_edma_device_prep_dma_cyclic(), the driver blindly accepts the cyclic
request and sets a finite count:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_prep_dma_cyclic() {
        ...
        xfer.xfer.cyclic.cnt =3D count;
        ...
}

Later, the interrupt handler completes the descriptor instead of
triggering periodic callbacks:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_done_interrupt() {
        ...
                        list_del(&vd->node);
                        vchan_cookie_complete(vd);
        ...
}

Should the interrupt handler call vchan_cyclic_callback(vd) so that
continuous audio or capture buffers don't incorrectly halt after the
initial count iterations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D2

