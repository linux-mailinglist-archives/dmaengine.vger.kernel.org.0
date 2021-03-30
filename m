Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55B34E3D7
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 11:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhC3JCU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhC3JCD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 05:02:03 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8AB4C061762;
        Tue, 30 Mar 2021 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=jVd5Fj47PE
        AEha0HxIJGwUYTFQoLyWB97glqQoEC1No=; b=On6BM+sBlxe/M3e/opvNqT11Fw
        qDsvFMqyAs1PPWL3ZW2+aOQYLVs1t/QAqDp4XAlQwt7G7KO0X38cNkFQafeo7YiQ
        OKMXzLB53y+6udU8yteaqQKuLcwILyRyzB8uyHNohD6PqmRtheBizCChtyhW6SHz
        kUOL6IqT91u8PFZTY=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHz6cA6WJgVRxvAA--.97S4;
        Tue, 30 Mar 2021 17:01:52 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     vkoul@kernel.org, dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] dma: Fix a double free in dma_async_device_register
Date:   Tue, 30 Mar 2021 02:01:49 -0700
Message-Id: <20210330090149.13476-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDHz6cA6WJgVRxvAA--.97S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kKw4kGr4kXF17GF17ZFb_yoW8XF15pr
        ZxGa43GFWjqa15ZF47Xr15ZFyUW3Z8t3yF93yqkw12krZxXr929w48t3yj9a4DJw43JF4f
        KF98J34fuFsrCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUS0P-UUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the first list_for_each_entry() macro of dma_async_device_register,
it gets the chan from list and calls __dma_async_device_channel_register
(..,chan). We can see that chan->local is allocated by alloc_percpu() and
it is freed chan->local by free_percpu(chan->local) when
__dma_async_device_channel_register() failed.

But after __dma_async_device_channel_register() failed, the caller will
goto err_out and freed the chan->local in the second time by free_percpu().

The cause of this problem is forget to set chan->local to NULL when
chan->local was freed in __dma_async_device_channel_register(). My
patch sets chan->local to NULL when the callee failed to avoid double free.

Fixes: d2fb0a0438384 ("dmaengine: break out channel registration")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/dma/dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index fe6a460c4373..fef64b198c95 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1249,8 +1249,10 @@ int dma_async_device_register(struct dma_device *device)
 	/* represent channels in sysfs. Probably want devs too */
 	list_for_each_entry(chan, &device->channels, device_node) {
 		rc = __dma_async_device_channel_register(device, chan);
-		if (rc < 0)
+		if (rc < 0) {
+			chan->local = NULL;
 			goto err_out;
+		}
 	}
 
 	mutex_lock(&dma_list_mutex);
-- 
2.25.1


