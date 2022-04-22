Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9450BA4A
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448751AbiDVOkV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385535AbiDVOkU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D75BD2C;
        Fri, 22 Apr 2022 07:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITz9TTb6EI0ngs9fwiecTQ8JR7k7d4OBLcJdlNiCsCzTSVs7d+RNoezZ7pKCZFdAfslot4n5nzETfe11fvgJ2R4a2lG4331B/548V+vxZN31hSSKxIYDl7om6XYixnj0k+btrP8W2+KL0dMARMM6tM1ww65yD+APloUG3FKvmkYlaS85qn6JrCRN9ZtjxJf0DFvHYrXw+wq78leio6owYbY6MvVhCWveSzho+U91cGgEF6vUUH/SCpQXPnMAkTg+3bWmUmJyEFtB4iqYunOxDNLe8vnnMAk1t8jhljxXBzVdlbojkef0/BE7loWMyI49FS6wYHaJehNDrD0O3riZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSYu1roS448YWRK5aZdU42MmRs6NYUqjXuK/66IL0Xg=;
 b=bqGMTO+f/3uul1Q3I202KsfR/wYnQD6D22nfaStboq8LLSaoIsyN8vSjyZyOm2h0uk8q9RFPkyNJj2p46pBg/QUKTnKxyvcCUNYMg6BT8z1pZnGUA2xs5MNaWQGdwST7NS53yMbbor7sH46Hwf46e3n5YRang2byIQObUN+dUqmpVWplIYMmi9nIj1xeefoIUOJnXxxsiY+88EeSN4pKpuG3cl5i+uMsN/dvxac/zfVVxb9i4ROk/pS3SY3CUnNjQIxnPzFWXUus3AVFB9/ja/vsoZlSze0XmZxW4rPn4mqkVs0oqZlp8qLCLugbt4OFbhZ+pDqzGfteOQrK2QGekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSYu1roS448YWRK5aZdU42MmRs6NYUqjXuK/66IL0Xg=;
 b=XEqscgxc8FHL6NtbATFQerdbrsPj5hhIBmXvNZ1g1xbRtiNxMbu6T9uAPGa2QKp0kVRuEixQeDAUU9cvd8zHe77GzKAoUWLKnu/UAIUQrIiG1nb6C4E0AIq41p1NAjyrPOYlb57rLXgLs2qqGzEJdZGY56bIcN2RCGC3ImQJ9iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:37:24 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:24 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
