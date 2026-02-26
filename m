Return-Path: <dmaengine+bounces-9136-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NyVDEmpoGnilQQAu9opvQ
	(envelope-from <dmaengine+bounces-9136-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 21:12:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E71AEEBA
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 299AF3130FC4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE44657F9;
	Thu, 26 Feb 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="h9S+qVYj"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23435472773;
	Thu, 26 Feb 2026 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136394; cv=none; b=qBm8j0xrF/bDNqs0qMyXyZAcwNFH2YWLsmbhejDqT5aHVA5OgfWpiCzKukSNQ4SfSJnHyiJNCNK5dyFRAyOV2AEWKCdsyiD8p9C9ASNpCJv5myxfCbX5F6rUzhQNEHg11++hzBSzzBKIEwaSuq/brmWkwqREucUSqimtIkqzzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136394; c=relaxed/simple;
	bh=rbEs8dxzXbyXsx8YK4dlXjrGx2Ow+1Um/bUSwRd3lJE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=N2kTxbkAFlKN8M0QCkUYGrEvQ0eOMkYJn0gx4XidZ+UVWklsFWsEFAb9f36m8mE+GRQEzKxk7KjilNZ8vgyyTZ3XwtDo8KsPis259zOKuWj0z6JVOZSi5vSqTroOP71is4MMGr2Wpg9ON701+zWeSSM64v2FqAuZ9xzszru/gZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=h9S+qVYj; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eCF8FWWOPs/3jZyvVWyjhhPvbHufnb1Suj0O602BVrM=; b=h9S+qVYjNEMQ6kGtSE0q8TcTUh
	BGyh8q1C4GjmMVF0102QFSNsuohfUtgqn5fgkgjC9ui/Q1fvua51GzqsFnm/ZAlQkgTr4tJlJhQeK
	kA9whG67+KnM0jGqdjiEB8Yp337rBz2YegWRzyG8YrRidZ1DGR7NQw1gXoMG+Xl5h/hc2/TMJyzvM
	wxwHkkdTx39ifFTymK744ARG3V/Ct/GEZzLB811u+tVQSFUDaZ4EkKL5pCjx9Ug/y2M8PbmBruCMC
	zZ8EYCt+6dMjgL8wWjDNoI9w1k4r4WBVHsTHqcqiBpPNlFoO42qlC2E5XiFW9HwLuBcn8/9sMtWfC
	DIwEYbUw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vvhci-000PKH-1n;
	Thu, 26 Feb 2026 21:06:12 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vvhcg-0009t4-2f;
	Thu, 26 Feb 2026 21:06:11 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 20:06:07 +0000
Message-Id: <DGP5WW6SNUHY.2E1CSUTEDRM4M@folker-schwesinger.de>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
Cc: "Rahul Navale" <rahul.navale@ifm.com>, <dmaengine@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
 <suraj.gupta2@amd.com>, <thomas.gessler@brueckmann-gmbh.de>,
 <radhey.shyam.pandey@amd.com>, <tomi.valkeinen@ideasonboard.com>,
 <marex@nabladev.com>, <marex@denx.de>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Rahul Navale" <rahulnavale04@gmail.com>
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260226073512.4595-1-rahulnavale04@gmail.com>
In-Reply-To: <20260226073512.4595-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27924/Thu Feb 26 08:24:13 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9136-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,folker-schwesinger.de:mid,folker-schwesinger.de:dkim]
X-Rspamd-Queue-Id: 880E71AEEBA
X-Rspamd-Action: no action

Hi Rahul,

On Thu Feb 26, 2026 at 8:35 AM CET, Rahul Navale wrote:
> root@pdm3:~# aplay closetoyou.wav
> Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 H=
z, Stereo
>
> aplay: pcm_write:2178: write error: Interrupted system call
> root@pdm3:~# aplay closetoyou.wav root@pdm3:~# dmesg | grep xilinx_dma_de=
vice_caps
> [    0.318827] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> [    0.318832] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> [    0.319170] xilinx_dma_device_caps: caps->directions =3D 0x00000002
> [    0.319175] xilinx_dma_device_caps: caps->directions =3D 0x00000002
> [    6.375745] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> [    6.375762] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> [  133.401497] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> [  133.401513] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> [  167.802636] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> [  167.802651] xilinx_dma_device_caps: caps->directions =3D 0x00000001

Looks like direction aggregation does not actually happen in your case.
Probably because you have two distinct DMA devices with a single
channel each. Could you confirm this from your DT?

This suggests, that direction aggregation is not the actual root cause
of the regression you're seeing. Maybe 7e01511443c3 exposes/triggers
another subtle flaw in the ASoC or DMA layers or your driver. But that's
speculation at this point.

I'm not sure how to proceed from here. I think the patch itself is
functional, but it does not address the actual issue.

There's however one other thing you could test: Could you keep the RFC
patch with the printks in place, but revert 7e01511443c3, rerun and post
the logs?

