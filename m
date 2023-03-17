Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075606BE82E
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 12:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCQLdt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 07:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCQLdt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 07:33:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0E2AB887
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:33:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h8so4961099plf.10
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsdH0oLvA5PMhdbh6lug1hHlRUTM7D8rYh/xwgUFb5s=;
        b=mvu65/QfRfRZArhG2eSvUbIHdoFY4+XUZwAOfwXTe1cLvSbmcJMG1Kmiu6dWv5m+sV
         N7H2LviIzAS9sDn5AjrkYhybo0WDWwXYNfIzD/FaBPa3FtdWnklkMXUOLLlXJP47u7PV
         2RSnZ24DTlFUNYaFwq8oq6qbiqtMOkwC9ILG7FGV+6u/iV21JyUVsT02+cTdERsgX/qX
         A6zj7Wkl1PpAup8r0VYcA85bsYauBVIq6sNO9QzpRJUISg6nSFLGCdjCcLZMxIthqssR
         Urfue+pE2rMnHktmFhN953n1+V0rUOZrCt4mUGc3MTzdrqPy1n8oeheLEkWk4fh9jURc
         tegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsdH0oLvA5PMhdbh6lug1hHlRUTM7D8rYh/xwgUFb5s=;
        b=Yr7thCkkhvOYLtZ5VnPMRX2RSDEmmzKw899nz+3xf8794t7WZER3shg1ozaDYufTbU
         r+nkx1CfQiai0FWGZedoLB4aHwuQxg49w/GgkjMOoROHtlNYIp1HmSxARbK8MrJYnBLd
         2RXF7sv9h7km/LhmcJHfW1CRV0AkktwixkyIYFg3yQ+u6ZHFzCSRX8uWQN5FqJhVGFYu
         P0PKd3rN65ESDH7HeUc4h8gqzRVJ8qlJhJwJ8aQlW1Xh5LbvZOiSQ41QktEoJwwjDohi
         DLzbu9E3qiJM1JAFNv2R/4fLxfTBkJE3tg8NDNsd9i66ktliqCE9Mq6evkT6OcSZH1Vz
         4wxA==
X-Gm-Message-State: AO0yUKXjQF7z4kRxdLwoWgluog+5boLXw3/lleeGBdVLTsuWAxL4pRJf
        Mi4MImKa604AYUItGUBN7NlaIQ==
X-Google-Smtp-Source: AK7set/uRUgDY2cX8naSHuM20nfNZ9dM/YY+xJQJECgmJbS3+imJdlIRZMryd8zO2HdBEbhtsUlhqA==
X-Received: by 2002:a17:90b:1646:b0:23d:3aa5:5ff3 with SMTP id il6-20020a17090b164600b0023d3aa55ff3mr2791934pjb.14.1679052790713;
        Fri, 17 Mar 2023 04:33:10 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:33:10 -0700 (PDT)
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
Subject: [RFC PATCH 07/11] PCI: endpoint: functions/pci-epf-test: Extend the test for continuous transfers
Date:   Fri, 17 Mar 2023 20:32:34 +0900
Message-Id: <20230317113238.142970-8-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The test could not test continuous DMAs because it was only synchronously
issuing a single DMA and waiting for it to complete.

Add a new parameter, `count` and extend the test for continuous transfers
to improve the test coverage.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 152 ++++++++++--------
 1 file changed, 84 insertions(+), 68 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 99d8a05b8507..7898dfd956db 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -63,6 +63,7 @@ static void pci_epf_test_dma_callback(void *param)
  * @dma_src: The source address of the data transfer. It can be a physical
  *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
  * @len: The size of the data transfer
+ * @count: The number of DMAs issuing in consecutive
  * @dma_remote: remote RC physical address
  * @dir: DMA transfer direction
  *
@@ -74,7 +75,7 @@ static void pci_epf_test_dma_callback(void *param)
  */
 static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      dma_addr_t dma_dst, dma_addr_t dma_src,
