Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E642F2AEF9
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfE0GzZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:55:25 -0400
Received: from mail-eopbgr800041.outbound.protection.outlook.com ([40.107.80.41]:25312
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfE0GzZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXZfOS/dQAXD9SPIEbxJDyZi8Wiwx0sdPDTxJ9BF/kE=;
 b=RnpXeancvfB8hcYbUVs9xARr4/moRQmkiUUq4e/2IW1X92+M2fQ4ddt/aNia7sX0cg8N7MY50agY1EuQIJBilroGCy0M8DRvrd8twh5vIXK3/8g+Nh7/VnYACn2Ld9I5yt7coJmrJ7VdHWV3Z9qkmNJEHmDBcZwL2UcrF9K0T58=
Received: from DM6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:40::17) by
 CY1PR03MB2268.namprd03.prod.outlook.com (2a01:111:e400:c614::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.18; Mon, 27 May
 2019 06:55:23 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by DM6PR03CA0004.outlook.office365.com
 (2603:10b6:5:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.15 via Frontend
 Transport; Mon, 27 May 2019 06:55:22 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Mon, 27 May 2019 06:55:22 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4R6tLQq029720
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Sun, 26 May 2019 23:55:21 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 27 May 2019
 02:55:21 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3][V3] include: fpga: adi-axi-common.h: add common regs & defs header
Date:   Mon, 27 May 2019 09:55:16 +0300
Message-ID: <20190527065518.18613-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(54534003)(305945005)(50466002)(2906002)(7636002)(2351001)(246002)(70206006)(70586007)(48376002)(8936002)(44832011)(4326008)(86362001)(50226002)(53416004)(8676002)(47776003)(107886003)(6306002)(106002)(7696005)(51416003)(316002)(1076003)(2616005)(126002)(476003)(16586007)(486006)(36756003)(6916009)(356004)(6666004)(77096007)(14444005)(26005)(5660300002)(186003)(478600001)(966005)(336012)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2268;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f4714c-0af9-43ae-e102-08d6e2704a24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:CY1PR03MB2268;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2268:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <CY1PR03MB2268C37920571F94065CE143F91D0@CY1PR03MB2268.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0050CEFE70
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Qw14zDPZufz+WQ9HPFIp6ZACS/BDdIQz80/8Iody+Ywj4rkHZsQSUBsLUBdRMHUkJpE4op4b3F/7mPjeDHfv4V+n2bW5vjYgmktwm8ylZRv2a2HdvMJbdndiBt8smHnEQhZ3AD2dCoLceW2ui7ljjY8WrGjzdWRekSf6SIMeWOQ10jX0yIEyZUnoTbT6sB5Bc/4F4Tr4uE1o/r4tnmBwwOqV2sw0x22iGyDLiQp+urTD9rZpKOfDuheoBfr5X30GS7ziOCUvGc0qjFOD/SJM3TAhxGfg5PlOGDfs9GZLz8KMrC0IbSUo88A3pWFtQM2XKZX9Qvp5ksvkmvfUkk9R2Qs/eM+FngfYEKzNAv1j3LH5zR3/ifMYb3Jr2UrWKpwfW7/5ovaPiTadxMShRNAxcds4zd341+m9qrvQ8y9x1VA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2019 06:55:22.4878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f4714c-0af9-43ae-e102-08d6e2704a24
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2268
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

Changelog v2 -> v3:
* fixed style for SPDX-License-Identifier in C header
* fixed minor checkpatch complaint about 80 col limit

 include/linux/fpga/adi-axi-common.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/linux/fpga/adi-axi-common.h

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
new file mode 100644
index 000000000000..7fc95d5c95bb
--- /dev/null
+++ b/include/linux/fpga/adi-axi-common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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

