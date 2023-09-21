Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97467A96F9
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 19:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjIURK4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjIURKF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 13:10:05 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A94783CC;
        Thu, 21 Sep 2023 10:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDfZqgTf5uvGQRiju/dqUv5kK3V1hAI5WEwr3DuTwtSfzQz40TRygNNtQr6qZ6/vW0dcHX8VSwZdBi0wevFrgJq7a2EU74Ijq73z3FNCGeGcXrsdhrWmY/kn/Si55Ylpl/qXHA27gnO6csoZkoGRC4b0+UN4MqgvccuYIkZTITx3AxWVah6jNwLaTmTzu0gsVzwVW3gd56Jthgqbw3QZcYFKm/NBgrY5dkT/2HFQ3N7ml6WO0je0tPv9rcCRKUVzvSwQ83QNBnR75Bhy3jQyU83TFjXoRD+jDkbg4CGMbQRqJTz7QeGrFFvwp+ZZuLtnfQlCCJH2IziFz29P6C6acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaUZu6RoCaK924oC9s1V2U56FctBox4uAc4yWbnZiMs=;
 b=Slh01OdX3Q3IG0v7WvAHws2kUmRK9PMQZutP2+wy2VyMVlVN1ly1er1Bxp2OzHpfrGUydFKdpQ/HIxjz42Fpq3lCvyDrX8eEjf182o0Y/F/MOdKkRFZHYiqyoBOMOEqBNYMp2P1u1TEzDrXpErJUOUqn0MMs2y5SXqMGxF9emBCQFuzg0uX+8aGiNIaJFuFHxjdJDCAALnAeB1YDyAukPQnWlXPMq6LH1jxgdeCGzrm3oCWbXiWbAt13KeTxtsJYjTnAX4B9M51aJJ36c/vcNtT3w4184mAaiu52Caqm/zfz5KwHvuR3DSs6ee2mWXb8OeOhjusB9fn0s2mHEP6OHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaUZu6RoCaK924oC9s1V2U56FctBox4uAc4yWbnZiMs=;
 b=XiuWV5OzNJSXwF+/+Y+t8bqLQJQJ3w7erVQPlUt2sMKCsFky6UN0dQZ6S9K3fjXTVAUkCTpxlFvUHQPMPFfY7QVTV5BwxRvHulOaZA9iG9IMp12NR+fZZRllQTwbBbpNFZkE0LQYvCGSY+P8TwqTMCEk2le3ZRKHOc4rX08i1zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 14:47:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 14:47:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v2 1/1] dmaengine: fsl-dma: fix DMA error when enabling sg if 'DONE' bit is set
