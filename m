Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6B61099F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 07:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1FLU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 01:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJ1FK7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 01:10:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B6756037;
        Thu, 27 Oct 2022 22:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYWpu3RhHYp8AGIlCxAErDRIRfGkJndljW9g3ppXBPNevRCgvT5P+190K+hvedyVJRU/CLBFs6SiZQpD1nwG7CSTAmoGxhyR9t6pkPMUnSGIxC3UiWHvmpOgd6FTbxtfzeXxNxYq4kxOy8bgdgtJvwUOQ0pIuMHufFPic5A0l+MHf14Wr377wtRo4d1tPLcfkAdpA+Tip/HMFale6HHh0w+NBXKaB5nCeuCsmq9s8smur3sk49adlgaM5UDbee4OH5OvxHFgXoWtLp7z1RdCXbj2qGe0H2YGOtWAEpbqmp2mpyna0owvxTNIc49eH7jrG3R+lkwqgdcM2eMZJTEVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35+uhI6rMw5Yr67wj0Fw1ZKBa8BIxlCESp8lm9CgQRM=;
 b=dIn+S54KEYylr0eIdgP8ExcOB+gmLC3zFlXesKRqEcK5JIQDKY09bzxUoe8jYT6VHJRop51C9fGybLtjpZ+Qdc2DIVO2og5PKVqueex9gTxNOmszeGj+PMGCvF4NJf/jSk04NS81OeQhwStimAV7xIvSI+CyT0phF5QLsGnvDXkkO8/WH0UGzY7jsVm88j5qiCNq0EnFWrX3k53eLQpNPcdvom0S0TqqCQUdyjPJIYuJZo6mGIGu0y8WTeLInkxxZgUxj7NlyBgVilp5a/s7hG4LirbIYctdYWt97NpTt4WgjmVArWPzs7X2bVahgis/EdwySS5QlaqRJm3bsFKIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35+uhI6rMw5Yr67wj0Fw1ZKBa8BIxlCESp8lm9CgQRM=;
 b=xdWKtTVZsXtBUrb52C65zfCMpgD2AlRdyd7AzVntMu4oMaOxemVCmT7OX7fWcaDDySgqtDRLiREBIU9mN5qSMF/UXyiD1dVxTbEsXducAyscYx4JubHCdvks1BL9IW66ziu6e6Eezuk5bm91Gdy096wJfc27Rr2ktKqKfCO9PCE=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 05:10:55 +0000
Received: from BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::a7) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 05:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT070.mail.protection.outlook.com (10.13.177.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 05:10:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:10:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:10:06 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 28 Oct 2022 00:10:02 -0500
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
Subject: [PATCH 5/5] dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical usecase
Date:   Thu, 27 Oct 2022 23:09:40 -0600
Message-ID: <20221028050940.27888-6-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT070:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ed7878-fb25-4e90-6608-08dab8a2cae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQU6GjpvkllfBCYIpGRtox3NWy9XoDV4jfmvZ78tCqtCsz8oI7hu+CE0mL7mnkUmA96kEVTCqewG//TmdTUAfkRJ7GEhk6nZwc2GZ3E5tTEMYxh8dlUdDSKM/y+vh4MajrWRfkMVvhe8/nqbRaaEUXZDDw4xiHwBX16eOmcXPr76Zmd6QqGPr0O2w+LxQsJMNeFJlkc0wHWjwbu09/Sc/brEISD8OWWySJZfNfSx6jlp7rvtQwzaXlgY28LWb9SCpRQYw72hYpHgl/tvZ8fWS5aMaedr/JORO9en2o7A3W33obhGkaWCOyIbXBuXN6CdJ/FXWvxz9ZS7sbYKVilfvEm2YURnMZCua3uBt8281rzieDxUPU6jUPsMy77xyBzUTASl1P0osp4z6X/f/FsAwh2oEqhWv9YfK64g7lartDNl/DDHPlvwn9vR1oBAvyhN2KEe8gK7K0MACOOKb7n8livBIRAkpZV0QoHONJj2mLOh1TGr3AxzBpRalELPciEcafnPsOnN/kEzkVCkRUpXHXMLYrRk4bu2tLhq7NMo+oRlFXP3XkBBr2dGGFnJb/cFrjPS9zl1Qp50OR2f8KW+23OrsMwg8bfs/MUpsLDsfs+pFUpfFPpM6fHA4l9qlX181bBT0rdM8WvKLAjSfDHanbWFDMeyaipjVOnpjg8cYDOteLxoygOFELREo7mEq7FDtJ0g4xQwjYfu2WLbRYi3cDb9lSDIWxwoIj+H0ImEVdaeoweLmiy+YA+3idh/TibTjKYViebBeA/ufHysOJapnIWii8L7956d0ke4Pc8ObIVZ8ELp9XSyE1Sz/GiT31ne
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(8936002)(186003)(26005)(47076005)(426003)(83380400001)(1076003)(5660300002)(2906002)(336012)(4744005)(36860700001)(41300700001)(478600001)(40460700003)(54906003)(316002)(6666004)(86362001)(356005)(81166007)(2616005)(103116003)(82740400003)(70206006)(70586007)(82310400005)(40480700001)(36756003)(110136005)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:10:55.3925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ed7878-fb25-4e90-6608-08dab8a2cae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
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

Schedule tasklet with high priority to ensure that callback processing
is prioritized. It improves throughput for netdev dma clients.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 43737e0f3625..bee21e4f1e59 100644
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

