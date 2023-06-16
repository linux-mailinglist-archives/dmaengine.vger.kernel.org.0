Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF01E7334EF
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjFPPgK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346073AbjFPPgF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:36:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB935A4;
        Fri, 16 Jun 2023 08:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbKUncTMSk7QyYlvG1Z352o33C5iyBSh1cf8pBeLvTzDfvEcT8G076hfG2HnIGmkrcwPIZEVRyyKtuTVTWiS5WeabYcILEbPY4jSSGdBPMgXDedJEEabdxijWd7InVKCV1rVfF2Q++3a+eLjq4P9qno1wVfrqlvcztzfg93iSxNGB05z+Mpe3+m+B4KTqktBkoJvtiieYYJv1k0lU6wo+FCckrGU9mBHbZQeCGlHNDuIjLRQGIgP7rGbidxWGJ3ZNWC3ZTU4paevtCjT+gXiZkeqcsdqYL22wQqVzs7sSrZAW3hLX8iPZaT6OiDbOFnc6MOmWElmhGh7eXJmlgNGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=fgylVRpHDTE9jZitM6umYjtjscRIdveXgU0a+e7S5U1AonYGecign5IStdLTvDtqeZLYyenPYl/BhjVjl73RZnHoDVaravoUF90ghql1DN/nbSvTK3uIMfjXV/Rhtae+g+l1jiSNewJdxhNPIWaH16/taNAhM7BWltXsaCDOsZMMLJ4ZyinCKJjdtn1TV7hZUPOdKvIR54pvR+vj4C9dQNhaHGbGUTcy5SAoHZhYNLKz2M4HZ6E1N6J3Vvclz2E0z06MsIT9u0qC3fSXhcnrcr5WGiJnuwrcnVqPEURuDAYQD54JyVqvAI9n4QXX9huVALJEgPhhRvC47iLqjrUjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=GmO1orl0d/lAAw8EgWd+psoj+wNR8YSNMn4D4nTjtTqI1ScNPRzZmJQASNXpPLivR0M1lw/JDBDpj+2DBp1Oy+ObqJ2bbKQ3rZVw6VIuVRnHFSJUrlXeqXdovbFHVzRwj4OtAyiy8fhn1pR6JrqBo+VmwsthkY1yiioE4Lp3ZDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Fri, 16 Jun 2023 11:34:32 -0400
