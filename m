Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDAA30BE77
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 13:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhBBMmW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 07:42:22 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44066 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhBBMlv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 07:41:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BB62E401D9;
        Tue,  2 Feb 2021 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612269651; bh=gTUqsn4xz8ouo5ljskht8yvrZS1XGOyKaK7hjYUYuHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ykprg8VljNuG9luuifcUGnu5RpgLS5pa1zdtnXXvkC2fm3iiACfSwuaS2k+euSOFQ
         u+HVTKqUxBB+o6AIP92rCx66FdW7IRe4OSe8+uE2zAnLvXswX9Yb5Erl/11zAIl7DI
         PZaixtjw3wQv4LDjs2/7AB35xcsP2NoVho5bGJoy+QQbyJlCxpKbLb+llewIEJHhS8
         8heyApLXhU3BOUIushdBXRQyZurFZq+gDdBpy3iU3Z2zo80KloOt0nuISce3WBI9kk
         D62QRskSCpUp0yBwHwLYx7W601bGir5283G0KSGdjpHFdUkshiOV9TmWK2BL+2OgnQ
         Ljgt70gmhhbcA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7B896A0249;
        Tue,  2 Feb 2021 12:40:49 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v2 04/15] PCI: Add pci_find_vsec_capability() to find a specific VSEC
Date:   Tue,  2 Feb 2021 13:40:18 +0100
Message-Id: <2ecb33dfee5dc05efc05de0731b0cb77bc246f54.1612269537.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
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
 drivers/pci/pci.c             | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  6 ++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc2..4ea6dd4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -693,6 +693,35 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
 /**
+ * pci_find_vsec_capability - Find a vendor-specific extended capability
+ * @dev: PCI device to query
+ * @cap: vendor-specific capability ID code
+ *
+ * Returns the address of the vendor-specific structure that matches the
+ * requested capability ID code within the device's PCI configuration space
+ * or 0 if it does not find a match.
+ */
+u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
+{
+	u16 vsec;
+	u32 header;
+
+	vsec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VNDR);
+	while (vsec) {
+		if (pci_read_config_dword(dev, vsec + PCI_VSEC_HDR,
+					  &header) == PCIBIOS_SUCCESSFUL &&
+		    PCI_VSEC_CAP_ID(header) == vsec_cap_id)
+			return vsec;
+
+		vsec = pci_find_next_ext_capability(dev, vsec,
+						    PCI_EXT_CAP_ID_VNDR);
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

