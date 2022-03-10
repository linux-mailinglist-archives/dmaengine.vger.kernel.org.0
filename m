Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348DC4D5202
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiCJT0W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiCJT0W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:22 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B3136EEB;
        Thu, 10 Mar 2022 11:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ1+Nil6otbMvJ1Fb3Hi6Q3+UYoCdfGSFSCGzZV7o0ddPnGzajBwh5qX2s3QNsJsrX9wjht7kEBrsVZ/JX8scIHjf2zdtl5wqOWqLuWI84lfZ8uj2ZUbIHXVg9RijCkwUu/5dzl4Qw1Y49S2DSF7qJgMlJ2vGIlqYTqYJzfcIjsn8TZ//1mdFliYnj/ocv47aCT0uaA5l8l7ywnB8hPCtj/0MWj1RuYP6kWfD6ey5hCii91N3oWhdeFZWYzdTX31o6bI+sM34cRQaz6Y+l+hqDPJ2KntougjKPUN5jyukMLsbyDI/Suj48XNCWMv0m4P+u9OR3jUCRd0VPmoceHtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+FIpQpgqEQxrwDPr5vF0/O6QtpDrd4HbmBAcLMCEoo=;
 b=KjItMZB1PIhvQ2zM/d9dui2hXSElCtEeXrUgOzXv/H4UrP6s9XwXmh49uzYKZJptEYSP6UnfO+48StZk+fbK6AFHRTt8t/MB010gav8krR4L/ZAluTTYx+le6/kTZw6a9fzvp74SG1tOYiUefcuKEszSVvciO5+9/YUd5VIm5A6rsQS9lymPr5sPmhwxe6g2Z0p8FxLnzj0tOtzMEt4dv90g82A+e8qG2ngNvcCAwTcoVku2t9zQw40wM4aZ5oAG5nm042XO/AGBQyPo2IeYxW1QUnoZQ6MthmD93EYiP14Cedi+wlSBglMLM9y+L36JN+FBg0HJn1f3vhJPNmc5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+FIpQpgqEQxrwDPr5vF0/O6QtpDrd4HbmBAcLMCEoo=;
 b=N+0wW0fwwNogtxHdXbw9aQtP29IdgbLlkbNZmIj3CASxAeltK4jyeGqeJ0oBlBic6t0JXWqOrqWPIJtjB32Sod1lOdIttR+OmYyhPVmu3FRH/4QnKjkCku6bvtzWRPEpUcmRrAHMoaBYYqtUqGTfgP+UTSxafDhF6KN3LOKVRZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:17 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 0/9] Enable designware PCI EP EDMA locally
