Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90D469EDE4
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 05:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBVETy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Feb 2023 23:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVETx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 23:19:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6413402E;
        Tue, 21 Feb 2023 20:19:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmOIZuZNYtab8eTsXVBVCBrTn4Rfx+wVbZPmTzyjS4DXPp1+euNSN85lcRJ0y3Z32dIWE8/I8DfnIaxFMuZCwquNLlvFncR9nDxOVw2ze+4qRTpIT3HRHgD31DrwL19s/n+HAI44rJzaEWZhwB/ah64eI4sgUEfg26wwXDUARXfTThWgXZcIXi23ln5Pgd6+5/ZgQGtwP6B+Fn9ZIxCr9PkplNP8i1H7z0SXQ2J7PhcMjcOMHUp/K8ZKpGTAQsc+sL/8PUJIFcIKO8DWrO0QWnIV0EzdXrGmKZFYpE0aeKGdgwVmIsQrTvjkWFTSaxCAwM71UrqHBqtfX4cow2acIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEmXFb4U54ZYFM/D/GFM4dFYDO2+FeewzX/HtmQhFvo=;
 b=Ra+7Yrbh70qTB+0bGJ6ET6FD5egLH342laATKkMu12R/fHI/THbWJqN+UBPAFlmulnYiwl4gXgy8WVAhNWh5bNDPcDjspT7GiXKQVAuR+rIA0I0+8QGFBlYo4L2i7yg7Lb4RNsTTzag8FQYMUK9B3UJyv6WR+5FHARJsQpDOhxnlIdCFAuwYSbagKsUPJj8sz0zMcL0VVVQp8RN3PXih5r70j3vOzDxZiQIDxzMWN/POxS59ajzujAHPR4HDwCM6kEsONPEVNoD6dLgrOkOSL3IEKCEb1956VDTBRj/kD1Y9k9+uxVHXG6Q79dYX7urWJkWt7UZ8FfAPFVYgP3ZLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEmXFb4U54ZYFM/D/GFM4dFYDO2+FeewzX/HtmQhFvo=;
 b=KU/9hT55W4B27G4891+UyimHUmhDvPQ6boiaEwoS8gS+SIy2TO7vQPg8sBw51TOJR+Ni59BIKMFb3BVSc8eqUGm28a7z8jSgps13sRzG6pf6tXrRB2tyebyl+qC0eadKLHViRqo6Jfre7ze0dDPI+mrgrIACBi/HP2H1FTOoijs=
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Wed, 22 Feb
 2023 04:19:50 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::f8) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18 via Frontend
 Transport; Wed, 22 Feb 2023 04:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 04:19:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 22:19:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 20:19:49 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Feb 2023 22:19:48 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <geert@linux-m68k.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>
Subject: [PATCH -next 1/1] dmaengine: xilinx: xdma: Remove id table
Date:   Tue, 21 Feb 2023 20:18:54 -0800
Message-ID: <1677039534-50549-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 410b851b-9cc5-4215-fa7d-08db148c0a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BmDGL+WVA3fdnz3XTLTfMLL9aq/Bt8u5SfPQ/86EkfrmarhzUpwgaVqfnEHKbNcZ4WvrOpvzbVWDMLFnkA6HlhsP7yC+ywqG+ZYBpj19AUmyi1HKFUun/H2OrWGl9OKmqj5068IMrzxpMWS7kh2v5KBQeSMuXHrOIndnlFi+5oqubcyw50iGVrNgPR1NXi0KN1xSfWKlEql0oTmtpwGmKxxYNrfPTkfCaaVRy9qmI+inZcKUzMYvr1q3h7nYYEcZ9pt9Pi42qwIj/JpYYvhfJe0O6IGlfAoNUQZIqlqzCMR2gL3UIVRY4lVvhDBqpFhE/iO11h94i1KlkrlACHcCVUspDuyUPH+2gp2nH+o0rmdfL94shb1FGj9Ep8ckeOrjRzS3z/qeyx9ltQ7wYO+lnTK2WYbK+RRXGc6QCnYryv4f/NWO7h7Fmjq/AlStUbgI6xg3LOOz3OMCvEoNcGPYm9THoL/obZlF3dFp0OvV09xsla7LFCD1iYX5qyDqEgTj8W6nkfQfTLJa0ECKVGZ2FCjsrXwTsSQeRIrdgjubYpIoPU0EU0Ea0QRn8tAJemM6JicynRymyfjGTIqmGY3z6cBIOjhOHYASEnFWVrjR//oGIT6PJ8kTjG9Z4wM7Wge0DClkgmxBapJKDqzW41dJX0+PVxnP+m9xKzoKvgJpKigX0GrqRZmrO2YJ/Mk601PWSEXkCrpHmFKzFoFwyOvdWYPyA+vdPi1eQN6XqS8jpE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(36756003)(356005)(82740400003)(4744005)(82310400005)(40480700001)(8936002)(5660300002)(86362001)(44832011)(316002)(83380400001)(54906003)(36860700001)(478600001)(2906002)(70206006)(26005)(4326008)(70586007)(8676002)(6666004)(41300700001)(186003)(40460700003)(47076005)(110136005)(81166007)(426003)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 04:19:49.9515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410b851b-9cc5-4215-fa7d-08db148c0a11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The xdma_id_table is not needed, as the single entry "xdma" matches
driver name.
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/dma/xilinx/xdma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 462109c61653..74e587adce13 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -953,16 +953,10 @@ static int xdma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct platform_device_id xdma_id_table[] = {
-	{ "xdma", 0},
-	{ },
-};
-
 static struct platform_driver xdma_driver = {
 	.driver		= {
 		.name = "xdma",
 	},
-	.id_table	= xdma_id_table,
 	.probe		= xdma_probe,
 	.remove		= xdma_remove,
 };
-- 
2.34.1

