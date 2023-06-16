Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB57334DD
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFPPfB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjFPPfA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:35:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23082944;
        Fri, 16 Jun 2023 08:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFFt+F1RMP0hXW/OMSYny4wPH32c+KbU+9mCvdDp7oc4fy8dw8MTbYM7ogCxZwBNtVCI6xiMWF7o8dV4Bp9awocMXkHZBKGgJ5LgGq2SlmosPTZGrjyohZOx9EQfw2x3Kl84Luisr+L+7TiT7GgWdAAei4t+67rWuenjg1KwMpt4LN696YxlsovFawNgyBXtUoRyQk4bdvg5Dno1DhvCTW/OWS93paVHl6ufVTk1UlsdpjyahTNRsRtQaMmMdj5dc2i5NLNjkUDhH5+Y5njJK7pd2AGTLRoSHvUkiOQvW/4kRMNLbXSxETeocXyjADLINEfGVDmsU8VS27ZJfDKtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94pbg/1MXXWOc+G5pabJcH9+SncYvQoHyjacj+hbMys=;
 b=ZxQgYKjaZpq3vfwqBzYFkIwcX+Dc2gWXwc9gYfAH+ysdbsV/XbMcUIlQRWqmkMXdYkLvzpwh8YWQngIzXiGa7V9U6jduP2l39Gp73+SWP0nh/GZhhOGbNSTNBrgTE0VERa5ISfaQgOG5Kvhox+xv38NSgx698/bR9fZ3ar8a7xEHUuXLthX0qxJrGDsekjyIsMIQbxlOeJNUQTlafrtqycFcoY5fErQxR4yTBwtmxgcqt2dOQXD28ygKnkqlkaKVUFrYmnvn8jsrDXkBacDsHY12fF+1xVqWZlag99AzX4pOdkwWmv1Ei7dfTS4Q3ptVH7vhNj+QUf8tC65N6ekRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94pbg/1MXXWOc+G5pabJcH9+SncYvQoHyjacj+hbMys=;
 b=ctft+F0nP3xFWN0+ZbNkEOBK4McBRR6CU7nef+GkwtMTPzTc2Yf9/CoIClS1mUcOoPfYem83pK7Js9zwVQhF3qRlnjCM/5iE5dlgX1u97zLQ4m/mbKW3pGlH7niqJFwQae1L+1lZg9cQIaeLUDQk8YatFJHqeGN2bduWbCjmYCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:34:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:34:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Fri, 16 Jun 2023 11:34:26 -0400
