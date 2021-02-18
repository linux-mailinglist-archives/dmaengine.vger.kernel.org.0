Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6572C31F00C
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBRTjv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:39:51 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33124 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233663AbhBRTFl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:41 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1F05A4016C;
        Thu, 18 Feb 2021 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675060; bh=/zIPChNzuqaHnxdUF1blTbcWoP7Tz+WvyFHNVF5OU5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DDX5e2dU57diajDD3+HJLOMSNuNBWg55W1p8A+TJJV5ZUMXzVMrCNW8USqBqmtOHX
         U0G9nppNbceQlic/0LRSF9cPaGPZKgQACqC2pZ83XZYqadFL13n9Lnjynq4G8N6ZM2
         EaYlR0Fx2vO+v2GS+rebsaJCT/wvDCA3Vw97o0W5Gi0I9gKdFEbNBIyldtzvIDJt3q
         oguAmJGzns7wL23RiTcPsf2liQepNs84QEC66BXXgxxCk/EuGzapp6acEoc6OWmgkW
         5ENKwT3Sl7vL9ayq8jxAAXf3IRYczNTaWdOKnmr8TP6YP1pol3wyTNViR1NeURZ9WO
         uSRslalXdwVmg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id EECB7A0061;
        Thu, 18 Feb 2021 19:04:18 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 04/15] PCI: Add pci_find_vsec_capability() to find a specific VSEC
Date:   Thu, 18 Feb 2021 20:03:58 +0100
Message-Id: <d89506834fb11c6fa0bd5d515c0dd55b13ac6958.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
References: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add pci_find_vsec_capability() to locate a Vendor-Specific Extended
Capability with the specified VSEC ID.

The Vendor-Specific Extended Capability (VSEC) allows one or more
proprietary capabilities defined by the vendor which aren't standard
or shared between vendors.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc2..aef217c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -693,6 +693,36 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
 /**
+ * pci_find_vsec_capability - Find a vendor-specific extended capability
+ * @dev: PCI device to query
+ * @vendor: Vendor ID for which capability is defined
+ * @cap: Vendor-specific capability ID
+ *
+ * If @dev has Vendor ID @vendor, search for a VSEC capability with
+ * VSEC ID @cap. If found, return the capability offset in
+ * config space; otherwise return 0.
+ */
+u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	if (vendor != dev->vendor)
+		return 0;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						     PCI_EXT_CAP_ID_VNDR))) {
+		if (pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
+					  &header) == PCIBIOS_SUCCESSFUL &&
+		    PCI_VNDR_HEADER_ID(header) == cap)
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
index b32126d..814f814 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1077,6 +1077,7 @@ u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
 u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
 u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
+u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
 
 u64 pci_get_dsn(struct pci_dev *dev);
 
-- 
2.7.4