-				      size_t len, dma_addr_t dma_remote,
+				      size_t len, size_t count, dma_addr_t dma_remote,
 				      enum dma_transfer_direction dir)
 {
 	struct dma_chan *chan = (dir == DMA_MEM_TO_DEV) ?
@@ -87,47 +88,56 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	struct device *dev = &epf->dev;
 	dma_cookie_t cookie;
 	int ret;
+	int i;
+	size_t offset;
 
 	if (IS_ERR_OR_NULL(chan)) {
 		dev_err(dev, "Invalid DMA memcpy channel\n");
 		return -EINVAL;
 	}
 
-	if (epf_test->dma_private) {
-		sconf.direction = dir;
-		if (dir == DMA_MEM_TO_DEV)
-			sconf.dst_addr = dma_remote;
-		else
-			sconf.src_addr = dma_remote;
+	for (i = 0, offset = 0; i < count; i++, offset += len) {
+		if (epf_test->dma_private) {
+			sconf.direction = dir;
+			if (dir == DMA_MEM_TO_DEV)
+				sconf.dst_addr = dma_remote + offset;
+			else
+				sconf.src_addr = dma_remote + offset;
+
+			if (dmaengine_slave_config(chan, &sconf)) {
+				dev_err(dev, "DMA slave config fail\n");
+				return -EIO;
+			}
+			tx = dmaengine_prep_slave_single(
+				chan, dma_local + offset, len, dir, flags);
+		} else {
+			tx = dmaengine_prep_dma_memcpy(chan, dma_dst + offset,
+						       dma_src + offset, len,
+						       flags);
+		}
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
+		if (!tx) {
+			dev_err(dev, "Failed to prepare DMA memcpy\n");
 			return -EIO;
 		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
-	} else {
-		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
-					       flags);
-	}
 
-	if (!tx) {
-		dev_err(dev, "Failed to prepare DMA memcpy\n");
-		return -EIO;
-	}
+		if (i == count - 1) {
+			tx->callback = pci_epf_test_dma_callback;
+			tx->callback_param = epf_test;
+			reinit_completion(&epf_test->transfer_complete);
+		}
 
-	tx->callback = pci_epf_test_dma_callback;
-	tx->callback_param = epf_test;
-	cookie = tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
+		cookie = tx->tx_submit(tx);
 
-	ret = dma_submit_error(cookie);
-	if (ret) {
-		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
-		return -EIO;
+		ret = dma_submit_error(cookie);
+		if (ret) {
+			dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
+			return -EIO;
+		}
+
+		dma_async_issue_pending(chan);
 	}
 
-	dma_async_issue_pending(chan);
 	ret = wait_for_completion_interruptible(&epf_test->transfer_complete);
 	if (ret < 0) {
 		dmaengine_terminate_sync(chan);
@@ -244,7 +254,7 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	return;
 }
 
-static void pci_epf_test_print_rate(const char *ops, u64 size,
+static void pci_epf_test_print_rate(const char *ops, u64 size, u32 count,
 				    struct timespec64 *start,
 				    struct timespec64 *end, bool dma)
 {
@@ -255,7 +265,7 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
 
 	/* convert both size (stored in 'rate') and time in terms of 'ns' */
 	ns = timespec64_to_ns(&ts);
-	rate = size * NSEC_PER_SEC;
+	rate = size * count * NSEC_PER_SEC;
 
 	/* Divide both size (stored in 'rate') and ns by a common factor */
 	while (ns > UINT_MAX) {
@@ -269,14 +279,14 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
 	/* calculate the rate */
 	do_div(rate, (uint32_t)ns);
 
-	pr_info("\n%s => Size: %llu bytes\t DMA: %s\t Time: %llu.%09u seconds\t"
-		"Rate: %llu KB/s\n", ops, size, dma ? "YES" : "NO",
+	pr_info("\n%s => Size: %llu bytes\tcount %d\t DMA: %s\t Time: %llu.%09u seconds\t"
+		"Rate: %llu KB/s\n", ops, size, count, dma ? "YES" : "NO",
 		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
 }
 
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 {
-	int ret;
+	int ret, i;
 	bool use_dma;
 	void __iomem *src_addr;
 	void __iomem *dst_addr;
@@ -288,8 +298,9 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	size_t offset;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
+	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size * reg->count);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -298,14 +309,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	}
 
 	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
-			       reg->src_addr, reg->size);
+			       reg->src_addr, reg->size * reg->count);
 	if (ret) {
 		dev_err(dev, "Failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		goto err_src_addr;
 	}
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
+	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size * reg->count);
 	if (!dst_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -314,7 +325,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	}
 
 	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
-			       reg->dst_addr, reg->size);
+			       reg->dst_addr, reg->size * reg->count);
 	if (ret) {
 		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -337,7 +348,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 src_phys_addr, reg->size, 0,
+						 src_phys_addr, reg->size, reg->count, 0,
 						 DMA_MEM_TO_MEM);
 		ktime_get_ts64(&end);
 		if (ret)
@@ -345,32 +356,33 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	} else {
 		void *buf;
 
-		buf = kzalloc(reg->size, GFP_KERNEL);
+		buf = kzalloc(reg->size * reg->count, GFP_KERNEL);
 		if (!buf) {
 			ret = -ENOMEM;
 			goto err_map_addr;
 		}
 
 		ktime_get_ts64(&start);
-		memcpy_fromio(buf, src_addr, reg->size);
-		memcpy_toio(dst_addr, buf, reg->size);
+		for (i = 0, offset = 0; i < reg->count; i++, offset += reg->size) {
+			memcpy_fromio(buf + offset, src_addr + offset, reg->size);
+			memcpy_toio(dst_addr + offset, buf + offset, reg->size);
+		}
 		ktime_get_ts64(&end);
 		kfree(buf);
 	}
