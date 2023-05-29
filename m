Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EC715031
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjE2UFU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjE2UFT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:05:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2527EE4;
        Mon, 29 May 2023 13:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAD4hVHNSURR3PmjO9Z5GhxOJR984P/eiBWfyhV2uqzYZZPiKt1RCbCr6d/aF0RCZxqrcH4PFqmhG8ujek/783WsFc6KQD8MSMH2daLpupYRHGbdCb/LXxma4ih9SBdqVeF8TQ2kmwa2dFTrmYQLeaoq7NO+bPsTj+u94YjZfKCH67HqazpTreBzjQcrqVPIeWfQVwg5pTiXU0WYYzqAbrPLF70JhZqhJidOeaejgjb5kXyd1CDAq0YLMLc5sWFHTmuABjYNSIQ9VAX5zBXeVKo3MNNY5Emd+o9bMYqxuid3w597IIOHd04joUgqPH2CaeYd02PGJvEvph037dsEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PE8VdZf3H5jNzkDFaSS72q3enqaUmcsgSbsFTnEJSk=;
 b=ScUEM5HT0e4DcHEvCUBJz4gHCgutcK8Je9hagUMTQ8b1Up9HAZr1XEfLLej7MfWCQmIXDdAXwh54vy933EvDoBNAncGBvs/hMFpqAdEVUVj25nskXfh6LEDBsWFJUdl2KVZfpU05EyS2eyH4/FHThjycJqHhmLAbdWJXmiy3DmGG541fgYSYbggWTr/u9A6AyKkntZqlN3gGZpSEBmG+V2WTrEO+R/g2/3wRziI6400hBVe1trqZwkVgVvBt7dgrXDLKXaEm5FjGYwsodvjCWziWXhvWF/HJlvq3T5QZHzRmEeVOc5YI6NCEjNoQq/++7MLf6sz7j6MwFQSc6ejgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PE8VdZf3H5jNzkDFaSS72q3enqaUmcsgSbsFTnEJSk=;
 b=rqxMlcnWE6+BKf5B1QVZ5pUtkSHRUNVMePyg4My7czi1n33mWQ6i/trMJjFmdVSYhX0xH3Kmmuku+gXjQ6keNxg5JJwcY4NRUwJWKh+DCz/waEJvHJ3i+boOAJhckJ8kKFB8Exgb2prNFM2zOfNvM4CS9k0LJKMqQCIs9osK3+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Mon, 29 May 2023 16:04:41 -0400
