Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC59E1C272E
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2020 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgEBRQB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 May 2020 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728342AbgEBRQA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 2 May 2020 13:16:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3CDC061A0C;
        Sat,  2 May 2020 10:16:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so15696290wrx.4;
        Sat, 02 May 2020 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PIv3g2HbrGzdAz/fXXsONdZmu8F6RevQt0D1oDmLho=;
        b=gV2H5xW2mTm8uTHZxOra8ob6JuAmi+h8HkRMipd8wXZ39Cl03adTXtuChzdjwVBSqF
         T7DTCpK499L13ogQPCODo8zyTDIWQ76Tz5oqsTfbpYK6PG9lo7kHlb2q9swyz2N8HdXU
         I/91hszWw5NKt63LjSaIHT+1bKVHdthB2Gh+gAJKYd8BaDK5sVG32omy1ajV5qdQu1jR
         pSOTekjzBaOHFNJJGxQgRiP2Kv7YSXmGmDNTZ0XouvsoW9j755qByUUsKtTm82DtFs3+
         WJGEXXPvnnhguH+LqS0Lk/X7kFXITvV9HJMXY11u/TvpixyqRllu2AnH4NxUpFNqt8HN
         F/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PIv3g2HbrGzdAz/fXXsONdZmu8F6RevQt0D1oDmLho=;
        b=r8MK6SM/943HCYeOoEMPzfRNZaVnBqA2dPBaYm7gYgyhYzQIZ61yQdbX0CjsQ/JMw6
         Gk1RaMd9gmtfjn+x23QgGSypRU9viV6cFnnt3Saky4up8NGZyQzGmfjqCqtMYtsqKB9z
         5CVZ56+zVQ6VoxevXTzo2AI3/FAfI33ZQkg7RdpqMxD4yg7pU+eEPVHMe84+nl261Q2k
         mNeYlS9P2Z72NziwrLEcZ5B6f3Di8GcdJ0LmvX8hb8zAf4n54R7/ZtB69NwMmIZUgHqy
         qAdEUwV2QWZ2t97Yjqo7/Lx2bX4zxjf4nOC03cK8/zMjTXxdwOjYBo9csiZ4wIhB0mjt
         tXWA==
X-Gm-Message-State: AGi0PubWyG2GXjBDryUJG4G0IT3k0J3680KaTUVzbfXG38sL49w2CrOj
        YBvmtW8TAJwBqtRC5gPS8F4=
X-Google-Smtp-Source: APiQypJbj1yl/89EsQl/nrkDrS2TuUaoAtTtpOQQOr9z/uF7PiIxOkiRtxQr8HtZ77MS6EtBt2jRAA==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr9916966wru.258.1588439753785;
        Sat, 02 May 2020 10:15:53 -0700 (PDT)
Received: from localhost.localdomain ([188.24.130.199])
        by smtp.gmail.com with ESMTPSA id k14sm10142090wrp.53.2020.05.02.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 10:15:53 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] dmaengine: owl: Use correct lock in owl_dma_get_pchan()
Date:   Sat,  2 May 2020 20:15:51 +0300
Message-Id: <c6e6cdaca252b5364bd294093673951036488cf0.1588439073.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
'owl_dma_terminate_pchan()'.

Therefore, this patch substitutes 'pchan->lock' with 'od->lock' and
removes the 'lock' attribute in 'owl_dma_pchan' struct.

Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA
driver")

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Andreas Färber <afaerber@suse.de>
---
Changes in v4:
* Change patch title from 'dma: actions: Fix lockdep splat for owl-dma'
  to 'dmaengine: owl: Use correct lock in owl_dma_get_pchan()'
* Add Fixes and Acked-by tags in the commit message

Changes in v3:
* Get rid of the kerneldoc comment for the removed struct attribute
* Add the Reviewed-by tag in the commit message

Changes in v2:
* Improve the fix as suggested by Manivannan Sadhasivam: substitute
  'pchan->lock' with 'od->lock' and get rid of the 'lock' attribute in
  'owl_dma_pchan' struct
* Update the commit message to reflect the changes

 drivers/dma/owl-dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index c683051257fd..66ef70b00ec0 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -175,13 +175,11 @@ struct owl_dma_txd {
  * @id: physical index to this channel
  * @base: virtual memory base for the dma channel
  * @vchan: the virtual channel currently being served by this physical channel
- * @lock: a lock to use when altering an instance of this struct
  */
 struct owl_dma_pchan {
 	u32			id;
 	void __iomem		*base;
 	struct owl_dma_vchan	*vchan;
-	spinlock_t		lock;
 };
 
 /**
@@ -437,14 +435,14 @@ static struct owl_dma_pchan *owl_dma_get_pchan(struct owl_dma *od,
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

