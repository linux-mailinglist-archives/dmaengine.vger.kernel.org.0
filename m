Return-Path: <dmaengine+bounces-12459-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7LYyKMjjVWo7uwAAu9opvQ
	(envelope-from <dmaengine+bounces-12459-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:22:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCF751CD0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:22:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GigJ0Mkr;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12459-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12459-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 075B83028666
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AAC3EC2F6;
	Tue, 14 Jul 2026 07:22:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45928643A
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 07:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013764; cv=none; b=Xcp1JfzlfrgbOyioVd1qz+9+Rb59iVVs1QH2JvmgM1SN9vBmbA9/8rWHFzMAGtnenU70RjwuIX9zPVjpsT9Nw7uaZX47nCzFbXeJQaq6PpbHZtnU1mnaenEM5g/amUrR5EGQS2L53sMTvJpsfMgm+dXYuGmucyaZFfOhn6hA3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013764; c=relaxed/simple;
	bh=G1rmEB7n78BtoIjhDECShH2vk3lnDwLctfNC8yfZRlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PHFY2+FQ7H7oxUfGrQLV8tpFu4ixLLhQ59eKufhbe68oz4G3rxoPkSQq4rvmFgiDj3VmwobXXO5fFe6UD36bvQeceCcwC6hAUT9kVcAR/GGMG3j8ScBRnmPkVBnrU8LPvraqAvErqMWpND1Vtyev8dh2XGD/A9Cj5tlg0jnEaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GigJ0Mkr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE7D1F000E9;
	Tue, 14 Jul 2026 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784013762;
	bh=kdHP1MVkuDIYMrWRGS7wnCNcPPB3a060BbbgUB/5Lus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GigJ0MkrPqRM5Mh60mQSDk5WyN0uyZ9SLBCDdiMG0lVVcG5n3w3vgF+E5XxSsRgds
	 aobiqXmXLfqVlaBxi98X9pwteEOj1ivfBEC++k2WgSQ9726ypP9sO/+5YTUobrqtxH
	 sV+B9EOFd9d86ivVan518L0OwUuYaKOP7cTEB4aAk5jUx383c9ulvYDOX9KEnPUfQI
	 x30LC9MQVjkSUFj9+zK8oKmitGJI6hTtwb0gpfB3hw8yjj2mu+u0NYrc/sAN76lB+e
	 WmuA41OXGchQYGCNtAxnq9Sy3tLhRA3ic5VzG+iovo8ZctCWmC/bXsGoH0pevRoKs4
	 t2w4kZPYdBtyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] dmaengine: xilinx_dma: Move descriptors to done
 list based on completion bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713072146.45269-3-srinivas.neeli@amd.com>
References: <20260713072146.45269-1-srinivas.neeli@amd.com>
 <20260713072146.45269-3-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:22:42 +0000
Message-Id: <20260714072242.ACE7D1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12459-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2CCF751CD0

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditionally setting `chan->idle =3D true` after an early loop =
break causes the driver to incorrectly assume the DMA hardware has stopped,=
 leading to channel corruption.
- [High] Missing read memory barrier (`dma_rmb()`) after polling the DMA de=
scriptor completion bit from coherent memory.

Pre-existing issues:
- [High] MCDMA delay interrupt does not complete descriptors, causing descr=
iptors stranded on `active_list` to hang indefinitely.
--

--- Patch [2]: [PATCH v4 2/4] dmaengine: xilinx_dma: Move descriptors to do=
ne list based on completion bit ---
commit 8891a603d60f283d523f7e4fb993dc400bd9bd8e
Author: Srinivas Neeli <srinivas.neeli@amd.com>
Subject: dmaengine: xilinx_dma: Move descriptors to done list based on comp=
letion bit

This commit modifies the MCDMA completion logic to check the descriptor
completion bit before moving entries from the active list to the done list.
This addresses an issue where interrupt coalescing could cause descriptors
to be reported as completed prematurely.

> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 965fb69a2a3ad..9b8b6f1acd4ea 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1773,6 +1773,17 @@ static void xilinx_dma_complete_descriptor(struct =
xilinx_dma_chan *chan)
>  					      struct xilinx_axidma_tx_segment, node);
>  			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
>  				break;
> +		} else if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIMCDMA) {
> +			struct xilinx_aximcdma_tx_segment *seg;
> +			u32 status;
> +
> +			seg =3D list_last_entry(&desc->segments,
> +					      struct xilinx_aximcdma_tx_segment,
> +					      node);
> +			status =3D (chan->direction =3D=3D DMA_DEV_TO_MEM) ?
> +				seg->hw.s2mm_status : seg->hw.mm2s_status;
> +			if (!(status & XILINX_DMA_BD_COMP_MASK))
> +				break;

[Severity: High]
Does this code need a read memory barrier (dma_rmb()) here?

Since the status is read from coherent memory, weakly-ordered CPU
architectures might speculatively reorder the reads of the segment payloads
and status fields to occur before the completion bit check resolves. This
could lead to reading stale, pre-transfer data from the descriptor or the
actual DMA buffer, causing incorrect residue reporting or corrupted network
packets.

[Severity: High]
Also, when this breaks early, unfinished descriptors are left in active_lis=
t.
Will this cause a DMA channel hang? Looking at xilinx_mcdma_irq_handler():

xilinx_mcdma_irq_handler() {
    ...
    if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
        spin_lock(&chan->lock);
        xilinx_dma_complete_descriptor(chan);
        chan->idle =3D true;
        chan->start_transfer(chan);
        spin_unlock(&chan->lock);
    }
    ...
}

The interrupt handler unconditionally sets chan->idle =3D true and calls
chan->start_transfer(), even if active descriptors are still running due to
the early break.

Since chan->idle is true, start_transfer() attempts to program the CDESC
and TDESC registers with new, unlinked descriptors from pending_list while
the hardware is actively processing active_list, which seems invalid and
likely to cause a complete hardware desynchronization.

[Severity: High]
This is a pre-existing issue, but this patch highlights a fatal flaw for sm=
all
transfers. Unlike the standard AXI DMA handler, xilinx_mcdma_irq_handler() =
does
not invoke xilinx_dma_complete_descriptor() on a delay interrupt:

xilinx_mcdma_irq_handler() {
    ...
    if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
        /*
         * Device takes too long to do the transfer when user requires
         * responsiveness.
         */
        dev_dbg(chan->dev, "Inter-packet latency too long\n");
    }
    ...
}

If the number of submitted descriptors is below the interrupt coalescing
threshold, the hardware triggers a delay interrupt instead of an IOC interr=
upt.
Since the delay interrupt doesn't complete descriptors, trailing segments w=
ill
remain stranded in active_list indefinitely because they are never processe=
d,
causing a channel hang.

>  		}
>  		if (chan->has_sg && chan->xdev->dma_config->dmatype !=3D
>  		    XDMA_TYPE_VDMA)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713072146.4526=
9-1-srinivas.neeli@amd.com?part=3D2

