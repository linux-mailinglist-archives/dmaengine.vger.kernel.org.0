Return-Path: <dmaengine+bounces-9804-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEyBFG38zGnRYgYAu9opvQ
	(envelope-from <dmaengine+bounces-9804-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:07:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C5F379168
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 571CA30F3168
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA9E3FEB3A;
	Wed,  1 Apr 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b="CKWmFr4I"
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12134035A0;
	Wed,  1 Apr 2026 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.44.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041023; cv=none; b=qJHUQCU+3W/8tyXhoiqrQRrfRZlpOgP3ku2RkQxECFCkrgetQukKf+Mnqe3RV+R04JljB9fGKa70VSvyOYEvm5IfliYJPjGLY+CkmH/FFbH11J63z4IvgTTiLx8pwTD5uEEedIatqwzDy/TCt2jnEWLBYTZQ7ABjxYR4ZiF1BHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041023; c=relaxed/simple;
	bh=nGbJMc1SpopSWDrpbU5L/1qQ3V8loe6NC9n1u7UtYqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iz86BTi4i4w6/l4G30+jEdfsUsOrU8QcG1XXy1ElDGRoBFwDFp+Q8rg7V1QjFnuQNHT9TZtEh7r4HKWfQke8Vif1f1y4lH9lYFkw2HeD43C4ItmJ/c4OR3pH2KxrwqF0Kpuztkajvqjm18vZYzRmUzjaOH0bsZuPWti8PfQWl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=CKWmFr4I; arc=none smtp.client-ip=162.55.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bereza.email
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1775041020; bh=nGbJMc1SpopSWDrpbU5L/1qQ3V8loe6NC9n1u7UtYqQ=;
	h=From:Subject:Date:To:Cc:From;
	b=CKWmFr4I7JiMChW8VHJ8G9FCq32dAXo4dBaKsG3gpsEqRn2pY8f2xnH8aOLKf10V0
	 wVjqP5Yc+dfdiYJHANjUVrIuJMI8iZgSzvq3jsA1KG7UviGk8Nnz4A8Pje3nFJMosP
	 aVsxkwCnecl5rCnDQSleGqlGhqUqRRR3h2lEZuxsp43dqa2iXimje3vBLmpr8X5kHp
	 1UZOeM7//4lVkoozqkj1GvAeAqODXd7cs0Zt7y2VDVoFK/BCwZoMwDqPYCudERZvHM
	 1MtF8W/5g82whwwJV5ENR+dO62x0eOSU2x0VEVa47RpLvJDBaDrovL+J+IxwxxjBKA
	 S8IOtroz5qoRA==
Received: from [127.0.1.1] (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id B95EC5DF94;
	Wed,  1 Apr 2026 12:56:59 +0200 (CEST)
From: Alex Bereza <alex@bereza.email>
Subject: [PATCH v3 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused by
 passing delay_us=0
Date: Wed, 01 Apr 2026 12:56:31 +0200
Message-Id: <20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OywrCMBREf0Wy9kqa9KGu/A9xkbQ39krbSBKDW
 vrvNooIrrocmDlnRubREXq2X43MYSRPdpiDXK9Y3arhjEDNnJngouRScjB0BxVsTzVcbddBoB7
 tLYDDs0Of5pCbHKVWRpqmYjPo6nBevSXH0yf7m75gHRI5NVrywbrH+0XMUu8rzJYIYwYZFLrSz
 a5EVSt+0OjwqTbYK+pYckbxo+Z8GVUAh3KrRFmgrCpu/qjTNL0AlEIB9D8BAAA=
X-Change-ID: 20260330-fix-atomic-poll-timeout-regression-4f4e3baf3fd7
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Tony Lindgren <tony@atomide.com>, 
 Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alex Bereza <alex@bereza.email>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bereza.email,quarantine];
	R_DKIM_ALLOW(-0.20)[bereza.email:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9804-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bereza.email:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bereza.email:dkim,bereza.email:email,bereza.email:mid]
X-Rspamd-Queue-Id: A0C5F379168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Alex Bereza <alex@bereza.email>
---
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


