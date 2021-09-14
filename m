Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6640A929
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhINI3l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Sep 2021 04:29:41 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:25984
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229829AbhINI3k (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Sep 2021 04:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBPiGhvhhffMLRurMvl4jpqYME57SvJEeudXRDGty0crzMVRI6XCIEfsiIqeBwLbtYs5tEX656vy/Q2sAxVhT9VaplXRM+llSO3vQkzPlU8n3jWQdXUQcL2/hSCv84+7YA+2l1ZHwtA93JSBBRjKvo/avd/nyeOHEB8rwEXapszSBp33E+Uuw48hZ8H99OSjBozbMZ/bRZCrg0w/zITT2K9XHPPKQtYy8GhpJYpUfwW8WBid+tdM4M8X3oFF7OGSTligoSC87qNK6blOmhL7NPQa+HuZMr/+S+jbaxKBSKB/3HFQzMmgpT3O89TkqUrMzw6d2Cr7Yvl5zgDHmI2Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+pr/LF66+wyHrDlhmER87h+gocC4LDyfpLZYX47nfBw=;
 b=DJaYyQ8fZJuMTtpVHz45IQApWmAV/GUU0WhydDVY45WSpmXw0cw0WwwbL/+AuqaK/x1c1mtBdEo7AC10nBHyZlXdYdXiWsLtajG4kK3nEsqD6PqhtmR73suFrM6AUOT81zJDr7MFBEd/BbfCljBgMNrskh9M8ZtujHtjD7P6bgHvhY33+CdxxRxSEbzGoLwpPdu5Y+P88dhypeD+DX3VkBTL1n8N5UPsxqeLMSCXTCgAx5kY2+a3hvYOzVuFbKyEpa6+mkIDvZmuK2UoN3nBKmuTCdC9ZBNA8jovGIuFZQUtXbsxrRRgtKyIs+vLAB1zvtvTqAWNO2eN5PooFXCuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pr/LF66+wyHrDlhmER87h+gocC4LDyfpLZYX47nfBw=;
 b=qxyXGFpPWLzxIDGF2GbRK9PYRBWDjyQos3FeZmtbN71tsAyiLcAbg83dE/78uTU9hGeEPuaOx0afcyaLm874WBTSxSxh6RS6xurXvc0CX1z0RDHPV0LYmUEIBx2LldbJF1R/3ifuU7It8hQly83BPDs8pSpprHUBc0mJ8r9Jh3M=
Received: from SA9PR13CA0080.namprd13.prod.outlook.com (2603:10b6:806:23::25)
 by DM6PR02MB6633.namprd02.prod.outlook.com (2603:10b6:5:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 08:28:22 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::bc) by SA9PR13CA0080.outlook.office365.com
 (2603:10b6:806:23::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend
 Transport; Tue, 14 Sep 2021 08:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 08:28:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 01:28:21 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 14 Sep 2021 01:28:21 -0700
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
        id 1mQ3nh-00094b-3h; Tue, 14 Sep 2021 01:28:21 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <vkoul@kernel.org>, <romain.perier@gmail.com>,
        <allen.lkml@gmail.com>, <yukuai3@huawei.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <harini.katakam@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <shravya.kumbham@xilinx.com>
Subject: [PATCH 0/4] ZynqMP DMA fixes
Date:   Tue, 14 Sep 2021 13:58:13 +0530
Message-ID: <20210914082817.22311-1-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fde4a64-6c4b-47b6-e00e-08d977599d41
X-MS-TrafficTypeDiagnostic: DM6PR02MB6633:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6633C13C3EE14669275B327DC9DA9@DM6PR02MB6633.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSMurGS3dw1ycDVtDlf5zApqm4BXS67xQDhi6+NJIuqqWvwp21mGFlr//+MZ5nZVtvAgdPJ1IOM9o9Y0Ga5DcCqQ3j/bP8GQvF1bhg/VHTknz7eIHZ38LL3Tr86FNoTj7RHypyl/bDUsCPvR1dON9dNgku1x756x+qzZl/c2LvTbEgvQv2La9++7ipHfIwnieUCJML0d4cJSf4nj0c1SAZxaM2q2ycg/mBl3YWhGFVhx81/JXJB7KOdqr4h4joabX7hipU3JzNQPYBTJ7rEnIXaGGuWMXAWzf2xoZinvmH0f1yyVONiBmYCTB0+dGzwk2wlI455TA47qz4U0m6d//bSzu1HSF9HeKT2uOZnQFEL+BXgcqLWFFLcZ4RCVtqyx1EqqLCizccM09axYXI1NiA5fZg4biN44vJtK/dUtc8zy0AIRb3WI/U5maF8nIT/m8GCOcVqc1Oocov2eGTZjGIo9R/Y2p0718rDf/uNdVuQV/0FdyGSJkMvzxdS998TgoLjUj53APvhc6fb6urk5Uh5hRd7A+HgSH7yEED3OeFe37Qa4E5uPaHbczNc4MVoq5TjnHCCcTDWEI/0ihpaIZ96Q1sKXNYg3BHEiSkCjkHL5hRxCcaAvnknC6H20sXCirKW3Sga7dYP9BbyM1wOGWF/btgqyDuuuVgwvAIeeyFDyjkQjKhqE1wVYXvsxANGU3nas4Qeq62TGU0aSPmpdaKyGY7mR5y64bUh6vm+XzKY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(316002)(36860700001)(110136005)(36906005)(2906002)(70206006)(7636003)(70586007)(8676002)(1076003)(8936002)(9786002)(478600001)(107886003)(83380400001)(6666004)(2616005)(36756003)(54906003)(426003)(26005)(4744005)(4326008)(186003)(336012)(7696005)(44832011)(82310400003)(5660300002)(356005)(47076005)(82740400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 08:28:22.2970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fde4a64-6c4b-47b6-e00e-08d977599d41
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6633
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Address coverage related issues in ZynqMP DMA driver.

Shravya Kumbham (4):
  dmaengine: zynqmp_dma: Typecast the variable to handle overflow
  dmaengine: zynqmp_dma: Typecast the variable with dma_addr_t to handle
    overflow
  dmaengine: zynqmp_dma: Add conditions for return value check
  dmaengine: zynqmp_dma: Typecast with enum to fix the coverity warning

 drivers/dma/xilinx/zynqmp_dma.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.17.1

