Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A99787549
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjHXQ0Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 12:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242541AbjHXQ0K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 12:26:10 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C21BE;
        Thu, 24 Aug 2023 09:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T70R1rrkqQuCpn3lJxc8SBYaQXo7H0IOdqNOojhD6GptV7/Qv5M5JX53YnCpMN/MzcJlVAccTftNKtSpGnlY5mnczRcu2ST6eYfiONRjRbrpcWLs9JJ6rHLbQ6T2benSXselStgJYOv4vFrTAcPdbC0GXNYbv49SjnNFaZRBAkxmE8UNSHGr9UCDyHV+Pqr2OHp9pN/1z2fEQYNeAbBLAYMtA0EOCZSAY4jQquBY6wPhHoCl9xp4Fher53Aic//fym15AfGT+ttFAV8mDrR92/lcp9kfZDDrer1cPxyV6iIvfEheZL7Q6Mu1WyPMb/XTslSksR0EQJ/mTYWY8BjS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XACH+tQkMFvU3MXvP2V5bRz1q+TtZ59dMBVEfZ4tYao=;
 b=eQZvJes97u5OVJLtmNfM9nSqYUwa9lCAs1dmMw9DeO3m50EOD3yAtXuladnUJZLRaLN0YJBQ18uX+tzD/Q4Qt/nvy9LqkQFMgFVutf2zk2A3OPjmp+ZJcyzm3cHXIA82KgtFKZC4tFis+eVZ0zi8ix46TsPb8AEJRzyksbA9VHaIBxQT5prN7aPRuYkamMs3J7X9jJgFDLKmMv6IdPVYxnhThyu82aV+zTAbwoANllIOBerBj9w+WVu//mVBTVJHtVzj/3S8GUcV3/MyXGCW8MOWKa15Kgmsd8u678KaIFEXqmRmMLFQv9OleHYVA2+S8ubhYCTHspM18T20VPaYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XACH+tQkMFvU3MXvP2V5bRz1q+TtZ59dMBVEfZ4tYao=;
 b=Mt99dDSYVZH0wBtplDTimHW4AiRVJ9zY3sF0hK0mS5xiIUiQ2/FZrTbo2HhDvupnFQGnAyEFnGCCzu+nzY75xReEtxxLyeSIeke2vhZr4kgUZlis39QGwmvdshEXnaMExWFBwdSkD5UgKKP7c0j6u1wGrVNOHlqD9Vkj5l6InNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:26:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:26:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH 0/2] dmaengine: fsl_edma: add trace and debugfs support
