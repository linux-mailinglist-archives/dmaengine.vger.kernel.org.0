Return-Path: <dmaengine+bounces-9036-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOhbJKC/nWnzRgQAu9opvQ
	(envelope-from <dmaengine+bounces-9036-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 16:11:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85F188D87
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 16:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE54530BAC41
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD23A1CE6;
	Tue, 24 Feb 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="HwzgDjSR"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9CE2264CA;
	Tue, 24 Feb 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945865; cv=none; b=iuoL2lzxv3JnaX4qM4uHv403V+JForiUxfeooHEfxMitCz8842VBKdBV7PdBpf6ibwtjht3hRbUnCyTKYQufrq2r8hELs6ICEdshZ48Oxb1A+nO5k8TDvcjrSx0MinBYZyminXYW2xn9/KKR0y1TsBZ7If6lfN70B30eHr7zQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945865; c=relaxed/simple;
	bh=dy52TRTcToqhsBjNt2WPnWn3Gtsyt5NZRxNdcDwqr/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=MprC+wkuViGW16R0u2APS6tX2QSALkJp83GoB6Hl081wxm7FLs1KURbvD7tMEzMgHJcB4BLGvH4wRd+G7dpCoLwta3J4C6AI77bVw7o0+jb1l2CsiNyBqTehAHdXxswKMiNMR0Uv8GeTSK5hT4iLd/Vvo3S3v+14hH4N72N4/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=HwzgDjSR; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dy52TRTcToqhsBjNt2WPnWn3Gtsyt5NZRxNdcDwqr/U=; b=HwzgDjSRmFaPfoyJVh0xby0D6J
	eBaGfxGc7Yul9IkeO80tiQ2w8dGJ2DvLXxeTZG4PKq9/DXY4RNhNzBtXoIGyCK7uA+vnJXkI7+2zi
	8Zs/T3767DicB+B7AKlAwderZ6/h0YRAcbrKYdnTqogyihb0VRigWkk6R9nvj0RSL0zUPbpsTvxA6
	I4eICZNMb3FCz07DN60eVvVkUSLpFnYoGD7RTiHe7xTbmeQX1rHRz1rcPL57KxDyYn4LUcc53YxjZ
	AUQMI0ip/IeFo7K4IrNS/9OgHtLCk1ORElGssPLlLt4nQyoCLww/iY0D1rjpTCsc9E7WOlX305P4u
	t1K74kQA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vuu3n-0009uN-0U;
	Tue, 24 Feb 2026 16:10:51 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vuu3m-000ChP-0Z;
	Tue, 24 Feb 2026 16:10:50 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 15:10:46 +0000
Message-Id: <DGNADOA8QYM2.2LA79O0V4M757@folker-schwesinger.de>
Cc: "Rahul Navale" <rahul.navale@ifm.com>, <dmaengine@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
 <suraj.gupta2@amd.com>, <thomas.gessler@brueckmann-gmbh.de>,
 <radhey.shyam.pandey@amd.com>, <tomi.valkeinen@ideasonboard.com>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Rahul Navale" <rahulnavale04@gmail.com>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260224093041.38699-1-rahulnavale04@gmail.com>
In-Reply-To: <20260224093041.38699-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27922/Tue Feb 24 08:24:31 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9036-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,folker-schwesinger.de:mid,folker-schwesinger.de:dkim]
X-Rspamd-Queue-Id: 0A85F188D87
X-Rspamd-Action: no action

On Tue Feb 24, 2026 at 10:30 AM CET, Rahul Navale wrote:
> From: Rahul Navale <rahul.navale@ifm.com>
>
>>this is an important bit of information. Could you verify that your
>>customized driver uses dmaengine's dma_get_slave_caps() to obtain
>>channel capabilities and that the newly introduced
>>xilinx_dma_device_caps() is actually called?
>
> Hi Folker,
>
> Thanks for the clarification =E2=80=94 I misunderstood about custom drive=
rs.
>
> I have confirmed that we are using the upstream xilinx DMA driver (driver=
s/dma/xilinx/xilinx_dma.c)
> and using AXI DMA for audio. We use separate fixed-direction channels:
> MM2S for playback (DMA_MEM_TO_DEV) and S2MM for capture (DMA_DEV_TO_MEM),=
 referenced
> via device tree.
>

Ok good, but this does not say anything about whether
xilinx_dma_device_caps() is actually called or not. Could you please add

printk("xilinx_dma_device_caps: dirs =3D 0x%08x\n", caps->direction);

before and after

caps->direction =3D chan->direction;

in the RFC patch, rebuild and exercise your use case. Then please do

dmesg|grep xilinx_dma_device_caps

and post the output.

In case there isn't any output, your driver does not reach
xilinx_dma_device_caps(). In that case the proposed patch is uneffective
for your custom driver.


