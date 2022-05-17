Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F37F52A5E4
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbiEQPTp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349827AbiEQPTn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:19:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AFA3BA51;
        Tue, 17 May 2022 08:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FshAzXl0NcjY5fILiZ28b8GYdD6XkCBHxr2ggwuxgNeWr+kXObtQjbf98u6e+vti1uSkzyKf39sxdjNm7NjKZMYHahlKXYON/WmwHRXGjMB7Xf78DSfbVJFEyJxc72M967cduLy9yguj7Xot9tDvD2K5HFIX4iF6bRRtP6mw6oMBtcCjnu+A5BTF0ZD521cvV3WOcEAu55G8w4kU9aLa9SqpoUMPW2Tc2cjUWqcJSpF7E5k69P0LGk5ngtSzwzwoG3asiA8ImlkehZqXCkY8blv0UaM4J5Ghq78cUV1f0KDkapOOa9UMoexlWwQ5G+RBepsT5041+F7hCBye3ncHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21xhV+/zbJSwDY8xKYR6L0PfAvBUscprZ4s5Kg7TwzU=;
 b=gZEU1zjfQx82lGr9XgFcv5dSqyjkrI5zRwVyZ+sVHcR4JJpg6FZYlmsVeH5yaCBmxTXHu2zm/e6ugw0l4RIsq3rt/QYfs0Zo31QjwbxJQN34p9prQHEHh3Zijrzsk9k/gLaIaTKVYiPSdN5AEieRGlmcpRxbp3pmu2zbPUdmDYNgW7/BTG5gIt4haydrRL/BYbgm4NXQY6P7BPo6/5Qd20H+bhyrUmiF2VvOGJxFlBekfsn/AcqU0wslNtJwS7bu8vdH0PE2d1byfvI+7ShtiDSYSG+RfYUP4pkVSWjIMJHbwfo76w1SDPSzpbW7lA+yiPX49nUMUKYzQ6rARO/uSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21xhV+/zbJSwDY8xKYR6L0PfAvBUscprZ4s5Kg7TwzU=;
 b=ALfqgOT+xDIO53utZ5oyfzhGoQJCoX5HQPjq4ou/B4I5EWrkV1E93SKpkxIU/fKjhW2h605dQnCg8Qmx+94dy7idf7yV5TLOYsL5W3kOaYiaC1O5JhrbCtMedZ0WZ4FGuMo4/9S1WcXfFOJmy9OtCoUe551sSHuBTkV8tzUcH0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB4367.eurprd04.prod.outlook.com (2603:10a6:803:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:19:38 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:19:38 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 0/8] Enable designware PCI EP EDMA locally
