Return-Path: <dmaengine+bounces-6342-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF47B41960
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE768566A94
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5F2F0697;
	Wed,  3 Sep 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIpTPaTz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365892E229E;
	Wed,  3 Sep 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889775; cv=none; b=Na+wLEajqgGv79WQ+YTnwaRPbzc6pqKa793/2jcpq6HA7480Vu8NoQzoJ6f/8lWorRpe3FaxhORh5FCOPcUzI3/2wpa/KU5woQ5XlbAy0Am1WHYnpaH9GV6MACuMbHtEKfodHxNc+BSnec6I117fK8+D9rnWbbDd+lX1pF5/+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889775; c=relaxed/simple;
	bh=q0tHz+BMppn+t5zOxfWZIctQRwVYHLuE0UcrNZZKdo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JVYMzxlpITKu8ZlvEvOhBszwFZhdRgXXK1zPtjBmtS465hXJsMQTyVwd3Z5d+MRaL98j8POYU8nmY2nnTvsmHxK+3BKawnXuWVIdLLlw1WgH5SAZz5LCMGmq/1lSeBh5ZYxHOMwBx/V/EsB/OZQz5l70jPpdFTzDQMFjy47h+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIpTPaTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10859C4CEF0;
	Wed,  3 Sep 2025 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889775;
	bh=q0tHz+BMppn+t5zOxfWZIctQRwVYHLuE0UcrNZZKdo4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=NIpTPaTzzHX7kB1f8K503erRMyypAXp1ExsDMwEhyLo+dF1be4OFKtlwDQVfIIahP
	 ESEMMz41sEaWtoKNZ03tJ9d9IJ0MiI6QaSzTeo8avGezs+TtC5yI5a30t4d4BB6v/6
	 O70WUoRIcXFhUmhrDmBDs88a/69IwmCC65sslg6afBp+/xZyXD8e2qAuXVJyWEsxrx
	 CXYDyRL8LpCA4/AYREoiSV59XCl7Br2dG/n1P6aqY+OtupCCehxq1SbsjnPAu0OFKq
	 jVjETpWA9H//y/7Wx7qZHhKDGss7GCsWGMKJCFiO0ekZAQdNIo4sEMed3DvDWI/WB4
	 mycw0vDRbpR5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03F0CA1009;
	Wed,  3 Sep 2025 08:56:14 +0000 (UTC)
From: Anthony Brandon via B4 Relay <devnull+anthony.amarulasolutions.com@kernel.org>
Date: Wed, 03 Sep 2025 10:56:13 +0200
Subject: [PATCH v4] dmaengine: xilinx: xdma: Fix regmap max_register
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-xdma-max-reg-v4-1-894721175025@amarulasolutions.com>
X-B4-Tracking: v=1; b=H4sIAKwCuGgC/33OywqDMBCF4VeRrJuSycVLV32P0sVooga0KYmKR
 Xz3RleloMv/wHzMQoLx1gRySxbizWSDda8Y8pKQqsVXY6jVsQlnXLGCAZ11j7THmXrTUEhlUaV
 SFULlJJ68vantvHOPZ+zWhsH5z65PsK0H0AQUaJkikyoFo0u4Y49+7DC4bhziT+FauZ5s5sTPH
 B6dGkXGBWaQV/rEEb8O/3NEdNQGlbnmJagDZ13XL3+nWz9DAQAA
X-Change-ID: 20250901-xdma-max-reg-1649c6459358
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Anthony Brandon <anthony@amarulasolutions.com>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123;
 i=anthony@amarulasolutions.com; h=from:subject:message-id;
 bh=L9Jh4ojlLzKIglwK2lLLxgJIk6sX82XB7wh+bXhzPgA=;
 b=owGbwMvMwCUWIi5b4HjluATjabUkhowdTGuXbz2h8O6vR9h7l8sJXDd2xeuveNJvuSdM7f7co
 LlBt/jiO0pZGMS4GGTFFFnKdeR5PZTrypVmPjGGmcPKBDKEgYtTACayiJHhn8qiHF9TpoxqOeMV
 03eG+W0RdGx0+/VCIXcmz4H1iZdzmxgZnspOWb3hmObTayGdPPNCuJXqK/8y2R1pOFGZv0JJr9i
 bEwA=
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
Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
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
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250901-xdma-max-reg-1649c6459358

Best regards,
-- 
Anthony Brandon <anthony@amarulasolutions.com>



