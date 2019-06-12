Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355004259E
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfFLM0N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 08:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfFLM0N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 08:26:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC1220874;
        Wed, 12 Jun 2019 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342372;
        bh=iniz35gqj7tTuYVqxCIYwTN/MkFFwRWSu9rRvy9EH2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFYUsRAWcnKQGMGBykNaoz2re/szbNRV88+h4atxRPofnC4m6fc0sB/8beHjFTfZ+
         FAJ2k/Xx1uz5Sz2/+b2O/QAsEB/oUJHb2hgzny9o+zUArvNj8tsvzYj8FH1nWDaN6i
         WL8tS1nEz9HPbZgOlNhfh+2peOfM806lvU8bEyH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dma: coh901318: no need to cast away call to debugfs_create_file()
Date:   Wed, 12 Jun 2019 14:25:54 +0200
Message-Id: <20190612122557.24158-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612122557.24158-1-gregkh@linuxfoundation.org>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No need to check the return value of debugfs_create_file(), so no need
to provide a fake "cast away" of the return value either.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/coh901318.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 547786ac342b..e51d836afcc7 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1378,10 +1378,8 @@ static int __init init_coh901318_debugfs(void)
 
 	dma_dentry = debugfs_create_dir("dma", NULL);
 
-	(void) debugfs_create_file("status",
-				   S_IFREG | S_IRUGO,
-				   dma_dentry, NULL,
-				   &coh901318_debugfs_status_operations);
+	debugfs_create_file("status", S_IFREG | S_IRUGO, dma_dentry, NULL,
+			    &coh901318_debugfs_status_operations);
 	return 0;
 }
 
-- 
2.22.0

