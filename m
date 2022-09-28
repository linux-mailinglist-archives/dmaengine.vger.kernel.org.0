Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214585EE0D5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiI1PtI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiI1PtC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 11:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487AD8265
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664380141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2UQjbjDuL+dUocjGeE3maRoix0WBciL3m26Z3iqlyY=;
        b=MlE/xDptKtZ2IH+HRpHKk5Ai2Av+vlvMFFX5K7wQF+Ct2fLKtlNfRSKtB1WmnDkzYnfcWO
        3u6eJzqIfA1Su1xPezE2Gc8GIRuUWoa1D3AJNpCUhuq5M6wZAphf577grlLJ4oCcw8zTOT
        4Qj0+HUoA1nUmGE8h7sfESu3a/VwjuI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-t5jp_XkXNieU8v-1jIuROw-1; Wed, 28 Sep 2022 11:48:59 -0400
X-MC-Unique: t5jp_XkXNieU8v-1jIuROw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6264C185A7AD;
        Wed, 28 Sep 2022 15:48:59 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.17.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1F41492B04;
        Wed, 28 Sep 2022 15:48:58 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 1/2] dmaengine: idxd: Set wq state to disabled in idxd_wq_disable_cleanup()
Date:   Wed, 28 Sep 2022 08:48:55 -0700
Message-Id: <20220928154856.623545-2-jsnitsel@redhat.com>
In-Reply-To: <20220928154856.623545-1-jsnitsel@redhat.com>
References: <20220928154856.623545-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

