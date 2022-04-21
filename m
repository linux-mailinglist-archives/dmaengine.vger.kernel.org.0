Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC12A50A302
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389585AbiDUOrO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389589AbiDUOrL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:11 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10072.outbound.protection.outlook.com [40.107.1.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4C4427D0;
        Thu, 21 Apr 2022 07:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc0avBsYpQ5YuQf9uKc2BPgE8R9sdj370HrvmGZgXjkLC0aN0ewGzHfy16ArCVTLJ3LCEg8m6RZO9cPxYjCToIY4TDQiqgBb9SUGgyqbMGxjS7yyb9SQCurbebX6y5DBLyJEdoWbuNympY3ZwyjCw44SwAN48gAa4f3KN1Wiq7hhcGDefqlgui2RWugtxuPHi3BIHHcSra9zbyyk0NqMIhShdU7wqH2+FIpvk9/EEz68iWTtp+ae6etxMdFYzv9tw031q2LLWdZ2/YCxEysf3iKP7brmKyWlDdcfeyYOgIITvQlogw5Ts/GnqJ5Txkl83FuNE7/TQjEZ3FQRV2HYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eMM2Hy+cZrDM6rnZL6Kby5v3Syrrjqnc88feJODeVE=;
 b=mfPN4OM1v0YUW0gzHxKOtkjF31QXw14VLdLtJvMOt3cgb3wkOr8jqcPfuqDzK3tr7t5C95fARzeXQCBRiujD2DWS6c4XHYWR9Si0rfdK06NFt4t75fS7NvHRzQ4ELFwIvecg2kYiDM1TpWifuGRSyZw+nhpfHzdOC+wwTBX0jojWfEr9M7ulkbcN9AyZKSA+i+10eBa6dw7bicA0HEYyGa8NNKMiE0mliWrrenuUJTlnilS4EybUlMh7Symbq/xvflSTjGeCtB8LX0qqiyXuTEgCVbTf7KIbbU8KMaatiI7Ajd37+8EvdmiZCvBihVFEr+CRt1IF3sEkaKZrG1CvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eMM2Hy+cZrDM6rnZL6Kby5v3Syrrjqnc88feJODeVE=;
 b=OOpOrwRI6DRM7waYAFPCyXYzU9T9ZW2QmAk8LWKLYN383Z7Woiy9j3uarZfliOB30yzVFQbmxpPUI+xFA1Tu/o5G2Y7czdmDa9cQaYCtlTJsc6WkZZmMga1sKd1F79xwy2w1ywStgMn9rGQ7PxkgtmOGwA2FX8Sfjo2+QGZ8r+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:18 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 1/9] dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
