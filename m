Return-Path: <dmaengine+bounces-9800-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GQxEl3szGk/XwYAu9opvQ
	(envelope-from <dmaengine+bounces-9800-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 11:58:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EA3781D9
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98CD8305445F
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CF23C5DBE;
	Wed,  1 Apr 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b="Ttsr53R2"
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99D363087;
	Wed,  1 Apr 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.44.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037499; cv=none; b=TDl18dj/auuf1ytepLUgu3XEEFgY7ZlCoQxcuBoZn0IiBSYS1R0d6zPq3OKfu+VotdlXulZCf9xaEl4EVDO4L4cIr0v2+nVrNBs5P9vXMfMGg+QJU08ejqyoa6QaMBPcpGyfDVCM63kFKkDjeLTPdEAZeNGub2oFzs3Zu3jZNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037499; c=relaxed/simple;
	bh=e7ROf8amYwTkT3CIywtA4AlkVDHaTkBNyidI2+epKIo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wy3tgChXqxl/D5YmJGjElU8BDytuTS9mxR1kCTzWtdU/coR9jINmv+TQrpL/8DxqWGtqQYImd94aLSEhj9PMQKJFGXu4692aEufx81PbZpdwmWcbZTxU3hae11k/BlWIaTtOMoGQ+zPSp+TeJzZPPa3wsdiZi1kVfhhAK32N/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=Ttsr53R2; arc=none smtp.client-ip=162.55.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bereza.email
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1775037494; bh=e7ROf8amYwTkT3CIywtA4AlkVDHaTkBNyidI2+epKIo=;
	h=From:Subject:Date:To:Cc:From;
	b=Ttsr53R2YagO3NF5Pu2ZltojRkZ6chm9IP4tDKZ9+ZD8vjhFEqgAolid+Tmhszea6
	 AvnyJtYjR7wSVRTc7bU+s4Dkk+L91/izQaiNYGTwUyhemlS8cIOgdIp74JwezBaSpO
	 3IizqFCbXERM5tXfpYxYFqWejadDloWDBj1aoWd/ChEGJbe7BMFps9rpdYpxPYLTWT
	 LhjYCVY81qr09gWAKK5nR+WAkCFh19Dnm993VHIpuH6UUF4iEsw2nZDlcGby0DzRgN
	 Vu7wiN4V/bIs/GHu/wDLaD4Cqffpu5mxk0P/Trf3LxsP6u6pc1PqFxEiflEgFiHMIY
	 RLhYlP7XCeh3w==
Received: from [127.0.1.1] (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id D04235DF94;
	Wed,  1 Apr 2026 11:58:13 +0200 (CEST)
From: Alex Bereza <alex@bereza.email>
Subject: [PATCH v2 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused by
 passing delay_us=0
Date: Wed, 01 Apr 2026 11:57:46 +0200
Message-Id: <20260401-fix-atomic-poll-timeout-regression-v2-0-68a265e3770f@bereza.email>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBREr0K69ptCEaIr72FYtOUXvgFL2kJUw
 t1tMe5dvmRm3qzMoyP07JKtzOFCnuwjQnHImO7lo0OgNjIreFFxITgYeoIMdiQNkx0GCDSinQM
 47Bz6VIfSlCiUNMK0NYtDk8PY2iW35st+VnfUIS2nRE8+WPfaXyx5yv2E+T/CJYccTqpW7blCq
 SW/KnT4lkccJQ2s2bbtA+f1KkHpAAAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9800-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bereza.email:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bereza.email:dkim,bereza.email:email,bereza.email:mid,glider.be:email]
X-Rspamd-Queue-Id: C48EA3781D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Alex Bereza <alex@bereza.email>
---
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