-
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("COPY", reg->size, reg->count, &start, &end, use_dma);
 
 err_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
 
 err_dst_addr:
-	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
+	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size * reg->count);
 
 err_src_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr);
 
 err_src_addr:
-	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
+	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size * reg->count);
 
 err:
 	return ret;
@@ -378,7 +390,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
 static int pci_epf_test_read(struct pci_epf_test *epf_test)
 {
-	int ret;
+	int ret, i;
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
@@ -392,8 +404,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	size_t offset;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size * reg->count);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -402,14 +415,14 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	}
 
 	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->src_addr, reg->size);
+			       reg->src_addr, reg->size * reg->count);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		goto err_addr;
 	}
 
-	buf = kzalloc(reg->size, GFP_KERNEL);
+	buf = kzalloc(reg->size * reg->count, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto err_map_addr;
@@ -423,7 +436,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 			goto err_dma_map;
 		}
 
-		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
+		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size * reg->count,
 					       DMA_FROM_DEVICE);
 		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
 			dev_err(dev, "Failed to map destination buffer addr\n");
@@ -433,23 +446,24 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size,
+						 phys_addr, reg->size, reg->count,
 						 reg->src_addr, DMA_DEV_TO_MEM);
 		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 
-		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
+		dma_unmap_single(dma_dev, dst_phys_addr, reg->size * reg->count,
 				 DMA_FROM_DEVICE);
 	} else {
 		ktime_get_ts64(&start);
-		memcpy_fromio(buf, src_addr, reg->size);
+		for (i = 0, offset = 0; i < reg->count; i++, offset += reg->size)
+			memcpy_fromio(buf + offset, src_addr + offset, reg->size);
 		ktime_get_ts64(&end);
 	}
 
-	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("READ", reg->size, reg->count, &start, &end, use_dma);
 
-	crc32 = crc32_le(~0, buf, reg->size);
+	crc32 = crc32_le(~0, buf, reg->size * reg->count);
 	if (crc32 != reg->checksum)
 		ret = -EIO;
 
@@ -460,7 +474,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
+	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size * reg->count);
 
 err:
 	return ret;
@@ -468,7 +482,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 static int pci_epf_test_write(struct pci_epf_test *epf_test)
 {
-	int ret;
+	int ret, i;
 	void __iomem *dst_addr;
 	void *buf;
 	bool use_dma;
@@ -481,8 +495,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	size_t offset;
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size * reg->count);
 	if (!dst_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -491,21 +506,21 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	}
 
 	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->dst_addr, reg->size);
+			       reg->dst_addr, reg->size * reg->count);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		goto err_addr;
 	}
 
-	buf = kzalloc(reg->size, GFP_KERNEL);
+	buf = kzalloc(reg->size * reg->count, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto err_map_addr;
 	}
 
-	get_random_bytes(buf, reg->size);
-	reg->checksum = crc32_le(~0, buf, reg->size);
+	get_random_bytes(buf, reg->size * reg->count);
+	reg->checksum = crc32_le(~0, buf, reg->size * reg->count);
 
 	use_dma = !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
@@ -515,7 +530,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 			goto err_dma_map;
 		}
 
-		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
+		src_phys_addr = dma_map_single(dma_dev, buf, reg->size * reg->count,
 					       DMA_TO_DEVICE);
 		if (dma_mapping_error(dma_dev, src_phys_addr)) {
 			dev_err(dev, "Failed to map source buffer addr\n");
@@ -525,22 +540,23 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
-						 src_phys_addr, reg->size,
+						 src_phys_addr, reg->size, reg->count,
 						 reg->dst_addr,
 						 DMA_MEM_TO_DEV);
 		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 
-		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
+		dma_unmap_single(dma_dev, src_phys_addr, reg->size * reg->count,
 				 DMA_TO_DEVICE);
 	} else {
 		ktime_get_ts64(&start);
-		memcpy_toio(dst_addr, buf, reg->size);
+		for (i = 0, offset = 0; i < reg->count; i++, offset += reg->size)
+			memcpy_toio(dst_addr + offset, buf + offset, reg->size);
 		ktime_get_ts64(&end);
 	}
 
-	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("WRITE", reg->size, reg->count, &start, &end, use_dma);
 
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
@@ -555,7 +571,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
+	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size * reg->count);
 
 err:
 	return ret;
-- 
2.25.1