Date:   Thu, 24 Aug 2023 12:25:46 -0400
Message-Id: <20230824162548.2940355-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 277b9c67-eab4-438b-d15e-08dba4bed0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzYWlyRtDTrP91Topa/L2lAFOBRYXR0MmkoQfijvpp0pg2sahGuMfHyhB+re8gtb63Hk6y7ZnBGbALzQBeNlfMXW/2bv5DnxIifMtbhUBjbL2zlaR1SpuHLgCA345KWioiQxeYiFH/lHsLQxlko+aWUAZBrYvu4NJjEYDDjlVlWG2fuOGMBZ9WPmHEw+skhpI53ynQnDK7GmphogOcJU/SwHS0UxO4hu4SJsABGchQSeXeh48TOtnJYmtcjwAaWfDm9Ik0TiX/Cv3+CAToel/U09SGs+CmhyzD+XqzlSwJHd4xiHt8Oy7MeF+CS2ZsoSDiHYvtEhXb4UMVYZCNdBkVisw7mTzD4Xr19Tgz7LVRHSRwvBbibVSwLCwpSInYKbRO8RCUO/oilLeXAiTFFGGHIN070NjiAJqXBYTFLqxuyqpGiy92vNX4YM2FhZ8kaU3Vhp4eQIW2fYEANuUZUtB93pWyNnYqqWPT0AuxhhZ1UUTd6aOzZxvwn/6MXD7FLqUSkd+CXiwlTerYdssrLBEOwtvxcQNrENAgXxBsx1K4LaLueCAzuQ0wlVR6gtOd6FcYUe2hGoiRhZxDsfgWpNBBvO7qH20qdTcUX7gFJzqGQwvog1ywZnATrasOmRD/9S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(34206002)(8676002)(8936002)(4326008)(36756003)(83380400001)(26005)(38350700002)(38100700002)(6666004)(37006003)(66556008)(66946007)(66476007)(316002)(478600001)(41300700001)(6506007)(6512007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51jE5Cxoi2BqVPj8Z3h4I7lxpF+CjtInDiAmpgNK0gTTgjTFCsfPRcjS7URP?=
 =?us-ascii?Q?hm9O5jZHLfPLnOPb81+WOvkRTg7DqqVnDU7HB1/h7hmpwRYV2H9JpT+SlLHk?=
 =?us-ascii?Q?5ruzoIXVCIsay8Lf37rNTjx53sxQ570/UK6QDehIoPqmAsu3GpziPvdJXmZ2?=
 =?us-ascii?Q?C+EOPE5nwLcb+Hn7y13lPxswe48rHmmblnuXxzzzvdU28fTDR4UCO8LMEPYV?=
 =?us-ascii?Q?kBDGv/0zciFtwQG+dI73P+u5v2LqIm5JAWXbpIJ+vaxIphbra5qIIDcRW6Ry?=
 =?us-ascii?Q?36ua3U7UzuFKow3CS9TzTVxdoPunowQv2F88QRnlbPZ4oysdueNPAKbgqq66?=
 =?us-ascii?Q?WUC7nbaprN1ysnKxUQ40hp3ZU2d6KhedOT0FktSzyraieeXTmQH6YHMJdCbI?=
 =?us-ascii?Q?IJdGc08OOTYkHAlSTtanoXUxjy8wbK49KaetBoEtzGDhLih6XO1uOzG+p3kW?=
 =?us-ascii?Q?UeQsSSJtlzC7m9ChVYofxXeRRFdy6PX7q/tyiY/DtL675RpJeApRfF5LI5rI?=
 =?us-ascii?Q?xl6VmOUD5EmXyw2HmOF8p1ZeoRFlU+Vq3rGnkYb9b+pG+Bqbzo0M31vdUokY?=
 =?us-ascii?Q?nu0jHmcmKtSOFiylz63HHn6RHv3LSZeT50Rs8MbgMwRsLDB+hBkLZqjkXbUc?=
 =?us-ascii?Q?JbHkepSyirjAaRVbrTjkaUpYpyiNh52/j+TLUAoXW4Jya5GyuGEcvYA94noI?=
 =?us-ascii?Q?QOgguOM2LZnc1xDVavCMPVEjDesyrYWH43ziCUatK4BUyISfCnq41xn5aYRb?=
 =?us-ascii?Q?bRRbrYC6nkz94oHSZvJXaTLtQoJ3ib7kvFfOuGP7F/IER9HC76tN6ekNBEv1?=
 =?us-ascii?Q?n2AGLqmLf3TGpJvA4uEmsaXUOEaDHwmuXKps46RMF0Ta3VexgI/sQ1DuB+Nu?=
 =?us-ascii?Q?ChaLkxhfYfY2+mKsic3+0JIe2kjMu4et94p1C7YVwxEo8ngv6bMcQMp7iyRz?=
 =?us-ascii?Q?OZwELxzfqmTIZ8MiLTKt1LLjcx1HtojqntGJ8gfpcIPsmh5nI2vV7LPUI1KB?=
 =?us-ascii?Q?SRkGnYlGhpT6OQvi8NSQELX+xufVE7k5Dx/qn3dISOpG/SG0387x5ydyc03X?=
 =?us-ascii?Q?Q1unpruvImKDfdNqWgtDSL8E9kWrMhahtaxsGt4knjCqeO+JUlyLNgrym9Zi?=
 =?us-ascii?Q?G3r96o+4QJ6AB/PRtXciqD2mMdGi2JVGu7eKysxyUQMbj3WnVmiA7JskKKJ5?=
 =?us-ascii?Q?PyMfHKp3pSx0WAAjP7lhVuGESrWD9HBgCFPIGA+euli3rg7NwdhQWykjQ2jB?=
 =?us-ascii?Q?nM7lbilU7mwCy82WzkMk65rdMYYONmx8LDHnFJll2UU7z1puwhIELWNLKCfC?=
 =?us-ascii?Q?/ZfIl4DP75xM6TZopie7PBA/QWKGy5HfgufheIFrcPx+tvc3CKHYp4eX859A?=
 =?us-ascii?Q?rO3z8zTgR35+2x6h2+YZJZ7rxWctYShpTXwUaWenNEKMzgLFnhXi/Y+20w0W?=
 =?us-ascii?Q?vAOkdUuuCUBqzmuQSXFK611ONA4pjq0a9CsSuSvPS9NbJugkG6zA8xsD6X/E?=
 =?us-ascii?Q?n70oJVPFk0PaYj6THL5Y/LZVTCYH5I5jW9ZVSNlEm/ugljH+9s0+hwl9dTQs?=
 =?us-ascii?Q?hEb1K0SAZSKlcHhkbRPIeNsLktUvq+FLA515PI9D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277b9c67-eab4-438b-d15e-08dba4bed0f4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:26:06.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxFpwa59JfnYj2oscDgKE+aUZi/QI9j8L+4S6fZFpaAetdgy9CNcHEvpOs1abcVUYGYz3MbSeSzd6YRG2yd41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

=== Trace ===

echo 1 >/sys/kernel/debug/tracing/tracing_on
echo 1 >/sys/kernel/debug/tracing/events/fsl_edma/enable

Run any dma test
...

cat /sys/kernel/debug/tracing/trace

 uart_testapp_11-448     [000] d..1.    69.185019: edma_fill_tcd:
==== TCD =====
  saddr:  0x831ee020
  soff:       0x8000
  attr:       0xffff
  nbytes: 0xfba40000
  slast:  0x00000000
  daddr:  0x8aaa4800
  doff:       0x0001
  citer:      0x0800
  dlast:  0xfba40020
  csr:        0x0052
  biter:      0x0800

 uart_testapp_11-448     [000] d..2.    69.185022: edma_writew: offset 0001803c: value 00000000
 uart_testapp_11-448     [000] d..2.    69.185023: edma_writel: offset 00018020: value 4259001c
 uart_testapp_11-448     [000] d..2.    69.185024: edma_writel: offset 00018030: value 8aaa4000

=== DebugFS ===

cat /sys/kernel/debug/dmaengine/42000000.dma-controller/42000000.dma-controller-CH00/ch_sbr
0x00208003

Frank Li (2):
  dmaengine: fsl-edma: add debugfs support
  dmaengine: fsl-edma: add trace event support

 drivers/dma/Makefile           |   7 +-
 drivers/dma/fsl-edma-common.c  |   2 +
 drivers/dma/fsl-edma-common.h  |  37 ++++++++--
 drivers/dma/fsl-edma-debugfs.c | 120 +++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 drivers/dma/fsl-edma-trace.c   |   4 ++
 drivers/dma/fsl-edma-trace.h   | 113 +++++++++++++++++++++++++++++++
 7 files changed, 279 insertions(+), 6 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-debugfs.c
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

-- 
2.34.1

