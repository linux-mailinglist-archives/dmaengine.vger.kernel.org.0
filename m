Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F162D0AC1
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 07:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgLGGe7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 01:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgLGGe6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Dec 2020 01:34:58 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF34C0613D4;
        Sun,  6 Dec 2020 22:34:18 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i38so8062712pgb.5;
        Sun, 06 Dec 2020 22:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5q1YhPjhi7857jfqqjPqEtMBVeFBPU6hgI2ckukTgPs=;
        b=TqgqXvQv9OFnZAsRrBCwKfwrdZn2KHcmTkOSjcBzhiZz3J887eVyNns+7SKUvQSgUU
         u0eJn5yPABA6QjK3Ovbt5FlbFwpV7bL/1o+HigXoQvI1J+LuG+nDZm4ZkRN/Oie+Rb0Y
         y2murPpzP79jGnsTohdSGMOllYfgAIE972JO30in3N7gLftmFbAis/eDL2UeK+OAtg/g
         rd5J/Fk4l3TK4MXlXmrBl7Szc5u0tAtJRutMV2R8FsEJEy11OucFTi818nVsFTZAnUrm
         dWXt1n93TOCUdk4DEJPB2XqoXcvPMl8JoVSwwJHUznKp54aZhbL1FPpzFhoxjflzD+Cu
         t0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5q1YhPjhi7857jfqqjPqEtMBVeFBPU6hgI2ckukTgPs=;
        b=etzUDVWUXbWeREmkTx2SguDg/5gN00rhjQ6TZQF7W2m0sCmdJGYzW20biBrJBFKWKV
         Fi9FoiltZzX955l+/nxRd41APIki/1K++YYe2BHB+PtfFBTr5OndoA471y1b5WieQ4ou
         0ykLaY0LSMGmWTDCIceKWAUX1IKV9G+LIiPJdVDKewn+/DcI8clOENbhCtlprhXQWh2h
         HnS9i/czASzunOJwy1USMZS0cwA8YDx6F3J5OFx7z2RcZXTrtyCvStWreUH7HTfi2lUv
         7Wot93WfAG+pjU/VGP/LTAxlg0UyX27zNYNliK+HkOhvd++Bjqvr90oL3b3qIBse6xpM
         DzvA==
X-Gm-Message-State: AOAM530pFdYPIBWfIOmSV/qsr/dcT5iBTWVRvRxbsA8OYcMeBKuEoTkK
        wHItrnrqEntdIJjmQjRdgoA=
X-Google-Smtp-Source: ABdhPJyo8hLLPix4fD3YGOUOwNDxD4XD8JygNu7LqBeXssUBABQtI8TVDWF7dpXKHtSrgFYO/NzOhA==
X-Received: by 2002:a63:f02:: with SMTP id e2mr1945774pgl.148.1607322858140;
        Sun, 06 Dec 2020 22:34:18 -0800 (PST)
Received: from AHMLPT1827.ap.corp.arrow.com ([103.85.10.190])
        by smtp.googlemail.com with ESMTPSA id w2sm1854273pfj.110.2020.12.06.22.34.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 22:34:17 -0800 (PST)
From:   Parth Y Shah <sparth1292@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH] dmaengine: bam_dma: fix return of bam_dma_irq()
Date:   Mon,  7 Dec 2020 12:03:40 +0530
Message-Id: <1607322820-7450-1-git-send-email-sparth1292@gmail.com>
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

