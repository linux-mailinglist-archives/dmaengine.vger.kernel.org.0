Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E717A8DB0
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 22:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjITUTU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjITUTT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 16:19:19 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F798B9;
        Wed, 20 Sep 2023 13:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRX0pReYTYo/9KUA4sNlnjjrY0yFrbgb4XhSkUM5qROFpZc+kxWsnDdxgnsWsRJ5b9xGPbsGJHXwHYrt5ngWhYOMCR/ZVCSRlsf/n6Hutn8hSWLGAjGLCKV89XIazOCKfPto+Qs/5pKzq6lTWuxlZ8WknTSOadyMdWBHKZGBCVpNS5J9eKJqlLp7oK1IjDtPdqwhyoN0KJNa/3SKhQlM/3gVFxOS0JxovEbkHdTnpJEn7ZZf+yMdbv5W0LXXwjxPkFE3G5gq+a3aMJaWxPJetELDlkjJf6XZwfbXyMB/U9MXaDtBiDTRznLJlkGDNG6udJWLsdW4BGtjrgTfxF+Uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYyKUvM95dQHB2l513mIVVBd2544o9uB7ueWLJclcEg=;
 b=PCpzc1tLhryDExYKEF4ozbxiPc4YfBcU22zBc+ATrIbJsFc3oPswGXaAyfixhhXzAF3Oi3CRDB6UBgv1FDetBUe2D9ixHd83AZMhZk4bwzQIDXjwdUcBaKfqDCByxBr0T4mbva+HRqLh2IS4DluP0+clV1j18BURCGuM/ehAXxWhZpFXN0qJZYvSJxYTJX3wiZoB+4VNzlaSOFs1pcO1xZ87XcX7+ju8dCJ96XaQsCZ0yGlLcRfH7AHts8u2G9IFfLkhWUk0/Xh4NelsKpuCcyM6I9RSBXKU1kFZNlq35PAHmmB1C9a4S8FLZv4d6C+i09T619StkGf7HVheZf79Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYyKUvM95dQHB2l513mIVVBd2544o9uB7ueWLJclcEg=;
 b=k0uZI9yFsbM3a89RAs8VzEcIQIltv/sIzff+UH+ScROyqwHESO5F3VgAYvRg+yPhYnM58zuBgHMSIPkxEsR9V5HzBVFXpwRh3BIyew4G5aeqNTHGP/gHFHpKCiWPMGYOdB8PbyzMNj0A/AQ1Iw27dIGUDc6ZKg1G/XPd8tPmO08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:19:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:19:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lkp@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Frank.Li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        vkoul@kernel.org
