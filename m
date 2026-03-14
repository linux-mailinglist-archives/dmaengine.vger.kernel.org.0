Return-Path: <dmaengine+bounces-9429-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL+YEEUhtWlZwwAAu9opvQ
	(envelope-from <dmaengine+bounces-9429-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 09:50:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B394928C38F
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 09:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A25963034793
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BED145B3F;
	Sat, 14 Mar 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="KIZvlHTY"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58457404E;
	Sat, 14 Mar 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773478210; cv=none; b=bxYGs4vaZ1WIpwR7g/rv90HDTpGW1Oa3RCAqO63frvFVqBEk2UOknik1/y4mtFCsX2xRgM6l3H644Ox07pCgZzBd5Lgz4vuaaQQj9Vwf3OrOfv1qZgVOK4Iuy1vzoskcg1b2bF1MTIpwsXthKy3954pLe0tjJr55b1u+9iqEiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773478210; c=relaxed/simple;
	bh=gOV8i4wDTFL+qKOfuVbKsKCJgT89u5M5X7x8Zm9y+Vc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=jwh5RsUhRJFbWFN5RE38pgJ6AWT/HnHa9bew+t+ApFawFLgdCk4GXBHG8ZZTilrDF/jC20+GpesFPE36QnHKhTshGqxSvb479mWCO0heDqj91qMcbUv+5injU6beLj3v5AS97WlGkx80njkB1A2xUGKIpfPFJsUrK4FxrVYl928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=KIZvlHTY; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YgHcLh85D6RIwPnhEQeV8kJ5EKZn7RVlARTM/mjlfW0=; b=KIZvlHTYTuLBuzJS5wB/91kZ/9
	9EL+MVOeirSz2hFFikWkmWzT2Y2SmzvMMBSC42pzy4Hb93lMF2dSK+yAuJywsKJeCwDFfaP/gAKnH
	SW3QuwJy+qSfjxTm579/DH7fdhKelpnI9WlFI0MzFSASm9WSSmi6sjytsRz6Cyhmi8UXz4/DO0BA8
	mQ5vA4TvS2IWpMNxxgK6ZWlykePOl/QmkzqiBHWY6Sl+C1QuTlAy+9P3x6AYXURHrxQNpYn5vkzYN
	zcl3wEzOB4HdkcVLX1EBUDRXQj5giMujhxT9KKh2D9K0XdeYh+TeLaEQpD0I0YEUkEX1lqk4KP2od
	ES2XfWpw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1w1KTD-000GQP-1T;
	Sat, 14 Mar 2026 09:35:39 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1w1KTB-0000Qo-0t;
	Sat, 14 Mar 2026 09:35:38 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 08:35:35 +0000
Message-Id: <DH2D8WNRXPUD.1205964NAEFPF@folker-schwesinger.de>
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
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260309072822.5016-1-rahulnavale04@gmail.com>
In-Reply-To: <20260309072822.5016-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27940/Sat Mar 14 07:24:47 2026)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9429-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,folker-schwesinger.de:dkim,folker-schwesinger.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pdm3:email]
X-Rspamd-Queue-Id: B394928C38F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 9, 2026 at 8:28 AM CET, Rahul Navale wrote:
> I have applied provided patch (with kept RFC patch and debug stuff) and w=
ith
> 7e01511443c3 applied. logs:
>
> root@pdm3:~# dmesg | grep ptr_res
> [  198.997591] ptr_res: ptr =3D 0x00000000
> ...
> [  199.242820] ptr_res: ptr =3D 0x00000000
>
> Also I have applied provided patch (with kept RFC patch and debug stuff) =
and with
> 7e01511443c3 reverted. logs:
>
> root@pdm3:~# dmesg | grep ptr_res
> [   60.480754] ptr_res_no: ptr =3D 0x00000000
> ...
> [   60.600877] ptr_res_no: ptr =3D 0x00001770
> ...
> [   60.725869] ptr_res_no: ptr =3D 0x00002ee0
> ...
> [   60.850877] ptr_res_no: ptr =3D 0x00000000
> ...
> [   60.975869] ptr_res_no: ptr =3D 0x00001770
> ...

This confirms that the residue_granularity field in dma_slave_caps,
which gets properly set since 7e01511443c3 affects progress tracking in
the PCM DMAEngine layer. Since Xilinx DMA advertises residue reporting
with segment granularity [1], PCM DMAEngine switches from software based
[2][3] progress tracking to hardware based progress tracking [4].
From my understanding however, residue reporting of the Xilinx DMA is
incompatible with what the PCM DMAEngine expects. So the progression
pointer is stuck at 0.

As I'm neither an expert in the PCM subsystem nor very familiar with
residue reporting of the AXIDMA (and its limitations), I can't propose a
solution that fixes the issue for you. I did a quick check of the code to
see, if there is any way to force the DMAEngine PCM layer into software
tracking from your custom driver. But I think there's no API to
force-set the SND_DMAENGINE_PCM_FLAG_NO_RESIDUE bit in
dma_engine_pcm->flags from your custom driver.
Maybe there's a way to establish compatibility between PCM and AIXDMA in
this regard. But to figure that out, I think more eyes on the issue from
the audio experts and Xilinx/AMD engineers familiar with AXIDMA residue
reporting would be needed.

Just to double check, and to make sure the regression you're seeing is
not a combination of any additional, yet unknown side-effects, could you
perform one more test?
In dmaengine_pcm_pointer() (the function we just patched), could you
replace the call to snd_dmaengine_pcm_pointer() with
snd_dmaengine_pcm_pointer_no_residue() while keeping 7e01511443c3 active
and test if this fixes your issue or not?

[1]: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/dma/xilinx/xil=
inx_dma.c#L3284
[2]: https://elixir.bootlin.com/linux/v7.0-rc3/source/sound/core/pcm_dmaeng=
ine.c#L136
[3]: https://elixir.bootlin.com/linux/v7.0-rc3/source/sound/core/pcm_dmaeng=
ine.c#L235
[4]: https://elixir.bootlin.com/linux/v7.0-rc3/source/sound/core/pcm_dmaeng=
ine.c#L251

