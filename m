Return-Path: <dmaengine+bounces-6822-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA427BD4C75
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95256350353
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DCA26FA70;
	Mon, 13 Oct 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksgnG4GB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA78261B9C;
	Mon, 13 Oct 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370565; cv=none; b=BkYHyP533LGp5lO0EcAnyayhLuoW63TQi1ze9Z9aFGRqcBx5nwv59kHVNeVYCLFjLWpFsKy1NO6qdrpZodj+m16YS1Rtu+1sqdHl5rpR32dM+Wt5cwgA0xatbKhL9bGhbXaBlGuTrJIf79RR4gABh7BgRYfauIxjhYkYpUP1AqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370565; c=relaxed/simple;
	bh=YIPVFumAT9DHDl+3NSoby0+v8/FmUF2QL269vIj3vhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b52hEJxH7O48GMy3SVJGx+96Rk87EWYl519zpqWaOIyiT5hT9MBED7qH3ZXqV8d42WBnZ+ZokK3GOgro2QICGv40w3+39eA91CmVLtdnkau9yODt9qYdSbvBtfKjmOdUCaNi3+KWVprHDdwVk/3OckwLbd1aiLBw8BfVmWkFKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksgnG4GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A1A7C4CEE7;
	Mon, 13 Oct 2025 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760370565;
	bh=YIPVFumAT9DHDl+3NSoby0+v8/FmUF2QL269vIj3vhQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ksgnG4GBbWOJxeQTzloKur8JW68127xr+1JOQt2hPE+McNJnuJ+vigSYO/NGqTW2w
	 f01RstPL41vUb+C9ZjqdFjR0oa008euBoOvMXr8FIrAwb6TdgQG+T5MM/0pwRMQASJ
	 bkw1A1cZpREPjEl9LVFdjs0WWSAiCfpqsil/Cfvl03tqsP2vjCQztNiga/1/phGsKj
	 RDTIqI74YxENgYrZ/lUn6Vos1x51zE5dzV0sEofnoX7CVSV7EA7ISAQfDIFqrFqsdu
	 dyztcLd3MXLEfhFQcyf91Lzgu0GzhLdw7b+pfhy/K4Kh940lQbiWqaEmcGDfTya++a
	 KV2YoVZ7LSjjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361EDCCD18E;
	Mon, 13 Oct 2025 15:49:25 +0000 (UTC)
From: Anthony Brandon via B4 Relay <devnull+anthony.amarulasolutions.com@kernel.org>
Date: Mon, 13 Oct 2025 17:48:49 +0200
Subject: [PATCH v5] dmaengine: xilinx: xdma: Fix regmap max_register
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com>
X-B4-Tracking: v=1; b=H4sIAGAf7WgC/33OSw6CMBCA4auYrq1h+uDhynsYFwOt0ASoaYFgC
 Hd3cGVIZPlPZr7MwqINzkZ2PS0s2MlF53sKfT6xqsG+ttwZaiYSoZMiAT6bDnmHMw+25pCqokq
 VLqTOGZ28gn26+cvdH9SNi4MP768+wTb9A03AgZcpJkqnYE0JN+wwjC1G344D/RQvle/YZk7iy
 BHkPFFmQmIGeWUOHPnriJ0jydEbVOZGlKAPHPXryJ2jyMkLlQmATNPKH2dd1w9iAz6ziwEAAA=
 =
X-Change-ID: 20250901-xdma-max-reg-1649c6459358
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Sonal Santan <sonal.santan@amd.com>, Max Zhen <max.zhen@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Anthony Brandon <anthony@amarulasolutions.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329;
 i=anthony@amarulasolutions.com; h=from:subject:message-id;
 bh=zm9B3BfNwF6YoIlqBfCv8ID8sIfD6lc0Mod18hncI6s=;
 b=owGbwMvMwCUWIi5b4HjluATjabUkhoy38i3rlObXltcKZGfnZTPlh9lcYd6vyn/49ZLII2Z7V
 zfmbuLqKGVhEONikBVTZCnXkef1UK4rV5r5xBhmDisTyBAGLk4BmIjSK0aG74I+Eye1VMtoRaSf
 vfenvyH4HtOzP/dPvvCf3pkzt2STEcP/ml6O2V2P+g8ziN2LO621z2pZv9of2R0yt3/ofpY4s72
 eDwA=
