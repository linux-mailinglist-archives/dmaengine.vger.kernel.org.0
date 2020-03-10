Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE617EF22
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 04:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCJDbJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 23:31:09 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:40495
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgCJDbI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Mar 2020 23:31:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJub619tmyASBjfoYlGcggPkCo9ReRQwXyJ8pKvIX7nBv5eddq+Yj02szyTpxD2n7TH8UpfHWGheQ54AucCn81Yhepg3MmDyWfQ7Hfwo13mBHfqdRcsCIs5p8rbb75wUmtci9k6JnOv8rARpcI1LF5pj1gKwfe5vLyh7ENdQe8100T/t3/a89I7cGSR/cMoiHze7rC9T7tHaktxikSKhIqTSR6ctZWd0I26G9gPw9fJw7blHQWYp9QRqXBXsJw2XpswXE9epqfAyIiQiLdhCdMmFPFORXGI8e27e9WSyc5LQM5SbYZNmzy/a6143IlCplTKwr7/GAG6zTUT1P+vjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6F9f2eo8lB1uHOFi/c5cSBwXm8B6luma377P8PY5hk=;
 b=b/jZnYo+4Cx60NuDCeSRrfQaK/eqJSY7rJaLO/fjmaoqRKTb63qUj8C6aX9p3K2N/fuDDan0NiG3CbOeoQhmGPqqsOO5zOEsBlMhUGgYxjKmcx8iUceRFThoQiYlnVwLCvlZg6d6aPUOive68lwyZ7L0Pf4zAWOATgcs2VTXxgEwzouBA+HBsdsdLXqOVKnne8yrU33sgMVCzExMsSPsQWfdwYU5O3r6uFNUI3cEBHYTeddB4eZPBqFu/Qw+tGb8Pby/3TXZJU/fVhvwS3ZdazSpdvvRCEnZnlXmbY43RY3cciouL7HJLk+AHnNamzdZEae91rWL1zeRRNeux/n6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6F9f2eo8lB1uHOFi/c5cSBwXm8B6luma377P8PY5hk=;
 b=lxIUUUCsTKj5wMsvBiyEg1KZiyGoYaFMAxT44fZfiUo0u3YYCqD093HRA+bAdAV893jJx5shCKnLHkrBqKDXczgd8w5NNiUqDLnFB7llj7Ubapn4sTJAlLahSl3a5eyGmTffb1qpaJh9HHYIN/nvOQ0SurYkrklp3YH+ilTAWyI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6621.eurprd04.prod.outlook.com (20.179.234.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 03:31:04 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:31:04 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND v6  05/13] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Tue, 10 Mar 2020 19:31:54 +0800
Message-Id: <1583839922-22699-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 03:30:59 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f3aaea8-5b4b-459a-4964-08d7c4a3767b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6621:|VE1PR04MB6621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB662151E3B8B822506E40A47889FF0@VE1PR04MB6621.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(4326008)(8936002)(6666004)(8676002)(81156014)(81166006)(4744005)(2906002)(5660300002)(2616005)(7416002)(36756003)(66556008)(66946007)(6506007)(52116002)(316002)(956004)(26005)(478600001)(16526019)(186003)(66476007)(86362001)(6486002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6621;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbupx9GwThb3z6z/80n7/jHKE6GVE0qYv/vK8LY2a/oTEf3R/fvQwxm+Yc02gOo1/9Uvby1/a2kfny6xv352TrxWalSG2ZjQWRWCKVz537NnNRhfeHhiH/FFmtwPq/D6ZUZsGQcMp942lBjNTfxyu1mV2y1oz7bGIyzYpPJGlRGogOKgqOtdnqJoVVPzMeRENrRNIPxIdJPP1sB02sBizHGuPVxGFE4r9boh0EsSkoCIOqUNemIc8Cc2Ut17Fz07y71iZEM8Z2fXqwBvOltJqVQLqXDdNlh7cnFmmRp/ajTpZSBJvje9RHrB3qqIwttHsPqtuTK+3IxMMiqYTyacEDm4uwOhBb63AaFKFkrfYk2cFubKeOsCRZw2pHxnw1IGsgRY9aMGHNUh5Rkb+vahkIQ6bxyxcq/3pbj4zNADIxl6fnRKZvi3xeS+OZZ+N7gbJKM6JxcJTYyjNyntjJb61yNwYhFkyrSbXtBz0j3kSHuebXZaAlrrOPzIIR5Q0LyS
X-MS-Exchange-AntiSpam-MessageData: n+6Kxbkyd6+SGw+gk20H85piEdJkQhBNO5rqYgaUCEFVFTxXa4ldKxLglhjBbEHAQFL6BYNFube0JexYFUjkorwqX5bKF+Y7WoP9IiV2ybEjSIFySGn0fotM856pix/BSZ979la0JfhMBPZ0Rb0x9Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3aaea8-5b4b-459a-4964-08d7c4a3767b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 03:31:04.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caWZM2LyJJW8NyF6wSs45VhEctkvWMF4IM3euaAqlRo+JaeK4e7Qy9GD+vjVz+KpY38zJaQU3yr2QOTimj7caw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6621
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
index a7656a4..56288d8 100644
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

