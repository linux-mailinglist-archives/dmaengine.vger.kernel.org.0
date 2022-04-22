Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6050BA40
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448730AbiDVOj6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444104AbiDVOj5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:39:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A805BD2C;
        Fri, 22 Apr 2022 07:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogRZ1gE915+viPaVlLfcy3B/TaALTpO2CGihjsI29UtV5ZpZODWqa6e9O+LqoDvBLfTUJYcPKfkV+siu/cTbr6hTU8mXaNgPWpiAvtNOYXdQgOxQEdkIXfBNXo+8YrDeIM5d+7OKGacaEdfXdvtE73TPS9ee+14gcoc8YBwWePaaoWZtfFfYA04WvV9Oa4kaLx7mEsa8anWRa8Tof7ZhzzuC6yy1HbSVMsLmeTG9tWCJ0hlmJZJmxSqCziKu30a9OMpJV+ZArtC2ifGxoIPtKXfrBmhs0j8KAGBZUdL0vMLsuEdCku6Yv7IEzYCUOM/TON9eFd/qUFq/fNZ94i2SXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H/7xYM/rKpdCsna6cwr9fmXA8doZRq71tAbpP5CJKU=;
 b=A6A8PTW6UptpGZqiyX+1AkAD2RSsDB+j7HgWc0id/1VEY083+SR6QvTXd12pI80K+Iu9dUBrzjtFToP6OSnhBF5dzYOIdSzxfy3Sh3ERVxNckffAOwKHHJwzYYwUC/ithOfIfgkyXvr2QTH7NSLZtFOeRLV3/GhqeqCJsQdybu2qRjPAG/YQj47qsYbzUSBfVT/jKoXmmrEj4jAZksPxa6DQ99LSgKstd1M9BU9oY9G5g5kwKClZDkGoQS6YqolvCvYIJh0JyYkNzvnudVHzEZOqLQyqlcfFyoSxGvp9emtbStmDVYONOrfRgzMIEY9eWL/W1mNwOuw1hAY/QtKXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H/7xYM/rKpdCsna6cwr9fmXA8doZRq71tAbpP5CJKU=;
 b=JdLWg7eJkYlG1PRkpvEEbWLaBAoLccMGEHZef6w6iaQx6475NrojCxcT5ZcprauSxo+mI3+VHStcXU4TI/mHNxaem0+M2XqwF61DCBPtEot8i6YG5380ffarUw0nN8OoVtSfDSsCtb4tx3RT03OYucqZAGgy1ROGVNSV5zsKZVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB5449.eurprd04.prod.outlook.com (2603:10a6:10:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:37:01 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 0/9] Enable designware PCI EP EDMA locally
