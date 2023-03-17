Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA76BE832
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 12:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCQLdy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCQLdw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 07:33:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9329ABAD4
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:33:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j13so4775743pjd.1
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeG3wRBDmKNCCUZ5fz5gWcA/vZS940xFTGQw0n7HN+E=;
        b=O6SXGDuUKlQ+9oQOkCmvU04ck+RyNmL8hdU9s6Nvyza/sjnC2hq+lrJ9WuLhWElkb3
         H6nH2JAjDt+A244Vi+2jSnJwNmdXNoe06nDr6Buxuui+5GUDvNxTeHtW0kF8rupLT6yv
         k/g6AHHcoxIXZVxEQ+JC3ebI6vI33WynceSPnNbAm0WhNp+rKo2H56Z+4xP6BGJ50yRh
         cLDex5tzITakt+e7nJwbUniSCYNydjTm2Au706qpmhGfgNs+oCaIGTYYenpQ2M4KxzLY
         XqVZPXqsav7oT6hhUsohmbzC/l4HWG51jCW4qvFFpFJ6Etv0POdkma8qEasDCWdv4o4i
         d5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeG3wRBDmKNCCUZ5fz5gWcA/vZS940xFTGQw0n7HN+E=;
        b=P2Zpaw+hlRM7OSwuzfzfIKoxwboeH+hvPYO/W/i0XcGVCbrOli7PBBGInNBIzSDeVP
         jcHtaIv8zsz3TNFYBxH+NZL+SC2Q5bsodQAJBXyaMW4PY/HQxvRys95Et4FXdHXbYgau
         thA13R8K34WaWRuX9wGan5oVmCCxGlcPhvSHuQT7UAAyd5VpcTPBJR45dKu8mnHflDCI
         OHoCqt0QZMVxUExwoBY8htumjBjTaNqkQ/jeIvaHrWN9kEQh4OavuMQqZ7j0S5L8ygfQ
         2QVhYkLdmsbn20fEA4950H3KPlo4XnoHd2+AUeJin5mI2NZa3hZkJPWGWV4+G9GsfMaN
         awGg==
X-Gm-Message-State: AO0yUKVZ62vpMZfhCPrIuL1rHJ8oQ/P0Z6IVbvlVlBJO7nQtCA7s72XS
        CGS0MLbXNZBb50kzBJvRGZ2+jw==
X-Google-Smtp-Source: AK7set+NQnSKYe8rjJOnq8VGzJNvTIqjYGfSG9K3yeXxMJf6U4NYDvg9R2U3W1W0s4+0B9RWCEeMgA==
X-Received: by 2002:a17:90a:e7cc:b0:237:c52f:a54d with SMTP id kb12-20020a17090ae7cc00b00237c52fa54dmr2618477pjb.21.1679052794296;
        Fri, 17 Mar 2023 04:33:14 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:33:14 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 08/11] misc: pci_endpoint_test: Support a test of continuous transfer
Date:   Fri, 17 Mar 2023 20:32:35 +0900
Message-Id: <20230317113238.142970-9-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a `count` parameter that indicates a number of transfer continuously in
a test. Buffers for the test will be allocated with a size equal to size *
count, and passed address of the buffer to epf-test.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 60 +++++++++++++++++---------------
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d4a42e9ab86a..a49303f8c987 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -302,7 +302,7 @@ static int pci_endpoint_test_validate_xfer_params(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (param->size > SIZE_MAX - alignment) {
+	if (param->size * param->count > SIZE_MAX - alignment) {
 		dev_dbg(dev, "Maximum transfer data size exceeded\n");
 		return -EINVAL;
 	}
@@ -323,7 +323,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	void *src_addr;
 	void *dst_addr;
 	u32 flags = 0;
-	size_t size;
+	size_t xfer_size;
 	dma_addr_t src_phys_addr;
 	dma_addr_t dst_phys_addr;
 	struct pci_dev *pdev = test->pdev;
@@ -349,21 +349,22 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	if (err)
 		return false;
 
-	size = param.size;
+	xfer_size = param.size * param.count;
 
 	if (param.flags & PCITEST_FLAGS_USE_DMA)
 		flags |= FLAG_USE_DMA;
 
-	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
+
+	orig_src_addr = kzalloc(xfer_size + alignment, GFP_KERNEL);
 	if (!orig_src_addr) {
 		dev_err(dev, "Failed to allocate source buffer\n");
 		ret = false;
 		goto err;
 	}
 
-	get_random_bytes(orig_src_addr, size + alignment);
+	get_random_bytes(orig_src_addr, xfer_size + alignment);
 	orig_src_phys_addr = dma_map_single(dev, orig_src_addr,
-					    size + alignment, DMA_TO_DEVICE);
+					    xfer_size + alignment, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, orig_src_phys_addr)) {
 		dev_err(dev, "failed to map source buffer address\n");
 		ret = false;
@@ -385,9 +386,9 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
 				 upper_32_bits(src_phys_addr));
 
