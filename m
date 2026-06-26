Return-Path: <dmaengine+bounces-11811-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gP/RJO5KPmodCwkAu9opvQ
	(envelope-from <dmaengine+bounces-11811-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:48:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E636CBD14
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:48:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GIZPxOnL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11811-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11811-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B475E3014DA9
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578826ED41;
	Fri, 26 Jun 2026 09:48:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842D4315F
	for <dmaengine@vger.kernel.org>; Fri, 26 Jun 2026 09:48:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467308; cv=none; b=A+Z6rzuBs7aivq0wSdy4AEZrdNqJ3HHb5zTVBxBf3KXOeXvFDNbWYnNRL5Ni8TBj93PB+9/N6v1HONptF8px+SViFsDE8MKgsDQx5Xboh/9IW1PmTeC8g5fN9WeZhs3NL2DH9Q+CEpc1HGsUaYm7C334jpNu9qId3G7agrHprDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467308; c=relaxed/simple;
	bh=rseBiIRtpD22WsIiWHbvpbqGHlyuKJr04/P9SbjF9Ao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CqLkzZb+ewgJvvwhbDISlOWG2S5uQy3UxEIYzp4RjNwnRT+Yx5opGbWnAmXlVc8gfVR7lqci9s0xvaIz4c40BGerP0DTjrK/0mepQ49aaruks637dHjLB2YJyrwB5T4wuamKalrbBIMXrRsJrIbq65xvtDTjn8/brayzfvH9RtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIZPxOnL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF8A1F000E9;
	Fri, 26 Jun 2026 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782467306;
	bh=qovKJw9Z4J0HVxgmTkZb6FbpRGJk2rdGKEr10jHxLUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GIZPxOnLV9UG8ZihbKRBjsbBSUUlKXM6/Pgz0a+oTKIRVEGQCnG8aRrneZLyDU8Pd
	 XEnHn9o4OyVUXnieduIUyPEuwvGCOns+4IOvLBSi8H5IHQDDW9qS/kPyEi+7xX8KHn
	 w11j8W2k8MbuiuTaBe1YPGJuaDJOAczv4wq1V5rANp0YhcioO4HEKCyS8YUrnBasTj
	 H7WtspXZEa8+QxZ0dNUpA3k18++lIKeDGzndxHWzLBpGsgytskzwVfgCc0NEMmr9Rd
	 X+IXu9+MaBdVMCfEXIPTn7WWH62zrCW0EXpLtzPl49gj5Yjp4cAFGnqZewwlW25IgZ
	 rO46EzV9MT3eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] dmaengine: xilinx_dma: Enable transfer chaining
 for AXIDMA and MCDMA by removing idle restriction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suraj Gupta" <suraj.gupta2@amd.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260626092656.1563871-3-suraj.gupta2@amd.com>
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
 <20260626092656.1563871-3-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:48:25 +0000
Message-Id: <20260626094826.3CF8A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11811-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3E636CBD14

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Bypassing the idle check allows new descriptors to be appended=
 to a running transfer, but the driver fails to link the active transfer's =
hardware `next_desc` pointer to the newly appended descriptors, leading to =
wild DMA fetches.
- [High] Overwriting the DMA Coalesce Threshold register while a channel is=
 running resets the hardware coalescing counter, causing the channel to sta=
ll indefinitely.
--

commit 06494ab31953d1c39c050abca192d725ee06375d
Author: Suraj Gupta <suraj.gupta2@amd.com>

dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA by rem=
oving idle restriction

This commit relaxes the idle checks in xilinx_dma_start_transfer() and
xilinx_mcdma_start_transfer() to allow scatter-gather transfers to be chain=
ed
onto an in-flight transfer. It relies on the hardware tail pointer extension
mechanism to handle chaining automatically.

> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index ca396b7097427..6e7b183cb4994 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1580,7 +1580,14 @@ static void xilinx_dma_start_transfer(struct xilin=
x_dma_chan *chan)
>  		return;
>  	}
> =20
> -	if (!chan->idle)
> +	/*
> +	 * Direct (non-SG) mode has no descriptor queue: writing the BTT
> +	 * register launches a transfer immediately, so a new transfer must
> +	 * not be programmed while one is in flight. Keep such transfers
> +	 * serialized. SG mode supports chaining onto a running transfer via
> +	 * tail-pointer extension, so it is allowed to proceed when busy.
> +	 */
> +	if (!chan->has_sg && !chan->idle)
>  		return;

[Severity: Critical]
Does bypassing this idle check for SG mode result in wild DMA fetches when =
a new
transfer is queued on a busy channel?

If a new transfer is queued while the channel is busy, the pending_list will
be empty when processed by append_desc_queue():

drivers/dma/xilinx/xilinx_dma.c:append_desc_queue() {
    ...
    if (list_empty(&chan->pending_list))
        goto append;
    ...
}

Because of this, append_desc_queue() explicitly skips hardware chaining ent=
irely
and fails to link the active transfer's tail descriptor to the newly submit=
ted
descriptor.

Since out-of-order frees can scramble the ring at runtime, won't the hardwa=
re
finish the active transfer and follow a stale next_desc pointer to an unrel=
ated,
uninitialized, or freed descriptor segment?

[ ... ]
> @@ -1599,7 +1606,7 @@ static void xilinx_dma_start_transfer(struct xilinx=
_dma_chan *chan)
>  		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  	}
> =20
> -	if (chan->has_sg)
> +	if (chan->has_sg && list_empty(&chan->active_list))
>  		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>  			     head_desc->async_tx.phys);
>  	reg  &=3D ~XILINX_DMA_CR_DELAY_MAX;

[Severity: High]
Does updating the Coalesce Threshold register while a channel is running st=
all
the channel indefinitely?

Just before this CURDESC check in xilinx_dma_start_transfer(), the threshold
is updated:

    if (chan->desc_pendingcount <=3D XILINX_DMA_COALESCE_MAX) {
        reg &=3D ~XILINX_DMA_CR_COALESCE_MAX;
        reg |=3D chan->desc_pendingcount <<
                  XILINX_DMA_CR_COALESCE_SHIFT;
    }
    ...
    dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
   =20
According to the Xilinx AXI DMA specification (PG021), writing this thresho=
ld
automatically resets the hardware coalescing counter to zero.

If there are already active transfers running, writing the new threshold wi=
ll
reset the counter. As a result, the total number of remaining transfers
(active + pending) will no longer align with the new threshold multiple. The
hardware will finish the transfers and stop with a counter value strictly b=
elow
the threshold, never triggering the completion interrupt.

[ ... ]
> @@ -1685,8 +1689,9 @@ static void xilinx_mcdma_start_transfer(struct xili=
nx_dma_chan *chan)
>  	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
> =20
>  	/* Program current descriptor */
> -	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> -		     head_desc->async_tx.phys);
> +	if (chan->has_sg && list_empty(&chan->active_list))
> +		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> +			     head_desc->async_tx.phys);
> =20
>  	/* Program channel enable register */
>  	reg =3D dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);

[Severity: High]
This appears to introduce the same coalescing regression as seen in
xilinx_dma_start_transfer().

Earlier in xilinx_mcdma_start_transfer(), the CR register is overwritten
with the new pending count:

    if (chan->desc_pendingcount <=3D XILINX_MCDMA_COALESCE_MAX) {
        reg &=3D ~XILINX_MCDMA_COALESCE_MASK;
        reg |=3D chan->desc_pendingcount <<
            XILINX_MCDMA_COALESCE_SHIFT;
    }
    ...
    dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
   =20
Won't this similarly reset the MCDMA hardware coalescing counter while the
channel is active, causing it to stall indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626092656.1563=
871-1-suraj.gupta2@amd.com?part=3D2