Subject: [PATCH v3 0/3] dmaengine: fsl_edma: add trace and debugfs support
Date:   Wed, 20 Sep 2023 16:18:49 -0400
Message-Id: <20230920201852.3170104-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: a89fbfc8-bc28-40c2-0694-08dbba16d8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTvWa3LyO0WGKKpJzM0duObDaAhUaChxXVdXuuHh9oqHNYUACygoQ6lTPJWF9tSV3VHK09CSVOhd3QAPAL1aMoa5N5KUpoyIWjgq4RPfT3CjDHg+ZbAMQn3os6b73TAXPZlGirvfY9cQJABKmDLjFGD75mmYXXLiUaAQ7F6L+9ORaMWyLzi3Bj8MyPr2n6EkCIJ0k5XXaNL4DBLmHs/gvRNg4IaPMqzhNGJhlRBUg0FxDbY+bZd0wLlonrAbbl0AC3dJghCYNhBt0RRCxn1U44n2lBurKKBBnsfPYnHcYXDgBrS4rBZCvUr4XUnV9rH3DsqUQH6b5i4O9bvR9dwNc7vfJ2ih8ZkIisuiq76dPos8KdqwKLK4By4BOuS77oXxFNhMRoieoOQ8aWg419eD+3osbJqFZeNVJKRHnoeEFCWapFnhD3B9/mOctEpuhVqV/qWN75j89fUw7XOBR/ggEMxQ3m8OPRvHZtuplApJKDLT0aiBUiJhfnOQjZIF4FsZ4pUWatwFBp31p/VMU8Ide3mAZQi0IorUjtO8hIuwTaCBpzBFCYE/dvOuc5U+ayeMTuRNEQeqmQYmKoy6+l8EDtdbuBq8+5OuqxLZd3c0RfPwa8VwlpcGyNMvvwinoFP8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199024)(1800799009)(186009)(6512007)(52116002)(6486002)(6506007)(6666004)(38350700002)(86362001)(38100700002)(83380400001)(36756003)(2616005)(1076003)(26005)(66476007)(316002)(66946007)(66556008)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XM+P4wBq/Is6QVoWGYMrxVhU0iiRsJM5Yx6gpm/xfKI8pCR0wmay2swS0OeL?=
 =?us-ascii?Q?aR4EmfZZiOHviLlZA6faL3Ng0a0YdBaYCow9r8+Eq2TkwDKODS1OL9nTAkxx?=
 =?us-ascii?Q?Kw2vIxJH9bPPdP5nXc27tvsh6cvDXb1V/SfGiNIM6Y1E9mmmhuNKAFJXJmDW?=
 =?us-ascii?Q?O+FTb7HV2L1OX1fgMOojJDJif6Sifq6O1koV/LEWekrexBTvZdkAbeRkPFoH?=
 =?us-ascii?Q?UUElO7Hog4wniOQV1SEdM1TG4Aju42lrJoHpboRJMs8casd8nBKgtRe5scAg?=
 =?us-ascii?Q?qE6JOaH+pZ7uD2qr/GCkjPxQ4Li6jA2z5H9WILFacNVVCJW6G1TVtcVCsAl+?=
 =?us-ascii?Q?SKYlv2EnP5YrzLXQTsTAIrYmb92rYwqvWYgcqDM7EQ9/H4Yr6V/V4EfrL7Lv?=
 =?us-ascii?Q?YFcjxGW1hCbveIonKOTm/32p6RKULbvRruxBJGMlUVmqBLlChEic9g7YAFNV?=
 =?us-ascii?Q?fpDYyAgjm3otExjS3d846gAe2Vi8JJ9BQJEjPHWdqFne7za4mj3BRFLggPWt?=
 =?us-ascii?Q?w4obNdp2tDyiXoO2v9tKMiRUZOs6ThooUUXKnnUW4Bi0mHoymwThsQNyt+rw?=
 =?us-ascii?Q?WCpmL9qHMoO7PUbuKoR1QiO2HA6bPCmoJgs3plUmchtdkNNObtQxaLApCEP4?=
 =?us-ascii?Q?OptfElv28rwAxE83wFpuL7dW3EPo8kbVLl3ca9CPPAzzhAlmiQvdtL4Oguo4?=
 =?us-ascii?Q?Af4qpTRV0botOy3J9RBhsPJFErNllCmk+xxrugeQTaphod/nF/QF9EiP63Ar?=
 =?us-ascii?Q?gx71sF+WS8clPx8fByFHfz6Fi/dEqiu0LpEHys0QKMuHt7YMZxRmxmUFuibP?=
 =?us-ascii?Q?UwPmAIg+l85rftEXmpGtGYN4zJkYsaGk/CK6gI/vaRnb5XhsZ988J4/3ZKF1?=
 =?us-ascii?Q?n0XAH/dgFgZr75bmDO4EpoV9xIjz9yZ1Eb3cnSCdLR0kGWBjZ9aP3RZFZV9B?=
 =?us-ascii?Q?tFGaUsO3hfJ3/x4Ytbl7L/E52CmzFdv4HrY9OD0zOL+M2vWamaq6tWgsczaR?=
 =?us-ascii?Q?PQtYJoXK7Liwd8E/z9nkN6n1bdGQQTJOzqCutzIk5N4BmxfHEovLiB/vsKdb?=
 =?us-ascii?Q?+QhF3mq9PBL5G5ASbDImvxX9ldTK1ujHRDWLU5HrB3cwTKnL6tBzY23lIYnu?=
 =?us-ascii?Q?41XunpBvNE0ZOn5tGxuwxj4Wgn4Mlq5Thtmm7K5N+AMkwjK++n/otH6vYmR4?=
 =?us-ascii?Q?GQra5kGV04Y2mKN+J1l+furgbOras6B7m1bdtpTH3v+pYX1Oz0/MJ7DkRnnU?=
 =?us-ascii?Q?6aO87TZWSfYw5yIpvSqhbjRNrOP+K+54w1kaozSKeRqsm1QDwJSnvf4VPV3T?=
 =?us-ascii?Q?YuPCfCmi44jqLnTiPY+vDZNZxCLCQTSHAC+irEgKBI+eTIhNS4f/5Mdnz3RG?=
 =?us-ascii?Q?G8TNicLkBPvxpT+l4bUecqGY/BrpcFAWr+LoiCyzvB3dcrIJPUREkQHrZ9Ac?=
 =?us-ascii?Q?4IZTu+hIqgPHgWvtaNhlITJFMsLV3MaB5+kAhH+IXPfcBFpaY72JObm0Ya8M?=
 =?us-ascii?Q?TyAlbAl2EN8b3DmKcCUq8hoozvE5zeimCZf+aoK62v/Jtrbz2ApX7AaX/oPd?=
 =?us-ascii?Q?UjaCPTNDR5P8X3t2v9mKoRIsc3BAGDCvFYoQjkaR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89fbfc8-bc28-40c2-0694-08dbba16d8c7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:19:09.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SkOcq1ncf9xLpM789vLjWMBWR2dPYCNq91h9D+pNrdTy0iIJt0YF6qoxfwm19tr6f6R3VvU2kJ4RgRaihLsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change from v2 to v3
- Fixed sparse build warning
- improve debugfs_create_regset32 and use debugfs_create_regset() to dump
  all registers

Change from v1 to v2
- Fixed tcd trace issue, data need be saved firstly.

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

Frank Li (3):
  debugfs_create_regset32() support 8/16/64 bit width registers
  dmaengine: fsl-emda: add debugfs support
  dmaengine: fsl-edma: add trace event support

 drivers/dma/Makefile           |   7 +-
 drivers/dma/fsl-edma-common.c  |   2 +
 drivers/dma/fsl-edma-common.h  |  37 +++++-
 drivers/dma/fsl-edma-debugfs.c | 200 +++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 drivers/dma/fsl-edma-trace.c   |   4 +
 drivers/dma/fsl-edma-trace.h   | 134 ++++++++++++++++++++++
 fs/debugfs/file.c              |  59 +++++++---
 include/linux/debugfs.h        |  17 ++-
 9 files changed, 434 insertions(+), 28 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-debugfs.c
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

-- 
2.34.1

