Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583DB1CD52E
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgEKJdf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:33:35 -0400
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:30439
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729572AbgEKJde (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhMWncHtYtflvtOkWxFoSCRc5tVNuXimGuxhtt6fyjAv+X6cq74vFvWrSipUdOLoCY1YGRcXyPxwjZ8im1p+q5DujDDbF5OuOt/RdHQpoJ0MWiOh0V7FuHrJPii4EX561U4TXbDFo9Qu/+tsjB7GQxLwXB9gI2ZkIf2pDB8aafMQ19KMWL0uZUcp654EpyOWecfCxKG5eV7dWZhvUnafkE8vCaDn9SMQQA1qpz/Tap6YYWOCOoDrbONcuqwELIJLpqeXjjGW5nGNaQeh86MQrzgYhsAPXjUx5vZMfHHg1xkU8evLdZZdf9QNk/fjfPkOIwM6S64P01O1fscVv2SLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEoEhyBGFSr+T0WmOOJnN6+RjSQtavc5N5PmyRlXha4=;
 b=S7EZFAvJ8yathjmhdTKFTHYQIkRMFaY2antZsHk33s7z+byuhszHd8I6JRHkHlkpgmKVZqX6Xkie3F9QOitd7BN5ben8ld1+6ao/Z6KV6fNp9OObpD/mHMhaVjsiL6Ftk/Z1yphE6ex/IDDlu5uMj4IW5rCrA22HDY+FmQ8AfFK821u1k2TvE3nE0/GB9LETfBZIFN/IBQrrEGrwrb6qKEoeDXencA2jokc3n7Jkata9ob2fjUzK5H6/eUIAt6wpl/dQvu4pYJQiDxaWwGkSJFUqEkrmLzQg0bk971qJBit2nOlWmAICsOr2R28Hetnyiin9p3pLx7drNyNdtzEWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEoEhyBGFSr+T0WmOOJnN6+RjSQtavc5N5PmyRlXha4=;
 b=VOPTMp3kRzeI9Al29ixpd0VhBn8fofs3l3lmmSP8fVWSH2HDOAI/Y+EkTk5gu79GSWKP6wtIEhI6QYP/d51AsZciSFcfwGvkJh4thxeJGaVTQbs9OcUQJMYA3dH0B2cSVAPThux35aK3YxaAkPsa4+WMEcUa4TQ6VGb3DjRetRA=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6733.eurprd04.prod.outlook.com (2603:10a6:803:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Mon, 11 May
 2020 09:33:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:33:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com
Cc:     will.deacon@arm.com, l.stach@pengutronix.de,
        martin.fuzzey@flowbird.group, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 RESEND 13/13] dmaengine: imx-sdma: add uart rom script
Date:   Tue, 12 May 2020 01:32:36 +0800
Message-Id: <1589218356-17475-14-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:33:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd6facc5-5efb-4906-7e82-08d7f58e5d65
X-MS-TrafficTypeDiagnostic: VE1PR04MB6733:|VE1PR04MB6733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB673391F1A575D7EA68B59B1189A10@VE1PR04MB6733.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdo5vcFbc9L2x6E13sHg5pWwqTUFVcnG72FKPcbN5GsPPfDxcpQye31HwwILK28on7/5fCYUia1ppwmq93l6haHrC8Ba+glSJns6oXz9boopEEvv0bkRq+LX21Ueq/+btY/2iEhRfxhYl+rZOslnSiCYlmSCpYP6/DkxELZuFwOWo88lR5L7mrfrRuEBMcIWPpCrHru+PCG8T2h+LyYgneHijZ3UyQB3niRs3XsXPhbP6i0dKXFLlRZ5Xl+9XQ1N1hXBDj4u7DUSQftq64+o6ZyHLgDMUvvUYhsOArYLmZsr2uRhBj8s70DDRSK0PiL5gfkmqgSNqo72YmYWkpxfQKfS/Cw2C0lMQxoXnPMkkjDgzEKvmKYldDfdGmLHM/+/0yaL/aLcVkPesCZ2eCksQlbkej6M683u8PbdU5ObK4NC1ExbxThy1axrBym+nWqV7sw/ithmkGPT9whcXxFIPAZI/gpMpwhzeMvEeMtyq7YQKRrfPLTNx7TynW7J1aKZnNrvipblwN/S2PRBV6gsSD2fU8nuO+dcW098cJOUEyVPSoRbfo9FqyEQWYt8mQfU5IN7AOYe7NMrzcACr0V+eehSsMTyk04g52sV/AVIQzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(33430700001)(5660300002)(66556008)(956004)(2616005)(7416002)(4326008)(6666004)(52116002)(478600001)(8936002)(86362001)(8676002)(966005)(26005)(33440700001)(66946007)(6486002)(6506007)(66476007)(36756003)(2906002)(316002)(6512007)(186003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /5fYM0WG0rhdYvy5a68mOObDswZoTwPJJaPzlgJXYUSwjAHQ3SXStlRQiVB6MdsP5qevJCDmM/dy0WnkKGx4KyYIqjTdc3lsxLTuFnlnKYF0x22RsMDHhcqH/L3JvbVWOL5OEYzb5G37TbuZuDRBSJI6iaeeyCNqILMbLb5StE8QsizIf7ngpX0EMATR6nEs2o6y43A5PMNnCQbPpUW9njhgABMBWyWPU4U7xvjyQGlXHUIb6Dp81KUDMbYIvHv/GvgRFZGfHljijOOnUMfX7Zbiy4g3bsvMpA6jD7JHypYYas1ybTEpMtvom/fQ86B0wyb0ycdFPGlJHnit2WBNtQ4nN880DhpOsHJ4phEU23CPHvucqM16O0VYCrqdOt1iH0Oad4dwVxVZ9baAJ73gqrNwobwQIdPiLVO8L1SWxbFbfK1OxBs7gJ5gIjGwdORhVHcohI3MD8u4UhvM+QZhhOHn3BDP3cSztYq1VeChMOI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6facc5-5efb-4906-7e82-08d7f58e5d65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:33:29.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHDmzgnnD+saW92bZ4h8R6UC2D0j3SpLlICtzvg4/8i/ZZFWC6RohYS5AlzYL9OUmISeK9yoxOOhF+FxNirC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6733
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For the compatibility of NXP internal legacy kernel before 4.19 which
is based on uart ram script and upstreaming kernel based on uart rom
script, add both uart ram/rom script in latest sdma firmware. By default
uart rom script used.
Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).

rom script:
        uart_2_mcu_addr
	uartsh_2_mcu_addr /* through spba bus */
am script:
	uart_2_mcu_ram_addr
	uartsh_2_mcu_ram_addr /* through spba bus */

Please get latest sdma firmware from the below and put them into the path
(/lib/firmware/imx/sdma/):
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
/tree/imx/sdma

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c                     | 4 ++--
 include/linux/platform_data/dma-imx-sdma.h | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9d49aaf..01422e7 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1718,8 +1718,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 30e676b..e12d2e8 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -20,12 +20,12 @@ struct sdma_script_start_addrs {
 	s32 per_2_firi_addr;
 	s32 mcu_2_firi_addr;
 	s32 uart_2_per_addr;
-	s32 uart_2_mcu_addr;
+	s32 uart_2_mcu_ram_addr;
 	s32 per_2_app_addr;
 	s32 mcu_2_app_addr;
 	s32 per_2_per_addr;
 	s32 uartsh_2_per_addr;
-	s32 uartsh_2_mcu_addr;
+	s32 uartsh_2_mcu_ram_addr;
 	s32 per_2_shp_addr;
 	s32 mcu_2_shp_addr;
 	s32 ata_2_mcu_addr;
@@ -52,6 +52,10 @@ struct sdma_script_start_addrs {
 	s32 zcanfd_2_mcu_addr;
 	s32 zqspi_2_mcu_addr;
 	s32 mcu_2_ecspi_addr;
+	s32 mcu_2_sai_addr;
+	s32 sai_2_mcu_addr;
+	s32 uart_2_mcu_addr;
+	s32 uartsh_2_mcu_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
-- 
2.7.4