Date:   Thu, 10 Mar 2022 13:24:48 -0600
Message-Id: <20220310192457.3090-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0df96d97-b2f2-4525-3a4a-08da02cbb554
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB485845428FD5DFA5CA8EC94A880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e3gUF1Mu9naESXWbiuRBeyLa+kkgo6z3HmyLY727G3wGqp0zYHZs89I0LQvVgiTE0qZWUv4SQT0GyadLivJAogWVkY9kyUCn0xy/73/Fay7wiDDkfpn4FjLJXApfwk8T1bgNuqcBwj4rogwZy96XKCjMt1ifxuwirNTaSFXpFb/x4n++AKasq0NtrNxkyzU5WCdu+vzGdNl3+liaJaVWgVyM9WRWWpm53rjZPnoqEg3P1TAoUpZAH0kj7F4tQgAe9eF03LjKzIqerfWzAIThCbVmaiJWiX3lEvG+IPKs5psK36/YYpBWeJSoxrFqotD1xDqJ2w2akkKbDwD7XOJ6qXAaJU0Va1QtSeDMU7QSW8CG47ZMq7kzr1LtFhw7FoeunWvC40IMoKxY/HwCz7D7z4PEjdRAhxHdZb8SIxoiaCMXIS59t5s/cR04WhaUpm2flaxaP4SsRx4HUHtButRNAvKpYl3mwkKm8tFRcpG0K+CxzUqtkC4s7B5yxZcwr/9npRJy70nz2u/kZVFF6tRXb1Qt0LZRCtlInLJsEV7DSjX+LJDoaioIykebX0fajr7+LzNX22GzT7isohMMZnjpSLnU85oDPtW/bro1CE3BOaoxVl7Rxq5jkHUyUvO15vCdjRUKqXRHUUfEZQbme570fvHxd6/hAzrR6iPl0/jh5j6xUL1mEa7nJK49ZO85g4bIsejcmdRbMoslWxZ6k0xw1Z3FAcARyhVpnUkGhxiJYH1IOdrZ11wme1rF03DE5GkNnlr64oEZorIhH+D8JN4CsLwuItZrB5G9sfZy4YNPkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(966005)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HR6siXvUwI8uCI0vtmD7KVjWLJPSs+giHG0B2+Fcj7GbcC3Cmz4N/9L6szjn?=
 =?us-ascii?Q?HBk/Fhtm8UlZ5+zACPaN8lKIP9t/YF02BhfHoKRWlsGXhIJUP4SGLJgu1ufk?=
 =?us-ascii?Q?WQPRn6Kj+nrS64RgOWbjANGLtPjsuim9uFn63PDX1Z06yGhK/HVDjR4oWoSb?=
 =?us-ascii?Q?z44QwF144Yur+GaOLkEmogqaVt8RBoJELSjovKizZGoWQNTNHXryvR6WBSBC?=
 =?us-ascii?Q?Ur63p8WhJz22QLMZXKcilPS/Vbgf31jgbW4nS1GEhCib2G92EC87AB5E/GXG?=
 =?us-ascii?Q?wBOoWtPJOvmCUNMMsdMQnThHG0g+KH4ws0/bRqRrfRh6EL9yj7Cccnsg8yEH?=
 =?us-ascii?Q?pon3XBthsEKllV8WcADsxObxc0Cr5xjve18kl+vBBlgTp0Qaq0cEgsBY2Gt3?=
 =?us-ascii?Q?OJbHMGbRc5NQOQO963MpfRvqRG75tTqnDZPpfX8RELhniL9RHiIn8eAir7qc?=
 =?us-ascii?Q?QXOE2ys4W4pNXtmLRnggA4S2xLSQSffpofqZC0psA8UlLGV28eiZgjjbarm/?=
 =?us-ascii?Q?poTD5MEwJwEu3o3d5l+7ISL6n4iFprxj6brgm0FZKSKHZVRHriuWW6dn51Cf?=
 =?us-ascii?Q?UfHSHQDed6xONYqTeEUIN6r6ET7woBv8diED+ycEcSNQlxIp82WiaqnXoih9?=
 =?us-ascii?Q?5aoqkhHLFE4Us0UQNXeUhXcy/xE/CDslnjyM0SIAA3VCOuxL+X70lsIzBawf?=
 =?us-ascii?Q?RlsvPPlITB3164JbG4I7Cd/Le7rKHiLAfp24H2Qr45VyYsKY+g+0ELnp5gg9?=
 =?us-ascii?Q?sZKfT9rzYGBRplAXfyeOFpldY3S5EXD+lJjJzwiZrlCvGiqll+cNzvBPDTbS?=
 =?us-ascii?Q?lEzS64pjIshdVUElIHT1QJ9ppCxir1dAYe3KxU6L6fxszYUbiFK4W/YDa5i0?=
 =?us-ascii?Q?2rwae2cHskKMfDHa9CqERdDFNm91hW/L+P/zhvBcpuf5rsqiRT2TLR4nbyNx?=
 =?us-ascii?Q?DIHps0MIw4SgKGsng7GH6+LM57fCOTeOWF4DCDXparkafp6Dno2HbT/15+yG?=
 =?us-ascii?Q?Bh0+NFonfEgUWFSeSnmKxx6ghoThFN+Yn5gwHLuCLeS46fDCE+b7vKGEDp23?=
 =?us-ascii?Q?6UXUb6Ky1CKZZYnKXXzgLb3/kFkiUtWAafTjYXHdJEjSi3c25Gv+31N8Q/Zz?=
 =?us-ascii?Q?w/eZk7uQDGbZYc0nSq7XOntooYBhw+hrLilTOjWROa03W/gQuxoEUtQRLifF?=
 =?us-ascii?Q?0j0wiFhgjawzA/NuMKAIPeFbCTN/DgUWbgWQcfOwyyq2APuZU8KxsLlfooJ3?=
 =?us-ascii?Q?j23bRo/WJbdSgpKFa0v3Wnt1HOE1/gLXmjZ3wd9XVif0XSEpUnbatS681hj0?=
 =?us-ascii?Q?BoY061X9qXLSURWJmJMGKQhMtotLIlOxDsOxgGaIy/MgB4/ORusgZQwiok0d?=
 =?us-ascii?Q?W2s4lY+tZ9HKYboAk2999wodVln6Gi6fIR8rW3aJmxRY0YR502fH6BnyiGH4?=
 =?us-ascii?Q?c6PwqzY0y5Yg4T/kMjknI1NHWQhX68Fc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df96d97-b2f2-4525-3a4a-08da02cbb554
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:17.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4saxs4Kh494Xcq0ILD0WYaddma/RBj/QLmefVCDs0vDYhKL3gAEVUKjexc47pBr74zAHR/TAyO/+L5yVr90vdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
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
   dmaengine: dw-edma: Add support for chip specific flags   
   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags

3. Bugs fix at EDMA driver when probe eDMA at EP side
   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
   dmaengine: dw-edma: Don't rely on the deprecated "direction" member

4. change pci-epf-test to use EDMA driver to transfer data.
   PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA

5. Using imx8dxl to do test, but some EP functions still have not
upstream yet. So below patch show how probe eDMA driver at EP
controller driver.
https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097



Frank Li (7):
  dmaengine: dw-edma: Detach the private data and chip info structures
  dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
  dmaengine: dw-edma: change rg_region to reg_base in struct
    dw_edma_chip
  dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
    dw_edma_chip
  dmaengine: dw-edma: Add support for chip specific flags
  dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
  PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA

Manivannan Sadhasivam (2):
  dmaengine: dw-edma: Fix programming the source & dest addresses for ep
  dmaengine: dw-edma: Don't rely on the deprecated "direction" member

 drivers/dma/dw-edma/dw-edma-core.c            | 131 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  32 +----
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  46 +++---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 108 +++++++++++++--
 include/linux/dma/edma.h                      |  56 +++++++-
 7 files changed, 298 insertions(+), 168 deletions(-)

-- 
2.24.0.rc1

