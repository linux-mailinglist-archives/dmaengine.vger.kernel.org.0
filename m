Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2841BDA35
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2LB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2LB6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 07:01:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B9C03C1AD;
        Wed, 29 Apr 2020 04:01:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so1531018wml.2;
        Wed, 29 Apr 2020 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nuf8dwcrjX3dNT8pb1qPoIHBU9UzXx/Q2WQpqmKN7MM=;
        b=CekuV0J8SOjnr1sBAQ1Kk04qxrk1dBsmfUWYQnh2DDFeJoTaDUGViG2RIuId7BIDPe
         XAK/kkfJlabmfZSkX/aizsmqpWeVqhkY0v9IDhhXUEzak+/LG7qeYx3EDS7OtLJ/ui02
         rEED4HcY82oWEUuwAafPJTWsVr/tGaR5Bi8zV5X9sK3YL9mMKF5aeP/AozGA3AZff/ql
         uPLG1JqepjJBAWMVTqoCpKqVtJ6wwlKqMxBwPdIlmUSPBixAXQ8R9n5uHo4ytoLjjRnL
         wZOPq+XM0d9PN9nbIYqx3K3SrX5cZzQDk1goDPKSuMIaarH9D3BuOdNEc7TyJgw4egkU
         GD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nuf8dwcrjX3dNT8pb1qPoIHBU9UzXx/Q2WQpqmKN7MM=;
        b=fYVjUNCcHO/fVIcnT9DjEeDE4vUlTl9TGvq2E+vIz/5/bRsY/VnQ5NbDI5K/xdxlvs
         IsxMRxxocgUelfTELtge8n/Wfw7RheLBHOe0LLWO3ddLwpfx3xTK1fOoJs5AsTaKh6om
         7Q3ARHDyYjRL14BywW92hQa9o0Cjt7eq3KsFKBlCy/4fO1iDnTIn+EJA+y9AIS4bGQ8/
         noTKoJNxY1jcZNuEaVKjDRfeRdGkEORfdjNQLMONXTi5Wr5tDQXsIZ51Av1K/000uqd5
         qw4JtB6b0n9RxFVlI3f8FlYY0Ud9MnrMYnAYU4suNE+KyI47+oXgOtf7Zr4idYY554IK
         MW8g==
X-Gm-Message-State: AGi0PuasxeR1iDARWuaINDstPG/YrNK8yGFqstLts1kHj2VN2HwkmPYc
        Mpox3zwf9pX1has4DYXC2uGpuR3kvWk=
X-Google-Smtp-Source: APiQypKZIgGaeRSn1GVJlz0TSvMRo05dmppm5CI0NwQeQqOmRf6pYn7lHEQT8aCIzeE1xLleAYmW9A==
X-Received: by 2002:a1c:6344:: with SMTP id x65mr2661658wmb.56.1588158116628;
        Wed, 29 Apr 2020 04:01:56 -0700 (PDT)
Received: from localhost.localdomain ([188.24.130.199])
        by smtp.gmail.com with ESMTPSA id i4sm15334969wrp.79.2020.04.29.04.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:01:56 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] dma: actions: Fix lockdep splat for owl-dma
Date:   Wed, 29 Apr 2020 14:01:54 +0300
Message-Id: <1d77970a82cf9b7cdf9f4731439b1e58c37ca3fb.1588156137.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When the kernel is built with lockdep support and the owl-dma driver is
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

The obvious fix would be to use 'spin_lock_init()' on 'pchan->lock'
before attempting to call 'spin_lock_irqsave()' in 'owl_dma_get_pchan()'.

However, according to Manivannan Sadhasivam, 'pchan->lock' was supposed
to only protect 'pchan->vchan' while 'od->lock' does a similar job in
'owl_dma_terminate_pchan'.

Therefore, this patch will simply substitute 'pchan->lock' with 'od->lock'
and removes the 'lock' attribute in 'owl_dma_pchan' struct.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v2:
* Improve the fix as suggested by Manivannan Sadhasivam: substitute 
  'pchan->lock' with 'od->lock' and get rid of the 'lock' attribute in
  'owl_dma_pchan' struct
* Update the commit message to reflect the changes

 drivers/dma/owl-dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index c683051257fd..5b1c715a56c8 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -181,7 +181,6 @@ struct owl_dma_pchan {
 	u32			id;
 	void __iomem		*base;
 	struct owl_dma_vchan	*vchan;
-	spinlock_t		lock;
 };
 
 /**
@@ -437,14 +436,14 @@ static struct owl_dma_pchan *owl_dma_get_pchan(struct owl_dma *od,
 	for (i = 0; i < od->nr_pchans; i++) {
 		pchan = &od->pchans[i];
 
-		spin_lock_irqsave(&pchan->lock, flags);
+		spin_lock_irqsave(&od->lock, flags);
 		if (!pchan->vchan) {
 			pchan->vchan = vchan;
-			spin_unlock_irqrestore(&pchan->lock, flags);
+			spin_unlock_irqrestore(&od->lock, flags);
 			break;
 		}
 
-		spin_unlock_irqrestore(&pchan->lock, flags);
+		spin_unlock_irqrestore(&od->lock, flags);
 	}
 
 	return pchan;
-- 
2.26.2

