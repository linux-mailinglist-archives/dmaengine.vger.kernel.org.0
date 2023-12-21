Return-Path: <dmaengine+bounces-605-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B881BAE9
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC54B289DE1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4755E6C;
	Thu, 21 Dec 2023 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dzWYkL9h"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2855E7D;
	Thu, 21 Dec 2023 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9JuaKPTeecNZqAFTbOZS4Se4itrjvQVg27lN/bVKJviWrG59Jsq521s5WjnTc3qWH35sTOw7w4x9YyfycMkhwRxoMDPX1sjoYGxH2LVNnW/1Gzd8prhfZdd9Xk398bX9hH65fPUjLmglepwCmWp7KmqO6EZnys/dsifupA1wB/ZN9a+YpwmOfErXpPIH9F2GvXcACCqa4AqdpuoTnJADrPlLzWvvJuMSg3C/tYwBkj8q5GQgK1veI/kIY8pCbAv15gTmgNdrJZjEbGz9vVCDS67FOi0jHGFkrdUt+qXHUcnNTpH5VmbFDBIoB+fdmkFI9GcHTNhaEE5K4wEoNP4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBP5q908Ng9LIH/wfPFsI3Scpoy1m/sgOEiCWyttsb4=;
 b=LG2FA9VC8wbavf2mzrjt2PJ3VVpDVZ50aqCXrw/lHAootdKJlGM07tNI3OXwdKzc17v1cfUIPUNda8nB9Ps7DWUOhaUg2b7we31gXVlQ3ulbbKMsNZm7L+7foN1aCxQemwQdVQQH/twLHUkw43hXBEMaqCRNm0Xs5imZx/zQ9rHgqDxBr1IXbc0ei5bdpx7LNbLSrpVFuxakdZIEUwh6KxwXBC6r9IqK9KTMksZcRR/ICrmLGZZqPyYj0nFZNYXzy2h9wYeToDPGmXSDy+YnftQSXABCYXO1NThJoSDQQCBR17IBNTq2ZXgX/LQba5zF+wBX46suD+nKUbKh3uu9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBP5q908Ng9LIH/wfPFsI3Scpoy1m/sgOEiCWyttsb4=;
 b=dzWYkL9hmQf0TJdcVC2ZxYGd90fWbj5hXtiq4iS07A1N9PjENmX+/xeY3z+rikjx1GtbWaRFHfEG8nR/7FwBUrrS3A37sLy/3x8aEaqneT5k3jg8P64YGcScsLSrVjNuHSKNhIJ5emw88JlOU6T60nJDc2yG5qZD67zSWdfNmIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:35:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:35:55 +0000
