Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF802D02B4
	for <lists+dmaengine@lfdr.de>; Sun,  6 Dec 2020 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgLFKWr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 6 Dec 2020 05:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgLFKWq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 6 Dec 2020 05:22:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72861C0613D0;
        Sun,  6 Dec 2020 02:22:06 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so7004520pfb.9;
        Sun, 06 Dec 2020 02:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5q1YhPjhi7857jfqqjPqEtMBVeFBPU6hgI2ckukTgPs=;
        b=e2gu7aUr0dsKXkMrLonqFcN0weGqSwt3YihATRUVIpty6lUUE0xnsG97LGd8+hWOiq
         aUcjJtL/QQyo+dp3l5AoGabSOkOrn1lxnUfyQRdmxiVECHguWqBIyWW6R9BW34sojeV5
         3t1aAtWjt7hMQ9t11rcFepGm35c4bJTAi9mQJlIev5Q5fLsxXu/EyXqSZ98MEMRplSJl
         1QkNAlaMQLQULaf15HilnP0bPhlncWvFDDjOgPKNvnnc0ElPF8yd0Q8n5GKlXtxKrtgC
         XaeAcfiSoRguvJ5PEjlAEJhgXgcD2p+j0aQsExAKhw+x45W90iuW0+T6hlLkkDz8g36e
         FjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5q1YhPjhi7857jfqqjPqEtMBVeFBPU6hgI2ckukTgPs=;
        b=fXiJFFl6sI2eGEE2qkeBj9ta47/rmEIR3Jhe/jvO+1NUiuoVfyB38e4F4w8zzlvoQB
         4wjg27Av2By1ELl0rhiGsT/01vI7CkcgOrMGbVj52zh/chCwggPfglPnRLRKLbnsniI+
         cixQKbyK5b3EjLS7BlLJ6XHSy2GkdZBbmy8Ao3QoFU10TCPyX5rMMQQ4VtTRWlJfuBTC
         Ir6X945uhO8B1Gp4iPgkex4ZNHvu9hcWlxYLsBjqrlYU9PH7XdMCkufasbN0Lb0ZthO9
         12xSMVQoOqUYuAWDUMZ8pdBLkQgZ3DI0CuRNWdnIV1vcHBhKWyO7hootn6qxcrznxwCe
         ug8Q==
X-Gm-Message-State: AOAM532XTwIB6ja/xXhMzLu+cO959ZcaQbliynpXMlPN3IaXTe+QsuHh
        upwKc2VmpWezuIYYPJHp4qM=
X-Google-Smtp-Source: ABdhPJyr9BWiGt6ikNQEU3/OkQGYQLONw0pEXzd8dS45f7HKBZ5GuSVMWNwq9mItZlauoI5obwSZOQ==
X-Received: by 2002:a62:14a:0:b029:19d:cdca:da14 with SMTP id 71-20020a62014a0000b029019dcdcada14mr7353477pfb.31.1607250125950;
        Sun, 06 Dec 2020 02:22:05 -0800 (PST)
Received: from AHMLPT1827.ap.corp.arrow.com ([103.238.107.96])
        by smtp.googlemail.com with ESMTPSA id j11sm10375604pfe.26.2020.12.06.02.22.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:22:05 -0800 (PST)
From:   Parth Y Shah <sparth1292@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH] Fixes kernel crash generating from bam_dma_irq()
Date:   Sun,  6 Dec 2020 15:51:34 +0530
Message-Id: <1607250094-21571-1-git-send-email-sparth1292@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While performing suspend/resume, we were getting below kernel crash.

[   54.541672] [FTS][Info]gesture suspend...
[   54.605256] [FTS][Error][GESTURE]Enter into gesture(suspend) failed!
[   54.605256]
[   58.345850] irq event 10: bogus return value fffffff3
......

[   58.345966] [<ffff0000080830f0>] el1_irq+0xb0/0x124
[   58.345971] [<ffff000008085360>] arch_cpu_idle+0x10/0x18
[   58.345975] [<ffff0000081077f4>] do_idle+0x1ac/0x1e0
[   58.345979] [<ffff0000081079c8>] cpu_startup_entry+0x20/0x28
[   58.345983] [<ffff000008a80ed0>] rest_init+0xd0/0xdc
[   58.345988] [<ffff0000091c0b48>] start_kernel+0x390/0x3a4
[   58.345990] handlers:
[   58.345994] [<ffff0000085120d0>] bam_dma_irq

The reason for the crash we found is, bam_dma_irq() was returning
negative value when the device resumes in some conditions.

In addition, the irq handler should have one of the below return values.

IRQ_NONE            interrupt was not from this device or was not handled
IRQ_HANDLED         interrupt was handled by this device
IRQ_WAKE_THREAD     handler requests to wake the handler thread

Therefore, to resolve this crash, we have changed the return value to
IRQ_NONE.

Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 4eeb8bb..d5773d4 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -875,7 +875,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 
 	ret = bam_pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
-		return ret;
+		return IRQ_NONE;
 
 	if (srcs & BAM_IRQ) {
 		clr_mask = readl_relaxed(bam_addr(bdev, 0, BAM_IRQ_STTS));
-- 
2.7.4

