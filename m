Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3448E5B96F8
	for <lists+dmaengine@lfdr.de>; Thu, 15 Sep 2022 11:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIOJF7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Sep 2022 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIOJFy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Sep 2022 05:05:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943F098751;
        Thu, 15 Sep 2022 02:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxkPJXT+BYGOHp/3yLQ9NrsX1BrXAFot74xo2rDjiJmOzAo8RrqF+Ev/zP4DtTMD4mccHVmYoHXCcXMYj2URlUyjtMg+72D1BciVoeOS/avax0WPCK9ONMYJ/R15awdZFG5Ekb85uk3q73+QeIEG8aYR55FZv/N8iKUnSPtrgCw8Ot3vrjfk5GcJHARjeecFxn2ML8Co7d45gvadyG+aeP8zLBG2nIrUxznMPYDC858wGpfI4RGIZpEzOMuEuuwDRoZejgDwvsEBPuLkWhxM8zxZnVUeNQWoEvS+hP/09aOjKiKeBz1WfEipGa1skgDXzpgmHkET4ubvB9z7kQ3Pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9FeJZj+g0+LVBISQhy1NkL6NyJd4S0siKIjIc5GiJw=;
 b=LdpzgO36WmYHel74wlfr7+DDmkDfIpnAiKXtW3m6htWxqlWJLZFpUyr+2OzwrazBu7hJrvnkcEsdKk+ACZGWdVl7rlADw/WOUbfJQICos6EDqmZM5aXn6B0mNkG+sikghZxis6rfUqdwcqS5b+bI8uOAw+llellQbyd9pK0dMIPFMcq+T1bNs5Yu+keB2lwfOYshWDYSzJnghg8ao1a1mHz31IixhUb7QmOX1uX6gaQ1SiPeBmuiQz9wHeVb/uNfN7yGK9Etz5AXlSqWyK551tgYWeIPQvcQ5nu+waW9bOVb3yyUxN+/4azUEh2Q6I07fA77rx5mW8KtdWr3Cq/91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9FeJZj+g0+LVBISQhy1NkL6NyJd4S0siKIjIc5GiJw=;
 b=VijIXWzelbuDh1pGJWj4E8gAbYHKhAqfHQgO3F5dVfisEkJeneSo3fhWqQ/QoYH6kr1Ds25dz1qIfDbkXf/bI3sXlUJEpkRmYh01LLAXx5otKTK37JVame9ify0Vytx6aBca9LbeFUXkB2xTuKKXzrJvMiXPc0LmfU14MTpnx/A=
Received: from BN7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:20::30)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Thu, 15 Sep
 2022 09:05:42 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::56) by BN7PR02CA0017.outlook.office365.com
 (2603:10b6:408:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 09:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 09:05:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 15 Sep
 2022 04:05:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 15 Sep
 2022 04:05:20 -0500
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 15 Sep 2022 04:05:18 -0500
From:   Swati Agarwal <swati.agarwal@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <harini.katakam@amd.com>, <radhey.shyam.pandey@amd.com>,
        <michal.simek@amd.com>, <appana.durga.kedareswara.rao@amd.com>,
        <swati.agarwal@amd.com>
Subject: [PATCH] dmaengine: zynqmp_dma: Add device_synchronize support
Date:   Thu, 15 Sep 2022 14:35:16 +0530
Message-ID: <20220915090516.5812-1-swati.agarwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: a199fd9a-c31f-4440-1665-08da96f977ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCIovtNq0HpCEdHLkj61SLVTI/BH4Hh0TC1WU3Bb+FOngD41DBs8y3qqSFBjlyyhrrhzQHiHcOI2D7JIZCstflZnUhaJo2EFvHuz+JOsfccPale13cU4ZtiDBURvuloitChyoKuMHiir02VEv8IWMuXOPkbVpbafBDAp/JNfZq2Wm5YUAByMghcaqEFx6fx0/aZz3cy/sW8PFaQnmjkw/fWT5x7zOlw6JlDNlULYPPmm9/ujXAc5hk9SpwY2t6pTsKTGdsClyda8EWyYvuLN/j8ctNQdMMu8z2xZAPtxWjOZG2F9yG70ZlMi7Sjf4Um8pVZNbmgOy5evZU7fn6gw+3U8fJ3G/c3YX8cHcPfcco36WHKFDAb09ajTlyum/y4vLdPK5FP9yiOneilq49EMW839AqYIS/VivrM29gVLxUTswLqTbd4Qn9RbBxhJD4gsEvH/y8zfWFHRm8nzPsuZlqK1Df7p0VxWdrMef2NiNx7gtB3HGAeaexDK7+hQyYdwFD7HWJIlK3wxDBXdQc6McdsSnl5V8bJm9kHvgW3T22vqfeX3ISTvPSk/K303v1mhSGvB9PDxo77Afc7GklLNdNxIS/WUYctNjKk9L56afU0Bk6Bh9wLXHMHEHuz47KJZkKh6FloLpzJcuXa74TXJVIqThxW1GB5U8L/HZTfjVOMrv0imKhb5EWhWewNZn9QQ96E4wk0wK9UNmtdqAyJTUvQL4YrOg1Lg70s+KYc9HaciMguynbdyZLhMuuRpy+iHjZzzj0QTIjRuGQ9HwFFWNhIc3BT/UYP5o+J1mjVsfO83VgCHvbKSOAkOTrHKFHsqV9o6MgT9/AiGys1B0E18OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(86362001)(41300700001)(8676002)(1076003)(5660300002)(2616005)(4326008)(8936002)(26005)(70206006)(40460700003)(426003)(316002)(110136005)(54906003)(36756003)(186003)(44832011)(2906002)(336012)(70586007)(82310400005)(356005)(81166007)(478600001)(40480700001)(36860700001)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:05:42.4173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a199fd9a-c31f-4440-1665-08da96f977ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dmaengine_synchronize implementation is required to synchronize proper
termination of current transfers so that any memory resources are not freed
while still in use.

Implement this callback in the driver so that framework can use the same
(in dmaengine_terminate_sync/ dmaengine_synchronize).

Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index a156e5f40fc5..0525caf1f998 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -795,6 +795,17 @@ static int zynqmp_dma_device_terminate_all(struct dma_chan *dchan)
 	return 0;
 }
 
+/**
+ * zynqmp_dma_synchronize - Synchronizes the termination of a transfers to the current context.
+ * @dchan: DMA channel pointer
+ */
+static void zynqmp_dma_synchronize(struct dma_chan *dchan)
+{
+	struct zynqmp_dma_chan *chan = to_chan(dchan);
+
+	tasklet_kill(&chan->tasklet);
+}
+
 /**
  * zynqmp_dma_prep_memcpy - prepare descriptors for memcpy transaction
  * @dchan: DMA channel
@@ -1057,6 +1068,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	p = &zdev->common;
 	p->device_prep_dma_memcpy = zynqmp_dma_prep_memcpy;
 	p->device_terminate_all = zynqmp_dma_device_terminate_all;
+	p->device_synchronize = zynqmp_dma_synchronize;
 	p->device_issue_pending = zynqmp_dma_issue_pending;
 	p->device_alloc_chan_resources = zynqmp_dma_alloc_chan_resources;
 	p->device_free_chan_resources = zynqmp_dma_free_chan_resources;
-- 
2.17.1

