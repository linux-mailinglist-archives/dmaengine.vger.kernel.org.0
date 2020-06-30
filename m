Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF03320ED6D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgF3FZF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:05 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:60291
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729609AbgF3FZE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inLlc378h9cfnYUPHGO8pRu8Wk4/bEoMvmd47f4UvuKLbwU2Ia7NFYGZIGcrJPCmpSntzyiovRntlLV1PHGJMpoYe/oWjXTXf8p1B3spMHtn/r62DPrxfi+814lW3xAGpfv5mJgxK4j4KsT7xDCH8N2q6eSwJeB6iwjCkdJtGXYCo66bM8nPXV9lZ9PB8hia7P48htt0bYkeXfMpaW2v1w2/AIgU1+2sP/6fw28l1jwEflD1dCeOBcBh1ptkguI8d+SW5C112lMCus/bHB2knuBc/K6fvEy4sCjNaKQU5OPBvI8sd1Y6aTXFB1oYlYk2sWJqrlt87+F/lSjQs+uZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET2xDtbbKlaDJICOQJqFSKVvEea+SYs1lteSLtp+Aa4=;
 b=ZNDsfeLQVlo7te0oA6D8ITtAnTBXgtYffRuKyT7Rz6RgabhjQkvlWFSVlMGfqhvz4Wc0TsUYx2CALe39fGvZ7z84VzUQipIpvdKh4VcScWKWFXrGwxnXneia1epMdtp52+YhPOVPOQoMTtZWgiEwWjwgh93xYlpYgHhn3cECCNzsKMT2L4IUIkpFgb7claK1sLPFlDVFqEZvjdKGIT7C7TCmIOEkWz5W/sOrJZI2Ek2l764rxs54cMcVWFZTP3XaaauiyssGLYk+GMF/0j5l1TJ7y472u+aXvmgWtl4khOm6TWfQwZGAJYq/l/nGPX4ZcRu1wAli6qIn7ZnCjFlC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET2xDtbbKlaDJICOQJqFSKVvEea+SYs1lteSLtp+Aa4=;
 b=dJck81qb4Yzew0hSRTmRKShCAlLSw5ikzm2/UuFFmvzGhrSWfw+dbdOZzip7l2owbc+ZXjaW9Hka4r6fHuBTQgvLhVs0cKLU8157U3Bb9TPY7NA6ZDyCX5cEncXqxz2ZBqUtImuhRFX3vWP6sbOyEeVOKhs3Jl9M4m4gnHu7hxA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:25:01 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:25:00 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Tue, 30 Jun 2020 21:31:10 +0800
Message-Id: <1593523876-22387-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:24:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5ced484-eeed-416b-ed56-08d81cb5ef74
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB664022AD3F8AF1FD4AC95E02896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWmL12QcL6lkt1hn3PMwNejlX0l+CPvmwDk5HLdZjTZs8I5Whyxwyt7V0fv49wEqVkpPdKwYeLGiU5lGpfeNH17CIVPDzl/lGbwiplEcjUWjwl9FdpSztjy9636taMBVgd+ZfHlENzInHtrTXx8n6JaY2kDY5wT6FepsCBo2lTCzc/9RyNdEhZKCQO76CLNEPSGHDc/XyFdj7b2XEsMhUmx5pooc520KPBscxglekOryskt0mKRmRTh0qLORutUOWkcWV1UqgfYWvz3s27Hrn8VR0MGL+a2gnSBXty3AJuEUpuLbcxkTTBQLjwAjenxemBfI4/7WnI5aCA0i/bA2n1zzkMbAqabm/yluCsupZQ4U2WRBsO5HDNytMB5Fg6JS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(4744005)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zQyxg1fWPfQ0QwQpXGA88RWiVyIu3ewUMcYGK75IB9pSbOK9ynaT1+aD0RhbnWp/5oFQPSBq4FbvNeUnK2yHe9kV96qU6TL2NL0cqAjnf9auLU7F7FA959no4JjFhwfFO8XHzN6/0jFVdx9hkxXiU0ufV6Fn2AJqxXts1Nxg9ctkQBaLCLt3EzIwCkZUj+MhXmW09oeXNOeznX61vLojDsDsp1VPZ9lVI2i5WmDj9rfGA7++g7gHeISuV1I37ZFDHTi8cpF7aFD8x3kOUj4eMJjsUKksMKKNkPa+ZzzJohoypglmd/devIMrRjtmPsJOgpJfhrUxMKma28dMaxv5KzEEBe1KectpBB1P+6Mq4seE4yh61iLeVxoCmOAqaOcRUjHv/4u1hWTwDXsRCMj6MY9Vj5B2niLAD6udTofhhyFfMusiL6R8jLNIJd0bK8qMxFAMnYxisYNLIoYjU1t+YbNbQqtlNJeNEFYf/te4S0Q=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ced484-eeed-416b-ed56-08d81cb5ef74
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:25:00.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naGkyod4iZs5TMnzzBQ0wiR9R7cwbCuVYFubrgO10k/QAIQvyU1Rx9RwEjfEQrBQze4T4XBvCk0Egm7fb3FhXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ce1c83e..337143f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -922,6 +922,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		sdmac->is_ram_script = true;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
-- 
2.7.4

