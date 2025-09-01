Return-Path: <dmaengine+bounces-6305-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35385B3E1C2
	for <lists+dmaengine@lfdr.de>; Mon,  1 Sep 2025 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EC91A80C29
	for <lists+dmaengine@lfdr.de>; Mon,  1 Sep 2025 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBB23148D2;
	Mon,  1 Sep 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKe3rVa2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235903148A8;
	Mon,  1 Sep 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726647; cv=none; b=LqX38lYu13DW2Cs1Us86jtxI66iIuOWxlJ5xKzW1VhaMWr/vy+x7LGGUeMGB19u6vzSUZ9VxzEtFBP2iKjyFi3+rjnPJl+X8b3zUX3jess04RnMrQviU3hfNCkJKwVgiFgHXdR1H78PUxrKxuG0v96Rn0JiSaPo0s8nbAxtHYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726647; c=relaxed/simple;
	bh=4S/RHev1Y2NUMoafR694usmzuXP1Xi5zuD4R9cVnE3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uVDhLp2e2IvKgMVaQjBgGizD3tYn794gZC7gZjdqN6EJtYxB9J7jf1s+Hxl6pTjhSYRI9VjtqZ/wnPXZ/pjvgjlz0RwILfF8XCpHUSrXCbiuTYB3Z52J2XsCl6oWvTm/GtByQn/8B8Zf3Bo6QnrEVD8cLL+gQt48KMCa6G1+j7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKe3rVa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84CA7C4CEF0;
	Mon,  1 Sep 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726646;
	bh=4S/RHev1Y2NUMoafR694usmzuXP1Xi5zuD4R9cVnE3Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZKe3rVa20pxNBPalkM0wfA/JxiFs9RN5L2hyMC16WxL+prb08gI8eJGM/AkCz0pE4
	 SfBMRbRW1PhaZU2WT4hj/sTAoWjZ0n4GwZPiDzS7LFa8Bkyk/gPJck0h7cNJr7E/11
	 dCCbFAbLo8t8N3d0vqryE6Qv2VOu1VGrKnXftkFSYGeUfprAv/+97uDp3ZamUHNRCp
	 7dHlYmgb8bfd8atRPStnKKU6B60YQ4KlixGSVYFldY+rw1mMEmsZPlrOQiOJfPXMhC
	 MPtHKWfSwK/LH7OcjXEcvbIgz74RfnSdCfK3qBJbd89wABiWXCc4U4hPMygg728DgQ
	 6YRgeMF36n0VA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1BCCA0FF0;
	Mon,  1 Sep 2025 11:37:25 +0000 (UTC)
From: Anthony Brandon via B4 Relay <devnull+anthony.amarulasolutions.com@kernel.org>
Date: Mon, 01 Sep 2025 13:37:24 +0200
Subject: [PATCH] dmaengine: xilinx: xdma: Fix regmap max_register
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-xdma-max-reg-v1-1-b6a04561edb1@amarulasolutions.com>
X-B4-Tracking: v=1; b=H4sIAHOFtWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwND3YqU3ETd3MQK3aLUdF1DMxPLZDMTU0tjUwsloJaCotS0zAqwcdG
 xtbUA6UUUal4AAAA=
X-Change-ID: 20250901-xdma-max-reg-1649c6459358
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Anthony Brandon <anthony@amarulasolutions.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961;
 i=anthony@amarulasolutions.com; h=from:subject:message-id;
 bh=Td8m3zq/WUtHpPPBIX28CApxSTxtvMscrufvMw7VZu4=;
 b=owGbwMvMwCUWIi5b4HjluATjabUkhoytrSW8+/XP1KYs0j29dsvB1Y8utfZ8jP7WWPvi9VJxy
 ZfKnuE7OkpZGMS4GGTFFFnKdeR5PZTrypVmPjGGmcPKBDKEgYtTACZyRYyR4VlU+MXDuZ7ZkUvk
 g/WmPFJvl5i5+/JVkYPei2Sd0swF9jH8U3JQ2qvbynxpfYqS/6WloWmyhjyKmW8WHD6UwDfr8Za
 NTAA=
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

Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 0d88b1a670e142dac90d09c515809faa2476a816..cb73801fd6cf91fc420d6a8ab0c973dcdb5772f5 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -38,7 +38,7 @@ static const struct regmap_config xdma_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = XDMA_REG_SPACE_LEN,
+	.max_register = XDMA_REG_SPACE_LEN - 4,
 };
 
 /**

---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250901-xdma-max-reg-1649c6459358

Best regards,
-- 
Anthony Brandon <anthony@amarulasolutions.com>