Message-Id: <20230616153438.2299922-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: c21c8d68-c0a0-4d94-1839-08db6e7f3c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7DR8OLjdKwo0kBlGepdWldbyO1Z1aPpuq40iH80z/Yp0kGW1LKSGmtk4E+jLJZFy4ihsBGLoGAJIB1RKLvlpm0rOrgq405on90PtiNgFZNPTdlD4uKCrNdqarqK10mlLp4nK1clB2pShsAcCsd1mZoYbmRDMGvlcGCsNl1MHbf12m6fk+1vhOwgtCOyHhiWRu6+sDVWll7rWyYRgF8TpjtOFO1wicv3NI0YTNEX1rCVt2GlnRifM8tbUyQ2rJtxW988aYn/s4f3v/c7XfhKRv5OGnKS/HoMbwHxLUL8VmZdItiuBonkvDH6BxN2k6vkbHemtLxnMN4JzKCizd+tYcOyBi6K7+vlP4FsuK/ncXQ//vEhqdZPimtgL02t5EBFaNhZP8/gLuMI44W7izSCSj1PlUtUFgH7p4hJ/iL0HpokGwSyHbw1WsRXPc3Iw9IJE/OlNdjTnnxl5EeKL1T3pnTs2RJiFqWPouJXaVHPMXqI0OnbI5DOPgUl2vKHj32ACtr3H489nH1xFRrQgH8FGUVvCz6iVY1sQa1O76UMA6TNvzNg7XA7P0b5BBXccOvcPIB79Nm48uB0EUBWICHVa0373CksaqGYYZgsrm+zJPWPhPY1nd81lgB79mwGIdQUDaph0QpETV7oncDd35JPMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(186003)(38350700002)(2906002)(38100700002)(86362001)(6512007)(1076003)(26005)(83380400001)(2616005)(6506007)(921005)(36756003)(316002)(6486002)(66476007)(66556008)(6666004)(66946007)(478600001)(52116002)(41300700001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xG2fjxyIYgoszZEWpjaCWpcJkISeoXH3YizwGC+igjeqwqTk0jMLJcJ208/Y?=
 =?us-ascii?Q?YrChjPhkCcPhLoWWMtYoqBsHoTKO2/sdbwYVMQ0DR9WMwdb1kzA5GLkZWdvk?=
 =?us-ascii?Q?9RpxEgQmOPOn1QCdIVOx59SW2G6nWa8BzjuCXSQFHwu6zZnySbOOaQWXyr3r?=
 =?us-ascii?Q?wi+oqVORxBOQeXyCmy3Fh+IFDNCfkchcmJrSLjLhrC8yUGpcGT5zT8dv0L0G?=
 =?us-ascii?Q?aV/URxflXyeNWkLnN7Ade4lgeTSb8d4BQwriDk8ePRhHll7riFnQ5lyrftPT?=
 =?us-ascii?Q?AxREFl9stBWaSM296StBnQGlNSq+sDxXOiAFxf+ky/8qaHXxTuxA/ZNETYCl?=
 =?us-ascii?Q?u4wy0hcihNkuSnhQAIBzIUC6R5aKF65kVmNkOqtBEXCa6l0Kczaxkem/enPK?=
 =?us-ascii?Q?rM7S7XAJ2GDK+SreotRDX3v9gLAKqF0hMVGjB1kSsD43u+j/HYvdCPxRJ4HT?=
 =?us-ascii?Q?KoMSjtJLPr/QjMNXd8+rFAzqRId6seqnR+44cKY/fsJ7U3Ma599xQZdQqtAV?=
 =?us-ascii?Q?x0ZT5H9zHOe4SvZOxzcVPw+covxrf1Eio4bs7KXR915bRrtlJRgx3+zzcyJk?=
 =?us-ascii?Q?hy1sv4k/4BcDsHn6u7Rdn1mJrog8foNgogMqOTxTAFgDwjPNIFkRQ6+iRTxb?=
 =?us-ascii?Q?o7Q3YCvrwc/DXhwqiMkMs2B8CYZ027sqivjfDtq45bc9ahVbiQl7/rHW1vCs?=
 =?us-ascii?Q?EGLcrG7W7sd9Wt6sxyrxHHLeq846G1lSPa86pRtNjBrIf82LjVX91hyBWvKR?=
 =?us-ascii?Q?TlfRsQ4VdQFpIODl8IjdWxxAjmP8o//aQPpzCE8iLLJqXe80dnis5g5rPyq2?=
 =?us-ascii?Q?fh5tgosLAm4mfL+KkjA0MLwjJebLZoNuO4QN/WjLChJlpcNC4lfwFbMbv/y2?=
 =?us-ascii?Q?bpuLxLh6hkzDPdM4AmSZYuRhXTswNZkGHmQRhOx8Cqoz0BD+v15wAQncY6Jc?=
 =?us-ascii?Q?83T7YkrRmEp4SQ3/OkoPRObX0sJ1Y5i9NFSCTUp8WNmSuSfC60dezul9jp+4?=
 =?us-ascii?Q?iUVMj+GAPQCYg0bCAuDCv9snRCyCP9dFEeDp8Fmngij2fKjonm1TJ7kT2eSj?=
 =?us-ascii?Q?pCylSSmAm3E8pkCP1IyEeqJQvqFjZz2PVnXG+Si+h5JWHEFNXnPKd2TM/kYU?=
 =?us-ascii?Q?J7YjT3Ic5HM0KiUKMDcRlJl97oZD0CMSDrBVtuvt4nGiUax2lHEJFZ2tMdD2?=
 =?us-ascii?Q?FHTUsXBRSw/5HvePxOsh6H/88IMbpBuKumB8M12F4GKdlGCygJStEDOaawkz?=
 =?us-ascii?Q?dlGDnZ360y3T+we+KnxbxFkgW5Y1UmEHE8DyEHPdVF/9dWKwZIFUDocOpviN?=
 =?us-ascii?Q?4QBvhhFdh6T2ztsoXeXgI0ULOlpuY8d5tYjCXz/EPrOPRacWKLL4U/cErumG?=
 =?us-ascii?Q?C1Oye98r3zhOG1stCR4GTpIy+ejkvP7Ip2tgJm4LDzlTpL7Ov2yAPNahJ8Jz?=
 =?us-ascii?Q?MLt3q2g6HhGqSE+PXV2yZKxlnOC7dGwWFDXXpXaFywic3InTBALbIbvpttJy?=
 =?us-ascii?Q?suL8dKeheZM9Xux9vnGOzkUR4nLX1c9ixGp21FKUGNXBTt1tiKsmaRK1+Fsl?=
 =?us-ascii?Q?gkQ3u5I/LF0j3z9NjAA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21c8d68-c0a0-4d94-1839-08db6e7f3c70
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:34:55.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMcLxmpBUxNan/dAoZz/Jop9kHF6GuAC5NT1t5XIsSo9qFrqKFMB+uoJsnSpmDTIimFXo4J/6Pi1LI6zpWFbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

