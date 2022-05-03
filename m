Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6743F517B7B
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiECBMx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiECBMv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:12:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C559BA2;
        Mon,  2 May 2022 18:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC4qj8dJV4BEmVuH4sjEGBZ4KI7s0bI5Ipx4p/36LNGVDQfXIDGFDBHENQT6Xz85UxxCbwQiX1xpBWVJNQ/O303dUg6VVL0FfqFWgH7v7A2/rTDzxIPbdEjU3NbyI3ja9iTjKQaHi9X6mb1vIgLwEbdng6ATcKq+UR160JfuUlvHroy7kZL1uGQC26I+zuc52gvjbt8dyVyDWUbC2vkBMRRcx2VPMjoguoIKYyjMReRLwjwWgCNbmks3uSLWlmlT9bPY+qR90Rn5u6NbsKluZQhEXUmRvIwq5m8viJfGMrLr0H/u2KlMbLKF+U/zNpVHyUR+A+94Tq2vkG+S40+49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQICkzBcS7//ffRoRumQnw8kx/xNhS4CxpTVXS1cgpw=;
 b=XBb44FV73c7byzM8jMsvXZElL4W6bM/XrI5LhTu+8fxd9W3SAjpywAoD3VYCOknjWS1jWm/bcfQrPYLa7HXOvtgqiHTNXENL/5gVs63ggOo67Sd3Be2PWTLTYQr7py4d0wr07jC7aw0g1uBGm5QjQfXSVJqYBbv00IYsdUcweUcybH58zrgdmcOiA88iosBciTkVcFkMY4S9Vfcsvy0kaliDdrmSQJscm2DaNQ2OrmIGcLVuyTvQgbUbEJbxPxx33bXxT0UtqryKfprrVbsh8/bk05vwO3GWuU3Jdtvqv0NzNkXQPyQdJjGxTtctGrgZ1aHX8wwfUO4iVHPKTdlcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQICkzBcS7//ffRoRumQnw8kx/xNhS4CxpTVXS1cgpw=;
 b=hJ3hayZl2ydwOuShojiVJblySRe8X2TEc9wiLyFq7uhFSP9+Ka10I+ZqMezOkshZJRRUb94hMwQN1mcetDRuLlSPB/N5aNC82Uyni/MArehI6Zx3ObesAFrxb07pYCsIylXSjRvXnjGPJz5IhHf0ZHjQYCWDJUlsg3dTXAkJBH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:25 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:25 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 1/9] dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
