Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347FC5BDCA8
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiITFxQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiITFwh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:52:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD85B7A0;
        Mon, 19 Sep 2022 22:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecJwSfOvT+OgklGJknckA+xJF4G5fo3dnZ5cvSxGtTfgG+bpJVgInI5FrH7wRawsqGOH/HMLRVj9u0lofWfsHM+jBiJfZnLXe7AGg5fBnqLj9+5y24sTBrTOLpS5oj0SMu0idTRHtnklGGmg/xJxS2z3yumVShW+Ic/XNcoLVsroW8JoC0nh7Qk0evR6H79oPvDR3iW9qL0Wd4gX9Y1PB4pY4l1eqrbTEQjIjTBFPGQCr5zQfee6sprbONjHyrgGD7fOexSO/TVQHzitMbwaL73se50pIPIZmE0XlBN5M2eWrgee2wM6OpRWIWpEbPYxZqQlkYJR6nJyLrOH1zo5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mhFhnS+Urh09YvvwKS45o6I5uLgqubiJ+Dih9n90Zs=;
 b=ln4v4vCQ8GOUM8hGrgjO0aUXQP2OpRICXhEeLeCtUwp/k8E3H/b2/goVDWjy84amlrFBkslHH1GrZoMT7+efxWyfN81Vc3eMHaMYL0yOiKY/SCWePxzDstwol+qOUSgb++Xt6bvxb095o/gTjF82Y3hTUYEILK4+UuKQcXDbHkeJOTUDWWVdSYm77FQSEZ2lEbQchTMjqAo0s33QEO5vlafqqPBUi7iWSblURgBx/MmWsldNt1D8sbuwt6/afEfndiMluhGWx8+5EzlFX4KBpg7VkegdZlMgkm0KvVg6Dth5/HyCK3bDU5ai3ou0umFvyvXRZHZon3qYrEC1rQ13pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mhFhnS+Urh09YvvwKS45o6I5uLgqubiJ+Dih9n90Zs=;
 b=JGW6uPVO2u5rikZ+hB/IKGXjnKf5uXRpVYGG+GgoJgSobylblKjxPP8EycelxsQ8yxEUCKWbn5YyrZ2GI73+aKICnnQMPDHtuoLGc9gOsuswjmSOCNlSLPmshDei74CgH3hsQjjgyIepPbV5KgCM9x/FvlSSvzJ8aLs85Qgnu78=
Received: from DM6PR14CA0054.namprd14.prod.outlook.com (2603:10b6:5:18f::31)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 05:52:19 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::1e) by DM6PR14CA0054.outlook.office365.com
 (2603:10b6:5:18f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:52:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:52:17 -0500
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:52:07 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@xilinx.com>, <git@amd.com>
Subject: [RFC V3 PATCH 5/8] dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit
Date:   Tue, 20 Sep 2022 11:21:16 +0530
Message-ID: <20220920055119.12634-6-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: d0723519-286d-4658-b59b-08da9acc47a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vw47WI7KC2w5tPWq35rtVOCh3q8NqroGINak2QflujJApGySxOvwp2jPG6UKNuBOCZAtWYbRqXfuNhMeyUlXOIt0xbTr/DzuBEo8wJ6UeAb8TKbyMyFMxT0ulBmWKGTBjrKxdQ4qxHcMrodDmt/51pm0ixO1WLo26mFWwIjVhLTmGqHNsyJ5ZJO2KK+j41/Cr5eHXac3StS8st23VjnBlmaWkEMVrsCSKEu3ZUmCkEOyGzcLpY9g73E3/jWyuwqTEeshij0g29BuoL48RTio8VJRvhu+xcdtv5RhTu1EFJJ2SiC069QPhlEU4b6ps3oGugsraJtDP0PXg/Cj1dn4lhdHE+aOYzfgD6qNuEsXSynlIgngJI7qnhcW/BlcIlvmDO3bfHJpjeQJB6eKTqAXO7GfPzNvjc9l58CYlxVZD3VUJrDijBTQJQgtLEq8xV2jvDYsF/vTnraJl9yRS0J/BmPFRfsbhuuNsB9uCCT+YQb83iUhbI/+BscvUAOtUFdL27bRhy9WlQcSwimBysSpUYSV4ykIw68hOVz3uffCcZBS9COeOTf7mvmV0ySUJCLLvPzUW5Uirhyomzl+2vFR9y78YySaL8cZZoK6tAL2EuN0irnU7V8WxdF5MumN5rFHGmtyiYCLRakUnxmKGD4RGuaxCPTfg0eCEKZLY2TmIwpj4U/5u+inOWolr9XHm2DEJqEOJs+fhxDylMos102N1TLINUAy9KRJSuTxmAMSf6yIWpI7zFxAPnwdchnzFeuomSYlKYKTj1OGthAQ9aMaXuMfYhcMIgPwFQcB/jNkkIBgl8I4GGCSPxch0qz4Z0Xt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8676002)(40480700001)(336012)(82740400003)(426003)(2616005)(1076003)(186003)(356005)(81166007)(86362001)(47076005)(36860700001)(5660300002)(8936002)(41300700001)(70586007)(4326008)(70206006)(2906002)(82310400005)(6666004)(26005)(103116003)(54906003)(110136005)(40460700003)(478600001)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:52:19.1260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0723519-286d-4658-b59b-08da9acc47a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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

AXIDMA IP in SG mode sets completion bit to 1 when the transfer is
completed. Read this bit to move descriptor from active list to the
done list. This feature is needed when interrupt delay timeout and
IRQThreshold is enabled i.e Dly_IrqEn is triggered w/o completing
interrupt threshold.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V3:
- Addressed RFC V2 review comment in xilinx_dma_complete_descriptor.
  "remove hardcoding for axidma_tx_segment".

- Below review comment is in pipeline. We are facing a race issue when
  addressing it. we will fix it in the next version.
  "chan->idle = true; in xilinx_dma_irq_handler() needs to be gated on
   the active_list being empty".

Changes in V2:
- Check BD completion bit only for SG mode.
- Modify the logic to have early return path.
---
 drivers/dma/xilinx/xilinx_dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8c6065cbda79..1488cc6a299a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -177,6 +177,7 @@
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
+#define XILINX_DMA_BD_COMP_MASK		BIT(31)
 #define XILINX_DMA_COALESCE_MAX		255
 #define XILINX_DMA_NUM_DESCS		512
 #define XILINX_DMA_NUM_APP_WORDS	5
@@ -1706,6 +1707,14 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+			struct xilinx_axidma_tx_segment *seg;
+
+			seg = list_last_entry(&desc->segments,
+					      struct xilinx_axidma_tx_segment, node);
+			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
+				break;
+		}
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
 			desc->residue = xilinx_dma_get_residue(chan, desc);
-- 
2.25.1

