Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4C7A8DDD
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjITUiK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 16:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjITUiI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 16:38:08 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8769C2;
        Wed, 20 Sep 2023 13:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJVabQgVcAnRyKiskRj83p8GBIt1HLaliwMDZ4hxlrUQXLc3ZDTM93/sMAuVIeG7JpYSka3EmTn5HHI4hoZxaCT9JwtQuVMb1ov3wewxt7E1jXj2rUVzoXbOmA5sxR3XPKjZi6t3xBhaSjWpw/+BZgB+AkBlLlsJafih8FCCyIsL3YXPRxobPtGCK/kIr0nXDhl81A0RuQJzTQeIiAbm4fDyWKi/P6q+WHRkw+5UyOcA1iwCAEAtVeLwaNc+BlcMv9qUCaDaxbzPY4A61uSTxiIHUVuo+4WbBaqeaz8H7mQ+XhkFE/XpzrhG3RWx6sFRBoWlOk9pV4K3S62Gc/LDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAVl07Mj+b2bnHwCqU4ORdz97ykl6zmyBuZmnqicyE8=;
 b=SE2wAPYnG/+qtflo9kHXpP/3qIAxnnS4ZkBE0jKi8VHIMF5aBw6F0idnTmM4JBv+bh0vjWAoZBVJtC8ZB59AWwMMw1vFjcFVRt6wpihmEH0yPCPvR7Zw/TTg+aOcl2UWHKRnDLA3/HygkUWYDCwaeE66ZADcnd7M+7bPFybxxlHGIfgV3cUWBZBGkCrM7Qn4gV4GqNvC4r2xloaJeOnC7CsHPcNJmwQ5nog1Ax9HPtPbRTXRA8SXWmIliW6bpcJ2Lj/mcv/V/YmzfHopLsBsMqkZq3soFg1yeEGd59SYIpGb6yuQaismk3ebu8KQclwtEVHnxyYyMBWFmMe3eWdWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAVl07Mj+b2bnHwCqU4ORdz97ykl6zmyBuZmnqicyE8=;
 b=k/Gccu2tqTYWdX8XycaOKS88W7eY/hm1ZRfFudBrxs8RO/7KGYBgjWrcJFTAT+ZIwyWqPAhYjSm/7CZHfki1HCdfrIQVx7lZS4o7GpBXll5JDZeaDM2USalUoUmyzJvTk9n7IcNyf0hhfrU2+VXBwkwDu5lcXyHHgzY15nnjU7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:38:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:38:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>,
        imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
        dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dmaengine: fsl-dma: fix DMA error when enabling sg if 'DONE' bit is set
