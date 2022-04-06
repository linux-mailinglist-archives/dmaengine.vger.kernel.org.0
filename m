Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1074F6726
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiDFRZs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiDFRZi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290C4B891B;
        Wed,  6 Apr 2022 08:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5mcwxWwaacr1v0hS9mB+Xkp5OQdQn1Eh+Em/NPtixvIxzVPw8HRgWXEYD/0+2nbtb87GZVs45StnuV8u0pPNPHU4YlqTqJXXr+V3+hsJ46b89pSb+BaYw5PdRZtxmxzoc320zeriTLCUd62aTQWZlMhL9avw6WWQJwY3E6eCU90jeKwX/pSfvQ50XeM6i1GHSnXnNz+aYTqPzkSHE7ZFog1hFac0EtiDzvkKcUepwj1/jy5gJ8LkvtBmCsyc03G/QBEfpzXV49avNxJxOtrJks+G/789SoPFddXxMVhKJDAwRHeR/tQ7/Q0kAk2hd4zvFEeC8+Pol7Y3SfXu7yCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SCNm6g7OCnem5Ndg2a/x5LnrvhrCmHwnEad0Xypc8M=;
 b=GmvjmUz6AR1cITpni94zkTvpvtSMfGb2v8i8QQuHcrq+20apmZg4xWyYE2k2TR69g0YfvnYB/hu/dRWG6nUIZDCFQsy8GSMgF5R8q6TYyBnvNj9DanX3sWO+pa7iug9qWb8kIiH1jHvh2Q3tpw0weSybKdjtjeOz9+HvPAMW+/ZgIkB2jtm0t/S2/YeTLAMn1lIxS6kSvJumMtzzKpxQlY92s22DyKtYIDHndqUOLxyI4xlKLP4rubliDYfPwpI7gfDUklFhZWe3BUUH1tIGl1Pi7fak/HuW9oYy6HGru7mTJBw5XcMwL2E+zvbsTEHCURCC/xufcXfBmNFhvmprwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SCNm6g7OCnem5Ndg2a/x5LnrvhrCmHwnEad0Xypc8M=;
 b=EAJR0dVpy27p/PQcsTBPlGTwuXdhtkJ4MJSt2zoNksyKLX3+V9+80C3FytEVpWAccGZVQxG76MrkHRL1sK7zdKIY31b+i3MWjsbVnGAdeTP9URS7B/EpsQ9+dl0Au7uCGMLByFeWe7ecX78br9svqYrNlYt4/ofQxSry0HDIQx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:24:32 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:32 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 3/9] dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
