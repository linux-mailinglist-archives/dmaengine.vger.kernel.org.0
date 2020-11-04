Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A032A5E73
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 08:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKDHAt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Nov 2020 02:00:49 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:32256
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgKDHAt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Nov 2020 02:00:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRfTSaYyW9cBePZ1kzE1luQ0P2jz4UAQqYuIAcyhOkL+QeHwiRmmX3foEZ1SHfHcZDCz1hlZhpcSAmN3vNAsyADI/8S8bzw19H25TSecsPwPDJX904c9HO9FCK0XGemoZvernEkYbbKNJiBog8ub09fl3do+YRt2is8LznSIdeQN8OdwKYRolBKgMtm5VkgnzLrPf5cLDcO0sh9NNRPvYHe0WRuhhqtip+MfDaOjA3K1T9jxrl2ft+sJuZ77Vtce4VfsiuTwbs01AeXS/JfIz6sDIKDZA4dQguWd+sSP0LKxIZBH7hy55knN2AkHnM/nMGsi7qUqTcDKTnuE4RKrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00JM8V3kiWIIrd71GxF57rlvEAMKri8qO6fssjtEQCM=;
 b=A7ZXVqlIhNeyIxgzj74HnysyvTFMjIq2aciFlMz27U7tYQnsSkc/4V4MqrRVofGV0GyYCf7Au9EwmiHU2xTKE37LU4SWHdL3ZAvWNVJP9cyoxEpoHktWsY9lXTmBGyZXfl4yGnnxuYa+cOmBLwXGvpJYzky1sYpxBtjKj43IcuMW8+zgtH90ZmfnLc4iE2G8jb8+1I/iMc+mk+lBrLOquHhABn8s53gZ2A6F+s3yXqt+M/Nlc4cl05YpkF0bdVux/LwtmCvaKOL+YKI4uxtrra/NnEPANb+LJNHZ1dhsVMGrvv/3z92Hp/mJs2uETAmGoUF1KHTd8AhpI/wlDiIaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amotus.ca smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00JM8V3kiWIIrd71GxF57rlvEAMKri8qO6fssjtEQCM=;
 b=IVjcLgXGk1zb+KKgLgbUHKJey4AUbhJpS9bVifr+9Qmptq75iJsjBW3r2Jd56a3WOaVfFErB7iuUBPQYZ+31XMHp77IZkvHAnMwyQDv3GrVZpfR7a4mJFXE/Hgb84qDKaO4AkVUBD0oeb1oJj2xuYx84LfvQk4iICbisE3E/8qY=
Received: from CY4PR1201CA0006.namprd12.prod.outlook.com
 (2603:10b6:910:16::16) by DM6PR02MB4777.namprd02.prod.outlook.com
 (2603:10b6:5:17::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 07:00:45 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:16:cafe::33) by CY4PR1201CA0006.outlook.office365.com
 (2603:10b6:910:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 4 Nov 2020 07:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; amotus.ca; dkim=none (message not signed)
 header.d=none;amotus.ca; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.15 via Frontend Transport; Wed, 4 Nov 2020 07:00:44 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 3 Nov 2020 23:00:23 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 3 Nov 2020 23:00:23 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 ferlandm@amotus.ca,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=53830 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kaCmM-0005cN-3d; Tue, 03 Nov 2020 23:00:22 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 16EA412137D; Wed,  4 Nov 2020 12:30:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Marc Ferland <ferlandm@amotus.ca>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 1/3] dmaengine: xilinx_dma: use readl_poll_timeout_atomic variant
Date:   Wed, 4 Nov 2020 12:30:04 +0530
Message-ID: <1604473206-32573-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1604473206-32573-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1604473206-32573-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9fd683f-46ca-442d-d0db-08d8808f59ee
X-MS-TrafficTypeDiagnostic: DM6PR02MB4777:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4777F0A22A436F6FCA5C4CACC7EF0@DM6PR02MB4777.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCd8APpEu3uiG/KX8SNjQ6WGR0wbdZ0K65+aMvt+q+xSgcArl4ylZLWjRiwZwcdrlnHIgqGJgayx20hFEybnD4leY/a4zNEVgKcM4gKh6RjAg1lvwOvrNeButHwOiR1pnrwobl9jAQYMkulhKu7RLkWY7tuGlvusqwJIqdR2m4SP+w7/n0f5VepZpoTIFhF3Nw32WW1QiAeNEa816lzXrvXZ+nrdePJwjSBQ+htySaMuvNkpvXRnZrcSQ7uPtMCCByX3NlZwilnQzUGV1sa5UkcvwaWuyyVWGOYXQUb1ousJhN3+/CMj904o3TP/Bv1BvfDVrBRPZYFKNmAFjetmS5vc47Ff2EjMW2zWxNF4AyyrbKbH3s/35NIVccAUo0RvI83z51lk0qIfiSlTDNyBDIn6ooD/NzimpNRgkFKj08yo0Obr6OoTBefPDz54ngIM
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(346002)(136003)(46966005)(26005)(83380400001)(82740400003)(70206006)(47076004)(4326008)(6666004)(36906005)(336012)(426003)(186003)(36756003)(2616005)(70586007)(8676002)(5660300002)(54906003)(7636003)(107886003)(8936002)(356005)(110136005)(42186006)(316002)(2906002)(82310400003)(478600001)(6266002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 07:00:44.9787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fd683f-46ca-442d-d0db-08d8808f59ee
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4777
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Marc Ferland <ferlandm@amotus.ca>

The xilinx_dma_poll_timeout macro is sometimes called while holding a
spinlock (see xilinx_dma_issue_pending() for an example) this means we
shouldn't sleep when polling the dma channel registers. To address it
in xilinx poll timeout macro use readl_poll_timeout_atomic instead of
readl_poll_timeout variant.

Signed-off-by: Marc Ferland <ferlandm@amotus.ca>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5429497d3560..9c747b08bb0f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -517,8 +517,8 @@ struct xilinx_dma_device {
 #define to_dma_tx_descriptor(tx) \
 	container_of(tx, struct xilinx_dma_tx_descriptor, async_tx)
 #define xilinx_dma_poll_timeout(chan, reg, val, cond, delay_us, timeout_us) \
-	readl_poll_timeout(chan->xdev->regs + chan->ctrl_offset + reg, val, \
-			   cond, delay_us, timeout_us)
+	readl_poll_timeout_atomic(chan->xdev->regs + chan->ctrl_offset + reg, \
+				  val, cond, delay_us, timeout_us)
 
 /* IO accessors */
 static inline u32 dma_read(struct xilinx_dma_chan *chan, u32 reg)
-- 
2.7.4

