Return-Path: <dmaengine+bounces-11257-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O4S9BPJoI2rTtAEAu9opvQ
	(envelope-from <dmaengine+bounces-11257-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:25:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5564C013
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:25:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OWklmAKN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11257-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11257-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848983010539
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7E1FBEB0;
	Sat,  6 Jun 2026 00:24:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9D199385;
	Sat,  6 Jun 2026 00:24:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705498; cv=none; b=DTcw5DueFPouBkgLXAsmC2zLhNlt05N3kcptey7I3RJYsWiieHfN3uwnUmtuXQzwLWj/i5/71mhYndQuGslk+rWL1/bOnFdtfCXFtt0jS8nzcFPEdF19X8JG41OIIaQa3ISfzcGcJgF9Yw6a6rJEUDYTeE6LxTpv3blBmw9ID9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705498; c=relaxed/simple;
	bh=85a+ZMOLVUDMgdb5VnDtIHQOh00au+drbiqXiadO2+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ieAVzsPGJCxnmXEwFwNZPbxuz7OyLiw/8IL63v5DlQunszzb1kYoymZfYKOS/NUkxNEzYdteriTElCHyTrlJgQ0ivbu0YLenog90j4BF+CavRmnMN/ZtnYLTSrcm0ivk37RS8mCzg0TwIKc+/pesEwbf8jpUitwVlx3E3L/Pgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWklmAKN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5533A1F00893;
	Sat,  6 Jun 2026 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705496;
	bh=WiSEczeLurMKUEyGluvk+DuVbxIXyIC5eryA1lsi29o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWklmAKNs8BhWlRgi/ReAJ7Or8JpcCCqgxGJpFh604Cs1AGU0XOl6X2SDpfNlj+wS
	 Cg31hBRgFp0OW2IRCfkiZHE6FJm8yYQHMdp/LfHll/KO+F8X88YwhuEifRNII05D7z
	 yT1mvycc637BEy55sO4aghTqVH14MV0Mu9ePjrII5ZRkMUnCtwtJ8j8LPvgyH1zHgz
	 KJwaE4bxRqDQwW/DSnyIKOwUnI+wZFm0aYmhCSuMGZYm93gLo9nJdMAc7FJOhtY+J3
	 FRRRwTcwNikprRLUJUcISuvTzXcZBsCBtc4oq82O9UKnVm9sbibHARjwqijSdhuROs
	 eiNKaL+2+T9gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/23] dmaengine: sdxi: Attach descriptor ring state
 to contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-14-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-14-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:24:55 +0000
Message-Id: <20260606002456.5533A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,amd.com:email,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-11257-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DF5564C013

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Driver teardown frees descriptor ring state while threads may be w=
aiting, causing a use-after-free.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but hardware stalls =
lead to permanent D-state hangs in `sdxi_ring_reserve`.
--

commit 7d20c79380e3ebc097f2724f0a53221cb5571730
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Attach descriptor ring state to contexts

This commit allocates and attaches a sdxi_ring_state structure to each
sdxi_cxt upon context allocation. The ring state's lifetime is tied to
the context and is freed upon context release.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 2f9a29df5d9ce..907547ac450f2 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
[ ... ]
> @@ -63,6 +64,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  		dma_free_coherent(sdxi->dev, sq->ring_size,
>  				  sq->desc_ring, sq->ring_dma);
>  	kfree(cxt->sq);
> +	kfree(cxt->ring_state);

[Severity: High]
Does this free cause a use-after-free if threads are still waiting in
sdxi_ring_reserve()?

During teardown, contexts may be forcefully exited without stopping DMA
channels or ensuring active users have left. If sdxi_unregister() calls
sdxi_cxt_exit() -> sdxi_free_cxt(), the ring_state struct is freed.

Threads blocked in sdxi_ring_reserve() rely on the wait queue head and lock
inside this freed allocation:

drivers/dma/sdxi/ring.c:sdxi_ring_reserve() {
    wait_event(rs->wqh,
               (ret =3D sdxi_ring_try_reserve(rs, nr, resv)) !=3D -EBUSY);
}

When a sleeping task is spuriously woken up, it could dereference the freed
rs pointer, leading to memory corruption.

[Severity: High]
This is a pre-existing issue, but can hardware stalls lead to permanent
D-state hangs here?

Looking at sdxi_ring_reserve(), the uninterruptible wait_event() lacks
a timeout and ignores signals:

drivers/dma/sdxi/ring.c:sdxi_ring_reserve() {
    wait_event(rs->wqh,
               (ret =3D sdxi_ring_try_reserve(rs, nr, resv)) !=3D -EBUSY);
}

If the hardware encounters a fatal error and stops processing descriptors, =
it
will never increment the read index. Any process attempting to submit a com=
mand
will sleep indefinitely.

>  	kfree(cxt);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D14

