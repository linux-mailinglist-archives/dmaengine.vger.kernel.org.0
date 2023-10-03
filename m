Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD57B6C6A
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbjJCOyf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbjJCOy3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 10:54:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717EE26BE;
        Tue,  3 Oct 2023 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNA9eJ9q7xCAk8tEoICl6Edzmgvo3MW/5WpmO8+/NVRugity7Cc5y8KorE4O7YOGT701+as0jIYRLj1RqoJvUeg5xLNpWDWYGt8W8R3VWY4t5i4eme68wFdtjwiB2RVcIlp9SBHYFtsivfn+iFAE6vKMBPNyq9nhHrPHogMiN4tZLYyfiLflseBKUCYKIm7mcwcus3+v3sZBLM3KY+hfh/XyH3enQnPa1hf7FLiZxzqJHJHOeEs5KYOrIZvwx+CQXr96S1/wUZMnPHOHfwXvCSGRss1VvTcfEu/HrGSG1I6je9cQnAwinuwwEkjMD5ecGq1zdj6bnIDMqBZEK9WRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztd2TlqL5MK6IbiPIib3jyaS/nQbB4fi+bTpNliK7Ls=;
 b=SoBLGQvzFuQySGT5wD5LzrIblAKx90jxyp7J/fnXlflqV4mhkpOCPB/C1c7777YcDL+WSJbj4aOYhWLzEF7X3c760J8E2RV3QUPO4M2eWaTgQsIgyxf6BocjSEK8ttFy9JgnHifnAfu+UWRzVRHvNwo+IWEwFyolss59YH+WsoKlmaUuOd96Ezmwf0dTPkwTdo3YonMuP3E25KSSZhaw+/d1zFQ538eAFQzMMWC7vHxUnFXafk7mdo9BJ3vSefnQxVgPadPHZwkhJwI7Qqfe80YzYjeTOO86ckrN6CIwF+uNUYUtkQ+FTwMSdSdYuteZSK6B4zwcZsDGH9j8dKsCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztd2TlqL5MK6IbiPIib3jyaS/nQbB4fi+bTpNliK7Ls=;
 b=ZWV9DtXXz8H9iQ8NvBoUAqi+TmjB5aimbvxUssYpTN7zGFtJVddNBWDOxFyf2uWprJrp9SYJL7Hob7sm4XFAghzrEuhjtfffVhty6sNVHczNCmtZhvdqQluN0U32TCmbJEvs8flA/4dOFQF0OW/LxUx9QetrW8FBo8zMhYrjzWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 14:52:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 14:52:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v6 0/3] dmaengine: fsl_edma: add trace and debugfs support
