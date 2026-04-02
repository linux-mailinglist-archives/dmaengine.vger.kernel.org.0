Return-Path: <dmaengine+bounces-9822-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Nx+LsMjzmnElAYAu9opvQ
	(envelope-from <dmaengine+bounces-9822-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 10:07:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2157385A0E
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 10:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45B2430A5B1E
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46153630B8;
	Thu,  2 Apr 2026 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b="wKf4lofw"
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC334676D;
	Thu,  2 Apr 2026 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.44.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116035; cv=none; b=ejkVtQyEH7BZsUZHrCa+evBXVqCWwsGGLjfPW+0fdta/sA1UaUtliyqIrXtYK/6sXJ1gpCmDvVYyuFh58r6NMgj1w84Bi+XytKiErjYtw9rITSUW5NyoKSZFzX7KHgdxAbePJL3vdFkANM/jF9g40KMh5eCmY0n9syGpyAhxMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116035; c=relaxed/simple;
	bh=kKR2O7P62uxmTg8li99pkBO69vG62/hHAn5Al/w8yRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ddbICnbnMkTut0PIVt4b/8mnOUydMCGtl7LUZJphLl+yK75u3icBBN2g8D3gpyLtg16MqBRqrsUFhXWEohYwVOrfNh08xNiUjKAu2Gai/lC0SUD7jyWrBfN5Jlb8mCJIAuo8TwUXxuAmiW4jkhv6RdDEqHw9NSG1qWp+8VmgOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=wKf4lofw; arc=none smtp.client-ip=162.55.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bereza.email
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1775116025; bh=kKR2O7P62uxmTg8li99pkBO69vG62/hHAn5Al/w8yRc=;
	h=From:Subject:Date:To:Cc:From;
	b=wKf4lofwVj/5LiOvxW8MOO3Sj+08MFUReRQRj/JgoZ4/kR/JQ6Reft5WgXQAVenWO
	 oCks7Nb0Bwb+D/EiusGMcH2N5Rz7X++a6cT/0p2riRCjlBcuzrwWpHMjxa8MFlwyHy
	 GMPw2QVJZXp0BYYoBvnhTJjm1vxov3DPLJbgOQoVpNu004/iDRUqq4nnEk9mGZNxYq
	 UGrIuMgmaSQAPEsMprngTh6+Fc0A4d+rgxbZJDvU9cWhgl9nrAg4ggDftZlG+KZW3s
	 Lmhi4x2tClDShMmHV9jvNfDkVCpa24bQg4oVMorJW+MYVhTj6FGEJJ4V0rwkDJ108e
	 g4X0xp6z70nGg==
Received: from [127.0.1.1] (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id 8AFC360258;
	Thu,  2 Apr 2026 09:47:05 +0200 (CEST)
From: Alex Bereza <alex@bereza.email>
Subject: [PATCH v4 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused by
 passing delay_us=0
Date: Thu, 02 Apr 2026 09:46:21 +0200
Message-Id: <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOTU4DMQwF4KtUWWPkSeYPVtwDsXAmTms001RJO
 gKquTtJEUJCLMrySc/f80UljsJJPe4uKvIqScKxhPZup6YDHfcM4kpWGnWPxiB4eQPKYZEJTmG
 eIcvC4Zwh8j5yqufQ+paNJW+8G1SBTpHL1XXk+eUrp7N95SlXuTYOknKI79cv1qb2vgebWwbXB
 hro7GDdQ880ET5ZjvxB97yQzKpurvpHbfE2VQNCP5LuOzbDgP4P1fxfNUUduw5Hj8TO8S9127Z
 PzyXjHZUBAAA=
X-Change-ID: 20260330-fix-atomic-poll-timeout-regression-4f4e3baf3fd7
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Tony Lindgren <tony@atomide.com>, 
 Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alex Bereza <alex@bereza.email>, 
 Suraj Gupta <suraj.gupta2@amd.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bereza.email,quarantine];
	R_DKIM_ALLOW(-0.20)[bereza.email:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9822-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bereza.email:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,bereza.email:dkim,bereza.email:email,bereza.email:mid,glider.be:email]
X-Rspamd-Queue-Id: B2157385A0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Alex Bereza <alex@bereza.email>
---
Changes in v4:
- patch 1/2: nothing
- patch 2/2:
  - Fix commit message: reword as suggested by Frank Li
    <Frank.Li@nxp.com> - thanks!
- Link to v3: https://patch.msgid.link/20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email

Changes in v3:
- patch 1/2:
  - Fix commit message: remove blank line between tags
- patch 2/2: nothing
- Link to v2: https://patch.msgid.link/20260401-fix-atomic-poll-timeout-regression-v2-0-68a265e3770f@bereza.email

Changes in v2:
- Fixed the Fixes: tags as suggested by Geert Uytterhoeven
  <geert+renesas@glider.be> - thanks!
- Split the renaming of XILINX_DMA_LOOP_COUNT into separate commit
- Link to v1: https://patch.msgid.link/20260331-fix-atomic-poll-timeout-regression-v1-1-5b7bd96eaca0@bereza.email

---
Alex Bereza (2):
      dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout
      dmaengine: xilinx_dma: Rename XILINX_DMA_LOOP_COUNT

 drivers/dma/xilinx/xilinx_dma.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)
---
base-commit: b7560798466a07d9c3fb011698e92c335ab28baf
change-id: 20260330-fix-atomic-poll-timeout-regression-4f4e3baf3fd7

Best regards,
--  
Alex Bereza <alex@bereza.email>


