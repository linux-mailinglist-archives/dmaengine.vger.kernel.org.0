Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479B74F677F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiDFRZl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiDFRZd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68A482373;
        Wed,  6 Apr 2022 08:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoA8FqdVeLyvRtpL543L1vlHu6cXJaEiu0aCzDth/EvML2m4XtKFpyRsaBUFoby/G/gLlSsjcPxr5lDkfCJTvBsLy9M2aBZWUMQjNp+1mnOtb9letq7mCBYCYUQLKuYvIIR+k5iCi1otVexatc20JoKusumFxrN6pnB7GKCVSh5+C5AFY5XJiciZfq8U7j2/g0ROwg+xarfqrw2r5TKq7UDCYG96i4zD0l+XJJnOJ+NKAO0rCuGwqmY3ROkNgIS+m72nyKEWjOn4prwbDNrODHPIGffjbzb2R0A9EciHU5nNDyIdn8PetkAPeKC/zRUFmjQfkL5bZy45lADNJvgwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QShmuTlkPiyzuO6Q7AsDeYZJhV/DkGFrT9LqZ4TVin0=;
 b=Znlx1Lcv2SPftQWEs4YYlBoupiiqqKD+y2IQ5RJn/To87VBIv09AksNL3/objPe/W81PPAQo3gS7E3RFt3m3KXvANVeEd/mAFhXpoCHqILiwbdPO1zbMn/Cp1pzs6bJMIoK7PaRcXY1JvtP+05oT9exxVimHcvHyCtgl05N6e++PE14384PJUr3rwUz8sw8f2Zrj7CCpPzkD40juin1cp798bA+8HfbYlVIBidsKSNN4IZbHYEWzMWRSqPMdWXYqACsqQApxZxik9gtebFwEKXXV32xQm8LD38xyMTR3RzZJSHmeEf33Bz4ldnRYZNzgoJrBYMdvj0xqF0uvfrOTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShmuTlkPiyzuO6Q7AsDeYZJhV/DkGFrT9LqZ4TVin0=;
 b=oXpw2akZ0Y6p+9gjWAWUFFAoAj/w/5XHiKK4aNnIyu3K41x7Uhs9E/pfrPpkYAEonYVx8kxIbzQ+TrD7g8zCG7Z+CZ6U3yXy5gbsloMFYQBWPGwQnnEbTaaKUKw8zo8MmkULNphVB5TZc1cPjggfMmFRPFxVKzi/PNwTUOL4F70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:24:19 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 0/9] Enable designware PCI EP EDMA locally
