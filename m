Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8528C55938E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jun 2022 08:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiFXGgS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jun 2022 02:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXGgR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jun 2022 02:36:17 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D64609E2;
        Thu, 23 Jun 2022 23:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTP9jotI8IaELsYMzOaCcpMEWXyVosf/Xunbl3uIVFaYwYhdQ+Lw5SZkMkgaal9jSJ+CLSzesoyHnB643m3PrGPAgbBC869Upxhv+YHEUFfnkvejkIBZWOzzRVZv/WTixhEKm4QOZSWFnI0QdghFLJgZlYhIgDEx51wHlwBDQQ0IuSVFTn713MhsFC38O42S6YzZBU2iQNbPJ1sB2ZuENdyuNbAcQYnFrb1QzwVtHA6H7fbxk+BGRGmf+NUDlimUxLLVIU0jLaUNOFWWUd3imS/Dws3CFQuWFuKBCmtRQc4k3YQvLhqqdjHLgs+XeLs7yLyC4244D7tzpqEgmwMRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST4U8b9xRnSU8SDgdanvDwT+OTVhfkA+MyD7le8tLvg=;
 b=jW3XEzJigw7Jh+VIIFszCj3P+T+NC0uTfhsnN4wsH6nFm592ItAsiwDDu/u8KjX/ivI5iWUqU1YBoFnDnBFKR3/t2whY0dqQyZKxuPmcuyu3I9HeGMGVYDPfOh16SRRW7F9URvJ+Yv69HCMc/Cf9IhWND65cnSM4/RJ4ptNkodlEPoD/qZ3IHh1Ia+S/RXvN2V/82N+fZyFNdyoncRT1UAyKJ40IAcISRjbVrTeq+ojGfL8RF5T7oeeOiQkyMeXdhrj2fsTUxv6s/w0FYlAREinTsSx8ashSjAcN9N3OBV/IhfHvp6zErq20Hxsq7Q0tcxJVvXebxln+w9WtGETXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST4U8b9xRnSU8SDgdanvDwT+OTVhfkA+MyD7le8tLvg=;
 b=YOWLH4P5PCbEdQQNXi6y26MG02BZFMJuyzotq5tnCoqvkYUk8IB9gGy01tMOCo0a2gZIYfEBl0YY0PHXYdq891g/4F/OanUvJ9AGzTWCnOoFWFbOs+Yz6Q8LgHGnjKtVBdonMwGfMc0qiPXmwKnLvi94eQJOiPuWUkyoaOGuV48=
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by CO6PR02MB8818.namprd02.prod.outlook.com (2603:10b6:303:142::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 06:36:13 +0000
Received: from DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::14) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Fri, 24 Jun 2022 06:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT048.mail.protection.outlook.com (10.13.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 06:36:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Jun 2022 23:36:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Jun 2022 23:36:12 -0700
Envelope-to: vkoul@kernel.org,
 lars@metafoo.de,
 adrianml@alumnos.upm.es,
 libaokun1@huawei.com,
 marex@denx.de,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.78] (port=39188 helo=xhdswatia40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <swati.agarwal@xilinx.com>)
        id 1o4cv0-000FW1-6R; Thu, 23 Jun 2022 23:35:50 -0700
From:   Swati Agarwal <swati.agarwal@xilinx.com>
To:     <vkoul@kernel.org>, <lars@metafoo.de>, <adrianml@alumnos.upm.es>,
        <libaokun1@huawei.com>, <marex@denx.de>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <swati.agarwal@xilinx.com>,
        <harini.katakam@xilinx.com>, <radhey.shyam.pandey@xilinx.com>,
        <michal.simek@xilinx.com>
Subject: [PATCH 2/2] dmaengine: xilinx_dma: Report error in case of dma_set_mask_and_coherent API failure
Date:   Fri, 24 Jun 2022 12:05:39 +0530
Message-ID: <20220624063539.18657-3-swati.agarwal@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220624063539.18657-1-swati.agarwal@xilinx.com>
References: <20220624063539.18657-1-swati.agarwal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ebc1077-8fc3-4382-5529-08da55abd517
X-MS-TrafficTypeDiagnostic: CO6PR02MB8818:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obVQcHGGxlXel4EtEh58m+YhdKQdOGf8DiqEpFpw6K4H15YT0v8T5s54yG8qtiRp58bOSfjIII6CZHy2TihyvVMc4pKmAxuLChoz67xNtDZumnOtXImrLxFxO/wBld8OjHw6t1pOzwSgQsWsYdvRAr9UeLNGyZc564PhyzRS9BZNVQAcqZxwXjm3HR2z/fQEYSFKtfem2OYjxCK0rFSbvzVEmAe7Iwi4Vra9+yI2xeR7OQRLGURd+PZTxScalVE0DzqJh0RrUxu0ywPwdOVC4yO++2tL5mM4mG1iA9jBhyVjbum0vu6HEDSMZ7V9CN1YSErhWREUd+1Uu92vtrjZbK9aHiq7dWkGXwX26gnU5tic1G22B3u4hdoh0FxlZzoaMvU5NCj+XZBccOFDFxZee6GW7jCS9yt/6N4CRyU1lIglkj4sUV8zoHoOmFJsDFHjBakiXrU+tU/liQWyuJODwdTRJfvmJVuqL7PnJWhYtGsRe2thAiST5QxTeotOJHW2/Ola5BVXHOCBZMoUbhwzYEa1WcNIx0RrzuUgOfR6ziepRRZHIFbMYqgdAhBm/cQxxabT0WYKvtf2AE2jPBrRQxwsPNz+9HSIhIcYSvWjbBFzdrBhV7897GATWk/7Kb07wx9b7qaU2onr0ckyKKnREKwlXYZoZGzg5yT4kKlHFQU2MKgLpfdY3jXzBSUBlCVXX+j1FSe2ww0HTrUf5n2s5YhRNtk5HwEbctpm8fn82MFo4nair1W8J37sI+Ywm7ef4PibMQES0GnfMEIu3CN2R51ArhU/HVfGlXyi3+OwBzZ3E0zYVCKKwJXyDOZSlpQzcX6FwTLFdE0DBDXby6s92A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(47076005)(356005)(44832011)(186003)(83380400001)(107886003)(8936002)(426003)(36756003)(316002)(1076003)(336012)(54906003)(4326008)(2906002)(5660300002)(9786002)(40480700001)(8676002)(7696005)(41300700001)(6666004)(70206006)(40460700003)(36860700001)(82740400003)(110136005)(478600001)(70586007)(82310400005)(2616005)(26005)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 06:36:12.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebc1077-8fc3-4382-5529-08da55abd517
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8818
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver does not handle the failure case while calling
dma_set_mask_and_coherent API.

In case of failure, capture the return value of API and then report an
error.

Addresses-coverity: Unchecked return value (CHECKED_RETURN)

Signed-off-by: Swati Agarwal <swati.agarwal@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index fbf341e8c36f..194513eca7a2 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3212,7 +3212,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		xdev->ext_addr = false;
 
 	/* Set the dma mask bits */
-	dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
+	err = dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
+	if (err < 0) {
+		dev_err(xdev->dev, "DMA mask error %d\n", err);
+		goto disable_clks;
+	}
 
 	/* Initialize the DMA engine */
 	xdev->common.dev = &pdev->dev;
-- 
2.17.1

