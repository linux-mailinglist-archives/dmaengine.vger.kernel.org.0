Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8C60C594
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJYHmn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiJYHmm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 03:42:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930C15A315;
        Tue, 25 Oct 2022 00:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV4+2BsrmFbG42op52WZpz/ZG9NZyptW72vCZ5sviprpJJeqrnACse7PnHhh/SeEBoWEG8I9hwKxktBGqWXJGtOCcTGQ/92wYeWpttIZUMxpRlzem2+1r9+75C1MN5d/nMrkubWJbjk4D+a+T/fkl3SIYTumJUycDB2DJBikTUiNRsvAFtJlVSDndpkA5CY+FX85xoTHBqHV0kvr3rSCG34hEo9dhiVdPJKELQAY5yWoDTGdHg7olWDTwbUpgCU3f2V3a4VhlObLJGqxaaVypNAE4MYL5+IHny2toUmitQJGkrJwuRilkViG8K9cHPqeDYeR+Hr9pf6jFKbo8AG29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2TzToUFi1HhLvKI2SJAzs8KeV9WjY87+qwa8hL/lFE=;
 b=WHP08dVVnVSiZuHQao/UCtestcZwEU+i5YFLflANjp7syq3CZAjl4RfCFhbKqPfUMsu62ZPq8O4IKGu6ljY0WeOmrKuawMvUgg5jMyM2vtdF2n3Nagmc1jw8N5EXV9aNDDMKDpMOQigUjnzGPLsMBF/nQyOScKBx3uwpw8gj/BIPgC9jWuuzIxrTuOLGUGfnmcTSGPaaAaVcEJivb8/PCd5/gob686yzEhH9wgslyDnbL1pnH5qTT3kvkBoalBEt1hqE29/85y/vUxXhBAFWRIxLVmfkOC+d5ecqY7eRc365PPKOLGXKEJU4Kan7pEmXbTaQ9Lvk3F+7dw3FBu8w8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2TzToUFi1HhLvKI2SJAzs8KeV9WjY87+qwa8hL/lFE=;
 b=AUYOtn4vtHBLEwwfgXz9ngbfHhoZS5QIaLcaYh9TV/ougUROp8ooXW1s4KSmOrYO0oXr8LKP7SOzOTydd73lxQyhneyKZkITfLbSsc0RJ4ADGQXEWE0VVNv+D/8s9DpYP+Dn4Y9YPd3suA3mcEunIqp9ZZaCElv7Ed56n+Np49Q=
Received: from BN9PR03CA0921.namprd03.prod.outlook.com (2603:10b6:408:107::26)
 by CO6PR02MB7777.namprd02.prod.outlook.com (2603:10b6:303:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 07:42:38 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::e) by BN9PR03CA0921.outlook.office365.com
 (2603:10b6:408:107::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 07:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 07:42:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 25 Oct 2022 00:42:36 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Tue, 25 Oct 2022 00:42:36 -0700
Envelope-to: git@amd.com,
 radhey.shyam.pandey@amd.com,
 marex@denx.de,
 vkoul@kernel.org,
 lars@metafoo.de,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.3] (port=50957 helo=xhdvnc103.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1onEa4-000Gu7-2u; Tue, 25 Oct 2022 00:42:36 -0700
Received: by xhdvnc103.xilinx.com (Postfix, from userid 13245)
        id 39CC910550C; Tue, 25 Oct 2022 13:12:22 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <lars@metafoo.de>, <marex@denx.de>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 1/2] dmaengine: xilinx_dma: fix xilinx_dma_child_probe() return documentation
Date:   Tue, 25 Oct 2022 13:12:16 +0530
Message-ID: <1666683737-7668-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1666683737-7668-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1666683737-7668-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1NAM02FT048:EE_|CO6PR02MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: b7264247-fe8a-475a-99a4-08dab65c7ceb
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E02cq7gS62MsVhnWATaa3q4/aVc+7aeq84hJwIdqkCp5DGq1+iLuzhxa3xWUXOCq1jvl2bUb6XIss8STfeVhKtHlwwkSghwRbUGC0yBrMTLVZuZrGkX1lzgU9vL7wj2l1eT2q85tgDCUDaMeqIpfYD8wFpVJ5LIQ3gksp/sgNwVK9H1Ne5fbeT+IANwgFme1od1pF5szepX/DMJnykvtC5sAmSW1YX8JL7qqnCmxNq5G5Il6p3iXhGvW10OCpVJlqxH1b+Qg8BrYn/ide9Fe9E+IEXQLMoouBpy5MxbX7NgEnlYgrns2lVTMrdzgug/5I1pOwRitawHhck4VjtPoYsJwQVtXkdE7qpoi+HuQv9gSRLeQN16wmJuJj7SYcFo6vMfp3t71Xzk5B6PBFSdNSuN3lQ0GY1lCEueCxKNuUxqtSNhovzYXs9abxde/l4Mq5tav4mQM8AA2rw0WjqHDOqkzfmQArN44Zf+HTomKH6QlzRtdJTHOmu3kRNT3MLF+kbNMs7MeTkILpGk63qtcnkOxfOKFxY0nFaKdJLqBEl32VhowpmX6K+X87/8+MziX0eybL3dWeliTsNKzsbApRJZ85xI4BG66noOxs8zQKvauTzcPAuxEWaIwASU9GcnsijGZECs62TEHKW6ATTPhfLO44gKV4WbyIAKt5BasomLFDUdFdlo6e63fJah9P8tmdIAC5v/Pev91ey7TBot43+owzZL9nKL2uiN0pCmIOwkJwoFtY6Je0MtJj7pLS2mmapY+suu4EetkWfwQoi6db6D9zYr9Kk84sSigKB7ZnoY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(6266002)(41300700001)(26005)(8936002)(6916009)(8676002)(5660300002)(54906003)(36756003)(4326008)(70586007)(42186006)(6666004)(40480700001)(36860700001)(7636003)(82740400003)(316002)(83170400001)(82310400005)(336012)(42882007)(47076005)(186003)(2906002)(2616005)(4744005)(356005)(70206006)(40460700003)(83380400001)(508600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:42:37.3533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7264247-fe8a-475a-99a4-08dab65c7ceb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7777
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Modify xilinx_dma_child_probe() return documentation to be inline
with implementation i.e. can also return failure value on error.

Fixes: f17e53388e82 ("dmaengine: xilinx: Handle IRQ mapping errors")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8cd4e69dc7b4..3b8cfeccf2da 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2924,7 +2924,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
  * @xdev: Driver specific device structure
  * @node: Device node
  *
- * Return: 0 always.
+ * Return: '0' on success and failure value on error.
  */
 static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
 				    struct device_node *node)
-- 
2.25.1