Date:   Thu, 21 Apr 2022 09:43:41 -0500
Message-Id: <20220421144349.690115-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421144349.690115-1-Frank.Li@nxp.com>
References: <20220421144349.690115-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96c57228-dcaa-408e-1171-08da23a569ca
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8689A5CE4C3FB6B98E89288088F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBaL35mzSZyhclLLZJD9Vi7pMbyE22mJgBBvkcdSE56Ksbhsgesu9uT0eBy6n1WCL7yger9rX49SBbSsaxhjAwYTTxVwB6dukEdTfq1uEFXVc0GRna9cYjfNTQpok7B4mhSxl1pq9DCx+cjIkdqpFcNZIjB4tYKq8KswTW0ZPaQV7fgfQ2Gs9YJgnTMBH1+EClKK1nyUBtHJvWDqhSbev1SeCGeFTzeJlmbPiw075qcWbGylltfYugA5KluyGRPfYugR565i2pzwU+mBqyQIw+q77V84zB/9JScDzfOXezvrwUEVlXlaUkd/NLDkcjizct33TWCRFBAJ8/DAKU8Ol20h7c8NKwa4eh7o22lXa87kdzcqUemSIV/tObAU7LerNrzaA+CuQ0aMMNZ54R7JBpAfNxaIQWSXqfixLDoPWRElSItt9ub+Aie5hUxMcTY7Gqko93WySSE7gOneTeWX2GF4EecUymWmANZGAwjZVkgqQH0D4wxO/NlJgXPg+mxejcJYVfGkbJIhlY4s9gHlFYQEz+XzofbfHbUm3qDLhEE+48ZABp4awwYBI7eQ81kMnQYDPkekolkhJbd2OwE9sFfxaIue/WTJEEWjoMq77cHC2vU0jCPL65bfEja/YX6HIXYt9HGNZ7/exOSjCrEPqLBTgf+lTosLTUnzajKvs0ctRb5WpqJqyHFkLuOcVA0xBQWKalj4g70mff9hJIXlzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(6512007)(508600001)(4326008)(316002)(26005)(66556008)(8676002)(52116002)(6666004)(6506007)(6486002)(83380400001)(86362001)(38350700002)(38100700002)(186003)(8936002)(2906002)(2616005)(7416002)(36756003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gImyEB4kGP/tuh0OL9UmjkuJ5//jsdm4jJkmN0wt6TwFei3iGuc+m+Umzyay?=
 =?us-ascii?Q?PzGVnYer0KKJ+yORWIZmfLVh8svpVnXg5ClvRWZt48Mfj4hS1oOfXL0QwF/1?=
 =?us-ascii?Q?Li0RfZPihnxau+YbFQDMoLcQS0UedF+LiTxdPl8ebGcijLJI33Xk89r/hrnC?=
 =?us-ascii?Q?HvXHuRlWN9xkH1xRyRliGBvoo0yn3CEe4QNrkhxmWivr9GzqxVi3Xq3dGYi5?=
 =?us-ascii?Q?DEZJ+D2DwkN9Kq7wGYkcRC9FSxF7+X/mRuo2GubhjUqxqs/DJng8KGCXuE04?=
 =?us-ascii?Q?p7qpO1ZB8dhazK7UAZyjZb93jXolWwVfEiwwVF1z3iCjeei18fS2OrSqqQa8?=
 =?us-ascii?Q?XLPIC5g54E+kig/tU/zpeeweFsBvNbl350Qy1+QPU+s6ShmQR2iQtdfDnwr3?=
 =?us-ascii?Q?UexRtL3dRWPLu/hGdzNSwQSVOfTJh/UwnHpI+jcKqbFguaBOFyhzvP7w5wHK?=
 =?us-ascii?Q?uhroTocp2fdiEvsbYDG7cyoc0UDln5qy4sX7XyHAW/Sz8wAYH+GFUGFt+BTU?=
 =?us-ascii?Q?cQlE3Qmz5lNLWYS24t0JEq524VEFGdQ4n8VcQcA5Pub74hcBA+vwTNSaMN+T?=
 =?us-ascii?Q?stZLBHs+KnfwoICpelZHTyRaJ+uCAVjB1vlujZidtMjOtxufdkzJxgkg0nR9?=
 =?us-ascii?Q?6yR7x92HXn9l8HA9hch1pb8ZLQ7oVtNUP7BesjUr5WOjUvktU1may4RRO5cZ?=
 =?us-ascii?Q?fc7PHLWw/TDNgeQg7zbtWh239/rsKkNInCICHBoShPDFf5+BVLbRKtbuyeFh?=
 =?us-ascii?Q?8u32LhFQ6mnX2bRbUWgIEPn2KfoD2GJbrRsoRpM4M1w7Nzli2/n6Dvfo7Ed1?=
 =?us-ascii?Q?gGO3BxYAJWtvMEmqNNItPZpuvGL1bGW3Ucjx8PtXm/ynFzLtl5DlprxMLga5?=
 =?us-ascii?Q?B8nSWJaJzCVZQCAxnsriHN5lth30cHZFojLlBo0svXspop4mNX5bBKKVOOCF?=
 =?us-ascii?Q?JM4Dw4Dim2jjj7ismmHqIZZ3TH0XFT9ApcC4dltnRYxZobFXf39jwXJtxjCp?=
 =?us-ascii?Q?cswRuQnEed8jfYzRPyd5ax6yk/nZQ9qXy0XrS7ABagobydUDcABu+hjTO9co?=
 =?us-ascii?Q?0z/DQ+EYHyWjNc+VeEcWLOztvw7GKQlcNCAb/N4t/wKVXSBpkXfQVBRuJY65?=
 =?us-ascii?Q?H5scbjFV8i8xsZB7YThZEEsMwlgZ0WHTMldB+lDWtQoP6jfzvhh3Ap8b2CBf?=
 =?us-ascii?Q?K8Tsft1Zocpq4X4khk9uchFpFnAI0UnaBhsxdcpJLesrqbIJtRGpu5PlsvXI?=
 =?us-ascii?Q?zEJTf72JEO7x4mJJl7O82uETIomFEdg+PJYNHj8CWWOyFBO8gQytn66ciVPk?=
 =?us-ascii?Q?LAQD34iCM45coAp4i570+UORsHM+1pMtdZCYPG/9HObUDprXrpxV+s4JW9Sn?=
 =?us-ascii?Q?39jyG2FAa7srfWn705JVifp3sA4WqQWqe3WPkHztro2VH2h3IdC4Ok4nCwLQ?=
 =?us-ascii?Q?4tuJxwMAFn6uiLS/VUmOfNWvXLhWESL9d3F4/2v0XPZo3JmvNGBAo/XcWcFt?=
 =?us-ascii?Q?ubLmH/FY38upspJcGDCUBYWS1JdXuxBnfxSqKwNP9ERVxT5TmH55AJ/nJVuM?=
 =?us-ascii?Q?2znwjIiACgAl6+0JIAZN1iwkDMixJguknrqySI+wI2JVz1+irjJc9FPSry8z?=
 =?us-ascii?Q?aKpTTAZugb/Cxq9lQejZGXbA+tGvR0fhjl7TSI3ZqmCR+WLdo+PmF3QSUoSp?=
 =?us-ascii?Q?MHB9lxnMjrXmPOHIzR/3+nOLFMZyCsj8Tj3XHelS48T77x9ZfHdhawJloq+X?=
 =?us-ascii?Q?ZjgiqRvp1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c57228-dcaa-408e-1171-08da23a569ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:18.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsuE44k/JIDzAudCykfASQSwregCYtcmz4c4ash3o7QFg3mEX5TZsULT7GE7x8lYe/HTTKuvbkVPzz+aJbuTqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

irq of struct dw_edma_chip was never used.
It can be removed safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v7 to v8
 - None
Change from v6 to v7
 - move to 1st patch
Change from v5 to v6
 - s/remove/Remove/ at subject
Change from v4 to v5
 - none
new patch at v4

 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb531..b8f52ca10fa91 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -231,7 +231,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
 	dw->mf = vsec_data.mf;
 	dw->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773dad..d4333e721588d 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -18,13 +18,11 @@ struct dw_edma;
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
 	struct dw_edma		*dw;
 };
 
-- 
2.35.1

