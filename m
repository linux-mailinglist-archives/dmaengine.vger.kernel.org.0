Return-Path: <dmaengine+bounces-11987-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id omvcJ/mNRmr8YQsAu9opvQ
	(envelope-from <dmaengine+bounces-11987-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:12:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B66FA002
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:12:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jISRAUCs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11987-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11987-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADC53311E224
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5A3290C9;
	Thu,  2 Jul 2026 16:03:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89F3161A4;
	Thu,  2 Jul 2026 16:03:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008236; cv=none; b=fRmV+g3cCak8XWhlYvQCwofa0NtdF4xkL2FNGVKRI+NexTcg26QCd15o6g7tC6A13MQaeqCB+WoWTi1pPgiiNk0apBy38DAMgXNoWX8bc8yY+qj6YC/XYMGecxwMRCiagexvae/Jo2z9gtobnZxVZNzRuRIa8QcIIhFujDakaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008236; c=relaxed/simple;
	bh=iomrlZG7kPzK7ffSVMHA//G0sN/O9h5S1fp6DPNs6hk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k5iCcuoVE1wag5U8TwUagQKC7zn5CP3NknADUihwR7BwpOnkoc8Q9ksDwt37VzRn0yzGgRbRjMsZBK9b+jl5htnP+PkOgkGNzMcJWZ/axc7ILEbZcSP/GNLp1uHBr9In0A6IqxOQ+Vku7rH0+bNSTOhCH+b2lmLKxIaEtWLMeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jISRAUCs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7841F00A3D;
	Thu,  2 Jul 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008235;
	bh=XrqTJm76Kt5HXWKNGtaVF8NXJWTQURY64tclnWYp1Ww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jISRAUCs1seajBhTHUM5kTliogvG0qdZDrZcJolDVGG3KjnCe5IstZgBLwhZqhg0/
	 7hZxrgH/q0fLLDKtfA2ISqNR2j6rA871RaAK5kbunPDC5ygjUGupMkPfA6BC+dkMUu
	 4MeC6iZu6PPi5EKNPucbE7/IJ7clvD8LtAFL9QLie03MYKPsPCVc2f8hOM/m4+wu6d
	 YoMMCsHCMd1sta3GyJ2RDlZkUNxiyi9gBkjucJfPv+i5Jbk+AdAbeX1tFvZs+o9y5B
	 BS6Fg6sCELoUMQb5JdtnEQ2oWN829itJjo+nFCaHKF31K7n356UEJNEJbxoKwdQ1Da
	 ZeaKJoairPs3A==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
 Tony Lindgren <tony@atomide.com>, 
 Kedareswara rao Appana <appana.durga.rao@xilinx.com>, 
 Ulf Hansson <ulfh@kernel.org>, Alex Bereza <alex@bereza.email>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Suraj Gupta <suraj.gupta2@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
References: <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
Subject: Re: [PATCH v4 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused
 by passing delay_us=0
Message-Id: <178300823153.756665.13267534916736185819.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:33:51 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11987-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:geert+renesas@glider.be,m:arnd@arndb.de,m:tony@atomide.com,m:appana.durga.rao@xilinx.com,m:ulfh@kernel.org,m:alex@bereza.email,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:suraj.gupta2@amd.com,m:Frank.Li@nxp.com,m:geert@glider.be,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 140B66FA002


On Thu, 02 Apr 2026 09:46:21 +0200, Alex Bereza wrote:
> 


Applied, thanks!

[1/2] dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout
      commit: aa99c4d1d63bbc26a5fc4c667d89b2595743c19d
[2/2] dmaengine: xilinx_dma: Rename XILINX_DMA_LOOP_COUNT
      commit: a6404c7291bcc10114e72e9d0226709ec9d05d5a

Best regards,
-- 
~Vinod



