Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687BC26688
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 17:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEVPEK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 11:04:10 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:37396 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729430AbfEVPEK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 May 2019 11:04:10 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3253CC0B92;
        Wed, 22 May 2019 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558537457; bh=QMumROM5kCHuwpr8gzsudweXd+5Xmn9Bswpd1qCx6ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RmSrFjaNM+5EbO7Y9YuoufgV0Yw8OfTjYbpVPUiaPwrSn9voe2ikkSgAjAcxLYf/F
         mmJxSB2xmSAwzSIwi7a9akK0acbOPUNJ4C76mEgMz4qUy7r6Xr2SjlJITqceSrdid7
         E3l6wfRzeQXWR/mePiAb7N4fHnxxSKwXMFGQsNlxsqidexl3ELzb6DmlJ71Sqkne9p
         CLkKlx439v76yfSu4AwDW42Sy0ZlO6Cy2aP6Md5sAzhbkthdGDM/2B17vyTANswKTw
         S3qk4GRLNvlOWrZC5HS7bwLRXdWmGkxESgcZHi+nRCdKzPhrrJiuVFTFPIPTZLkAqo
         NLAPj+UrkuGQg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id DCB55A0098;
        Wed, 22 May 2019 15:04:09 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E354F3F064;
        Wed, 22 May 2019 17:04:08 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 4/6] PCI: Add Synopsys endpoint EDDA Device ID
Date:   Wed, 22 May 2019 17:04:03 +0200
Message-Id: <80b95a37a12a58b59a85688ed0549209d12bdce7.1558536992.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
References: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
References: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
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
 drivers/misc/pci_endpoint_test.c | 2 +-
 include/linux/pci_ids.h          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 29582fe..f65a882 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -789,7 +789,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
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

