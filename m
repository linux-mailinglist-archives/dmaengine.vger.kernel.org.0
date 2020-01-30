Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E002614DB06
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgA3Myp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 07:54:45 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:6151
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbgA3Myo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jan 2020 07:54:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya2UOnG9ZxE3IA0cNypEkUfQhJmZRY/wFpp++yIcQEFD9LBCw8AknIx+zMezV91OP0glucCb2cQiLmYwsGXYFBY09NcNJGEeQz4CarIt0PwBrMNBVE+YUEjKq0GlTSepj+5XBsjxmcwalIMZmwdKsq6D72ccvXXW7l8kE23Gf9YvdJpVla5irtWbnyStiwl4yAfv19/7sLg/6l5HN5asl7ojqbJdCcT+CTB/8sZeZBuVzS5BRp8MS7w23cGjdE+zttFkfDR1It1UpjzwCBFA6GmyDTqn4PqReCnMRO+KQ7tV1e+fKhZ3zlpMZHunXBCmCA8TAwterHbUag8gCs2D+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ4P/xmO4mCp3DrNdlVfjpkpt9WYRX8eVDH7rSShXhw=;
 b=U/eOiXNrKLFOJMW6rZsMPTmEYiKhbzLB47CsdqfuY/SqDR4O+W/I+GLE7Qkfm7attDaU29osNfRL79odDrwx83/6gKx5MHAkryZlNFsHjRS93QezUzDqmPheeYQ6wDowkWTSBvpxAeFMb7KVGlz0GBYRc2HqgktKJ3joAGGwJGaotfhyTV1svRdM6qGcjWj7x/COUJpdOTWn0PAjDGchhn106N5DWw62GKYnMMcm75SMlH9lnMxJ22b+t2RyBhnAU4BCoxaUoN/BYw57YAUYcyBFOQ/khV7TxLWtLXhsJU28OvJbStKiI3KExYWA/Ckf8xlmsGYthmMLynmzVnDyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xhdpunnaia40.localdomain; dmarc=none action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ4P/xmO4mCp3DrNdlVfjpkpt9WYRX8eVDH7rSShXhw=;
 b=B3aS5EK4PoMOaE9BuuLfx1YyGe89a89axgaunngYD/Sqcu2PaURw0aXsEDYX0OOqePqokwZKH4Z5gcs5BUr4NNUn+ZD8dlbQRx5BK6Mv/JvnLZBZHMEgDI62ykPQPHeB+NMIdqdiVgeSUyG3MGBoSPTWU0OuzEDIosyB5tMYk84=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by BL0PR02MB4324.namprd02.prod.outlook.com (2603:10b6:208:40::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22; Thu, 30 Jan
 2020 12:54:41 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Thu, 30 Jan 2020 12:54:41 +0000
Authentication-Results: spf=none (sender IP is 149.199.60.83)
 smtp.mailfrom=xhdpunnaia40.localdomain; vger.kernel.org; dkim=none (message
 not signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: None (protection.outlook.com: xhdpunnaia40.localdomain does not
 designate permitted sender hosts)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Thu, 30 Jan 2020 12:54:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9LD-0004Lk-Hv; Thu, 30 Jan 2020 04:54:39 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9L7-0000iq-S3; Thu, 30 Jan 2020 04:54:33 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00UCsWgQ000943;
        Thu, 30 Jan 2020 04:54:32 -0800
Received: from [10.140.184.180] (helo=xhdpunnaia40.localdomain)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9L5-0000hg-TJ; Thu, 30 Jan 2020 04:54:32 -0800
Received: by xhdpunnaia40.localdomain (Postfix, from userid 13245)
        id 1EA58FF8A9; Thu, 30 Jan 2020 18:24:31 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 1/2] dmaengine: xilinx_dma: Extend dma_config structure to store max channel count
Date:   Thu, 30 Jan 2020 18:24:24 +0530
Message-Id: <1580388865-9960-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580388865-9960-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1580388865-9960-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--0.744-7.0-31-1
X-imss-scan-details: No--0.744-7.0-31-1;No--0.744-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(249900001)(199004)(189003)(4326008)(498600001)(5660300002)(2616005)(36756003)(356004)(450100002)(6666004)(26005)(70206006)(42882007)(70586007)(336012)(107886003)(82310400001)(316002)(6266002)(42186006)(2906002)(8676002)(8936002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw01;FPR:;SPF:None;LANG:en;PTR:unknown-60-83.xilinx.com;A:0;MX:0;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd145b4d-b56a-4a68-2092-08d7a583929b
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Antispam-PRVS: <BL0PR02MB432469003120905E820AAE94D5040@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 02981BE340
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydHRuwlGo2ZMO9d+lyCwwzLQJbiJYmcHWGRHW6sIJ+eIkrCsmWA7WXH392eLzIZNVsFAUtuNGtedAP3HLaB1lUmvsX5AiYPk7hUH2JhECE+MnIEV/kisd6CCjPsS8r8nWUQwRwCakokPa6vLAwSNrf/c2KdnFjbaLQh19ohBbdrzcyxagZFHKUt+iWDUlrKipL2zB9EvG7Sm2SEUagoYvXl4L1VQalOadnTX6HaR/NSJUsmeY6II2T9hM0JO45B6gvNEjhHrGZnLEubrJdlk5shhV/snk0lfWgahboT9LNrr2nU2ZJ/01lCQh37Djq06CUi4g3TB57fR+aqU8T5JaGibq+N9CA7loDTaAuOaWgtF/WnTnBZoT5AH11FiCMVAJX1yQVm19FmbZq11shsgMCAx6UTfW6N9UeUWkZ+UJcf5PptJABO7GVcMYvOEzKQU
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 12:54:41.4212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd145b4d-b56a-4a68-2092-08d7a583929b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend dma_config structure to store the max channel count. This input is
used to populate dma device channel nodes at the fixed offset. It serves
as a preparatory patch for removing dma channel DT node order dependency,
added in the subsequent commit.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 6f1539c..2281af3 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -125,7 +125,9 @@
 #define XILINX_VDMA_ENABLE_VERTICAL_FLIP	BIT(0)
 
 /* HW specific definitions */
-#define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x20
+#define XILINX_MCDMA_MAX_CHANS_PER_DEVICE	0x20
+#define XILINX_DMA_MAX_CHANS_PER_DEVICE		0x2
+#define XILINX_CDMA_MAX_CHANS_PER_DEVICE	0x1
 
 #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
 		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
@@ -468,6 +470,7 @@ struct xilinx_dma_config {
 			struct clk **tx_clk, struct clk **txs_clk,
 			struct clk **rx_clk, struct clk **rxs_clk);
 	irqreturn_t (*irq_handler)(int irq, void *data);
+	const int max_channels;
 };
 
 /**
@@ -2939,23 +2942,27 @@ static const struct xilinx_dma_config axidma_config = {
 	.dmatype = XDMA_TYPE_AXIDMA,
 	.clk_init = axidma_clk_init,
 	.irq_handler = xilinx_dma_irq_handler,
+	.max_channels = XILINX_DMA_MAX_CHANS_PER_DEVICE,
 };
 
 static const struct xilinx_dma_config aximcdma_config = {
 	.dmatype = XDMA_TYPE_AXIMCDMA,
 	.clk_init = axidma_clk_init,
 	.irq_handler = xilinx_mcdma_irq_handler,
+	.max_channels = XILINX_MCDMA_MAX_CHANS_PER_DEVICE,
 };
 static const struct xilinx_dma_config axicdma_config = {
 	.dmatype = XDMA_TYPE_CDMA,
 	.clk_init = axicdma_clk_init,
 	.irq_handler = xilinx_dma_irq_handler,
+	.max_channels = XILINX_CDMA_MAX_CHANS_PER_DEVICE,
 };
 
 static const struct xilinx_dma_config axivdma_config = {
 	.dmatype = XDMA_TYPE_VDMA,
 	.clk_init = axivdma_clk_init,
 	.irq_handler = xilinx_dma_irq_handler,
+	.max_channels = XILINX_DMA_MAX_CHANS_PER_DEVICE,
 };
 
 static const struct of_device_id xilinx_dma_of_ids[] = {
-- 
2.7.4

