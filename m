Return-Path: <dmaengine+bounces-9270-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLblOpc/qWnK3QAAu9opvQ
	(envelope-from <dmaengine+bounces-9270-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 09:32:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857120D7DC
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 09:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD98300E72C
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C83264EC;
	Thu,  5 Mar 2026 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="QuqLYNEI"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE023C516;
	Thu,  5 Mar 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699539; cv=none; b=iSkgZ5Eioij5Kwpx90XMT9t8ucHSxT8JumB/I5MmGI8tLxub+pcbwvIcQkPYufKegDV72jn1AThiyfy1+b1efxOSvSFRrTAKecEWQbswkKCoy/GhRFfFU0kIyabnRaH1Qn7WkVGcYICPWbcjX6PBapxIX9CL1wPht6n+HTb0nZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699539; c=relaxed/simple;
	bh=nnflLaTfGvJc0HH9hksuKLYPsZhCvKkD1AAKWqLjGjw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Pb00avwAWpGnAmzegEFFF2cCIkh/Ja8G0trSiHbgrSe7YxwjjFPHkcSqeHpNrTIiOM2EKAHmLWSED0evCZPGldQiWmCxziJekw4TjpaglRgOWUFsnd0NWtTIDXjDcloHWJCvZJMx65Yfb/dDuhp9oYhs/h08I3fz7LSojxgLOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=QuqLYNEI; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UVLaL6Pe/vYrwUbYcug+Ovp1mp1+ydzWEyoM82UXZ9Q=; b=QuqLYNEIwTyOJilhTq+juHtXZT
	2EfnaDsNpK8kLNO0yprRtZ7dk8PduIEKDD6xierhNtM499NT7FR9eP/RCjIws+J4j8l+aC5rWVXoB
	T+LlkB2W+3Nmi3DjRETBZ8uoQkZ4DSXktdtUsbqYtWihC646CWnknm55JH1+kNPP8+2cjoM3lgzGf
	KlAx+cuCfWNpEx/i2lguahbkQzplK+qo4tXcJXUeE0V+l4CQ7qRFTopUoT0+I30heHyrNMo9EpU7V
	2gKFwN60U5ouDI3nMyOzlinzwMIr4fW1JqK4W0a++HEpostwkNB6PU2mWSSlHy+qfNMeJr7LKmtEQ
	D718UyrA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vy47v-0009JJ-05;
	Thu, 05 Mar 2026 09:32:11 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vy47u-000PSq-16;
	Thu, 05 Mar 2026 09:32:10 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 08:32:08 +0000
Message-Id: <DGUPJD1VRSH8.6EHJG20V49KE@folker-schwesinger.de>
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
 <20260305082919.5940-1-rahulnavale04@gmail.com>
In-Reply-To: <20260305082919.5940-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27930/Wed Mar  4 08:24:08 2026)
X-Rspamd-Queue-Id: 5857120D7DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9270-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[folker-schwesinger.de:dkim,folker-schwesinger.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu Mar 5, 2026 at 9:29 AM CET, Rahul Navale wrote:
> logs:
> <4>[    0.302360] dma_slave_caps:
> <4>[    0.302364]   src_addr_widths    =3D 0x00000000
> <4>[    0.302368]   dst_addr_widths    =3D 0x00000000
> <4>[    0.302371]   directions         =3D 0x00000000
> <4>[    0.302374]   min_burst          =3D 0x00000000
> <4>[    0.302377]   max_burst          =3D 0x00000000
> <4>[    0.302380]   max_sg_burst       =3D 0x00000000
> <4>[    0.302383]   cmd_pause          =3D 0x00
> <4>[    0.302386]   cmd_resume         =3D 0x00
> <4>[    0.302388]   cmd_terminate      =3D 0x00
> <4>[    0.302391]   residue_granularity=3D 0x00000000
> <4>[    0.302394]   descriptor_reuse   =3D 0x00
> <4>[    0.302398] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> <4>[    0.302401] xilinx_dma_device_caps: caps->directions =3D 0x00000001
> <4>[    0.302404] dma_slave_caps:
> <4>[    0.302406]   src_addr_widths    =3D 0x00000000
> <4>[    0.302409]   dst_addr_widths    =3D 0x00000000
> <4>[    0.302412]   directions         =3D 0x00000001
> <4>[    0.302415]   min_burst          =3D 0x00000000
> <4>[    0.302418]   max_burst          =3D 0x00000000
> <4>[    0.302421]   max_sg_burst       =3D 0x00000000
> <4>[    0.302423]   cmd_pause          =3D 0x00
> <4>[    0.302426]   cmd_resume         =3D 0x00
> <4>[    0.302429]   cmd_terminate      =3D 0x01
> <4>[    0.302431]   residue_granularity=3D 0x00000001
> <4>[    0.302434]   descriptor_reuse   =3D 0x00

Could you confirm that the DMA IP core in your PL design operates in
Scatter Gather mode?

