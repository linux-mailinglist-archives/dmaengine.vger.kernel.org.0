Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231B72D088
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjFLUep (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFLUem (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:34:42 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC9E54;
        Mon, 12 Jun 2023 13:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpMfclg851gubK6p2KKJhXK4unn1+QnY09MocKPO2MxwkzlPGBU+5dbffHniVozj0nHkeDdNomrSx7qht14zWxQ7sC82T3XeGraXTxFCldKeXnE2c5ciPnG1anssl3da6k5mnkMhB+gwp2aDOgkfKSyfGJYvIf6QOLHFvoAtgQPUP+MeWSwBhIBtl1JR+pOJIWTn0KxnnvkiD+5X3kDZt4S1cCGAn4g/fFtoh7/HaAqqwiQapN6EUbE4+0Y6OSRightOliFCXu+CB/W1u9z+mBJsciQg3GqeJXZMhZwb6thkXsHum0ZTzVRCs33xTWh9sb3S2b48d+P68as/rKSfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBYYC5bby3Ju0K/sB1Q5Q20b9AxJBQlcwpNRxPQQF+Y=;
 b=KmSAzLackMCYn26tlujGPFteKr+Gb27T5A2WPwnsB2vxd3qwhnmBTFUCXPJf1yXLga0hSx3TyQhG+FWljWRqH0OoNtfFiv+beXrUjOcdWOZG1rsrHsSGQRQJhB65dyuyYb53I4TFutJPuQSYWB/VAATF0F/L9rtlN8rbFX4KmnoZmUNGFu8pemdzAdgxQgnkCe+4LDh2vdPWGKB7ps5IPWvTV/Nyr+Cah0ukDNARxlCjAAas816vvhXEe6ogcHBBNNdpZCN9TJQqwWR4+JBqaJeVXek+Mk10BmOhmGS4nGu2+/5FSLROETVHy1764y3qq8BVHQOnorKJOC4IpqW5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBYYC5bby3Ju0K/sB1Q5Q20b9AxJBQlcwpNRxPQQF+Y=;
 b=WvxM64ZT8JdoN44sNDCJTWOCi9U3tQAMPzQ8zGIs786npAzt7ILVKoUDwgBu9Tjtfc3n1pFLdaoyBo4273Odo0Sc5QktmRd2bz9RNxfBGhyTqb+9JHL6UVL+Qkyphujd1TlIgWlbE7n+OXw6LQFIiwIloQWS+ESRHT9q+zHZU8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 20:34:37 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Mon, 12 Jun 2023 16:34:06 -0400
Message-Id: <20230612203418.2017769-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbce232-5291-47d2-21e7-08db6b847031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHg9zA4Y4goUKZHiSPhXW/w5Ib0pATBsy7AgHl/1J3Yl0+GY7rHWjHjnWRHFnT+zHZBeXMWLItL83GD3OLjNNGyHBYtB+cTFXo//4TeEonEqeduI3zw4/3pK0eZsc4ohjaoxDI98Bgn8A/JrQO/UhzQidC7E9R/WUcPAN1SqLpa3cYaj4ysIJK8QkxwTDTgmGwngcmtubHX/9mfje1XxUy0CRNXE70Hc0cMjvR9HvYow6X3Kg3AHU+2vJM9vpFSjf83F9VoFCEGa3AEL08E5Bqk9t+bVX7TBxUcQVCAS4IrNKxb53l6seVLt4/IxfNlkeF+dJF8RZUx04gDeJ2YjGRj5teBwIJDmHlgnOl/afYgiO4Gq8Pr6bcsFdaf4819pFZY8hYYuFEBaXlVgHWgVuZ3O+zuNcJDRBDlv0o/9XIfHCIHhlIS/AbH+/N/CKW/k4sS+yNEIoHLZ5JGFkeIT7+Gcpme5p5Pw++4OEtFxDRtrSyB+1BvRxrLFNCpomyACdFq3PrGMYpiIGgWnGFOx0KnUg86g9gPHHTf/NA8en9JZisngx1Kg9gMudNdy6GH/c4A4ICfkqVJO2s5uoQ6VRETBQJHmRbVUyVigRrAe5wTOTsTz1cJs09Ymo7PmgtFJ/3zfAF17AQvuQG/PYYseXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(66946007)(66476007)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(8676002)(316002)(41300700001)(86362001)(6486002)(921005)(6666004)(6506007)(1076003)(8936002)(83380400001)(5660300002)(26005)(52116002)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cvD+wEpfTu2S+1rXr6xFj8czdDvWBbjF7YTt2UAt/t86TSCf7PfKpiERIw5A?=
 =?us-ascii?Q?K9sYw10Ufr0aJraUNU8ohr6j2tnxbpDE48B60af2kvgDLCFJmlZuGO65hU8/?=
 =?us-ascii?Q?94VC3TPDyOgLE5Rak67S1ooTiCEvaI1ZrktrtFxtCDVoMu/4zHlVeHOdWDnG?=
 =?us-ascii?Q?pt/bP1STHnQWcBTBpg9UM2BgVxpcJufNRldzmBtaRZZvCsEklRruXJIm/MX0?=
 =?us-ascii?Q?Q2LcoGur268+Y5ZRb4U6lHR8vguV70F1LL4qIM/W4s/o1RLH+tOT7nnspFi/?=
 =?us-ascii?Q?+2kGyzPwGsukKT9bh/hIg0DMfn63n5uswzyv24T2jJrh//ejeKYuHZcSJPkG?=
 =?us-ascii?Q?XklHsyRf4SBZbx6u8KQJJZr9djM8O/yO/Bp3bIhvzNEyUIVXzxLKLDUqxXuZ?=
 =?us-ascii?Q?exrPE8MLvd9iIofygBE+VW0K9ASdR25o28f4EMkwq0W7YKLUQy8TsTxPxRtr?=
 =?us-ascii?Q?DqxUkwONGIh883tYnyn11qTk3vANZ7IqHfUnsR8cCRFj0tcySe+reCaXht49?=
 =?us-ascii?Q?RSL7xDyY/R1A7gq0Kvbm8mNnXCqvsiM/OdUF+zqIWZDDDeMy6fxJjQSwVRj0?=
 =?us-ascii?Q?GfZNtn562TIskobQ9EP12tw+3jRUhyu0oJpg5/Y5XwDWivb6a+ytz+pK2c8R?=
 =?us-ascii?Q?ZoPPh/32XW6OQ+DUdueGVBNBk+tPxEPscVSk52Kd6l+Pkkzn/yL7uDk9o0R0?=
 =?us-ascii?Q?M66pWnW24TyYkf/Ok07RVxfXY8+mJZ805X3K/mIaH76kMlNVsOKxZkCAAdSs?=
 =?us-ascii?Q?Hq4cupzAtz6I25XJNE1icaBUsymtir9NjbtRiHQzgMf165jYe6QHNV9Bg3Tx?=
 =?us-ascii?Q?YcIa9V3ud7ls2C6rCQV2lLkD59fdlGremxRcLqKlcs9atQrADYbYtn1V3T2B?=
 =?us-ascii?Q?nO0Tj37z0CclVHYPGGWYoiE4VxJN8VQSUM/pPr01uTeDGzqOtIXGdLEoeC+O?=
 =?us-ascii?Q?Q5YcFz8QSRgDgFB1uFxEjPNjAnQabtJ8FwBSZaBEe1f0XjuRJgXE9ERxQQ/f?=
 =?us-ascii?Q?jaB87uveq5gqBC/yD6qLilC2KJBFtQ/k1WgoYqoItdwhFa6MOR2+pATOrKcc?=
 =?us-ascii?Q?uQar/RRaHwUV9PRPjkkyPUbpPlDZRlhVgIZXYDS6qJYIgMVKBfqLZTur1AGU?=
 =?us-ascii?Q?06nOzURxUsc69oJwuaMZDBWMB+LjLZYzlkRsQ436K4/ElA8iDFKGPGpBR6BC?=
 =?us-ascii?Q?ZBCpNBZmIZmjafZ/Fupk9mmfgV+HqAJxDiUvvv6EDB/YEQ8lqPP/BG7cTNG8?=
 =?us-ascii?Q?93pHdZ6WuMCQKm41AkBtgC8HIwSfOw4PZTaeQXLm+JWXUVUCQf2xBZ/oTlHs?=
 =?us-ascii?Q?tXlAbdy/byCr3SdfoypbZZaSCjYUmWZgaWaaLx3CQ8B3peI2KgG3FJ4YshTg?=
 =?us-ascii?Q?LXeJh0590zw27kBHdpP50G0IB4XYUUUnoV2AKoW9rxQgJjCKZHHbNAjeMfIW?=
 =?us-ascii?Q?Y+v6pLZBdOmPZCG1QrHcOe25NRKO6C7U6dgGMPfVHE1nSUkJqv/H3s7giNmJ?=
 =?us-ascii?Q?Mv93C6F87QD8ewjvWd9FY9/TQ6rTQgKSFp6eCLGNdfH2eAPqqR4NzjHLDoYv?=
 =?us-ascii?Q?ReWEJHlH31b1936u7OY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbce232-5291-47d2-21e7-08db6b847031
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:36.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtQ0hHrkJM91JJnv7v564iGMjEEjhTY/eV+BkqCiHDMcqyNRTV5yGZD/RKAxRK/5+7mbqAlU8DtyF4Zcs9cZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

