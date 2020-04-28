Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5775C1BBBAC
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgD1K4R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 06:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD1K4Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Apr 2020 06:56:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0765C03C1A9;
        Tue, 28 Apr 2020 03:56:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so24132865wrw.7;
        Tue, 28 Apr 2020 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9HT9T3sVHrOZBKILD60eSWOeR7JckWoGT8oUYZeX9Q=;
        b=gn9Rq/4YAsv3kVD1X98o2XKcvxM6FpneKD79RZzyslKC2FvVwRST4O++pEK8rPexzg
         r/Vl6RIQLw6FDpHqynBeALOS+dueugLcmWxumA5UrN8TSdspaht7A3+I81+umdeAKya2
         mHRYuPzt9PBiskyRzZunPj1XcPwCX+UYYZYkYqs183Z+YcYW4wr+QVbs9wHbDCEF2wkq
         4cH5kzVCdRlFdF2bEKda5tBPci53Lq6Cis4ic31b2lLeLzplNF0g8bL+Nheb5+GllcEX
         PmSIw060Lvtf3doTKh2doz5hmiI3h8+oGSHK5n79JENB65VZDnmGo7AGrWrJFP9YcFmT
         pc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9HT9T3sVHrOZBKILD60eSWOeR7JckWoGT8oUYZeX9Q=;
        b=kkpUksdtHmDrok5/S+iDOScNf2OWt/KRBxr9rZENFY+AdXQZtqKflcMCuL9R+wrn+Q
         m727SBTJkAQRKpPCHaG7rRfInJsRvwCAqNAQEgy+THaj/9oJMCLVVp3HY64oE9YH1LrH
         GsGuVagELtsY9FbMu7gmsKIFJiTR/eAMnAdtW0EsKfyrE2x81AaW4tcFMyNXvGJHMSJ4
         piNG7qx2CIZkC3z2qWHZ4rvcaBtoKpOgfofOoJiZADOi9qUhvyfXtljl0kOGSxlV07xV
         rWM54YV2no081vtcX6T8wNuBOb4/L/3xNeydGcqye8mDFx/bB/3Rgk8V/Lj6dFCqDATQ
         aIsA==
X-Gm-Message-State: AGi0PuZsHZcfMKVADngLCSBXNpshlWoDThSK3qQx/A4tn/rKDP4ZpN9K
        LjYZ6U4EmICKeVFQ+ASvdcA=
X-Google-Smtp-Source: APiQypJpMHNB4ZhFrn8kd+snTeuQ+WeBpbEdrXCMu3bKIrb14Gc+733ciOV7qgr37GnvYQfB6xcd3g==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr30244836wrw.291.1588071374527;
        Tue, 28 Apr 2020 03:56:14 -0700 (PDT)
Received: from localhost.localdomain ([188.24.130.199])
        by smtp.gmail.com with ESMTPSA id e13sm15530968wrp.15.2020.04.28.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:56:13 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dma: actions: Fix lockdep splat for owl-dma
Date:   Tue, 28 Apr 2020 13:56:12 +0300
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

