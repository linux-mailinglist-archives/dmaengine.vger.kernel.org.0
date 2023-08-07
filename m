Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E77719A4
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHGFwy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHGFwx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:52:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE489170B;
        Sun,  6 Aug 2023 22:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1/r/6/L2Nm6OmP4o3BT2qUE0qrGSsvjAuqadRYvy37h0hLVkn+AEtV7YQ0Ouu45+B4RLU2KkjMWpGG9CJIkxX6XVoXh4162L8oXdARff5KIno5HdD2RvKchzRdScX6Ut+Lo9Zz17h7djeivDd5NgdmpZJ7HS+pyDqMPt/Ryf1ZYak/buDyhlx87Fik0w4ZcS/zW8uaLWsU39bHHQeVBYhautLU6XVcEhNTF6MmojSNaIadjsA04S7Er17gokupUIvbXjVOCI06biMnNTgwTIfDvU92U9LuqzY5zZe1lfCJ1Fc9P0JWLHwFWg3sNCaIBbUQUWtaUF2FUlz/LaEAoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OieXksdWjxEWShSwdTIrHnqGCRT91Z5IVj6KjeOSkA4=;
 b=HPa1x2xMWwtPd0qcBBr43LPhMY6vOSlN+z/Mo5G6Fuv62SOrGC2OJiHaOyIufroyay1YzOQwr12+9jzcxUyhlKxeqeuf5AMXLwyLXwkWdW5aVv2sp0ekXFUCZLjmyglfCejyyrJMRqcYdFMIFgQWg6t8tgFEvuQ1dEDBu1ZXliQs3LnsJJd0TPWAqtvDIJqf6XRLJxKgjx8OEwCL9ScGBiwP/yrhu5ULBONrjUuka9f8DDY3VbTXv0CHrVlythy7IrVWxWGdRQk3vjirzhQlj62SKFVmtWQ8SzU3pSpeZdlnxbZN3O7Gbqf95QjuzPVaFoWbAlB0+ZSZUnq8JdI9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OieXksdWjxEWShSwdTIrHnqGCRT91Z5IVj6KjeOSkA4=;
 b=Ko8ez+6Wmy6S5Ly9gBW+GIcU5XniqrohFeleIY2ock2+/euYDUXN1j47dYlcJt6diCsoAjCZFENFYkwkSTeSFR+/k+zbfwOLUzlbZ52XL+KWMNWeXz4DkitfC6BgJPs3gKiZY0wQ4fSFRDiNl8t3Gqbr3yz+y1/vA7FwZRGoO5c=
Received: from CY5P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::16) by
 DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.25; Mon, 7 Aug 2023 05:52:43 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::95) by CY5P221CA0047.outlook.office365.com
 (2603:10b6:930:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 05:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:52:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 22:52:14 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:52:10 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 01/10] dt-bindings: dmaengine: xilinx_dma:Add xlnx,axistream-connected property
Date:   Mon, 7 Aug 2023 11:21:40 +0530
Message-ID: <1691387509-2113129-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 95836797-2b7b-46a3-a4db-08db970a848e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/yXmZEh9TfRHpZlk13K+ugy+qxDFmi54ph5TEhyuMbxCJtb7R0q+Zzb2GvkSSVhCj2qlWXwjfRVJoEtj0CGgojUIesm5cXZJDViZ6W3AEIXUKpsPjqhJ53V1Iq3/8jb2xiPnOwaXZH5rNHKiq67mhwxJQrdU4EM2ZWcGbT2XpOd2VXO6TLogD+lcUjBzpTMO3KSAaIvuEFPDMLiz3QuJYrpoOvLAdr5OTeeGgksjfpXJUwYPDPXw0gRhKX1VlFsJgayoUoLe8uMMcpp9Hyi5eC1qXK+T22HxbIhDq64XLQ2hyZF5N/S8kpJ09Ivvtb94Aajb6uJfp4OK6oQvCYTCqWzMyNFDckFU0NkI5bwb3VjvGmUaC4HeFaeJbocrbI6twrvg0aZjDMgUL4M4IUrrX1KWGnxvrXt2bLRdhY1UiLfAVNbZ+8GMviDtjKvcitkBjdyD0S4mjQVX4er2gYWJ0T4GZs+Kcy8AGznno20X03/rjL9wQmqSPWojvN/MRBYeSsaO7BrUOhjDIxVbHCKnYKJKmTZNnufeDlA6ezSSPAXmU11DI9HkQbsaJh8fge0qsJ8f46d09/J+dzhx89a1fO7/q/2TXlXev85lX0ePmoLSHTK1n577g9A1LMHC2HBhad4Fwe5wvXxyxs53wenodtGtFIhKA0QmfMReJiYspLdBgwCyYXjkeFpP5xzVqakVf59eNO2Pg7wXIoMNRrDFB+lJrC0+sEngwXbyXtF7G6dRwdvMtDF8JLof1+0z7JvcBprX9AljMt9b13JrSidsCGJz52gooQjYFIpBECa0B0CzhBX9spFdpRA7Eadm53e
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(1800799003)(186006)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(47076005)(4326008)(70206006)(70586007)(2906002)(336012)(6666004)(5660300002)(36860700001)(7416002)(41300700001)(8936002)(316002)(8676002)(40480700001)(81166007)(921005)(356005)(2616005)(54906003)(110136005)(426003)(478600001)(82740400003)(36756003)(26005)(86362001)(40460700003)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:52:43.1371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95836797-2b7b-46a3-a4db-08db970a848e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add an optional AXI DMA property 'xlnx,axistream-connected'. This
can be specified to indicate that DMA is connected to a streaming IP
in the hardware design and dma driver needs to do some additional
handling i.e pass metadata and perform streaming IP specific
configuration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v5:
- New patch in this series. Just a note that dmaengine series
  was earlier sent as separate series[1] and now it's merged
  with axiethernet series[2].
  [1]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com
  [2]: https://lore.kernel.org/all/20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com
- Switch to amd.com email address.
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index d1700a5c36bf..fea5b09a439d 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -49,6 +49,10 @@ Optional properties for AXI DMA and MCDMA:
 	register as configured in h/w. Takes values {8...26}. If the property
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
+
+Optional properties for AXI DMA:
+- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
+
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.34.1

