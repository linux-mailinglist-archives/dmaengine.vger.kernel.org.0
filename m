Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3953186FA
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 10:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBKJVC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 04:21:02 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56796 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhBKJOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 04:14:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4FA11C00C5;
        Thu, 11 Feb 2021 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034779; bh=xSw5LvD/YxXUJeeq0fPt2fEv2IzUw5tDpPF/ckOJIV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TdvJtSgUpmmC+ly6Drd8sTpXaTE1G97pOUNKuA9O09B/X8ZfoA5obL1aFW3FWEKu8
         gACUxJnQwGwdb7pL0r5xdC6FPcYud2/TEdjKeMtvj1xUkFYs7lYbH9AI/6ANRHvO3A
         UcQyfnk30kZw8B9538pjckxgSigvBwFmYOHZ1CxBGsw5pBRR+wb444vFeqNs5PJ/9Q
         M9D96Gv89ubzIG+WJ0WsfFs1vRPYRo+dqxnKnO2PfBF8k8a+vBQefq2hMQ2CBKU/0I
         Mnazp974S7kRS3sDkRPy5fuYbB8WmddLRi3+VFaZNej+e9rjCEpC8JUhdLsXwe1MzC
         DtIfP/m2uxaGw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20ABEA0061;
        Thu, 11 Feb 2021 09:12:58 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 04/15] PCI: Add pci_find_vsec_capability() to find a specific VSEC
Date:   Thu, 11 Feb 2021 10:12:37 +0100
Message-Id: <45b51292876f238afe3f6865113cd9d72d33e51a.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add pci_find_vsec_capability() that crawls through the device config
space searching in all Vendor-Specific Extended Capabilities for a
particular capability ID.

Vendor-Specific Extended Capability (VSEC) is a PCIe capability (acts
like a wrapper) specified by PCI-SIG that allows the vendor to create
their own and specific capability in the device config space.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.c             | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  6 ++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc2..1307af6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -693,6 +693,40 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
 /**
+ * pci_find_vsec_capability - Find a vendor-specific extended capability
+ * @dev: PCI device to query
+ * @cap: vendor-specific capability ID code
+ *
+ * Typically this function will be called by the pci driver, which passes
+ * through argument the 'struct pci_dev *' already pointing for the device
+ * config space that is associated with the vendor and device ID which will
+ * know which ID to search and what to do with it, however, it might be
+ * cases that this function could be called outside of this scope and
+ * therefore is the caller responsibility to check the vendor and/or
+ * device ID first.
+ *
+ * Returns the address of the vendor-specific structure that matches the
+ * requested capability ID code within the device's PCI configuration space
+ * or 0 if it does not find a match.
+ */
+u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						     PCI_EXT_CAP_ID_VNDR))) {
+		if (pci_read_config_dword(dev, vsec + PCI_VSEC_HDR,
+					  &header) == PCIBIOS_SUCCESSFUL &&
+		    PCI_VSEC_CAP_ID(header) == vsec_cap_id)
+			return vsec;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
+
+/**
  * pci_find_parent_resource - return resource region of parent bus of given
  *			      region
  * @dev: PCI device structure contains resources to be searched
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b32126d..da6ab6a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1080,6 +1080,8 @@ struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 u64 pci_get_dsn(struct pci_dev *dev);
 
+u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id);
+
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 			       struct pci_dev *from);
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8..deae275 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -983,6 +983,12 @@
 #define PCI_VSEC_HDR		4	/* extended cap - vendor-specific */
 #define  PCI_VSEC_HDR_LEN_SHIFT	20	/* shift for length field */
 
+/* Vendor-Specific Extended Capabilities */
+#define PCI_VSEC_HEADER		4	/* Vendor-Specific Header */
+#define  PCI_VSEC_CAP_ID(x)	((x) & 0xffff)
+#define  PCI_VSEC_CAP_REV(x)	(((x) >> 16) & 0xf)
+#define  PCI_VSEC_CAP_LEN(x)	(((x) >> 20) & 0xfff)
+
 /* SATA capability */
 #define PCI_SATA_REGS		4	/* SATA REGs specifier */
 #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
-- 
2.7.4

