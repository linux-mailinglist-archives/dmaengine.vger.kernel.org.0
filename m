Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A148063765D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 11:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXK2F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Nov 2022 05:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXK2E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Nov 2022 05:28:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D177742FE;
        Thu, 24 Nov 2022 02:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbY88Y/L4K1cQ38K3e3EuYhvzZVyBhe8o87KGvrhoLe0ZPkLyVfEwTuw3gGyuaRSVvJBQYugggniMocGtA4vZXM15Yf6iWwYQxb61865RmOkPeLnLIC/ANvBGT8Z8Im1IYwKnhpl1jdlwMtWHBBYSvT2H/dhLmyd8r8hGOhiCzby6WL0Rnhm+qKv2h6QDGAWFLzMGlj8ZMdLgqFX+7O+8Q7r391TPmBD64109NQKj52lK5trUCSEcjEus8PSBt75FpPYqJ2DO7dtS5V08k1t1VYS6sY8jbC866WWhU/w6BQanKgs/5rQq1A5YfZ4vfQ91G2emuWdiDM0Qn1T0dYGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfLKqGKQx21s73uJYkviSoidiVp52HjmF2OkL3UkRhE=;
 b=dlEJvrI3y5B8B3dx8PxC/ht75X0Onpyr0NoR6MSOWj4m58CAfVespbR0Gi0O+UJ5f46ssPnbSYC0g9BMfcrz3CrXbAskMfrqNpGAOU5guEPL3vBMqqWX/QNV8YNTlVENFMUliKtkejM4z5pL4cqJYSdtb56fTNChlUffLGNlYUIhsNrkScpKgOyXNSAIkgDZlnXdRLJoFdfnLbr8M5pO6/LWv1gf06v+tH8IDihG0sJT6M6E7ZDNIFI1YqJfoxnARzMUwhfBBUn8WFf9DWAnnYwXcBXd6fQzHatNUrDqnmTM6gY/3FjOWJGmRqz0zLh6AaXyo455SG85C8hOomGv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfLKqGKQx21s73uJYkviSoidiVp52HjmF2OkL3UkRhE=;
 b=1fiFRLRmDmpgNYwfEZANemc9EJnIwmV4BCznl7xeP2GOpEUu+w4KXN4yeOjW4W0E7UJ3HNWw0BiL+Wlff/ko7vAIVMT5vxBqT2R6fOewVsYViBL+p7me+PhzMzAsTRsMhhP9Hg6NmWro48w1VIJv9gB20OyLYJrdGlQ7kxGXVQ0=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 10:28:00 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::ac) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 10:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 10:27:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:27:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 02:27:50 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 04:27:46 -0600
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
Subject: [PATCH V2 0/6] Xilinx DMA enhancements and optimization 
Date:   Thu, 24 Nov 2022 15:57:39 +0530
Message-ID: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3f9d98-42ca-4043-8da4-08dace068f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGsH9S9+mQpyEXcwTV3QfiaRCPM1dw9SYDiKKUiXNgR2bmanNvDYBO2RBiPv4MZxHI6l8S6sE68TV6InfJVhWrj7Ne73fQaeoSYNQg4ekPOKZF7G9gW+qK6zkiVst9HpmQ6ZKDNsI9a4KRdGE0S/Vat2hBgAIzue+TvC+jYHF3NcBj6l7Z3aPS7s/n1NTalZaJu6cf6stHN7/hei/wJMh/JSI26QyQJWE8oDhs0/NSwK8qSxPnGctcSDWTNLOpzkRCjRatixQQW2t3m+PXu1lpL0OlE6tlwJsSp5Uff8w7NkOGwmnoQkco3KeX9vv5waMZY5cz8pEJHrWYf2Q1k1qupHW+fe4QVjqAF7K3A5/b6zDlIkbogorS8V3nNc2ymiLhSo0+NNTEJjL762ic7CUE/Id53ropaDNVAJJmMasqrCPmp5/NoAfIEp52GHuzUyrfgan3sdjfiHjWsl1MgXzijeQSqQN645pMlP43wUclonkF95Al0ONoXWt5b0C5MD7Mromk7x4Y26Zr239C/P3l4lJW6fc2v0naAmXVHZQXEz/n+9NJKVQGww/sglWQIl/T2BKvG2nnN4vb52BYF5qWq06Kuv0si33Co1rt8Uz96xJwb5YxU08mUpFMz6qSDSzpODBs8KwtiwD0xp28F5HtkDo4Yt0h46I6LgERR3cHeRJm1CQVyyuBC1pULZPEa6ie2RBdKOxE9pCoJI+/jxQfajWzCVWowgc3X0kQc4s7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(426003)(83380400001)(1076003)(2616005)(81166007)(336012)(82740400003)(356005)(36860700001)(40460700003)(2906002)(5660300002)(40480700001)(26005)(4743002)(186003)(41300700001)(54906003)(8676002)(70206006)(4326008)(6666004)(316002)(110136005)(478600001)(8936002)(82310400005)(70586007)(36756003)(66899015)(103116003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:27:59.5838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3f9d98-42ca-4043-8da4-08dace068f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
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

Changes in V2: 
1) Moved xlnx,axistream-connected optional property to under AXI DMA.
2) Removed Acked-by: Rob Herringi for PATCH 1/6.
3) New patch(6/6).
 
Comments, suggestions are very welcome!

Radhey Shyam Pandey (6):
  dt-bindings: dmaengine: xilinx_dma:Add xlnx,axistream-connected
    property
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
  dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
  dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
  dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
    usecase
  dmaengine: xilinx_dma: Program interrupt delay timeout

 .../bindings/dma/xilinx/xilinx_dma.txt        |  6 ++
 drivers/dma/xilinx/xilinx_dma.c               | 61 +++++++++++++++----
 2 files changed, 56 insertions(+), 11 deletions(-)

-- 
2.25.1

