Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A378340A92D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhINIaH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Sep 2021 04:30:07 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:10304
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230165AbhINI3r (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Sep 2021 04:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnbe4itU6FvQ4npjY9esSfF7u+sfp1rFrAYgumSYEXU/AnvtHlth9zGR4zq6cz0JLnKJS1r4XAVcA2pf2K4dqpsmrXj27O2IRO73SflrguviqVVp4x7MpMk4U90GHxBXYa0L4IN+86bKoCDndQ+PRRYkYpcoFjdM89hFJSSzQt9UNJCgxAFP0qm0yMK52jwOuklJt5gEDZcikwtaZgYLqzF5PcoxZ5Mfuv3mT1dJk5aYO0bTdlfp2CC7t3ipePZSn17/8ZQyd4xkVdW5hEVVmjlGEwso6YYBvsKfCggrcFAmKVoajSgVRR+nf+vwuNnrfEPTq5H9V7GnoGUyUDbNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aCTGRg/I5ahensrOBg0zP3XYp5MeFE2Nvf/XlLN/z98=;
 b=n3GohO9Az1x9IIFRwlWADHcGYFXEM0+ESMdzQArC64SdKMJmMOQsC944S3JmchzkWOTBd6nznYa9II/FggB7iCM9srU5TaFf0bM0AnNExyzLgd8uFSMxHkleD6hvVnistSada6NpPe0K17UOxAOBevXF93u8lq8J/i08YcbFmu5flyn6ty9sc6f4Jjv1q1OCr2JMp4DQpauypLUj9iMqPTIapQkEV+7e6dB2WjX/nHjqXjhxmgssLrT63hIoHS5z8VgEEcGdB4z09s6FgLY304SInlAXTEoyGJA2Vy5FmcRBNU9/lko6AmA/+lCTCG6rB2qvVy7DDnHfLI3sg4ftTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCTGRg/I5ahensrOBg0zP3XYp5MeFE2Nvf/XlLN/z98=;
 b=YRAjzkPv2sGxkn6P509xD7wDuwPfOZwCTLkAjRzyRqEYS3Tt+1eyG93L0HOPuGr0XztrXm8t0Td4pWzov7hO5OON6sSBLcX1X9FUua+NpxTKRu0ZAm25oyuuVYYbAbTzeoE2Sz4nJNPcKpv0DyEsxKZE6/XdwtgqhHMhMSw3T9c=
Received: from SN1PR12CA0111.namprd12.prod.outlook.com (2603:10b6:802:21::46)
 by DM5PR02MB2746.namprd02.prod.outlook.com (2603:10b6:3:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 08:28:29 +0000
Received: from SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:21:cafe::31) by SN1PR12CA0111.outlook.office365.com
 (2603:10b6:802:21::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 08:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0030.mail.protection.outlook.com (10.97.5.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 08:28:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 01:28:28 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 14 Sep 2021 01:28:28 -0700
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
        id 1mQ3nn-00094b-S1; Tue, 14 Sep 2021 01:28:28 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <vkoul@kernel.org>, <romain.perier@gmail.com>,
        <allen.lkml@gmail.com>, <yukuai3@huawei.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <harini.katakam@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <shravya.kumbham@xilinx.com>
Subject: [PATCH 2/4] dmaengine: zynqmp_dma: Typecast the variable with dma_addr_t to handle overflow
Date:   Tue, 14 Sep 2021 13:58:15 +0530
Message-ID: <20210914082817.22311-3-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914082817.22311-1-harini.katakam@xilinx.com>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4bff6dd-e1ef-44d3-b855-08d97759a12b
X-MS-TrafficTypeDiagnostic: DM5PR02MB2746:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2746D028A05B66D600D7542EC9DA9@DM5PR02MB2746.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqWPNGAgRyAj+CvWjYIvd4CWJDqjocf2iw1ZGo//VLYsBpgjI/dynUD073AM5DTZKUfnkrcfiohcLy/waWUcYgnArmyzII/ZClzyRURLrodwhjQOFVhXfI5OA29smBYKRJ2ZVaGfHmg6NeLB4ks0cjfVy5aBLquFSRHlAjFIyMIbXjh/DNf79tbLaWGmEB6coJXO0Ux8t/K9VlgGeKdAoEvHCEyY5dEak5+HBQCzKyyPh3KmCCxPyQ7OIsOvSe+EUPGQk87lkVcKp9umYorHyNAi/j7vFRlKrdo6kAmm3rKpzaonj97qcA+3RdFvWAZf017J7YfNp2gJHr7ByY8iC0Sd0mRc4cGLZUYCkqTWn115kX+4thgWvz0VdP15T2Rfb1Nmqmjk+mHT/l4ubxVkmagP24MfFhLYfIZhMKj8vFaT0SDQ2zoOZzmWYHwtZHpDqVKQYJU0r5AIzCWzqy1CEU5qsG5menyZQACm4CYlXT7h8uWg9eBHF3RaR9NHjcJ/Yu1w8CVd9wlhyqJnRTrmvqCCB9cLLj2y6T+5TStxRkHuMFgAx+Cma9Z9/q3gMRxCoIzh4LCaW+BYF+oe0bJCYKyofbxYgen1QbWIAJIpNDxZ+JK5jvdGtWLg9iyWwKAt1x/fuHfBYlOVugHMuJuPrZ4BICnMIyfps9ScaY363Kj6CjAbLQutqRVPGT+pJSmQlvK3Nn5YPlxoKy7/KruYWfXRt1329WoHrQPd7jgs16U=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(478600001)(8936002)(186003)(2616005)(26005)(83380400001)(336012)(44832011)(8676002)(7696005)(82310400003)(5660300002)(36906005)(9786002)(426003)(110136005)(54906003)(356005)(47076005)(36756003)(1076003)(107886003)(2906002)(4326008)(7636003)(82740400003)(70206006)(70586007)(6666004)(36860700001)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 08:28:28.8627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bff6dd-e1ef-44d3-b855-08d97759a12b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2746
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

In zynqmp_dma_alloc_chan_resources function there is a potential
overflow in the below expression.

desc->src_p = chan->desc_pool_p + (i * ZYNQMP_DMA_DESC_SIZE(chan*2);

The macro ZYNQMP_DMA_DESC_SIZE and variable i are 32-bit. Though
this overflow condition is not observed but it is a potential problem
in the case of 32-bit multiplication. Hence fix it by using typecast.

Addresses-Coverity: Event overflow_before_widen.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 2d0eba25739d..d28b9ffb4309 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -502,7 +502,8 @@ static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
 					(i * ZYNQMP_DMA_DESC_SIZE(chan) * 2));
 		desc->dst_v = (struct zynqmp_dma_desc_ll *) (desc->src_v + 1);
 		desc->src_p = chan->desc_pool_p +
-				(i * ZYNQMP_DMA_DESC_SIZE(chan) * 2);
+				((dma_addr_t)i * ZYNQMP_DMA_DESC_SIZE(chan)
+				 * 2);
 		desc->dst_p = desc->src_p + ZYNQMP_DMA_DESC_SIZE(chan);
 	}
 
-- 
2.17.1

