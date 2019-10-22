Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E35E09EA
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbfJVRAn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:00:43 -0400
Received: from mail-eopbgr730089.outbound.protection.outlook.com ([40.107.73.89]:18334
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730363AbfJVRAn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 13:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBlZtfNwPEGQN4/wRpv8wU0tngcoVhNG85XjK70Toyj38ydwxtjBTTB3/TCJshiULKF7NdB1pbAFesMSc91CSQ3zzfL61er0BBihDN7HGH/IRtCE7tRLXBWX4yZRJnBiWFDhP6B9+RwLzevgp9YFOHRhfT/0cmeAVnmvzWVyniBGuPBWzhgPstj3pFQ/nMJ3/ee3ggbHJ8pGMiVHuAhKZEqoXBzzJqR9GmwkWCuhbwOCK53Gq+0RmmH8pWbjyLENVhfBNgWGUzC79Y6kB7MBw0VvOxzZ9OEKRVL/z/WrLuaWO12XKy2utRGvbn1wVUs5o9WDctChVoZXhZdX1sVtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZe1J+kjAxace7Y02lfa3AlwKrWulwj4LpqjO5RicqE=;
 b=UqUQoB9oo1mErJDvyC95UibPzKQdMbm5NCYW/FZlkAKKuc0BvK8s9IYlm9VnDtGvvTwFM58a6p8r2R1cUKZ4InT+ZCLyx9mmuVpVrvll7TcZKLuXWCbysL4XGy7E/OHCM1si0nA4BvXV9G5uKwyK5piE+N8CGRvwn0cn5lSU4euZpAoihT4oFbiV3MnQ+wtrz17bEKblE4FekCP+ggnetID0oS9jJrOg7GxdVdtT+sRDrlne2a00XUIpbxY7GmltCKyopQyC3EgezjEVZEEyJ1zqf8JZpFykVtLMknXgMhNYSfCF1EcQ7OCiI2Fn04kGwxXkZhLy2waVid+u+InCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZe1J+kjAxace7Y02lfa3AlwKrWulwj4LpqjO5RicqE=;
 b=IzmdYdhLjnaNK1KUHfMdx63eZGYxgUPid1/QbIb0uje1dcQW6p75LGeJzeFxU9SUQuVIKc19bjIVxTcam7TFHv55s+ZPhRP/Q7+1NtnA9dg8XwFbN5i0kQlUzeGu7Bb5+MMcWq07TmWys03X599MJvZbJpoMw44Sm61omtL0iDU=
Received: from BN7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:20::17)
 by DM6PR02MB6236.namprd02.prod.outlook.com (2603:10b6:5:1d1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 22 Oct
 2019 17:00:39 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN7PR02CA0004.outlook.office365.com
 (2603:10b6:408:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.23 via Frontend
 Transport; Tue, 22 Oct 2019 17:00:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 17:00:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWQ-0006Aj-So; Tue, 22 Oct 2019 10:00:38 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWL-0005CE-L5; Tue, 22 Oct 2019 10:00:33 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MH0Wac022056;
        Tue, 22 Oct 2019 10:00:32 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iMxWJ-00059c-IY; Tue, 22 Oct 2019 10:00:31 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id C537710112C; Tue, 22 Oct 2019 22:30:30 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 2/6] dt-bindings: dmaengine: xilinx_dma: Fix formatting and style
Date:   Tue, 22 Oct 2019 22:30:18 +0530
Message-Id: <1571763622-29281-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.034-7.0-31-1
X-imss-scan-details: No--5.034-7.0-31-1;No--5.034-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(486006)(336012)(26005)(51416003)(8676002)(11346002)(305945005)(107886003)(76176011)(446003)(6266002)(426003)(16586007)(106002)(8936002)(5660300002)(36756003)(4326008)(316002)(50226002)(2906002)(186003)(42186006)(81166006)(81156014)(47776003)(6666004)(48376002)(7416002)(476003)(356004)(50466002)(2616005)(70206006)(70586007)(126002)(478600001)(103686004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6236;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a0f761e-4245-4a11-35ea-08d757115db2
X-MS-TrafficTypeDiagnostic: DM6PR02MB6236:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6236620C4C3944A8C170A291C7680@DM6PR02MB6236.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVaasdJe+W7FycCy51iUGGTJnB9Xrinm9H/4UUKFK1ARaVG9zfQsHahVwHAIYgumexXwUuA6wAYBrkeXbOuw1jnT3eL/bJsgPNupJe2tlJePvsiLnHkC4QrC50i7pEqnWu1/V0w68Ke/IJFrqnoSQa1su6WiFgx4GzJOxusFYd37qxq4rNODKHMydWiwcxpLYuwNEXFRd+9eOZL0dqKFLsqTi6CBG14GyE7SX447VXdanfMa9UWQlosMUfkpvbPIi23kmeIw0u1HETRVJxJ6jORQAt5lXzmdwJyXZ5BzjPUd2HiwZYc+vofd2DFujSpUXg1xc4hcNL53ZUIOi9YMtBCOrK+qpI1Ei+Pma5jrnUtumKRwv/bPoWnwBnPZZMstQrkh5BrMgEnh+vBAx2pSVOsUWppZGC74Oldw0Kbx7h8smUptEqTZqMU4Ks25RlSm
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 17:00:39.3104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0f761e-4245-4a11-35ea-08d757115db2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6236
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Trivial formatting(keep compatible string one per line, caps change etc).
It doesn't modify the content of the binding.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes since RFC:
New patch. Trivial formatting (compatible string one per line) as
suggested by Rob in MCDMA RFC series.
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 99d06f9..d4ba1cb 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -12,8 +12,10 @@ Xilinx AXI CDMA engine, it does transfers between memory-mapped source
 address and a memory-mapped destination address.
 
 Required properties:
-- compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a" or
-	      "xlnx,axi-cdma-1.00.a""
+- compatible: Should be one of-
+		"xlnx,axi-vdma-1.00.a"
+		"xlnx,axi-dma-1.00.a"
+		"xlnx,axi-cdma-1.00.a"
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
@@ -29,7 +31,7 @@ Required properties:
 			   "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
 	For CDMA:
 	Required elements: "s_axi_lite_aclk", "m_axi_aclk"
-	FOR AXIDMA:
+	For AXIDMA:
 	Required elements: "s_axi_lite_aclk"
 	Optional elements: "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
 			   "m_axi_sg_aclk"
-- 
2.7.4

