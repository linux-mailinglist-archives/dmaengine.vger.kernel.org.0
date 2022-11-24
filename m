Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9663766B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 11:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKXK3E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Nov 2022 05:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKXK3B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Nov 2022 05:29:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9FB97082;
        Thu, 24 Nov 2022 02:29:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jlg8zLogXv+rN4CpUIlAqwaDcBKoTnRb2vl5po09WfiSF307eBCn6FQzjFj1Xgck9RDdF83DxDZOLnqIDXJciz6bua0m2rIDN7AkuQMWSwTA0uqtBXv747pxSGxVyLRaqE0SX4f9ZRHI2AywpDhQGbiv1fgsUiChdWN92V/Jq03RHDlMfKVVSLSruM/FEt7mZzAna5Yn2aIa4kckRG/0TF6NtKoMbdCHgNoiWxlpsKzwipIBuYfuXDGg9Yq+ceRSch1g1ZFJIBafvPD0jEdCqwiv5d9LhBhhewsYknaVPacRXDnaClG/w8KYnxlYEkYuEuZZPCkQAx/LOfnOaRt4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0+RWuwJl62d76Dx8SBHoM93qKN3RwXm5y3DThCMKpw=;
 b=PPcJPXMdPhvzNuUCwEtCfFJsKbsHowmhcdUM0hYLbgm2C6PTQhg4eLO8/VZ1LAN5G9eaDoLN1VGjhdg4H7tsKGoZC49dYrcOJ1kVWOTQeuzTvA3Mgh44wpgQV39Txt+03hwQ3bfLlTETEbaw7im0sCmLQhiOdvJQWgI5qscVoG1jshMhto9cfKsB7PywL5m52r/6kFAfYB3yUTKmHTNxFYptgsF1NgwCgleJGB5bbz2CdHjeRHj4D510VX+djQ1gkRW7LeUf9Pyb0sq8d7DRi13cL0tp3KSrdMr0NKHLyz90sibTsACgOZ0Foctx8gVF59XK1hVepocOFJnVSijqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0+RWuwJl62d76Dx8SBHoM93qKN3RwXm5y3DThCMKpw=;
 b=Z2qaWZgKkSA0ZgxlitnYbOIGtr2ep79/P31soW3QqousFvHAEK1acJezu8NXM6XpqGeF1sUmCCMU8H0bj1D28sQvkZ/NPY8FsFi1O3wmhA1xqDd0bgLv8QoHrx7edLSjtOMVfjwkFZ3hLbgJY0vHRFWKUVnl58+91PZTXsLlzoQ=
Received: from BN9PR03CA0916.namprd03.prod.outlook.com (2603:10b6:408:107::21)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 10:28:57 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::aa) by BN9PR03CA0916.outlook.office365.com
 (2603:10b6:408:107::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 10:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 10:28:57 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:28:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 02:28:06 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 04:28:02 -0600
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
Subject: [PATCH V2 2/6] dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
Date:   Thu, 24 Nov 2022 15:57:41 +0530
Message-ID: <20221124102745.2620370-3-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: b56ea23d-a5ba-4e6e-c412-08dace06b1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6l11WpwIgTnXK3G6FmtZzhTjwKHBXgnn53rauxgIbw1fLdpIGAOd5tPsicypmPTPxyp3v4YVYIweLDciuB5J1Iq5P60Qr5B85N5cC6Va7tgddo/ZxWVZH2gBAWlyvssQpzt5rVX5HWsL4YP8UaYKSr9LA3kFZDJJJQQg/lOhThTCIXYa27Op+3EMFdcUAuLsFpP+kk1aDN81yr/4YwcTlDGktCH07aZbfAXCoc3A8YokLM0KWTAr420xwcfoT7KP/4dzxTGVsNQBN4FY8Z5sysbjWGaIhKouyfBKLiEF1BetywqlgeHjAeYlsBflVJRWnkHcbVuVWuW9pIXXugl19arSnXtc+EqteOfsnNfJgx81+xXaF/xSJKreMaHrhcP7EieFwX03XQc0MiVGw4jybAi06Cc3EALBDZEaUvchoZulEhLkf51wAZy3PGtyM+kSrrFBWED//9huT1hmayg1hMAEnOCCggcJJYshiJK8xkvwEfY8svq1hGsnQmboHe1v+qCxCjEij/dFreUGkdOnYUibWJOX+ayULPmq5PZVwdzSS1gro8zrBZaw9CHkEM0Bm1O8/tJIDpezxgnzTSo5cWB2ZMpDHQUTBGrOArt4dkMuTrWuPRV692a5RRqcTldvx+uxt8vYs35K7ScAFex6T5arHc8j/9XZf+JxeBOpfOOTANxKKTDkPkGlG46jdCwuEhedzr0IaUNoFd4oZ9EgnlvxwsD5exkBQ4GCT/+E/sI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(26005)(6666004)(8936002)(36860700001)(47076005)(70206006)(82740400003)(86362001)(103116003)(1076003)(426003)(186003)(2616005)(110136005)(336012)(54906003)(316002)(83380400001)(40480700001)(36756003)(82310400005)(5660300002)(41300700001)(356005)(40460700003)(81166007)(2906002)(4326008)(70586007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:28:57.4842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56ea23d-a5ba-4e6e-c412-08dace06b1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
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
index fea5b09a439d..590d1948f202 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -52,7 +52,9 @@ Optional properties for AXI DMA and MCDMA:
 
 Optional properties for AXI DMA:
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

