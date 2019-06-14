Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C61946084
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfFNOUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 10:20:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54614 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfFNOUS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jun 2019 10:20:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so2551610wme.4
        for <dmaengine@vger.kernel.org>; Fri, 14 Jun 2019 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ty57fS8FEMMkyXkp+DBY1O/OWs9quJnipD1xbuIqd/0=;
        b=jEyWyusNNcy/zIbSz97DCVXFWo6liOcR3UroHiqapt1gsw21z6NUzdxOP/hmEgFDBX
         t1czRS7WpYV+PhrzE3HFYeek6Du6wzUsF1/pN008841LWOFHasdvj6d+dFsDXf+hlrJU
         owQrDqnNU5/CublkS+8W0dU/rjeHgad6VMBxd8pnSRMEdPRJTt1X2bt1uaQJXAL1e/5q
         U/gmBDF5avTuXoNJUV7zOCQIGoZGpk0ulZIOp7Et4rU7grQ325ujdHK3kP5Y7lhQvg5X
         KWcolpqX/LJTn4nS4d4FeoGz8lrZ3u9tUQ3Ld6Z6/atadBGm/XGdJH91UL7cE7YTfnk/
         qBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ty57fS8FEMMkyXkp+DBY1O/OWs9quJnipD1xbuIqd/0=;
        b=LI4CYYaKkcHr0jFMfnhOtdB12lmwqtaJCWGo6MnCMtf0EeJ3JFnC1MZzToB6J6sgUF
         /8/M3+f8t8l+lMXfxGlCzJb/YaJNZVbBuTEAiYLvIKJblJ3UlmsEjAy5vT2xd28vUEP9
         BSfFicGv+23KyTb+xv7HLsLta/P1yZmLzF45syH8XVz650t+nlH65gHKxCddy8PfleU7
         Z8VI8Cq+P54rRWfLD2jqLV8S4LJuhF+LJSKQoAqY17IQ7QzBGP6M5W4DU8ofXcFGn3ys
         Qiaww5wilMz2MC/R8rdKbygoRiNahENgshDWdt8tiPDtcqx5zWGmUc1kPigzG+/AALku
         viZw==
X-Gm-Message-State: APjAAAX2xS+K+9RwjRGVIuYappGZ/JQZ0Z0ZrFnHI3ZCmr/dRBxBZXPa
        xxVPFcRohZt45cXHydnV7yRUVw==
X-Google-Smtp-Source: APXvYqxpNPUsDaAEg7ZHJS2hvOSurHBke9twjY/3loroMi7xipncRW4bBwmksKoG12q4fxRVq1yzYQ==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr118305wmf.101.1560522016576;
        Fri, 14 Jun 2019 07:20:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id j7sm3990080wru.54.2019.06.14.07.20.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:20:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
Date:   Fri, 14 Jun 2019 15:20:12 +0100
Message-Id: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For some reason arguments to most of the circular buffers
macros are used in reverse, tail is used for head and vice versa.

This leads to bam thinking that there is an extra descriptor at the
end and leading to retransmitting descriptor which was not scheduled
by any driver. This happens after MAX_DESCRIPTORS (4096) are scheduled
and done, so most of the drivers would not notice this, unless they are
heavily using bam dma. Originally found this issue while testing
SoundWire over SlimBus on DB845c which uses DMA very heavily for
read/writes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index cb860cb53c27..43d7b0a9713a 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -350,8 +350,8 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 #define BAM_DESC_FIFO_SIZE	SZ_32K
 #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
 #define BAM_FIFO_SIZE	(SZ_32K - 8)
-#define IS_BUSY(chan)	(CIRC_SPACE(bchan->tail, bchan->head,\
-			 MAX_DESCRIPTORS + 1) == 0)
+#define IS_BUSY(chan)	(CIRC_SPACE(bchan->head, bchan->tail,\
+			 MAX_DESCRIPTORS) == 0)
 
 struct bam_chan {
 	struct virt_dma_chan vc;
@@ -806,7 +806,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
 		offset /= sizeof(struct bam_desc_hw);
 
 		/* Number of bytes available to read */
-		avail = CIRC_CNT(offset, bchan->head, MAX_DESCRIPTORS + 1);
+		avail = CIRC_CNT(bchan->head, offset, MAX_DESCRIPTORS);
 
 		list_for_each_entry_safe(async_desc, tmp,
 					 &bchan->desc_list, desc_node) {
@@ -997,8 +997,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 			bam_apply_new_config(bchan, async_desc->dir);
 
 		desc = async_desc->curr_desc;
-		avail = CIRC_SPACE(bchan->tail, bchan->head,
-				   MAX_DESCRIPTORS + 1);
+		avail = CIRC_SPACE(bchan->head, bchan->tail, MAX_DESCRIPTORS);
 
 		if (async_desc->num_desc > avail)
 			async_desc->xfer_len = avail;
-- 
2.21.0

