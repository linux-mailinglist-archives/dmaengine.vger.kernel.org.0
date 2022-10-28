Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8130961099A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 07:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ1FLC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 01:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJ1FKi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 01:10:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B15A8C2;
        Thu, 27 Oct 2022 22:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f75PQ1jwtYKIU1Qto/aNtPZ4B6yyNUfpuFWSvmDlAX7ZPCh6gKagPWUlKGRpBmXEZblXMhjoIUyaZjj6GMU6k6LTF11WG3AMF1YU8E7JEJAqjLRR5NXcs1y6x2LQeO0msqS4jx49I3ezyw/M3CChXSquxcVv925vqFAQIQNAXKcEuGM7pHgNeoMLSj2LicYnkFno5P9QRlj2G0HEq2jW2eFlXItenLbxrkQmvpNJ7ZKjiUVsX03HyLFDRhzwmr6UAhws5llVrrvr3k7V2VSuDwzRoME9k63qZTmh0XPA9eWd6tXgvqglQPCC93SPyE9qKzplwDCenqLQL1DGHP6iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEsYzSKMMJEK7OMcw7t2A2Ow8Wr422lOdsWJGZ/s05c=;
 b=J0h7+0YZUkc5DeWfSIiIIQ1G+mWI4kgHFuuTfQIBWCquoMIKA/tZzCqj9Kk7LTCC4UXANDFvD4ix92mvo6FRZDGVuObyGXFgdtOIDPk3vgn1ZvIkFG4FDpgnMxbthKVqZTPZCOLdINQv6plXO+SOlVw3nLoiI6q5NDPMT/jDOTMrLDyBoRA9Lkc5ynuTOcz2EZFclcQL+LIINtxOJIMU3Ma/+bfZmWlot/LSqwle5zrsjoZbIjBgz0qpL7PewcSGjwjugAmao8oSfe8pjqBPhBCbyOyxiL+uPjs7xGmDtn1XJ77paAj8+fLwKqZ8MPAZsVZ7iMzLhzBWhinw8D0VNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEsYzSKMMJEK7OMcw7t2A2Ow8Wr422lOdsWJGZ/s05c=;
 b=i8LAMGtn2PhkJU093927I2wmC8hZPL+SJvWdWgHlaDCfbfYsSyKGLhM5gMHxC0Bg+6Nyvf9+jvTG35LRHx1roktU566E1gx3ypDNXg9hKVq3G0qjMxhLGeRY5AmK+sR0MQtUvKM29/tTS3oW4+Ed0DbldMYJCLfrLikLM4N+evY=
Received: from BL1PR13CA0332.namprd13.prod.outlook.com (2603:10b6:208:2c6::7)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.15; Fri, 28 Oct 2022 05:10:28 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7e) by BL1PR13CA0332.outlook.office365.com
 (2603:10b6:208:2c6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.13 via Frontend
 Transport; Fri, 28 Oct 2022 05:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 28 Oct 2022 05:10:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:10:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:10:02 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 28 Oct 2022 00:09:58 -0500
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
Subject: [PATCH 4/5] dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
Date:   Thu, 27 Oct 2022 23:09:39 -0600
Message-ID: <20221028050940.27888-5-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: da6407fb-9562-42a5-e7ae-08dab8a2bad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7+PFf0ySAjCJ6OexWvUbr/eBUPd5+zaT1gWtw9+8B0A4kr8S4DVyN8VBopeIO2eM/PJ2xi4gmpe45GuyROdYbeW3m37btuHEykGEPeK/9IxpcU/LxPyLR6jwHsugjHngo9dswq6Ry8w02YeCbk4o/xJBUOGXViDeWJMAYC7fILkOui+xiQ3oiw+VF/p5QI4l5T9U8+Xv0qjWUIcZZoxjbei31a6XSd5OR+c4PZizP1RNVWNkdSkvXh/EDHPHcRWd+Y+lyC8v35doovSzLWwrkbl2w5r9UDjUq2A232EjVgTXWCrB+Lf489WXxCJBSDWw+rouKAL7vyJ72zXe7r52Rrp/UtWLfniV6nC8enB5/rJnp2Qj67iMm6aLqOOkuop+0aSBfRX/xdtmuEGdCtqi3+oRtDwJtHIaE54wVsCC6EbpIYMZDkUSLaD/mWMgBUSMMcIc46Qlere15rzQGhrkKrbwh3r4nRyR5IBHEYb1q0+OQF+uZv1LMQCUAFnAWoo+eLlo+bIvLMOXV2b4oqRzL3Hdm1qinndwApl4ITA2oCUBaQGvM3MqQrAd+Khxs8l+v+FQg8NnEFozYQ2ZbhHfN7hzoUvXd1M+YfgkBVywS9UzFUEUkOG+k3x+uZen6BI67wWSKeoWtIq9doBpxgBjo0lNPPdqJyFx4I6SiBJXHRu4reDekDq0JCMgzLoyv9VF4o/NKNm0BqytAe4NgMWP0fabAqgB6k73VSZWCO7K163dbEjQx5sB7yQbrtn6VFEo1OvrghadJmkQ04YqzHVF32m2TzwvEdF2q3wWUe0ZdFjEXchRgvI/TGQT7hmW9QO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(41300700001)(82740400003)(6666004)(8936002)(40480700001)(70586007)(8676002)(36860700001)(4326008)(70206006)(103116003)(4744005)(5660300002)(316002)(110136005)(2906002)(54906003)(81166007)(356005)(83380400001)(86362001)(336012)(1076003)(47076005)(426003)(26005)(186003)(40460700003)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:10:28.4318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6407fb-9562-42a5-e7ae-08dab8a2bad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
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

Increase AXI DMA transaction segments count to ensure that even in
high load we always get a free segment in prepare descriptor for a
DMA_SLAVE transaction.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b69e0482a50f..43737e0f3625 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -178,7 +178,7 @@
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_COALESCE_MAX		255
-#define XILINX_DMA_NUM_DESCS		255
+#define XILINX_DMA_NUM_DESCS		512
 #define XILINX_DMA_NUM_APP_WORDS	5
 
 /* AXI CDMA Specific Registers/Offsets */
-- 
2.25.1

