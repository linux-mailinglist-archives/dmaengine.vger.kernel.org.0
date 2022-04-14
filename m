Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE147500D25
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiDNM1D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 08:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiDNM1C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 08:27:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E8286E1;
        Thu, 14 Apr 2022 05:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmkElGjh/WWTBRX0U9HBF10rPpP+TYpUUrkdqWECxEYowQNCY6KAyTUA0fSM27mec6i8kpUfM+xgrAvkA1535SD6iE/YlfS6GhrKlkGESijOHcIyXy2QxknXmumbRC6P55AcjQhPBByYgstvD078HHDFIdIuKvlwapsHZtO9mO9tVS6j+sZG+/neOmUfOlgiuj738e3/fB6AF4NSFdzrm20ziXGbxw4h3/wdrzyPeEwARDRn3hCt5425qGP9tFxApxBwFvNmpIAA4TQEoL2GlETyzVyKEoz8mxMcojjSye1x+lHmIfGvXSNS73GKHx4kqy5nfHwiK0vTa037IV4eJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddq+j1XRQJK7pIKJcbZKZMT4tN5Uj/7H9aRm7PlQXWs=;
 b=JVSY+jlsgQl2mGkd+2wrXC66N+8phV61o4JP/4yYGf1Q1Yf9yjJbJuXeIejVHrbzSlMhd+aK0q03VMX9hQX5/aHDb/EEcyRAy2U7NmJ7b/M9M9FIGB9nXuba1J/X3dh3RIXZ2AfTqJkGvk8wwxB12HpKTx+ygoyx7Jt0b9D7usNyMbFDW6bUlM9JghfCS+N6KrM+6bjLUNa4XKKEhnx40lzwwSL62X9opTLlR0LRBXSWkZCnoNgh8AlW16XrpdUasO+Bw04zQs1uk+0K4wAJ17IysWK3lBjy95ZJNzmJnq5sT4Xobmqc/CfC9JVNr6KDnSkgYkxUbR+f49kMGYeZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddq+j1XRQJK7pIKJcbZKZMT4tN5Uj/7H9aRm7PlQXWs=;
 b=W+CZM1QDv2SDlLVNx4olRKkT5bnCpEaQhHQ1l19ZClN3XOdspg7kGc0KmreFJ36Bzu/+jkiv/4DNjud/bjclVOdkufUAmRatN1kp0p30bwjIdLU4EtSSYDwAgwya8iZjBdbVoyfyHKwz/h2ADS87553+csQRKCFV2w6HkEz2LM8=
Received: from SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::7)
 by CY4PR02MB2263.namprd02.prod.outlook.com (2603:10b6:903:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 12:24:35 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:124:cafe::27) by SN7P222CA0022.outlook.office365.com
 (2603:10b6:806:124::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 12:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 12:24:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Apr 2022 05:24:33 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Apr 2022 05:24:33 -0700
Envelope-to: git@xilinx.com,
 krzk+dt@kernel.org,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.6] (port=53815 helo=xhdvnc106.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1neyWX-0003df-4J; Thu, 14 Apr 2022 05:24:33 -0700
Received: by xhdvnc106.xilinx.com (Postfix, from userid 13245)
        id 5C97661054; Thu, 14 Apr 2022 17:54:32 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <michal.simek@xilinx.com>, <radhey.shyam.pandey@xilinx.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
Subject: [PATCH] dt-bindings: dmaengine: xilinx_dma: Add MCMDA channel ID index description
Date:   Thu, 14 Apr 2022 17:54:21 +0530
Message-ID: <1649939061-6675-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7647f3a-f5d8-4ced-465c-08da1e11bc46
X-MS-TrafficTypeDiagnostic: CY4PR02MB2263:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB226321C1C88A22AC3DDFAB91C7EF9@CY4PR02MB2263.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qO7dFrQtZ5ZJlvVt+qv6bT2ksG8z/3BcfwRM2Ce3ib8f3TCyI/bkYqy5I1QkaRkbaHDzQNdjNQffP79DLh0IObt9w3ebZNgNvhgmW+Lqmug5P7mU/jsKb2ftuD0N1GKvNuZXG8AKjqt7+dmIAq3cE9t4kEjdwPIX3ZBclQTPq14tcxS/ebkSCFuwcn6Yz2YKh0zeflSP93DIK2pyEoufjYy6fIw9GodK6lxS9vD6ejKEFPlKW8c11XbpEImEf819il1xUp2G3NuOEkhqamkB02nKQCA+/+aHTtp0v7XsYC02z0eZkpepRk1NhLprw2tfQFbxIo1YnZR6nP3dMLn3JY18hgS5gFBTCMIE7IcMacmNavjbeDqTZOqTMHHC/njTjiiVSgw/2AgDSO+tk0y22LSmbPudF8xtI0Z32ZsC3JsiLcNc0mu2DojyKfK6oYmwEYV3aj1OVfAR/c7jJuv2DdZtuuhcBRhKRrTNJ7LSIgL31Wq3UTjXQ5qodxwf9ilqGScL/VsaabMILK6Z3cHAj+wNIcBJIa5a7EvRMZPjV26Q0vAW9oPuk6ddC7ICXcsfldQTNhTa3YVsz+614WW84UlDuC/Vj1h9d8DMSaWCLm8tDfVlhOPRc+k/QiKxNnKvdZHDtGkbSWMWAvisgf0pqARa0lXviouhX82u/XYK5hinFZKs+hnxHnFB4+XKKLNAw6Esq43OhUUyt6PNGBAKzQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(6266002)(426003)(8936002)(508600001)(36860700001)(8676002)(4326008)(70586007)(47076005)(70206006)(26005)(6666004)(5660300002)(186003)(40460700003)(36756003)(110136005)(107886003)(54906003)(7636003)(2616005)(83380400001)(42186006)(356005)(82310400005)(316002)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 12:24:34.7564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7647f3a-f5d8-4ced-465c-08da1e11bc46
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2263
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

MCDMA IP provides up to 16 multiple channels of data movement each on
MM2S and S2MM paths. Inline with implementation, in the binding add
description for the channel ID start index and mention that it's fixed
irrespective of the MCDMA IP configuration(number of read/write channels).

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 325aca52cd43..d1700a5c36bf 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -110,7 +110,11 @@ axi_vdma_0: axivdma@40030000 {
 Required properties:
 - dmas: a list of <[Video DMA device phandle] [Channel ID]> pairs,
 	where Channel ID is '0' for write/tx and '1' for read/rx
-	channel.
+	channel. For MCMDA, MM2S channel(write/tx) ID start from
+	'0' and is in [0-15] range. S2MM channel(read/rx) ID start
+	from '16' and is in [16-31] range. These channels ID are
+	fixed irrespective of IP configuration.
+
 - dma-names: a list of DMA channel names, one per "dmas" entry
 
 Example:
-- 
2.7.4

