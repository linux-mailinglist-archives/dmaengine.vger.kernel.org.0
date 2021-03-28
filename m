Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F6234C040
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhC1X6u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhC1X62 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:58:28 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7621C061762;
        Sun, 28 Mar 2021 16:58:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h7so8244300qtx.3;
        Sun, 28 Mar 2021 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZY3iifrv8ClFucjg75wWqbWgmlD1U3QmF4uzbWxtyk=;
        b=PIw7C1Bk/eGWQKsGvWCr0S8TPn8QvRWOhl6hvWK4VjoMFupeY5/g8s7kzwhMScA5Yu
         3e7Rj/bjvS2b85U9+k88WGtsKgUTPvzzvdFJYC0k/RqLPZFS/3GhHjMqD5kK+e7jKM/6
         53Fvs6gxrbJFiC1u/dgFp8bxTyuVzLD/Tpou7SHHqSFadmyNPt3U4CU58tt95gASNQQ7
         xYX4ULcW05MCOpvlLfFnzFEUNX3Yp7+RhdNBet8s+BvsIMTWUkgy4Nq5pTpS8LNP/fAV
         /fA+htsmtHzgRatr0oZ5k5rLTOnxU0BoqA8YYmMtTbokFKvFZL0GLX13Zdgx+VbiqJTc
         ioTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZY3iifrv8ClFucjg75wWqbWgmlD1U3QmF4uzbWxtyk=;
        b=BPQI1ldFc17wxokIZ9C8LnmECtkOPTVbuuygd5D1VOmkUnY+CG+X62Aw0HoyYly8eY
         eLF4p7wfu3+EXCSVH8oqIcvdqN4SXAawwIVLejan9B4J/CgKbkCd0c7Ds7+TEkIOy4+Z
         sgnHZaZvZKnTU3z9/+rmAiIQsJx+U0m7OFRJAnT/q0mevozte1dptuXKtWPHW7fG1JV+
         FoESd+RvRcN6e9OKNHo9M4ZDCcuAaC9C9rfWl/K3HNRxYF14+vjyHqnVE+7oD7EV9RPH
         EfX6ZC0togBin1VaDQylyR++CpVGCv+Q0KsbNwxLrXxh8Fc4ZdgxqkEtN9iM83b/P/Ui
         8cFQ==
X-Gm-Message-State: AOAM531lBU3q5Qqe/k1hBdOA7WgEFu7k/BpuQcrDaw4wV/dTWQMwGPPq
        1XyNqt+LNdJm7AuC1U0mAhWMYn4r0kIFi2w8
X-Google-Smtp-Source: ABdhPJzrXaJ3NFEfLw/ORFLnH6cpcNnBby0kvFM8FYj18PlBci3BiuYNuENXsp4hnCZmTj7qcXXSOw==
X-Received: by 2002:ac8:dcc:: with SMTP id t12mr13998503qti.219.1616975906780;
        Sun, 28 Mar 2021 16:58:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:58:26 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/30] xilinx_dma.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:26 +0530
Message-Id: <4613951fd51572e8c152d07c402d30a13f19a917.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/interace/interface/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3aded7861fef..63d2f447ad79 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -483,7 +483,7 @@ struct xilinx_dma_config {
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
  * @pdev: Platform device structure pointer
  * @dma_config: DMA config structure
- * @axi_clk: DMA Axi4-lite interace clock
+ * @axi_clk: DMA Axi4-lite interface clock
  * @tx_clk: DMA mm2s clock
  * @txs_clk: DMA mm2s stream clock
  * @rx_clk: DMA s2mm clock
--
2.26.3