Date:   Fri, 22 Apr 2022 09:36:42 -0500
Message-Id: <20220422143643.727871-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 995a1d85-317b-4858-cb59-08da246d9db9
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB26448EE4D6830B2FFA07CEF388F79@AM5PR0401MB2644.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzGj+YgL1JjgG5cTqv3vjuIqi705p19+mf3t06BViEm/3ufMIzpJll3fUZg6IAxELzS7934+Y796WfRT3rGO5BCqLMAr9jYZX1SyadAJY7KN6+J6F8JXCEZ/Y0jw/L3rhncJTlpLm0SRQhb2/+OJWdoDyQQVrKl1K0vvjN8Jgi5q386it/g0sMSYV1QfdjNGem58YELwqDIbcXq6c+YN76J/vOQqkL1Lph5HVOltN/SvLBLY3CH7zY9cxdGRV7K6kZPxEEph3DX64vGflw6czqAxH34gVe/UXbSJ/vRucp4vetTZml8ajeN9CkV3LDgH6Fa8oFXOMvObcpXKCHcCWgVXIQm+pTEe7myVfw9Zu+qGcXCGzvipWs9B4Scbtr2NymYsIaAsPl75jgfqSPHzi0QV5NljwRztsSPxLqWO8Nb8nCMaDvjm0ZqMAjwqQQ6E85yeik1GAM27KLDj28e+mg0u1d/MTOTJxuziRGp0jiDZgSYM9mHcL+uwTlrqkgl9esAU+xVuBhLmy4Ehy46XqDM6pQe4zizYB9JCefa7vgijb2HW1nqJiAW41GWMfVHhZUy24Qmzpr4DN/K97flWrR18urdTZQjWoSQx40WReaSmUIkcKyLMu3mTPmfCIYSJspdNjye/FQWAyGU98OJdSlO+2vfVk4mqLclbIfqRWWBbyCmfEcKP9ruSKXmcrSvcqM/WkOOvqXMD+xxqydZE5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(4326008)(6666004)(66946007)(83380400001)(508600001)(5660300002)(6506007)(86362001)(38350700002)(6512007)(36756003)(52116002)(26005)(38100700002)(2616005)(6486002)(66556008)(7416002)(8676002)(66476007)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B31rBx3MWQhA/4NbTqxSf/sA7bUfi6+1FfQAg6MMvdFEfLvHk88fyzS8l5Oi?=
 =?us-ascii?Q?BzV+y6xvtjPRgVR77tdhPeXjQxCdiW3qGnY9exGUvByVNeDlU77vW6EHZgXy?=
 =?us-ascii?Q?r7JfXx5xeqECdzIE5OkWj8rU/VQVUd8C/ImtWG6S+ICxbPiDOWQYTvGuy0iV?=
 =?us-ascii?Q?HTBjKfvdNg+eepBsOjZQMn8JOYmCEtY8HS8SNq6N2XvsKKtBvToNmdMYvMN7?=
 =?us-ascii?Q?08MEUgTvJ8iOK/2hk8TJlvm/onZ5zN9KHrcLUUJ9EWQrilTUDgl2ntxUXKOc?=
 =?us-ascii?Q?zK4NyjWK6oTuUPIoL+KuSNCG3q/Bn9I+8JXwm5knahYOVDUwrIOKESaWEo1J?=
 =?us-ascii?Q?bnQ1SkgrJY51u3WiwbD+bT5GZxO+EKPFwEeCuHZslBbfqkU94EEuiQcYd3Q5?=
 =?us-ascii?Q?vfV96UIFMXmUeZ9j57UN2nKgBCDwwUqhU7433YMHS+34K3CwhltwWjPXc+C0?=
 =?us-ascii?Q?a6M6VLrnht7muYpl2M5cOWihKjRkU2qUbhvxw0Wqik9b5xcHiqmX1OxYsgpw?=
 =?us-ascii?Q?qlgpj5K48V3x07+i2+bA61Jd16/srob/Z4iAfPC2DHBh4rkVaGr+qCicXSzY?=
 =?us-ascii?Q?v889WKc8F05F8CqfT2LOxZrST+YLZpMpPjdvFqKXVhyxdokTdDBH5wTh52Ql?=
 =?us-ascii?Q?QBaX4sF85N5Nfs0geCZeR7+0MfxRrqRRhBk+uNUIYRKL/TIGdDuPTMOfJLh2?=
 =?us-ascii?Q?FtFMBnzBgU49L0UnW+equpzDwXOD2z7KFb6MXSlW42Askg0Sm44VK3CRmmTe?=
 =?us-ascii?Q?ZlPnKuez7fP7hOTyVloQeXolq8CZmnp9/XOrh77wfxraCBd5CHn5ef8AtCeV?=
 =?us-ascii?Q?brovb8RVjSSnJfUulDlIHL1B8p1By0VPbqkuSK7SzuWRtc1wcRvJDC+aczNZ?=
 =?us-ascii?Q?3ZaOIuM45ic0vSkC0j2H3jqA6rPstVXjY3y3RPmlUtjygpQqWoSKyUaU6dq/?=
 =?us-ascii?Q?ubVThu6M2NqWsswsl2rg+fM/oFYfdcVln5aR5PG2NGRsBU+0/Qd32E9PTbKM?=
 =?us-ascii?Q?nV0p/FqSH8tU5Waj/8k2+eLHIvYbs+4jxWjM3KofZrip2fRCO6q6GyAPQnWc?=
 =?us-ascii?Q?PlFEPF+SQymlQGNA2QSy729UCgLdI+5HOG/8m/XtjRjq0OBnjEJ6nefq94k5?=
 =?us-ascii?Q?rTT0qEmyQijfv+lo4MGP/zlj+j0tGucH6ibgIAMNRGr1Mxe819ywIVWFUnAi?=
 =?us-ascii?Q?za74SACykB6+eWDLJolqzeiAZbOhFQiTYhhG8rZ9Y1mFr5UYJLOgaLnH++6i?=
 =?us-ascii?Q?rrCJXqVk2xn8hGQMFm0w3WBNzMhTC6NWnn/7Nmsg2t+jcCxSWteQJMbNtZZe?=
 =?us-ascii?Q?s2qceRKfo1uo2/tlKbX/YiuWUfCn5k5wV3yf+Kojjz0nmikfcBxa6/dpTBjg?=
 =?us-ascii?Q?vFTV3H+cBFhgJ/mYMbgeJsLS3vKdJKOiS71J50+X5TNihZdD/fq2JEXoil4e?=
 =?us-ascii?Q?NUJ4XhrQGIxs6slf9TfrF5tTOoPFv8QwSd4Nv4SnjT1X08sdRDpzkTO3udiN?=
 =?us-ascii?Q?VBu3l9yHggTqs1+ZhaNBunPVT/UtD+ODoBtgWWGiLcd8p4GkXjfJG/gtbOV5?=
 =?us-ascii?Q?WjV4N6wDUKrPsPCi0UH3SUonxbFO/nf+kfZSfmQSVp1haJ4B9ZYTqXerh1ji?=
 =?us-ascii?Q?ntF/aY6wJeSs/5pznAZ6X+pTdDafLon1ewacdLtTXIZVuUnA3GjZCEJql/IH?=
 =?us-ascii?Q?ZrsYFC1NaT4OunToDFGmrdk6mp0NUh6roMrM/yHsDVhlRCSKMJIULXxnoZsb?=
 =?us-ascii?Q?tyXAhzBlxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a1d85-317b-4858-cb59-08da246d9db9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:24.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSfZr+z/O68vY19yPf7MI1LT5JKGThTPECish/QmUgXnr6jkeHYwsVM883GfSMCmlSvpC7aoeX1lwiRHOicckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
allows only 32bit access to the DBI region.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

Change from v6 to v9
- none
Change from v5 to v6
- use enum instead of define
New patch at v5
- fix kernel test robot build error

 drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++-----
 include/linux/dma/edma.h              |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 2ab1059a3de1e..2d3f74ccc340a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -417,15 +417,18 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-		#ifdef CONFIG_64BIT
-			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
-				  chunk->ll_region.paddr);
-		#else /* CONFIG_64BIT */
+		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
+		    !IS_ENABLED(CONFIG_64BIT)) {
 			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
 			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
-		#endif /* CONFIG_64BIT */
+		} else {
+		#ifdef CONFIG_64BIT
+			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
+				  chunk->ll_region.paddr);
+		#endif
+		}
 	}
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index fbd05a7284934..8b134896c9edb 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -36,9 +36,11 @@ enum dw_edma_map_format {
 /**
  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
  * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ * @DW_EDMA_CHIP_32BIT_DBI	Only support 32bit DBI register access
  */
 enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
+	DW_EDMA_CHIP_32BIT_DBI	= BIT(1),
 };
 
 /**
-- 
2.35.1

