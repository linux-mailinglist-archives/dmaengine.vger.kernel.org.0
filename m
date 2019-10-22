Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82096E09F9
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfJVRBC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:01:02 -0400
Received: from mail-eopbgr780059.outbound.protection.outlook.com ([40.107.78.59]:60858
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732886AbfJVRAn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 13:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx071NEhWr3UJA7tlODqD7P30MvTDZHQgU4D1fY5vDxZtd8KuyNtx87WjLgjxyanG2FXF7UA6eLJ/Fv26NzQg4oLLYpUE2skikJeARprUgHhj1JZ3tbODTTTRP9WwSEFqHLGnGCR5hzldtfFu8KZMdiZGTRow7qC9ZxMUB+e1c9FJz+JRHDssB60S5F6q/8ruNtdi9dj9sUqCXFVMT7F6T//XLrKH0DERecoSs7kik/Ah8cPh2C3FcKRbv190+XzgK4BbEk6redfkt/uqQi8+AufFMyKju5jA+IzwjSLGwkzEXC3NUOlXvCvmeYXsCTOcJJRpNpvj0/JCfXDE7Y6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed3I5BZoPRoKWOYjFKhAI5bg7DDua/eE03WhPAIGYrM=;
 b=dnNvYxsh5lQ9PTMDTNw0ovkLMfrLgWbVaRbOPDH4IMAy8yXb1fkfa3tAsQHBjPnYCMcboOr/1oMVe1VD9BfvComAoecFoHTTCoZN6QYTqAHlgSf4BZrBt7oBTQ2NTDUmOP5tLGwAQqKoFYv7NsN/7R2zkeQVCq7P1HRYS+2d7+kNXLQCM8AWPeHvv1iSanFjClt4Ju49I5H+s6Er2IPMbtwWHY5IavB5EOudoO0OafpKF8sonidw8WhXgFGRZNkH7SCJUZj+W8HUxaKpntwksyaVmNFHO6WGCjlAfv0ShD5XSWp1TFpOSoVSBs7n+zBDS6mYvTk2+xlteq6DgCNc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed3I5BZoPRoKWOYjFKhAI5bg7DDua/eE03WhPAIGYrM=;
 b=GKybovS15aRJD7lFoPv2rim6eNa3YMfpuR7rprFnVRg6s3Mdomdf8vTd8fiD6jALdHP0hYqmiepMuuXJYCqyuD6PuJ4Yc5mjuhY7N5MYigLL9hdy8yL8F16rIom7YWRQwnPR4WVDusL/ZR++FdF1DI/pq9Up5khpyXNgZL0qYkk=
Received: from BN7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:20::27)
 by SN4PR0201MB3614.namprd02.prod.outlook.com (2603:10b6:803:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Tue, 22 Oct
 2019 17:00:41 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN7PR02CA0014.outlook.office365.com
 (2603:10b6:408:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21 via Frontend
 Transport; Tue, 22 Oct 2019 17:00:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 17:00:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWS-0006Ak-0y; Tue, 22 Oct 2019 10:00:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWM-0005D8-OM; Tue, 22 Oct 2019 10:00:34 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MH0Wo4030513;
        Tue, 22 Oct 2019 10:00:32 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iMxWJ-00059f-JZ; Tue, 22 Oct 2019 10:00:31 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id CDE1410112E; Tue, 22 Oct 2019 22:30:30 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 3/6] dt-bindings: dmaengine: xilinx_dma: Add binding for Xilinx MCDMA IP
Date:   Tue, 22 Oct 2019 22:30:19 +0530
Message-Id: <1571763622-29281-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--2.053-7.0-31-1
X-imss-scan-details: No--2.053-7.0-31-1;No--2.053-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(478600001)(81156014)(186003)(81166006)(8676002)(26005)(2616005)(6266002)(126002)(446003)(107886003)(11346002)(476003)(4326008)(316002)(50466002)(2906002)(16586007)(42186006)(50226002)(106002)(8936002)(36756003)(70586007)(70206006)(6666004)(356004)(76176011)(48376002)(103686004)(14444005)(47776003)(426003)(486006)(305945005)(7416002)(336012)(5660300002)(51416003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3614;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea22e8d-3a24-4563-53d8-08d757115e6c
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3614:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3614D5E8D2770D06B065FC35C7680@SN4PR0201MB3614.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7eAm6BwoA0HZ1h1AAPgAVSIXvErRJHo0OGJjQK59Nyo9EmPX0p1FZTZ7+ZvcvSFhlRBFArLoB+O8XNvovDVmI3yVbDr0r96q6c/LR3cv+26wngxBlinHd5XWRxTUxLqHeXtZg3rq4oz2HoMOSV24si9vulLB4v3VJ4Q7pnr0FPgRF8Mq0jPJBr6nyLfJn4z6eFy0On00akZ6cAWtR06jM8k9Tn3P/7dMV9niDMFrnj2tQJrmdznGpO4t4nhm2gyu78Yx3hgkolD0fAfvotzrFrWWfZEPIXni9trCDTvsVvHYWHOqUDSdpNd8zynEMANEkYlQY+fQveDBFlXc/T1HmHqXazhXjk657UhvXJ6WlriJOYWO3AGSzWU4oi2JPNZ18mxaB94v4ZOfcCjdZlTeNgRovdcvS4lSsS3C1HouRFKfl7jjkTuj0prbYz0JhvV
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 17:00:40.4911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea22e8d-3a24-4563-53d8-08d757115e6c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3614
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add devicetree binding for Xilinx AXI Multichannel Direct Memory Access
(AXI MCDMA) IP. The AXI MCDMA provides high-bandwidth direct memory
access between memory and AXI4-Stream target peripherals. The AXI MCDMA
core provides a scatter-gather interface with multiple channel support
with independent configuration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Keep compatible string one per line. Suggested by Rob.
Reuse the existing xlnx,axi-dma-* channel names. Suggested by Rob.
---
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt         | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index d4ba1cb..325aca5 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -11,11 +11,16 @@ is to receive from the device.
 Xilinx AXI CDMA engine, it does transfers between memory-mapped source
 address and a memory-mapped destination address.
 
+Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
+target devices. It can be configured to have up to 16 independent transmit
+and receive channels.
+
 Required properties:
 - compatible: Should be one of-
 		"xlnx,axi-vdma-1.00.a"
 		"xlnx,axi-dma-1.00.a"
 		"xlnx,axi-cdma-1.00.a"
+		"xlnx,axi-mcdma-1.00.a"
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
@@ -31,7 +36,7 @@ Required properties:
 			   "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
 	For CDMA:
 	Required elements: "s_axi_lite_aclk", "m_axi_aclk"
-	For AXIDMA:
+	For AXIDMA and MCDMA:
 	Required elements: "s_axi_lite_aclk"
 	Optional elements: "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
 			   "m_axi_sg_aclk"
@@ -39,7 +44,7 @@ Required properties:
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
 
-Optional properties for AXI DMA:
+Optional properties for AXI DMA and MCDMA:
 - xlnx,sg-length-width: Should be set to the width in bits of the length
 	register as configured in h/w. Takes values {8...26}. If the property
 	is missing or invalid then the default value 23 is used. This is the
@@ -56,8 +61,8 @@ Required child node properties:
 	For VDMA: It should be either "xlnx,axi-vdma-mm2s-channel" or
 	"xlnx,axi-vdma-s2mm-channel".
 	For CDMA: It should be "xlnx,axi-cdma-channel".
-	For AXIDMA: It should be either "xlnx,axi-dma-mm2s-channel" or
-	"xlnx,axi-dma-s2mm-channel".
+	For AXIDMA and MCDMA: It should be either "xlnx,axi-dma-mm2s-channel"
+	or "xlnx,axi-dma-s2mm-channel".
 - interrupts: Should contain per channel VDMA interrupts.
 - xlnx,datawidth: Should contain the stream data width, take values
 	{32,64...1024}.
@@ -70,6 +75,8 @@ Optional child node properties for VDMA:
 	enabled/disabled in hardware.
 - xlnx,enable-vert-flip: Tells vertical flip is
 	enabled/disabled in hardware(S2MM path).
+Optional child node properties for MCDMA:
+- dma-channels: Number of dma channels in child node.
 
 Example:
 ++++++++
-- 
2.7.4

