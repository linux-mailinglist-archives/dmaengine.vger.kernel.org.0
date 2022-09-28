Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966E15EE0D7
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiI1PtK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiI1PtH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 11:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE04DC110
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664380145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/fkn9zPBJpOFQKeaHKQiXdHNWX6qJBIhEOAaIwagtrc=;
        b=GrsoWNNG6NqcDvKJ1NfJ+u7g6B3oKn9ed/3cP56JOa2wkB5mkbprVNg1ZmJk/RNbVp/EJv
        aCWQxkHNwndeGpU6c9XQOhMes+TpkxapCTGAuxSXow8rA8p9GfZAwYnh2mMMdqej5BOwwg
        Sge9gl6QAxi5HO+m0PnMF2L8Y9cioxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-j9V9FJRcO3qocio5BNqKyg-1; Wed, 28 Sep 2022 11:48:59 -0400
X-MC-Unique: j9V9FJRcO3qocio5BNqKyg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B064800B30;
        Wed, 28 Sep 2022 15:48:58 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.17.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03B50492B04;
        Wed, 28 Sep 2022 15:48:57 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 0/2] dmaengine: idxd: Fix up re-enabling device workqueues
Date:   Wed, 28 Sep 2022 08:48:54 -0700
Message-Id: <20220928154856.623545-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently if a software reset is attempted on an idxd device
the workqueues will not be re-enabled, because it will see
incorrectly see that wq->state is already set to IDXD_WQ_ENABLED.
So set the workqueue state to disabled in idxd_wq_disable_cleanup(),
and use a bitmap to track which workqueues have been enabled so they
can be re-enabled during device re-initialization.

Changes from v1 to v2:
- Clear bit in case where idxd_wq_enable() fails during re-init.


Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>

Jerry Snitselaar (2):
  dmaengine: idxd: Set wq state to disabled in idxd_wq_disable_cleanup()
  dmaengine: idxd: track enabled workqueues in bitmap

 drivers/dma/idxd/device.c | 4 +++-
 drivers/dma/idxd/idxd.h   | 2 ++
 drivers/dma/idxd/init.c   | 6 ++++++
 drivers/dma/idxd/irq.c    | 5 +++--
 drivers/dma/idxd/sysfs.c  | 1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.37.2