Date:   Wed, 20 Sep 2023 16:37:41 -0400
Message-Id: <20230920203741.3184727-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4478de67-24e1-4a87-1945-08dbba197a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSvqRE5X48De3hJCjptDyDW37qiUj+LMXimcOTjD1FrvW03LmrcfrBzysQvDIsf4EeZPzzOAbx3cbQIIbzdrwf5cVZFk4b8lN/qzuX173TJzW7q0JHzExeG3Q3itFOYV1DyaXirJN+e1jbLCGgLuy00aCDfCzxhP+HaLR6e+LXDZ8K3Dx5pXsn7ICpGQA0QsPp/VQDVsQ+lJLUqYjHDXTZNBbz9XJ647YVX2jIYNddVjqB/MCc/qYUoAwJRDE6qQrntXlvrrZ2LgmoBQ3kcFYM2BN1JRmL+PzSe1Wsdu2HR/BLNJk8G9WCzdB7eyRjofvjewtgqHLnHlBljwY/EEp2pnXev27N7kjxbUyixMq6TlHhLRwYl5neKkbmKuI+TmXamXoUjzIb8t4A0l4gjLF+UIk6ZLQUlqPDr6aPCRi4NR1ezeLfVnZKSHXO5HFuUKoIbq00hpTPgdLkUboBgmA6P2BM5XbJodL/xd7brcMJJwhByRkxJer5jIUl+8rKjtux5z/nm3WyMYYMlWPj9nS1thIMrvwJWc9vo1/4Nv1P7L3YvEBX14rPcWyrFg85vBlwFKCoEugdy5uNsGtk0Fzw5SWPVhvEWxDDfaANeR3HSCYteeOqCRl4lcG1CBKFZ6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(186009)(1800799009)(451199024)(52116002)(6512007)(6486002)(6506007)(6666004)(86362001)(38100700002)(83380400001)(38350700002)(36756003)(2616005)(1076003)(26005)(8676002)(41300700001)(66476007)(66556008)(8936002)(66946007)(316002)(5660300002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmHGZmbCRJqzKPr0PTDLn9sf4lhPJ/h8WqoT4CDJcvseplTL/UkiLdOEtEaV?=
 =?us-ascii?Q?8yQBvJE8//gbz/ly8HGuR06FEQxlQJ2iz60dwtk6XoqLxJ6dGhndarXcOYoJ?=
 =?us-ascii?Q?yyC4aSXeycV9+qJpLPxIr7+s0OSYMqtQm1GkS5hozGDo2X4ZRPUCajQBC4Dw?=
 =?us-ascii?Q?82JL4+3dlgD8/80s/Z8AQxNd1X06tCH9DnP1Su7kNcWe4zF3NoVWOpheLQsf?=
 =?us-ascii?Q?xnhhv88eotA984/L6AqOghyFnmS7eIkzKs+yyTWU65ThhW4DPgbHFSgyta/0?=
 =?us-ascii?Q?O0QOzjzOj5bOAea6+o7dyjWfOii73B6X1OCejAn/R4VVCBzCwaThpTtYU67L?=
 =?us-ascii?Q?Fre0QbgEVqYaRdJEM0dHKVFsfeENwBPXeObp117PHRl21ghzN1tdfC2ttAch?=
 =?us-ascii?Q?KFXX9gEsI/hsYs5zucsYx8rztPD+bz6CIEw/UNNxaOXlEESXaLwsYakudPki?=
 =?us-ascii?Q?sChm/NvT/sdzKtVRtO/1QN4IYnK3P1bXIoumev3JapMl7aAbW45pgluYndix?=
 =?us-ascii?Q?RQaAzOPNI+//ylt7zGNMmWUiggqtSXo2bCW62E7RdxMJ6sUYNOKFBQ5/GQw3?=
 =?us-ascii?Q?J7dIq+PsrnMOfJp4v6FBteIVRX5qT3OfaID6ODBB6sJisjyIN9Txx/UsSB/i?=
 =?us-ascii?Q?1n9BlmUl2qs1KGj2qNfWTghFIFclLcQjr9t+8yetoqfX306Uy4f4HgR79cBd?=
 =?us-ascii?Q?xGD1AAbB0b/6JKui033zE712gKs5vHgy328hOCrVIPvXiZbztSapS92MjhLF?=
 =?us-ascii?Q?OaNU1vMNXHsQq2CKQ7/u9ywF8XPKL++JdhgdDI04HugWet+4N5tzPLXSFtAM?=
 =?us-ascii?Q?fNcDzJQqlmHfeCUprr+d0FUzrYHry8z/RyDMn+QoY7IJ9U/1hfSjSxblI5ro?=
 =?us-ascii?Q?jI9Pfxy0j9vgwFtMDzh6pM662iMSqnLlIXsvtu3hn4eOQFOHadvSs53ZgoRc?=
 =?us-ascii?Q?8Da76JLFvWbf/x3aF53xCCBYVhKoTS0z3vYjOOqOWmTPOf2lNAdgAOsboLxl?=
 =?us-ascii?Q?h26vm1lAq4U8ihXQ3adVM1mpP7KMnGYlFPZjqGnVoblY6Is45nDE2pjs7Q1o?=
 =?us-ascii?Q?kb52Zw6UHBcDp0JkdeXQ0OLhAVnuPnSaDLa/PomUkjtrY7Z/AG4BlrBHQWbn?=
 =?us-ascii?Q?SRiThMe2UbPbGrf5zhkWN70/06VJPyxWzyjp+ZmXXh6FeQ2OAOjuoKv4n/hy?=
 =?us-ascii?Q?Tipm/PdJh9DkluvgyU4mND2d1sMs7prQ7MAFkxCUHioPFtfqi43gswTxd5J0?=
 =?us-ascii?Q?x/5pV4NSBdXtUEP+vJkbJ3lTLYD9qjTwtopQ2XeBXYxVKJrNuTA/gpb4tiGi?=
 =?us-ascii?Q?Mmgi/S50b50fPQ89+JYt6Ky2MUz3j63/OAlCH9G9974TRYApvNOn0EoZT5u7?=
 =?us-ascii?Q?/1i/3bTwRuvkqzVu8VmsJxMLOwxtCKd2EYT/drLoDWDUnskgjMjvi9M9I0QG?=
 =?us-ascii?Q?v6wVJJUhNpGS9mPMsNR7j8uzhmMMqzanjJuGAFvhCjzVIwT93SIpkycdZG/8?=
 =?us-ascii?Q?Mg8eWZyeNCY18LDXYzWAnIcs5lUs7lQ3m1g+LDGvHRaC7NgVQM1cXiF69aoq?=
 =?us-ascii?Q?/wMvEp+ZZElVtjIbDEA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4478de67-24e1-4a87-1945-08dbba197a99
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:37:59.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0tsRJE3qceWBH+qN2MZ9tMzi9FgljjPcK5M8XgvDWRRuZdHYjFK+b8KcjoLboY4UH9TRQMmmXGis7jjfRQYhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In eDMAv3, clearing 'DONE' bit (bit 30) of CHn_CSR is required when
enabling scatter-gather (SG). eDMAv4 does not require this change.

Cc: <stable@vger.kernel.org>
Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 12 ++++++++++++
 drivers/dma/fsl-edma-common.h | 14 +++++++++++++-
 drivers/dma/fsl-edma-main.c   |  2 +-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 70e24e76d73b6..2b834502e30a5 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -460,6 +460,18 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 		tcd->csr = cpu_to_le16(csr);
 	}
 
