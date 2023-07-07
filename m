Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E9074B6B0
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGGTAx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGTAw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:00:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E0910C;
        Fri,  7 Jul 2023 12:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f00AdKYkNPd3u+pR2I8TGlqU/1jgickKVun1qK5Kl6gkRSNqvJlezqqBb9QduU5WWG4FKQICM9q+xn9aeZjZlBmMPZtYtfTSso84TS9P5KG0aj/ZRrp/jQTgCWVFXbsUzS+ogJQIItyhyfl2ge+qUsZpM72w0PMrV7XY2KC98nDM5xUoIfBZj1sLg2U3MTWbkQW9UnM1a/CFh24u5MTQuti8pwzKzZK7I1n5s9rZMo+KIYbdOHzbxXqJCDAZhSgosSTfO/qCsPqmIoAPc2hu/1rFJuva5Xbr0jKmalGqKJdNil9YLXlJoJ7R8LzhZpRcILARxv+/GW8t4uQvv8df0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVRNGmrAXGcMzi+seC5Rxb/ECE4blFW3LEnc7n1wTHM=;
 b=Ou67ZlG+tQyT4sscDyUTaZcTZI6wDr3KXIgcjKV+pIxhWtiiwPrg45ChWQ7UGzocxHmxeJ2qJHXkM/xCW8ec5JRPrdg2gH25n66ig4mNbFquHttWdN6ykOiaOBIvqsvdpdj2vBk9mqYQCnXhJTb42h+YDW7hEobuKEMSA0abAauF9pe0YdiSxh8QW3ckWfjgz+B8F7WL8ixRyh8mhbV0Zzd6Q570eeore0Z3Xh3GzSc9DpjgOMVPKJ5XY6lXi9XfPabn55Hc0n2OnuzdS1GXGh3A44bke+0uVhf+NjIHjx9RY9AejqBUdluaIXHa64r9ja7THVetosZ8oWAP+rsSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVRNGmrAXGcMzi+seC5Rxb/ECE4blFW3LEnc7n1wTHM=;
 b=Wg+NJLTZVQj5FZN5UATRMXdX9GaVmguGvXpe2Ecey+77TgWCdkRFbaV3F8f5eQR1lDnyN4qit45IlZKbcueqabsLqE0u47O84Sqq+f+WBEqjCBxTMcIJlsow3AvytBMm39ITCrNXhTbp4DBWzjue/9sg+6AfodymxVx03kWyuyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:00:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:00:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Fri,  7 Jul 2023 15:00:17 -0400