From: Frank Li <Frank.Li@nxp.com>
To: joy.zou@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v4 3/6] dmaengine: fsl-edma: add address for channel mux register in fsl_edma_chan
Date: Thu, 21 Dec 2023 10:35:25 -0500
Message-Id: <20231221153528.1588049-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221153528.1588049-1-Frank.Li@nxp.com>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: e36c446e-3f51-4a53-cff6-08dc023a854b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qtQwfD0rKDd1he97GepXtVkxYxvKRmy9okWYKVqShuK72FsyAb6bLfqeFqZyNNUZcmUS3owoEMHTW13yuBcafQwFD5G9HgTrn+UjEMRKqO1MSkiNEv9BjcI6qc1dAYwEKF8DjDyKObhfbK4WdZcZs4V4NSus3E6oMrSx+f+e4pnEYc4uS7VyEwJkDOe68W5CFs9WNpDEj0ODCDj97R5lk/jGo6HzYburALYfzwxpQsrOuDriyGODkel/5FpJyhsKQzcotLGlUitS6gu4yiHc+Gq28HOtJ5q9M6wzZVcWcNrx6fOJ4QQ8vKEDusS0GDnORfGc8FORxNbCZ110XeSyozsI6LgeONDVp1xQQfFP62hYMynMNgIut12YzujWcGvmIbp0+iQ4I7E0dpYxdR7+NxDvRLYItSTEGoN0Db24ILEIQ9hgGUcX7h47uJQkiaTeihIR0UDTIm7n75GzOU6Sjax5BzJtfDCS96MT1NeUhOfoOv4ztZ8H3Du61RPrVv2kOk7Yik0ILBL3/cdrz3eCHtqvw+wp2yhyT31/ElaniUYWGOeqpSKRLlbl+/w7e1su01RIt0uzeOjqTuT1Ls7zvuGm4GWSErupLXn7IW6KNvb85/fnJFFErX72zIFJNKAS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(1076003)(2616005)(26005)(6666004)(52116002)(4326008)(83380400001)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66556008)(66476007)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZ7z5EkFCTmLGzE3WZjHMRk6f/9YCRQb6Kvxm1AZL10ZMXgs4689BYxi8P58?=
 =?us-ascii?Q?Xk3pHAwnVQC5qUZmyfU1oKTs7sh+Gge6erLoZDC896b8Prg1KMXF0IAYVfLM?=
 =?us-ascii?Q?iS4gXqg5N29WQ0cA4bAM/ff6JhdE+AElejHMP3XWnKbX8WFOUosRsotZq/Uv?=
 =?us-ascii?Q?mpIa2CGHAR669QKJOgfVI3jphB2Zca4Eq8XkSiKLjCNztJ5Tln3HEfze+Tkl?=
 =?us-ascii?Q?JqUgFSYn/Q0Dazn9ZWUTJ/42y1uO5o+3o2RILk5ryDElbqriuSF2MJ1tEGSR?=
 =?us-ascii?Q?kT71RC3FtVRw2RVyHzmjn2PQCkmEWu2BgLHFYoZ0l0T+GmK59tZekbtde5u8?=
 =?us-ascii?Q?zqR4r6QenWoOf/VSJMu5T5VtnJ/lwSOIfST6Cnlf4QzDlNpVLkQsRFKxnpps?=
 =?us-ascii?Q?li6ekssRRhK5p8o5MG5SqTKVF5+Fsy2bKATo7FVabrNkkQLwPSmQt/y4MqFZ?=
 =?us-ascii?Q?+ffLYV53wXbQ7p/7Ivu5HMoALv/jTmAt12iv2S+BHiiHMc0xZg1AV9pMdy9C?=
 =?us-ascii?Q?5llk7JJGSWTkEwpgOqwKKV/vMJ+DdrXmhxt2e45vneyFkyAgi+MqMMz7kb1w?=
 =?us-ascii?Q?Egyrp5f9K1agTN3qZBs9PbC8QttHpxyC5NFId1m2igTq7OCCeo0mDjQWNtbG?=
 =?us-ascii?Q?WFXrgz2MkoEbE8fS9rrIHLuqSQCXFfltaiWgjAtj1KD9fP4NQJTtwYYse1pc?=
 =?us-ascii?Q?3K90oSl73818H4mYbaoiRCYxK26HdD2Y+WxB8lgSmb2mUqFuLMEy7+BuMuqO?=
 =?us-ascii?Q?/gGD17SNnUg5Sr7MwGf72LDig8BJZvSDTRxi1Z4kv4IBLrfwxSYk9AMknFWK?=
 =?us-ascii?Q?Mk4VmwfPxFUEJZUivEt1OPmP8b/xelVLGDpCiDArmo7f18UCPAqk8ZHOg9KF?=
 =?us-ascii?Q?CkNMYscDVTDazL+eaEmRvT/Dp/EK50IHeaeR4EcQvV7goNevh+19KySumdnL?=
 =?us-ascii?Q?GL8Y1PMvYpzhK5yvFJR13VUeeo3FjmNesr+YVbmUf0gtg6X8lwBQFT53NSdQ?=
 =?us-ascii?Q?LUalPaUWXc+Ol5ef9+ZD/YQa6Apw9cE8NvbIgRyz+pbrGJ/3tQfPXFJODU/d?=
 =?us-ascii?Q?I/w5Wouy/d1i5P0as0RpWAOtgXhEbM7Z5xcpVJZx3JxYbqAqtcO+ee4JROPq?=
 =?us-ascii?Q?BStBZEahVlb0/jc5uVXnFABtvMyRHRIN3SYR0JvB3AUYFLA2opDGbyZqebX2?=
 =?us-ascii?Q?P1L6TC5Zx1sNDMGGTd+im9p+TOtPbm7XLCWrFf+2YbaCXleVDca2Bo14lCQg?=
 =?us-ascii?Q?q4lg9XpasXBWawYo1jEaiVDlEhBZoKw66v3P8azSziarCoP8aKaERX+bWuHx?=
 =?us-ascii?Q?D2LpPkDoD6joIFNHNeWe/XVRu643gnTFdIS1QEMtXSBeUTyORek1/I+QTo0z?=
 =?us-ascii?Q?r8yvwwnK0OIXvsWnnCAIUCVWkpmF4QdtsoZpM+FZe91xzveMp4vRXaDbS0iZ?=
 =?us-ascii?Q?nKDBMNRfnCOwqrQCUIL6e90CuaeWh07iTFxHO6p740gzoOuPLtcf5oo/TBoP?=
 =?us-ascii?Q?x8wmMizkZPu07rYF/03jVywsAkQjdgOnNQM9Lp9+3lkGaK457twbWMLmVZ6h?=
 =?us-ascii?Q?uH+CqILH6OBpeqUFL6F25J30cWfAoEqBmdVmU+Qu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36c446e-3f51-4a53-cff6-08dc023a854b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:35:54.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIBZNhMttZSbFiltZO+raXrQcu3aA6Q86OX690MHGVClXBnzx/0uGIih9ic8n1ckLHh8rg4Z7wM9ZFY7N3Bomw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

