Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8AD1BF018
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfIZKvU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 06:51:20 -0400
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:59726
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfIZKvT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 06:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbrCQVgb0EIdKFLnsqYm7NtH5vm1QEiabD+dyCtE2/DGdzOTAzhxSv2k9kG/cXAjmYGJYfGJNLsUOLAc/CHxVgEWb1/rSJr/ctTkQdnEeqPHiU/lVj5fDygIoKhaZv/cvrspYc3SBEQtx+qIMWAZgvqLDtTKdF6izg17Qs9vwNiniJMMH1ZRZuCPx22hynUaA4UAqxV/Hw3hRqU5LXEa86nysXtPosCBTz4AwcqTyh19dnzqAKBmmJXP0n5DBlP2st247fLgBnPumYiR0IVdSa5G0j1irJZHXUf7YUBKKZMWhZkWFeihcdjz6UckL4RID6nr2Jtx19DeejfK+Ip2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMfrbu6S8K955U5DEjMZ+MnaMLfH2CSFw21huab/AQM=;
 b=iHgdtljzzX9zSm1HYGVduOV5oYqU6x7P74GjiZ8x7P9ToaAJelK+sIL+lQlr05mNn78+jn/whDr1pn3xzv6rrAbdplNIbGWATO1BCoEewG3udIgYHhBzOHfXZubcWQrfvSikME8WX/944mRlHYaG5FaTTx6zpsI778A4Tz4VKOmr7is8fNeROSw/KTZ9FsT4wZToJ3T5TUZvEa93Dtn6rHyTdo3xRE+j+muMfs8TkyXUp6noix7oo1KwLcqsugTdlBv8r5dePgCyh9izZcu2V2EDKylzBt+lbR6Gr6gjLc+1nVmEGBwcyDEpSUS5dTZS7ZiMtAbHYFB2DGARp4Us9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMfrbu6S8K955U5DEjMZ+MnaMLfH2CSFw21huab/AQM=;
 b=bg2DjcEILZeiSn0myAmJVBJrOF0onVb8ADCj8nkTSk414bKNzvfoOS2C4R3MPED+4/ng5gvbSO9y5LJmrXx1Y14jefjC7OSVAWR9LQ6Ttk9Q3o2KTsdZIkyQAo6rRGni5b+eprHcPUPRgca823kwJyVRi+KiQq40/YFd97A9rlE=
Received: from MWHPR02CA0050.namprd02.prod.outlook.com (2603:10b6:301:60::39)
 by SN6PR02MB5328.namprd02.prod.outlook.com (2603:10b6:805:71::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 10:51:17 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR02CA0050.outlook.office365.com
 (2603:10b6:301:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.23 via Frontend
 Transport; Thu, 26 Sep 2019 10:51:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 26 Sep 2019 10:51:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMh-0003yL-E1; Thu, 26 Sep 2019 03:51:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMc-0001k4-9I; Thu, 26 Sep 2019 03:51:10 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8QAp9CR032133;
        Thu, 26 Sep 2019 03:51:09 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iDRMa-0001jU-UZ; Thu, 26 Sep 2019 03:51:09 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 288DA101104; Thu, 26 Sep 2019 16:21:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 1/4] dmaengine: xilinx_dma: Fix 64-bit simple AXIDMA transfer
Date:   Thu, 26 Sep 2019 16:20:57 +0530
Message-Id: <1569495060-18117-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.069-7.0-31-1
X-imss-scan-details: No--3.069-7.0-31-1;No--3.069-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(4744005)(426003)(446003)(305945005)(50226002)(48376002)(50466002)(2906002)(478600001)(70206006)(70586007)(5660300002)(36756003)(6666004)(356004)(76176011)(51416003)(126002)(107886003)(81166006)(8676002)(8936002)(2616005)(103686004)(4326008)(486006)(6266002)(11346002)(81156014)(186003)(42186006)(336012)(106002)(26005)(47776003)(16586007)(476003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5328;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f3b5387-4367-4d5e-d039-08d7426f74a1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN6PR02MB5328;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5328:
X-Microsoft-Antispam-PRVS: <SN6PR02MB53284EEE6BFEEC057C44556BC7860@SN6PR02MB5328.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: K5Jd3rIRSs1/2LegWPwEi/OCKdhV7CGtJIm04gAbT/XJatSh8oW64ym5KSM/JLsH7Ge9wTNFzTcUywFInw6gLOd12QOuwkhIPY6kruaFEOrSCtA0YBH8+6XAGEqliLa7tworQI+/jxJckPGjZpIaDwwuvuCduCHDS9NNTa8xnIqFtZrCu/Gx39XX/wb5OfjRK1jKgQj9RKKrQGrxXydifRF0wTZ0lkiVGRaIpUYfNDB8nanOrX/Kv4XqBoh4o2Ti1eihIypkAWIWKIbuL7yiQ5eH3AGx0PrJBZztmIz2Xm4z3QH/q7bwXdAqRC4dg1qmNmndzhMag2bvEPc4VZFAr3jbOrDIzBIDtzj/Ka/QTxkQn6cfKBp1abYzUORmXEpGlusqhYEjMnRyGvTcGYzmoP8EYKCSKjaQQ7T3mJfeW2k=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:51:16.0047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3b5387-4367-4d5e-d039-08d7426f74a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5328
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In AXI DMA simple mode also pass MSB bits of source and destination
address to xilinx_write function. It fixes simple AXI DMA operation
mode using 64-bit addressing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index e7dc3c4..1fbe025 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1354,7 +1354,8 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 					   node);
 		hw = &segment->hw;
 
-		xilinx_write(chan, XILINX_DMA_REG_SRCDSTADDR, hw->buf_addr);
+		xilinx_write(chan, XILINX_DMA_REG_SRCDSTADDR,
+			     xilinx_prep_dma_addr_t(hw->buf_addr));
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-- 
1.7.1