The first ten patches aim at tidying up the existing Freescale
eDMA code and laying the groundwork for the integration of eDMA v3
support.

Patch 1-10:
These patches primarily focus on cleaning up and refactoring the existing
fsl_edma driver code. This is to accommodate the upcoming changes and new
features introduced with the eDMA v3.

Patch 11:
This patch introduces support for eDMA v3. In addition, this patch has
been designed with an eye towards future upgradability, specifically for
transitioning to eDMA v5. The latter involves a significant upgrade
where the TCD address would need to support 64 bits.

Patch 12:
This patch focuses on the device tree bindings and their modifications
to properly handle and integrate the changes brought about by eDMA v3

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

Frank Li (12):
1   dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
2   dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
3   dmaengine: fsl-edma: transition from bool fields to bitmask flags in
     drvdata
4   dmaengine: fsl-edma: remove v3 from enum edma_version
5   dmaengine: fsl-edma: move common IRQ handler to common.c
6   dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
7   dmaengine: fsl-edma: refactor using devm_clk_get_enabled
8   dmaengine: fsl-edma: move clearing of register interrupt into
     setup_irq function
9   dmaengine: fsl-edma: refactor chan_name setup and safety
10  dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
11  dmaengine: fsl-edma: integrate v3 support
12  dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string

 .../devicetree/bindings/dma/fsl,edma.yaml     |  19 ++
 drivers/dma/Makefile                          |   6 +-
 drivers/dma/fsl-edma-common.c                 | 267 +++++++++++----
 drivers/dma/fsl-edma-common.h                 | 119 ++++++-
 drivers/dma/{fsl-edma.c => fsl-edma-main.c}   | 323 ++++++++++++++----
 drivers/dma/{mcf-edma.c => mcf-edma-main.c}   |  34 +-
 6 files changed, 578 insertions(+), 190 deletions(-)
 rename drivers/dma/{fsl-edma.c => fsl-edma-main.c} (62%)
 rename drivers/dma/{mcf-edma.c => mcf-edma-main.c} (91%)

-- 
2.34.1