Message-Id: <20230529200453.1423796-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: c74ce2f3-1057-464a-17e0-08db6080026e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNY68I/R33LGD4DNY4nGhmVT/cLM9QNYgCj+OxV12NUVIoCyC0OZH4PDZnWANnG2kReatRJTgw5BempcGlRqTAvcdNuv5xIbNFau99NCQEbjPEkutj5enwiJttyO9XOjtJepKBWLSEUm8YzeZxIhqk++kRvmONLWl8PEK6Kvq8giFK+T1feFI2yQBLMV7mLWmppIYZApaxdahNTQbYoWI80IUZeANBHEUJgZbbV9w6ZX8t+/Jc8UiLGqxPwakleDtZHldR/XpWVim2HoZY2CnN+t9o38MZ0OGngmUFkuT2m8luWWUYWc7e/ANS2pXg7dXSyTfKE6na3mlXowIdS0AfxFmtX9RN/pPSNmU5/L3BTjNR2Wkcg55jhithGZfPyYZgC+MlFk5mTb3GJrrgucyExwRZY2okKKCflVSqdej0ZnKgUaToRohTf1kBi55NX4ZJ6V1KCym26HXsKDGqd6tbzRw/RlTsiJG6Qh97hAS8/xmswtXj8NauOgkKOLTCuU878QXSDhLCO5k9KMfe5XrDQDzqNMnMB+sr0tgvjs3u9VvOQMZEyGAIQWduJSCwCtYBl1ZSMKN28Stx7HyApMG2TbqLCWLmV9Hx7ai50br+CafuZy37qsOvHNS0/ozACy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AlMiOwmfAHn11JIuvxDzx7PT+ZIzJxEbijMA2QnN/B1tDqPNbdXM36cF7knj?=
 =?us-ascii?Q?SjIzk+EqBXhSGzNLi12wbtC8G9pv3sTX26x42YA6CO5B2ailL4QHb0yRzbWp?=
 =?us-ascii?Q?xL479nq9JvqkXm3cTQUri5rUuA+sygr9SukJj4PdUgpIowZqGV6WuEz/pGZe?=
 =?us-ascii?Q?pFx/zCOw+n3tDUcCZfrV6jqwguHjwjh0EzDqIwv7x66Vax0YkV5gSuZRFBZj?=
 =?us-ascii?Q?M/wPF8BXbY5x4b7plqlUcpxwGzApmSiiQXHDoJUTHDPgF8L+45zni4IEm1FU?=
 =?us-ascii?Q?DEIj6BeIDptLsN7wZXHzYOHm8XzLdW3gk+Gs3/d9taxrhuKIZnIR/Iyo66F9?=
 =?us-ascii?Q?saHp/qLIlQHFK1lnx2aj8wsoWTeM16fFwpPH7r5zdR+KQMqqV7LKYsHqebLp?=
 =?us-ascii?Q?q/+vPJ7c7LTyUvnZ/zdJqaYJ+DwlI9S2mrZtcRmkee64PxP0nPrB+DAiv9zW?=
 =?us-ascii?Q?DG52YXoMEzVP7h8LkpcDjgse+3IXCda9XKQ+Aa30NY8P7gxF4MzjKr5+P0Mz?=
 =?us-ascii?Q?xHOqlBvucwVUhztq5LP1EAHC7nxLVJPXFZjMv/UH4LXcoNGfBsfFVPPkALI8?=
 =?us-ascii?Q?wblbFUlQtnLHX8sJ8gLmeJ4AICz+DsBPXNAd1e3jh4qbdP8v11SazbUu7/7c?=
 =?us-ascii?Q?oaHthkl6Tdzxy1wqL7iU95o3zO2TKbfEE7FNYwHvnob1QfAnPmqTw27hNDLc?=
 =?us-ascii?Q?B/J2YcC6JidHMhGIXpeetbA3lbgQ8fFIG/HaMGUPgyEQB5kNbB4d4gmlpyux?=
 =?us-ascii?Q?/akc+3BYJs1/QUpIGvn9boWMcsqlhnyjwlub4R5mK6k7Gai11hG4iZPZx8pK?=
 =?us-ascii?Q?whVTwuLvsjZqX4jvuIj/Np+XcbMjoem7jEJ/mHek0d3atXW38oCJqnh8GFZo?=
 =?us-ascii?Q?GhIKvyfz6E+YdXP5XPXIlZG2B/1THi7jFwF2RIIXCMkz9vFNbKbwqh4wmc4Q?=
 =?us-ascii?Q?FiAmSb39nao0OZaDAIDDH1JNBScra4Dbt/IVo6j4PBvUiFriH77ZOFDErMxP?=
 =?us-ascii?Q?ygGd3YnAbAAqLqy4RtCgtBs7YI1W6O6vpKkn7QTi2gie8xb60dVqdYHwOY6n?=
 =?us-ascii?Q?KkKxon1EbdfVt5iXIWo6zqQRGAGpl2WICbe9yzlhv6ddC5gjywOTyYwpJywI?=
 =?us-ascii?Q?Q0KJbvp7mPdFwvGQpOz5Js3F6RNcctff5Hl07Iz2cISqO0Pv50t7SJAnPqU0?=
 =?us-ascii?Q?3F0LE6JU/VVIz2wDCyHkARJ3kt7zAe6v69ntRZtBgfQq34VCKvAbjnDPP+Hk?=
 =?us-ascii?Q?ypQaqaUvygDmgAqZbCXTneYz/xJSbAf+sKfH3ZLXwIvPlr/pqctCm+8B6/Ot?=
 =?us-ascii?Q?Gr/PAeRg3OrJOq3PeKeMa3J6hV/5cvgx+U3/FkDTPiEYhcGPuamKeBnXolyU?=
 =?us-ascii?Q?oXDT/YyRkivVzO+8Bag1J8RcfViobNAIm28shzjapKUFPrPzmXdlY00JmPBI?=
 =?us-ascii?Q?j0d4iG0vIuVFFkMvixLHENnZG8tvskOUqdSu4jb3O2IR0t7khd9d+/gyVdOv?=
 =?us-ascii?Q?FDIeCyIhmQ/G0pg3NlicgbPTnvGou9yhGgNlaN23QndsfKiKghXSGJrBuHTq?=
 =?us-ascii?Q?mTzGR5xw2qT6TfRUhLCf4KkgOmeqWcE0NsjJ1TlY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74ce2f3-1057-464a-17e0-08db6080026e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:11.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiY5cJhTBmB66f9mD2U/5yILjvh/lMh0x0+nM/6FMWa+UEFEO5Caw1pDdgejZKjEHXkocBGWF5wLrqxcnC35KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

