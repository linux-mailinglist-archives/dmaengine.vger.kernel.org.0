Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA6268D0D
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgINOKN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:10:13 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6837 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgINOKL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092610; x=1631628610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYDhd/FJLml3imudNetsFooMTS+ot8GWqvv/6Oq+a1Q=;
  b=eIj/4+73AkupAzqDsinhZFL4bMmV8emSsQr5QDdYdUBlrVSPOuJ5Gu5d
   +knbNpxGJr7tK0fYzI29LuumbeJ2kUG/gQzFKImy2BOv6bei484zNx9kr
   c0rucAYSRsQi7Rv5AdgM1Qppf9DDScFU6SP1L2nP5FYYwhBQVuOwqIb7O
   r/ATB48MxrMUPET26ZJ/uYM+3Yw4glUnQBxC1XwsajYcDZtquKBo8VkgH
   pavoTzs+Kp8g5PJTgQfrD6LkodKHlJTHpjIpu/Jj+Q/jV5OnvYE5tImy5
   RDqBChghtp0M+QgrylhdTbEUD5tuBiVtBRwQD2ui57T256C82SMsT9U3x
   A==;
IronPort-SDR: RTplavA7CAXz2qi+5rKFZpGD9LooTK0NUnyrnDCakhp7nXGs6wiluMLji816czsfXwBXeEIL7n
 9rBTmXfvTNbfY8kGIXxniIMSCIvo886MnfdutJVJuRESVbHzI4yY6ZKuxNQhnW1g41R7j1kRgQ
 4jYue+qLtqerOvR59p0cMeEm3B9tB7+txwSwgWQkaZtQnI5t0ch0zX7CsFZdNs/+5j5jYXUjHV
 Sk1+CZVt+Cm+0qZLyo15HvV0xH9M68y6+JrwoA+luuqP7flMf1p/obWIy0K8Vn4WrnIzRqikre
 o3s=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="88993907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:06 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:10:01 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 1/7] dmaengine: at_xdmac: separate register defines into header file
Date:   Mon, 14 Sep 2020 17:09:50 +0300
Message-ID: <20200914140956.221432-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914140956.221432-1-eugen.hristev@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Separate register defines into header file.
This is required to support a slightly different version of the register
map in new hardware versions of the XDMAC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/dma/at_xdmac.c      | 143 +--------------------------------
 drivers/dma/at_xdmac_regs.h | 154 ++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 142 deletions(-)
 create mode 100644 drivers/dma/at_xdmac_regs.h

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fd92f048c491..fab19e00a7be 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -24,148 +24,7 @@
 
 #include "dmaengine.h"
 
