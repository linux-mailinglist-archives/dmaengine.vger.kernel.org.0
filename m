Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8861098C
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 07:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ1FJw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 01:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1FJv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 01:09:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3043B13DCF;
        Thu, 27 Oct 2022 22:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6xXqnDAUY28wa+GXsiPgKUJflXTGph2b80CVmqsKsutiUelF2HdGi6NVzCof71dXFf7uU7bfDqN+6TzgTmKeYB5mz9EZM45SCgRp+00A3WWmqDbNVATPtxJY2RVe7UREXwmqhFjBq8yEGkM0BkPhSdRgW0Ku5qT+AaHUa88Aqjd1VCn4x1YW42zlfep/p0rggItJ/+noDoPIyWZEusKa35YtldCo9aQmT8NxVRljlwO0XSJij6G9Dl6Xp036c5L6XDuBBNpQG4E0TEmaU1PcmeSEipDXolKMLdr6lSBd2T2HNlmqyIWP/LFTiUmphHvJPWwyYoHq4P7zcHZ2zi39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU+5zjSrk414ddhcpz58EiPfYp16nflE3OXJD0CQ4e8=;
 b=nLqVyIbXPu2KZztcEudS6Da5IX9YELOukBvUp07W5gYkzd1AMTrLfjkIRaY/TilDEpnZv+EVxMXCI5o/n5cGY7NxshQD1JUU7nsrtKMnHLvZ0sarp8fUrRFqVhwHOvcSTI3qbdFv/oPg3dPh5BULU5hHzhc8APKCV9qignh4HmH92muUGl7FjOMMmAOFJ5sapWjG63OWcCnOx+QrzPpAmwHtMc4wGG0vdfoq7XYW0bWgbR4JK0cmWOfS+4vqiiaWiHXix0cg0dLsOlMD3D3XcaaM+RDTcKsuRPeKCfAMNdSr8OMXccI1tYAaVciGzpWZryLC5xpLFNn0r9TdMn0/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU+5zjSrk414ddhcpz58EiPfYp16nflE3OXJD0CQ4e8=;
 b=uHfIM5eleao8N2+B0ekVHdtB7F1ngziuuFFUQuOf+hJ3AQZi/dHYNOmKWlLgiy7thZBpHKtiIffvdkriZLgQc8r789b4qeE8GLHkxrce2m+fUvpf9SoQjWk8Hanu7ZdEniLNgcxEX+yXNyUKuf4J/vFCGx3PXwIf4H/FmR+v7SQ=
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 05:09:46 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::b) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Fri, 28 Oct 2022 05:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 05:09:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:09:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:09:45 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 28 Oct 2022 00:09:41 -0500
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
Subject: [PATCH 0/5] Xilinx DMA enhancements and optimization 
Date:   Thu, 27 Oct 2022 23:09:35 -0600
Message-ID: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: d14c0224-2622-4621-b8d2-08dab8a2a1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17SHuxuJLdVGBJJe/p5VreRfKM3aHOZe4ECY1qdrBdOQr8mdQdLI3hDOJoLfLHkJ2Nkd8x77P/Afz8sb8g40GBES61KR9umSrf1LR9UjU22rDN4xVGw3YY24Wpn8KJcgyypGqc/UbfvYP+sG6wjdvTo3aMo0eyDZRkAYIuVB3ZCiHLoIyocBhbRhSAtklDTFAq3CSpLk54JIRfh0WngntFAKoneLVFgN4QmE9GBqMrWp5FgQPLqKPIn5t5tPkm3kjxiVtw9whumR14Z0yITEU/gIK2T5/MEtbak1JK4AFwwzy8avOl/0QEgTdU88yqZkhU7C+VEAEilfDliI0cbrJAFvfCWk/Hyyqd8M+QzNY0t6xTYgClvWw5uoDg6ONuaQO0sNjfPCKvzNgH3W8R4/NFLX0LE3JrEo+SkGN1T29SIC4kjDLP1k+1H2rJHFPlnQHRuwjfnzl0fZGXzHfmFAkPPUtO1w2A41NSGnx8SqADRJ1Q7THCn3kM4bb488Vs8t3g6znI/8qy4ClPsQs+lnbETTOWe/hBb8aoTznPZ/H3M4VbtJED6iSUQpjq4bKnfYy4FlBnVHuYZPkDc1xE3oNAWCzIq+/DfjkOcXy71dpH6Tabg/E4muuds5yz9xsA+iRkC0yCMa5N4mrCnXiOSINI71NNHcoxRsplwr6g0RK9HaD9TcIh+NQQSOOVQaN3p46n1zVeeTJMf3VzqA6Ut3nnEJsIWJQLkdBiOOVxPoTx5kCEj4XVnSInGmCim1k6mylXBKB4qYZWHLFlXqrZOO/d/FWtSERFn74YuJRtw/DLHOOvL8NdQXQoq6rp76OQbi
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(1076003)(54906003)(83380400001)(316002)(426003)(110136005)(8936002)(478600001)(356005)(81166007)(86362001)(47076005)(36756003)(26005)(40480700001)(82740400003)(4743002)(70206006)(41300700001)(6666004)(40460700003)(5660300002)(103116003)(4744005)(4326008)(2906002)(70586007)(36860700001)(186003)(8676002)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:09:46.4049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14c0224-2622-4621-b8d2-08dab8a2a1c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
X-Spam-Status: No, score=0.2 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some background about the patch series: Xilinx Axi Ethernet device driver
(xilinx_axienet_main.c) currently has axi-dma code inside it. The goal is
to refactor axiethernet driver and use existing AXI DMA driver using
DMAEngine API.

This patchset does feature addition and optimization to support axidma
integration with axiethernet network driver. Once axidma version is
accepted mcdma specific changes will be added in followup version.

Radhey Shyam Pandey (5):
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected
    property
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
  dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
  dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
  dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
    usecase

 .../bindings/dma/xilinx/xilinx_dma.txt        |  4 ++
 drivers/dma/xilinx/xilinx_dma.c               | 41 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.25.1

