Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22A531A3C7
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBLRjN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:13 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42824 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhBLRjA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:39:00 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C032740C6B;
        Fri, 12 Feb 2021 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151481; bh=cQjujTnWyKUOSgbCsF+i/tT+Tu5m3bZF6Yf+tcqDiQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=C5hGZlDj8mj7OGvsT73+t+8kStw/uDNgrAzrt87PGvOdTpOvAP3bxDtoN19iu7aME
         njkny07Z3pASP1gtSMqRSipZizHdh+oOeyXzS/tMpAqTjUocQdzSQ/FWZFAuGUvUtb
         vmA72bi8tDLilKvWmfbs4MiBFyUKmF7rKhjiHM9OwJKP1Uc7j5lsEUaath9tiYotAG
         f9mUDY+BZqAX+Ux+Q3Jk2R9aVnlaY547JYb26ynGfLsWcGC9rKOEqOBH5b+a+J0B4v
         G0zwrHQ5tTfFAwIFm7kknTt6D8W7iF0FWSJVD+qm2Ox4Y+QanMYham8PT9qmFjaz+J
         vo8IBuJti7fpw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 89A0CA005C;
        Fri, 12 Feb 2021 17:37:59 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 04/15] PCI: Add pci_find_vsec_capability() to find a specific VSEC
Date:   Fri, 12 Feb 2021 18:37:39 +0100
Message-Id: <145b54b2a6feabcfa913ec8c44c9dee92deedf11.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adds another helper to ones that already exist called
pci_find_vsec_capability. This helper crawls through the device PCI
config space searching for a specific ID on the Vendor-Specific Extended
Capabilities section.

The Vendor-Specific Extended Capability (VSEC) is a special PCI
capability (acts like container) defined by PCI-SIG that allows the one
or more proprietary capabilities defined by the vendor which aren't
standard or shared between the manufactures.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.c             | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  6 ++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc2..628aa9f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -693,6 +693,40 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
 /**
+ * pci_find_vsec_capability - Find a vendor-specific extended capability
+ * @dev: PCI device to query
+ * @cap: vendor-specific capability ID code
+ *
+ * Typically this function will be called by the PCI driver, which passes
+ * through argument the 'struct pci_dev *' already pointing for the device
+ * config space that is associated with the vendor and device ID which will
+ * know which ID to search and what to do with it, however, there might be
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