Date:   Wed,  6 Apr 2022 10:23:41 -0500
Message-Id: <20220406152347.85908-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406152347.85908-1-Frank.Li@nxp.com>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f8a24e0-d7f3-4ab6-6f7c-08da17e18c8d
X-MS-TrafficTypeDiagnostic: VE1PR04MB7343:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB7343024990CDD269B576E45988E79@VE1PR04MB7343.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEfOENnN6McUUN0ToMVcLEVuM+7ZRpxWkHWYktWKbccW1Nn44Ek5Y6u2mCzk2zAWcJCmycLAAjNCp4J1MSqY0cdF2L1+fikBkxaEu5trfAeZ62jLUvpIc36g1wt9BbaASU125G++8/QBZS91/62rOylnaNDEnGcV6Tp1mmveIQpc8xCucr86DvESIS/UlNz+/gYb9dfL8wv0sOhA4HuS8JagVcg11FV40fb48Zvo+GWup0uRyNrgRpcHP33d+oqdfu80phPq/0O2R8x8C7AvUy1+rY07XXhfG9+UGzTJounrUYQxHIc+Rsnamz6oyoTSIGXmeBSz6GpLR4lhNlHCarN+BpWBgheWsBBae7kCsp/VhAR0f7hpOij2U6r1cE1esgJDw2eoH4MVIgUjehSqXfcAcMIFsTX5y44TCV7TzRNVqti0LZ0vAxhLk3w7ir5NWxoSrjePyx7+wEcjnvZIlklC2mhlM9n+m29AGigQBWm04lb0BgrsVmqrjuxq8T4l6UYLXMV5pw0UzcB64gfSobY2rcMo6m9vtDLKW2kVyEacRak9KzqR7nVseJiARQJGsugbhwy4ZzlQU8RKY6gxlPKOXhC9OzAPOg9PCiDkraD7IrmCVTUboxTck1TE7dYVbf+e3CzxFnk7SW7/NfmjqjykMwlSaYj2FTwSuf382O/EU4kYR7GZyeZFid3gpCHPo6G5VN6sHEBOtYE+RQ0JMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(7416002)(6666004)(36756003)(66476007)(66946007)(66556008)(8676002)(86362001)(83380400001)(4326008)(52116002)(8936002)(26005)(5660300002)(186003)(2906002)(316002)(38350700002)(2616005)(38100700002)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wOR0od0x28XAicMuIHirmQyzqd5CVHJOmO9GgA5lX9/6SLoqch4uN1gol8h0?=
 =?us-ascii?Q?gWTvh/9DkjHPADwjx3NmIWonvVQXV6dJJaHAN8A9fbJisqdf30IEmVAp2RkH?=
 =?us-ascii?Q?620s6bXzNSQGhY5QA2C+cPScJlGY3DWNlY6NHWDdNhIYtS+uhW5O/YdXBPVr?=
 =?us-ascii?Q?C9o50Q2rEj4a3rhE11ag6P1mu3WzHm8pkOX19FnigUDJTzG0oGOQvNA8T1oz?=
 =?us-ascii?Q?py2pITyY/SwlKAqo/3wBYS/+MDD7Kn9BC7meveRJvKxhhk9bxh9AMorDpJUC?=
 =?us-ascii?Q?YlV58tJUhjv0TpoDySQ+z1Bo/OnDZaQS5epfPb7UTLwYbZ3uc4eOn9LZtT3i?=
 =?us-ascii?Q?JP1SRXf8qBiEJNRzzumtuDtzpY7QlUImhD3eyQLTqbvPhQlZG4s6xWOXKe/k?=
 =?us-ascii?Q?uhWUYhmJjsb7Vl/HfxIwoDGp2fuW/oOcDXHwb03w0svHJZpFqcy9OPFakzoo?=
 =?us-ascii?Q?aZVfCHR1T6bPm02LWVdgkJifiRiwh+5V76iU78Twj8sjDEVHdy10/de863u4?=
 =?us-ascii?Q?XVia6xzS4hRFyl7pmIIlNZJG4dmPka3z5bCrWgeVUZ6oslQZBYgQkhKxymYp?=
 =?us-ascii?Q?06sc2oopgE4RzVItYLNlx3cyxLcfR2j6n/9yV/lBdWtpnahIxav5Be0WfRUl?=
 =?us-ascii?Q?C6QTixHgELJ4v1nysgNpUUCsrBWoxiT/JNOh11hHh9hdmu9zViu8f51O4Bah?=
 =?us-ascii?Q?K1ZdtYXpJUCl2zsUHP5bRU5GT8EfZOMI4+mP6AGYrJhUVDa2aWEbtdymz1uG?=
 =?us-ascii?Q?kJ00OXjwn09RazD3k8qIQl27UJyxzfSoOBL4VerKh34s+YCoUqHaFFFshsLn?=
 =?us-ascii?Q?F0k8UDez3i3nsyujlsJ0OOGk1mN8ZL1rjTYLZhXoRHGCf/eTCujrqpm3r9IL?=
 =?us-ascii?Q?/MGrXB6Zvd8e1YS3v7IZXah2n2Adu5XMx+83BA10/Yq85UP0vxoApvaakHiI?=
 =?us-ascii?Q?r76HtbQ5fIicQsicHtO1QYVwMb3Sk1X49IsxOFgumvtDRUxPzBQ8YauUCoyT?=
 =?us-ascii?Q?6Si1VnA9kB3KnasbrR0bmoO4ielCYCtBKKdgN9o7KNgwISEK3e3bbU0EHfL9?=
 =?us-ascii?Q?vfJC+Xmion88ZaSwr8tGza/v2FZGVZEmi8QOHWLklxUXMTJfvZQj9+bPyUIC?=
 =?us-ascii?Q?dLBPZvi58Qh+gRQbgMwmVJLmVqnegWgsFKOBgr67UH/Z2YsvXKl9ZIEcFAK2?=
 =?us-ascii?Q?H26b8YPwepD9cqr8wBPxwLIyc4FGcXZIoJeOiHMdL40x+6UafLhVzcoDZtmJ?=
 =?us-ascii?Q?q7Yaza8vxEoTMs9LDU5g+YlRqyU/YIAvByAl616iBXhTppalczEKiEttl+3P?=
 =?us-ascii?Q?KFxzbzoDHYN/FsrpUU3QVxTFbBmNDQNOLEZ7Wak5j5DMGEcra7LCvnDEgw8k?=
 =?us-ascii?Q?SYXkVgT+KXLP326zgxvnuu+TPw/CIkB3usqVWWsZ32KRBkr05kv6Uz5s/Vwm?=
 =?us-ascii?Q?jP/jaWKRC4/HZL5CDM9RyZ79wt1qoNN4P1HRKaDhAuAzLZL4V5QW8O7yUyFe?=
 =?us-ascii?Q?hHQlVZ/CymlXHR2b01931sg9ef4t2sKychCGSsY0QSrvc2K3rZeILWgZOfXU?=
 =?us-ascii?Q?Mf0RnvL8QEXP7zxoTkJrEwJx4LYL+ACme1w2S6druEuNpF/QtD5BpSV0p+BE?=
 =?us-ascii?Q?y00X2mF17VkVJYleaWq+K8wdmEJQpoqaFYa61BGGAnNdQ+d8CicoqNERa2wo?=
 =?us-ascii?Q?oOw0cL0A/teVqfLxANzk92RTPaNDAdgCuWfq2OVJzMAhw/1LNICNckRincS/?=
 =?us-ascii?Q?NrdAgLpIlQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8a24e0-d7f3-4ab6-6f7c-08da17e18c8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:32.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A97qUiYfEkjm26fcY9k0lzOZyUvxLuj0gV4Ic3SmHcZXvZtI5SqOj5oLeufclb3KA/IFvsfcOnX1u771Eil8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

