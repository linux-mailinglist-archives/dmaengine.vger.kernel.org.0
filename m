Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52557375B2
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjFTUMq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjFTUMp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:12:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15BA1727;
        Tue, 20 Jun 2023 13:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0w5WSWByy8NN36tzgShufToUz/VW+mi1Nc6HWXqctEY4AakBwRTAHdPlI9QHZvHjW4tQyttye0AJM4pLjhHpv1mVk3N3DxPZ448Mhv7Yk9Q16M1d0NJ2PKqMyrrnL79wvXxtX8lOKCjVr02mgLHWkJA65Z4b8VjgKuS90X+/r/tnNe3qirsDqipQjyk1g1thWN05xAMcmNDcu2vZHqoBRC8DmztnGtQs2zPGQHLoQSD706LKuRCsuQXFjDUonXxEL50SGyfFZZhszWvbBnP272H91AiT4i4oLKe+IGxQq4RWDccPxjwVV0oIAyaif8BA1WN1DN+qV4Qxl+Kpp6pyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yENe+/TBryzJZB26ULxb81LTOfoH8h70wIB6GOwuscg=;
 b=AAsJiGqDkg6+yFzfuwb+kYCtPRF2ClPSkYBxZ8hQjgzdVPtXCWI0viiLs38Gf/EvLYcx3wR7UzntbVFMhBoZ5p9jsPad4Gs5DNWGek2hjKSekWx9iG5xjO1AcWfyNDA4ZvLbPFHsbOMKnXuxKIrSN55ulcPCUTrhqS61Pu3H8kTdVfU6psqH/izqoUwSLdDhZaOe3ZVMzks2jZ1iDax/aBNb906gp7799zw47e71shPhh4K/CWflQSqp4Dp0uPD6CHgCdOjT9oZoAa6gTcbnicZv8lOFOAxdTie6vTZQIeBQEbwGmYxNe3QtWauraVQ1IqNNEedYKZidH1wLmsHM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yENe+/TBryzJZB26ULxb81LTOfoH8h70wIB6GOwuscg=;
 b=J6BB1gtxOE6g8j87LpGkFdndhXhtSrd9bdOvMjybJuWp3FtUdgoHL455bAKqOl6oe1kiA7I5prVTlQIjzeqE2grIc3L8V9s0yjQTJO7/jgYjCuPjyCkpR9fU8otvAFnnZoV/jEnAifNZhyUTBsPHoNiYRPzAzocbOmA5Fzna1o0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:37 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 00/13] dmaengine: edma: add freescale edma v3 support