Date:   Tue, 17 May 2022 10:19:07 -0500
Message-Id: <20220517151915.2212838-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a535f839-f1cc-41a6-0913-08da3818a845
X-MS-TrafficTypeDiagnostic: VI1PR04MB4367:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4367815D696218284A7B3C1188CE9@VI1PR04MB4367.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6U6whgoB+P+J90QHwXjjB2RPOA0S2gTSaEjl6YeS4GRBf2l5HwfShEQbe5bh6ymvIud2EXLJBju5N0/jNbj4ZbNBkWjZr7iOcpFkTm5cbZM5oW6ekhXVUe5B18VGMfb1rMoijIx21KUh0BMSoI+myOSFj+tdJmyjoCLHzrQLyiFJtZka0TA++hBFYpGKDjDeYrwQmc6dIX2zX2rpwcsML9rRsp8lpJ9PmthDWUQ8mBFc/kNOITWRLFxh1V5GmR68FfcHzQ4qD00p2B8rMFvotuILHEM0yCwGPbLHFAqkHd/LVO00hImT3Zwq47XKVhfDBRBx7exaavCeLH6PlRg7KwvvjQxNTAKTiv4dnPpVX6S4qDELjz4jKMfRfU7v39WxY5Ts9lCCAeNhZVnnhRypEwfPbnQ4A6QGw9DM2hrVsWPBCpA/RIIfxEKXPjuxUpejOFUfEvrYeAGTeebkptawITRxenXaXfS2eV/j7AaACU0dcFa/tTEhqYVHk528UtHwRJHBW29Vr6l/uXuUAixYePj7mB42U9wJrugFtpADnlwW8sNgDWG2Pv4aTJJTWm0RJqzPFYHMWDXjoqM3jWkGaneyU+qwcK4HgS90DQVOlJGr4pvRdkRAgx/bcnq7gk7ohmFjtjK2Ua6aFyDp2VRaEtdlnnNL1AtkCWzV67KA60X0mkvHnZo/NmGYLwohaP2jFttI2amvneBcHmhqs4HpTr8FpDQYHDKE4hIsBVeVRA0Yxy3k33z8pV0vHTZ38Avk77IR/GRWyIqvK/2xPg/eHlCsVA3x84ENi5GfoErt+f5EZOzHUrgtJnmj1OFnaMzE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6666004)(52116002)(86362001)(83380400001)(7416002)(921005)(6486002)(38350700002)(316002)(508600001)(6512007)(26005)(6506007)(2906002)(186003)(5660300002)(1076003)(2616005)(66556008)(66946007)(66476007)(4326008)(8676002)(8936002)(38100700002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/7bcH8AWoi9923pNwwesIIiNk7CcksFsRxIzsMsTTybVGpPhBa3jjWwOFtz?=
 =?us-ascii?Q?qFP9ajQY/f7cgbVXoywSGSZIfmUH1gIFMLMPHi78FlFSt/JWyB92HhE/hKvE?=
 =?us-ascii?Q?OhWg+94o35OnVpgoJvatmulrdfeaTarU935nrYG50f1B0wkjoQuLM6BtXm1O?=
 =?us-ascii?Q?WPn2gWLGuAd4IA5B9zfuYkiRBoUOLp590Xsp+Ax+XLGU3XXhozYkGObXQgAh?=
 =?us-ascii?Q?+73WESPk8x2EKDiznuILh8JdR66JhWIuf6yIXvLVZH5XQ3lDUE42jIr2bQ+2?=
 =?us-ascii?Q?CiKjb3cEXD9vAzkL1rdNbpIxYo9eotGdVJbNbrVptW5T2Md1k36lzsbbrsYM?=
 =?us-ascii?Q?zpy5Iq0Qmst0JVyX6kfHWSL5DrxE94XNUhz5Vbro8EpXqBWdSsVoinZL3cus?=
 =?us-ascii?Q?QtkFsEgs8rI3ZAZ2SDKIgQ9xFr+xF5jt4ga9L16xFEDImXiJ+GP/t14WMa8y?=
 =?us-ascii?Q?yZhiVdxjr2wUszNfIP4ejBbKYN+cn+agmcNWNwABiBuVN+ta6jE8r2Lpxjqb?=
 =?us-ascii?Q?69ojlS7IAqVxsL7x91NCrq0cg4FlLcRogrZBfTpX7kXcBaSXMTjr+SXbURnT?=
 =?us-ascii?Q?fQpkk/wDEgHFQDpYtvZRbjJ03rsItS+Gxtyfj+xH6nagu548ljZkr9bbgwMp?=
 =?us-ascii?Q?hdKHoGXHxDbidJiFtNWtqQkPNapAiGaWVFgJZd3JCF2b8nE2XtuMmODKC/YK?=
 =?us-ascii?Q?INr/BvYuBuE2NfBo9RalvWv/3ObZ3nqfkWWKSmMF7xv1NZJUXsObnw4qA6A5?=
 =?us-ascii?Q?CLldM5cwYkwSmTFAPK9xjowDoe/VtYC0MS17SZem/2fnB8M1aIrS6N3l/9CQ?=
 =?us-ascii?Q?6Ju/M6+leo7uM5r1p/JKbb3l4IOvGpgfQGtXwwfFXQZyCYUySJyVK/1gJcfJ?=
 =?us-ascii?Q?0VZtHm2CWicPUN60wI2fB344ZjOjef8LsPMTgTg1xq7pZcVpyZOPPmB6QJWq?=
 =?us-ascii?Q?PRzq211QUYfnPq172qRGHLKRcpbrUSrZNqxwCuJkj/42JhkrEPH73FrufzWt?=
 =?us-ascii?Q?QKJC1ypnjMEFkdFFPY80uRb78TCHg8JjV/ymO/YoXbGgS93CTurVMMds7Nt7?=
 =?us-ascii?Q?SKKay2N2gNCx6hOQGLZgAJtLzep/LgKYsuCwchv5W7CLtDHZ7DzLaSIUtFwS?=
 =?us-ascii?Q?6yz7WuyqrN6bxfxCVw7yWRvcjC2n1+82wm1YeS6w70vkPD8k60FTTPtr5GCZ?=
 =?us-ascii?Q?8U/vczNCZ3mSuVYFk1DpEzYIZX14uOpmRx58QXzT/XKXP95dZq6TeI0TZK2N?=
 =?us-ascii?Q?Iua0PqTz/YqfwIS3rQB/IcsA5Vb/3LCDkkeLKCfXrZ1R4H0DE112ruA2LA6s?=
 =?us-ascii?Q?H3RRk/sj+bkpGl2afLTpbp55UmZnARhAaX1dmuUfbjv7xGujGO49fss6B6ve?=
 =?us-ascii?Q?WSkHr3LFWJNba6nyJuuI7ap9e4Yi3oLjtsOgTwGkOl4+OeN86L/aCO3yzWin?=
 =?us-ascii?Q?0wsYASOpaWtv+pxilm7HVtIR/L2RUQUVtMA6BvO0CZCKfrO9I5+JDMU2mBd/?=
 =?us-ascii?Q?6mr/dzhUO3eCe0L2IcFxZLZI/+AqWaFhmlGpZTd90v7XQpIYqAlvNE0feHky?=
 =?us-ascii?Q?1QyS8MnlCUMHy5DYeo9EqrsdVK7mHeZuXDaDnizs86UQzBY1sJzRdp6nxdRH?=
 =?us-ascii?Q?zWCisPEcuVA1Xu5sIylRZW/VlzDNR8M/3NCgAFwjVBM609676DBhhd3xOB3L?=
 =?us-ascii?Q?pJV+F0t7z5LwCb2sskr+rqcOPoTL8cFec2DqIHVGQTgYwZQ6HikThhDZnskh?=
 =?us-ascii?Q?qGscbii3cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a535f839-f1cc-41a6-0913-08da3818a845
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:19:38.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIDb658srbUJg4lkfd1IgenG6qxsEZ7X2rIgSqn7bSRojgF9YSmBzpyE7SGFH5DFoO9Vf+sNMQh0dPYA8R2JDQ==
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

Default Designware EDMA just probe remotely at host side.
This patch allow EDMA driver can probe at EP side.

1. Clean up patch
   dmaengine: dw-edma: Detach the private data and chip info structures
   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
   dmaengine: dw-edma: Change rg_region to reg_base in struct
   dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct

2. Enhance EDMA driver to allow prode eDMA at EP side
   dmaengine: dw-edma: Add support for chip specific flags
   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
flags (this patch removed at v11 because dma tree already have fixed
patch)

3. Bugs fix at EDMA driver when probe eDMA at EP side
   dmaengine: dw-edma: Fix programming the source & dest addresses for
ep
   dmaengine: dw-edma: Don't rely on the deprecated "direction" member

4. change pci-epf-test to use EDMA driver to transfer data.
   PCI: endpoint: Add embedded DMA controller test

5. Using imx8dxl to do test, but some EP functions still have not
upstream yet. So below patch show how probe eDMA driver at EP
controller driver.
https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097


Frank Li (6):
  dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
  dmaengine: dw-edma: Detach the private data and chip info structures
  dmaengine: dw-edma: Change rg_region to reg_base in struct
    dw_edma_chip
  dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
    dw_edma_chip
  dmaengine: dw-edma: Add support for chip specific flags
  PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities

Serge Semin (2):
  dmaengine: dw-edma: Drop dma_slave_config.direction field usage
  dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
    semantics

 drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
 include/linux/dma/edma.h                      |  59 +++++++-
 9 files changed, 313 insertions(+), 180 deletions(-)

-- 
2.35.1

