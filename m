Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF56F72EDEB
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjFMVcM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFMVcL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6047E6;
        Tue, 13 Jun 2023 14:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZy1HXuwzRLZbZkPPFKCdc0ShLiCmM5OdrlpIaS2JTImi7hTfG8veDkj9VJG7PVeQZYHQjA28Kq+twmmTEVO7OwZwQfFAJrCCka37vxkTr6i7/zQVP/GGsiZjrGN4/7DRUDVtGi91Bs0Qb08YzUpeniarQfaFD+YTsD1o5SuD3N2gk4E5///RRx/rYabkQ3L+ELVQEL6pH+Pk2T2q2wZmf+9kWFqoIznsBs3M8/9EF/gRKD5jrIq8M1NoeMPTLg9unaTKJe1RyO5MEWya1zciaREyRo23nzF0HCHJfEPqPPSwn/co7t84tICgjlG3HZfgWm5b7MI54GEDUCKnmYVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/B1anbGOdB6uOu6o126ivsIDalGDdPgDAFM+UPY2BY=;
 b=WNQKIwvosXVl/18fmrNTNQ41q5w2+Ub4D/X68BMdJOzfjSbFD/2P8nGaBW4CNO5YHwK9/UaLhfRLElOBOUNm34ahdIY25PgkTzQWNA55ccrPdHDiPqkbuVeFrz1BxayEtAv2XqQ6OODegmQIUtBYJMyIAGApJI8Qd55dAPQL9uQahF+6OIFkFQDIH77vmVJK3HNwfpnkUUaBxwcaK3GQlPKh/e7Wkykz4jAt5chxaI5u4JlRZuNu0oYGPRQkCaRZvgTObxYcgfrLz4XTc6D9mqcgqXnxtxEktb98sn6G3I6trrC8cxrvbN0/wTO/zOuZ6TZ359Oi8aXSq8flzvfsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/B1anbGOdB6uOu6o126ivsIDalGDdPgDAFM+UPY2BY=;
 b=kroP6CmQdEQRv4PozyyHm3+vl9Q2+IEQ4BCzo7YDo1Ry4wRNX8bjj6vPsUYDnJbH35Ti6ZKeWVCiOyvV6LKADuQ8BGY9xAxdkEl2PXzykjTOAMf+WI/hsfzxyB9L7avAjA8yg6Z6JBBYCb0WUuqqY9665fgTqcN5uhG6er+ICng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Tue, 13 Jun 2023 17:31:37 -0400
