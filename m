Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83326B005
	for <lists+dmaengine@lfdr.de>; Tue, 15 Sep 2020 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgIOV4e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Sep 2020 17:56:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34734 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728086AbgIOV4T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Sep 2020 17:56:19 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E9F89C008F;
        Tue, 15 Sep 2020 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600206976; bh=BculKQP67AioWF1xXTen5cFzZ7cDzk664YnlbM6m2O0=;
        h=From:To:Cc:Subject:Date:From;
        b=irn7P3/GkHyp1gCcMTXaI2Yiq4MqClwY65UibL1LI6GbmCLG9VUjXJ7iUOJ4nj44h
         gsxL8ngnmK8WEk/boCXfwF3uFacgHZQcMe1oP8Ftkvp2Ca/+4NNjAlAxO22mgjbmFg
         F0+k+hO5rDIorSy5dSAd1zP/M+ru+rUPFb0+wD7vTT5mgoP2DDKHlzIfGRN64lXPJI
         fEZwh30X55X6b++36Zs0r0X8jsJxVxvdY9110Ztvwdn5/mpaBacJiE85iW/Fufyyqd
         03jqvgNIaZfc35a6H34NuBArOOKRyBOSsDJFkt6ENQcN/JVGVGGVsc5lhOffSdLaLj
         Kfq0riV3krinw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 623DEA005D;
        Tue, 15 Sep 2020 21:56:14 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] dmaengine: dw-edma: Fix Using plain integer as NULL pointer in dw-edma-v0-debugfs.c
Date:   Tue, 15 Sep 2020 23:56:11 +0200
Message-Id: <6569fd8ca5ddaa73afef1241ad7978c2a1fae0c7.1600206938.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes warning given by executing "make C=2 drivers/dma/dw-edma/"

Sparse output:
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:296:49: warning:
 Using plain integer as NULL pointer

Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 4273950..6f62711 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -293,7 +293,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!regs)
 		return;
 
-	base_dir = debugfs_create_dir(dw->name, 0);
+	base_dir = debugfs_create_dir(dw->name, NULL);
 	if (!base_dir)
 		return;
 
-- 
2.7.4