Message-Id: <20230616153438.2299922-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616153438.2299922-1-Frank.Li@nxp.com>
References: <20230616153438.2299922-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 185a13e8-5dfb-451f-614c-08db6e7f4669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InVgSUxRDqiULwONQZDyutMOvepxCLUcOC3824BJJW1xsyq3UN8p9ZwE0A+RlpDfs+UAetmpeDn/uphMa036eaf80YDMbpIK9X8RzSO4GCLp8rV3lq7jVA3Jnef6NyQSqpJmaolGhpRp13FfArVucjaMfWj0eQtaP4JGhbPCz888nibHbYFjvJZLr+yfBepn5DPDPb/GHtudyfz7ngUU78u7A+WrHK9XDD4jUavaM0O1AC6fCYa/D3m/MiWtFZy4blu+JU9yvX2Qs55tWFSFog6D1PTzb6XFVtaAJbpYOxj/oyhdOn4fkzuYnrNC8lMYsKwM1/GBNwCOetQBIutnQo8rTT02YlPrmCqeCGUz0KAKTAXLlxoACJKMrD4kP0HtbKZa4sTZWdM0DtJiAPacsEpszH4vXG8bTTr/EZshjWoEfQHlT1Ut7I0nt9TVGAXln0AXZxO4i1QFw+HL96z81i1KnE6z2pRZ2okyjc0pCl7UOvnLylYrKz5IBILbb0UIfCmDMknYZNd22KmVJt25kHTSIZMkp0Zss2YZV/PUXra6ZMGWccym/urK4SwwJ1xuQoPoyJn0o/BEBp/cN9Qd8I2hfjIT62FqFnsnAz6UCFaSt2KKIX56SGhxYVCv3nFk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2oUEd+gxf3Gbq//lNqU0yWlpvVKl2Px/7r7FCpWO915qwbqpmwldP9YQ3+ah?=
 =?us-ascii?Q?1iQTSFXaaUGI/d+WMNBR2Z+v0TmpxmFA99av2mMcY8+lw7Ec2eFJEiOGX07r?=
 =?us-ascii?Q?XSlpLvO1K5YpyD/OngQTF00eiuMOWz5aZ+wJq+YP16/TZPNwbs59eTudGMXe?=
 =?us-ascii?Q?JY0UT4FePXDxHTHiNbBUphYG7jAvwtYrQILLFPAlO8a7JK7scW+IdqkIBuVL?=
 =?us-ascii?Q?FuKx1EKpbNVsuek/kFn/J5ewD9q8h3g943JL4JfcwAn/anl0mom4ybb9MavX?=
 =?us-ascii?Q?Jggb2AVG/oR40YkF4tAUZYLr5LszT/SAPFnldq/YcPeBuQoAf4iW9MJVdwSI?=
 =?us-ascii?Q?ziOgpFvjrORcrMDt5Ml5Lbu7kYs6CsoY0ruHlSBy2ywpTlv6KpDoBGX3brdM?=
 =?us-ascii?Q?yjPkBhzG4fgcwkPG3oLEaB3qJHKf+BoUO8UfxYxT5nqp97GioEV7LAAgbKBG?=
 =?us-ascii?Q?2iGhnMCwPtH9eUbC2xQf0XIbbqMrdh9u2Mf0wS+4lG7hOKmWnNBXtFhu1KKU?=
 =?us-ascii?Q?uV/HqAcGpS2G2RrXPy7ATSWxwbTarp8AKpkzAInw2QV6bACtlJ0decdh6POl?=
 =?us-ascii?Q?K8lASUZQHoKpBinrjSrFrMNia/O/18VyXgaG7CaWdE8JQDp/GDzl1TWSqvYh?=
 =?us-ascii?Q?QuOOpSIWfLoQCdGD9CRFcszKxrJmN2mBnFbcuhzbPlkdkcAOQCi/IniktmHd?=
 =?us-ascii?Q?VQL0/Fn0voVE/SHrCD/J/nUVpSFZV//dsBRmhelmbloI3RSi6ZDe4dKBXEJe?=
 =?us-ascii?Q?2ket1GNkSZCk0xqoBqHNY8NBP0woQYTeovOv+VHGedzfE8ocWfPlLWqUS1pM?=
 =?us-ascii?Q?A7jK2vrCz+hdO6tDpmPsq7ZB7GNR/rP2DZmMANEPRQ3Lw6XuShDZ3QbGqkjB?=
 =?us-ascii?Q?l5gHZqIVWu1tUCLeqCuLiFmNVqAi6wK8kwH3YDt8TMcUlpuFdudFl+MQXOaG?=
 =?us-ascii?Q?KvtzzH6gAMYnHh5dLe/Ox3ZYWecFed4ZNQLf716xJU3wSHu2UYO6/M+Z4Vo9?=
 =?us-ascii?Q?EP95m3tIeHJ20AMLWF09ITTNmX+DU/QJdgZfYFJW1LMDroD4fSctYTM6at6j?=
 =?us-ascii?Q?t3+HX2osCsv06seOVxIcn6ktr41Zcgg+cXImKFi/bxlA8DrG0/cgOk9aEAzN?=
 =?us-ascii?Q?xemI7My4Ki1DH3qobJBhnAnonclzjs4ULfp3XTewBYW/Jk/c/i2kuDxASekh?=
 =?us-ascii?Q?ye0Ch5FWs3J15sbmBPDuw6bRSw2cohuXiFeDfSgakhARlRX4cKIga7mV7bPD?=
 =?us-ascii?Q?u9ocIErqGY15074abBjYDDiP7RcFV5Y6IDWRNIFjI6sn2vQ0csLIyy0m0zVW?=
 =?us-ascii?Q?mBwxCaurg8+/WLIEj0KLsXqqSZee2sVddiMEUh21e6XYze+IQbvlPiByXL1/?=
 =?us-ascii?Q?UiuxieBqzO5uVOsqJiEHMtfPVGbebn/kcPDScKHTwxhTBp1mPheXxxKkvqhe?=
 =?us-ascii?Q?OA9OVbpTs70xJaO6YhNBhEEeI+5Y6LnGWhJwQApTneiySp1JthNE9Tmgt5v3?=
 =?us-ascii?Q?Zdh+kOH4GiOMx3+7/sZzxxu9mLgNZGPwqid69F1VjZAKf431E8WqgofSVmIM?=
 =?us-ascii?Q?0nvsUfscVNQk+TOH89RnVUrXY+l3HQTSLxM16CaD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185a13e8-5dfb-451f-614c-08db6e7f4669
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:12.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZJ3nyzFM0zNd/Tjwq5MdCI+MC98mlcKT47zwnlFkXAKsSTUqy6SUFJE4kG36juBhzKe3X2QNkOFRNzNgqvQIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Removes all ATTR_DSIZE_*BIT(BYTE) and ATTR_SSIZE_*BIT(BYTE) definitions
in edma. Uses ffs() instead, as it gives identical results. This simplifies
the code and avoids adding more similar definitions in future V3 version.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 21 ++++++++-------------
 drivers/dma/fsl-edma-common.h | 10 ----------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a9d17cf142fc..51fbd7531c74 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -154,18 +154,13 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 
 static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
 {
-	switch (addr_width) {
-	case 1:
-		return EDMA_TCD_ATTR_SSIZE_8BIT | EDMA_TCD_ATTR_DSIZE_8BIT;
-	case 2:
-		return EDMA_TCD_ATTR_SSIZE_16BIT | EDMA_TCD_ATTR_DSIZE_16BIT;
-	case 4:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	case 8:
-		return EDMA_TCD_ATTR_SSIZE_64BIT | EDMA_TCD_ATTR_DSIZE_64BIT;
-	default:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	}
+	u32 val;
+
+	if (addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	val = ffs(addr_width) - 1;
+	return val | (val << 8);
 }
 
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
@@ -623,7 +618,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
-			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
 			32, len, 0, 1, 1, 32, 0, true, true, false);
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 242ab7df8993..521b79fc3828 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -29,16 +29,6 @@
 #define EDMA_TCD_ATTR_DMOD(x)		(((x) & GENMASK(4, 0)) << 3)
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
-#define EDMA_TCD_ATTR_DSIZE_8BIT	0
-#define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
-#define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
-#define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(2) | BIT(0))
-#define EDMA_TCD_ATTR_SSIZE_8BIT	0
-#define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_64BIT	(EDMA_TCD_ATTR_DSIZE_64BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BYTE	(EDMA_TCD_ATTR_DSIZE_32BYTE << 8)
 
 #define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
 #define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
-- 
2.34.1

