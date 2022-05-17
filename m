Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A570B52A5E7
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349832AbiEQPTq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349822AbiEQPTq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:19:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF737A0E;
        Tue, 17 May 2022 08:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTvi+5wbkUTW+Xf+ehgueBr3oP4JYQCDgrXUatGRgEZMeAxU9zSXJJiKZt7qJmvgimeZlusSKJuu+5AWeo+bTVCjmpJa7XS/nk5qDfu/W7qtrsfSVKEKazaosSweVSnZbANcjGOqIplYQH7fVOTtU1LtdNCk2duPcs+ZZiobnsiHewlFoBvcxbZFX/eM2yXxmho2CGiO0ErJH5yHsOfDR8SsTphVxmOCQaFPQ0HUL01w59ofKPL0EyCz9woVmYhCVIFz/Y10TNMKpKkkZIj7X6nldYckMXniJmOWU2EoqadDkcm46nJS85F2KtOtjVAnjcZ2qQedHetwmBbuIeYPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ncTV5KYenVsTqJuRXLJ7swaY6VyfYire7r2DNqTCHQ=;
 b=KgUBboFonMbhHwQzxroplsvOlxIIGwGmFY4OkGLiDi9Ptd8ruLWNiBRetpQZmrW/DRaUAeDF+pNJ365/JoAypFszyVuavlGHBGigQWJ3+kS/pk8ilWMpIKq5QmEpSFtGEeinqR3qmgusOxrB7k7MnpKjdjf85BxQQIxsVXUAJnRL6k5O64w0e2oFLRTg63GQlbAb6+xxwxsi5smaQj2wQkwV49f+JJCpjV5bnykceBPDZBjQ/29S0J7qikx8xz7SiG7ROjsy9RQId9cPIjl2ZgCXE8TTJWGc+v2uher7qZsVUpHb6gvfjb42FnAbTykiV4ilBGJD0fHHz2WuzO4ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ncTV5KYenVsTqJuRXLJ7swaY6VyfYire7r2DNqTCHQ=;
 b=TO4n4qslUnnZIJV8Z/KDOcD/PlFQfhmOaRKIzZsnY3ssMDNZCjGM8Q5Y0Jxq+l1RyQwVgauVpsOlociXIaygChJMwFG00rmA3I5FGi+/4iybsx2LeNrLta+83HF2uWJA36xV7p7x9Q6mvCSk+RkOoQVCnDBFI0f8lESoJKbrQLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB4367.eurprd04.prod.outlook.com (2603:10a6:803:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:19:42 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:19:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 1/8] dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
