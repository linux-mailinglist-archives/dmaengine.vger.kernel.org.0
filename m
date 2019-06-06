Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7337D371FC
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfFFKqD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 06:46:03 -0400
Received: from mail-eopbgr810074.outbound.protection.outlook.com ([40.107.81.74]:52096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbfFFKqC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 Jun 2019 06:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg1R0I6reR9dplWRbPP7GkSQrygmHnJ38V+4yz7MpKU=;
 b=0bBcRNN7nw6OMCcb6b2YKN173OZqnkuBoElrTh4Xy0ZYfAJXHqTpQGymbghzWrHoyeImtx8QSOSz6eH8IASpe+i633Q7BQ6nejRyWtLbi9F8Eh5tA04h9WShrW/7ysC7KBGyf0CzQDJWkJT4vt9qGpClxMIatU+dqr5k570dI5g=
Received: from CY4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:903:33::26)
 by DM5PR03MB3130.namprd03.prod.outlook.com (2603:10b6:4:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Thu, 6 Jun
 2019 10:46:00 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR03CA0016.outlook.office365.com
 (2603:10b6:903:33::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.14 via Frontend
 Transport; Thu, 6 Jun 2019 10:46:00 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 10:45:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x56AjxcI013758
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Thu, 6 Jun 2019 03:45:59 -0700
Received: from saturn.ad.analog.com (10.48.65.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Jun 2019 06:45:59 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/4] dmaengine: axi-dmac: add regmap support
Date:   Thu, 6 Jun 2019 13:45:50 +0300
Message-ID: <20190606104550.32336-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606104550.32336-1-alexandru.ardelean@analog.com>
References: <20190606104550.32336-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39850400004)(376002)(2980300002)(199004)(189003)(107886003)(106002)(50466002)(1076003)(305945005)(7636002)(2906002)(4326008)(246002)(50226002)(6306002)(8676002)(8936002)(356004)(6666004)(48376002)(316002)(2870700001)(5660300002)(6916009)(336012)(426003)(51416003)(7696005)(966005)(478600001)(14444005)(36756003)(2351001)(77096007)(486006)(186003)(446003)(11346002)(126002)(26005)(47776003)(86362001)(76176011)(70206006)(2616005)(70586007)(476003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3130;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21a27c51-291d-4e91-e811-08d6ea6c29db
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR03MB3130;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3130:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR03MB31302705136A94A6475762AAF9170@DM5PR03MB3130.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: C2TyvMEd7aFqHuOmnBdkahyTyI8+Xu8vfhPRCwpGrN85/W+qhcMHsil0Bs6L4KcNystF7gtdgW33Euovatty7ts/1ceQcMpNHiRlheSNt9hs4ZfKGNexdX52e/GFFP1Mhnwr2gI19e0AtHSZItip39mgyMN/NzcZTyb4LoGR2RHmwrYfomIQvf/Hkb7lLekKZZdwOT91N188pDUu6RxjrW9RG8g0EQUErDSkRp38m7nnOjGP5agphDq6a8S4pJF/Xlz/4cW+vg9SeUrNv/D2TOOyh3ypTirlyohyIXYTXUpIYxFpcG6J3bRa2XIoqxIrjaGYQoxxuqo3FGI8XkFwfNa73YjshDPM1jie9ES/YedAl/9XIae6sTm6282ak2wyXa0WA4ZWF1MI/zCsQDINC2fBE29bsfBdRmgKUCM+QaU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 10:45:59.6917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a27c51-291d-4e91-e811-08d6ea6c29db
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3130
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The registers for AXI DMAC are detailed at:
  https://wiki.analog.com/resources/fpga/docs/axi_dmac#register_map

This change adds regmap support for these registers, in case some wants to
have a more direct access to them via this interface.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/Kconfig        |  1 +
 drivers/dma/dma-axi-dmac.c | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index eaf78f4e07ce..ae631c6e8bc5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -102,6 +102,7 @@ config AXI_DMAC
 	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_SOCFPGA || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select REGMAP_MMIO
 	help
 	  Enable support for the Analog Devices AXI-DMAC peripheral. This DMA
 	  controller is often used in Analog Device's reference designs for FPGA
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 3b418d545c7a..a35b76f08dfa 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/fpga/adi-axi-common.h>
 
@@ -679,6 +680,44 @@ static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
 	kfree(container_of(vdesc, struct axi_dmac_desc, vdesc));
 }
 
+static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AXI_DMAC_REG_IRQ_MASK:
+	case AXI_DMAC_REG_IRQ_SOURCE:
+	case AXI_DMAC_REG_IRQ_PENDING:
+	case AXI_DMAC_REG_CTRL:
+	case AXI_DMAC_REG_TRANSFER_ID:
+	case AXI_DMAC_REG_START_TRANSFER:
+	case AXI_DMAC_REG_FLAGS:
+	case AXI_DMAC_REG_DEST_ADDRESS:
+	case AXI_DMAC_REG_SRC_ADDRESS:
+	case AXI_DMAC_REG_X_LENGTH:
+	case AXI_DMAC_REG_Y_LENGTH:
+	case AXI_DMAC_REG_DEST_STRIDE:
+	case AXI_DMAC_REG_SRC_STRIDE:
+	case AXI_DMAC_REG_TRANSFER_DONE:
+	case AXI_DMAC_REG_ACTIVE_TRANSFER_ID :
+	case AXI_DMAC_REG_STATUS:
+	case AXI_DMAC_REG_CURRENT_SRC_ADDR:
+	case AXI_DMAC_REG_CURRENT_DEST_ADDR:
+	case AXI_DMAC_REG_PARTIAL_XFER_LEN:
+	case AXI_DMAC_REG_PARTIAL_XFER_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config axi_dmac_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = AXI_DMAC_REG_PARTIAL_XFER_ID,
+	.readable_reg = axi_dmac_regmap_rdwr,
+	.writeable_reg = axi_dmac_regmap_rdwr,
+};
+
 /*
  * The configuration stored in the devicetree matches the configuration
  * parameters of the peripheral instance and allows the driver to know which
@@ -883,6 +922,8 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmac);
 
+	devm_regmap_init_mmio(&pdev->dev, dmac->base, &axi_dmac_regmap_config);
+
 	return 0;
 
 err_unregister_of:
-- 
2.20.1

