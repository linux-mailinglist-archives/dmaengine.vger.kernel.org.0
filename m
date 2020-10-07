Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B01285A87
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgJGIbs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 04:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgJGIbr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 04:31:47 -0400
Received: from localhost.localdomain (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE20E2137B;
        Wed,  7 Oct 2020 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602059506;
        bh=Tb8EhsXVCrZQ8L7rmZn17TYMuy1M9vCPuBp8lHV7LJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/FjvFxzP+sqEntTaNr9phMZTkMIkepO3JesCduAEUJDl9JTYZnIlaU1pIf1dOVAv
         0SbAHIDvr40kO0PAxkemeNpbuL2PmZtPzQjA4dPu7H73fRe+X6ZJN9G6Fg6RiGm4FC
         DV8MjtBskV8UtY3J2EUfpF3hyHZBQyQVhGjlFWMQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] dmaengine: owl-dma: fix kernel-doc style for enum
Date:   Wed,  7 Oct 2020 14:01:13 +0530
Message-Id: <20201007083113.567559-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007083113.567559-1-vkoul@kernel.org>
References: <20201007083113.567559-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Driver doesn't use keyword enum for enum owl_dmadesc_offsets resulting
in warning:

drivers/dma/owl-dma.c:139: warning: cannot understand function prototype:
'enum owl_dmadesc_offsets '

So add the keyword to fix it and also add documentation for missing
OWL_DMADESC_SIZE

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/owl-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 331c8d8b10a3..9fede32641e9 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -124,7 +124,7 @@
 #define FCNT_VAL				0x1
 
 /**
- * owl_dmadesc_offsets - Describe DMA descriptor, hardware link
+ * enum owl_dmadesc_offsets - Describe DMA descriptor, hardware link
  * list for dma transfer
  * @OWL_DMADESC_NEXT_LLI: physical address of the next link list
  * @OWL_DMADESC_SADDR: source physical address
@@ -135,6 +135,7 @@
  * @OWL_DMADESC_CTRLA: dma_mode and linklist ctrl config
  * @OWL_DMADESC_CTRLB: interrupt config
  * @OWL_DMADESC_CONST_NUM: data for constant fill
+ * @OWL_DMADESC_SIZE: max size of this enum
  */
 enum owl_dmadesc_offsets {
 	OWL_DMADESC_NEXT_LLI = 0,
-- 
2.26.2

