Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004147719A5
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHGFwz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjHGFwx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:52:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46918171B;
        Sun,  6 Aug 2023 22:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InrDuJY0t302wycHpLm5n4Jz3wU3MssAKz6sQJULk1hZkDtQhRIL+Xn5yMGJirLbo5zABRAar901jqtxoLA31lAkwWnKRqgmA9Bp2P3S/hPNOKrOIR5vDPwLX0R6YPZ9Ta4/XGNQsHyEeK2hKwVW2Zpo2BJuh4rcrL9cUONULbB6/+2Lt/SQ3RYNjt/AaD9G8XS6zpa3tjSi5fbnn27NiQa19+hx+UNlcLmi1ecuIEgHqKbd6J3L2nlk6Qld264yT9N3NdqsPQf8XlhLbahP9H4InTawX7jdXEMqQTNqxQ9khCXpgImvZI6fFAGRLtf5RVx/KVK8KKEM+Vtz2PF/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4kmAr3BLf7v+CPfaK9S+TTv9wF6I3BI8aOmVeruI8Q=;
 b=krujImEwE4fVBETIsBjczIJ6r2I7MYE6W3QwXhlEaHGg1wdwsTo0CNNOTXfB8LHTOnCbBqowMYOIKS6k2YBzSH2vR5vhHblrRi2Hqmssyz4SmN7qVHNytwsg5byka/bj4/o/RWgMZtvUFkxksdJr7cQRnEyaFgaAFOya8B78cqFJqTqiXk4KpWG3tA6NiZ2iBdTxQNqPTGuDdmcc7BPAOBiDpzp8LVQ5IbrXgZrZeduU7TJ5x8ko5L3ExtdHRU3JGNg1kCyJUbQ7d/VAp5Co87pGTf/zbeyP26NnDYrdG4ctaneTjsBviQeo3XvYggxbI20VYmjwmlWDbk4WTwhRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4kmAr3BLf7v+CPfaK9S+TTv9wF6I3BI8aOmVeruI8Q=;
 b=Hi/ym1Xt19PBmMynyG/iru3s+Xi/1E6LkeVQ1R5FfyO9yPHy+WVVjmmwo87i24PRmjH4rYucPmED9NAQiKnAcuE+ow58oKFvzvTu0TelaTBa5L6cMKnXNUNFOpmVJmlEMefk7dnEzl0luetxVzi4ai7lGxcpS8NEKql1KR0t1vc=
Received: from CYZPR05CA0021.namprd05.prod.outlook.com (2603:10b6:930:89::13)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 05:52:43 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::c) by CYZPR05CA0021.outlook.office365.com
 (2603:10b6:930:89::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 05:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:52:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 22:52:28 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:52:24 -0500
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
Subject: [PATCH net-next v5 04/10] dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
Date:   Mon, 7 Aug 2023 11:21:43 +0530
Message-ID: <1691387509-2113129-5-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b348bc0-c58c-4cd1-8cf7-08db970a84da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfV60tsF4E8A+/p9IvI8TdsPKgE7R5cg3o/QpziSgbYx6mgDlf9zitzTMav5wDGpd1zTRoLl5E+d8nbbH1TYO/kV4IlnAqoZWCJ8wiAc28zgTBjH72SXpmjpjJ4+OR7ffMWfKCZFhqdOYyTs2N1ALOuIoF6TuW9vjiqw0lpwRtxuM6ToXk8M1Xvu+xk4ZkRzGPKbN4hppUR2yg+b2POSFnFugcN34oiEbxjYnI+7hMgj3JRCuj6VrOZsQXcAFKCHp6ZLu2/9AGwdx1EFjIMOBZ0WCkVOJZDUvdkVeS97FEdY3m/vbWdYhgeyD/MRd+iojcFZZjygRrd2b0QxLWQtplgYmsdWCjgOsNT3W3qyQvBjIhOy88kBRtvvCDL/diqjLCrtC9ytQGwQ5JCzV/zV3KhMjxPqacDXPlB1hb8Ca+z1fAf7ic6P7mZpMpGJoj2gDP+CNgCmq60c8VOElI3DBvvzAXbhWyh+NiVyksnZUulELLjdCeg/pSreYP8tVSiLi4m2J0OsnuaDzmpObfE3aAIWnhFjJz3pmVTHAxeOReCHMFVm0cVtrHSKwAQ2EuuM7y9WkqLSwVI56qinlI6DEbuLuNQeGqDjS+c8mDJSQ4lvMopruwb15ESxJnBr9iOeCXjuSHrxENLFPUiu2pHvyVkY2Da9P3GP0bU9tUGP4oHEBhbqCFm+TbIoZ9MNU2qYYsksQAHlSd0umxgJmofjVgi0rOGECwIPfXP0Orh5Gi5BojuWLbq7UnPNQTq3/OTgDxDXHGgwj4GMc4hZe2kjZuOpnndmz+r6nldqieO/KTE2RsxAxcNquGhA3lfVHfxB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799003)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(921005)(40480700001)(54906003)(110136005)(2906002)(4326008)(8936002)(316002)(5660300002)(8676002)(7416002)(336012)(70586007)(70206006)(86362001)(966005)(478600001)(81166007)(82740400003)(6666004)(356005)(41300700001)(36756003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:52:43.6345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b348bc0-c58c-4cd1-8cf7-08db970a84da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Increase AXI DMA transaction segments count to ensure that even in
high load we always get a free segment in prepare descriptor for a
DMA_SLAVE transaction.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- New patch in this series. Just a note that dmaengine series
  was earlier sent as separate series[1] and now it's merged
  with axiethernet series[2].
  [1]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com
  [2]: https://lore.kernel.org/all/20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com
- Switch to amd.com email address.
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index d526e472b905..7f3c57fbe1e3 100644
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
2.34.1