Date:   Fri, 22 Apr 2022 09:36:34 -0500
Message-Id: <20220422143643.727871-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98e0aff-bf1f-458c-d261-08da246d901c
X-MS-TrafficTypeDiagnostic: DB7PR04MB5449:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB544977BE03CD42025F8FB9DB88F79@DB7PR04MB5449.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFRYcgBkyEKrfqYo49TdZvH9btZdcXB0LONKTx6rIZqC0VwGT6MIu4/t2hR1JB3ORn+kt4q8+h3wHqODNDIRO2DRA5ZDHwH93GivNU88/lb56QWDjDUe389xJEOTwRG6sbDV2sOmhPeQfMmeoTw/NR9k3S2urQNSWbtDJzOgaDfUqBPpsNr5pyY4WlVBoPibSrORivsXNhripYDX0i5Feyc8ICf6wX57yj9CxYYHBLkDsCoA0FjCp+2fp8PYXnG5uXgf4+n476Y4Z7An0RmciPMcquNq3B6dwDnWL4nfqqKuQLCNUMRL0DqV0SXzZPgkgsIZxLr0yB7nvLzULHXra+gD4Uchll6sK1f3/IV/7gM8g7csEmPw0Bn7qKki0GISiyie564IkUDyZq8Hsv5uoR+wBhIqfBFqmI8Sbrne9IORzQ4IW74ZDDUryZUza1//QWyZK4OMS9veWFmT/HKuig9Mxv9b1+F3Sv1cZ3f8vP4PqN2oCs1P1PKUIUIvlIUAtqj7dQ8IhtFo/ZcUc+X5eH4ipAnNLiTVecaVtqR7ROwPvrZzQ8PtdeBjDjlEWihqLElsQGvQYUkvUfJkSD45iNZ0X2pxIGdl1R5WSGrk3ZXnx2m12u0S8KEhkI19pOBL3gax6wYc6hhQX/lNA0wclng60xx7HzYOgoLs1m3AexssEYWYX9Dp2FgFn7LCJ26MicrdAz+Tz3Am/i9CBWcx+MJd5AN7urIhuF9iOpDPYnfOiXD6SgnubHjSu1SUCjmRCL+PuXi7P5tGH0riKg3SVixa6m6INkcnoGI7SbnEcss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(4326008)(8676002)(66476007)(508600001)(316002)(2616005)(6666004)(6506007)(52116002)(26005)(6512007)(8936002)(38100700002)(66946007)(966005)(6486002)(86362001)(66556008)(38350700002)(83380400001)(2906002)(36756003)(186003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2adikAhGV8oxe0ZiURm5i/Gn0mHnHdUf/zC5MU65y01ggqYPioN77dmVNwB7?=
 =?us-ascii?Q?bMOKe10Q0dim13n9Sh4DWG0oY6co2pehNLAFG2MvRpVU0rNkdVDHxWf/K8hl?=
 =?us-ascii?Q?zcYoePZLl+nyXw/H2gWRbLmPElTT15mPAcuZsOM8zFEaBJ/30oxRd609e7/q?=
 =?us-ascii?Q?8n3018vGdBbSF6/54LE8h5Q7j+E6cjCE1dTtGaN03ItQ1XY3QD9NH+eoPif2?=
 =?us-ascii?Q?fQ89szLrRu7dqSvAiIHsmDmZ2m5QrrFp1tl7IYnLbd6XnsXi4HsfRr612Qx6?=
 =?us-ascii?Q?CyxKsq8XlPgFOa72k4Ig1Eo5ox369eSz5EnH1YPn+8GWEdyvul2zsPX5TtiA?=
 =?us-ascii?Q?eJllEY4i+o6ESYHxIe9NDSWNDAC/nbN0oY0F5vSqfVt78tywYCp/MlOFF7oQ?=
 =?us-ascii?Q?Pwo8htzsp9mo0Qj4WtpJcTo86YJnvsUDRbMZC59MLBH+b+Ys5i6+Cyx+X92Y?=
 =?us-ascii?Q?xZVau1l4d/1m2x3L9J78WgkPvuLu+Pn6P+4esp5pL/0nwTshPn+D2dA9scBv?=
 =?us-ascii?Q?r4hBYkSHNLu/Xwzoy1lG7wMZsMmqOZOky4z3guUOxZmFEMSeliSFRfLxzqwF?=
 =?us-ascii?Q?ha9SnkqSdqTca+bJknvWzrA3puaRY3Iz0JsiRME6NO2i/gCfA7V1gO1dOXC0?=
 =?us-ascii?Q?4IcxKfiH1eYgvkSjcTt6arWl1Y0wHx4qUKj5T8uK04Bvq0ZT3OHd1c23s8Ig?=
 =?us-ascii?Q?pQf1DJkdKxllqwJRlzgseaJh+YrztOVQdk7Jd9sm3p/k0ln4MQkWUr6yfOKv?=
 =?us-ascii?Q?TKd5jeipnjwBozlgy51PTcsVKfPq9AW9gX4nwwcJXqGg7ghCSgbtAKco1O4J?=
 =?us-ascii?Q?Rg5qv9o9Zg+gN+DWC2eahkXx3V4PN4QGwqpSXOeaXL6ewU6KDMy3kUrssQtl?=
 =?us-ascii?Q?130kCKOpeJlo4vALFtmFzG4j53jY5sOkSigCj8W5sSi214+4Wvu+WBL38vVw?=
 =?us-ascii?Q?hFmWSUJPDw4/xG9G5FHh4znjSM/+tvxHPdmQPyMbMkrvyP9L+jOd2yO/dnxZ?=
 =?us-ascii?Q?rF+k/2TZVgn8ympRnbl4vM8R0+I/4wLNPryJkC1TZ1Z1h7ufFHOpkuYXRv2+?=
 =?us-ascii?Q?Fyl6qOY/xqdzv7EarvHnli+Y+UwPfAo36maziaSf5u6d2eV9kJ2RCbKZm5cD?=
 =?us-ascii?Q?GXBMiY7mZ84yrhNUbKW1yjLBoMs+fdYUUexUHbeVQioS5U9L9JHFLGbgxQW+?=
 =?us-ascii?Q?Y0sPSPtZpUytkco5QYUIIa8C94p8+SHShagHEUwOaU7nVLwznDS2flqWSKgE?=
 =?us-ascii?Q?I6cGDWATc2pVxki3ypEpdIQ3h0fyNdYXvNylVj6xNRxUBH5u/fVXI0hhSKCc?=
 =?us-ascii?Q?AsN9Y43Su9QmOsNwIZL5hVps3RZobZjK50h4KIuEWatzS1uLZbMidrSJbhW2?=
 =?us-ascii?Q?pWb3w7rpv+I3h8rquSNZMwDrLpa9tUIHq0ePzZQKveMxR2bya8G51dbrMmE3?=
 =?us-ascii?Q?9zYilKEd4JqJY2bvy27J1YTtUpW68+OJtoBP2iKlnVuTaSPJZUNqm6vnERKb?=
 =?us-ascii?Q?xkHHBD0kBU9uL6CalCZyrMPC/XRYgS4qRLBQytwrGgvRiRLeN0k6gnCEBHdz?=
 =?us-ascii?Q?ySU0+3vcY7UQrbWyOurCqI8TlKxBbIbgjcwXo+26yoJDF11MvJlCiI0xL1p+?=
 =?us-ascii?Q?RqmnyadqMo2uck/6AlL3wbz1SHV/FfDMGb5/3zfXl4vomJtmHmwjhz6NnWMo?=
 =?us-ascii?Q?5lMVe56xTqn9QWWRwSey7T3lDLR4UFbE+fIHJemdKsu6Njo0bJ6M0B4IjrFQ?=
 =?us-ascii?Q?dOFkkE/jOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98e0aff-bf1f-458c-d261-08da246d901c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:01.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ced83iNzAHPDynkA4kYUIB8syqQrNj1H67pzSR1CC7EPmSVpuVuAwgpegFfVFq4O4O6Zz1Qshx6Xyc5akjJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags

3. Bugs fix at EDMA driver when probe eDMA at EP side
   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
   dmaengine: dw-edma: Don't rely on the deprecated "direction" member

4. change pci-epf-test to use EDMA driver to transfer data.
   PCI: endpoint: Add embedded DMA controller test

5. Using imx8dxl to do test, but some EP functions still have not
upstream yet. So below patch show how probe eDMA driver at EP
controller driver.
https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

Frank Li (7):
  dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
  dmaengine: dw-edma: Detach the private data and chip info structures
  dmaengine: dw-edma: Change rg_region to reg_base in struct
    dw_edma_chip
  dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
    dw_edma_chip
  dmaengine: dw-edma: Add support for chip specific flags
  dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
  PCI: endpoint: Add embedded DMA controller test

Serge Semin (2):
  dmaengine: dw-edma: Drop dma_slave_config.direction field usage
  dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
    semantics

 drivers/dma/dw-edma/dw-edma-core.c            | 139 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
 include/linux/dma/edma.h                      |  59 +++++++-
 8 files changed, 312 insertions(+), 176 deletions(-)

-- 
2.35.1