Date:   Tue, 17 May 2022 10:19:08 -0500
Message-Id: <20220517151915.2212838-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517151915.2212838-1-Frank.Li@nxp.com>
References: <20220517151915.2212838-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 608adc9b-b109-4514-dac7-08da3818aad4
X-MS-TrafficTypeDiagnostic: VI1PR04MB4367:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB43675E938BB064519931555D88CE9@VI1PR04MB4367.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9I//+aWrjH4jjr+POuQLJF2n5ibaTd5d72QahqFiT5NpshBCXV836S0Izbh40o/t8qJsC6IElY41+AIsyXjxOISbaNbcnn+KO7q/PKvz4CZhMjt7acTMFXAaQ1ZovRpvh2Tx3pqToAnUZzSnkNxcKi2D2wn5kk3rYANpNUu8MglwHKf16+mYDZpLBBH0QAoBGekiI+5jgPNGllA/ITA5DBhS0tD3yAYcBPpXSHybnNdFEeA8mY5DKZToYuTBxsA0SdAjeRNsR2vcmHr8hYVj2QNtygXlxCLjmhUK+EIskqJmGcBmyWETUWVIv6qrRi/cvG1op2Gyq2DWEFpVqkbt2ZX60Tx8JRRKpsk+U5BsEm5rayjcKE/AaEmhjUukH16k8i2bmKVQ9EdiORO7K7mi7XEgJUlf1IN4t2kMUQLDf2sbktOqi8sc+jK0w5RE7P8K6Ps/W1oY1Sxxtza0AciYkonDCyNEkAD3GUTbgi1WE38Ci1w29TKse7szww7NwRPlnJjAcAofVQEDCnJW5Mhw/t2eFE1f8QmSGe72jI2icsWHIyPisFyksmVhaXgPvL2wG79oHMAAn0zy2Syi+Zh4ORDFq03q5E5NZsr9GL3tlPIwlEUINV/tIWYK/U4V2EvvLrWIWrWRQBmW2FLVJ2b28Pey4JGCcJjK9DXvqsCnWYi8hS0FlTpXxkL74HRYLz++68Uc+JX30tsscx02JfZtDncIU6jmw86Vh5KRgKVbues=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6666004)(52116002)(86362001)(83380400001)(7416002)(921005)(6486002)(38350700002)(316002)(508600001)(6512007)(26005)(6506007)(2906002)(186003)(5660300002)(1076003)(2616005)(66556008)(66946007)(66476007)(4326008)(8676002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0teCgbw9zU5sMg4P7QFt5MDJzr/4ncJZDQu/ljCDzSeUBhjWLdvCy1O4J0MD?=
 =?us-ascii?Q?OtIFkgK+FymAdPc1KPl+nn13AsJzYSqQijh82bsm+1TKGDFvZ/QlHwBHcdIF?=
 =?us-ascii?Q?BPe7w1hEqRVoHGJe7O4x2ZgG5p9oPpZhsxEvYkqmaz/Nia5JtY++KBKoUyHS?=
 =?us-ascii?Q?OWaC3B/zxZ1+bmR7GaMhlfONEmtrTgWCNPrwUihXu6HRF+C+nFOzzt2PXGmH?=
 =?us-ascii?Q?gksVX78T/rgLz7i+Q61aPFtIIS1ZW+J0JmGctNLUhoNq5P7HBKmfwkpP2an3?=
 =?us-ascii?Q?wXW3KjTey46xVDNdGoja6fz6Yh2zy8vyAZ4SttNLu26+MdfM9PmGM2J1UtqP?=
 =?us-ascii?Q?/lTzx+74m6jCH7dGK141PmrV6dmuw5jN3nNqazCv56eZMFxqFd6aggnCO7f+?=
 =?us-ascii?Q?c3830xSdu3t7wivZj+CqlCMWwUN1YXBuyRJItiwtF+JYMAHMRVTcR4PIkqYL?=
 =?us-ascii?Q?LUpSNl7fn1zcF+35kJczBMPmg8wQ8o0wWV19bWEDlMih4RewV7sQVvMuWVEh?=
 =?us-ascii?Q?8J+B8cx4jZybFUsG/G7PYD/aaOgXPOL42AI5nLD/E3cqCWRyKbDaXCd2Q/lS?=
 =?us-ascii?Q?asiEMv/BBI9sLN4mZ7yB7hbvZoRFIiZUBXE21Y74u9Mmh19Iqn1VcFdnXYP/?=
 =?us-ascii?Q?K5Aba4EAuq9BVHcbyi+Cquvw1s0JHjdK2XeImzrCUVY9lU0DVv1wF36UXq5B?=
 =?us-ascii?Q?eM0UBIngDUKE+jfGKCSIbKOoeD2NkzyJmDXvSNb3Ry51yRUjEb5oanuZTC6Q?=
 =?us-ascii?Q?xkrJVJiol7u93SvEnchbhTbyubax4E36vUTQQORFAnm6Xtdxujb+BxF9nW38?=
 =?us-ascii?Q?boQfoVns9LHvNH1B42upqwEedPE4/XP4XgrHTfazLiJS5zz0Svro4HCAt/CF?=
 =?us-ascii?Q?rYlKGJ9W7cOREaf7vsW74KT/yXtJkXILcP9L4ihyx5IJTXxkghzhiS2FQs/I?=
 =?us-ascii?Q?45aPC/oge3BQJbhbm2zY2P1fyzOE0dg9yVAopigetPa5C8yCNtfAiXbq6nXg?=
 =?us-ascii?Q?XCm43l1/1x7y48e9Oj+4ThDrR9PmYRlOx0cqtZMF+v1xSe7YA5yKHE9IrKkU?=
 =?us-ascii?Q?p8hTy9RGzShhPi9v/J6y3zYtQv+4rAwKAid5ZT+QxdLpiRHVk10sKQiK7L1u?=
 =?us-ascii?Q?UX8FqC0jJPu1uISy0IKJn12Yx97Cc0qusUpLSE/W6qp7yCHUiLlYDQaDbghP?=
 =?us-ascii?Q?DdQ7otmsmH9gEfxPjKDfGEjBfWWFPDO2Bh35oEA9kubj30rs1qzqNLukwwEm?=
 =?us-ascii?Q?xejmD4VOheAZwJFeLGbRmsEfAdqfaGt6qLvn4LCIC6340il8gzUz8KbLp0BY?=
 =?us-ascii?Q?WCVItzw6xtMUn5Lc56Sumw+KYbyUlAyE2xpZjtxLbX5qIC0M4iLhUEMjF4pl?=
 =?us-ascii?Q?vL8nmdlUUnflixj49qnL9AVuYLw2hbZto6S9rvjArvavftYQs3fI+FjzqhjZ?=
 =?us-ascii?Q?xP/UkZJ5G4erYIsIDbQKmfz2Tjoe0sd/L89hmAfULNlfiSWRQad1Hc7choCL?=
 =?us-ascii?Q?FJNWzm5Gv+B1ftC/JLIK0Sg6I0ZkvCxjwAXUXAhuFvYYTtYE1/sUu4I48R+w?=
 =?us-ascii?Q?NyPQsJjaesuyupAmbM8OUhTsweKjDPYwspcUvKs13LaK+lG6BoV9r9NdQ8bP?=
 =?us-ascii?Q?5GJpejylRyFjqCvbk59VkrRlnui/6QCyzcCcNAEXzMyR258XFaTehYcYnMt7?=
 =?us-ascii?Q?K5PjbOVeEGDc35sss5iBQK5Fi01fLIQkRrBlEh/GemCYZUi37Ep4n43VhdFx?=
 =?us-ascii?Q?AW/i3IfXgw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608adc9b-b109-4514-dac7-08da3818aad4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:19:42.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfKuYBjY5P5t6EUvIRZiV4tunWP6YZVHm2VB1ndAHLnjhHAClzd7NKsfgOwEhtyX8jcrBRbrVg1NpWk/ORdDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4367
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v7 to v11
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

