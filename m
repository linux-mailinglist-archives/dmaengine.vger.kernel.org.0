Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2B34C026
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhC1X5q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhC1X52 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445FC061756;
        Sun, 28 Mar 2021 16:57:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g20so10956730qkk.1;
        Sun, 28 Mar 2021 16:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/yLPPo841dOFvgXTquZIbBYSrAfKw7ph65+PVkCETM=;
        b=kqSj7aCUIqDznfRqoW0QgxanHBokTPho/STAgy/fC8CA3oXoCgHhFZhBx0bJLndhc8
         wZXHyS8nNnyL4m3H41Q5sXrJUArJwb4e3uvpRO6ZiiPmvqonD2DdrFEfo3DQvOZ5GNLc
         saLjVc0lRUjJtgagE8u6Yu8CITfDcO85EeHQWIC6qGIwBV9GPuHXwhP71WdYcSnqksrV
         FNU26qKEnM5rl5JDN5FsqwYdmveQ1Fh4viKid8oVbsEdm6o45iKO9Hgzr7Yxaox21zzb
         ww77wgJoQflTxFMPJgrI3Y4ozqFjMr9xfHfwriPaNfSlEl7FNt79jmEG4sqtEa2Qq+uS
         lsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/yLPPo841dOFvgXTquZIbBYSrAfKw7ph65+PVkCETM=;
        b=Wdw5N2eJelfBOUuIgIgJWXQGuOV6zFL2sd7pyAeDfmHU6tn6o+3sHSxskHYIZUhFCz
         D0tH48L+9xLawjcqBV1YMjIkmVVvMyNK+CW9NSvA3wPQWtBujqLrRDZg1fUtye3VZofq
         qBdVJoNbjBVrQiD+I6/1A4mpE1SycCjtVtZfD2q1OwUS9ph2TrNZBqcR2uIKc38Qr6YP
         5VpL78Xg3lQUFwxdz5n1p96QSX1bJLMSTQODwXtkOBjZxLEh+MIku8rz4XOVRcT741kx
         4Ty4WDJsaKtQHv+Lda9d4JOpVyL/c2iAwEKj2/wPZZ/zQzD2DRFIJRhi5nnG7kjT/ZDg
         k6Cw==
X-Gm-Message-State: AOAM531H1hOnsx4HHDIAzJm5YCMjJGCzKB48tbBQhPQ3KoSYd7YyXwts
        A6I6F/fxXz/vCTRUOW2x4WBQvyFRlP3N0ANU
X-Google-Smtp-Source: ABdhPJzlIJVsP1+e9L67X5sWl3v37tzXkq6IkG/ls+Iz+DhefXkxs3HuwQvPjNj/yaULuKiNhdk4uA==
X-Received: by 2002:a05:620a:1650:: with SMTP id c16mr23014988qko.477.1616975846867;
        Sun, 28 Mar 2021 16:57:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:26 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/30] tegra20-apb-dma.c: Fixed a typo
Date:   Mon, 29 Mar 2021 05:23:14 +0530
Message-Id: <58f465e8c502b9f5cb07a2174a8103133defcbb9.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/programing/programming/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 71827d9b0aa1..e64789432587 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -475,7 +475,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,

 	/*
 	 * If interrupt is pending then do nothing as the ISR will handle
-	 * the programing for new request.
+	 * the programming for new request.
 	 */
 	if (status & TEGRA_APBDMA_STATUS_ISE_EOC) {
 		dev_err(tdc2dev(tdc),
--
2.26.3