Date:   Tue,  3 Oct 2023 10:52:09 -0400
Message-Id: <20231003145212.662955-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: fcda9827-463e-475e-3ffb-08dbc4205dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pivs+zKehkd1tzqGWbokws36NVLHUUDxwMv2wTxikmxd62NXH0oCOrdxc4qUrNZBmtfQBfa/qbrDgqSmg0TH/9eVfKKFrSUSX0pS4nJzPMaAImnHRziPZiZW2qDTL0xjirMcElN8rXc6DkSUMLh2yJRueOjL+1UMdK4BilomXZ7bfTtBU225MvA9a1OVWoNj1t6cDRzC0UHEU53mmZ6Y5jMawcf2uM80c9iGdZgyZoC3HBJr2PQeQXIVkykPgPyfljPszXdtx2AGgry5ZDaCuK5MLO3F3KCYuoWCHbunk1h1IXBaox2mS5Np8OP0Sfj3LwEsTb4VdAKY0Yx1OMoVegUqy9e6LqIsl5iHVud4xwmO6phqC9+/DhxwI20QCFUjiynhO+8wGxxoaIPv1eDgKgceAOuYu6MEhQq7ZMWbbnEX05gRh/SF58hylPfO9SzpOTn4VWUQaEApcstB7tum/lsiCwG14rS/l1TT6VhyM3lfmAYDAqG5jIUPEZ2EOia5na49Bf/fasdpMxbamMVH4bD2wh6fM/It/bawbGKCKrYUQ0DD5JTJJL/VnEsNf3Ln5LpO3RRhtvzieebkuaShPpkRurA1h7/y12qcYy4242Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(38350700002)(86362001)(8676002)(66476007)(2616005)(1076003)(41300700001)(52116002)(8936002)(4326008)(66556008)(5660300002)(7416002)(2906002)(6486002)(83380400001)(966005)(6666004)(478600001)(6506007)(6512007)(316002)(26005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?481QoYSKVdnGpuPDP41PTKccTDWBnQvbE/OlgWGv5uK0iNZAl5PVjOL3fH35?=
 =?us-ascii?Q?tw+bi70Fr88irkbefKQlIeaG10sxYBbnD9Xt+/jGl9ln3byd22S+3QTls+R4?=
 =?us-ascii?Q?ZSqkoou9DE1kMkB8m6O1nsST8grALB2Cn/g+2AExXuOdaN4IiN2XAuJt1+Ie?=
 =?us-ascii?Q?Fzf+cl8cEvlNhJ17QYEEEh9Vwc0ifXYYGA1l0otl8WySpLRebMvnuEAZpNR+?=
 =?us-ascii?Q?n24yhDXooQ8f2q36JXe655qrjn+MRPObsWF+dZBmW5F2lJxOSvZ7PpI/v1vd?=
 =?us-ascii?Q?Rc1vWnehPIwfFJd37070xCFJuZrIApeYjupxP8SsBQXu3PmOyZELTTcZ7yV6?=
 =?us-ascii?Q?wZBmlCbkeV9xh4qPegKnHgaRtyhronj3Sa9K60TRWvHO/YQCpZW2m9dceUk3?=
 =?us-ascii?Q?TgCzjBtMh8ktQQ7G5C2GwS5lpmYJN0M0sWNvGS6KxsGNe001GNSIDCjf1rPd?=
 =?us-ascii?Q?FOBbfZ0iwSG+yCFHKFsMgqGOq3rGduik1masZM5XvNbJ3/+b874G+VmMtXTh?=
 =?us-ascii?Q?QOW37eBa+EkYZ5FnJ1xoBjeVsxBgE88s0+PmgvUuLl1OwnHAGuzQgbaMsBRd?=
 =?us-ascii?Q?LRn33/rwTOk1abHU11pD1/xSq7KJJTS+NuROpBrTp7OtlwrurdvxpxfgIzu2?=
 =?us-ascii?Q?cTmTXbdyAM8LY1A51qo5Y3LAl8guedKZxZ9vhIUBkaTEpt6gN5jJwooWLDj6?=
 =?us-ascii?Q?fLRrvv0CaCkllgX4VdeauzmQthCXXHynM8XvqC85uPQAeL3Ok8XD8UuAUujj?=
 =?us-ascii?Q?NaQEIIoHFotl6UGoQUcAniC/EZ/hi4mhT3XkqsZymjf/GXbn0OINE30CtykQ?=
 =?us-ascii?Q?JgQ7MyZOaRoijryr9GDmKcIKBwEjFG6mp1kL1qTyEmf1wE2sY6iRg9NLKZwS?=
 =?us-ascii?Q?T/Yyo1hW+lbOLgZUVMbFspANkdWO+oDZZDqtf0Yk5O/gGDlV1g/PZHs3sMA2?=
 =?us-ascii?Q?ON92Lh6BnErOkm4XIlJjuVOTanf3TBRXH6r/76c9ZLLERu11hQEhFQjOHLDk?=
 =?us-ascii?Q?7yibBRBhsqWj3ALZ+yY5HuXjUCb7NECe+NHB8Mp6I3C87SHOvFBF7rjd1T1+?=
 =?us-ascii?Q?BPM4rRefoQF4lmtrci5gC9VjUar95SIKSYHz2gm/J+tpsZ5OZzpeSZ1OwGt4?=
 =?us-ascii?Q?xCuy1FFPVL3UOw2wRalvPUxJ2c7DMoqfU3RLKUZhIu8Z89v+tkvQhcGUd+wj?=
 =?us-ascii?Q?sN1yoVWiO0QlPznXX6pUFxrao5G8mQJa8f8dMW/WeoqjI5i2KHCWZbVahAx5?=
 =?us-ascii?Q?c38L2S9Xc8F3iRxAZSBTw9MPvJD5XtDWckTzdzpy2ZvWC6VY0A9GjqeAticR?=
 =?us-ascii?Q?snjxF8YC4mVPyrtFtf7zPKLp1WOJBOlo3YTYCpnhIpsHETHRIYplmOW2BlTi?=
 =?us-ascii?Q?csl8ZqZ48kjWPFsHh5Mbp5GnRkbnLl0LiuHnunHwwfCtH2rLGl0woW+zZN/Z?=
 =?us-ascii?Q?Vur5Ugkna98Ci16TG/yI4CFT8EJlrqGEiKOyp+JxnbOIB/wou3xgeX2oFL0x?=
 =?us-ascii?Q?2TjUl6JeULlwYA5cHEdx3rnO5eFnx0WO1FnLS84Ki9ztzP91woeIQJmHyC1g?=
 =?us-ascii?Q?5YpSyG27u/Sok50w5obwoFpAhL3/yEKiw7h+okv9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda9827-463e-475e-3ffb-08dbc4205dc7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:52:29.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trnig0xbYtnhn7mOLxAXAnQaAxG/5gzlxaKcDdN38IIRi83nb6kwNzFmAgDIclgKTUVZSNqLPIoSO2OKW6O9Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change from v5 to v6
- Use case 0 and case sizeof(u32) instead of default

Change from v4 to v5
- There are still some discussion about 64bit register access.
  Drop 64 register support and use sperate patch to enable 64bit register
support in future.

Change from v3 to v4
- Fix build warning

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210500.owiirl4c-lkp@intel.com/

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
  debugfs_create_regset32() support 8/16 bit width registers
  dmaengine: fsl-emda: add debugfs support
  dmaengine: fsl-edma: add trace event support

 drivers/dma/Makefile           |   7 +-
 drivers/dma/fsl-edma-common.c  |   2 +
 drivers/dma/fsl-edma-common.h  |  37 +++++-
 drivers/dma/fsl-edma-debugfs.c | 200 +++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 drivers/dma/fsl-edma-trace.c   |   4 +
 drivers/dma/fsl-edma-trace.h   | 134 ++++++++++++++++++++++
 fs/debugfs/file.c              |  54 ++++++---
 include/linux/debugfs.h        |  17 ++-
 9 files changed, 429 insertions(+), 28 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-debugfs.c
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

-- 
2.34.1