+	/*
+	 * Must clear CHn_CSR[DONE] bit before enable TCDn_CSR[ESG] at EDMAv3
+	 * eDMAv4 have not such requirement.
+	 * Change MLINK need clear CHn_CSR[DONE] for both eDMAv3 and eDMAv4.
+	 */
+	if (((fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_CLEAR_DONE_E_SG) &&
+		(tcd->csr & EDMA_TCD_CSR_E_SG)) ||
+	    ((fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_CLEAR_DONE_E_LINK) &&
+		(tcd->csr & EDMA_TCD_CSR_E_LINK)))
+		edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_csr);
+
+
 	edma_write_tcdreg(fsl_chan, tcd->csr, csr);
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index a9e27110ac7d7..6a74bf9facaa0 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -183,11 +183,23 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_BUS_8BYTE		BIT(10)
 #define FSL_EDMA_DRV_DEV_TO_DEV		BIT(11)
 #define FSL_EDMA_DRV_ALIGN_64BYTE	BIT(12)
+/* Need clean CHn_CSR DONE before enable TCD's ESG */
+#define FSL_EDMA_DRV_CLEAR_DONE_E_SG	BIT(13)
+/* Need clean CHn_CSR DONE before enable TCD's MAJORELINK */
+#define FSL_EDMA_DRV_CLEAR_DONE_E_LINK	BIT(14)
 
 #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
 				 FSL_EDMA_DRV_BUS_8BYTE |	\
 				 FSL_EDMA_DRV_DEV_TO_DEV |	\
-				 FSL_EDMA_DRV_ALIGN_64BYTE)
+				 FSL_EDMA_DRV_ALIGN_64BYTE |	\
+				 FSL_EDMA_DRV_CLEAR_DONE_E_SG |	\
+				 FSL_EDMA_DRV_CLEAR_DONE_E_LINK)
+
+#define FSL_EDMA_DRV_EDMA4	(FSL_EDMA_DRV_SPLIT_REG |	\
+				 FSL_EDMA_DRV_BUS_8BYTE |	\
+				 FSL_EDMA_DRV_DEV_TO_DEV |	\
+				 FSL_EDMA_DRV_ALIGN_64BYTE |	\
+				 FSL_EDMA_DRV_CLEAR_DONE_E_LINK)
 
 struct fsl_edma_drvdata {
 	u32			dmamuxs; /* only used before v3 */
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 2c20460e53aa9..4f8312b64f144 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -357,7 +357,7 @@ static struct fsl_edma_drvdata imx93_data3 = {
 };
 
 static struct fsl_edma_drvdata imx93_data4 = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
-- 
2.34.1