Date:   Mon,  2 May 2022 19:57:53 -0500
Message-Id: <20220503005801.1714345-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4545ffd-a156-4aaf-28cf-08da2ca006f1
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7364563370030F71758681A788C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ta4hSBtee7S+J9EwwdB9yIaw2QzoUuuZt72r0M5JPPM8BEAKl/ITlAYC4I3AD9DxxBZDNBl6zxU6z+q+4KGd7R4pwen4B6BgHR5v4f791GcK8RMSimsT+0tjJfzU5XRjuEbayE3GYspToSV2IwnYEisVAJtaMOw4F3SwRqYC/UuFP2rIFmIW9tHH3+7sYXH5rbyamLWnUyAImCNaOQHEhvJa/MmgeIUFBzetrXs2TS4kU+HYF9ZAXYQeDorKIaUZgNZIFoDno5GtATMLB5u2AAdY8gVAJoOl+hKHVwDsoT5ZRlfIohapxk/vW2kOaqUzCqZzoJCsOh+eI43QMmj9vED6rYL6t04mEJeWRE9HRLi6nPW4C6XcHZrbY1YDu1NDI/8qF+hPBVDrK8Wzhek9oX92/I5EgIirlfQRDHqRfQfGjdumHhSX1hHekn1dqHVtVVURJtOOFs6A2b+/NwPtBLZbc4is6yK/LbCr+F3PyQosoWKpNkGAX9M4/lRdiMagGevGFMGSFBkYKeF3EorImn+Z8pz2Okz/VX4/4xtR8D7yXjzASU+C3TIZOEoz+PQDc3zY8zmQBA9eEeDbEKgKK+WAzZ3nzUDvfQtwlzIwpxSew6oLzaYstiwaOiYkCiYdKGEb8czl8tDaao1Y10PGJ7DSsa8LAgG869XNhvKi2ECCge0PqSWi3IHXwrvUNU0QOp68LkgmMb6Z2gR7fjZaSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cj3oI1q5gv8NAWYLHPJJq84uR3m4DkmKsAlqVKF7Wnl7gFKlaQac9cOHxMT6?=
 =?us-ascii?Q?WgeT4a+MY80rhmRyqVGOjpdKbCC71+kwZc+mz+rTbiWjxIBw3ZYQDjvqgmu/?=
 =?us-ascii?Q?bvnOmyKyBw5mwTpjQGXCjC8sz1BCLqPfNqKPfOSjI34J21vpJPSuLgOS+Wh3?=
 =?us-ascii?Q?A1u1dXgEUeX1jxgQbPNm4Y+B7j4sIgcu16LIIgWfqcBdNJzvFgWLhNJeiKEt?=
 =?us-ascii?Q?ih44eYjikoXn1NUYE0JP+pIMXf+JwVmS0eUqjsQVFSO/B3/0PxAHXmcSrMl3?=
 =?us-ascii?Q?0/w/uwBxgQ+v/2MQVlBlwxl5GQQpgsTG7mR39uDHW/sZAH5sWKuDs5l4kyJL?=
 =?us-ascii?Q?YFEyf5wN7XXsiGymXcF2DxnLbIB2J8MJY4FGRFW1Q3oiv8oUUsCFzLXpQVlq?=
 =?us-ascii?Q?11IkI2jWFqjnPuRT8SlgyC+ZbrY1ShzDGBPJTmFV+irDr73Rzg6v2TwMacbl?=
 =?us-ascii?Q?yWZbVRmgbHGgUhUZMcNAIFhrZvXxqJb4hNB6TegiOwlK1eYBc9qUUrwzhtmR?=
 =?us-ascii?Q?K25iKL9TZw4nVzv1Vs6rKOe6uKgz6dVG2vpKsKo3IiiJw3QjU1PuD/FKnX71?=
 =?us-ascii?Q?XdiYaskaI4xjhyxmnwram4nW2JYuTIt3JbnvzoOnHyc1bZi/z83DWY6iTLSf?=
 =?us-ascii?Q?VWeEVk0IWiJetcCYgUG4Tcv/bHAirfOdclVvZB6ghWWNnRDvK54TIH2OEGwL?=
 =?us-ascii?Q?8g0U6823LvHKEA6Q8xM5mhQCLGenboG4B1QtNHvV8peAbX21grUIMIuINeaU?=
 =?us-ascii?Q?z8brW+++RHZqtyTlowuSEFOtrndgMSpwq5X9ck/yWmHxxlwqrNp/Kd5UzcoP?=
 =?us-ascii?Q?yirIebI6ZVfdbbSj36kUsYR9eSVP4GN8j9ru9H0vJNIcO2C9oM4/ii3Qh3O2?=
 =?us-ascii?Q?/MFjctaNOVG7OoV+EoN/ScZdLLRRc3wzRCfbXwbgVq6LT+j/UHFgmHFbzZT+?=
 =?us-ascii?Q?Gi9QGVg/Sy2eAzoT/660Jj9nwiLk/tXpjkCacSWbTOK2Ookfl0w9qqXEpkZ7?=
 =?us-ascii?Q?oxi9dVrDcNAeECmSoGwYZhnmREpVDKnQB0MkWFjhUzvuGyF8Vbg1Gu8+ryum?=
 =?us-ascii?Q?7oRRmuFtAkxuZDjXmOEFmFJSsVmNa33GrxUArBaF9y8S+sC57tf6hF6nnUg8?=
 =?us-ascii?Q?ZtKNuc8BTGK6sNOPTMzEEzb9IOZscK7/QkDCNmu8TaQwO9n1hz89g7dJslbm?=
 =?us-ascii?Q?OqSnfcphiicgqip3yW/dWShdUzGxmBCfLcKy5QMTCVqr6UpqA+82lHKLWLbV?=
 =?us-ascii?Q?HEKU4u2OSpoSfSDoJ5tjgwiPSn341bNBH6OFmB63dMOWfTj1XBKb154yQEec?=
 =?us-ascii?Q?f1gFasnm7FVGGuWw44KePSnDvug+QhhQiOK6KWOIeIhXj5wk+4vZDCH++eqZ?=
 =?us-ascii?Q?weEElRjEaS3lSXWGP9LLHWskBj5S71y1w5INzVJGW+nw03tEIaVviiR3hfp7?=
 =?us-ascii?Q?R/ZVAYe9uf6GE/XCzGin/BjPFa9s23N+iFtTVeLUsAaZV3Cbe0NG7ZiSd1LU?=
 =?us-ascii?Q?f3qKwp7trDXsl70PDDEFGhExNsbGabMEFG+p2kGojF1PHqiYePYM2i8R3AT0?=
 =?us-ascii?Q?uu0II1dCQdXQWbCGEQ1G3Letn+2GuymWmAqirv++qK84ec7u9R4O0EZG9edT?=
 =?us-ascii?Q?mH3IdFnd3P2psKHQG2u0/qDFsKVeOUYG33/Qrx+DtUncrEiL2+x4AOIrz+MP?=
 =?us-ascii?Q?oP0GcWcoQsdthBGRoV5AWLrRWJAd7yzhYKbI6En7MujCdk/rkhF1+o2x0G9c?=
 =?us-ascii?Q?Q2Iw05556g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4545ffd-a156-4aaf-28cf-08da2ca006f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:25.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMIiPzH/bhkKNamArlQG8NEX9YJfwOWlalo1euesyKQACDPJ2wFwjqBmKVXpJMr4w8c6NrYYZDGopPR4uJHUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

irq of struct dw_edma_chip was never used.
It can be removed safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v7 to v10
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

