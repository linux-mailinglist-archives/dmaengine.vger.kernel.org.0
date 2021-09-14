Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9718F40A92B
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhINI3x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Sep 2021 04:29:53 -0400
Received: from mail-dm6nam08on2057.outbound.protection.outlook.com ([40.107.102.57]:11744
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230072AbhINI3q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Sep 2021 04:29:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/hktOTU+EQ0POxr36hwbXRME32w09aEJDvcUMY85kV1REKb8121uhbLqnddv3M1lUPU+LkUPqki2kiGXhEzYwT8E4hP/RDdYi7ttpnsEbp5voNnzNsbarukLBHwjV6MuvTaz5qwAY7vMayySRo6CmK5/QSek1M4wMdoBiH/7CHaWzowIZCVmLOS43gHjGOjdpB5ruUzGENzGzRgevxCcQ05pjghQshpBFKv5LY6S7bZPXOW2GeDYLa/flCQvEDF7UpA5THSvz79zemvwJct5IarDD0jp+h8MsBI3P3RDA6BzM+bIzjlaFVHDgsqhvtAs37hglpMRk0uD7/Q2A94FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rTVl+iqbrrMSgEzQGPiHm66OekzzwfwmiPD4MHxj/Lc=;
 b=CPH2QEQETuhaFF6CcaccMBN388N1Bbp+hQaTV2CmysTQCtGgE4tAlel+Nm38SLjTrHyIIEenWc3wqgpOXbEXQbFkOwRtyg4uRBoadlF4263+1xMyO2TOs1qf0m1/JoApdTKhg9BXslk2sAWWaXsPSlUvjzV9S8foTNteMvhPBtjjJAuzOlX/O39UJqyH4dKOJe4sUptLKon3BZnXhcTZ8IipkCWIWSYMiBUrI1tfL742qptz4qaHSciMXLUazIHtg1xgqIHlJ5RmsLLaeioaRnpj2LcXsaRh4+uOaBq6haLTs4SLTsp/eYVb4GczGwVqfGKupKSKJYAarNCxPe/heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTVl+iqbrrMSgEzQGPiHm66OekzzwfwmiPD4MHxj/Lc=;
 b=RZ3G6lK2aElMAXfMv3NPNsBadcqGVsmQ3L2WGWJJxCjoMUQR7+rZ0VAvaGnOYxv8V2I9ALcODNXew4Dtru8k1ZTJK/6IvBGfMgTKHskRGHVYSZR9TH9s6M7EWKiR4D+GWEXdk1kho58rTMFcn2hxEx5PutwMypRoIBBRK44aoyY=
Received: from SA0PR11CA0110.namprd11.prod.outlook.com (2603:10b6:806:d1::25)
 by DM5PR02MB2698.namprd02.prod.outlook.com (2603:10b6:3:10e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 08:28:27 +0000
Received: from SN1NAM02FT0008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::27) by SA0PR11CA0110.outlook.office365.com
 (2603:10b6:806:d1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 08:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0008.mail.protection.outlook.com (10.97.5.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 08:28:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 01:28:24 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 14 Sep 2021 01:28:24 -0700
Envelope-to: vkoul@kernel.org,
 romain.perier@gmail.com,
 allen.lkml@gmail.com,
 yukuai3@huawei.com,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com
Received: from [10.140.6.13] (port=35510 helo=xhdharinik40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1mQ3nk-00094b-Fs; Tue, 14 Sep 2021 01:28:24 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <vkoul@kernel.org>, <romain.perier@gmail.com>,
        <allen.lkml@gmail.com>, <yukuai3@huawei.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <harini.katakam@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <shravya.kumbham@xilinx.com>
Subject: [PATCH 1/4] dmaengine: zynqmp_dma: Typecast the variable to handle overflow
Date:   Tue, 14 Sep 2021 13:58:14 +0530
Message-ID: <20210914082817.22311-2-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914082817.22311-1-harini.katakam@xilinx.com>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b9f8617-cc8d-46fa-ddf2-08d977599fd0
X-MS-TrafficTypeDiagnostic: DM5PR02MB2698:
X-Microsoft-Antispam-PRVS: <DM5PR02MB26985C9AF5308BCF25E83A8FC9DA9@DM5PR02MB2698.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLFltj2cplKIQ25Z0t6GuNO7hkhBK99GUsAF0oiSld8F8IgXaZV4osxtiZ4VHhkUfjvjzc4+NEODxGnW0e9cTz/T5mRKvmkWGkLpg+gPPFbJ9S8mriJ0XFWqaWSW8RYjATm8UWezBAcgVXiq0r3cWiAurq51723JeyKT/T+Lha/w5zwibM6AOggviZUzdgICg0XAcNJYcWdbCQhBwsE0TvBXehCbTaM10VEJQ28stMgfEhOq9oFzWXfmJUkW2+dXNKjZEY4esa1obQc19aAjR7QlhyX99282fRG2YpxISnJ9pqEq6guSFW5Owz3Eryal1MLzuj+/FKTD/s64NmuyD9bz3eZ/7dycn1eQ/O921IEaKZxzAzjm65HpGTUUMn8MUSkGQIY4t4fPGUGolBuSNog8mDBWP7yq5Ybb/76+XklOs2hBgSzbGxjvb3TSm7qUqOxzIg1h2ClCp0J5PCTH1Z24e+pvZZjd7orRfoS+MPOd4MTkR0DX3f8zwtZiZyYnOD8dkO634hnECnPsYSZ3Vu7iKmdBhFnq1WWbFjeLOXc/unshw9zb2KwhFsvLPwMVTrQVKoGTCzkvA90dMm+tajfpBIRKjTvtCmZz91BleUwhfY0hMqVlq7g5lnZDZOWLkmrw1uRz28T6XNHona7pZeVKZ/zLitI0B4F+ONBTp4hjcG6+KoNj7BeTXAGA8MU0j3TBtfvWyuy5km1x9LOtoCfXzW5hxrU+qoDwdnjjy5o=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36840700001)(46966006)(7636003)(26005)(186003)(36906005)(8676002)(356005)(107886003)(82310400003)(110136005)(8936002)(70586007)(316002)(82740400003)(2616005)(36860700001)(44832011)(4326008)(7696005)(47076005)(54906003)(70206006)(36756003)(1076003)(2906002)(9786002)(83380400001)(5660300002)(336012)(426003)(478600001)(6666004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 08:28:26.5886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9f8617-cc8d-46fa-ddf2-08d977599fd0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2698
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

In zynqmp_dma_alloc/free_chan_resources functions there is a
potential overflow in the below expressions.

dma_alloc_coherent(chan->dev, (2 * chan->desc_size *
		   ZYNQMP_DMA_NUM_DESCS),
		   &chan->desc_pool_p, GFP_KERNEL);

dma_free_coherent(chan->dev,(2 * ZYNQMP_DMA_DESC_SIZE(chan) *
                 ZYNQMP_DMA_NUM_DESCS),
                chan->desc_pool_v, chan->desc_pool_p);

The arguments desc_size and ZYNQMP_DMA_NUM_DESCS are 32 bit. Though
this overflow condition is not observed but it is a potential problem
in the case of 32-bit multiplication. Hence fix it by using typecast.

Addresses-Coverity: Event overflow_before_widen.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 5fecf5aa6e85..2d0eba25739d 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -490,7 +490,8 @@ static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
 	}
 
 	chan->desc_pool_v = dma_alloc_coherent(chan->dev,
-					       (2 * chan->desc_size * ZYNQMP_DMA_NUM_DESCS),
+					       ((size_t)(2 * chan->desc_size) *
+						ZYNQMP_DMA_NUM_DESCS),
 					       &chan->desc_pool_p, GFP_KERNEL);
 	if (!chan->desc_pool_v)
 		return -ENOMEM;
@@ -677,7 +678,8 @@ static void zynqmp_dma_free_chan_resources(struct dma_chan *dchan)
 	zynqmp_dma_free_descriptors(chan);
 	spin_unlock_irqrestore(&chan->lock, irqflags);
 	dma_free_coherent(chan->dev,
-		(2 * ZYNQMP_DMA_DESC_SIZE(chan) * ZYNQMP_DMA_NUM_DESCS),
+		((size_t)(2 * ZYNQMP_DMA_DESC_SIZE(chan)) *
+		 ZYNQMP_DMA_NUM_DESCS),
 		chan->desc_pool_v, chan->desc_pool_p);
 	kfree(chan->sw_desc_pool);
 	pm_runtime_mark_last_busy(chan->dev);
-- 
2.17.1

