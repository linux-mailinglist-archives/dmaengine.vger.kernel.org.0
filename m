Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FC520E96
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiEJHiJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 03:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiEJHRB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 03:17:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C12992C1;
        Tue, 10 May 2022 00:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv1u73YkXZCcBcoN6kpODUFjt+8CJwk7RBXSVcmVzmK4gmBCniXFFC24f0hr0sH63bQ6ZXYz/jJFCVJrwDkdnnKcbz9zk8eKan91zir/JqP4IyCVlEBvXEI9LZZn2uEZV/3rfQZRREZmV4XC8RBC8gWP6WJTNxCr6XKlts97+VKXPE/RkLtjsHAp56zrRLtBmIaJzn/Zu7vW3cPm62qa0eChGVtBiMo1Iav4Q8lEe+A1rpPyDwKsAasMPKdNa2m+7SL+lDSVpBEixTWtD+5IjWUt7d227ptB8Cs8bW4UYtgPO9Hdpkt2+THIirzez46Unz7pk4+I9iPmP28/Jk+iEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaQH7QRYWl2wFH8wt8vJHFxGGvL41jH70IW0jz0D7K8=;
 b=IKmv4LZrNIIbB3+kojLMOO3zgVl640IelMVbO1G96obatiTHXFFrbYE2UiDYR3+QWdfxgeys6jryTIQDZPyKwjv8rBMHCVNke9CEL+Eff4s4VVUY37+QZupvfqQof5QKi9LNkXmHWKY7/sQ7KD1EUHAGlw5xOkJ64BPc+oBCvHtRv5zHKxuOCFCmzp6bJb/8XVabri5jNfEBU0xc85EJsRrccEbYkDfOTZKB7CqlieJQg6suk5pqIJyFIjMwIPFqpeV4fqbTfY1olfg1u8cczn9aQfHBRGUENK9gWQbzcys97haC+IeQsIWuaUjwEMOedRmeUW6/jHd72tzoFYknyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaQH7QRYWl2wFH8wt8vJHFxGGvL41jH70IW0jz0D7K8=;
 b=Z4peX8/d+tQrws//vEUXYvA1Q9tgJ8t8OpOh0O2J5ze9j2lzB+QmFOOrERdKQh/EheSMAV0dKTMaqsbvzsVVNZIi3sUqPeL7d2LJEyL6AqdSJywQXSVsqXrIDffILhftNua/7rk9HNG2AdzVue0Cc7x9XiwgT+FxsppLpx5HWe4=
