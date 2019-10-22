Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4414E09ED
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfJVRAo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:00:44 -0400
Received: from mail-eopbgr820087.outbound.protection.outlook.com ([40.107.82.87]:60952
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732905AbfJVRAo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 13:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0WpUY4SLENRBcI9ONpTgIM71eOm3lvh/iC/L/+w6MP6lOiiVZJw89gAHX8G0K1anaxzUFNqPoR/2VLtlnYdcTTVGv2/eWNSsz4mizm4rp6StF1cu5DbaqW/kiIauMIwGTFemy2O9nRAGDkJ1P57v5dwcP8GL0rXZhJFiYPkt4fJTW5zlCLMyAtWwttaWOTOnd7q/Xx0fREc4MfMtPgd+Z+91u983SyS/wctj6qKN9sU4U8FpWq5IGLp70Luic+0zCBrIgBbuLDSP79y2ZgD23bSq6WbOeIusZw2XUY/fZ4qchhijrec1VPtJsdckdQvh5jpyHcK9qQDS0FUOTNAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdyptbvHTltRINYT9OFsVx3Oe4pKWTXX/58ZkW6H2Vk=;
 b=BiWzahQ3NDjOnJMVm6dqkR3nRdlnApN3BVCDm40lttfTC8WcOf22V6hBERQCGTSaHTxuQS/ZY4+kzOKwOy9oSc8vCpm8kntoeRJLRSN13D/th3axU37NqPbYqvGMzFoaAF3KF3yndnNtgvkUOFja4M3E0de0Zb4dpTcbWwOGtyBEZBX2F68lSRHlKOkS17OU2DYQCOZTGx8GngtGsX2xQROKh4HqKECgt1UtnUxOrAnozQSIrEA5Qa3ssGHoAc4mI0MVZGLINFdSNkIQxK/LbVuu4XUc/r4/yPzb+19fmlUqK9MFeshH9lClTeTRPFYRdNn1Yjcw3riMt4HzwL2rXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdyptbvHTltRINYT9OFsVx3Oe4pKWTXX/58ZkW6H2Vk=;
 b=QdBmqosXnCfZYuzRawGfYGn3mEn9j/laNtJPfrM5A16ezRC4jkHcK3MKb0W5NDdWqKxUSfgLDREIR4Y8qLwPaVZe7eez6UHjPoalAsvxHYXuGBlm2HRyYMSMa5c6VOVNZtd8DyUem2Zkruzjs9Cnpjt1RMIWnhkaVDkKoRzQZW8=
Received: from MN2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:208:fc::23)
 by DM6PR02MB6377.namprd02.prod.outlook.com (2603:10b6:5:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.24; Tue, 22 Oct
 2019 17:00:41 +0000
Received: from CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MN2PR02CA0010.outlook.office365.com
 (2603:10b6:208:fc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Tue, 22 Oct 2019 17:00:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT036.mail.protection.outlook.com (10.152.75.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 17:00:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWS-0006Al-4B; Tue, 22 Oct 2019 10:00:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWM-0005DH-S1; Tue, 22 Oct 2019 10:00:34 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MH0WZR030509;
        Tue, 22 Oct 2019 10:00:32 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iMxWJ-00059Z-I4; Tue, 22 Oct 2019 10:00:31 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id C26F510112A; Tue, 22 Oct 2019 22:30:30 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 1/6] dt-bindings: dmaengine: xilinx_dma: Remove axidma multichannel support
Date:   Tue, 22 Oct 2019 22:30:17 +0530
Message-Id: <1571763622-29281-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--2.613-7.0-31-1
X-imss-scan-details: No--2.613-7.0-31-1;No--2.613-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(107886003)(26005)(76176011)(51416003)(6266002)(14444005)(7416002)(305945005)(48376002)(2906002)(4326008)(5660300002)(36756003)(81156014)(8936002)(81166006)(50466002)(8676002)(50226002)(47776003)(106002)(42186006)(446003)(336012)(6666004)(356004)(478600001)(70586007)(186003)(11346002)(486006)(126002)(476003)(2616005)(426003)(16586007)(103686004)(70206006)(316002)(921003)(42866002)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6377;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd846e4f-937c-4dbb-6047-08d757115e96
X-MS-TrafficTypeDiagnostic: DM6PR02MB6377:
X-Microsoft-Antispam-PRVS: <DM6PR02MB637726318E34CA361C889C67C7680@DM6PR02MB6377.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5n63usNrYXjfAqdchaP2QBSPHqe+G4x+0YS1YfQbJj8rGwu62csBi0J0+/TcVLRMtMq1sYdVoH6O0muy0g0XG0RfHTnK5YfE3gSaHa7r8qN4ndTwCNbvfTLSvYX3OpEgMK7u2+g2ZcbTkMYQtMl9tl/nhb8ymtkYfDCiO9LQvmBW9hasiI4jTel3YV6Tt4Nmyv0dlRMWZv3VXulw/Bi5woXn4ME1rB7Bo4uyr5BaKkOZYIFAcD1Qdqzm7pmspul7moOFPCtMCptSqjBu+YbJu0queJS9oYlNLgwmnQihJzC/IX+X5m9kF5YSRGmoOp04Mhqt/HPIwSxDcuADt0ewO4eam2AqlOyRrPj0+OtU06H5wC7UPv2lVDukmXF8ofgg0BMN1rhOuqfvA68eksCHo+zwVyrJxhetNw9Mmpg6O7kv/quP3BDbg/2oFDwEawk
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 17:00:40.7757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd846e4f-937c-4dbb-6047-08d757115e96
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6377
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The AXI DMA multichannel support is deprecated in the IP and it is no
longer actively supported. For multichannel support, refer to the AXI
multichannel direct memory access IP product guide(PG228) and MCDMA
driver(added in the subsequent commits). Inline with it remove axidma
multichannel optional properties i.e xlnx,mcdma and dma-channels from
the binding description.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes since RFC:
New patch.
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 93b6d96..99d06f9 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -42,7 +42,6 @@ Optional properties for AXI DMA:
 	register as configured in h/w. Takes values {8...26}. If the property
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
-- xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
@@ -69,8 +68,6 @@ Optional child node properties for VDMA:
 	enabled/disabled in hardware.
 - xlnx,enable-vert-flip: Tells vertical flip is
 	enabled/disabled in hardware(S2MM path).
-Optional child node properties for AXI DMA:
--dma-channels: Number of dma channels in child node.
 
 Example:
 ++++++++
-- 
2.7.4