Date:   Tue, 20 Jun 2023 16:12:08 -0400
Message-Id: <20230620201221.2580428-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 816076c3-6392-4176-1c39-08db71cab105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXuvUAcnUVYVzkLoeF4hJajV5D5nHhs3lJgD99yYkUewklEwz88CJkyBcgvsqtkwcbHzSstv5O/GrRObVJiJQHGr75T+zjRW4XqtYVxItH5moe2PjMEcco/RrW6AiazC5F10O2cFVReuZfG9imrfKyg5/E/eIxv36sctviZkEkPUgj+91DnnQD8Q2PeEaUM3GNvfyYEQBI3bjcRgDEYZCc9osJ9OUJKUq/t05KH1nZM2lBpBHrsMZ/QSrEmwNrasbTP2ssG0k1m5zlhr9GSawjs2OFQaPealStuVYWF1zXw+QCQFqu08bp9HB6sAMhorSj5BPBstwmV6L3tpiImgDJoGThe2H5Fv+zlnAzcznBnquy89oHa+ITp1GO1gO2xNEXCJ0RLRzUC+mZ0GY3w41gEO/Py8sZCtipZdMl2mtQB2SUiPbYbR70hb56svMVByN7PLRHvU2Pobi3mPEL17O5HLWYLmb6u8pW0TBubp5Keiv6FPROX5s8uOLHEKK/H11bFFPDMk1R9kXUSaMTcxCQya21lC1MbaCMYxUUGAtH9hi/CupKm6MdQFd1S6ef7U+bkffu9uWISKngAChODMUWwsw1f3M7GRrH46rBE7yiGDaDkcJ7npkLK1ITdBeOdZmz2w5Q8Vr/T7pUfP3whHow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IJLxv2ZvALv9BAvGV6j9SlZFaXMkhhD6D1IUW4DedfMzga4DEz6C3bTiKSIJ?=
 =?us-ascii?Q?lAsUVlQoJYkzC3Gz765cAjzJPqFSvz99yZUGknRu60Boh/n9uzR6iJB47Vmn?=
 =?us-ascii?Q?2DndWGHGWePYq48AeLAULRPgj0u5pgqZVlOlUKPtCqea+oxaezSNLOa3Q1hL?=
 =?us-ascii?Q?zu8Zudq8dt2hDB7DL5GUZs41T82ok0qy9Wk9ygCdcH1lX5PrI/0C7wkNAeOy?=
 =?us-ascii?Q?R6S1MtBhIX5LlX5wPOiJGHVMAsGEIncAUetgm84c2/9C+b6UMlzHLFsUVIIL?=
 =?us-ascii?Q?u0zjDH8VFueRTMabX9BC5q79QQ2VnIliZofHcBamEyZvoUyrw16MWxHbZYbW?=
 =?us-ascii?Q?5wOwHdED9jtJmgFU3a/Q0+qneaVws9xR0axBgvIkRUNp0eJlNuS6V2GUGT1t?=
 =?us-ascii?Q?ELxzQl3wHut0kDEUYIYlXnKSl6qUnJocis7lGcFpirbPo0tZby1qZ+ekZt63?=
 =?us-ascii?Q?0Gwt54kRllH827Y4LUx5yUAJYabwHbL0afIZ8i6COcmnOo05te7vDudQ9TPS?=
 =?us-ascii?Q?01OF4WoDdr2LfFgD11w5Jb3/h9rPlA5LOdzA5eohZ30wWfaMxWuazDy/68FL?=
 =?us-ascii?Q?W+2N+FfG0FSqvGemXWEkqx1Ga8Th8JCTultpob3SH8U/hUlDksUamGFSjZnF?=
 =?us-ascii?Q?geDLDTf4mKLdH2BZXwyv8yzZFYASiBFgV31eqTQXD1cMPiqNOrLZ5mwlUnlH?=
 =?us-ascii?Q?Il+Ej7ati0TNBwljXHC/HZ4Q8ghO/lLbbsf9EmKAu+GxuUvxhDHWwg32MPFI?=
 =?us-ascii?Q?WyOdIh5knniy1jd324E5rhn8C2+Mf9aTmMRWwoh0/rmd8viH/q0AMyrygOI+?=
 =?us-ascii?Q?JNbjLdoryiIfs3Kw+ltFb3y7LNQ7EavaNIh776omF6B03B37Q84XUplmOB2F?=
 =?us-ascii?Q?IsBZikhH4zW4SNCkkoF9lOBKE8jqRHmLIgqDL8i6u4w+ERTV4gT0xGilPO8x?=
 =?us-ascii?Q?BPtUST6LluQs8SSb1s79hVFdzXAtsVXhWxPNh+5xzxqfBj4lkd7g+euoDrQ4?=
 =?us-ascii?Q?ruUgJ+dTUGvFYezgbXe1N6pDc7NFZOEXZCwl2OFEaLlknicYYTF3mxO4a1Bu?=
 =?us-ascii?Q?SERAXaC34zEDnPofo3lzC/G25+mPoAOorpy/xHJndBvR77GcmOkcz0DDMv69?=
 =?us-ascii?Q?bIoLgYMFlQ+wfHbatT+p8wY6axOCRF1ShKTXO8N24+7b2GqvQjcZtdtV5TmC?=
 =?us-ascii?Q?g9ideI710Ju+CKRuVffCKPA8qC2rLqF5m+V2bXg6D+tMnnfKe69GO51c/NS2?=
 =?us-ascii?Q?Oxc09O9b0EjpeQ8x2yFe0n1tY0ZxelXvZ1pz479gZu3H3H99LKelf9PIl8tN?=
 =?us-ascii?Q?Us9+sMzdquHCTHLepjp+Czt2qYbCqL4eFnIgufq0q1qyXPrmENfqtD4HIIT9?=
 =?us-ascii?Q?cajZkkuJQVl4gdKTRsMtWtfVX/U8jBxWec0dHd7LBHEX96UH95MfWiqWML/B?=
 =?us-ascii?Q?bpJAlWXT3AIVp6rJBB/xAtfLXiVHYDcRtChWbKZC6SJEijPIofzr4820uhug?=
 =?us-ascii?Q?PDOklH67rjOmRp1mk2BGEGF9HUzQdWhBkWK6NZX1YjXoq19/MgrYY09EP2iV?=
 =?us-ascii?Q?jtlfzXoLY6Et/i08E8GUrxhRE6g/JIXizyWwWAON?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816076c3-6392-4176-1c39-08db71cab105
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:37.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIAeHMod2BRjH5zQYXthRSHR6ObCH/ZhwG/CdxokRLEyRS1cCWc1jTg1/OtRpjdbEpxG6JkZXBqOjHybAk2KZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series introduces support for the eDMA version 3 from
Freescale. The eDMA v3 brings alterations in the register layout,
particularly, the separation of channel control registers into
different channels. The Transfer Control Descriptor (TCD) layout,
however, remains identical with only the offset being changed.

