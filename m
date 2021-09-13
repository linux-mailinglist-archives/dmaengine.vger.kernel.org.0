Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9C408834
	for <lists+dmaengine@lfdr.de>; Mon, 13 Sep 2021 11:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhIMJaI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Sep 2021 05:30:08 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:10695
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238597AbhIMJaH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Sep 2021 05:30:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3ztF4r06FpcC1NzciW6A4LOb+Vut87cNl/QnkSif/OWKDTRLWwEhJLaENOBnvdhnTTX4jIBPbzddZshMffWTrOnMPbng4IXCccG6D1XvgOMu398kRsxWJ2t6dpvmQpazrcaYmoG6FThr67ZpQntEthejPeJL6PLqqarkBskgs9/OwmxvhdSU+914K7I9+xElVhQ4fZYkR0OhprmsK0hSt18a92E3suaynDzToNCJhCsCt/7ILH3z8XWs5D/iHbQj2d92bhEhnpQZ/vRy8pNL9jWvrJIf5DHVMNOpF+Dcz9F41eV0k1kwyo9xF4Ff71QDX9gcoPuOh4JSFgXBatAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4jcC8fPHcVQvkuD9YZaceKZ7A4AVM598nxrITSvidbM=;
 b=jzMh4+kGSFthSyRFRLOl1SnhSXAkPNPbmEhwnafzQ1drknnSIsm/95eRBUVhOd8zgUK3RbZsfK/QdnWgZT6NM0yw/A50P4ypk0VsRh2q2naPPXvHpqZZ/fLRgz8JrAIP88mnJRgAFUb3J1Y2F/BDu/FXfMpdjdN4shcPbel58/tOI1jNhT4xqhW9Jo3CQyf1NQb7RAevGf321Rj3c4x7G1qaSKShHsIlpndYt/X5YmvKxJQn6Aw+pkzFnSnUe8C8pSbvOzQ1YFDIBEnJsLpLmrmQrhdVc8MI+G6cmQ11AWkjQ9ORYV9xA1HuqkOCsRIA02itrWi+4hKzUfXiXK7TlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jcC8fPHcVQvkuD9YZaceKZ7A4AVM598nxrITSvidbM=;
 b=A3+1VHUkIqNm+2Z+NOJ8RPnTFk1ReFdyKKZTS3o0CsIjdwmW4Wz2Qq6lkoJ2Jibhr+dD55FAcoOWbarZ06W/nsTa7GrV3ipMLXCNX8/s3ytQIzbs7TghLUXs2EBmtJRAGTVaoackV622TC3LCACM3bdLTbF8qMl/8pH6DPxToko=
