Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA573476E
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjFRSJv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjFRSJv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:09:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F3110;
        Sun, 18 Jun 2023 11:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNyW7K5yUm2oUBVH/ZRkkLKVBiKJP8kWa01cWw06+Xtg+dlQubC6tH2HeXiSOq7xdKCl6y0uIEFDxYqCMUTKowgsTZfZMTBvE4LBzTkA0jLVRQxo5t+dUBpvyV2B+AOmhSnL8LwmnDWHDr/wOvSVFJfen3rusVOvpDg95Oabhr0EtH9fN7AKxuDOuAF6Jqg8LJhfnLVc2UdYLFCaHP56c/kk2gJgiV46JXTVxxmgb6YG3t7aKhFSHF7im0WAUhmVoJ9ea+gdRGNwgDtMdj95PcY+OwUBdxDhe1WhkhW2XwRL9RHRGPqsYxTFeXNUc87BZWILBewaBPshWATM6p6XiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEnGh6GNW3N201nd85++3IFZ1FlWARWFbB5j++mchM0=;
 b=Iypca6en4rqqMB23b4uoSukujZrWTkN4qyudWf48mWrDOQt1ze8Hwcw6Xk7/YokfpOOnU1mnydJAwqD8WhOlB7EcJ8qmiEPKuy1AM1gLA20J1BuQPcZ5sa3riHk6PpuHxVgGJ66z4zJejozuLTvhebRqfw+RJfG8Tww06f/WF/qnpNyzVlDsbEte4PoDUf27K0iCgwJEeAS86ba+Wj8x2TgkTqJDfMvUGbrmvIu/PjBrlP1l7nQOdvxc0lGFP6juJ8Fi+JVGz70JLyFk2vA2OlXJDHlC5NsMKmPpq/QXKdnNH+1TlkVhHDXWkwNqJ+rIzAhiLzRwrqB+Hv/9G753QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEnGh6GNW3N201nd85++3IFZ1FlWARWFbB5j++mchM0=;
 b=X7e186mVnTf+FiYP+E4mPgDXyPz9n53mZsPsVBvN+2B0GyOtI8jFqpc9OTKOCOAeErxtQGWWSg7cMUZcObmPIAtdCeVWEXAg3WtK1YjR02HZUSwvK/O7E1xuAifTBbmqPNwyd7j8Uo+3MS7cezzhi3DsRtaXUzH03J5R7VlkNMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:09:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:09:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Sun, 18 Jun 2023 14:09:13 -0400