-/* Global registers */
-#define AT_XDMAC_GTYPE		0x00	/* Global Type Register */
-#define		AT_XDMAC_NB_CH(i)	(((i) & 0x1F) + 1)		/* Number of Channels Minus One */
-#define		AT_XDMAC_FIFO_SZ(i)	(((i) >> 5) & 0x7FF)		/* Number of Bytes */
-#define		AT_XDMAC_NB_REQ(i)	((((i) >> 16) & 0x3F) + 1)	/* Number of Peripheral Requests Minus One */
-#define AT_XDMAC_GCFG		0x04	/* Global Configuration Register */
-#define AT_XDMAC_GWAC		0x08	/* Global Weighted Arbiter Configuration Register */
-#define AT_XDMAC_GIE		0x0C	/* Global Interrupt Enable Register */
-#define AT_XDMAC_GID		0x10	/* Global Interrupt Disable Register */
-#define AT_XDMAC_GIM		0x14	/* Global Interrupt Mask Register */
-#define AT_XDMAC_GIS		0x18	/* Global Interrupt Status Register */
-#define AT_XDMAC_GE		0x1C	/* Global Channel Enable Register */
-#define AT_XDMAC_GD		0x20	/* Global Channel Disable Register */
-#define AT_XDMAC_GS		0x24	/* Global Channel Status Register */
-#define AT_XDMAC_GRS		0x28	/* Global Channel Read Suspend Register */
-#define AT_XDMAC_GWS		0x2C	/* Global Write Suspend Register */
-#define AT_XDMAC_GRWS		0x30	/* Global Channel Read Write Suspend Register */
-#define AT_XDMAC_GRWR		0x34	/* Global Channel Read Write Resume Register */
-#define AT_XDMAC_GSWR		0x38	/* Global Channel Software Request Register */
-#define AT_XDMAC_GSWS		0x3C	/* Global channel Software Request Status Register */
-#define AT_XDMAC_GSWF		0x40	/* Global Channel Software Flush Request Register */
-#define AT_XDMAC_VERSION	0xFFC	/* XDMAC Version Register */
-
-/* Channel relative registers offsets */
-#define AT_XDMAC_CIE		0x00	/* Channel Interrupt Enable Register */
-#define		AT_XDMAC_CIE_BIE	BIT(0)	/* End of Block Interrupt Enable Bit */
-#define		AT_XDMAC_CIE_LIE	BIT(1)	/* End of Linked List Interrupt Enable Bit */
-#define		AT_XDMAC_CIE_DIE	BIT(2)	/* End of Disable Interrupt Enable Bit */
-#define		AT_XDMAC_CIE_FIE	BIT(3)	/* End of Flush Interrupt Enable Bit */
-#define		AT_XDMAC_CIE_RBEIE	BIT(4)	/* Read Bus Error Interrupt Enable Bit */
-#define		AT_XDMAC_CIE_WBEIE	BIT(5)	/* Write Bus Error Interrupt Enable Bit */
-#define		AT_XDMAC_CIE_ROIE	BIT(6)	/* Request Overflow Interrupt Enable Bit */
-#define AT_XDMAC_CID		0x04	/* Channel Interrupt Disable Register */
-#define		AT_XDMAC_CID_BID	BIT(0)	/* End of Block Interrupt Disable Bit */
-#define		AT_XDMAC_CID_LID	BIT(1)	/* End of Linked List Interrupt Disable Bit */
-#define		AT_XDMAC_CID_DID	BIT(2)	/* End of Disable Interrupt Disable Bit */
-#define		AT_XDMAC_CID_FID	BIT(3)	/* End of Flush Interrupt Disable Bit */
-#define		AT_XDMAC_CID_RBEID	BIT(4)	/* Read Bus Error Interrupt Disable Bit */
-#define		AT_XDMAC_CID_WBEID	BIT(5)	/* Write Bus Error Interrupt Disable Bit */
-#define		AT_XDMAC_CID_ROID	BIT(6)	/* Request Overflow Interrupt Disable Bit */
-#define AT_XDMAC_CIM		0x08	/* Channel Interrupt Mask Register */
-#define		AT_XDMAC_CIM_BIM	BIT(0)	/* End of Block Interrupt Mask Bit */
-#define		AT_XDMAC_CIM_LIM	BIT(1)	/* End of Linked List Interrupt Mask Bit */
-#define		AT_XDMAC_CIM_DIM	BIT(2)	/* End of Disable Interrupt Mask Bit */
-#define		AT_XDMAC_CIM_FIM	BIT(3)	/* End of Flush Interrupt Mask Bit */
-#define		AT_XDMAC_CIM_RBEIM	BIT(4)	/* Read Bus Error Interrupt Mask Bit */
-#define		AT_XDMAC_CIM_WBEIM	BIT(5)	/* Write Bus Error Interrupt Mask Bit */
-#define		AT_XDMAC_CIM_ROIM	BIT(6)	/* Request Overflow Interrupt Mask Bit */
-#define AT_XDMAC_CIS		0x0C	/* Channel Interrupt Status Register */
-#define		AT_XDMAC_CIS_BIS	BIT(0)	/* End of Block Interrupt Status Bit */
-#define		AT_XDMAC_CIS_LIS	BIT(1)	/* End of Linked List Interrupt Status Bit */
-#define		AT_XDMAC_CIS_DIS	BIT(2)	/* End of Disable Interrupt Status Bit */
-#define		AT_XDMAC_CIS_FIS	BIT(3)	/* End of Flush Interrupt Status Bit */
-#define		AT_XDMAC_CIS_RBEIS	BIT(4)	/* Read Bus Error Interrupt Status Bit */
-#define		AT_XDMAC_CIS_WBEIS	BIT(5)	/* Write Bus Error Interrupt Status Bit */
-#define		AT_XDMAC_CIS_ROIS	BIT(6)	/* Request Overflow Interrupt Status Bit */
-#define AT_XDMAC_CSA		0x10	/* Channel Source Address Register */
-#define AT_XDMAC_CDA		0x14	/* Channel Destination Address Register */
-#define AT_XDMAC_CNDA		0x18	/* Channel Next Descriptor Address Register */
-#define		AT_XDMAC_CNDA_NDAIF(i)	((i) & 0x1)			/* Channel x Next Descriptor Interface */
-#define		AT_XDMAC_CNDA_NDA(i)	((i) & 0xfffffffc)		/* Channel x Next Descriptor Address */
-#define AT_XDMAC_CNDC		0x1C	/* Channel Next Descriptor Control Register */
-#define		AT_XDMAC_CNDC_NDE		(0x1 << 0)		/* Channel x Next Descriptor Enable */
-#define		AT_XDMAC_CNDC_NDSUP		(0x1 << 1)		/* Channel x Next Descriptor Source Update */
-#define		AT_XDMAC_CNDC_NDDUP		(0x1 << 2)		/* Channel x Next Descriptor Destination Update */
-#define		AT_XDMAC_CNDC_NDVIEW_NDV0	(0x0 << 3)		/* Channel x Next Descriptor View 0 */
-#define		AT_XDMAC_CNDC_NDVIEW_NDV1	(0x1 << 3)		/* Channel x Next Descriptor View 1 */
-#define		AT_XDMAC_CNDC_NDVIEW_NDV2	(0x2 << 3)		/* Channel x Next Descriptor View 2 */
-#define		AT_XDMAC_CNDC_NDVIEW_NDV3	(0x3 << 3)		/* Channel x Next Descriptor View 3 */
-#define AT_XDMAC_CUBC		0x20	/* Channel Microblock Control Register */
-#define AT_XDMAC_CBC		0x24	/* Channel Block Control Register */
-#define AT_XDMAC_CC		0x28	/* Channel Configuration Register */
-#define		AT_XDMAC_CC_TYPE	(0x1 << 0)	/* Channel Transfer Type */
-#define			AT_XDMAC_CC_TYPE_MEM_TRAN	(0x0 << 0)	/* Memory to Memory Transfer */
-#define			AT_XDMAC_CC_TYPE_PER_TRAN	(0x1 << 0)	/* Peripheral to Memory or Memory to Peripheral Transfer */
-#define		AT_XDMAC_CC_MBSIZE_MASK	(0x3 << 1)
-#define			AT_XDMAC_CC_MBSIZE_SINGLE	(0x0 << 1)
-#define			AT_XDMAC_CC_MBSIZE_FOUR		(0x1 << 1)
-#define			AT_XDMAC_CC_MBSIZE_EIGHT	(0x2 << 1)
-#define			AT_XDMAC_CC_MBSIZE_SIXTEEN	(0x3 << 1)
-#define		AT_XDMAC_CC_DSYNC	(0x1 << 4)	/* Channel Synchronization */
-#define			AT_XDMAC_CC_DSYNC_PER2MEM	(0x0 << 4)
-#define			AT_XDMAC_CC_DSYNC_MEM2PER	(0x1 << 4)
-#define		AT_XDMAC_CC_PROT	(0x1 << 5)	/* Channel Protection */
-#define			AT_XDMAC_CC_PROT_SEC		(0x0 << 5)
-#define			AT_XDMAC_CC_PROT_UNSEC		(0x1 << 5)
-#define		AT_XDMAC_CC_SWREQ	(0x1 << 6)	/* Channel Software Request Trigger */
-#define			AT_XDMAC_CC_SWREQ_HWR_CONNECTED	(0x0 << 6)
-#define			AT_XDMAC_CC_SWREQ_SWR_CONNECTED	(0x1 << 6)
-#define		AT_XDMAC_CC_MEMSET	(0x1 << 7)	/* Channel Fill Block of memory */
-#define			AT_XDMAC_CC_MEMSET_NORMAL_MODE	(0x0 << 7)
-#define			AT_XDMAC_CC_MEMSET_HW_MODE	(0x1 << 7)
-#define		AT_XDMAC_CC_CSIZE(i)	((0x7 & (i)) << 8)	/* Channel Chunk Size */
-#define		AT_XDMAC_CC_DWIDTH_OFFSET	11
-#define		AT_XDMAC_CC_DWIDTH_MASK	(0x3 << AT_XDMAC_CC_DWIDTH_OFFSET)
-#define		AT_XDMAC_CC_DWIDTH(i)	((0x3 & (i)) << AT_XDMAC_CC_DWIDTH_OFFSET)	/* Channel Data Width */
-#define			AT_XDMAC_CC_DWIDTH_BYTE		0x0
-#define			AT_XDMAC_CC_DWIDTH_HALFWORD	0x1
-#define			AT_XDMAC_CC_DWIDTH_WORD		0x2
-#define			AT_XDMAC_CC_DWIDTH_DWORD	0x3
-#define		AT_XDMAC_CC_SIF(i)	((0x1 & (i)) << 13)	/* Channel Source Interface Identifier */
-#define		AT_XDMAC_CC_DIF(i)	((0x1 & (i)) << 14)	/* Channel Destination Interface Identifier */
-#define		AT_XDMAC_CC_SAM_MASK	(0x3 << 16)	/* Channel Source Addressing Mode */
-#define			AT_XDMAC_CC_SAM_FIXED_AM	(0x0 << 16)
-#define			AT_XDMAC_CC_SAM_INCREMENTED_AM	(0x1 << 16)
-#define			AT_XDMAC_CC_SAM_UBS_AM		(0x2 << 16)
-#define			AT_XDMAC_CC_SAM_UBS_DS_AM	(0x3 << 16)
-#define		AT_XDMAC_CC_DAM_MASK	(0x3 << 18)	/* Channel Source Addressing Mode */
-#define			AT_XDMAC_CC_DAM_FIXED_AM	(0x0 << 18)
-#define			AT_XDMAC_CC_DAM_INCREMENTED_AM	(0x1 << 18)
-#define			AT_XDMAC_CC_DAM_UBS_AM		(0x2 << 18)
-#define			AT_XDMAC_CC_DAM_UBS_DS_AM	(0x3 << 18)
-#define		AT_XDMAC_CC_INITD	(0x1 << 21)	/* Channel Initialization Terminated (read only) */
-#define			AT_XDMAC_CC_INITD_TERMINATED	(0x0 << 21)
-#define			AT_XDMAC_CC_INITD_IN_PROGRESS	(0x1 << 21)
-#define		AT_XDMAC_CC_RDIP	(0x1 << 22)	/* Read in Progress (read only) */
-#define			AT_XDMAC_CC_RDIP_DONE		(0x0 << 22)
-#define			AT_XDMAC_CC_RDIP_IN_PROGRESS	(0x1 << 22)
-#define		AT_XDMAC_CC_WRIP	(0x1 << 23)	/* Write in Progress (read only) */
-#define			AT_XDMAC_CC_WRIP_DONE		(0x0 << 23)
-#define			AT_XDMAC_CC_WRIP_IN_PROGRESS	(0x1 << 23)
-#define		AT_XDMAC_CC_PERID(i)	(0x7f & (i) << 24)	/* Channel Peripheral Identifier */
-#define AT_XDMAC_CDS_MSP	0x2C	/* Channel Data Stride Memory Set Pattern */
-#define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
-#define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
-
-#define AT_XDMAC_CHAN_REG_BASE	0x50	/* Channel registers base address */
-
-/* Microblock control members */
-#define AT_XDMAC_MBR_UBC_UBLEN_MAX	0xFFFFFFUL	/* Maximum Microblock Length */
-#define AT_XDMAC_MBR_UBC_NDE		(0x1 << 24)	/* Next Descriptor Enable */
-#define AT_XDMAC_MBR_UBC_NSEN		(0x1 << 25)	/* Next Descriptor Source Update */
-#define AT_XDMAC_MBR_UBC_NDEN		(0x1 << 26)	/* Next Descriptor Destination Update */
-#define AT_XDMAC_MBR_UBC_NDV0		(0x0 << 27)	/* Next Descriptor View 0 */
-#define AT_XDMAC_MBR_UBC_NDV1		(0x1 << 27)	/* Next Descriptor View 1 */
-#define AT_XDMAC_MBR_UBC_NDV2		(0x2 << 27)	/* Next Descriptor View 2 */
-#define AT_XDMAC_MBR_UBC_NDV3		(0x3 << 27)	/* Next Descriptor View 3 */
-
-#define AT_XDMAC_MAX_CHAN	0x20
-#define AT_XDMAC_MAX_CSIZE	16	/* 16 data */
-#define AT_XDMAC_MAX_DWIDTH	8	/* 64 bits */
-#define AT_XDMAC_RESIDUE_MAX_RETRIES	5
+#include "at_xdmac_regs.h"
 
 #define AT_XDMAC_DMA_BUSWIDTHS\
 	(BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED) |\
