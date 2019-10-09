Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC946D0A96
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 11:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJIJLs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 05:11:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37609 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJIJLr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 05:11:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so1007226pgi.4
        for <dmaengine@vger.kernel.org>; Wed, 09 Oct 2019 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O5t0e/gQse8Qw5vCIuQfPPdmME+fzFWGPG6GN+mUsd8=;
        b=LoukXlwGXcDpo42+DF7QA/ampXViZ8/qogRylR7ilMVvqTBR5C9prHUwp/JSDEPfHL
         wsxGbIsyAs24d6jeOL6KuV/JtF+Bv0Ynez+O/OD1IreIVHoI6xvNB3GNlyzXYHlwOlSN
         qs6kclNoibg5qb4HjCbyCz4nrnD4jp51YnY7Vtez7bL2fs8xoHY/Lu483aW2/OhTtrFU
         RkGQp/OlYBo8hzcukAFIAdhIkaiWkCN+pyCR4jwmvA13SyWGlgYSF83Vzk9BBLK64K9D
         ZxKnipZJPSwWSUr0wT+CLOGLFFiTLomqkczZR2ZISQd2W5jqsOVJZ+zRORQdSr6zul80
         Ozew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O5t0e/gQse8Qw5vCIuQfPPdmME+fzFWGPG6GN+mUsd8=;
        b=pxy7FvpUz8YcWWyUlZgfgvaLN8dnJ1WTWu20nvUSMj0M0p693PHjzmvx4Mb7xs9ryQ
         8eL6Lm4ssuCsY4NklbU+wnfZrvxGgtRkwQBRUhfdvqzNTFlB795T40ebWt2ETcrF0tJu
         CVkJ5JatGvQGML0H5N9kZQDpNZ/M8O795lo0+olwkSjGRltQblxAIy4AZHKFRgueSg7L
         lPISYLS+RiiR9mM9A9KOo0Svi9YMcss35KY1FMXIDfrUbGcOhnPPszx4lj9eAO1jzGw6
         Za3QcH3sVu2VcHuD8b/etv5Fp+HgDL6rjunHF+wwDQ52OyHwe8YyVbtV6pJPchjp3QeU
         zFQg==
X-Gm-Message-State: APjAAAW5SLs5fFnUSkE5wqiG24t2KmaugovGB/OsglMjNAAS4BhnvWGq
        +sWsrG1wngkb6okSW3lKqaz7o7daJWrKow==
X-Google-Smtp-Source: APXvYqxPWJdd3eHAZx5Pc7xZksg/1PPFQsG0t5tP1r8W/zu+GmFmqzZFAeJt4f4hsNbkHKos3Ja/ag==
X-Received: by 2002:a63:1c06:: with SMTP id c6mr3153861pgc.417.1570612306950;
        Wed, 09 Oct 2019 02:11:46 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m68sm1642818pfb.122.2019.10.09.02.11.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 02:11:46 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        zhenfang.wang@unisoc.com, baolin.wang@linaro.org
Subject: [PATCH] dmaengine: sprd: Fix the possible memory leak issue
Date:   Wed,  9 Oct 2019 17:11:30 +0800
Message-Id: <170dbbc6d5366b6fa974ce2d366652e23a334251.1570609788.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If we terminate the channel to free all descriptors associated with this
channel, we will leak the memory of current descriptor if the current
descriptor is not completed, since it had been deteled from the desc_issued
list and have not been added into the desc_completed list.

Thus we should check if current descriptor is completed or not, when freeing
the descriptors associated with one channel, if not, we should free it to
avoid this issue.

Fixes: 9b3b8171f7f4 ("dmaengine: sprd: Add Spreadtrum DMA driver")
Reported-by: Zhenfang Wang <zhenfang.wang@unisoc.com>
Tested-by: Zhenfang Wang <zhenfang.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 60d2c6b..32402c2 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -212,6 +212,7 @@ struct sprd_dma_dev {
 	struct sprd_dma_chn	channels[0];
 };
 
+static void sprd_dma_free_desc(struct virt_dma_desc *vd);
 static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param);
 static struct of_dma_filter_info sprd_dma_info = {
 	.filter_fn = sprd_dma_filter_fn,
@@ -613,12 +614,19 @@ static int sprd_dma_alloc_chan_resources(struct dma_chan *chan)
 static void sprd_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct virt_dma_desc *cur_vd = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&schan->vc.lock, flags);
+	if (schan->cur_desc)
+		cur_vd = &schan->cur_desc->vd;
+
 	sprd_dma_stop(schan);
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 
+	if (cur_vd)
+		sprd_dma_free_desc(cur_vd);
+
 	vchan_free_chan_resources(&schan->vc);
 	pm_runtime_put(chan->device->dev);
 }
@@ -1031,15 +1039,22 @@ static int sprd_dma_resume(struct dma_chan *chan)
 static int sprd_dma_terminate_all(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct virt_dma_desc *cur_vd = NULL;
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&schan->vc.lock, flags);
+	if (schan->cur_desc)
+		cur_vd = &schan->cur_desc->vd;
+
 	sprd_dma_stop(schan);
 
 	vchan_get_all_descriptors(&schan->vc, &head);
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 
+	if (cur_vd)
+		sprd_dma_free_desc(cur_vd);
+
 	vchan_dma_desc_free_list(&schan->vc, &head);
 	return 0;
 }
-- 
1.7.9.5

