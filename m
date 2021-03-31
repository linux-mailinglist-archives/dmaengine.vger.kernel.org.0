Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292CC34F659
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 03:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCaBpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 21:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhCaBpL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 21:45:11 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77C53C061574;
        Tue, 30 Mar 2021 18:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=R+YO8TACOX
        GNoVNl3MxR9+6Lq0q8OS7rvRzgBfzXiNc=; b=TqqwmyGc3guTwopvJmg61IIeO1
        uESz4QtlRonocY06qNOe13nuHEfPd/HE0KDXFvr1qyHaus99TXz//zeBXKu8Lzkv
        hWVwDvCoSrjAPOrgrNkL+TYcKFWqXzp3AJupiVfd5Fo6jOwPlliIeGWTtdpOswzm
        MwG/g3fmHm5OaOvfU=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCnrU0e1GNg5J90AA--.440S4;
        Wed, 31 Mar 2021 09:45:02 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     vkoul@kernel.org, dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH v2] dma: Fix a double free in dma_async_device_register
Date:   Tue, 30 Mar 2021 18:44:58 -0700
Message-Id: <20210331014458.3944-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCnrU0e1GNg5J90AA--.440S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kKw4kGr4kXF17GF17ZFb_yoW8Jw1kpr
        sxGa45KFW2qa15ZFsxXr1FvFyUu3Z8J34F93yqyw1akrZxZr92yw48ta1j9a4DJws3JF4f
        Kas5J34fuF47Cr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
        0VAGYxC7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUmNtcUUUUU=
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