Date:   Thu, 21 Sep 2023 10:46:52 -0400
Message-Id: <20230921144652.3259813-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:a03:338::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a9be95-2fc4-4e84-2d02-08dbbab1a212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ercy3hJlOb5UpsHz3LlC7O9DVwY84Ek18VgnuR06e7oxxiiHgnKsr80AGhh+iJXeIzVGqr1P9FNYj8tDkG1AbC1a9SEq9XHPMT+BbyKQnDUOLAyz0ijvwFHFtGDfwHwWb/DmBupSH+oRQBqcl1833i68XvN81KHR6NMy8PYgom1KhA+ePHeBSH+blDAQCkQNvkFFd6PAyfpASnvwh7sYtm5Dpjvos6YgcGKGi2n6C1O97TuZa3L9GtgAdjaDB64Qw9LW3GTMUAjuvsZXw/wUjvRMNSz32q0h5RgwavhDmY/a7SEEU8w5OI7FPD62Xic8MWBT3voVpgkgoDx6zQdd2jeJZMZ/sI0CeOEScVE2RTkoNGo80SqW15f6Rli2rLYXgPoXW2dbSQeIMKIpm0MmIoKqcB39miQWfFyRXzwff0uw+FK7w2oIH2lvddiQnZdCMXrBLAgFqz8crGWQGMkaZMSlaQObi7pgXm54PSRPxIxDBExyvZvLtQtu/0nSfTLTEzDiVbG92YPsleldLXFpb9l+xPHOlvKguQ9zerxMHSO2+agVgZ0zzQTIloHqlYEqtutS+z3oGoA8EK9duL4DYlMMdcIqkLch1QpPGh66hmsPiVHdDfJLz6VA3nT2v66B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(186009)(451199024)(1800799009)(41300700001)(86362001)(38350700002)(38100700002)(6512007)(6506007)(6486002)(6666004)(52116002)(2616005)(83380400001)(26005)(1076003)(36756003)(316002)(66946007)(66556008)(66476007)(2906002)(478600001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?johnAey/jEJtsC68x8EGckrEJAZhX1TJWz3lc41HaCOD2NBWRShgwwlBRKAq?=
 =?us-ascii?Q?1iGMCtfqem3yhSlXb7sRGuyN2xThH85ImhB0M3LrYZEZ4r64kknt7yiNNh8E?=
 =?us-ascii?Q?cAsOOjl+m2pvvmxotCMPyzqRC7vnGMH0wBm1OYt8jiJkVgh/XhRUMO2anO9X?=
 =?us-ascii?Q?g3rx2UoQnUSfCjGkZMYdq32FIj/tqFLBJDPMFfYKv6AHwuLlC6A3R5HngpSu?=
 =?us-ascii?Q?qJ1EJM0f4oi7WY5rY+JIAQetmdGZchu5JSQag2LhHEM/NWkm6KbU4fGexdBr?=
 =?us-ascii?Q?bm84OaKWsoXFRlFBl33EY6Dt19dVBqegRs7u2g2cz9Mqf/U/sb247aiZKqyA?=
 =?us-ascii?Q?tMoDYiQfAbsAz0Fwm7ABJiAE03ipz3phMIli9lYpmEUed6VtAAvtp6/4WwtS?=
 =?us-ascii?Q?PJUgC0CTAqGiQlzLiUIA2OGznipqOQFO0K4JA/qU24PxEXZLCo8Lpr03mxv2?=
 =?us-ascii?Q?93u5vdog9Kf13Z4eSVhbXWweUdOYOyp/k/5NuTcFt2712zRJ+Q8XVOw6GQBy?=
 =?us-ascii?Q?Rvcybo6zGNBUC/kFAkpQWt8pynhpPQjuAFdKofXsZ+B95kt2uvbpCbL2aAZE?=
 =?us-ascii?Q?MueeQv3AFfb11E2HxwbNbJzUZq5RNsCzoDCKkHxPJAwncfkjvRzDTgEm6CEO?=
 =?us-ascii?Q?d04UZMfLePV6NDbxVPevS7HsWjM9jZGQz6I4yrfT01ybv9CQNKM/YMBEyMru?=
 =?us-ascii?Q?RXQ13VqjA+3KqLpJ78SJbB/R4Q2UdQEOCAXnUpP6sF4v+7mGdz5GN52ys+Y8?=
 =?us-ascii?Q?Tp7u2IQInkMv9Azi55UnoGyyuGov1FBEly+qP6al5nK1ryYd4gkX9u4w02Mq?=
 =?us-ascii?Q?qY15lXJfc3fsmJMM0z+7SFhMn/W5QKeQLjupfYHUGMPCkPe3+QjzPWdiQixF?=
 =?us-ascii?Q?lp0OfxRNXRx33wzq5hKPgwx0RyZJ/4mN8BLFI0/yZz+DUSzIaiJnAxJXUJuy?=
 =?us-ascii?Q?Z60rNasofQjcJpSqzIXKudcZV1HLrHbdSw6ihAfgLpqvZKVb5GQYikuzCSk/?=
 =?us-ascii?Q?ET4/o2Xq0G8y4oWrJUw+gHOaaWztgOIhTsJLlIz5S+juy0jeLTXj2iCVWx3e?=
 =?us-ascii?Q?56MRtNMuM3/b/uHQtBefVJgkV2bn95ITQk1gEgTVU0GN6t78D4x1WyjFAwYx?=
 =?us-ascii?Q?Jr/4pouHLswI5Eqlctfu9M+cgD0acTCVjFGXHn/kCgqtJvXjkS1dM+wCeIMG?=
 =?us-ascii?Q?1j4eCg4S1/tGU4494VtKJe/I8Tr5/ZhQIFBMhYKc8f0o8bb8M8IHtm3tM29x?=
 =?us-ascii?Q?ET6axyGS7LHLNgAtBSh7Hwjm5Hzs9X/f2y5EV68EElQb7h4Z/jO2QQ/QC3+7?=
 =?us-ascii?Q?ORh5iVrbLdIiXsZINoLLJJN4lmvVduvcs11Nj9eJpnfRNTfoQEm2mhQzyXON?=
 =?us-ascii?Q?utoCi1vn+15+SnnH0DXdpL0FW30VuybYFDwJcZwz63/cSYObT5ZpGZ+IAuBR?=
 =?us-ascii?Q?2/TSgHa9QtqNgbsDat1NCW4ADV0Nk+Fx/TgKMHqumm4GxKgiicIAu1FGFaaD?=
 =?us-ascii?Q?bSWy2sgBnv7Co4d2mf4tlgxdJxB13lOCiRgGxN1HDg7rPHMZe5/CtCrf0Hjs?=
 =?us-ascii?Q?4C7ZKqQ/fN+pvGe8Ihsl4Csd7qqUoOYWK55XK6/8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a9be95-2fc4-4e84-2d02-08dbbab1a212
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:47:09.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Cqs1jmQhpAe8RujmnGRQLTVyZJSkf/aUgPM6Pm4eRmMAvXewMYogTKLqLb2mn++OuUazWS0NRytEnK6FKQ18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In eDMAv3, clearing 'DONE' bit (bit 30) of CHn_CSR is required when
enabling scatter-gather (SG). eDMAv4 does not require this change.

Cc: <stable@vger.kernel.org>
Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Fixed sparse warning
    
    sparse warnings: (new ones prefixed by >>)
    >> drivers/dma/fsl-edma-common.c:463:21: sparse: sparse: restricted __le16 degrades to integer
       drivers/dma/fsl-edma-common.c:465:21: sparse: sparse: restricted __le16 degrades to integer

 drivers/dma/fsl-edma-common.c | 15 ++++++++++++++-
 drivers/dma/fsl-edma-common.h | 14 +++++++++++++-
 drivers/dma/fsl-edma-main.c   |  2 +-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 70e24e76d73b6..598e72be54097 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -454,12 +454,25 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 
 	edma_write_tcdreg(fsl_chan, tcd->dlast_sga, dlast_sga);
 
+	csr = le16_to_cpu(tcd->csr);
+
 	if (fsl_chan->is_sw) {
-		csr = le16_to_cpu(tcd->csr);
 		csr |= EDMA_TCD_CSR_START;
 		tcd->csr = cpu_to_le16(csr);
 	}
 
+	/*
+	 * Must clear CHn_CSR[DONE] bit before enable TCDn_CSR[ESG] at EDMAv3
+	 * eDMAv4 have not such requirement.
+	 * Change MLINK need clear CHn_CSR[DONE] for both eDMAv3 and eDMAv4.
+	 */
+	if (((fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_CLEAR_DONE_E_SG) &&
+		(csr & EDMA_TCD_CSR_E_SG)) ||
+	    ((fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_CLEAR_DONE_E_LINK) &&
+		(csr & EDMA_TCD_CSR_E_LINK)))
+		edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_csr);
+
+
 	edma_write_tcdreg(fsl_chan, tcd->csr, csr);
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 453c997d0119a..fc0bdf6d16a96 100644
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

