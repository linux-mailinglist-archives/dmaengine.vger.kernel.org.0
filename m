Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619A4D3BC6
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiCIVNc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCIVNa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:13:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF922C1;
        Wed,  9 Mar 2022 13:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzePWjJq93OIZZB43BEx2uJ4lm8KeBkQOEBMbk3EAUwK9/lbkSx051U5Xjyw+35Uc4LQKszTjLMg3q3HbkQfVOAfD1osqx4UmZYPPGgAVBKHX4RtAgXGln/PjQFGgwzs3hjELLzyiCG68CKQ1YAUGvjIQtAJ7poK7n5YeJ21DGn7lCIjbUhXJaoXvjlSI32h0FhhztsdE/zeGig10sISJuBV9FDdjHKuXxKmCCMQ6umZ99WMxrCmkDf9FOke1HljLckx2jPu6fVg2vXLpQOf5FyCNEJ1IImJojwZi5PyIxLH/MgCRyFFDxOZRB+7VPVGEHy1Zm/ge+Dm6JiqxJUPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqPthBbLqY3zhinKqaUVBq/LaccIR03YxZK+ayfy1tI=;
 b=Oxfh0bVrTY885/kKI+vFdnGjYJbtuyF2qOA1sA62Bk+cWQeRFGmVWYzD+THsbqnK93vK7n28+fgiUnYexzvLkEmsi787t8cOXEHiwxpyrgGBgKzvlJSwZ5HcOKE61fujSROk39cy41/p9MYf4qU1/S58gCVf9HYI5CDonKrIE3y9+hYVR0qsdijPKKQIgRoVvpi20yi7Wj+I3/t2WwW59eUHU4dLreFd5RniAthuLIJRiuKGGTnOZ5TEYQRMaiXtPLuJeyNIKImAt8h33bKmPU+SJQuSbRjK0fqGAuiwskuO+HT04nWVZ3rG69tuyL1Nu4ZjHEhiQMamB9lZdmSvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqPthBbLqY3zhinKqaUVBq/LaccIR03YxZK+ayfy1tI=;
 b=gjYlSJi+JCyd2TOXCQKv4pGchmsBM1W2vKGsQ7qGWiJeY4hlkugIaR4JcjjctLDo+DQpvtpJt/3xrUvAFi1DcaBNTXrqBMt6BH6w510MqG9C8cq8UR4RsODT2Dvys82av9cy2nJhoq3ywJOp71Vz4niUHVCdWF3kudtR5izHGHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:12:27 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:12:27 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 0/8] Enable designware PCI EP EDMA locally.