Received: from BN9PR03CA0910.namprd03.prod.outlook.com (2603:10b6:408:107::15)
 by PH7PR02MB9025.namprd02.prod.outlook.com (2603:10b6:510:1f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 07:13:00 +0000
Received: from BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::1d) by BN9PR03CA0910.outlook.office365.com
 (2603:10b6:408:107::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 07:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT033.mail.protection.outlook.com (10.13.3.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 07:13:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 10 May 2022 00:12:58 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 10 May 2022 00:12:58 -0700
Envelope-to: git@xilinx.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.6] (port=41365 helo=xhdvnc106.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1noK3G-000Cbp-Ex; Tue, 10 May 2022 00:12:58 -0700
Received: by xhdvnc106.xilinx.com (Postfix, from userid 13245)
        id 9290F604A0; Tue, 10 May 2022 12:42:44 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 1/3] dmaengine: zynqmp_dma: In struct zynqmp_dma_chan fix desc_size data type
Date:   Tue, 10 May 2022 12:42:40 +0530
Message-ID: <1652166762-18317-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 636ce9bc-52e1-4608-3d9e-08da32548463
X-MS-TrafficTypeDiagnostic: PH7PR02MB9025:EE_
X-Microsoft-Antispam-PRVS: <PH7PR02MB9025153997634EC036F519A6C7C99@PH7PR02MB9025.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZY1egh/UQcz72mYYvNgvJnQIyc/ZYN4kCkiCtwZmmBJaMDrlk6Kxo5Ri6dCmhtQBb7mwAWwkhYtqB1sKcmDEQ7iUPyR9w3W9Kc3ejqoLrgvLyxI/rf0C83toXUAjvtAwM0LOsKDyjY3zj0uNnsiMposTxG1GfjNN9a040Flir1PZgmlFI6ZJeUp4VC4tPZip9qPtIxhlKuDwh9JdqkqZWnv1xVEhA/21GA6ZkPp8ejhEdn0k+V//iI7+NSQUot1EoM8xEWgCWw82gwhYl0OdFOpSImHnMr1kev1qDXcOzVGySEFUxEW6tK/qfY0gk8iN4lLLkigKEGhW7E7SyW38ZtkcsZGsg8jKR9Z4vW3WmLVjAbZ/m2QzLeGhZksUSuCOmSlHXYDRfhG3G88Vb/ZJvWmJVibAwvIEphhmijWvDTDP+Sz/TIRB2nJk69qTmGmNbc6TdCde2Ro2OvlFM0EbO/7niIFyyJvXQ+9Uddkvh7iSan1zfX0dEG28kK4ggBONBbh8E2QwvxnyKibl4y3eS9FtxS/tTJ+kaVr5h9GdAEomJXl3aFwoEvKqyqffUXz+GnaOmbANzVhC266fewAidqlIN/fmfEH2cQq28b1VhDXQ9C25ofloxTBaS8Usfe3jaTozQXqYgdSqjRj1ZVKMr/yRnjeU2IKyj0RG7U2LiriXpGg3yQTckiTAGyuU3eNjCsZ54p6XyHsGN/HPUKKScg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(107886003)(40460700003)(26005)(6266002)(36860700001)(70586007)(54906003)(42186006)(70206006)(8676002)(4326008)(426003)(186003)(47076005)(336012)(36756003)(316002)(6916009)(82310400005)(2906002)(6666004)(7636003)(83380400001)(356005)(508600001)(5660300002)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 07:13:00.4678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636ce9bc-52e1-4608-3d9e-08da32548463
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9025
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In zynqmp_dma_alloc/free_chan_resources functions there is a
potential overflow in the below expressions.

dma_alloc_coherent(chan->dev, (2 * chan->desc_size *
		   ZYNQMP_DMA_NUM_DESCS),
		   &chan->desc_pool_p, GFP_KERNEL);

dma_free_coherent(chan->dev,(2 * ZYNQMP_DMA_DESC_SIZE(chan) *
                 ZYNQMP_DMA_NUM_DESCS),
                chan->desc_pool_v, chan->desc_pool_p);

The arguments desc_size and ZYNQMP_DMA_NUM_DESCS were 32 bit. Though
this overflow condition is not observed but it is a potential problem
in the case of 32-bit multiplication. Hence fix it by changing the
desc_size data type to size_t.

In addition to coverity fix it also reuse ZYNQMP_DMA_DESC_SIZE macro in
dma_alloc_coherent API argument.

Addresses-Coverity: Event overflow_before_widen.
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 7aa63b652027..3ffa7f37c701 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -229,7 +229,7 @@ struct zynqmp_dma_chan {
 	bool is_dmacoherent;
 	struct tasklet_struct tasklet;
 	bool idle;
-	u32 desc_size;
+	size_t desc_size;
 	bool err;
 	u32 bus_width;
 	u32 src_burst_len;
@@ -486,7 +486,8 @@ static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
 	}
 
 	chan->desc_pool_v = dma_alloc_coherent(chan->dev,
-					       (2 * chan->desc_size * ZYNQMP_DMA_NUM_DESCS),
+					       (2 * ZYNQMP_DMA_DESC_SIZE(chan) *
+					       ZYNQMP_DMA_NUM_DESCS),
 					       &chan->desc_pool_p, GFP_KERNEL);
 	if (!chan->desc_pool_v)
 		return -ENOMEM;
-- 
2.25.1