iMX95 move channel mux register to management page address space. This
prepare to support iMX95.

Add mux_addr in struct fsl_edma_chan. No function change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 6 +++---
 drivers/dma/fsl-edma-common.h | 3 +++
 drivers/dma/fsl-edma-main.c   | 3 +++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 50f55d7566a33..65f466ab9d4da 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -97,8 +97,8 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
 		 * ch_mux: With the exception of 0, attempts to write a value
 		 * already in use will be forced to 0.
 		 */
-		if (!edma_readl_chreg(fsl_chan, ch_mux))
-			edma_writel_chreg(fsl_chan, fsl_chan->srcid, ch_mux);
+		if (!edma_readl(fsl_chan->edma, fsl_chan->mux_addr))
+			edma_writel(fsl_chan->edma, fsl_chan->srcid, fsl_chan->mux_addr);
 	}
 
 	val = edma_readl_chreg(fsl_chan, ch_csr);
@@ -134,7 +134,7 @@ static void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan)
 	flags = fsl_edma_drvflags(fsl_chan);
 
 	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
-		edma_writel_chreg(fsl_chan, 0, ch_mux);
+		edma_writel(fsl_chan->edma, 0, fsl_chan->mux_addr);
 
 	val &= ~EDMA_V3_CH_CSR_ERQ;
 	edma_writel_chreg(fsl_chan, val, ch_csr);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index fb45c7d4c1f4c..4f39a548547a6 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -145,6 +145,7 @@ struct fsl_edma_chan {
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
 	struct fsl_edma_hw_tcd __iomem *tcd;
+	void __iomem			*mux_addr;
 	u32				real_count;
 	struct work_struct		issue_worker;
 	struct platform_device		*pdev;
@@ -206,6 +207,8 @@ struct fsl_edma_drvdata {
 	u32			chreg_off;
 	u32			chreg_space_sz;
 	u32			flags;
+	u32			mux_off;	/* channel mux register offset */
+	u32			mux_skip;	/* how much skip for each channel */
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
 };
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 86b293eba27c2..d767c89973b69 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -359,6 +359,8 @@ static struct fsl_edma_drvdata imx93_data4 = {
 	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
+	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
+	.mux_skip = 0x8000,
 	.setup_irq = fsl_edma3_irq_init,
 };
 
@@ -533,6 +535,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
 		fsl_chan->tcd = fsl_edma->membase
 				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
+		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
 
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
-- 
2.34.1