Message-Id: <20230613213149.2076358-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: d3056bed-b69e-4121-0945-08db6c55a345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcpCHwXIC61t6+jNU2QraTilBybmx5UAa0IteammGroQt/rUFDSqGspg0HQle8t5wUj0utJTPcs5TuTnKeW3mmPt/6VYxPB8yOF4klBEceb2TgAvMAPX24nYqDYrDDQCYzSCEn1HciRJ/HLSrliHWBlBzKw8RsRumJEO9/848RLLT7kVl6l+XZP4erVXkB/MUV/oIB9P9Nbbcvi6Yq1goHBLIS195UT1vBSxJSmItm/a+xZCCmeOHO3YW9pqeuj4uN1x5VaRpuOtT2YDhhZDcbNDPJdqIeOQEvXVuYtb1nHWXJHtzVGOK9yy+uDPyhLuu1Q4sXlUfKC+k/SJ6yz2kpllksXJgB8rrR3LEZRd3C6D5e0dzpj3ZjzbyGKswnBoY5e3Cg6kW3LDq4RTeqIkbJ2QRRyImtjC1y2OM5jiTPSSUvQOg5+BLsw+5eiwIxvyu56eidEtmcYK179RYthFiEztlOXIDvXhtCc5yAbkQqx3+buCY0Y82tYUTwQvqkQEDuPnuq8DvwnFjT9WSqmnxK70FYsA3wdLEPSQYrajyr+Io+q2R2NptzV9Lte/NZkxMKDepiHiyvnj062IoqoeHfPS8lFEt8JRND0UtrVwRDL4PcF/TnhkjsQ6hq3lS98km1dEgF/BGDb3ltRRxHbU9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sD9hoBrlD68iU41uSjLfO/pC0GmkfSoJrmfpLglBInqlP4O/PvPE+/wQihr0?=
 =?us-ascii?Q?pn1J6zS9FiTuns3BtwUXXnUsNO2/SmDP+QwX+SssYRV+VsteElmcFe7xvowD?=
 =?us-ascii?Q?8UN43Dy70rTR2nnoWdQ4FoHa8Tt3c0HaijZHnQLhwqJ4BCbSDABN+JYQxTWv?=
 =?us-ascii?Q?uqPsANoxtUhP5bBf1rLkjSsEzDtjvLJHz/6u51W7vhIFVZosTTnNAtNkdPCH?=
 =?us-ascii?Q?WvT+tRQJVc7hrTvwx9kFeBdWnrXVwymROB+go4K8qun0sQkj6XvIve1Oi0BW?=
 =?us-ascii?Q?fhAb7rohT0WZN9lStX/5SAbZsn98JWJvPd/Y96uajpDsqD0iczGSzmrbzi+c?=
 =?us-ascii?Q?dvwzWhwWYtQlbW89BD0O2hmwpXtXEbIODApf0VCxaGWFrNYHPRgwvy58lOnd?=
 =?us-ascii?Q?j+uv1iV4f66peklFbMtqR9babJJesc4esdwwUAXPytPkpU9BL3FxwvtW96ng?=
 =?us-ascii?Q?otZqnFPKbl9dKPn/Py2JEGHIE4tHe9/GXWBhdr+LZpSXeEdkhKEDTBG4K/lB?=
 =?us-ascii?Q?IH+r7IMa3c3grk1n/Xtn3zq0SEVXl6GlYtKd+PHiStxBHeoUAeRB5Fvvv2eN?=
 =?us-ascii?Q?btixHBv14tIxfCPIBxpxGzZTLDshsuFaoB4kBvp30Qa+iR1/ds9ycdbHMHan?=
 =?us-ascii?Q?bvbSJFCit7/aDxyOEsgB9KeViyTM3ThrsFv2FhQcyUbOB2B80lUsJEwttghD?=
 =?us-ascii?Q?m1/oV7qMrARtKSjipnyfjlB3A/blTLjCldH3D2N94bfq8ClpHYc52HSVbM8l?=
 =?us-ascii?Q?WhDNqDJSICO0h6csCeHVQ0DFLtivU3ygRF2rZCUq203w0gQMSVt75YLIPtpM?=
 =?us-ascii?Q?dd+vxam98d/nZan9rmt8701yL4sAHrDBoZMwVnrmCFO1SJjutVTpDnd9A4G0?=
 =?us-ascii?Q?3jahihUNoxw+t9MdcCnBauBQdHQ1N243L9PUXZAvsj9+BAyDtR5MMkRnG9FM?=
 =?us-ascii?Q?+L1D7xx3V8gLfZIEQcG0zqxsPwOXcn9aAYO3ErkWfO+KicFDpmtMrDi1AujY?=
 =?us-ascii?Q?IxEOjV9fUIogSa7GzsENpGOFF7bSFQSPgq5vuufLv5OFSzBNAtBWFiVP28OY?=
 =?us-ascii?Q?Xiv+iEJUVWjJFKu0G8UE5qHU0284IONMoqkNVCp+aS76Y9/T7zn25K/USwgW?=
 =?us-ascii?Q?WSEd+SERslkztu2EM1D91fWhT8wZnZiaMUQpCVxh+qIltAueIL/aCkyPP0mc?=
 =?us-ascii?Q?tk7wUCLrnJz/sxAPKvdKDDDIPwobScLubYWEYESDkt9kPnZeLEZhhwh/dc2T?=
 =?us-ascii?Q?CEZls9bkWv9puiMy/sK/e2+2nA6C2DNUOqLTZB+ymb9kyco42m1dQ6r6hGoB?=
 =?us-ascii?Q?pwls29aInNRyl9mdxMkJuejUxfTRz3Ia2BR02NJm8CszmMCSh8H1goW9eNs2?=
 =?us-ascii?Q?dHGssOJU7N+destTS5s6Bb+XBOs0QsyvXlohY8YkkYMpJyO5rp/5aFmVDiYi?=
 =?us-ascii?Q?3o1HSHcZDGJanKN4yql0cWuxUZSKU/1kPy++Y9lH6Y5rulc+VGxkGQpnvYyF?=
 =?us-ascii?Q?c/xmLpfgO/FRSr5YtF/nJ/ADkqJzDL0Q5a7peSY7jbWA8anKWS5NSvM+GfQx?=
 =?us-ascii?Q?a/Ett9fJHpNevlOVkTU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3056bed-b69e-4121-0945-08db6c55a345
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:07.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+lKZMVuXvnVKH+Y24RSEgDMgka5fb8SENqb+7p4ZbHR0SFbD2QdULa3M2Liicc395glyKC3CctH41uiCSAeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
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

