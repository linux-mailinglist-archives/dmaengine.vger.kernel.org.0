Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB22574B3
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHaHvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:51:39 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728033AbgHaHvZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:51:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU1AfXyXLszGkI+k9v+s0R/ki6EwGH1DJW12YxfL7dlezIvEt/oa99zBREGFEkBSBGrfmx3lEGAkuWJCvQC0PdG9LPXb+RB4Q7aj8n+Goxn+OL3ZDs5+BxDBkB9tJR9dIgoBJtCUDdHSgS9hjLlaoMt8mObKz3bel3ndpgcp3ZfVUT0xGfb0gottpY+/USd3bVn+kv0lDMDUf4DDTkpA7c/MTHp83NKN5T5sNlf32ArrGT8nb6lOYYvr5icj06Cyd+Jn5C+IlbCUW15t9b8dp/Qp9EBhtXYQfhj6nvLXNxWQDeiI7ih17sLmYmTjapj7WjWt57bYPjr5aL2HnmZP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/sXCZYZqMNc+2wr11POB6/DrTyhYASzg0Y0zEWA+fw=;
 b=mgaxvCyZ5Bje96l2L+sYufe8X4fcgTpSDxCd0Hv4bHn9nH2DC0L0l9jGZYnPA10XSoScC/MFwACmg8dh7xG2/O1ekpyCC8eavHG2Z1gp6M0JFzSysOQvWWpwZXdPTsbmbnQ2+WEPkmaoT5DaivbR9L27xBdnPwBk32oZoSRWdDmLI6DRD8eYSJjwlM+6DuioX+P3VQolM5LyXRyAQ7fCG3LEXFVVTWkF8E/VHplZlqrT4RB8piH15+yPA2rfBOpw4Qfz6xc9k5pZ8HqXd6tS22WhWXkyiUR7BsQHEQySZls0RDv7t4J9ojcvOBkTfjgu8jR76Hctmk7ntz58kZE/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/sXCZYZqMNc+2wr11POB6/DrTyhYASzg0Y0zEWA+fw=;
 b=HW3D6UCpKnJ5bRD3xD+0PnmUgyXsluQy1ONfxD7WQKN2AWR0TU/QxHUnptaiFGUWBt/OL4NteCPpvy+oPj9NhtePNCU+7XdXt+vY5V9ZMlGxjZQFiX8XHCYySgfVG5ugQD+UsdIOz9SXs31hE/mLHagLqAHAfLxTu+tqg2j1zGY=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:51:10 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:51:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Tue,  1 Sep 2020 00:03:19 +0800
Message-Id: <1598889805-30399-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:51:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4513fa5f-269a-4ed4-aa7e-08d84d829fcd
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694DB52D3E19D46B6D83E5C89510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7lRGWNYHi8vA4+pgtABpIgMisbXAFjKvGjlillyK0M4OSHdS0JmIpaskBLlnl3UCes4ElOrDX2qZgeLNfHI4jk6jA1qfSeXIm8X2U1LiOY3RlOXAfalgYNNGtCG6vtXIMH0QxlXthDrNekq8NX28B71f5V3As/k9P7NCmc8DRL988LK7NXlPAFBFUgUUni2p7nR8DYe4MROAVLDxkgUJkclMZiUMxnesPjdkF5gnrl6mlaHURFfKD15dBXrXSYnU9fmQl7cO+BFYHbdeT7D2Sna7jPgnH+TOXxGSHp8QDDDx/8FRKDCV549KeZKeuK/YD+ISij0YQXSkGscKVWLh4+5Rlxsi+OkeS4bbxdght8V4aGBM929Tpr+arU1vifl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(4744005)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cIisXd3EcZwhtRxN1D/hiM3qX6q4yaHzvce28p0xyZzQTxew35OHcX3GQ/It3qz6TBokjQXWzi5UjUmStDepY3YKpGCOhY6m6Uf1/52T7jlN7P3r1hiJzK5bOJ/7kBgde/kLV9QfzO2Au+TLPs8CuxA6elBMNORckiT2i1Zy2FJms3/FpDPQqytncI/7u8dxVnwhGlj/qy9omJkIL19Qy/usubqB9TGkZVGI2IJPLVftQ/myXwOODFKvIWt4vCYdM2YjHIVqv8YxxtpbdyZT2hcIh1PSCMa/2rUN9+2ymKN3laqWq6k+zJhkG0GoOolBXnNJhjKLQAZTsEIZEsGK4+IO5v3taRrlFd+1lSbcQZbHTdunsWAgs8dqYpkVb9oN+1Zz/+B5AxdtUZ4C9zo9nAaN02qki/NLPqQuSaKFqGHSUCYaPYUBe7QEDSY4/JR9z4y6yJ8MQ/0Kt5ZblZ9D36ItvTuNcD5JodUDX+mXk+E4Lenurptt7Dxaull4YVTwlFacYBCtc249pYhMuYk/p7WqaarndAydbN1bTiqOUdnHcmlDBTtpNS52BMaxSNfynmKcb+Pd5kVOxIPfmxYHChfa2L3R9Lmz2frlgDr0zvvtxAwMhVdpYAnuMj1iRG9GE9YnVwed0+G98SwCIUa+RQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4513fa5f-269a-4ed4-aa7e-08d84d829fcd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:51:09.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkcicUVh4ln94JiOMwC0LpODEsIzkp/O/Bgc4Mhm/N8JANNFW+URqeDqKn4f0uqVq1Zngmf4K9iuieFq4ki69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
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
index 10214bb..fb522a1 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -924,6 +924,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
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

