Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D60198677
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 23:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgC3V1O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Mar 2020 17:27:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:41462 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgC3V1O (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Mar 2020 17:27:14 -0400
IronPort-SDR: nGNAxcTsSHZOvmTSYtlHM+tPnYZX1ybJqZFyhFbyFjYcM8JNeR/elMBs6ecob3oZwXMrviGxxs
 0MSCvYPRJp6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 14:27:13 -0700
IronPort-SDR: sNzrtukh1VqfBbYWFW1DmYjELA34WKsEpih9CFrTERWSoAH8HGUn37Kdnh7idnQdHKI3AF0dFl
 r6zEOFwcSNng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="272509717"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2020 14:27:12 -0700
Subject: [PATCH 4/6] device: add cmdmem support for MMIO address
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Date:   Mon, 30 Mar 2020 14:27:12 -0700
Message-ID: <158560363242.6059.17603442699301479734.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the introduction of ENQCMDS CPU instruction on Intel CPU, a number of
accelerator devices that support accepting data via ENQCMDS will be
arriving. Add devm_cmdmem_remap/unmap() wrappers to remap BAR memory to
specifically denote that these regions are of cmdmem behavior type even
thought they are iomem.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/linux/io.h |    4 ++++
 lib/devres.c       |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index b1c44bb4b2d7..2b3356244553 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -79,6 +79,10 @@ void devm_memunmap(struct device *dev, void *addr);
 
 void *__devm_memremap_pages(struct device *dev, struct resource *res);
 
+void __iomem *devm_cmdmem_remap(struct device *dev, resource_size_t offset,
+				 resource_size_t size);
+void devm_cmdmem_unmap(struct device *dev, void __iomem *addr);
+
 #ifdef CONFIG_PCI
 /*
  * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
diff --git a/lib/devres.c b/lib/devres.c
index 6ef51f159c54..a14a49087b37 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -218,6 +218,42 @@ void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int in
 }
 EXPORT_SYMBOL(devm_of_iomap);
 
+/**
+ * devm_cmdmem_remap - Managed wrapper for cmdmem ioremap()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed cmdmem ioremap() wrapper.  Map is automatically unmapped on
+ * driver detach.
+ */
+void __iomem *devm_cmdmem_remap(struct device *dev, resource_size_t offset,
+				 resource_size_t size)
+{
+	if (!device_supports_cmdmem(dev))
+		return NULL;
+
+	return devm_ioremap(dev, offset, size);
+}
+EXPORT_SYMBOL(devm_cmdmem_remap);
+
+/**
+ * devm_cmdmem_unmap - Managed wrapper for cmdmem iounmap()
+ * @dev: Generic device to unmap for
+ * @addr: Address to unmap
+ *
+ * Managed cmdmem iounmap().  @addr must have been mapped using
+ * devm_cmdmem_remap*().
+ */
+void devm_cmdmem_unmap(struct device *dev, void __iomem *addr)
+{
+	if (!device_supports_cmdmem(dev))
+		return;
+
+	devm_iounmap(dev, addr);
+}
+EXPORT_SYMBOL(devm_cmdmem_unmap);
+
 #ifdef CONFIG_HAS_IOPORT_MAP
 /*
  * Generic iomap devres

