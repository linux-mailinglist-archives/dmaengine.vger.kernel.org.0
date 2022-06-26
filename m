Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F455AF43
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jun 2022 07:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiFZFQ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Jun 2022 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiFZFQ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Jun 2022 01:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B72D211812
        for <dmaengine@vger.kernel.org>; Sat, 25 Jun 2022 22:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656220615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqqLkZ8qs63LGYXJWLYH7qSzKVlxiJgdi7CcXHtcQxE=;
        b=LNX12RHBJvdM477KpcXNh83wI+UNygkAECYHkRcjaRKfDhRshuadsiyma/Ke5b5wzq5oRK
        6sqEfEBXWS2QAm9ZydfoU0h2Zuj5JaoYHdewU9qcsaTTAcZXJF1r0nPra+G5E9XBSXmwVL
        1zgOy9b1YeLEPaCgP8PrDOZXVnuD7VU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-_A4Pmc9OPFqg63sX1_jbWg-1; Sun, 26 Jun 2022 01:16:52 -0400
X-MC-Unique: _A4Pmc9OPFqg63sX1_jbWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B078D803524;
        Sun, 26 Jun 2022 05:16:51 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07FC22026D64;
        Sun, 26 Jun 2022 05:16:50 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3] dmaengine: idxd: Only call idxd_enable_system_pasid() if succeeded in enabling SVA feature
Date:   Sat, 25 Jun 2022 22:16:48 -0700
Message-Id: <20220626051648.14249-1-jsnitsel@redhat.com>
In-Reply-To: <20220625221333.214589-1-jsnitsel@redhat.com>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On a Sapphire Rapids system if boot without intel_iommu=on, the IDXD
driver will crash during probe in iommu_sva_bind_device().

[   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
[   21.445108] #PF: supervisor read access in kernel mode
[   21.450912] #PF: error_code(0x0000) - not-present page
[   21.456706] PGD 0
[   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
[   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
[   21.464015] Workqueue: events work_for_cpu_fn
[   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
[   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
[   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
[   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
[   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
[   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
[   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
[   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
[   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
[   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
[   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   21.464078] PKRU: 55555554
[   21.464079] Call Trace:
[   21.464083]  <TASK>
[   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
[   21.464121]  local_pci_probe+0x3e/0x80
[   21.464132]  work_for_cpu_fn+0x13/0x20
[   21.464136]  process_one_work+0x1c4/0x380
[   21.464143]  worker_thread+0x1ab/0x380
[   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
[   21.464158]  ? process_one_work+0x380/0x380
[   21.464161]  kthread+0xe6/0x110
[   21.464168]  ? kthread_complete_and_exit+0x20/0x20
[   21.464172]  ret_from_fork+0x1f/0x30

iommu_sva_bind_device() requires SVA has been enabled successfully on
the IDXD device before it's called. Otherwise, iommu_sva_bind_device()
will access a NULL pointer. If Intel IOMMU is disabled, SVA cannot be
enabled and thus idxd_enable_system_pasid() and iommu_sva_bind_device()
should not be called.

Fixes: 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling")
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lore.kernel.org/dmaengine/20220623170232.6whonfjuh3m5vcoy@cantor/
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v3: Move changelog. Add lore link. Remove you.
v2: Balance braces on if else block. Fix up commit description.

 drivers/dma/idxd/init.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 355fb3ef4cbf..aa3478257ddb 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -512,15 +512,16 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
+		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA)) {
 			dev_warn(dev, "Unable to turn on user SVA feature.\n");
-		else
+		} else {
 			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
 
-		if (idxd_enable_system_pasid(idxd))
-			dev_warn(dev, "No in-kernel DMA with PASID.\n");
-		else
-			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+			if (idxd_enable_system_pasid(idxd))
+				dev_warn(dev, "No in-kernel DMA with PASID.\n");
+			else
+				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+		}
 	} else if (!sva) {
 		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
-- 
2.36.1

