Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFB35A509
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhDIR5e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:57:34 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:21664
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234313AbhDIR5c (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:57:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2S1Cmea+uyOw99VRxRsPs34W0kPRsqc6cLEhSIXer1IDHJUu4kU3KUyRlmZ79MdJXMVv55XDbVH9Ij0nZ9i9Y5wEh/Q8sAWuk90ckLrO7WiKztNUrwJgFsWVZctPwOTKu9VT4Yc4wuydbklsNe9n9S9xQsFXnbt8ZV5Ec5AyqfNKXz5GIMigFSTLFVBXUbIRI9qeXaE/mawiFdFtDodAXBZW/1GVPQAFc8KTl6/dyJW+rIReBZPcR1R1canH0pb6nWKcH537fdv7mC9v8DQQ2AJo6qwze3JsskjHSL7NULTFQ3zmW8lQiFqfi7xsAnD6mN5GzxN1w7RD2VvaKtM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7/BmvERrCSe1tnCDnq5w0eMO6FyTCDASPrA1Y8mmdc=;
 b=CKSCVuCG0y9y+orwJV9dyI+QSt6Wuq9sK+FpTMZLkzp3vfCcXr3THyWv3FZtqmSTDDt3ytoqGTkfLgp2NxS6idWhoDi2Zf6SbtGyDCtvqJgxLJhgR0RnJOYGkb8Z9SjIm3R5SfighgpQH6ucaifuIDXdwtCOETFWi940OS0dcL3lilXwhiOYBm4w+i99NRb3zAt4UxVUPoRWijsRfbFecDxsgmExRqSBjBNFMjFq2tF6d0c7yfrYq6k/gnFsSsTu9D/6D2BYiVG6Z2rC6fLIbDlB2IW2waACks3y/MKRjAdI6adcqJSTu+OMZ7lcqS96mGCng3S9WgfZppkeTG2LeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7/BmvERrCSe1tnCDnq5w0eMO6FyTCDASPrA1Y8mmdc=;
 b=sT5kPxaSaxVLd1JVg4LqVb9tx/Ditr7IqKNhBe6C4ahKtEZ2Fq6EmVB5G7J4JYzd8mwCP71IRtEoSjS83NRCIV6cxe3BWTNwsk1yh6DFoErXVBEYIWJdb+Pg4IMIBxikVV38gi2m9x+omy7NS+UE7OhjZGYKJp56PMLEI0MkAqk=
Received: from SN4PR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:803:2e::27) by BYAPR02MB6437.namprd02.prod.outlook.com
 (2603:10b6:a03:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 17:57:16 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::4d) by SN4PR0201CA0041.outlook.office365.com
 (2603:10b6:803:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend
 Transport; Fri, 9 Apr 2021 17:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:57:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:56:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:56:48 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33285 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvN9-0001C2-4h; Fri, 09 Apr 2021 10:56:47 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 348BD12164D; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 2/7] dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
Date:   Fri, 9 Apr 2021 23:26:00 +0530
Message-ID: <1617990965-35337-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c77b5fbd-163c-4148-40ca-08d8fb80e9a9
X-MS-TrafficTypeDiagnostic: BYAPR02MB6437:
X-Microsoft-Antispam-PRVS: <BYAPR02MB643705F120590C2C9F4919CCC7739@BYAPR02MB6437.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H48eeHOUDas7FiUikDy5GMU1a0PD0DLZFcJGLuUPn08CVtx7OtXEkJCWDHC6mKG1krAcYZOU2ShBAkLKpYXozDrF+Pw2qYCYhHuf3zkfOgDvlKnstya7yXIOIycRxDvnFKROBjS/k44sxdnmwLkFShw7+I9Hf888V6OKJeaDquy2cGyNXJZ7MGuooguMFMwBTgCJKqkFVr7Al2Z6TRJf6iHT7MzUxjJ8fRVIn5QwhsFJazxVYG5x70gijmxH5Y9cJPeEjyvybfEXyUm+igu/VEefp6KiP9K6NWKMJ6/W4GhUKlSQTuBBvEv8iwxMXPQ4+WNvgNG0wAAPglE06MKTPF9/2pG7TmRpkOZlLU1FsTjXUhYVxPFmhAwO0M3Zn2FnPruvncMlmlmW9Aa2mq0PdV67tsM41Crb2knKJ8TCLtJ/lMiV1tGl2oD6oea8fCWeie8Fa3VBYGcq1PGqIFTIPZPoTNm4XG+dVUIGBoY07XIezxiR43noG0Hp5JeGusySooNPi6R/Ikq+xl7PxcCCUR9zDHVAWjOfpYbqnINB3S8yTKX16X9L+gNf3vs0JnPTWMOAE1O0Z1X7bB9Q9JbffbSXaYjKg369dTyNbJkrzkwzkbclY68b72e9DY1EWLD9IM8iMRmqKzh/JLG8A9a6ni/+CA8Yj/BMjvYuMKO/HysbSF0hP0WDT4o2eSFZbtXz
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(70586007)(2906002)(6666004)(8936002)(70206006)(356005)(426003)(36860700001)(336012)(6636002)(83380400001)(107886003)(6266002)(8676002)(7636003)(47076005)(5660300002)(316002)(4326008)(54906003)(26005)(110136005)(42186006)(36906005)(82310400003)(2616005)(478600001)(82740400003)(186003)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:57:16.6684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77b5fbd-163c-4148-40ca-08d8fb80e9a9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6437
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add an optional AXI DMA property 'xlnx,irq-delay'. It specifies interrupt
timeout value and causes the DMA engine to generate an interrupt after the
delay time period has expired. Timer begins counting at the end of a packet
and resets with receipt of a new packet or a timeout event occurs.

This property is useful when AXI DMA is connected to the streaming IP i.e
axiethernet where inter packet latency is critical while still taking the
benefit of interrupt coalescing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- New patch. Introduce xlnx,irq-delay property for low latency usecases
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index f5f23a4a4467..96009ced7b29 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -50,7 +50,9 @@ Optional properties for AXI DMA and MCDMA:
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
 - xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
-
+- xlnx,irq-delay: Tells the interrupt delay timeout value. Valid range is from
+	0-255. Setting this value to zero disables the delay timer interrupt.
+	1 timeout interval = 125 * clock period of SG clock.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.7.4