Received: from BN6PR17CA0055.namprd17.prod.outlook.com (2603:10b6:405:75::44)
 by BYAPR02MB5159.namprd02.prod.outlook.com (2603:10b6:a03:6e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Mon, 13 Sep
 2021 09:28:50 +0000
Received: from BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::f1) by BN6PR17CA0055.outlook.office365.com
 (2603:10b6:405:75::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 09:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT007.mail.protection.outlook.com (10.13.3.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 09:28:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 02:28:47 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Sep 2021 02:28:47 -0700
Envelope-to: git@xilinx.com,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.5] (port=56079 helo=xhdvnc105.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1mPiGc-0004K7-C3; Mon, 13 Sep 2021 02:28:46 -0700
Received: by xhdvnc105.xilinx.com (Postfix, from userid 13245)
        id 972DA61058; Mon, 13 Sep 2021 14:58:45 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH] dmaengine: xilinx_dma: Fix kernel-doc warnings
Date:   Mon, 13 Sep 2021 14:58:36 +0530
Message-ID: <1631525316-2323-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa7f7395-fd5a-43c0-a52c-08d97698e50a
X-MS-TrafficTypeDiagnostic: BYAPR02MB5159:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5159639C7EDD3B7BF6DD3671C7D99@BYAPR02MB5159.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C32DU9CrHJROwdhVvTdQVU5HybK+WL1AY2D4UTt0OTA96CiRHZo3DYaXygLynvBijiRjGNoN6cOQt/5TCJdsYkaySyggPJFvBED+hg8n5bXUIVuhVKP2eOa7a3A1787HCX8uJuyGBYZ7zgYS4ZU/yRU9GqSLMrrRnUWkQcpnWBewN0ezWvJGtvwiEb+0LFM02DfYxcQjMByGKL3ikPlV4bOijUl5rIZyVCrns5le545xxxyxku7ZM0x5vM7LVDDG1NxTdLnHdNCrIVsqpjC1lDXzDAwW/JARe7fEY/+kkJjvAvP04M76PniaEBkD11aBTTHkKbytOvzo3oSzSMdbaTiY+w5eSardz0jLN2jYOogdbCUwzPDyyEmwCNIzfMo2fFxMBs0HmO2FvxgRFhUAQ98Bs44ZMgBlx5O3nQajDXVxIwiBi3L37bRuQtVmgGauq62elWqyc5vI5tLRflg+G4OczR1iYG8daPXmCbPhqeeh7lxEBh7NQR30Jvb5sYNcacP7PD89vzt+BkBUMJGdWhIbp9n53cYONF1K/k6spfM8GEMkLy4vnJugQ7Gw21zC+Azo62KNZpU71vLUf3HR1rE+jtQJrMdcK/dyXRENBmNmJfx6ctLX64wojiDnT21BP4U8H0JotL2r6Fxoeq6ojDLvYDb7M5CjHtsbxWZ4HHWTmIM/PwF5xk+CsPmtasb6WpXVshnVuVS9+kpEg/VyrQtFkktzkPXi15mXT2oMW6UgC8NZmmfA3WIKBszasxop
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(36840700001)(46966006)(8676002)(316002)(478600001)(82310400003)(110136005)(82740400003)(336012)(36756003)(186003)(7636003)(4326008)(42186006)(70586007)(70206006)(8936002)(356005)(83380400001)(36860700001)(5660300002)(47076005)(6266002)(107886003)(36906005)(54906003)(2906002)(426003)(6666004)(2616005)(26005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 09:28:49.8103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7f7395-fd5a-43c0-a52c-08d97698e50a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5159
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Modify the prototype from xilinx_dma_tx_descriptor to
xilinx_dma_alloc_tx_descriptor and xilinx_dma_channel_set_config
to xilinx_vdma_channel_set_config in API description to
fix below linux kernel-doc warnings.

drivers/dma/xilinx/xilinx_dma.c:800: warning: expecting
prototype for xilinx_dma_tx_descriptor(). Prototype was
for xilinx_dma_alloc_tx_descriptor() instead.

drivers/dma/xilinx/xilinx_dma.c:2471: warning: expecting
prototype for xilinx_dma_channel_set_config(). Prototype
was for xilinx_vdma_channel_set_config() instead.

Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 75c0b8e904e5..5efaea74e6e3 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -790,7 +790,7 @@ static void xilinx_vdma_free_tx_segment(struct xilinx_dma_chan *chan,
 }
 
 /**
- * xilinx_dma_tx_descriptor - Allocate transaction descriptor
+ * xilinx_dma_alloc_tx_descriptor - Allocate transaction descriptor
  * @chan: Driver specific DMA channel
  *
  * Return: The allocated descriptor on success and NULL on failure.
@@ -2461,7 +2461,7 @@ static void xilinx_dma_synchronize(struct dma_chan *dchan)
 }
 
 /**
- * xilinx_dma_channel_set_config - Configure VDMA channel
+ * xilinx_vdma_channel_set_config - Configure VDMA channel
  * Run-time configuration for Axi VDMA, supports:
  * . halt the channel
  * . configure interrupt coalescing and inter-packet delay threshold
-- 
2.7.4

