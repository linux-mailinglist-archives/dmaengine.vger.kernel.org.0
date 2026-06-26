Return-Path: <dmaengine+bounces-11801-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fB6KGEowPmq/BAkAu9opvQ
	(envelope-from <dmaengine+bounces-11801-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 09:54:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE6B6CB275
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 09:54:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bereza.email header.s=mail header.b=QEt68Hc2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11801-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11801-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bereza.email;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B88A302A069
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE63D4137;
	Fri, 26 Jun 2026 07:54:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80B3CCFDE;
	Fri, 26 Jun 2026 07:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460474; cv=none; b=jURucx4bleaK7TTpV6r0t8k9DO7JSUytT0lg+86X1TRlBEX+SGtJtKdnF+89iec8I8m1DEEQW32L9irVSQ4vKJWDF+IMw1G6gz5TPyzDAbAlpizKgOhp1xvkcGpjNMgvAHyuQUdmxMY6hMltw5S67loBxXbTVkAkjHL51U3vT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460474; c=relaxed/simple;
	bh=fu9TsJGr2BQbDqvWo5w+dHLu7Kx9Mkjtvmx/clbn+f4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f3SecSZT0b+qDNxuyjyYYtHqViYXazbB3quksZM1zOZI8uuLJhSfsKGuoYzqUkncXAX0QSboxZ3Q2meibgS7apne5iPWAQm2cd5JzMK7JWTXY9Q6D27DjSqPcmo30L0wWvYiHX+KkVvoxxTqkah1R8sR+N/11VmXdPVI4/h63Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=QEt68Hc2; arc=none smtp.client-ip=162.55.44.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1782460114; bh=fu9TsJGr2BQbDqvWo5w+dHLu7Kx9Mkjtvmx/clbn+f4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QEt68Hc2Iwnt5hJOnqWzuEE46SMI99d9j8yhL76igYVk+Z2HuWrqShDiIdFlMazjW
	 ChE3kVJkR7rbm7YwifGNj5H1o4RLuWoQFZvMiLHYtOJaeZlkLCWpXPxLB4cu02MRkI
	 A6g1MiobRTxewhm+IzBGmkD/loRZMv7yKuVkDVaQziVTy74bDdgvzWQvqKaEwSEGGy
	 apVpB1WXgUBjmotxmStjiy9O1zhNINyMypX/TWaOYfkVtX4Ttc5BwLv629u2lMqfGa
	 m5zm3Tv5RJQAGbL6KFSiDstVkbl37W0zqdiNv7pGmOhfvnLNy7rg4n5Bfvw6Z6i8V7
	 PtIvN9QQf9eIg==
Received: from localhost (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id 579F460E20;
	Fri, 26 Jun 2026 09:48:34 +0200 (CEST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 09:48:33 +0200
Message-Id: <DJITDJYQEOPN.I0S9T54IS104@bereza.email>
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Suraj Gupta" <suraj.gupta2@amd.com>,
 "Frank Li" <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused
 by passing delay_us=0
From: "Alex Bereza" <alex@bereza.email>
To: "Alex Bereza" <alex@bereza.email>, "Vinod Koul" <vkoul@kernel.org>,
 "Frank Li" <Frank.Li@kernel.org>, "Michal Simek" <michal.simek@amd.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Arnd Bergmann" <arnd@arndb.de>, "Tony Lindgren"
 <tony@atomide.com>, "Kedareswara rao Appana" <appana.durga.rao@xilinx.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DsE3FsHGEnJCtXR3Z9SV8EKrNPT5Ts7jJzvuFbYxFFwXiTIk9D95VxhojlLSRRnswrBlhXLZAePfM5VH9axGhQ==@protonmail.internalid> <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
In-Reply-To: <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bereza.email,quarantine];
	R_DKIM_ALLOW(-0.20)[bereza.email:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:suraj.gupta2@amd.com,m:Frank.Li@nxp.com,m:alex@bereza.email,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:geert+renesas@glider.be,m:ulf.hansson@linaro.org,m:arnd@arndb.de,m:tony@atomide.com,m:appana.durga.rao@xilinx.com,m:geert@glider.be,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11801-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bereza.email:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAE6B6CB275

Hi, could it be that this patch was forgotten? I still can't find it in
dmaengine tree. Is there anything I should do? It still applies cleanly
to dmaengine/fixes.

BR
Alex