Date:   Wed,  6 Apr 2022 10:23:38 -0500
Message-Id: <20220406152347.85908-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af5e269-319b-42dc-9026-08da17e184e0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7343:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB73436EB9776657CEF908B03C88E79@VE1PR04MB7343.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvtYWuEcq+bbDr4qpEEf7qIeinVCqrDZPulX4glLCqbKkpufDQAasUqCp1uCx5ew3fsjAETpG1dl2FgadC6oJbA2sROCLCayeErPAyi7FdJzpw6oWh1ajBPjh1VdzLgXjEpzkQzcQFaw/UsSCfffXEVRYLxu0/g0m5/i0cq3bEgblGqL5PffG20ACx3L7awt79h4COfacGIvYk234vX8AriS5+8fkTGtYx1khvTSePFtHshuHVbOc+Ti5BW6FP8nK7anbHTFi2d6iXHfNqnl+6r4PYQc/IP+/pVXHhdk7Mnt1OFFsrx6RQuRpJvD6YgZshEAPpUg3iTbt1K51HUdsnK7+VvLA2HlYaVEaLodyg2J3FeG7+F6YRqrYm4gnr7E4U46ZW4fdOSPZcXelfY4+Lm0PGrKWuPjOe1wZhFGB2KGq6YdAOQXgf7zeKnwMjzQ4xXErISxxySzDnLk2yjX8CginlXlUvPTiSvkAYbKqYjDmcYXPAAiNFm/GuXImKmrvwsvxnn9jAGfJ9WwkC47Ds+3vSysk5NeGmf5P9E9N8NIZmquvWQaH6Sq8pNya2kbt8cDYz6ZN5xBK3XYHcM/w7W4LyavzXPJa69ftAuhq3kD5Muu3HyNzlW32PEEyYBXGtcYM4+DdJvJE70DKNVrvCd3gXKku1j5fWO1CcnuMktbgLep0z8Hq8sNaboQoC+uH/bHulME18PlghcxXl1sSr0xjdnZp7K4nx54QkwlR5OEnQn2GWYJKZMj9tPYZYIas+fG/PTrhSLQcoBXspInZhb3ruVqKfuM9RC9W6HEc3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(7416002)(6666004)(36756003)(66476007)(66946007)(66556008)(8676002)(86362001)(83380400001)(4326008)(52116002)(8936002)(26005)(5660300002)(186003)(2906002)(316002)(38350700002)(2616005)(38100700002)(1076003)(966005)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e+/ciIp+BwmALgaFtko+McaGKtJYq1EXzOBzwl09Rwetirv8TYpFDw3cqnbR?=
 =?us-ascii?Q?zxI7B1lmJTmLg088dmTKSxXhuIHWC6gp1DjAKtV/upZm1zlUNj0YShboEI7c?=
 =?us-ascii?Q?ZX056XungUy9L4FOMz5Jvmeeq8PP+6oZkOCMLw3CPsH0TKJtcyF5SbYDnAvy?=
 =?us-ascii?Q?Ogd3bQRexNFAB4TwjjDSlgrXdw8VZZrTPeWigbPgW2pE7Fb2Md2yrmePC/db?=
 =?us-ascii?Q?fW15J4Sva6FJXskgk/dX5dwpBw7VtYyrw4L7iUHn1fn7la1ET5AFHHQ7fvfN?=
 =?us-ascii?Q?FfCQAtwRE5XmORY9NT34jTJfYooCSIdOtZWemwda1QB0tpmYZz8pFomWLS4V?=
 =?us-ascii?Q?KSgPrar95Ub+5sFjJZlxup29Q6TwJQ7cDrgVmV5X18prRxrnD88Xi9UqIM/c?=
 =?us-ascii?Q?l55VXW5WtQ4eRljylR6hZDXlISoYmEoaejM0iK2F6YVdtWZnQovs0k6gJVux?=
 =?us-ascii?Q?qup6qkrIVRh6cNoKefDANgz6G/JCrvzk3tPZ/hPW6PKUS2TknFU9qBl3/CoK?=
 =?us-ascii?Q?agZNmANDut/OuqjhzT4RTm19kQHwKUlKWFPJBcqmLtIpIRwKq+gyUv5sC8da?=
 =?us-ascii?Q?VHD5oDjLD+0FlKziFrOdEuVuPuyZl6ba8M4DleVJGzhic4Omd8P5QCwlrtIH?=
 =?us-ascii?Q?AAPWX/UqxXdt7ytTFGieKfxTIWc6CpEr/5r0rtnuDHrlD4hdM96nHbkU4fqH?=
 =?us-ascii?Q?d91BWEGTBxWOy0MzhaudaUSDk0sLSurTZB5qvCU8pXrs8RuNSHVQp2v7O8yP?=
 =?us-ascii?Q?vzjGpdI81lUiYAwfIIG02D9DCXKGNxcZzv4HQduXlW8Nc34yZv/zy+L2SUXu?=
 =?us-ascii?Q?n9+xIKPv4b4PWeFZLHVYey5e6OSZAZKnJet0m6cEd8k6VvYKSkg8YTVFuO2H?=
 =?us-ascii?Q?lgqQhzzweZg/sAitXidoGGSpMH6babxQck73+RBPfEogX2i/NpYtjmPMfR08?=
 =?us-ascii?Q?b2TypyZo7qtjWZ2YnAvg/S1b6oX5PKV4JGocWmZH0m9KI8AEyTJDiEJj29WT?=
 =?us-ascii?Q?z4FaGD+mWKJ45+h4OHLquW/UunENRCRUWZ7M8cQB8IR10+8I0/8o8D+MjReA?=
 =?us-ascii?Q?/L2BmxmvdVuQzaJbdbUu+WrwvV+6Afb4ZkUbue+XDsV/FGwSAy51+wBmwthz?=
 =?us-ascii?Q?DJYyP9vBLPRg+Kjryf27Yv7FrNXqBXXHeOKinadIdSgkz+upgZk68e6Y6nER?=
 =?us-ascii?Q?3hDWyFfhn7Vp52ysC12t6pVF2NMMwOh3HndWzSF02byhN4gXgu7EH4N9dVId?=
 =?us-ascii?Q?gjc3DDtXq0Jy25tCmp0p6rCy0fB6OLqIfVppDYqVAhAqLH1fBqzDrLB0u/Yv?=
 =?us-ascii?Q?PL/jKU6Of5qk+cax6XHN62KiX0MOlY8yKu+69bJ05eUGuylZrNP5UzAsvFNl?=
 =?us-ascii?Q?KTRAitGSTbl26lnBvacn9wPlH3BQ8w4Fqaw1ny/SXn+W5ZLYsTKgShuDTx/w?=
 =?us-ascii?Q?dnWW17qxb3XhTYHclgYkT570oIyC5mn7WvY+8ChMhQw+4UCfB2ZiCzkyhhNC?=
 =?us-ascii?Q?qZ+wL0JNDRwwWPIpR90gp3l+JVMcno5mHd/QcX/8RQyzrlvSb3qdo2qi/BKL?=
 =?us-ascii?Q?8M245ZdOY4T7sI89me8aTYwrBNyr9g/sBIQ0vW0UT4NhwCkn2touEHjfmlnQ?=
 =?us-ascii?Q?HEgK789LsazFmSEe8SNIj5ViVmNvgp4WtnfCn4+TzODP2wj1yyYTGTtQu4a0?=
 =?us-ascii?Q?kVI45Rtpf4LKPlLeFMtsjQfxE9FCr3ozbCkLXzaofOZWoFW6dkvSuDLG5lUw?=
 =?us-ascii?Q?84717kg7ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af5e269-319b-42dc-9026-08da17e184e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:19.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7UcvkZAPJlA8Nnu6MSd+zbHE+Z9g9zU0gPxGcvy9pn/lJwDoscW807PRon3NvJgdAfTbR+9tnTYOOrpjYgykQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
  dmaengine: dw-edma: Detach the private data and chip info structures
  dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
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

 drivers/dma/dw-edma/dw-edma-core.c            | 137 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
 include/linux/dma/edma.h                      |  58 +++++++-
 8 files changed, 310 insertions(+), 175 deletions(-)

-- 
2.35.1

