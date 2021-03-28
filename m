Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79234BFE9
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhC1X4K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhC1X4E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C715DC061756;
        Sun, 28 Mar 2021 16:56:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z10so10906604qkz.13;
        Sun, 28 Mar 2021 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZDOzS1vRcWtTYspKStQDHl39R8ItwGtdALzS3MH5haw=;
        b=BzAd00k8G81ySOORFH4ZYZ1bB3RbAIhMFXIV1td9cqvEo3UX3T7K8yDs0BLbUNs6dC
         G70pZ49bAzdfN5gPoTXAyB2FSNpShLDrz7XUsanKWuxMQrhE9um5pz0Eh9zXb8CEGvFR
         jProIh3TzVfDeb19gYLYfk5ihXrjFf2yWbMRIoNvoxWoNIfCyhIw+Kz9BsCPPMQa48D+
         /s97ueBJTMSjpIujqIKbMYw5vTW60f47/GtkTVffiOEP9zXV5SaMf2r5PpRh7pMqROjm
         DF1/IGaESef8EHnGmyWKekR0S17ktc8qfK44vFx3jKgxW3NB7Ado6xEEMvZo+NhRg8K7
         3Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDOzS1vRcWtTYspKStQDHl39R8ItwGtdALzS3MH5haw=;
        b=K1w/CQNf5Xgx+tGfbodKIA+GUoaJaIWd/KeUa+8qenGdMCC6U3VlFvdWjzGhtGrOX9
         +1M8G7NIaWVEU43j3IAovhmFkUkq/sRZDN2i5St6LjZXckGzb0crDJYTFVZSC9oa/lU0
         mv5zOZcc7+VCG6ixE4ZYJ1/B9sfB0RNzVvA1x5N8QGXtU9U85YOYfzhdGpp8S36wsxtc
         OIJV3+IUSNzvVjsWDGcKV2hy4qMulc8W05/I3B8GYyLcsUUaIDcRII4SuQYW/kQAgJ6j
         DUzF7MrU9BLkwBnACHPsqXKXlDcug0ZRLPR3GzWu3AaYXspOKQVsJKuqFk9zi//eZ0fO
         kCQA==
X-Gm-Message-State: AOAM532ft5DGGOnAPwOsnAQhpvfO1vQUHq/BH9+JTKV4jyS9l6C7QRnC
        IHaaVA6Jt173yatIJV3cD8yIwYqd+0taLa18
X-Google-Smtp-Source: ABdhPJypSYspQV6VkWopPpkt2zOnTgc+JiYwp3Y6rFrbq+R2YCZW03mpS3QNcfpuRFem43a0O2MkwQ==
X-Received: by 2002:a05:620a:110a:: with SMTP id o10mr23876269qkk.281.1616975762740;
        Sun, 28 Mar 2021 16:56:02 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:02 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/30] acpi-dma.c: Fix couple of typos
Date:   Mon, 29 Mar 2021 05:22:57 +0530
Message-Id: <c461490c88fdc6a18d264a283e5c69642ffa2859.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


s/exctract/extract/
s/avaiable/available/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/acpi-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 235f1396f968..4b1d5183bf64 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -100,7 +100,7 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
 }

 /**
- * acpi_dma_parse_csrt - parse CSRT to exctract additional DMA resources
+ * acpi_dma_parse_csrt - parse CSRT to extract additional DMA resources
  * @adev:	ACPI device to match with
  * @adma:	struct acpi_dma of the given DMA controller
  *
@@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(devm_acpi_dma_controller_free);
  * found.
  *
  * Return:
- * 0, if no information is avaiable, -1 on mismatch, and 1 otherwise.
+ * 0, if no information is available, -1 on mismatch, and 1 otherwise.
  */
 static int acpi_dma_update_dma_spec(struct acpi_dma *adma,
 		struct acpi_dma_spec *dma_spec)
--
2.26.3