The first 11 patches aim at tidying up the existing Freescale
eDMA code and laying the groundwork for the integration of eDMA v3
support.

Patch 1-11:
These patches primarily focus on cleaning up and refactoring the existing
fsl_edma driver code. This is to accommodate the upcoming changes and new
features introduced with the eDMA v3.

Patch 12:
This patch introduces support for eDMA v3. In addition, this patch has
been designed with an eye towards future upgradability, specifically for
transitioning to eDMA v5. The latter involves a significant upgrade
where the TCD address would need to support 64 bits.

Patch 13:
This patch focuses on the device tree bindings and their modifications
to properly handle and integrate the changes brought about by eDMA v3

Change from v8 to v9
- add dmaengine: fsl-edma: fix build error when arch is s390
  fix kernel test robot build issue

Change from v7 to v8
-dt-bind: add missed part

clock-names:
> items:
>   - const: dma
> 
> clocks:
>   maxItems: 1

Change from v6 to v7
-dt-bind: remove "else" branch. 

Change from v5 to v6
- dt-bind: rework it by fixed top level constraint.

Change from v4 to v5
- dt-bind, add example for imx93 to trigger make dt_binding_check to
generate the yaml error. fixed dt_binding_check error. 
  keep compatible string ordered alphabetically.

Change from v3 to v4.
- use dma-channel-mask instead of fsl,channel-mask
- don't use dmamux after v3. only use flags to distinguish the IP
difference
- fixed 8qm and imx93 have not CH_MUX register. Previous can work
because dmamux is 0.

Change from v2 to v3
- dt-binding: add interrupt-names
- dt-binding: add minItems
- dt-binding: add missed property: fsl,channel-mask
- rework patch 4, removed edma_version to avoid confuse with hardware
IP version.

Change from v1 to v2
- fixed issue found by make DT_CHECKER_FLAGS=-m dt_binding_check
- fixed warning found by kernel test robot


Frank Li (13):
1   dmaengine: fsl-edma: fix build error when arch is s390
2   dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
3   dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
4   dmaengine: fsl-edma: transition from bool fields to bitmask flags in
    drvdata
5   dmaengine: fsl-edma: Remove enum edma_version
6   dmaengine: fsl-edma: move common IRQ handler to common.c
7   dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
8   dmaengine: fsl-edma: refactor using devm_clk_get_enabled
9   dmaengine: fsl-edma: move clearing of register interrupt into
    setup_irq function
10  dmaengine: fsl-edma: refactor chan_name setup and safety
11  dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
12  dmaengine: fsl-edma: integrate v3 support
13  dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string

 .../devicetree/bindings/dma/fsl,edma.yaml     | 106 +++++-
 drivers/dma/Kconfig                           |   2 +-
 drivers/dma/Makefile                          |   6 +-
 drivers/dma/fsl-edma-common.c                 | 308 +++++++++++------
 drivers/dma/fsl-edma-common.h                 | 127 +++++--
 drivers/dma/{fsl-edma.c => fsl-edma-main.c}   | 320 ++++++++++++++----
 drivers/dma/{mcf-edma.c => mcf-edma-main.c}   |  36 +-
 7 files changed, 677 insertions(+), 228 deletions(-)
 rename drivers/dma/{fsl-edma.c => fsl-edma-main.c} (62%)
 rename drivers/dma/{mcf-edma.c => mcf-edma-main.c} (90%)

-- 
2.34.1