X-Developer-Key: i=anthony@amarulasolutions.com; a=openpgp;
 fpr=772C1F0D48237E772299E43354171D7041D4C718
X-Endpoint-Received: by B4 Relay for anthony@amarulasolutions.com/default
 with auth_id=505
X-Original-From: Anthony Brandon <anthony@amarulasolutions.com>
Reply-To: anthony@amarulasolutions.com

From: Anthony Brandon <anthony@amarulasolutions.com>

The max_register field is assigned the size of the register memory
region instead of the offset of the last register.
The result is that reading from the regmap via debugfs can cause
a segmentation fault:

tail /sys/kernel/debug/regmap/xdma.1.auto/registers
Unable to handle kernel paging request at virtual address ffff800082f70000
Mem abort info:
  ESR = 0x0000000096000007
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
[...]
Call trace:
 regmap_mmio_read32le+0x10/0x30
 _regmap_bus_reg_read+0x74/0xc0
 _regmap_read+0x68/0x198
 regmap_read+0x54/0x88
 regmap_read_debugfs+0x140/0x380
 regmap_map_read_file+0x30/0x48
 full_proxy_read+0x68/0xc8
 vfs_read+0xcc/0x310
 ksys_read+0x7c/0x120
 __arm64_sys_read+0x24/0x40
 invoke_syscall.constprop.0+0x64/0x108
 do_el0_svc+0xb0/0xd8
 el0_svc+0x38/0x130
 el0t_64_sync_handler+0x120/0x138
 el0t_64_sync+0x194/0x198
Code: aa1e03e9 d503201f f9400000 8b214000 (b9400000)
---[ end trace 0000000000000000 ]---
note: tail[1217] exited with irqs disabled
note: tail[1217] exited with preempt_count 1
Segmentation fault

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
---
Changes in v5:
- Update Reviewed-by
- Link to v4: https://lore.kernel.org/r/20250903-xdma-max-reg-v4-1-894721175025@amarulasolutions.com

Changes in v4:
- Reorder Reviewed-by
- Link to v3: https://lore.kernel.org/r/20250902-xdma-max-reg-v3-1-5fa37b8d2b15@amarulasolutions.com

Changes in v3:
- Add Fixes tag
- Link to v2: https://lore.kernel.org/r/20250901-xdma-max-reg-v2-1-fa3723a718cd@amarulasolutions.com

Changes in v2:
- Define new constant XDMA_MAX_REG_OFFSET and use that.
- Link to v1: https://lore.kernel.org/r/20250901-xdma-max-reg-v1-1-b6a04561edb1@amarulasolutions.com
---
 drivers/dma/xilinx/xdma-regs.h | 1 +
 drivers/dma/xilinx/xdma.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index 6ad08878e93862b770febb71b8bc85e66813428e..70bca92621aa41b0367d1e236b3e276344a26320 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -9,6 +9,7 @@
 
 /* The length of register space exposed to host */
 #define XDMA_REG_SPACE_LEN	65536
+#define XDMA_MAX_REG_OFFSET	(XDMA_REG_SPACE_LEN - 4)
 
 /*
  * maximum number of DMA channels for each direction:
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 0d88b1a670e142dac90d09c515809faa2476a816..5ecf8223c112e468c79ce635398ba393a535b9e0 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -38,7 +38,7 @@ static const struct regmap_config xdma_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = XDMA_REG_SPACE_LEN,
+	.max_register = XDMA_MAX_REG_OFFSET,
 };
 
 /**

---
base-commit: 52ba76324a9d7c39830c850999210a36ef023cde
change-id: 20250901-xdma-max-reg-1649c6459358

Best regards,
-- 
Anthony Brandon <anthony@amarulasolutions.com>



