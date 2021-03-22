Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09B3444F7
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 14:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhCVNJn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhCVNIw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Mar 2021 09:08:52 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94B29C061756;
        Mon, 22 Mar 2021 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=sHJzoveTSv
        t6lzJJYtkZFvsbbLRnHZNaMV5XbRZgAUY=; b=W+TzCSRvr8HjcAyW2azP4SuREb
        o7JF5Db2NBPgLbnBKg+d6kRkFvP66Q9vU9P5z2EiAeWLodKKvRpw4wEgozCTeWyp
        K36xMLMdyfSsS1sYYrPotMRm45GJBMK4L3XlSv72pPhJ8Kbu1qXEDL1rqfkTaOZj
        vTLIvNKfJCTQIDEWQ=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn7U3XllhgLsoNAA--.4684S4;
        Mon, 22 Mar 2021 21:08:39 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] dma: Fix a double free in dma_async_device_register
Date:   Mon, 22 Mar 2021 06:08:36 -0700
Message-Id: <20210322130836.4252-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDn7U3XllhgLsoNAA--.4684S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW8tw4UCFWfXFykKF45Jrb_yoWfCFb_CF
        10vryxur1qkryfCa43Jr9xZr1Fy34qgFZagw1xtF1xWa47Xa9Fgr4qkrnayw17KFyUCFWv
        934jqFWfAF4xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjfUnsqWUUUUU
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In dma_async_device_register, in the loop
list_for_each_entry(chan, &device->channels, device_node).
If __dma_async_device_channel_register(device, chan) failed
and it colud free chan->local and return err.

But in the err_out branch, it will free chan->local again.
My patch sets chan->local to NULL after it is freed in
__dma_async_device_channel_register().

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/dma/dmaengine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index fe6a460c4373..af3ee288bc11 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1086,6 +1086,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	kfree(chan->dev);
  err_free_local:
 	free_percpu(chan->local);
+	chan->local = NULL;
 	return rc;
 }
 
-- 
2.25.1