diff --git a/drivers/dma/at_xdmac_regs.h b/drivers/dma/at_xdmac_regs.h
new file mode 100644
index 000000000000..3f7dda4c5743
--- /dev/null
+++ b/drivers/dma/at_xdmac_regs.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Header file for the Atmel Extensible DMA Controller (aka XDMAC on AT91 systems)
+ *
+ * Copyright (C) 2014-2020 Microchip Technology, Inc. and its subsidiaries
+ *
+ */
+#ifndef AT_XDMAC_REGS_H
+#define	AT_XDMAC_REGS_H
+
+/* Global registers */
+#define AT_XDMAC_GTYPE		0x00	/* Global Type Register */
+#define		AT_XDMAC_NB_CH(i)	(((i) & 0x1F) + 1)		/* Number of Channels Minus One */
+#define		AT_XDMAC_FIFO_SZ(i)	(((i) >> 5) & 0x7FF)		/* Number of Bytes */
+#define		AT_XDMAC_NB_REQ(i)	((((i) >> 16) & 0x3F) + 1)	/* Number of Peripheral Requests Minus One */
+#define AT_XDMAC_GCFG		0x04	/* Global Configuration Register */
+#define AT_XDMAC_GWAC		0x08	/* Global Weighted Arbiter Configuration Register */
+#define AT_XDMAC_GIE		0x0C	/* Global Interrupt Enable Register */
+#define AT_XDMAC_GID		0x10	/* Global Interrupt Disable Register */
+#define AT_XDMAC_GIM		0x14	/* Global Interrupt Mask Register */
+#define AT_XDMAC_GIS		0x18	/* Global Interrupt Status Register */
+#define AT_XDMAC_GE		0x1C	/* Global Channel Enable Register */
+#define AT_XDMAC_GD		0x20	/* Global Channel Disable Register */
+#define AT_XDMAC_GS		0x24	/* Global Channel Status Register */
+#define AT_XDMAC_GRS		0x28	/* Global Channel Read Suspend Register */
+#define AT_XDMAC_GWS		0x2C	/* Global Write Suspend Register */
+#define AT_XDMAC_GRWS		0x30	/* Global Channel Read Write Suspend Register */
+#define AT_XDMAC_GRWR		0x34	/* Global Channel Read Write Resume Register */
+#define AT_XDMAC_GSWR		0x38	/* Global Channel Software Request Register */
+#define AT_XDMAC_GSWS		0x3C	/* Global channel Software Request Status Register */
+#define AT_XDMAC_GSWF		0x40	/* Global Channel Software Flush Request Register */
+#define AT_XDMAC_VERSION	0xFFC	/* XDMAC Version Register */
+
+/* Channel relative registers offsets */
+#define AT_XDMAC_CIE		0x00	/* Channel Interrupt Enable Register */
+#define		AT_XDMAC_CIE_BIE	BIT(0)	/* End of Block Interrupt Enable Bit */
+#define		AT_XDMAC_CIE_LIE	BIT(1)	/* End of Linked List Interrupt Enable Bit */
+#define		AT_XDMAC_CIE_DIE	BIT(2)	/* End of Disable Interrupt Enable Bit */
+#define		AT_XDMAC_CIE_FIE	BIT(3)	/* End of Flush Interrupt Enable Bit */
+#define		AT_XDMAC_CIE_RBEIE	BIT(4)	/* Read Bus Error Interrupt Enable Bit */
+#define		AT_XDMAC_CIE_WBEIE	BIT(5)	/* Write Bus Error Interrupt Enable Bit */
+#define		AT_XDMAC_CIE_ROIE	BIT(6)	/* Request Overflow Interrupt Enable Bit */
+#define AT_XDMAC_CID		0x04	/* Channel Interrupt Disable Register */
+#define		AT_XDMAC_CID_BID	BIT(0)	/* End of Block Interrupt Disable Bit */
+#define		AT_XDMAC_CID_LID	BIT(1)	/* End of Linked List Interrupt Disable Bit */
+#define		AT_XDMAC_CID_DID	BIT(2)	/* End of Disable Interrupt Disable Bit */
+#define		AT_XDMAC_CID_FID	BIT(3)	/* End of Flush Interrupt Disable Bit */
+#define		AT_XDMAC_CID_RBEID	BIT(4)	/* Read Bus Error Interrupt Disable Bit */
+#define		AT_XDMAC_CID_WBEID	BIT(5)	/* Write Bus Error Interrupt Disable Bit */
+#define		AT_XDMAC_CID_ROID	BIT(6)	/* Request Overflow Interrupt Disable Bit */
+#define AT_XDMAC_CIM		0x08	/* Channel Interrupt Mask Register */
+#define		AT_XDMAC_CIM_BIM	BIT(0)	/* End of Block Interrupt Mask Bit */
+#define		AT_XDMAC_CIM_LIM	BIT(1)	/* End of Linked List Interrupt Mask Bit */
+#define		AT_XDMAC_CIM_DIM	BIT(2)	/* End of Disable Interrupt Mask Bit */
+#define		AT_XDMAC_CIM_FIM	BIT(3)	/* End of Flush Interrupt Mask Bit */
+#define		AT_XDMAC_CIM_RBEIM	BIT(4)	/* Read Bus Error Interrupt Mask Bit */
+#define		AT_XDMAC_CIM_WBEIM	BIT(5)	/* Write Bus Error Interrupt Mask Bit */
+#define		AT_XDMAC_CIM_ROIM	BIT(6)	/* Request Overflow Interrupt Mask Bit */
+#define AT_XDMAC_CIS		0x0C	/* Channel Interrupt Status Register */
+#define		AT_XDMAC_CIS_BIS	BIT(0)	/* End of Block Interrupt Status Bit */
+#define		AT_XDMAC_CIS_LIS	BIT(1)	/* End of Linked List Interrupt Status Bit */
+#define		AT_XDMAC_CIS_DIS	BIT(2)	/* End of Disable Interrupt Status Bit */
+#define		AT_XDMAC_CIS_FIS	BIT(3)	/* End of Flush Interrupt Status Bit */
+#define		AT_XDMAC_CIS_RBEIS	BIT(4)	/* Read Bus Error Interrupt Status Bit */
+#define		AT_XDMAC_CIS_WBEIS	BIT(5)	/* Write Bus Error Interrupt Status Bit */
+#define		AT_XDMAC_CIS_ROIS	BIT(6)	/* Request Overflow Interrupt Status Bit */
+#define AT_XDMAC_CSA		0x10	/* Channel Source Address Register */
+#define AT_XDMAC_CDA		0x14	/* Channel Destination Address Register */
+#define AT_XDMAC_CNDA		0x18	/* Channel Next Descriptor Address Register */
+#define		AT_XDMAC_CNDA_NDAIF(i)	((i) & 0x1)			/* Channel x Next Descriptor Interface */
+#define		AT_XDMAC_CNDA_NDA(i)	((i) & 0xfffffffc)		/* Channel x Next Descriptor Address */
+#define AT_XDMAC_CNDC		0x1C	/* Channel Next Descriptor Control Register */
+#define		AT_XDMAC_CNDC_NDE		(0x1 << 0)		/* Channel x Next Descriptor Enable */
+#define		AT_XDMAC_CNDC_NDSUP		(0x1 << 1)		/* Channel x Next Descriptor Source Update */
+#define		AT_XDMAC_CNDC_NDDUP		(0x1 << 2)		/* Channel x Next Descriptor Destination Update */
+#define		AT_XDMAC_CNDC_NDVIEW_NDV0	(0x0 << 3)		/* Channel x Next Descriptor View 0 */
+#define		AT_XDMAC_CNDC_NDVIEW_NDV1	(0x1 << 3)		/* Channel x Next Descriptor View 1 */
+#define		AT_XDMAC_CNDC_NDVIEW_NDV2	(0x2 << 3)		/* Channel x Next Descriptor View 2 */
+#define		AT_XDMAC_CNDC_NDVIEW_NDV3	(0x3 << 3)		/* Channel x Next Descriptor View 3 */
+#define AT_XDMAC_CUBC		0x20	/* Channel Microblock Control Register */
+#define AT_XDMAC_CBC		0x24	/* Channel Block Control Register */
+#define AT_XDMAC_CC		0x28	/* Channel Configuration Register */
+#define		AT_XDMAC_CC_TYPE	(0x1 << 0)	/* Channel Transfer Type */
+#define			AT_XDMAC_CC_TYPE_MEM_TRAN	(0x0 << 0)	/* Memory to Memory Transfer */
+#define			AT_XDMAC_CC_TYPE_PER_TRAN	(0x1 << 0)	/* Peripheral to Memory or Memory to Peripheral Transfer */
+#define		AT_XDMAC_CC_MBSIZE_MASK	(0x3 << 1)
+#define			AT_XDMAC_CC_MBSIZE_SINGLE	(0x0 << 1)
+#define			AT_XDMAC_CC_MBSIZE_FOUR		(0x1 << 1)
+#define			AT_XDMAC_CC_MBSIZE_EIGHT	(0x2 << 1)
+#define			AT_XDMAC_CC_MBSIZE_SIXTEEN	(0x3 << 1)
+#define		AT_XDMAC_CC_DSYNC	(0x1 << 4)	/* Channel Synchronization */
+#define			AT_XDMAC_CC_DSYNC_PER2MEM	(0x0 << 4)
+#define			AT_XDMAC_CC_DSYNC_MEM2PER	(0x1 << 4)
+#define		AT_XDMAC_CC_PROT	(0x1 << 5)	/* Channel Protection */
+#define			AT_XDMAC_CC_PROT_SEC		(0x0 << 5)
+#define			AT_XDMAC_CC_PROT_UNSEC		(0x1 << 5)
+#define		AT_XDMAC_CC_SWREQ	(0x1 << 6)	/* Channel Software Request Trigger */
+#define			AT_XDMAC_CC_SWREQ_HWR_CONNECTED	(0x0 << 6)
+#define			AT_XDMAC_CC_SWREQ_SWR_CONNECTED	(0x1 << 6)
+#define		AT_XDMAC_CC_MEMSET	(0x1 << 7)	/* Channel Fill Block of memory */
+#define			AT_XDMAC_CC_MEMSET_NORMAL_MODE	(0x0 << 7)
+#define			AT_XDMAC_CC_MEMSET_HW_MODE	(0x1 << 7)
+#define		AT_XDMAC_CC_CSIZE(i)	((0x7 & (i)) << 8)	/* Channel Chunk Size */
+#define		AT_XDMAC_CC_DWIDTH_OFFSET	11
+#define		AT_XDMAC_CC_DWIDTH_MASK	(0x3 << AT_XDMAC_CC_DWIDTH_OFFSET)
+#define		AT_XDMAC_CC_DWIDTH(i)	((0x3 & (i)) << AT_XDMAC_CC_DWIDTH_OFFSET)	/* Channel Data Width */
+#define			AT_XDMAC_CC_DWIDTH_BYTE		0x0
+#define			AT_XDMAC_CC_DWIDTH_HALFWORD	0x1
+#define			AT_XDMAC_CC_DWIDTH_WORD		0x2
+#define			AT_XDMAC_CC_DWIDTH_DWORD	0x3
+#define		AT_XDMAC_CC_SIF(i)	((0x1 & (i)) << 13)	/* Channel Source Interface Identifier */
+#define		AT_XDMAC_CC_DIF(i)	((0x1 & (i)) << 14)	/* Channel Destination Interface Identifier */
+#define		AT_XDMAC_CC_SAM_MASK	(0x3 << 16)	/* Channel Source Addressing Mode */
+#define			AT_XDMAC_CC_SAM_FIXED_AM	(0x0 << 16)
+#define			AT_XDMAC_CC_SAM_INCREMENTED_AM	(0x1 << 16)
+#define			AT_XDMAC_CC_SAM_UBS_AM		(0x2 << 16)
+#define			AT_XDMAC_CC_SAM_UBS_DS_AM	(0x3 << 16)
+#define		AT_XDMAC_CC_DAM_MASK	(0x3 << 18)	/* Channel Source Addressing Mode */
+#define			AT_XDMAC_CC_DAM_FIXED_AM	(0x0 << 18)
+#define			AT_XDMAC_CC_DAM_INCREMENTED_AM	(0x1 << 18)
+#define			AT_XDMAC_CC_DAM_UBS_AM		(0x2 << 18)
+#define			AT_XDMAC_CC_DAM_UBS_DS_AM	(0x3 << 18)
+#define		AT_XDMAC_CC_INITD	(0x1 << 21)	/* Channel Initialization Terminated (read only) */
+#define			AT_XDMAC_CC_INITD_TERMINATED	(0x0 << 21)
+#define			AT_XDMAC_CC_INITD_IN_PROGRESS	(0x1 << 21)
+#define		AT_XDMAC_CC_RDIP	(0x1 << 22)	/* Read in Progress (read only) */
+#define			AT_XDMAC_CC_RDIP_DONE		(0x0 << 22)
+#define			AT_XDMAC_CC_RDIP_IN_PROGRESS	(0x1 << 22)
+#define		AT_XDMAC_CC_WRIP	(0x1 << 23)	/* Write in Progress (read only) */
+#define			AT_XDMAC_CC_WRIP_DONE		(0x0 << 23)
+#define			AT_XDMAC_CC_WRIP_IN_PROGRESS	(0x1 << 23)
+#define		AT_XDMAC_CC_PERID(i)	(0x7f & (i) << 24)	/* Channel Peripheral Identifier */
+#define AT_XDMAC_CDS_MSP	0x2C	/* Channel Data Stride Memory Set Pattern */
+#define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
+#define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
+
+#define AT_XDMAC_CHAN_REG_BASE	0x50	/* Channel registers base address */
+
+/* Microblock control members */
+#define AT_XDMAC_MBR_UBC_UBLEN_MAX	0xFFFFFFUL	/* Maximum Microblock Length */
+#define AT_XDMAC_MBR_UBC_NDE		(0x1 << 24)	/* Next Descriptor Enable */
+#define AT_XDMAC_MBR_UBC_NSEN		(0x1 << 25)	/* Next Descriptor Source Update */
+#define AT_XDMAC_MBR_UBC_NDEN		(0x1 << 26)	/* Next Descriptor Destination Update */
+#define AT_XDMAC_MBR_UBC_NDV0		(0x0 << 27)	/* Next Descriptor View 0 */
+#define AT_XDMAC_MBR_UBC_NDV1		(0x1 << 27)	/* Next Descriptor View 1 */
+#define AT_XDMAC_MBR_UBC_NDV2		(0x2 << 27)	/* Next Descriptor View 2 */
+#define AT_XDMAC_MBR_UBC_NDV3		(0x3 << 27)	/* Next Descriptor View 3 */
+
+#define AT_XDMAC_MAX_CHAN	0x20
+#define AT_XDMAC_MAX_CSIZE	16	/* 16 data */
+#define AT_XDMAC_MAX_DWIDTH	8	/* 64 bits */
+#define AT_XDMAC_RESIDUE_MAX_RETRIES	5
+
+#endif
-- 
2.25.1

