Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00637128C7
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjEZOn6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbjEZOnz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:43:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E01B3;
        Fri, 26 May 2023 07:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKg1cUY1VWKhJRuqWbI6y8NgLBenYT+++cS5PC0f0KdHhKOnvverjWu4hohL32+GW9hF0Nf1qDldu0f3nP43YcEalgYpKY90Pa6TmTDJgaS+PBSsu2pTti49s9nGi5v5pwtAIENskecAS/UUBiEWryl0kCpTqOD2yNocFrLeT7Pfsz6vCoHOLA3ki8Y9/dsDMJj1lEJsDcuILjHOBUvJ9QsFbxPYDh/jILPUs9wGJvQ+1ifaYCupyAqJafa70V95LSvVEXtTX/eYMIj38JAiygV735o3k7lq+eM7tbvWW4uK5Ur9BXbSAbCNoExKItF1xBcrxt8UmHmI1Fwx72sHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXsD7+YcTEcrKaPXoM3x/n/eoHigU3a4iHHI87Z0FkI=;
 b=nAqy1MTS3Z2u8rJ6Sm2BMnQi0SfreiRl9IbfhQ78IlIrz//r4wgNEd3WkA1merDKTdd7Nj5jZwxZREAuYkXy8qjOF3s2sCOkUul7J9oXhdlUjppfdrlqjhNi+N0PBYd+VycA2sy9GJE3wUasaSolPyMqzloSWe6Yn9nIlGVZF7oHrxZwBzKkSRJHvcDHg3OJJBSzeudzdynPiqeqRLJ8CVK70LW0DQO9Oh0FQqRCzxpRuYC+/qsnU1gt10a9c5gzY1VFhwFqDThUt7fYOB3jXVU10o0aonTRpRMhdYB8xuibvKKpCHl6v/wb74RYRgD8ONdAx1Wg06+nRfBoPtvXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXsD7+YcTEcrKaPXoM3x/n/eoHigU3a4iHHI87Z0FkI=;
 b=cWQV0QbEgiYWG5jzBwIEGQvt7eZfs+P1TrcZ51OnTviueXWlTEbuMCud5tsP9/3n0BxgtimussusvB4VhXakQefkVNQ/Vzy5+3YnCWJsOMLLJSipymItqfmH88SqiuFahKY0l1NvB0HfTR7tb9IclIF6wHy6WN7XEHfTxnY61Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:36:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:36:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Fri, 26 May 2023 10:36:27 -0400
