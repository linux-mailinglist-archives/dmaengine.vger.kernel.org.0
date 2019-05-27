Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBDB2AEFB
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfE0Gz2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:55:28 -0400
Received: from mail-eopbgr740058.outbound.protection.outlook.com ([40.107.74.58]:2055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfE0Gz2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd3rrgEbfhQwUv63GAX/GSD8JVBVuNt7XKDKnNeukRY=;
 b=RoOmTJD5j3iLNJQ+WNrOs+uZ/ilkqMjV1mTLPIoRwBTKHeZINYj2QPdfGBGIEW2QNW9tzrk9/Pl9aI9/+7DWrp7PrfCYIVbbPzGAmLNfRG3mPFHeuN6Ka9v1at6rFzZEPGmwyDYz0uf091K+uR/6BKAlH0zrRIPrZu78jYI5V6U=
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 MWHPR03MB3136.namprd03.prod.outlook.com (2603:10b6:301:3c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 27 May 2019 06:55:25 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.15 via Frontend
 Transport; Mon, 27 May 2019 06:55:25 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Mon, 27 May 2019 06:55:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4R6tOlC029729
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Sun, 26 May 2019 23:55:24 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 27 May 2019
 02:55:23 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3][V3] dmaengine: axi-dmac: assign `copy_align` property
Date:   Mon, 27 May 2019 09:55:18 +0300
Message-ID: <20190527065518.18613-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527065518.18613-1-alexandru.ardelean@analog.com>
References: <20190527065518.18613-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(189003)(199004)(5660300002)(186003)(4744005)(77096007)(26005)(7636002)(70206006)(53416004)(48376002)(50466002)(50226002)(8936002)(316002)(16586007)(47776003)(2351001)(478600001)(86362001)(305945005)(70586007)(6916009)(2906002)(106002)(126002)(7696005)(11346002)(426003)(44832011)(1076003)(336012)(486006)(36756003)(107886003)(4326008)(8676002)(246002)(6666004)(356004)(446003)(51416003)(2616005)(76176011)(476003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3136;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b30776f0-3c48-4eb5-c7b7-08d6e2704bb4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:MWHPR03MB3136;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3136:
X-Microsoft-Antispam-PRVS: <MWHPR03MB3136D593115FDF93388A0B70F91D0@MWHPR03MB3136.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0050CEFE70
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: NF2hvDjdrcpSUaunWsOEBuh9FeQnZRR/sD7MJBYTQqTL2WqlNH6pv6pMlgds1VGvo5Y8CNRo87dBA1hDyARkB1P6d+1jPhBx8I3C/2QSI5G9VOfk9zqIVYDHLaTVOh9wA6o+cp5ouIserdkLyWJXON+lCleatyVySsH0x+uhvpN8Pz2/TcW1joi2ihkTW107XD/zFuICcBgspwXGJj/5WpsCS/PhtU3t7+YPYiuYxgvrdr937rgeoRHZPU52SgdqN3nfu1XPGRCb4ILaTOkuIlDZEv56yXrMq/grBrdPlSv9XJgvIQApvlPREJRcPUiKtxWzzt3TVDWQJ3Z4u2q2rC1UIJg26dk0fh0si9f8vOyUbQkMYDBWa3RjyHGydivttYqtTHXkE2hgXf775PWAlrzkKroGT2nafFuOdmYB3Xo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2019 06:55:25.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30776f0-3c48-4eb5-c7b7-08d6e2704bb4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3136
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
index 74ae6246d9a5..d5e29bbc3d43 100644
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