Message-Id: <20230707190029.476005-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: c0008cca-a2d3-4194-80bc-08db7f1c796d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPc2UW6wtAfs88++zg1Hca8d4GepF14DmOs7xNJpme5y0oepNhtnZoNVvlcWAI8VWmUsGbUSyrZrEBedcMVWthtsLlDa/62wAOzwpr6A+HnKGByi3wijfJE/Z4lWztY7f8gzPkSOuUXB6nNCPjnTpUQ/vUoqX2PhL2fQ7hg2A71fqbi1Wd0VeoXthTja4kwoDWPX0UOUugJjIurWoEZQTbCXEruiDGAgqnBp5pPy/vIMpVidyV1CxfXN2Jz+qPMHtPV35Gq5QeF0DWkgWuEF76DZ0X6FA0om1nAZ/R3t8GmcW89IN2dYrbOBh5Dv68hEvLJwXNwFEKFkhtzSDPNyeu9/uqr+UWAlwD8cUA5f/4J0yUvU8uvlbVhMyXLgmDZ1U1H4r8P7YojksYAXpMnD8iqnpe5Alb9fSqpZAEhZJewNvmbX7CqFywQln8TTcl4FKTYTfqEvIWaE2U7QlwQNh2lGGrMXniBGUyxfzPGs2QHEbs0xBx5GkCkHdt+d9Dokp/MVSavD5APBr7Fkl/t/BJ0lliLYSrVHdp1udBUMq5N92yMdJBapP7xb9c3FotvTOAQoWOpczOTpj/p6xQN14Kpcf4/MXDPTze6eV0bKdeT/QfZfMubzXkHYbHrap3kA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(6506007)(1076003)(26005)(6512007)(2906002)(186003)(41300700001)(316002)(4326008)(66946007)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(66556008)(66476007)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5G4OmIOipluvrcztMnmkSveStlcqIiHb7ItXmoBYIsF+8WS3h3skhBbYOEgS?=
 =?us-ascii?Q?l/WigYWkyVgXKvZxuzWv7pDWXX5SiAfYoTBv8hKDujmmA+xTm4bvJmFMRTUT?=
 =?us-ascii?Q?GSvOty5woPEURaX58sTz8kGw33Z+zaUS/EgjCWnMVSL4XGnBatyvtihUrk4M?=
 =?us-ascii?Q?qE6+p6pBFMjJzN8PPtCoqzo+098X7UKOQ2kZSbWAesjlRvLuUTdLmtjQb4az?=
 =?us-ascii?Q?81SiiNMuPBMvPvnDHbLawOF9OMY8rgaJ5lBwhFgS5CGkM1Aer6F72KLkkYUA?=
 =?us-ascii?Q?gpmUlmokoGof8mUnhU3aX4zRUjoATGsk0Irqe5+fn1/AcZjfkdGpAHpou4zX?=
 =?us-ascii?Q?xA67y3RNfBSQL2zJ0Un4yZEvPE0/yotutN78GBIbw2GXR7KoXcbMy7SDPyHM?=
 =?us-ascii?Q?c1+bIybPs0VZttzjcTPrygTN4uBHrRZpkxntjhR1HV77xtfj4aDbJpo5dfPB?=
 =?us-ascii?Q?Zi3RaQ369PvgTJfDUZFd4447tnW+gPZxMxYbKh2ryHku8ezyEdsIGQex3VbH?=
 =?us-ascii?Q?TqxqmGwYjYgl6FNXnwV/kS4Ta2dYlxuI/VUIRWgYBeBknHd78e6zpRVUAx3P?=
 =?us-ascii?Q?hgzfjFEJ9/+CRyegWALCybfPnOWmKlZc1SCPSaMDs3quVgU9Ta3XrKZwL9vJ?=
 =?us-ascii?Q?0KvozXSl8vB3zeErPyJi7/1WJhwW9qru62z8QYm0TIjEEx5g4rUa7tG7s3N6?=
 =?us-ascii?Q?WiEI3yZ9UL30AMkmahpp53VL2xOywMB8ln/ZgLNFssvh73+HNfqhBDEYttp0?=
 =?us-ascii?Q?OFEJTpWLENnE+I8HJgj8NSfs84MP8VVomIchxT8h0qg+GlPepNMxZkGtbD8f?=
 =?us-ascii?Q?tl84ZgDiDB6bwlVxdueVL52CsINMz2F6EZisIEH7R6BBLkWJJQr8H9z4Flb0?=
 =?us-ascii?Q?cuVHMRrnZZqvwh2OhW5BCGPKnqlKZHMky2wngrIguPtsjaGkOZh+qpy1Waue?=
 =?us-ascii?Q?r34Qev9ciBke4Kf7yrTDXMg0Wj3OSlLSTIVRm4mawVHYXV+42rUUsp1BhWLk?=
 =?us-ascii?Q?3RUCU51LKvdbiqoE1ZCtO7+MUXBinw+0PaE2W6qX21Vk/fpmSSuNcKunyw3x?=
 =?us-ascii?Q?mAGWRvWoGBe5NoEWP/f+EaDhFNq9vnQeZLTfcHryLy1HSBN+ZWaG8sqZpgs9?=
 =?us-ascii?Q?b57/cKfJB9k1+tBixVzKBA/ZXV1A4PtO8+kFEtc2QX0mtpgZ51TXvhY1c6rX?=
 =?us-ascii?Q?HJekI1yVicwSz6pp3/15l24t9IswCC04qcXMECxDTYO/YXU2dzry4wlqL9/A?=
 =?us-ascii?Q?S31dz4Yf6wmj/FP2rAE0gAoXEnrGnias0Lr43BE4VY06+XvLxbQ6HcMbuLio?=
 =?us-ascii?Q?R6lMGCvxcy2GmPaUwt2vVF9EREnKhoXfNSkeRm1DFMcSh153yFxUQSYDkRKd?=
 =?us-ascii?Q?7WisSx2luFGCX5h6yzIBBJsZKHZ+nU7+eWtFlcsQtjZ4JdsmRoXWvXxJ8QYX?=
 =?us-ascii?Q?eKFE8y3RISFLuG8rRv7YCBcaWG2ynTDk2ejFMB6h4/XbjL7VUd169bKtVROf?=
 =?us-ascii?Q?ukwf2UkxMHRGmr8o3fPBs4Q5jR5nNIWBK0/erNfBWwEKen3Ohf3N5RN2CAVH?=
 =?us-ascii?Q?VwggAhIYWdUb9G9VmLU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0008cca-a2d3-4194-80bc-08db7f1c796d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:00:47.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9pY16B3K+mweLRBw/f6w8y+uJHvPEM04287BpVvOURNZxw2qhhXLPm8y7S5L233wpL5ngREuw2QqrPBRcl6OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103
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

Change from v9 to v10
- use HAS_IOMEM
- move dt-bind before enable v3
- remove a unused code
- drop patch3 clean up fsl_edma_irq_exit()

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
3[dropped]   dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
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
12  dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
13  dmaengine: fsl-edma: integrate v3 support

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

