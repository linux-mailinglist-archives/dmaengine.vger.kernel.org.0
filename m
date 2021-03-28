Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0D534BFF4
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhC1X4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhC1X4X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBECC061756;
        Sun, 28 Mar 2021 16:56:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c3so10929588qkc.5;
        Sun, 28 Mar 2021 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1jriUq1sL9lb0mtxN9KbapTjAFOd4HdFdy/Egjy5og=;
        b=rGFcWETJr6kx1FhK2VwuyFhj5mEQ2a9w1BMQGwfNSg69VWO2NHz6DRFrgg4SGJ3Z+8
         +nckc0b33f7uTjbCD27I2Gl2Jdn2HT3qvcYJdS4WPW1YXJNFE46lhkK9BighwwVM7M6Z
         sbmrrRJH2t3VrRNWQZyiWfEew9FMNFhk6Zl5kKcli7J7b4abKENXJWSILGRJkqUTX2+t
         WHSb9X1FAt5JDH4q/BeU5ocKsg/w33VbP7p3+NQRcRhAMcotq7sULiWyjAlOYf/mHOqB
         H9GvMPiPug0qb8cAXChS8dbpZy4uTWPDejj82uflrDF2gz/fTxAhbelewAFroVWE3qew
         2RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1jriUq1sL9lb0mtxN9KbapTjAFOd4HdFdy/Egjy5og=;
        b=b9jXUHnYK/fNoSLkeR23634SzMdlmW1EYCcZoEn6gpyJTytka0UXjcOxO+R0MwnFGy
         QatLkyRl+U+jw0T/hTKLHYjn/R3aDRA348DVHd6an02dyvbNk3gNP0kpI0mzipGb5org
         YE5JoONn8zuTJVlJNFejhUn44KKSKQkKUFOx9KER/bp0BwjAlwcJojNNQLxMOvY6kt9V
         yxV+UzGdBCcC+N7ZUu/8sEuviQxDFrx+lcMxOy+Bc6stlfumHP9GjRHaALmxV+jU6L8q
         +774EbeaWntiTJF50fiTdgF6dm0UY7iJdCeD316bHCb5jISATFcOPQeTPc1CGo7eEQS9
         k5jQ==
X-Gm-Message-State: AOAM533K/qdFHJeS1gICz4CWiJcEQcm23gWPTKV0+IP8Z55WwOikXY2L
        kEIu5Vk5PGKxGSh4GnwZbDwSnm52ZHys1o3O
X-Google-Smtp-Source: ABdhPJyKy/81JUq/KZUC1NO8pklpNrg2DlDqj4i3GsKGyS2IOzo8E/4XiQGvp7DS8QS7skiReIXQZA==
X-Received: by 2002:a37:584:: with SMTP id 126mr22223976qkf.274.1616975782447;
        Sun, 28 Mar 2021 16:56:22 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/30] bcm2835-dma.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:01 +0530
Message-Id: <77d89989f1cb7362f0a3a5a279d7846a93ae3968.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/missmatch/mismatch/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 630dfbb01a40..e6baf17b0434 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -369,7 +369,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	/* the last frame requires extra flags */
 	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;

-	/* detect a size missmatch */
+	/* detect a size mismatch */
 	if (buf_len && (d->size != buf_len))
 		goto error_cb;

--
2.26.3

