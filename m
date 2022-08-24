Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F875A021C
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 21:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiHXT31 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiHXT3X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 15:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665C78BDE
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661369361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1madC+R9UQ0sdGYZ6Rb4RFre0WnX4XbXDajpRgvIHys=;
        b=COdi4NnHSRJEU0nDtZoePDO9AH/VM+o0a6YWnLe7ZRCJvKeXO5sNLpbUjsAcdZ7fej096/
        hkiAh8S+4J8sMOe1bA9DgMQ49TLGLjIi/7SaI4WEJ8PNqQal1z4n/pFl43nVr5Z0m95FUK
        YY2uAPHdqFv/ixPnaljUpN1KxLS+YAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-pGYwyQFlM8qip7dsuiawMg-1; Wed, 24 Aug 2022 15:29:16 -0400
X-MC-Unique: pGYwyQFlM8qip7dsuiawMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E132A18A6507;
        Wed, 24 Aug 2022 19:29:15 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 517FB492C3B;
        Wed, 24 Aug 2022 19:29:15 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Set workqueue state to disabled before trying to re-enable
Date:   Wed, 24 Aug 2022 12:29:13 -0700
Message-Id: <20220824192913.2425634-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For a software reset idxd_device_reinit() is called, which will walk
the device workqueues to see which ones were enabled, and try to
re-enable them. It keys off wq->state being iDXD_WQ_ENABLED, but the
first thing idxd_enable_wq() will do is see that the state of the
workqueue is enabled, and return 0 instead of attempting to issue
a command to enable the workqueue.

So once a workqueue is found that needs to be re-enabled,
set the state to disabled prior to calling idxd_enable_wq().
This would accurately reflect the state if the enable fails
as well.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/dma/idxd/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 743ead5ebc57..723eeb5328d6 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -52,6 +52,7 @@ static void idxd_device_reinit(struct work_struct *work)
 		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (wq->state == IDXD_WQ_ENABLED) {
+			wq->state = IDXD_WQ_DISABLED;
 			rc = idxd_wq_enable(wq);
 			if (rc < 0) {
 				dev_warn(dev, "Unable to re-enable wq %s\n",
-- 
2.37.2

