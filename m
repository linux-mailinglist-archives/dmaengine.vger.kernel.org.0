Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8767B1B938A
	for <lists+dmaengine@lfdr.de>; Sun, 26 Apr 2020 21:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgDZTIt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Apr 2020 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726166AbgDZTIt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Apr 2020 15:08:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AECBC061A0F;
        Sun, 26 Apr 2020 12:08:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so11982806lff.2;
        Sun, 26 Apr 2020 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/4kgm18MPKyif9QF7RKPNqTGNQbBIVS8DbK5GTpM+Y=;
        b=NEYzbPbCKaVbsoswB64nzatO6wDRbdWqn7IQh9ZuWnEwcaGh/609EU7KJ0UAae1ymd
         cBAV1IuKXEHn+cHCE2b51SzVkIj0d1zkofuQkdRWwZ5BQ6IxBX643e9n29V5p2+GpJyw
         1jT94pNCQeMhPDoFqtk16TO7KLGvHvc1Wb9z0OJVjmUXWpY2VTZGkrXEoW3S7o8GxX+8
         zREaXQyCJzEAI59rQNYnVStrPZKtIuvi9RcIafYxwuy/bjEw1n4FRSl9LiNKccvMdx1X
         1HhkLjvwYtX+AGwerusZQU+CyiQft9ZhH+ZulqoDLCr2HxtxzmIaZVfv83XtZkisrU7D
         PKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/4kgm18MPKyif9QF7RKPNqTGNQbBIVS8DbK5GTpM+Y=;
        b=Y55lRGGNBYSJ/piPsh3P9bKGfH5QBlVR1MZW+3b/UnuBB1I8AisA4ctKXH+JwyOM/Q
         g79/yrXBtb2m71IKg4K0vrBYubKAXMmmr9thicGBYZKV7mKXPdFEtTQw2xY5mG8CKtmb
         BEqSITlkfvnKK2UEHXhDCmZLVVTjDOi+s/eI4vuvGtmQ6dmYORclpZo4kmETW61/ORrO
         HgNkc8x/m9N3S70WSfe7jtDfTA7k1NNJt06sCDOGmq+Apq98D4FCcAWmedU+MJDhPBw9
         oG6GIjpM/eyHaZTzTENOT8AbZjte5AZsdNUc7RoyAYFFmTjOSP2+0dgPlKxnzftDExhD
         GT8w==
X-Gm-Message-State: AGi0Pub67Qy+AisSpPqAEsqsFgFRsQJTVuSsmTQXOdWhGm9jGue/+Zho
        J/FmKSJx+PL2Heh35HtfIYg=
X-Google-Smtp-Source: APiQypIF5PNYEJ5NTpcX4aInGwC+Ef+A12wqHzFlGoXoI+AbOjsCJZfV4gc1ewtK6Ao1r9PSEoEO9g==
X-Received: by 2002:a19:7507:: with SMTP id y7mr13173859lfe.121.1587928126145;
        Sun, 26 Apr 2020 12:08:46 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h24sm9351933lji.99.2020.04.26.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 12:08:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: tegra-apb: Ensure that clock is enabled during of DMA synchronization
Date:   Sun, 26 Apr 2020 22:08:35 +0300
Message-Id: <20200426190835.21950-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA synchronization hook checks whether interrupt is raised by testing
corresponding bit in a hardware status register, and thus, clock should
be enabled in this case, otherwise CPU may hang if synchronization is
invoked while Runtime PM is in suspended state. This patch resumes the RPM
during of the DMA synchronization process in order to avoid potential
problems. It is a minor clean up of a previous commit, no real problem is
fixed by this patch because currently RPM is always in a resumed state
while DMA is synchronized, although this may change in the future.

Fixes: 6697255f239f ("dmaengine: tegra-apb: Improve DMA synchronization")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index a42c0b4d14ac..55fc7400f717 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -816,6 +816,13 @@ static bool tegra_dma_eoc_interrupt_deasserted(struct tegra_dma_channel *tdc)
 static void tegra_dma_synchronize(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	int err;
+
+	err = pm_runtime_get_sync(tdc->tdma->dev);
+	if (err < 0) {
+		dev_err(tdc2dev(tdc), "Failed to synchronize DMA: %d\n", err);
+		return;
+	}
 
 	/*
 	 * CPU, which handles interrupt, could be busy in
@@ -825,6 +832,8 @@ static void tegra_dma_synchronize(struct dma_chan *dc)
 	wait_event(tdc->wq, tegra_dma_eoc_interrupt_deasserted(tdc));
 
 	tasklet_kill(&tdc->tasklet);
+
+	pm_runtime_put(tdc->tdma->dev);
 }
 
 static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
-- 
2.26.0

