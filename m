Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC853782E0E
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjHUQQl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjHUQQk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:16:40 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BFEDB;
        Mon, 21 Aug 2023 09:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+g+YLCpjVd3C2XCEkfzo8HRZbLx8EiolOMtBsPscimygijL6D6yO+Y34up7j00wS5oL0eBg3App3cM2LaRUhH/8K4WhheJhEIAh+D6VyqKIUMehAjAYGmbVrtfg0uYTlaYjSx/xmGfGbHXXUMA7ngD7G16TUx1bgG5S58lRZQYCyTGABy0yxEtXVICWON1XqTyqKaQh+GGU5eSDa8ynWo26RDvGHQrtyT54r2I3UBYMET0bQ6dkwgtAf7COC/lUsvMzPImlr6y0Cd1BSs0M11qqlul0aYU8Xfc7CpmgwR8G1G5vUl06TuqE3ITGQPcG03se1x30oAOjDwglwOXhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYpai8k9wksvkSPCkBhGaaPPsM7bHfFSzkZ37c9QiGg=;
 b=a2PojJUt6Gcif1+svzRaXplW4dS8iMr2Ma2l2uZWLgu+UzyuGriKx6j9Xk2wMvxLjJ5rzIo2BcAxCZfTEKyO1jiM6n80gubZvMTgfLAMylnsrU9EIbTA5UOx3IqHUJApkGc4Vj04PG8U7x1TWbhTo2jnBaenQ4QtbwI0Kd1dXEwMdw6fVi0BDEsahc3m71yfJlffQu8mOdyEpCJLEorzy6K4X3USsJtDu6UjlVPdHSqB8/UhjPu3zo1g3ELu5ZX3mMWyc8GaJHINBYTcavufsmqz/fvyJhxsPW/lSi86hBVWa7f6xZsOvn0At7RFu2IIdU58nfeJ/tY59k7yO7VlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYpai8k9wksvkSPCkBhGaaPPsM7bHfFSzkZ37c9QiGg=;
 b=Udbruv50q9MF79sWZWZsOf8nQlBX2PpGAl1z8kSVXD+g/pvUOSKxKmG9AezMfHiuAM+LcNBW7jDLqDZhvBsPatO2lNA2xZMhD2EA1nf+xuj+YobjNiiH5y32to8Kwd3K2ReJ130wy/VAz+p5KOHpub/cCyjFYfJeLxE1VBT/pJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8464.eurprd04.prod.outlook.com (2603:10a6:10:2c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Mon, 21 Aug 2023 12:16:05 -0400
Message-Id: <20230821161617.2142561-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6a217f-e9d0-4aaa-5eec-08dba261fdf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TT8K5p6fRizMXLVXBtj6By2vsz4xt7Cf65NjqU5QOOq+Lt3wrrmHDN89zSkOZViAiYo2103tn6YuvcYWMT9k9lEc3PWL31BK4KyF4nFf+fXdXr5WcRKRTNUDpHm6FuqOFitGSDoEUSB9SOFROEA9L8eKZNuZ7otRLkMtA1nq2Ktf+QMKXG+UT9PNePY6HVh8tJOUP9i232wf0LklWsfP6qP4J4C4i/lJCVzIHrHH/lIsTUZOtS4pAYaSkxDvpRu75UGl9t+Nbd+ovb/RTomi2IFsyhlsYKDgl/atGDB3eA59pc7Vw8uTZx9Uo0aPecBYrLoFoVOQ7Ko6jc6jRT62UO/XvFuSuFNA/+1+urUilNnPQ72OYc3n6k5m8QW5rgSxqIZ257EheYE0ycrvVVp18h8e/DhYjiXQfaO7CC4mOpOYYZGng2bzLmOKnD+GdQkGrtO+goImEm8YO/vkEFMDQYwdxo5PyqphTuCt3TadY7+hknHulwhB6dcAB7K9Wc5qmIuaU6d9mnukr3xkNzkd1KGzBPh79K9/0IcfJpwb32JerYmbZmkW3Jo7wxmhGi5yhT7dc1Uw3hYlpehKn2uubZXu2d4NjBUe655R/+zLDH+DcwsQJ83BSUIJ+rcwvxe9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIShwcOVLTip22AyPwUUDQpfwsZZSAqgftIyWLFQ+/iKyMGv72dBTL0xx+BI?=
 =?us-ascii?Q?wUVywNPUQVWdLgPCT6zv8wBeUMTLkM3KwoueE1II7FTikBRbi4pmAx+SiVrs?=
 =?us-ascii?Q?jefk0ZWsPwdDma3BeroijrwUq6UtmOH27zHXHHDxD42OHXkjuu1LnPXM9IXB?=
 =?us-ascii?Q?ZJk/wEGqli0sTrjEMbSzpEZVqeXRD7lpTU+8jIWwPHv8ElS4VKrZ0XrX7HYB?=
 =?us-ascii?Q?dmWvIM2o+6DNwPvOCxnZ6+DXEtX5HrvUxLqrjz/kS6lJa1UT36wA6zmxM92j?=
 =?us-ascii?Q?ViXF/5akWAbqUXHCms352yAQxGU7kJ1oe5AmAEnAvDtIS27nwu9Lz6aisI1o?=
 =?us-ascii?Q?a0+0u19y7iwEwmW3JYa0tLcPOk3z+b6z1Z6kykCwuibH6c83afRQYqVuSVJr?=
 =?us-ascii?Q?0cCsuzgl4Cr8jttcW6+v79/r4WWxW150/O2kmJz2j1C5lv6xITqsxlla/JsW?=
 =?us-ascii?Q?M8OOavMzKChm0usedRWZQ6owURAvthxfJ1Va5DoL5iF9RrM7s6ZiFx1Hc2jY?=
 =?us-ascii?Q?gX8zLM5jsw8RgrlEpcuSsjyTcGFg4gB5VoblIyWQJf2EQKx9ngF8EgdmHbTB?=
 =?us-ascii?Q?dZ+oLqVupz786vjQhOnuAzQ1xPwUn7D/T+yAtYzIq6GqK1JR/pQBIvOmVg6n?=
 =?us-ascii?Q?FW/htoi/e5tHo/2WqzbVnSujpmaTPFwTcBICQstj/kNs4CIrOFk9itQOkKHX?=
 =?us-ascii?Q?CJXn1r1X+LtTxH+EEPGcOAVki/NF1tm4v0nJXzFPlD2FrDYQgTWK7WQMSHus?=
 =?us-ascii?Q?s1pEoDXmlPHwt1lM+2kDTPaLbQZ3SXpaDLby/5OxVEcPo0lvRMoiXUXksgW5?=
 =?us-ascii?Q?BfZaozkQmR4zugPgUTZE2LseHcWR16ypXxnbPvJYDNwT1czbsoCh0cmxRMPL?=
 =?us-ascii?Q?WSHD0yokAjDrjWzstN6oSBy6Ncb8Gg+x5DtP1XaVIocyjMnk3MgChmObIP+B?=
 =?us-ascii?Q?pCg9oisZBTgMFOIywYUXmxDLTV9Qpd9XGnblrx1jDq0J7CfCyUubY7ixoB5h?=
 =?us-ascii?Q?VuepVfOjizDEauNFeJSP6Ipgskknj2aQyoOB9DrF8AL7DMIXz+nCWFdlWlhn?=
 =?us-ascii?Q?ETpS88QNcRL3p1bAPEJik7iwsnyoM+vFIKbrSndDnQBKuKZNnUuGZsfdYDye?=
 =?us-ascii?Q?RoId/YY3QrawVFlZ2iOmrgizE0bVRX0cqmGvQZeSEBC5HkCFIHce5O8uYtGs?=
 =?us-ascii?Q?qTNK0WwQtulh5hW6Ye5JJY6w9NojuzCKB2hw4JrMH3W67vPTv05MD2zzaKo/?=
 =?us-ascii?Q?LR/Lz/6MKdsDkD9wLLDamM1b3LDkNgF7Ng14FisJHwMyGjPM8qdtJtd/JJHL?=
 =?us-ascii?Q?DsueGdr0feC6QBRBB/x5Ecs/7JVYg8FI+1GvDw3AlbGHJFVp2YFJBuEAHdWV?=
 =?us-ascii?Q?y1XZf9lpBqv10ZX0mFVGrWx4J/rBEi43Qw2uIBL6eFGSEkf7mcuLbJkJu55E?=
 =?us-ascii?Q?fL7+eKDymKSW8PWOMAZVFhTqEegDG7ItQ7K8r+qpF5ZWafZa/GbLMV04Prmq?=
 =?us-ascii?Q?HAodSWe05by2RzgEXG6L9goUXLPWV38sWOeGAI870oA9arfrx5NiBVa+lLxR?=
 =?us-ascii?Q?Dy1ApzhjIfjkyyJzJZE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6a217f-e9d0-4aaa-5eec-08dba261fdf9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:36.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyuCV0u4iSFKm04VFQd6cE9/4z/+D+AIPcLNZ3T535p6g9lgPGPSmENelGphvUW6rpog+TRrBW4T+uFnaRYmsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

Change from v10 to v11
- rebase to latest dmaengine/next and fix build error cause by commit
33a0b73

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

Frank Li (12):
  dmaengine: fsl-edma: fix build error when arch is s390
  dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
  dmaengine: fsl-edma: transition from bool fields to bitmask flags in
    drvdata
  dmaengine: fsl-edma: Remove enum edma_version
  dmaengine: fsl-edma: move common IRQ handler to common.c
  dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
  dmaengine: fsl-edma: refactor using devm_clk_get_enabled
  dmaengine: fsl-edma: move clearing of register interrupt into
    setup_irq function
  dmaengine: fsl-edma: refactor chan_name setup and safety
  dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
  dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
  dmaengine: fsl-edma: integrate v3 support

 .../devicetree/bindings/dma/fsl,edma.yaml     | 106 +++++-
 drivers/dma/Kconfig                           |   1 +
 drivers/dma/Makefile                          |   6 +-
 drivers/dma/fsl-edma-common.c                 | 307 ++++++++++++------
 drivers/dma/fsl-edma-common.h                 | 127 ++++++--
 drivers/dma/{fsl-edma.c => fsl-edma-main.c}   | 306 +++++++++++++----
 drivers/dma/{mcf-edma.c => mcf-edma-main.c}   |  36 +-
 7 files changed, 676 insertions(+), 213 deletions(-)
 rename drivers/dma/{fsl-edma.c => fsl-edma-main.c} (63%)
 rename drivers/dma/{mcf-edma.c => mcf-edma-main.c} (90%)

-- 
2.34.1

