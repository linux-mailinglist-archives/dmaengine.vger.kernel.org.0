Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B463721F
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 12:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFFKxw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 06:53:52 -0400
Received: from mail-eopbgr820074.outbound.protection.outlook.com ([40.107.82.74]:64404
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbfFFKxw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 Jun 2019 06:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l77Rja3NVTr1FASFf4N4OECgTfkCHz7c77vasZ9/Eo8=;
 b=Pnjkm7nhv0tqJIvZdjKngmhWFeXorKlY3mPcjIC05UwWXUJG/JHe+JSCAKqA9Xm+On/bGyW4TBGkLgpm1Mcp/7oWUiPZgRh2Pw63isCx1+ID3/76oQTOynCMYhWNAP0WRBweS+BjT0ysdDhc/+U8oTfnArpPfivVkEZ14+aPlUU=
Received: from DM3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:0:50::33) by
 CY4PR03MB3128.namprd03.prod.outlook.com (2603:10b6:910:53::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 10:53:49 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by DM3PR03CA0023.outlook.office365.com
 (2603:10b6:0:50::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.21 via Frontend
 Transport; Thu, 6 Jun 2019 10:53:49 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 10:53:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x56ArnlB022967
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Thu, 6 Jun 2019 03:53:49 -0700
Received: from saturn.ad.analog.com (10.48.65.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Jun 2019 06:53:48 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] dmaengine: axi-dmac: update license header
Date:   Thu, 6 Jun 2019 13:53:44 +0300
Message-ID: <20190606105344.3405-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39850400004)(2980300002)(199004)(189003)(2870700001)(36756003)(106002)(246002)(8676002)(2351001)(478600001)(126002)(476003)(2616005)(486006)(44832011)(316002)(426003)(336012)(6916009)(26005)(77096007)(1076003)(186003)(4744005)(50226002)(8936002)(51416003)(7696005)(4326008)(47776003)(86362001)(305945005)(6666004)(356004)(5660300002)(107886003)(70586007)(70206006)(48376002)(7636002)(50466002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3128;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 889809d6-bd4a-44db-16d5-08d6ea6d41c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY4PR03MB3128;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3128:
X-Microsoft-Antispam-PRVS: <CY4PR03MB3128F955501A9655F39A160BF9170@CY4PR03MB3128.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TkVpP7aYpjrgnnR+TagK+VjvWWqsT1KgMQ0KYLCuUN6ZHVrvm9r1z4x1x/hNFU2lSGJ1iFFV7Ut+ve6dVBhuHWwhIQ20jQ8YJ/aZlaaswtH/f53IoH7uo0IKzRJt2rLCsjlpXQVD0wPqWUiWMgcObwrSCiv7G6MxuWFaWkCznGgQUL/9AMTgeifzk7bQKhHwI0Nb9roK4tQlpZmQoJIkZCp1332JTUR9IhbmjS0zrKH63JSWeoAwldX9WlflvSVnGwuXF/KDnj5MpCWNyQGklajIZgpGpJamB4bSidQCZJTi5p+XP5Xqq3g5XTY00fwHxHyEIsv3DVIieMVQx4VEkv0WadEEnA4g57tDLMt9vlxU1BRgPDFkoDvRcXar8hKd2QKW+sqA09Z4wPdBrI7uRKJD2BGs2axIe86L0oNUcX8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 10:53:49.4061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889809d6-bd4a-44db-16d5-08d6ea6d41c1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3128
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The change replaces the old license information in the comment header with
the new SPDX license specifier.
As well as bumping the year range from 2013-2015 to 2013-2019.

The latter also reflects recent changes that were added to the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a35b76f08dfa..5c81b798cadb 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for the Analog Devices AXI-DMAC core
  *
- * Copyright 2013-2015 Analog Devices Inc.
+ * Copyright 2013-2019 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/clk.h>
-- 
2.20.1