Date:   Wed,  9 Mar 2022 15:11:56 -0600
Message-Id: <20220309211204.26050-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a048fd-3ee1-478f-2853-08da0211839b
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8358E428C4C9FAA2AE5725AE880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPScaZPpzazAGSkH+p3KP9pV25fzycXgqP5NyzE3asKQ0zEvbVETXyqdtpbjoR4AuG/DNFmME63YqNRpyBvu13wNKvQZVfclJ2nsPh09iue4vFnHK8hlr1PVkI0D+lLTHNs/SIRuXkvsAJ6UHqTUt1b9sRzuWnKk1Ta0bk1qTYCS4y8h+bYBDcqNe5lALT6gzd7JL7phxJYriFu95EChm3YPKaYhpgXG0wB5yK4XK1Ow9nlvEZuODtFbNG3eP/o9RpH7rW9j2U0P9WXNSyn9d+M67TNeJ9k+zLnUlHeqkVsvX9W7xqUdeRkLLqyD6NtaLGhkXywWGY7YzwtFB/NupSGEKoZCJ6BoAdFzV17Lit3MrBh/9u57kFmVI4u7mFOuD4WDHjphcLKPUtuJvrVfcfmyaCfoYfQEhaU9/SEg3fr3YwX09HEvqMjXuY1sGMOBYL24tdG4swvR/JFdcCu6uMFj1o4dsNKapK518nY7G234e0r3T36mPFh9mOBvPC/nK0Jedu+8FxYclHYmsB160mpKm7vLLfYKaSYtXZ+frHuvj5VisHYXvnTJb/301Qpo8LbthjnOQbVTi06duhZ2bsRSuD3XhYKRGmxrEtADl6fP96Ale3CKkkYk/dsG3HFnC6Vz3l7vg94q77aTvjkl+9VbfNFKXeiXFsJxevgnusNqz69Z2pdJBaullRUeG3R/lzv0UBeRph8tp44xmyFkMI1MkhN19xx0GBU8HcLG3B7xEOf+6E1y4K+I4/+eWpdHiuRUUtXG8tjPM/dLALPgc6mdpg8qAneHK0/ftjEEQ74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(6666004)(966005)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pcQ8J7BgNa4m9hxWxTR85Il7iF5DWJb2GdFsAVouq0CtOkcAKpFLg5q58pfH?=
 =?us-ascii?Q?diM3ILUlZfUic8f8QkPO2wOqE9MOOS4+ueE6HKK3TOR70VKTs4mcI07/eiYj?=
 =?us-ascii?Q?fnGO58ItYCbUCJ9eFsyj91dqwGVo0ZL6frGCTwx8H+MfIca+hzAExuicD5u8?=
 =?us-ascii?Q?Mb0yjyfzHjH94qX+XfOxtByMcVl428RFOP7RIZUfuLsKG6/X24B2rtvM6DjH?=
 =?us-ascii?Q?SzaIbGP+dfdgHvW8j/Pvet+vtrcC4+CvBBuZIIfUMPpEuvi9lZP9d6OP5ZfH?=
 =?us-ascii?Q?UtaXC2XNZYqDGimvPWPC+5hpubLD3lzVbLtPNEFfg6Cehe1cw13BB8VIX+Hh?=
 =?us-ascii?Q?pgEjvdQzVDm3qpywyuNmRlFt82U2ywTY4jzAiRQB3j4IgTYEu6PUq/bvxGSl?=
 =?us-ascii?Q?qSMpS+vjUDZhHV9R7r7trJoBtwjaVj+eylyXVAAPKXtQPOBNuVU7V+tZCVDr?=
 =?us-ascii?Q?G8lwk9mEGRxdP5BujebCjst6rkd53VHUW1aFv5oTgHyhBPP4F18O9QDptqYh?=
 =?us-ascii?Q?PNNTWUQWBpKIm3AUV6KtFx52CosLldVBH3lWvxnvYzsZcR6Ukhvz92NQk9Jx?=
 =?us-ascii?Q?ERZmV7eMNDXjz8ex+XYFbL9nBadp/HNmStS2WMd8OM3hPppMGmfgPOJL8TaE?=
 =?us-ascii?Q?S+DJHBbrS3PXrlUOJacPO1ni7S+3Hk5PHVx68Yp3MtYoTVPF7NUn0nQwlWm/?=
 =?us-ascii?Q?2GbOeUEyZ2sbKOvGY/srW4a1sux4XSTv4u4rhhlLzYblPlnAPSOau7zNmNRo?=
 =?us-ascii?Q?Fb6BN6xvkGnZ/+wS8mrP/ce/R8MSwJUoIVh9axGYtito1Cj+J1UqYGW8Suak?=
 =?us-ascii?Q?bAkbMpfWfLNwhesvg/pjPCuXJgw+BFdhTt5mTeetgsA6oqtBGfHr0TBTG3MF?=
 =?us-ascii?Q?dX3cnGHiudcZ20zJdJ/d6nNTA5yL9FLStNe3iDLNn9fL4NVmlK9pLiVmOD6a?=
 =?us-ascii?Q?T5cHmrkS9/Qbnc1Q2F0QVlE7Da/JdT/VanOBA6qnx8c7bA8geYRlSpmFr05P?=
 =?us-ascii?Q?lTSpkfxgr8dLt+CGMHJyMpOH5bxuLXUeV6RgkdTRoGn1KgjG9Ns/SnEBo7JY?=
 =?us-ascii?Q?s+abArwvX98B2SHa6WN7WAJlkezYR5L/u7D3IOswKZD6MhmxRVm9rlsYNREt?=
 =?us-ascii?Q?iRMjRHcOY73OU5RFthqXtpmB3k7NZawkOzjTQG2UH5I4KuSH/xUvadSux/tz?=
 =?us-ascii?Q?bHLJ9M8hDePLBKDgySYza4g7KlN95fNO/niIOP73xtFmoCALdLamxG359ERn?=
 =?us-ascii?Q?zs9g7WEnaGk8W/A6YoCF6o8fZm06K3aPxqiMuPKjirNtJf55/RgI+OT0BHOT?=
 =?us-ascii?Q?bi47m2zQTNP8ItQXUDAO6S7wJA9DcZdEgX0jpBD20qIwiVrMfeuQKTGfRte4?=
 =?us-ascii?Q?I9nLa0f81Eyyej8/vrcNsHMUjC3A/pDlIhE8uxPkxFyURFW2k0NKKWldS9bz?=
 =?us-ascii?Q?W3oECpK8DZntPYO/9HolA9NxSaunuWc6D2Xoq3N4qjX7zImz8FSZRfjP1MJf?=
 =?us-ascii?Q?d+7GoPiHiMqLx0vvtUj3sf6eQURhC9m98Y02GtR9RnzVkB6mVrsSZbIAug7t?=
 =?us-ascii?Q?MowmzjxiF9zbcgsrcEjCdlHEN284eB13FhvXyiw8YcAF1q4wyLSA1L7RDxqN?=
 =?us-ascii?Q?eE1C5gR91MyGZkmQRBMh3n8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a048fd-3ee1-478f-2853-08da0211839b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:12:27.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HwrvcVNSW8+iiT895dP1xQmmlp5R/cXLs4FtMufxjQ71SP2d0XCeK8bVKOcGD8JLIy/mVK3x6o6wz1vM/jx3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Default Designware EDMA just probe remotely at host side.
This patch allow EDMA driver can probe at EP side.

1. Clean up patch
   dmaengine: dw-edma: Detach the private data and chip info structures
   dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
   dmaengine: dw-edma: change rg_region to reg_base in struct
   dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct

2. Enhance EDMA driver to allow prode eDMA at EP side
   dmaengine: dw-edma: add flags at struct dw_edma_chip

3. Bugs fix at EDMA driver when probe eDMA at EP side
   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
   dmaengine: dw-edma: Don't rely on the deprecated "direction" member

4. change pci-epf-test to use EDMA driver to transfer data.
   PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA

5. Using imx8dxl to do test, but some EP functions still have not
upstream yet. So below patch show how probe eDMA driver at EP
controller driver.
https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097


Frank Li (6):
  dmaengine: dw-edma: Detach the private data and chip info structures
  dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
  dmaengine: dw-edma: change rg_region to reg_base in struct
    dw_edma_chip
  dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
    dw_edma_chip
  dmaengine: dw-edma: add flags at struct dw_edma_chip
  PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA

Manivannan Sadhasivam (2):
  dmaengine: dw-edma: Fix programming the source & dest addresses for ep
  dmaengine: dw-edma: Don't rely on the deprecated "direction" member

 drivers/dma/dw-edma/dw-edma-core.c            | 130 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  32 +----
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  44 +++---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 108 +++++++++++++--
 include/linux/dma/edma.h                      |  56 +++++++-
 7 files changed, 297 insertions(+), 166 deletions(-)

-- 
2.24.0.rc1

