Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2713C2C
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfEDVeo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 17:34:44 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53408 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfEDVeo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 May 2019 17:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1557005681; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=9tfzvKOm06A4jddn7oON/GilMXhUArEom3wLurTW5hg=;
        b=UZf/GesyoH5Q8sDs2UILRSJyV7IFuCJCu7swQTIx1ovZSTEJYC0yLHmmbRrp3KmNS7fsm7
        uA4HG+9Bbzzfhlz2n/gScElily81umHwvTTtty06lrLP0LDat+RGbJJWOFIVHEQkYQxRDB
        /hGRZf8K6rVQRvqn+Iin+klLZvKRz0U=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] dmaengine: jz4780: Use SPDX license notifier
Date:   Sat,  4 May 2019 23:34:32 +0200
Message-Id: <20190504213432.6356-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use SPDX license notifier instead of plain text in the header.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 9ce0a386225b..02075417c69f 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Ingenic JZ4780 DMA controller
  *
  * Copyright (c) 2015 Imagination Technologies
  * Author: Alex Smith <alex@alex-smith.me.uk>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/clk.h>
-- 
2.21.0.593.g511ec345e18