Message-Id: <20230618180925.2350169-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: f07986ad-c600-4ee2-17d3-08db7027320f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuPEwiUkivlEm4cjZjK2vLXXfAOLCzj9u8f9s2Jt9E3P4VfnkTytUq5VwTSgPXOteTA9M/P5XmRsN4bfLtx3yV/Tq6j3H8mIOzrpIypiCQggRGWPZb06sCOgBlYl5350pSt0oZK5qvq7AbJZI/KreFqs73uFCDH/zM/ozibbdRaHWtAG3e2HeOdS5S9OrulN/H7V5mRrIrW/WHHAvyJovvcAMnqbKRS7kMQgI/Uyayhbee4F+7tfuix2hijVolki/g57wJ4fM5IvEecl5541E0Bwh3Kl4EwLFcDUsZLlCTZdl9xob+LpF2c+vXYBXhAHBBvOGBEFnV8zwtFR1cqOAWFcs3BKpfjylU8f8birkfvD8sAweDCWb6Jn8I5I6bxY/UoyGselrLYKJZZgKI2/1mZkicJUuAOj20FJshe4v+HD52+vP9laYabm8PZV2ACE5LTQhDpd43xxyJfam2GN7qJlg/pzCewR8BZ5XtvyAHblSpy6MvZ0nu47PHyZ1gkEplZI/Tx8MPvzNfXEb8i1GLMOYURzBkgbzyfEOUtubGWOAX+rlsjJif2OZp59RqcwQR8RxF/mcktyXCtIC30ZdvPWGD1yMai/jjE+3P/5NRhIUeYdorjeFtf8W41Vag7T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJcFrkHL+PzJkBBjF2eBV41IHA66Y8jsbPglxGHZ7FrxR5IiNo7hSa0Yo13k?=
 =?us-ascii?Q?sx1PbPwL2oxRwgzqSY/0B4UmHtQ3nQb6aKy2CSJkXMspN9SMRhSg/FCEMfbv?=
 =?us-ascii?Q?tPi38YwKzS1iUSC/aEsK1dmfEdFBFic1qhX6GGoW2k0kzLq24SZecEfxf+rP?=
 =?us-ascii?Q?oBt556mk2syOLYKBU2BR9GHYW2UGL0yJIj8U3Wiwbj9PIORlgAphTPM43dY0?=
 =?us-ascii?Q?4Y2DGalCF9M3okfT5e8jgnvPIzRh8OyXfYHD1dFLp838D+2ejtD0AOVrrDnI?=
 =?us-ascii?Q?7lOFfqrRF+OBMQ3+1n3rYY+qKRu7epMeFDc+Ycd4MVms4RUkCDAC1wkp7sL4?=
 =?us-ascii?Q?IE0egtuAv/cisAG2ChIqJSSoHgST7nsDpTf7+kelCottMEoubjme9fisg5Ca?=
 =?us-ascii?Q?WK26bmcFUfu0QKRnRX3l9elHQ464gerndAHl44XwUe1MbS7txiSsR8YfDRCq?=
 =?us-ascii?Q?LkJvGiSLHSm1H3rNM2jh8ZDykG39PX/VAvEgP3boq3qCWvPPrjxCtnnZpKH1?=
 =?us-ascii?Q?jt2R/c5v8Bd0LwmRQocbpNKP10z4V/UhpXSMPEhteLJQGruCiXZvRJDWUOCW?=
 =?us-ascii?Q?asKsQqH52qULUD5WJNc+WPnIxAyVEcUjfGkP7t+uodFWOZZ1AlBgU/tsPg5T?=
 =?us-ascii?Q?W7FU+3xckok+CPTNmhn0xDVqBNzmqo/hmIaX2uSTnDpEibK1pStdYAdHAbrw?=
 =?us-ascii?Q?k9nitR0Q7IpAQ8HBLyeZ6vV8cbMdp4i4fMd4uQlvBtgOW/Tnp/VLL1efD/s2?=
 =?us-ascii?Q?AmHHnn0OgGk0u8yW9X5AvT9xqSSv1xj7J2FSQA/UrMQof1Y5wSoLQiisNkyJ?=
 =?us-ascii?Q?3mMQ6f6+RrM3Zto24Cho/i3FuaSV4pZjfcBgdEOHHD1VuDLHjRhllGhEK1l5?=
 =?us-ascii?Q?z7A27x7O8nFM98w+1QHOjrD3Si3S7Yub4vKsLSeZ5+u+w7gv8c2wanq2PgFQ?=
 =?us-ascii?Q?z5zt9tQakoccr6Xx/wYQ/w5zZkCWshhjBnsiVkwlCSah+ZzfL188d1XA3yld?=
 =?us-ascii?Q?vvDgsmRGii+xnq2+UB/H1e87ldsXopcJVYhhFMv+XMnBf1dodBnCe5cJr9K3?=
 =?us-ascii?Q?HIT2R/Cia/wF+GiR4eYp+QtSxIh2wSFYrXkVmpger66nXNWsH+vA+NmhLKFa?=
 =?us-ascii?Q?PEPcJusozLwdF2s1d4Mnz53Lw6FSLmlIzz0i7OrJcTTuwl2b1zbPTB1L7I+o?=
 =?us-ascii?Q?H4wKkXzSREQ9urCdI+ba5ApYcbkN866hfEiNkF+wO+SYHs5q6t4uDqYUgz9B?=
 =?us-ascii?Q?OVWS1lq6tWfwBPZHA/eyl6tRUO+S2nAon8rv73WzE0UeIa2vA4rhSkJsvwCK?=
 =?us-ascii?Q?KncQbiPXjakOpeNr9TFxQM5zgZ1rO8pBwFGC4lM0craKgUyxuclgo4WBlIm5?=
 =?us-ascii?Q?3bso8ZSOVBbOVcUyNXigGd1SkVjRhDvfxjcYr5xjYUajAY+Fn/udL6SRWMmq?=
 =?us-ascii?Q?PyTuUgnoLD18M3WiMWDJUHno/S6CYAUSkXbtVpo/MxBIiPgFEh2yV1+LIWs8?=
 =?us-ascii?Q?zs1nBu/fK1ygnC5BkvpKZ944GP34XvypFlGKUo/wVHb9rtCMgy/0hYxgm3cB?=
 =?us-ascii?Q?DQStZZzFe2XQ1iI/+4caxRLRtjw1Iw+trrP7gssM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07986ad-c600-4ee2-17d3-08db7027320f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:09:45.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+Z37oqiN9Buhq+snG6eskXbjg5pgqhyjmOs0tGY1uJ77FsTWKqQloa45k8ui7ka40B65Gw3LffuBGn6DT05tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

