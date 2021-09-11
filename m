Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB7640755B
	for <lists+dmaengine@lfdr.de>; Sat, 11 Sep 2021 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhIKHHE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Sep 2021 03:07:04 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:42119
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231552AbhIKHHE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Sep 2021 03:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=xcFDCKQo00
        tgnBI8uRJMu7ZJQkbd5ZBb6anV9AP3qvs=; b=AnVTgSp9cG4qwJTOBPFqjsYtxX
        bqnU3/naz2Ml3xB4DGRKiisuVl0xwJD/WMxoysscet/9R65cVcH4vF7c5TggShpY
        ag1Ux8RLQoEMvVHnbX8kyd7H5wF6mYgMGWa0M2rGNcPfre5ygqhjTyjm41yDYxNM
        VuU0274eYjC5nKCFA=
Received: from localhost.localdomain (unknown [223.104.213.26])
        by app2 (Coremail) with SMTP id XQUFCgB3f88_VTxhRrRZAA--.24021S4;
        Sat, 11 Sep 2021 15:05:42 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] drivers/dma: fix reference count leaks in mmp_pdma_probe
Date:   Sat, 11 Sep 2021 15:05:33 +0800
Message-Id: <20210911070533.3114-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XQUFCgB3f88_VTxhRrRZAA--.24021S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4xZFyDuw1UZrykuw1DGFg_yoWDtrb_Cr
        y0vr97uw1kCFnxWr1jkry3ZrySyFyvgr4agwn8Ka4fXa45XrZ7Wr4UuF1kZr17urWIyryU
        C3yvgrWxuF17CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUjCJPtUUUUU==
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiARABEFKp4zYKHQAAs5
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The issue happens in an error handling path. If
of_dma_controller_register() fails, the function simply prints error
messages and returns error code, without decrementing the reference
count of pdev->device incremented earlier by
dma_async_device_register(), which may result in refcount leaks.

Fix it by invoking dma_async_device_unregister() before returning the
error code.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/dma/mmp_pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 89f1814ff..a23563cd1 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1123,6 +1123,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 						 mmp_pdma_dma_xlate, pdev);
 		if (ret < 0) {
 			dev_err(&op->dev, "of_dma_controller_register failed\n");
+			dma_async_device_unregister(&pdev->device);
 			return ret;
 		}
 	}
-- 
2.25.1

