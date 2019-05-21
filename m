Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE68251AD
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfEUOO4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 10:14:56 -0400
Received: from mail-eopbgr760040.outbound.protection.outlook.com ([40.107.76.40]:8388
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728202AbfEUOO4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 10:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wQXnhr0DrcQ0TBrDjTt8b2DfI2dGItjw2i7B0+5cb4=;
 b=OAoiL8r7KWA8YUMeHPalkdKGt0tUEhl2jBe/Rhvoyrsk+QrUyMck+Bb9C+FgdVH661SZNGisf6/IxAPswPImuT5bGYa4+upMxR8mtQzF6oPrSPVYR4kmH70Z91qXL4Snupk2X2F6HQ1FFzmdcFkHY/b23kTBl5AoOAw/KKtytsI=
Received: from BN3PR03CA0080.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::40) by BN3PR03MB2258.namprd03.prod.outlook.com
 (2a01:111:e400:7bbf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.17; Tue, 21 May
 2019 14:14:54 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN3PR03CA0080.outlook.office365.com
 (2a01:111:e400:7a4d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.15 via Frontend
 Transport; Tue, 21 May 2019 14:14:54 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 14:14:53 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4LEErpO032419
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Tue, 21 May 2019 07:14:53 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 21 May 2019
 10:14:51 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3][V2] dmaengine: axi-dmac: assign `copy_align` property
Date:   Tue, 21 May 2019 17:14:25 +0300
Message-ID: <20190521141425.26176-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521141425.26176-1-alexandru.ardelean@analog.com>
References: <20190521141425.26176-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(316002)(486006)(107886003)(2616005)(2351001)(11346002)(8676002)(126002)(44832011)(86362001)(50226002)(2906002)(36756003)(305945005)(6916009)(7636002)(1076003)(426003)(356004)(6666004)(478600001)(51416003)(7696005)(76176011)(50466002)(48376002)(53416004)(47776003)(186003)(77096007)(26005)(70206006)(70586007)(106002)(4326008)(476003)(446003)(246002)(16586007)(336012)(5660300002)(4744005)(8936002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15807ffa-79ea-45f9-970f-08d6ddf6b225
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-Microsoft-Antispam-PRVS: <BN3PR03MB22587DEC7C16752B4EBB0C6FF9070@BN3PR03MB2258.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: A5OeSkyHIuUc904olr3Qq6FDL83ZEB4xoiNjCJAwgb55z88VoDha+M/vhCWprthPyRFW81227XYk5o7WNa3jC1W8OTDdwddMDc6gn70PKugU5FudGRgnqrqcoNYvrB/QeMmll7tmZg9o2XvlYoOFg5hpx9PKp09wLL46HlNxFJKQHK+0qBIlGlZm3dVFRonbRYHPnCdBfDUxFrLEQRWQXGCBt5jhliLTybbTYqmbhZh5cvZCVGRqXJ6PPbYpw92bbKFO4b1GSzFIKzHV5A7biLW2ogvwndXvqQRpV5VT8a7n7HBbh99xa8INGaY3AzZz9/7EDaQVWJCVOL8A9UpYfWkt6ZEZkqy4oriNqE0/+EDJsnTLLrji7razhYuFqORUWrQF4N5aRRKjWu0g85LGrXqFuADbSWuJtn11fM6MFbM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 14:14:53.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15807ffa-79ea-45f9-970f-08d6ddf6b225
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The `copy_align` property is a generic property that describes alignment
for DMA memcpy & sg ops.
It serves mostly an informational purpose, and can be used in DMA tests, to
pass the info to know what alignment to expect.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 196e6c429182..88f9986e0e14 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -762,6 +762,8 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
+	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
+
 	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
 
 	ret = dma_async_device_register(dma_dev);
-- 
2.17.1

