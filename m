Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9DF24A33
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEUIXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 04:23:41 -0400
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:11997
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfEUIXk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 04:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU6uK3En89KmXXTp9paUgCWrXYW6Udye1VW5ru0UuSE=;
 b=q2aQE7gCWiuaZZnEiZRdk4pcPeMI9Gfol6nkXPrbGvQYtQe1fqBRiwpsWFzy8m03B+V5AfhRFzXgN7Xz94ONlgHeW7f8b/e9nWirGQlDS+VulVrUH8YsurJaD1ScycFoAg//9nXdkwAPH72J9+0yYKR9ijrITtl+4juOwMWKmV0=
Received: from MWHPR03CA0004.namprd03.prod.outlook.com (2603:10b6:300:117::14)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 08:23:38 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR03CA0004.outlook.office365.com
 (2603:10b6:300:117::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Tue, 21 May 2019 08:23:38 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 08:23:37 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4L8NbW8021508
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Tue, 21 May 2019 01:23:37 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 21 May 2019
 04:23:36 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] dmaengine: axi-dmac: assign `copy_align` property
Date:   Tue, 21 May 2019 14:23:31 +0300
Message-ID: <20190521112331.32424-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521112331.32424-1-alexandru.ardelean@analog.com>
References: <20190521112331.32424-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(189003)(199004)(50226002)(53416004)(47776003)(50466002)(107886003)(5660300002)(48376002)(2351001)(4326008)(246002)(8936002)(305945005)(51416003)(7696005)(8676002)(76176011)(478600001)(6916009)(86362001)(7636002)(4744005)(70206006)(44832011)(36756003)(1076003)(16586007)(11346002)(316002)(2616005)(2906002)(426003)(446003)(126002)(486006)(70586007)(336012)(476003)(106002)(6666004)(77096007)(186003)(356004)(26005)(81973001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0856ce1-59e0-4b8d-f415-08d6ddc59fd6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR03MB546;
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Antispam-PRVS: <BL2PR03MB546301F9134CD6D9FFA8D35F9070@BL2PR03MB546.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fuN8Pr9jFfSk476ESJByLrvO6necBhOLO9HRPcubnzZITBmWDsiajRhXu2CyxmBiXWCRsHoNrHfHK7RLTnBpxGMw7/pKlLQDu2DMhppFuOgfWniqXmeKsEhbqNvJv7HamWiy9/ooE9GaMdchW8//WVx5icRTGbthTtrJStx1ureO02PgPzt01RVI42ifxAmB0iAaUsNR7fWdUQg+396mIlK+mg45ZPJk0ffQJIFKe4lNkIp/AB4czfdg0VNrIRIXlC4906VZ+7s7hRovfOfxmVb85UUlFdGw6vL5b9LAINdpI762wyXzx5Ss+3CWWZ3lS7pLCtMakQJRJflmLh09/aSsAeZ92PUpjZn1hfsl8s3pdRtNqijAQOgYbtRf4g8iRV39z84PrG4sn6ziOihLdhooXXnrIhK4mS96/jvJ1F4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 08:23:37.8533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0856ce1-59e0-4b8d-f415-08d6ddc59fd6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
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
index edd81ceeeb33..eea994d827ba 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -763,6 +763,8 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
+	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
+
 	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
 
 	ret = dma_async_device_register(dma_dev);
-- 
2.17.1

