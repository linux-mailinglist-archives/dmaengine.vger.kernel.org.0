Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 610F34259A
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 14:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfFLM0F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 08:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfFLM0E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 08:26:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D643320874;
        Wed, 12 Jun 2019 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342364;
        bh=wczNPXZLnL6HqwLpJn7GMVKqkvkHn0jl5FDY27UAjhM=;
        h=From:To:Cc:Subject:Date:From;
        b=TaQ4iIgSMv5QJ1vtTO6Khgkel68PYje41aBD13uzeGtSPL9kAgE8UjQf4MuDURTSI
         Sgr8ByFCBOO1ky8TACxeKu2ivnxMxC13BXUHR58e2h7O9ZRwYydABgxjuat4Kgikkn
         31Uj3A1SixVnl/Jku9XJLG4MtsplSrOSX/BzWMgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dma: amba-pl08x: no need to cast away call to debugfs_create_file()
Date:   Wed, 12 Jun 2019 14:25:52 +0200
Message-Id: <20190612122557.24158-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No need to check the return value of debugfs_create_file(), so no need
to provide a fake "cast away" of the return value either.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/amba-pl08x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 464725dcad00..9adc7a2fa3d3 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2508,9 +2508,8 @@ DEFINE_SHOW_ATTRIBUTE(pl08x_debugfs);
 static void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
 {
 	/* Expose a simple debugfs interface to view all clocks */
-	(void) debugfs_create_file(dev_name(&pl08x->adev->dev),
-			S_IFREG | S_IRUGO, NULL, pl08x,
-			&pl08x_debugfs_fops);
+	debugfs_create_file(dev_name(&pl08x->adev->dev), S_IFREG | S_IRUGO,
+			    NULL, pl08x, &pl08x_debugfs_fops);
 }
 
 #else
-- 
2.22.0