-	src_crc32 = crc32_le(~0, src_addr, size);
+	src_crc32 = crc32_le(~0, src_addr, xfer_size);
 
-	orig_dst_addr = kzalloc(size + alignment, GFP_KERNEL);
+	orig_dst_addr = kzalloc(xfer_size + alignment, GFP_KERNEL);
 	if (!orig_dst_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
@@ -395,7 +396,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	}
 
 	orig_dst_phys_addr = dma_map_single(dev, orig_dst_addr,
-					    size + alignment, DMA_FROM_DEVICE);
+					    xfer_size + alignment, DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, orig_dst_phys_addr)) {
 		dev_err(dev, "failed to map destination buffer address\n");
 		ret = false;
@@ -417,7 +418,8 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 				 upper_32_bits(dst_phys_addr));
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
-				 size);
+				 param.size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COUNT, param.count);
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
@@ -427,10 +429,10 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 	wait_for_completion(&test->irq_raised);
 
-	dma_unmap_single(dev, orig_dst_phys_addr, size + alignment,
+	dma_unmap_single(dev, orig_dst_phys_addr, xfer_size + alignment,
 			 DMA_FROM_DEVICE);
 
-	dst_crc32 = crc32_le(~0, dst_addr, size);
+	dst_crc32 = crc32_le(~0, dst_addr, xfer_size);
 	if (dst_crc32 == src_crc32)
 		ret = true;
 
@@ -438,7 +440,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	kfree(orig_dst_addr);
 
 err_dst_addr:
-	dma_unmap_single(dev, orig_src_phys_addr, size + alignment,
+	dma_unmap_single(dev, orig_src_phys_addr, xfer_size + alignment,
 			 DMA_TO_DEVICE);
 
 err_src_phys_addr:
@@ -464,7 +466,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	size_t offset;
 	size_t alignment = test->alignment;
 	int irq_type = test->irq_type;
-	size_t size;
+	size_t xfer_size;
 	u32 crc32;
 	int err;
 
@@ -478,21 +480,21 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	if (err)
 		return false;
 
-	size = param.size;
+	xfer_size = param.size * param.count;
 
 	if (param.flags & PCITEST_FLAGS_USE_DMA)
 		flags |= FLAG_USE_DMA;
 
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
+	orig_addr = kzalloc(xfer_size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		ret = false;
 		goto err;
 	}
 
-	get_random_bytes(orig_addr, size + alignment);
+	get_random_bytes(orig_addr, xfer_size + alignment);
 
-	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
+	orig_phys_addr = dma_map_single(dev, orig_addr, xfer_size + alignment,
 					DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, orig_phys_addr)) {
 		dev_err(dev, "failed to map source buffer address\n");
@@ -509,7 +511,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 		addr = orig_addr;
 	}
 
-	crc32 = crc32_le(~0, addr, size);
+	crc32 = crc32_le(~0, addr, xfer_size);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
 				 crc32);
 
@@ -518,7 +520,8 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
 				 upper_32_bits(phys_addr));
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, param.size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COUNT, param.count);
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
@@ -532,7 +535,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	if (reg & STATUS_READ_SUCCESS)
 		ret = true;
 
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+	dma_unmap_single(dev, orig_phys_addr, xfer_size + alignment,
 			 DMA_TO_DEVICE);
 
 err_phys_addr:
@@ -548,7 +551,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	struct pci_endpoint_test_xfer_param param;
 	bool ret = false;
 	u32 flags = 0;
-	size_t size;
+	size_t xfer_size;
 	void *addr;
 	dma_addr_t phys_addr;
 	struct pci_dev *pdev = test->pdev;
@@ -571,19 +574,19 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	if (err)
 		return false;
 
-	size = param.size;
+	xfer_size = param.size * param.count;
 
 	if (param.flags & PCITEST_FLAGS_USE_DMA)
 		flags |= FLAG_USE_DMA;
 
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
+	orig_addr = kzalloc(xfer_size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
 		goto err;
 	}
 
-	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
+	orig_phys_addr = dma_map_single(dev, orig_addr, xfer_size + alignment,
 					DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, orig_phys_addr)) {
 		dev_err(dev, "failed to map source buffer address\n");
@@ -605,7 +608,8 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
 				 upper_32_bits(phys_addr));
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, param.size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COUNT, param.count);
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
@@ -615,10 +619,10 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 
 	wait_for_completion(&test->irq_raised);
 
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+	dma_unmap_single(dev, orig_phys_addr, xfer_size + alignment,
 			 DMA_FROM_DEVICE);
 
-	crc32 = crc32_le(~0, addr, size);
+	crc32 = crc32_le(~0, addr, xfer_size);
 	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
 		ret = true;
 
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index f9c1af8d141b..8f05df4f95a6 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -25,6 +25,7 @@
 
 struct pci_endpoint_test_xfer_param {
 	unsigned long size;
+	unsigned long count;
 	unsigned char flags;
 };
 
-- 
2.25.1

