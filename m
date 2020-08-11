Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857AD24175D
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHKHk3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:29 -0400
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:13806
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbgHKHk3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWkrl6L++20m5xgYrYSvBPJhKk8RdJuXh4atMyySsxTfHGtE7kEBihMXsW1yWdqAS4fqgnr1hzHuxunDkD1xageWqkgiSPLYiOs2x2y3Lpi3ZftaNFr1B4kBjq1RtdZTSZoxJctYh+S3ABMao1mljGylMXGBN7yLdi+sIt8YXnUbm7SStcQxV6hIHTa0kIeIiFI+6ND6GVXUx0+tVZY9BxDBoWTDVh4fvll5mdImNbBF9G/05hIO1ixSoiIK+8pBW2KKbMdqoA7sIZOHRf9qPaf3qL1GSFGFoZd8tSuPtGl++nUur93vYwY9upJZ2W2lSbYEt4lRFBjDq0DpfccSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZKBPwv3h3QlWAM24YnwpxiPhRgJFyrgSksGB04gjZs=;
 b=bQphhvVq0SAPk5U9Kg4q9fApNiBC+c59ALhOZd1/luJUYpGmBzOLcXhW0G6B4IYMQOUvuSJzfCBYrg639v4Ky7AXOcp7Zt4GezYiYprE+R4y9EcFWKO2X/JwXx5eRIf/M0dFCJ2SelgQP4KpUoAh6gTzdvHkiRzeusKURhYeHR08EDxaTu/9kzo4PV4Dy3xr7+VbLCl6rPiwNLup1+NZnGailKRNbnmTGik9vvlO//GelBETTa15ZvNCh/DMl2WljgrlyDBWqBNp1Q3HfBIAKlncvYUUSvLFYdZ+IoCyfrRLLIW6u5+q7CW3W/HF7xCmaUpEGOE23WgP3cNd2VMnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZKBPwv3h3QlWAM24YnwpxiPhRgJFyrgSksGB04gjZs=;
 b=l3pUHYpgJaa6wH0MD6cT94sZa2OQCcdrHomyoJlJL9i/i9a0EijD6iNds2fzobQ5XjWZcPUMCSn7jWY599pd0m43qppU4rho5a/OB5gRgz+9A3/Tf6O78WjWvuTkpDgBIsYaZFmx7uiMkqZu5fbCV7X8fyYPKdne5uXrC5lZsEY=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:24 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Tue, 11 Aug 2020 23:53:45 +0800
Message-Id: <1597161231-32303-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 671d6b29-223e-4bb2-3f16-08d83dc9cef9
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3464F512E0D4426578D283A889450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDPvHKFB6qqUWMvO5BFj1xMaRvcOGHlsPHb4NkhNOkTuOjWKrwyw8kvQD9KCexUtYas10Kv5MBApOZ/d8S7iUaj4+SBhnIiBM+UUE5b83BNBcrDPDLGbQZvJwhMGh0BFqNvcxT1HUrOKK88/SMrf/MioP9U+ImYyLrgRJxbOF8tZix6FYwG3ZW6DdVOMA5qYhiOarMpuFqHp+J8KMVTm65pHk/jAOkOn8f4bQ/31hLrdawy2v3inde2P7WHhhlrLSn6DurDHKnN5nV53zZ5DrniKVXA+fZqNnyxNU2ca+FD/Swyn1149RaU3LZft3JZFyWJZzmLft7J4vV+pWxsVqRa9EvurBlQ713BYDLiiNMK/TG23IWPO4eFIPQDETseK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(4744005)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: onPNCK1q8f1rvh5FHQz9MKcK0rGzfIy6DaSe4n/WNo0PBYI1/OIYq6kD4bLVSye4dsmbXIvtbRQkHan6rnaYBpEVIkSr7TOX+2loqZKUMHMJLSDbQJMC1c/MbMf9vs3JIZUZrOHk28CEQ64RVKpLNpmVEqz35OMrrs1aQW3f9zeW5SWkwPMS+gsoFr+1BRHkKYruQCzqM74qA0SRb1TkOBUd4MqXJpHtJVxEpoNWzXIRw7Ke+7A3geREsnUAG30ycnMk1oJk2R6R9KnGpwdVz/RqC69F4lyexwcr41EVGQCdgwhw+ZW5/CBT92w75Ht4C5lRDikFhDb3TKIOc6Zpw3zO5saRzeCD9u3wHSHySZDhKMLl2Sy8cBd2nIeW6cU3pJ0Odf46MiWxxZ+6EnRYbdyzzmIywBVtTuEj5RExg+CeDQrm+r5iwOwLKGTN9bAPGzyiimB03SRDHYHiemyJk1Q5Jw6eOYkGdyRIfHmmfzQ0YtLj2EJ/2yXFH2qcXWXaa93SDaNB8M7eXHowdEhyljjq+JS1x+oRGy1LYo/zz5EzB4vmy97qrq1PoAEpts729ciA5zw9o8Dm8gsLQ41bsKYbbgWj2YuTIEoh5SDFFUL+28GcnBz+PnASE0NDSHeI7u05FD7sDYRLF5oHMoF05Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d6b29-223e-4bb2-3f16-08d83dc9cef9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:24.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFQN1UKVXafHl7r6P80iej5ZZfZqHdgbD+nLhH8gEnatQYSagJW4AHTQ6STo90XEHWgdMCiLUkHTMF442QIGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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
index cf02c3e..d5d5d40 100644
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

