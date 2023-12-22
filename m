Return-Path: <dmaengine+bounces-638-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C914C81C76A
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539AFB20E1C
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB3DDAB;
	Fri, 22 Dec 2023 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKf4O8lF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5790DDA3
	for <dmaengine@vger.kernel.org>; Fri, 22 Dec 2023 09:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B48C433C7;
	Fri, 22 Dec 2023 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703238025;
	bh=Iy4oXj3nws/xs7/vUDvLO61UmjzamQgxPGLmju9ESZA=;
	h=From:To:Subject:Date:From;
	b=NKf4O8lFKtZyIRbGJLczwX1nHycIk4lxllO1NDImJ1XTGCzdkZQVX49kuiSdDYJqw
	 aJa58lqcKN/YX/hQRBTMS6NuhwmwOTpLwyyA7m8ixITWONZtYmPFiQPm8kJL2ORI2a
	 OKiwPIaVwcTMqmd5kAGnibV8P9r8bgF2sO8GtRvLoBSbmnF29z5IUhr5RZ5cl3ta0g
	 iFW9OHl/XN1csstz/J+wM6Mgb1FI3Qf8ZnsPmzCrL6f+Fs8CCl3kX5roc4jPwi3K2T
	 F2ffsfzbJYNk1oy0LOIg+QQ7ejdjoOVrq8OneNv62om6BVjHyzmj1Q+aWxF/G4cV9d
	 /wG8UkEnbPX4Q==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH] dmaengine: xilinx: xdma: Workaround truncation compilation error
Date: Fri, 22 Dec 2023 15:10:17 +0530
Message-ID: <20231222094017.731917-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Increase length to be copied to be large enough to overcome the
following compilation error. The buf is large enough for this purpose.

drivers/dma/xilinx/xilinx_dpdma.c: In function ‘xilinx_dpdma_debugfs_desc_done_irq_read’:
drivers/dma/xilinx/xilinx_dpdma.c:313:39: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  313 |         snprintf(buf, out_str_len, "%d",
      |                                       ^
drivers/dma/xilinx/xilinx_dpdma.c:313:9: note: ‘snprintf’ output between 2 and 6 bytes into a destination of size 5
  313 |         snprintf(buf, out_str_len, "%d",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  314 |                  dpdma_debugfs.xilinx_dpdma_irq_done_count);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 69587d85a7cd..b82815e64d24 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -309,7 +309,7 @@ static ssize_t xilinx_dpdma_debugfs_desc_done_irq_read(char *buf)
 
 	out_str_len = strlen(XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR);
 	out_str_len = min_t(size_t, XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE,
-			    out_str_len);
+			    out_str_len + 1);
 	snprintf(buf, out_str_len, "%d",
 		 dpdma_debugfs.xilinx_dpdma_irq_done_count);
 
-- 
2.43.0


