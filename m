Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E441F0764
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgFFPVr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:21:47 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:28739
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728884AbgFFPVq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQs1EsjLFjjHVuaTHP5s87LdOpoWxqcMOKWBth0g48cLY/h0456toRQLy+2BYxkHP+z8+4sorOsdwHJXG9aFPFxMDWhPYmdjLRfpREfKgz70nLfSA0hmSuHUzTZ906fnpgox9B46A4xiG3Um6RjjhJOoeqgwK1xr/6nWUixSCGNTubku0y+6X4AiaOF6fWljwSMhmfftWP+z8xIsW80yHBtYqj2tBGuj9wU4uuG7MRPSwtKC9AGoAv7q0sLrw4+Pib1gmBSL3GR28MGfYi9rIbjcVfl/ub00lLcVQYXu2LysvE50oT3DY1wZgEDNu3pvx5ljMX1RKqO7fClE7AwNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yx0IR+9/TNLsZpIgHM8O9jKDpTRHMYZbaruFg9y6So=;
 b=WU9DUznGnh274w0j+YtZzFUgusegBdrD5yhVOExfRxzUL5PpcNcl3X9hZ1LyilYegPX4P6HtvsDsFM7KeMVK+E2D/c43pfBYsIYt4bSFkLoqsNfbm1S/UuaZdNfU13CQ7PANMk7ZGTZya8T7+0wDP2c9j4QNzGw+pkfXI+4xUsn+QPyffqPr6lbMXOZjuCsFxQAZXGzV9YNMX/r7MEfcgTHwgtfL0RPsKQTLz9EfrR0kz6j3hZsGJNxkYO/OIOBNN9Xy/n37ICKoLH8QmoY5ZLyjo1qzCEwpmogn/lrt8h7dXOb2Od55ZwAH3VQ6enrqRE6LdQ1R2nZmOZFSq9l7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yx0IR+9/TNLsZpIgHM8O9jKDpTRHMYZbaruFg9y6So=;
 b=NGV3j9miTpK1oCo3gPWD+/y1nI87ky/bPH1YT0Re8nNQi+XPe8Pg9CGk0JzZJxaxVHdZDnFxKSCWFdxCrT2zBnClbNnKC2TmnLBFfUOMrPOGH8fp6vDHUXkmT2Ya7ATMTb/JUO+4tpt74xG7BPHiR8y3hHkjuvgTMTsC1I+85UI=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:21:40 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Sun,  7 Jun 2020 07:21:10 +0800
Message-Id: <1591485677-20533-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 213f2b5a-6182-44a6-b40e-08d80a2d4f7a
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB65115D048813DD273C68F98789870@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MdkZ/kKz2pLGYL6qwbryRsyuzSsPORlSjpqpQH4yTuJ0l7vunQgT40SdnhVGjJYNlMbDv4EvWjd9tlWEI6z3altZV2ZlwzO6a5HJUalWBB2fQjfK1C0zh1YWpqQ5sGfX5xADRiRQX51HLiPAEB9YfL43JlrIVNAArz8I7hYd6CU+Kwz9b8sdnVEpl8l5hZv1YEk/YbkRi30kEVS6G4PNuMOhc0QiEDr60SRt7U58afiylUYcvImQqyTicp+LjK0GHqwgVi1cxGuz1DrM8Vul/K6T/jIQ9tT+KUFJVkyit1/shtpoxQhHnJtJLMCUA/cF2a/meQcp324DaotxVVaEY64x8iQBJ2tqJHteWca0+JYcf+6pnpqFGt7ukToyaLe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(4744005)(66476007)(16526019)(6506007)(66946007)(956004)(6666004)(2616005)(186003)(36756003)(2906002)(7416002)(316002)(66556008)(4326008)(478600001)(52116002)(26005)(6486002)(6512007)(8676002)(8936002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DCzN9ticWJXDnmHSc3CekHN1zuJR4Nd8vRGsir8njLpdyk9vrO3h0onnq3112zR+3cefrhjbdk2I63EOjbEPThcj8bj0wT75AVeJUOt1RqLqtFvN9SyACZZSm5aDf/GVlp0tIhYmhQ2tajUzO3pCaoK9p1q6tnF8+yxPUkLyWlyjTJSN+OixLAqVOZKSpAQZ8sBJebYlJxoBOs7dkY9IkROdMR6DejfsSh0ieqOW8FVHgS4AODnf7VjvIDhlG6SxSXflQgE2JoR2f2zgmtQyT3OI7VjIJZozp1r7g0yIcXyVBL/FlaBCEEzbp1c71QEP6s2Svcd0DxIWVUcH9Vih01mRk/k1eAP6tUPRg3tFnhPH8zANsOPDa43U+Pdv8Rr75HdHVaCQ4EZl/QK12PuolpruQbVznhslfdBJcNMk7W+t3HWJyU8SKzcT6WnrEQQBEoNEQsveoOwLT2x8eWBelcYQfe72wE3Eu0g44o3U260=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213f2b5a-6182-44a6-b40e-08d80a2d4f7a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:39.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 690pzTEecQWnji9ylazGkQbcQxqVnwDLFHihyyw2xwknt5C0hAlncdcyAfiQ8WEvT/BboX9Me8Ogh0iGn74vYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4440ddb..db4132f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -920,6 +920,9 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
-- 
2.7.4

