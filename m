Return-Path: <dmaengine+bounces-3050-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376596708B
	for <lists+dmaengine@lfdr.de>; Sat, 31 Aug 2024 11:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE0D284399
	for <lists+dmaengine@lfdr.de>; Sat, 31 Aug 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29028174EE4;
	Sat, 31 Aug 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooJAng5e"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82273C30;
	Sat, 31 Aug 2024 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097488; cv=none; b=q4aec9MntQL/wfja1tLGYhix5CUtjwaeELqtZYxQwNUec/WmrJZ7b3H4TcpnSUfWu6rSGfWeXL+ByyOOfMqKLEaE4oTHD6gh2y0+pPDeXbGNvkwnrSA+ID6rCY73tJjrdPht0tMVj5dx7zWpHhVY8sK6IezLXw1hZ5YFh5iHHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097488; c=relaxed/simple;
	bh=KDQzyOkkwbrujyqTmmY2hPMlm6qYeDDhHK/LgLyZBls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XHQZRJyvtPzIRiSv4nwNLCpYpTtx93sxqaMP1JCMS7JV3lVy07nryxa2pMiQuT58KSBEQ7P7Z61lzthoybTtwxidf37rPHTA3u9Jsta/WXLtibLdxgAuJYpaJJX98+JuUHL9xwnBl3+4hbZ72ByxA0oqqK6Bk5740SK4IFgNCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooJAng5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73FFCC4CEC0;
	Sat, 31 Aug 2024 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725097487;
	bh=KDQzyOkkwbrujyqTmmY2hPMlm6qYeDDhHK/LgLyZBls=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ooJAng5e2s4bvrOrx1lE6lgF544n67+MLnDNZavXoMQuHCBLdoeZ+ZJ8/ZFbqqc5j
	 Xd1hpHoyJ4zni74cFCYC/nW+6yyCzqg7tCGBGkOoJype0rlhOxUNxyyNh06RB7P0m5
	 P5xBOKZ6s0NSpWBBsPhoiD9S/sP/FcShBo7yGSQuM3dF20J4c3kDjhlfV8y/MnF9fA
	 QOUNSGceUvdNV8F7/G1CzcIr4hBuQ1GEDHBUOawazL639OvF8tGC3r5zwovFlubxJ5
	 bKcYKJw3WetlA02HSsvanT4S8iudRyMrR2HHOafcC5KZMAX3Wzwa5zSdLyHAodyHzs
	 wA0+FWGcXObkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52558CA1018;
	Sat, 31 Aug 2024 09:44:47 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Sat, 31 Aug 2024 17:41:09 +0800
Subject: [PATCH] dmaengine: loongson1-apb-dma: Fix the build warning caused
 by the size of pdev_irqname
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240831-fix-loongson1-dma-v1-1-91376d87695c@gmail.com>
X-B4-Tracking: v=1; b=H4sIADTl0mYC/x2MQQqAIBAAvyJ7bsG1oOgr0UF0q4XSUIhA/HvSc
 WBmCmROwhlmVSDxI1liaECdAnfYsDOKbwxGm0FPPeEmL54xhj3HQOgvi9s42d5pr4kIWncnbtL
 /XNZaPwxfKyFjAAAA
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725097485; l=2069;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=9F7l316ps9HN6pWRl3U35o6ZL8rlcyn9cYcUpzY8XIk=;
 b=q0fD0o+6qKstKnpPMNAUzLR8RiMcfvfrzXUgn/Py5cvAoOcaqibaJjDj6Wuz2FVZ1p8I+Nj22
 2WIq9qcO7t+DZ6lfXoQscu7uebAmAmmQeuOb1EdwU+zn3S7QpMMEDcf
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_probe':
drivers/dma/loongson1-apb-dma.c:531:42: warning: '%d' directive writing between 1 and 8 bytes into a region of size 2 [-Wformat-overflow=]
  531 |                 sprintf(pdev_irqname, "ch%d", id);
      |                                          ^~
In function 'ls1x_dma_chan_probe',
    inlined from 'ls1x_dma_probe' at drivers/dma/loongson1-apb-dma.c:605:8:
drivers/dma/loongson1-apb-dma.c:531:39: note: directive argument in the range [0, 19522579]
  531 |                 sprintf(pdev_irqname, "ch%d", id);
      |                                       ^~~~~~
drivers/dma/loongson1-apb-dma.c:531:17: note: 'sprintf' output between 4 and 11 bytes into a destination of size 4
  531 |                 sprintf(pdev_irqname, "ch%d", id);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix the array size and use snprintf() instead of sprintf().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408302108.xIR18jmD-lkp@intel.com/
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/dma/loongson1-apb-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-dma.c
index ca43c67a8203..255fe7eca212 100644
--- a/drivers/dma/loongson1-apb-dma.c
+++ b/drivers/dma/loongson1-apb-dma.c
@@ -526,9 +526,9 @@ static int ls1x_dma_chan_probe(struct platform_device *pdev,
 
 	for (id = 0; id < dma->nr_chans; id++) {
 		struct ls1x_dma_chan *chan = &dma->chan[id];
-		char pdev_irqname[4];
+		char pdev_irqname[16];
 
-		sprintf(pdev_irqname, "ch%d", id);
+		snprintf(pdev_irqname, sizeof(pdev_irqname), "ch%d", id);
 		chan->irq = platform_get_irq_byname(pdev, pdev_irqname);
 		if (chan->irq < 0)
 			return dev_err_probe(&pdev->dev, chan->irq,

---
base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
change-id: 20240831-fix-loongson1-dma-f78a3c0d0111

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



