Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19C2348A8
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfFDN3c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 09:29:32 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:53136 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727482AbfFDN3b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jun 2019 09:29:31 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 543A4C1F32;
        Tue,  4 Jun 2019 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559654981; bh=kd97XDKnjOupwrWHekVRtiuIqrkK+3KFbvZjtosRs+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bOsFgiyWJ7w7PWufQyLTiR24wlXWC8PL2DzkgEH2QLoPc5Cb6CF7jJ+gAmUzd80kV
         c+gqBZyDdggVTx341c7NOQaYQ4Z2u0UetxBIY6/cDvJUC4fM5YatmoYSJECCdss0DN
         9MzYkHlIn9qNGufFEMEeWUOefrGYtidTMLi8J2VCdHcfp6VcX3tno/BawvzgRDsr8y
         aAwyAZYbvzbZn2zb0u+F1zRgqER3SPPKQCn2TlWla7F28qzm62VB2YpGhx87vSN8te
         JNL9koAsmFFbt7OPdSqyC/OU0guDkrRq1YCHrEYzkF5Bacx6jQ4odRYVVK867268fn
         me5I34rOaPIXg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6241BA0235;
        Tue,  4 Jun 2019 13:29:29 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 3927C3FAD4;
        Tue,  4 Jun 2019 15:29:29 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 4/6] PCI: Add Synopsys endpoint EDDA Device ID
Date:   Tue,  4 Jun 2019 15:29:25 +0200
Message-Id: <f9efb723d07c60ca945d8664814b37b0e969c8f0.1559654565.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Create and add Synopsys Endpoint EDDA Device ID to PCI ID list, since
this ID is now being use on two different drivers (pci_endpoint_test.ko
and dw-edma-pcie.ko).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
---
Changes:
v1 -> v2:
 - Rebased to v5.2-rc1

 drivers/misc/pci_endpoint_test.c | 2 +-
 include/linux/pci_ids.h          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 7b015f2..1f531c1 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -804,7 +804,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e8614..4aad69f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2366,6 +2366,7 @@
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
+#define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
 
 #define PCI_VENDOR_ID_USR		0x16ec
 
-- 
2.7.4

