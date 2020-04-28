Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA21BC074
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgD1OCV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgD1OCV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Apr 2020 10:02:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26BC03C1A9;
        Tue, 28 Apr 2020 07:02:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so24791444wrs.9;
        Tue, 28 Apr 2020 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9HT9T3sVHrOZBKILD60eSWOeR7JckWoGT8oUYZeX9Q=;
        b=CcrNKsQmYZEf3NJD8agcFLjHTZi1rvPaBCHnAdcj+baOML9Q5IG0Txpw1bJYzdID91
         JT9gP8oPNHy1fwNWFTd+Hi+gOTxz4wW97RrhqWKk2dPTJi4xs3TaGley4t5T6A+okJ9C
         vHn3dAHEWrW53/MUVoaRq/be5DRfBUtZgGtRE8mH4G6NagVOU05HSBH5XvBCjC161Z/W
         l6A5mJ/RM+zRKhYV22LibAL2kxcd9Tj59LVUaqha/TPU9HXaOPxJdXDRkHKbH5hKmg8x
         6J7X/SaK8sQfvfCjbc6WKb81cTzPwsKLcQ5J/WjL/3InRPRbXTYo12eSW3rQPaV4dGCX
         k0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9HT9T3sVHrOZBKILD60eSWOeR7JckWoGT8oUYZeX9Q=;
        b=W886HwUcvwLBdHC8zN9x4h8wgMrv4onz4U9QYQDIDj+QvtvD6JG//qP/X40aPd6GSG
         eYVx5WuS50sbXQkBnnpptI51MYRjx2Lq3MzuB1+pTQxyJG+EXgJZUXRjTAGdkk4yZMhG
         oPL3fenTBH75+OZ1pf5C047a0U8YA0RlKT/W0MBdFP82dqY59JvXshDhPyUcesrbsXUd
         5zNqUXO92cYfh61ur42aBQdNUm5OpFwlAj4coCgI0uPOkJr9XY36BZ7ZZUAz3BL6gKVI
         8aE3y/CawFwDxHPWSkvPu19Pfk88KNx9pPtB4sKjToX778/WrYLUyQ5l/64j3x77F1wM
         e0GA==
X-Gm-Message-State: AGi0PubY5eUCRlTKN1GwkaNo+vqWkAuB9JGZSL66xrjx6CfF6dyxQoF+
        08TuSOfYAvZCATQcaCErAmM=
X-Google-Smtp-Source: APiQypLRZbfVvn+LjlIVs1TeRB/k7VtV33DqhcgyNIGIp4giTYfqrW3Di+Sa7+pgoPyR6/3Lm9NLpg==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr34207544wrq.306.1588082540040;
        Tue, 28 Apr 2020 07:02:20 -0700 (PDT)
Received: from localhost.localdomain ([188.24.130.199])
        by smtp.gmail.com with ESMTPSA id b191sm3788677wmd.39.2020.04.28.07.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 07:02:19 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dma: actions: Fix lockdep splat for owl-dma
Date:   Tue, 28 Apr 2020 17:02:17 +0300
Message-Id: <7d503c3dcac2b3ef29d4122a74eacfce142a8f98.1588069418.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When the kernel is build with lockdep support and the owl-dma driver is
used, the following message is shown:

[    2.496939] INFO: trying to register non-static key.
[    2.501889] the code is fine but needs lockdep annotation.
[    2.507357] turning off the locking correctness validator.
[    2.512834] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.6.3+ #15
[    2.519084] Hardware name: Generic DT based system
[    2.523878] Workqueue: events_freezable mmc_rescan
[    2.528681] [<801127f0>] (unwind_backtrace) from [<8010da58>] (show_stack+0x10/0x14)
[    2.536420] [<8010da58>] (show_stack) from [<8080fbe8>] (dump_stack+0xb4/0xe0)
[    2.543645] [<8080fbe8>] (dump_stack) from [<8017efa4>] (register_lock_class+0x6f0/0x718)
[    2.551816] [<8017efa4>] (register_lock_class) from [<8017b7d0>] (__lock_acquire+0x78/0x25f0)
[    2.560330] [<8017b7d0>] (__lock_acquire) from [<8017e5e4>] (lock_acquire+0xd8/0x1f4)
[    2.568159] [<8017e5e4>] (lock_acquire) from [<80831fb0>] (_raw_spin_lock_irqsave+0x3c/0x50)
[    2.576589] [<80831fb0>] (_raw_spin_lock_irqsave) from [<8051b5fc>] (owl_dma_issue_pending+0xbc/0x120)
[    2.585884] [<8051b5fc>] (owl_dma_issue_pending) from [<80668cbc>] (owl_mmc_request+0x1b0/0x390)
[    2.594655] [<80668cbc>] (owl_mmc_request) from [<80650ce0>] (mmc_start_request+0x94/0xbc)
[    2.602906] [<80650ce0>] (mmc_start_request) from [<80650ec0>] (mmc_wait_for_req+0x64/0xd0)
[    2.611245] [<80650ec0>] (mmc_wait_for_req) from [<8065aa10>] (mmc_app_send_scr+0x10c/0x144)
[    2.619669] [<8065aa10>] (mmc_app_send_scr) from [<80659b3c>] (mmc_sd_setup_card+0x4c/0x318)
[    2.628092] [<80659b3c>] (mmc_sd_setup_card) from [<80659f0c>] (mmc_sd_init_card+0x104/0x430)
[    2.636601] [<80659f0c>] (mmc_sd_init_card) from [<8065a3e0>] (mmc_attach_sd+0xcc/0x16c)
[    2.644678] [<8065a3e0>] (mmc_attach_sd) from [<8065301c>] (mmc_rescan+0x3ac/0x40c)
[    2.652332] [<8065301c>] (mmc_rescan) from [<80143244>] (process_one_work+0x2d8/0x780)
[    2.660239] [<80143244>] (process_one_work) from [<80143730>] (worker_thread+0x44/0x598)
[    2.668323] [<80143730>] (worker_thread) from [<8014b5f8>] (kthread+0x148/0x150)
[    2.675708] [<8014b5f8>] (kthread) from [<801010b4>] (ret_from_fork+0x14/0x20)
[    2.682912] Exception stack(0xee8fdfb0 to 0xee8fdff8)
[    2.687954] dfa0:                                     00000000 00000000 00000000 00000000
[    2.696118] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.704277] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000

The required fix is to use spin_lock_init() on the pchan lock before
attempting to call any spin_lock_irqsave() in owl_dma_get_pchan().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/dma/owl-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index c683051257fd..d9d0f0488e70 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1131,6 +1131,7 @@ static int owl_dma_probe(struct platform_device *pdev)
 
 		pchan->id = i;
 		pchan->base = od->base + OWL_DMA_CHAN_BASE(i);
+		spin_lock_init(&pchan->lock);
 	}
 
 	/* Init virtual channel */
-- 
2.26.2

