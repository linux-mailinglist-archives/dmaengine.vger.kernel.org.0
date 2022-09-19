Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B05BD6A7
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 23:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiISV4H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiISV4E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 17:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E69140BE5
        for <dmaengine@vger.kernel.org>; Mon, 19 Sep 2022 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663624561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2UQjbjDuL+dUocjGeE3maRoix0WBciL3m26Z3iqlyY=;
        b=Gd6WvjqdgUX4DiyaaY44umsCHQIuGvBSM3ADxx2dqs2gHvy4Hc1ZshLNC1arsnYbBcVDmX
        FiGDYbWy6uEjYxcmeOpG/cxhuiPPYf0Mr1WQfs/8UP64IjZT9nP9n5ya4gNvu7TaCOT3RD
        VVyIeW/uPpaTbhl67eBmQRDHcod9PM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-7eO7XFZFPT-zzrXSXBiyOQ-1; Mon, 19 Sep 2022 17:55:57 -0400
X-MC-Unique: 7eO7XFZFPT-zzrXSXBiyOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67900101245C;
        Mon, 19 Sep 2022 21:55:56 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C975C40C2064;
        Mon, 19 Sep 2022 21:55:55 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/2] dmaengine: idxd: Set wq state to disabled in idxd_wq_disable_cleanup()
Date:   Mon, 19 Sep 2022 14:55:52 -0700
Message-Id: <20220919215553.600246-2-jsnitsel@redhat.com>
In-Reply-To: <20220919215553.600246-1-jsnitsel@redhat.com>
References: <20220919215553.600246-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If we are calling idxd_wq_disable_cleanup(), the workqueue should be
in a disabled state. So set the workqueue state to IDXD_WQ_DISABLED so
that the state reflects that. Currently if there is a device failure,
and a software reset is attempted the workqueues will not be
re-enabled due to idxd_wq_enable() seeing that state as already being
IDXD_WQ_ENABLED.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/dma/idxd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5a8cc52c1abf..31911e255ac1 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -258,7 +258,6 @@ void idxd_wq_reset(struct idxd_wq *wq)
 	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
 	idxd_wq_disable_cleanup(wq);
-	wq->state = IDXD_WQ_DISABLED;
 }
 
 int idxd_wq_map_portal(struct idxd_wq *wq)
@@ -378,6 +377,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 
 	lockdep_assert_held(&wq->wq_lock);
+	wq->state = IDXD_WQ_DISABLED;
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
 	wq->type = IDXD_WQT_NONE;
 	wq->threshold = 0;
-- 
2.37.2