Message-Id: <20230526143639.1037099-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: f97261d6-3071-4a66-cc21-08db5df6a849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5g2xaIKw+bKgZvXH4k8LJ7rAMxIFqQ8W4MIaafm4eZ2t9sSs4159hWq2StbxF+AM8gtc8T+8l7GNsultIwC5KY4US8QGBABfxfjWJp8BCYl2UTWrXaL0ljQ+Ozhfi+kcXf49Aq2tNGVH/awxGX9S/WxLeQPKrhnK+9PIT3bnjqNC954hISQPXmNzr6DYKZcd2ubwVH7olTL2bRQ+s6BLGjAeGXyOaO9rOdmP36V02TJ6E0HKkuNbA68ZIjncFOq+HYVSCh1nePU1h8kHACaOyqD14M67G72PvSWyzrVluivpyPkSB9qHv+1XxaPNqQVkm/RDtAXvHk15RFamFIxDWJ8MVgPB9Hfd058LpgxJnD8wPM6JD/p60G7znrQnuGdRnTra4KiZVLI2Nqq6f8M5bRkb0IL31dw7dGhMTanxCGR/+J+8k6BDb9KFirZI3D+dXVCWxhfulyjjaBYocP2FZBy7ZrTm+KrOy4DiPHzKoSBTvT6LHyJKJdFYhBrlN2SZ3dCg7IK+uBF4J/aJk3ZulSe39fj41KvbTY/X0Hgs9/8eFcWnDSK45sNNspO+CrL6zt+qYafmeB/jwtpokuhZNY8m9S9aUmC1GrRFtFmvhxEkXtJgsli0+A8z+fA8UDv7JroNrS5YggfknHwYOR3cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5odoGTeuYkCHGV4WcNbhDsCTG62OQ20TW250wJDqanhfZ2z/Dib3coCXrgXb?=
 =?us-ascii?Q?JmUaeb3hF5RNp1Jeanm5Jw4nzS083/A9fYDCpdf6mVhE/iOihxU724lXMC4A?=
 =?us-ascii?Q?zRAuQM/vizLgxHSz+XUtR55S9zy04K4LKkCtwL8YF7kXyoVrbkqy1SxP4rVL?=
 =?us-ascii?Q?pZ3E5KaIPBDY287aMGQPsCEXc/O2uX0h+p5KIFgvc3aTqLzqq84njssYEJo6?=
 =?us-ascii?Q?V8z/Zxx7B+uschf5mY20JG9iygTzQ9Kl4ipXyl6WkiiUKci/t3qFxGzciAZH?=
 =?us-ascii?Q?unSNh/6Nnp9P4d4zMlWpV71C8QWofNsQY2tIz22WfctdCaLqTWYWsFKuYtwD?=
 =?us-ascii?Q?RiE2REtsqq6l3lLZXuJdAtDTW1wtQyCF4IDBRr3qqojF+7L6uZ30GbwRhl2V?=
 =?us-ascii?Q?juyUaxoXXQdFHWTqKbMUQGhk5W32QVeUdshekjBn9soj1/TtdFaQ+svHd1os?=
 =?us-ascii?Q?uMs+RAK7GW0lwx+mTMepwT3BuJ6eMFFSq09w7j3o3yBk2SCkARcew+MpZTcv?=
 =?us-ascii?Q?aGNFCgWkYaE+Ae2w5fh6vJviibG6/RyFOnAEThhPonjftyT1zP5zs1otsY0o?=
 =?us-ascii?Q?mTJGQmMezL6/QE2DkdB4v80t4YQWR7kqxmmWfI+Xy3pRwu4jaeF7jfNtnDzm?=
 =?us-ascii?Q?euuSdRArI5vUVP6OVBGrlMUkaIYveTxPCm123ZJA81Ok19/Zb7TYq6yXCGoL?=
 =?us-ascii?Q?BE1KMxB0CP52A6lAyzKhRnVNypKq4kcJXkcx+69YhfPQJxm+2Uid1DTlNJm4?=
 =?us-ascii?Q?OBWDYQG4nz6Ayk3PfFytiwK0CxVFQc2dx9ynDWvThX2bXoZI2TkvNQjaoAOq?=
 =?us-ascii?Q?dWH2G8kUGSK4gEV3PBGujV/rYcdVpY8MDlgYU7fFDzI4op9ig1dwVL61MPlQ?=
 =?us-ascii?Q?+i7DDPN5oZyQb20IZzFANEd4zxnzcmDB5fct2WK5oG0XnClw/12jdCPeLYFX?=
 =?us-ascii?Q?ZUZlyEiAUwMzmQTsDZCvbWB4V6eYj0umYMoFdzkoDunQfKMnhADiAIaBmT4E?=
 =?us-ascii?Q?OXnVNbgSXX3wvcJGdvmO1e948r2wBTeChQvqEvL01EGpsU1135a9tvofnjG/?=
 =?us-ascii?Q?FojU9FMh0bLRFRSeiLn4HK4VifwVnhj1W7b89kEG7sCDmgvLLy3er/7+3R2a?=
 =?us-ascii?Q?lsvv2hET9owgD5sIs76UjOrGABLf75Q0Z88EYDhrRYo+pLHld0N6QBBaMBnF?=
 =?us-ascii?Q?teTkV4yrNu3emd5dwTN5sIS3/1gcnTMSwyZFvZyOYuF+sv1Qx4T5s2zgB7Ik?=
 =?us-ascii?Q?1cvtB2PI680BGZRFlwI68hTSAZYyp4fztc8pMArkjYWBIi+Piw3wjnl52eKV?=
 =?us-ascii?Q?llQbfI3bkLvnMCWimzOd2yetSA+fB5kAiJ0Ka4psxax3fF9GbdVU/VQxa9SO?=
 =?us-ascii?Q?Az23zm6uFfw+XeZQJaku5o/Zaf+7BO/rPceWFOGSZ+zd6WTlBLmqRxbmj/zO?=
 =?us-ascii?Q?oEYiJfgSfOZkxLD7+HmX7kKfpC5v7ChayhQ0Y7AHrL3kKovjM34sVPVYZPrk?=
 =?us-ascii?Q?b/URWWvD+XVNz6gt+qwnIdObrvd3K4R4XiCvImzdCtQlJd+ktkmFgzbMPD/c?=
 =?us-ascii?Q?smRTjFNnoV0xxSBDXhcxrXd2sVRpEIm0ZwUJVGAU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97261d6-3071-4a66-cc21-08db5df6a849
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:36:57.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wG9R6WEQT1VLtT4G8qQAWnuN8A+cpGVxHBHhNFR/u5+7NqRNzou9DXqxD6Ky9ukz86bPohfohcGiH3hvsvNBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

