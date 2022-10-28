Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBF610996
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 07:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ1FKR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 01:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJ1FKG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 01:10:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABEB209A7;
        Thu, 27 Oct 2022 22:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRluJeUNuf7FU82KbEfbO2QKNBjDPAYBNoNDPhA8NG/PzUsUD0PFX9yOroSf/0XkX9WjJ1lmn/RS44+z7JSF3MoDfVMs+eGnn8u03nPwqTQcATSm1lQk1gFtOQmLcD/igprCwjZ+njWZ/u5M44KGrgm2RZTInioKGNb1DtA4p/KrQ+xKqIQegyGs7BfPMzjglEAeFPIUilMco0kDpP9YLLC5ZfOrLpUfEBbReW1pv94OP5o/AirBhxOIySGS6u+AMKDM7QIW7dMxhzQ4rAkYFbnJfQeXU+t+/brNUf5ru/oFhCb7ig9245whRBBwx026q7Bbw8mpGHfUBlqTbSXdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXv1KRMk7l+GwHFfacek8MrL5RuwhHO6oiSVEO5Go0s=;
 b=B2AAPLCnVsuxl8r7F2aDkRiALd/GEl7349r8r5Wg6wL2ZSOXdsOszuT66XoyDVYy29MhbczD6NKIuXd7EVbsFoaTt1JcrHatPqGTMJEtqT87J5Tl2mypE/3s6FRDmVuAR78NLChztZ+vD8JIREvZNsmiJev5IbfbsbxvexnoqDT71vL5mNI/ttDjLCQWMRtIdubKKnluCg0cmACvVyFrhJUM3CTxu8/WEzjeHjNFt8ZXBe9JPiviz0dl0fVfEQwVbjBSibcA3G1mLvPNExI7PJ96G/4EAVvCeOZhSv5GNcE0+2rN0BjU8hhbGwlb1O5tlVz/wUuToS+khS+Pr6qUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXv1KRMk7l+GwHFfacek8MrL5RuwhHO6oiSVEO5Go0s=;
 b=cI8lanL3vNA9T0ostTCFO0dwxgSjhVkTzFInK3hW4kT3k3e3VaziFu/HKzrYR55eQLrmjzIbBMZNhvgGCKYbu83ErExrnpkZ9RztMRlcj1fLRwTra+m3n0u7ZJMf2zQzAZNkBOTrZMF8l4cK21FmBmyqOcHKJDO0DPpjZSjiUa4=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 05:09:55 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::b2) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Fri, 28 Oct 2022 05:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 28 Oct 2022 05:09:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:09:53 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 28 Oct 2022 00:09:49 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH 2/5] dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
Date:   Thu, 27 Oct 2022 23:09:37 -0600
Message-ID: <20221028050940.27888-3-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|BL1PR12MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b44f080-d1dd-4d92-a66c-08dab8a2a74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgKc2S/gzyVVBSp6P0ryPxWJv6ZTo4BCvR86tjnU91iiNJYtrpYLWS7erbSNqzslm5m6Ckkg8SCT6QVodZ8l2CpC0YqUVOIcP513Rn7WThFXc2JmUQUcyWQGQOlIPUSVvwGJ7IR3YVSyis1xNBnRqavyLToc5bxvyYuaZ5d2s5/fmu99V4BBUPgpTSPfd71eAoU1HB/aqlvpiCWuLdHy58Y+aC4GNBx+zX1kzWrvESRt6++/L6ZjpJE4P4WMdVLiBP79p1Fk0qM42V5sMIQJeDxeyjsTludenrRtH9jC8LqBjGtBkwW9F6eo9hVGuRjvGpyudbtwDJvXTUwmHU9jw0Os3FvaveHoMPRFCyTPpyfW3LJxa1k6PLqxzR1M/56jBI860FdKpWgUrtL2TzccYdfY+kGp4wBdKcv3ZekIca8JqlueQHo04VU0+nqqGwV7bClVoXUBGjYzzAK9BeFhh2IJeZtmD17MWk+sApSN4HJNZ/b1wYjDZ1tmDxLhAC0fxIw1YeMhF2/pnnjWnU9vD6jU9AC6stmRE+yTgUyADq8E8YSTBduoE4UFOpacVJXEj/P5ucpJNFrjKt7CUXqlfRcaVjRJpyYcMlMTro9PWZZYnnFE2GdApgaDo8SAlXYaCbgQ3pLlYRoDblxKJ42i790825UZ73jAse43A3SRPYIyEH/dA9AHxD58NGhW1LGOxemaW/3qNGM1uugiwIQHqfNPQnzw6EUh5L3JpM7Cvu/MXwVutZd9Zv86p13IjyGawPqqjR/Ew+Hl9Lrbwd1hnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(47076005)(36860700001)(8676002)(54906003)(40460700003)(6666004)(36756003)(1076003)(336012)(8936002)(4326008)(82310400005)(316002)(103116003)(70206006)(70586007)(2616005)(26005)(2906002)(508600001)(110136005)(426003)(186003)(86362001)(83380400001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:09:55.6752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b44f080-d1dd-4d92-a66c-08dab8a2a74c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Add an optional AXI DMA property 'xlnx,irq-delay'. It specifies interrupt
timeout value and causes the DMA engine to generate an interrupt after the
delay time period has expired. Timer begins counting at the end of a packet
and resets with receipt of a new packet or a timeout event occurs.

This property is useful when AXI DMA is connected to the streaming IP i.e
axiethernet where inter packet latency is critical while still taking the
benefit of interrupt coalescing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 18445aa092ab..9793523633a4 100644
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
2.25.1

