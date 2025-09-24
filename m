Return-Path: <dmaengine+bounces-6700-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876CB99F5B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE3E1B25FA1
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072242FD7B2;
	Wed, 24 Sep 2025 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HQ3vOw/v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx-relay98-hz2.antispameurope.com (mx-relay98-hz2.antispameurope.com [94.100.136.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CD2D541B
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.198
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718869; cv=pass; b=ZpCj4zY+sO8qwyM02RKTHt6YgmviPjjZ5tCynlRuG8DXSJVQjoLkai63RfeHsmvB5aOUdghcAUvvL4zpqwgF/oHsKhNZ5Q/CQFn6QKq9v/64Qjinzvq/UFlPfXX1F+Tx4YfqMRxT6pTOpCa9vi0wk0QdcWuA5Mr51P7+KaKrA3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718869; c=relaxed/simple;
	bh=tRFO2lmj9fh8+cqEU3EcQ/kLEOghCXUYGgOwKHAIOT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9/jaOL4e7AqrO0sfrOSFH0vwIAe7+YhecUKi6Bh8PVZGBV4/PQ9t9JN0PGsbJGODaViPoCOYBaMpq2Mcp99vLKOJ5HePuil7rt07ez3nP8QQYdb9i7BhTQzPUMrzQvCKu326xUvDlFBe1flAimhipGlkoncAoHiz5jONCeoQNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HQ3vOw/v; arc=pass smtp.client-ip=94.100.136.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate98-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=9UDISnZw3L2CnlLPkLi4dm5l+dhut+bxyAY7QFGqaZY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1758718829;
 b=HlliUtkBy/42qGjZ529Z2wOd8ZGseeKTiQFKIaTWmIaNn8tjQSz0xUHhkhpq9Oslwq6K18b9
 feLCSRn1LXPMHm77YnWd9ad/tYGUsMrXDDUmgVbaH9BrH8erVR1ytaIBCfJLv16zwQIHiC11kfz
 jsahCikh556JEP+ryss8ZRdOx+RgzQ+Y3S7oh72y+ooFPbgu5sG3j1KcYBgDUU7vcHto+GW1CC6
 +eFKLqMhJLk5Le+8bJF867G4E9W5h3WjiE2svVxpLDjOhSwV40DJZZZmVWFM4lyK4vrpKMs52nz
 I2eT05G0/rZ72b3ft5paEby20xbTwfPm8ccGQHaIBJMtQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1758718829;
 b=LeC3M7cJ/WthOzCH7XsWpVmHkHrtXPvmjnwlWTPMK9f0fxFpTgXL0dj4amu6WsdFfkTDew8E
 qBgi8O5tR7Bf58ytslcDheEARBsIWLv4I3JRn2YPAFOMcEt8rS+jidRh0yFwuS5T0IHqlW6+m6Y
 2NxwBamzFBQ578BpB4FeK9wuOKMpuGkrK/VwSibcLlyaN6/7WhGI/0fqFRCH106XEWRNUqc0Bmh
 /J9cSuxY18vtI2t2IqjRBWU7IBXabPyjo9mXve+09M+g5tvmlDsnkz+r9QMAWMRhn8/Icpj9TBx
 gtdFN9av2ebMb8UTCMhECqBGcodA+j5XYtPfAYrCtsExA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay98-hz2.antispameurope.com;
 Wed, 24 Sep 2025 15:00:29 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id B64FC220CCC;
	Wed, 24 Sep 2025 15:00:20 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Max Zhen <max.zhen@amd.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: xilinx: xdma: Fix regmap's max_register
Date: Wed, 24 Sep 2025 14:59:41 +0200
Message-ID: <20250924125941.742020-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:dmaengine@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay98-hz2.antispameurope.com with 4cWxln2CYmzJVhx
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:80bcfa90857a8c74b541e95d24a74b4e
X-cloud-security:scantime:2.129
DKIM-Signature: a=rsa-sha256;
 bh=9UDISnZw3L2CnlLPkLi4dm5l+dhut+bxyAY7QFGqaZY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1758718828; v=1;
 b=HQ3vOw/vA3U82cfTX0knxDMAVHao74NXpO8djR6ybBEKNtUoBPVc+/G3EbXVKyuP9qqvq5Xm
 ozhaKEC9O087QoYHJmEWBFGMbVKWHIEf3xNZddkbcoWv5+DHfG5lLtl00X2zD17BVeHT8nTIsj8
 /PtV8zu3wQhfv185QZk9D7QINQnd1+kkgK++4E+SPM/e5t6m70tEf4snbiuecC5ufduDpMaBwn1
 jnaZuRTw8Ey9qyrbo45fkyR/KU81+1kbhEK29ssbjPb5wkttfdB8XaBDiMAIialeWnej9BFS/8W
 hMMclfXPafhBsvOX+D4A6FExOdZzAPfRlSm0yXVwLj7Dg==

max_register specifies the last valid register address. As the BAR is only
64kiB in size, 65536 aka 0x10000 is too big. Restrict the XDMA register
space to be actually 64kiB.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/dma/xilinx/xdma-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index 6ad08878e9386..c6ef198ef7627 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -8,7 +8,7 @@
 #define __DMA_XDMA_REGS_H
 
 /* The length of register space exposed to host */
-#define XDMA_REG_SPACE_LEN	65536
+#define XDMA_REG_SPACE_LEN	0xffff
 
 /*
  * maximum number of DMA channels for each direction:
-- 
2.43.0


