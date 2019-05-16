Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE8202CB
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2019 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEPJok (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 May 2019 05:44:40 -0400
Received: from mail-eopbgr770080.outbound.protection.outlook.com ([40.107.77.80]:63861
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfEPJoj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 May 2019 05:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npRbukhZoJ58S7/cSVyNdSDFI37jeYcLA/kYCxlv+Hs=;
 b=ywaZUc142cgMGCte07r9LTDqNS3aVuLxtu9OmTIySqu5eiBtgPOjjQmiEy2LJ82/FJ1+N18IjqszrRlfTS9rzmKdI1v9QxMe0tr8Q234wuO4e3780eGI6FTdMTq/Y3a9EVp/mdVEhqM86cOXIF6GY2a6o7M4FxkIkvbd46yXPcs=
Received: from DM6PR03CA0012.namprd03.prod.outlook.com (2603:10b6:5:40::25) by
 BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 09:44:36 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR03CA0012.outlook.office365.com
 (2603:10b6:5:40::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 09:44:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Thu, 16 May 2019 09:44:35 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4G9iZJt031971
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Thu, 16 May 2019 02:44:35 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 16 May 2019
 05:44:34 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] dmaengine: axi-dmac: Enable TLAST handling
Date:   Thu, 16 May 2019 12:44:30 +0300
Message-ID: <20190516094430.16121-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(86362001)(70206006)(356004)(70586007)(336012)(1076003)(6666004)(478600001)(48376002)(14444005)(44832011)(4326008)(107886003)(8676002)(2906002)(50466002)(51416003)(2616005)(50226002)(186003)(486006)(26005)(476003)(53416004)(47776003)(54906003)(426003)(8936002)(77096007)(246002)(126002)(36756003)(2351001)(6916009)(106002)(7696005)(5660300002)(305945005)(316002)(16586007)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4e07b92-312a-4a04-0524-08d6d9e31b52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR03MB550;
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Antispam-PRVS: <BLUPR03MB55059DEA8E9F59FA8EEBC41F90A0@BLUPR03MB550.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XP1tcUZZ0Jo6G7vQRCEo+bAIfobqkH+AWEnUYdQVeM66P9r6m1K8v/yQ0XhOjyfoR2IERjH2/ueBnDPpqsXuVLgxxvkIoQdGwHYUNdUWWQMAzev3VCw6mXLL8/0O1u2Am83CsRWrUAGFX2F746PSgRKxB19BcO9KZvLZsJOENicax3JJ9mQY7e/NtEnM1Pugx0gwHaVYlzV6dm1S/X+jC6+QuxFm5lX4xUJzsID5TCsma9wECWcPsyQ9LUl86M0Xz3pKVdI9o/0PlUs//k8ArBRnn7nK88qoIJBu06LCw74+hI2vlxrauXbxieEdQIAmTbtP0sAXoY7MLXFnojDL/zCO1bzUMgIUcrOu4EaVNs9gfb/NeFIzH3H/BPE87Nutewyms8fE3ZMYvK93qMFcyQ6MWgs8d/tvaeQ7DiE7AbA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 09:44:35.7726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e07b92-312a-4a04-0524-08d6d9e31b52
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

The TLAST flag is used by the DMAC HDL controller to signal to the
controller that the following segment (to be submitted) is the last one (in
a series of segments).

A receiver DMA (typically another DMAC) can read this parameter (from the
transfer), and terminate the transfer earlier. A typical use-case for this,
is when the receiver expects a certain amount of segments, but for some
reason (e.g. an ADC capture which can have an unknown number of digital
samples) the number of actual segments is smaller. The receiver would read
this flag, and then the DMAC would finish.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f32fdf21edbd..8b6fc21bdb9e 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -71,6 +71,7 @@
 #define AXI_DMAC_IRQ_EOT		BIT(1)
 
 #define AXI_DMAC_FLAG_CYCLIC		BIT(0)
+#define AXI_DMAC_FLAG_LAST		BIT(1)
 
 /* The maximum ID allocated by the hardware is 31 */
 #define AXI_DMAC_SG_UNUSED 32U
@@ -216,6 +217,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 			desc->num_submitted = 0; /* Start again */
 		else
 			chan->next_desc = NULL;
+		flags |= AXI_DMAC_FLAG_LAST;
 	} else {
 		chan->next_desc = desc;
 	}
-- 
2.17.1