struct dw_edma_region rg_region included virtual address, physical
address and size informaiton. But only virtual address is used by EDMA
driver. Change it to void __iomem *reg_base to clean up code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v5 to v6:
 -s/change/Change at subject
New patch at v4

 drivers/dma/dw-edma/dw-edma-pcie.c       | 6 +++---
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
 include/linux/dma/edma.h                 | 3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2c1c5fa4e9f28..ae42bad24dd5a 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -233,8 +233,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
 	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
-	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!chip->rg_region.vaddr)
+	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->reg_base)
 		return -ENOMEM;
 
 	for (i = 0; i < chip->wr_ch_cnt; i++) {
@@ -299,7 +299,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		chip->rg_region.vaddr);
+		chip->reg_base);
 
 
 	for (i = 0; i < chip->wr_ch_cnt; i++) {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 082049d53ca73..8ddc537d11fd6 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return dw->chip->rg_region.vaddr;
+	return dw->chip->reg_base;
 }
 
 #define SET_32(dw, name, value)				\
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index edb7e137cb35a..3a899f7f4e8d8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -288,7 +288,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw)
 		return;
 
-	regs = dw->chip->rg_region.vaddr;
+	regs = dw->chip->reg_base;
 	if (!regs)
 		return;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 6fd374cc72c8e..e9ce652b88233 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -39,6 +39,7 @@ enum dw_edma_map_format {
  * @id:			 instance ID
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
+ * @reg_base		 DMA register base address
  * @wr_ch_cnt		 DMA write channel number
  * @rd_ch_cnt		 DMA read channel number
  * @rg_region		 DMA register region
@@ -53,7 +54,7 @@ struct dw_edma_chip {
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 
-	struct dw_edma_region	rg_region;
+	void __iomem		*reg_base;
 
 	u16			wr_ch_cnt;
 	u16			rd_ch_cnt;
-- 
2.35.1

