Return-Path: <dmaengine+bounces-550-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD97A81663F
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 07:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F110A1C2216E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5F6FBE;
	Mon, 18 Dec 2023 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dwTOrS81"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5766FAB;
	Mon, 18 Dec 2023 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VhRO85FdTj+UlavJCsN+ZgrYdj3Kvcs7/EpNRYGwNyo=; b=dwTOrS811A3SGcz3EpjLvVWrVn
	Ft/I3aTOznNgKSjT6lnIc+xRB1zYT8n0KxS3f6xDTTD2tD5LhsfCIBWXTsTTtEHdnGpaTIpYLG4sn
	iZCzjVoXEwJOsan+iLlz72SNJ020BN+IIEIjccZ431qE4bh9H4z/LEQx8qvodZGEIWhG/eKVcbEyA
	QUwvRWGDzmilfwXnVBGcSQKHTGT0eb1z/TNbeDy9UoCbCoRxOe/qu55iVobUTIHyShh79qQJyzs+b
	0RdsJk9PEykYu7kCY9ODjX8WEQusY76Sxb6mR4gP+NNwEfpxc9vr5aIoayLS5OVGfFHwJOICwcOJS
	tpw3roUQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF6nr-009BKq-1L;
	Mon, 18 Dec 2023 06:08:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: std_dma40: fix kernel-doc warnings and spelling
Date: Sun, 17 Dec 2023 22:08:34 -0800
Message-ID: <20231218060834.19222-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct kernel-doc warnings as reported by kernel test robot:

ste_dma40.c:57: warning: Excess struct member 'dev_tx' description in 'stedma40_platform_data'
ste_dma40.c:57: warning: Excess struct member 'dev_rx' description in 'stedma40_platform_data'

Correct spellos as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312171417.izbQThoU-lkp@intel.com/
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/ste_dma40.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff -- a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -31,13 +31,11 @@
 /**
  * struct stedma40_platform_data - Configuration struct for the dma device.
  *
- * @dev_tx: mapping between destination event line and io address
- * @dev_rx: mapping between source event line and io address
  * @disabled_channels: A vector, ending with -1, that marks physical channels
  * that are for different reasons not available for the driver.
  * @soft_lli_chans: A vector, that marks physical channels will use LLI by SW
  * which avoids HW bug that exists in some versions of the controller.
- * SoftLLI introduces relink overhead that could impact performace for
+ * SoftLLI introduces relink overhead that could impact performance for
  * certain use cases.
  * @num_of_soft_lli_chans: The number of channels that needs to be configured
  * to use SoftLLI.
@@ -184,7 +182,7 @@ static __maybe_unused u32 d40_backup_reg
 
 /*
  * since 9540 and 8540 has the same HW revision
- * use v4a for 9540 or ealier
+ * use v4a for 9540 or earlier
  * use v4b for 8540 or later
  * HW revision:
  * DB8500ed has revision 0
@@ -411,7 +409,7 @@ struct d40_desc {
  *
  * @base: The virtual address of LCLA. 18 bit aligned.
  * @dma_addr: DMA address, if mapped
- * @base_unaligned: The orignal kmalloc pointer, if kmalloc is used.
+ * @base_unaligned: The original kmalloc pointer, if kmalloc is used.
  * This pointer is only there for clean-up on error.
  * @pages: The number of pages needed for all physical channels.
  * Only used later for clean-up on error
@@ -1655,7 +1653,7 @@ static void dma_tasklet(struct tasklet_s
 
 	return;
  check_pending_tx:
-	/* Rescue manouver if receiving double interrupts */
+	/* Rescue maneuver if receiving double interrupts */
 	if (d40c->pending_tx > 0)
 		d40c->pending_tx--;
 	spin_unlock_irqrestore(&d40c->lock, flags);
@@ -3412,7 +3410,7 @@ static int __init d40_lcla_allocate(stru
 		base->lcla_pool.base = (void *)page_list[i];
 	} else {
 		/*
-		 * After many attempts and no succees with finding the correct
+		 * After many attempts and no success with finding the correct
 		 * alignment, try with allocating a big buffer.
 		 */
 		dev_warn(base->dev,

