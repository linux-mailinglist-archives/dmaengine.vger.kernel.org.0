Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70A159EAA1
	for <lists+dmaengine@lfdr.de>; Tue, 23 Aug 2022 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiHWSM7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Aug 2022 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiHWSMi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Aug 2022 14:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E329C2D6
        for <dmaengine@vger.kernel.org>; Tue, 23 Aug 2022 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661271882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZInkH65kXXJrl1np4vOxGvfc6E02VGBPw4illArQKwk=;
        b=XZF6RNByb/QcamLklY/rdK9GhlcDomZm/pIeSsm+LI6czKyIJMt0U5TozjKoUBi75QlZmf
        MVFdIbKhEL6rGUlnHrq4EWTyz5/rzO2TEFmK2GC3iHh26HJ53nO6bEOOfbK7XgmkiZfvgI
        ZfayICDIc/7HC1/yU1bSI0rVWhE2S5o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-b1M910_7MUWejWr76gIR-Q-1; Tue, 23 Aug 2022 12:24:38 -0400
X-MC-Unique: b1M910_7MUWejWr76gIR-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4C7A3C0E20F;
        Tue, 23 Aug 2022 16:24:37 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC964010D2A;
        Tue, 23 Aug 2022 16:24:37 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH] idxd: avoid deadlock in process_misc_interrupts()
Date:   Tue, 23 Aug 2022 09:24:35 -0700
Message-Id: <20220823162435.2099389-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

idxd_device_clear_state() now grabs the idxd->dev_lock
itself, so don't grab the lock prior to calling it.

This was seen in testing after dmar fault occurred on system,
resulting in lockup stack traces.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/dma/idxd/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 743ead5ebc57..5b9921475be6 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -324,13 +324,11 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			idxd->state = IDXD_DEV_HALTED;
 			idxd_wqs_quiesce(idxd);
 			idxd_wqs_unmap_portal(idxd);
-			spin_lock(&idxd->dev_lock);
 			idxd_device_clear_state(idxd);
 			dev_err(&idxd->pdev->dev,
 				"idxd halted, need %s.\n",
 				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
 				"FLR" : "system reset");
-			spin_unlock(&idxd->dev_lock);
 			return -ENXIO;
 		}
 	}
-- 
2.37.2

