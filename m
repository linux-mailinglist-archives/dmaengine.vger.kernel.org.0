Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E064C637674
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 11:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKXK3d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Nov 2022 05:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKXK3b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Nov 2022 05:29:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBB2C0532;
        Thu, 24 Nov 2022 02:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTj527pofAhjb/cTWU8oNyNHYTvBRATypV/pgfgDISzCIjFauaR4Uv1qDdgdyy+dw3T8zBV55GUu0Li21c+AjaoMDtiIoRx6kLdVcMmMIYT8Uul3OncshQbXOwpDHKF9A52PHGMoErlQABICUW+/Noy52gdSfJIdJtLFjbfYjBTWpdFcWwqaV1yOTkjWvH9MSQ8fEdAFFN1Zp2QKejxCfqG7v5XH+y5vz+bkLaKVLMOsrM8Y3vcLy7Zx7fSyheruaT/IDTkAnJNzLPDLBsuFueITF5brC5IFZIFyI1HTOstuXWZ5ooIGfjsRxjvkgfWPox3Iv8Vcz0sv7rWhaewGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHxK1Ft+ONeIi/aaMf2yOaMWGf27wZEBgx9HByo+Lwc=;
 b=csHkE9clSOEFrsnwJ3lhWFISm5wny3vdNBmi5gwjDIMhTYXGwiqigPmd1hsoIE+VtdKCtF6VG2S6FQbITGBMhIID0eJmZSyfiwsA7emkKsag8idjPyHKaS+6Oe5cq9hGFQ99JbWQaPhpqvBrFSFLUlxo4GjrpNYYNebxf3HOjt3NrmAtrabkUt4JrUYvzR/MvIANhrGb9WqiIV3f9YZkrsXF//kX0pPDKrqrbGJn4QoabB7Aog1U1XljQHA3t7TKj3akhiIF5ZlcV/wNws9Bg3rY35/q3jVF34O+gewb1wGc1vQMdyG7VX0xLNsjMFcr1K0wblJ48BvyteTEc6nmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHxK1Ft+ONeIi/aaMf2yOaMWGf27wZEBgx9HByo+Lwc=;
 b=OGITD77oeMQYpvWX9o5yx21jyU4ON72/qlkPKT48JXHFp8I4Q1tb1OEticZ+MVWj9NhXSDxXtOyU9GWWOX1GIlSq5VRrk7zjjtsGTClfU44fMe+PtXPaiq5MIsJCRY7976NTnAaPkFvpweP88KEr4wnmWBW8kQGbXr9EU0PpM74=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 10:29:26 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::8a) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 10:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 10:29:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:28:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:28:56 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 04:28:53 -0600
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
Subject: [PATCH V2 5/6] dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical usecase
Date:   Thu, 24 Nov 2022 15:57:44 +0530
Message-ID: <20221124102745.2620370-6-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: c99f50e9-1e41-4c83-8cff-08dace06c31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E96yBKXUt9oiS6bQPWzWrb/uxOENYlYlUDrc9NZvHj4jXf8vxIJGV0+nMRYrxP0xpCIHxJYxh4IFwQh8Pi3FBbjNqGsr4F4NO4SPXSge3wAllGlLvNRmFx4hyrrZ+9Zm3zMGeXFgfTqVF1xHyMngiaw5hBE9r5MSz45takoINqLp6Xtw0DbKJj0WMtDoVtQ51R6l+pVhl2y0HmM+WgsoN0qFzNBxRhWvub7MVMQ9lUdiEm2o3mRBtzNOEE5sT/MQ6Ua3Dvh4bLxqwQ8GBgkhVNevs57QrRZ5xUKQyPLlvMNKonmJJ6vSQs7KzafT8Oiwa1CuzRnJc32rG/jt2DJn++wVDsQHDqZxOE0baXSN0gLKT0MJ5Ij4A2erMlikOyzE133dD2SQ76vx//1ADsGnH9ne7B+z7+X2t6u6kDmgT0Oru++Rrad0B/xx5pMm/OKb9KAaqcaSxGzbsqUpVK1aYcU4dALvjRE5wHZolCImuyvjIiukR9qC5BTx65XaHx+cbwKq1RrO+XiboQ5UO/BIqmy5jcDOhST4HOA/GI+d2iU4Q+zRVovPprbrJjNsgNQfkk9aYxQmjHmiaqBtI2cRBi2C6JSckd7zP9hWor5nYD8ThxD2iSCtyDEud1rWxk40ccVBu0tJisUmwwVvzhFj4/X02qQnDpcCUcgMAbx7QmRDzrLXl192ypJrrqlaigHOQDdYiHdDsff6335EBcSsJ9Ch1nUk1i1cMzbYihuLnyk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(70586007)(40460700003)(8676002)(316002)(82310400005)(83380400001)(5660300002)(4326008)(26005)(356005)(6666004)(70206006)(8936002)(36860700001)(36756003)(478600001)(82740400003)(40480700001)(110136005)(86362001)(4744005)(54906003)(41300700001)(103116003)(81166007)(186003)(1076003)(47076005)(426003)(2616005)(336012)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:29:26.4209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f50e9-1e41-4c83-8cff-08dace06c31b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Schedule tasklet with high priority to ensure that callback processing
is prioritized. It improves throughput for netdev dma clients.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 6780b1c21414..ce0c151d8f61 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1839,7 +1839,7 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 		spin_unlock(&chan->lock);
 	}
 
-	tasklet_schedule(&chan->tasklet);
+	tasklet_hi_schedule(&chan->tasklet);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

