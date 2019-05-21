Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC3251AC
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 16:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEUOOv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 10:14:51 -0400
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:23491
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEUOOv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 10:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02ThFPfSX8mreM4p2BRvdbg0zDfEYQNxXPWjqMZxnbU=;
 b=LefPsbcIT+sAvKN55rl+LbRk5nt26yp0+G5VquaipYFnasuJCngKO5hyXzCRaoCSdFlzZ46M/rzuQJF16/9PcxhxCtxlN2JqbhtTglIU/672e/yeYDdkZ5ZgPljWPpVC2ry8Q+w7VvrE7hy3bWQ/iLoW2p+xNViPCC5+HU791hM=
Received: from BN6PR03CA0051.namprd03.prod.outlook.com (2603:10b6:404:4c::13)
 by BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.19; Tue, 21 May
 2019 14:14:48 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN6PR03CA0051.outlook.office365.com
 (2603:10b6:404:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.17 via Frontend
 Transport; Tue, 21 May 2019 14:14:48 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 14:14:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4LEElnl032390
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Tue, 21 May 2019 07:14:47 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 21 May 2019
 10:14:46 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3][V2] include: fpga: adi-axi-common.h: add common regs & defs header
Date:   Tue, 21 May 2019 17:14:23 +0300
Message-ID: <20190521141425.26176-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(199004)(189003)(50226002)(1076003)(316002)(16586007)(6306002)(2906002)(5660300002)(70586007)(70206006)(356004)(6666004)(126002)(2616005)(476003)(305945005)(47776003)(7636002)(426003)(86362001)(336012)(966005)(486006)(478600001)(51416003)(4326008)(44832011)(7696005)(6916009)(53416004)(36756003)(186003)(77096007)(26005)(50466002)(246002)(2351001)(8936002)(48376002)(107886003)(106002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fbcec9-fc09-4d55-c0b3-08d6ddf6ae83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR03MB550;
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BLUPR03MB550662A56CACA7E9F10BE50F9070@BLUPR03MB550.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4AzqNgSqlLII1dQ+U74l4wHLM5Ed6ef+GPhambWPzXkX2Ol6oX9ziRLVfAHLu9tm7oFfT9xtIVOQtkGZ0XrUqrT9BkFO7IURnDMwSXsJ2ggGt5661lBSSTwBazUO1h3/FqjxoiZLzHLkgBz327EbPrP/fw3fl24v1hL1y8Q/lOQs9uFh2TOprNe9oEIFNzsaHR43nhWkT3UelixochK5bWZxgDZXcWLaRamvfN8OQrmr70yrqG0qVNnJsimaUmKYgJyJo+KZbtNK7Y9hP8qBtENCrsHMSFSVrXJ3f7R7f8C2CDU0vvEyxb/Ebe3Mp4ZoY8zEJ+wElIZyoG64H3zk96B3PuXcfelH+SNQlCNzLxTFCoM8GjL7xEpFVrG7ni/SPv/FtTtpykReCbBgHB/L4YDW2QslOMwexyPlN0s5gJk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 14:14:47.6585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fbcec9-fc09-4d55-c0b3-08d6ddf6ae83
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The AXI HDL cores provided for Analog Devices reference designs all share
some common base registers (e.g. version register at address 0x00).

To reduce duplication for this, a common header is added to define these
registers as well as bitfields & macros to work with these registers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/linux/fpga/adi-axi-common.h

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
new file mode 100644
index 000000000000..7966c89561b1
--- /dev/null
+++ b/include/linux/fpga/adi-axi-common.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AXI common registers & definitions
+ *
+ * Copyright 2019 Analog Devices Inc.
+ *
+ * https://wiki.analog.com/resources/fpga/docs/axi_ip
+ * https://wiki.analog.com/resources/fpga/docs/hdl/regmap
+ */
+
+#ifndef ADI_AXI_COMMON_H_
+#define ADI_AXI_COMMON_H_
+
+#define	ADI_AXI_REG_VERSION			0x0000
+
+#define ADI_AXI_PCORE_VER(major, minor, patch)	\
+	(((major) << 16) | ((minor) << 8) | (patch))
+
+#endif /* ADI_AXI_COMMON_H_ */
-- 
2.17.1

