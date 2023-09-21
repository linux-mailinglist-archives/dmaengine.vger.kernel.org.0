Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38A27AA599
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 01:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjIUXZ2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 19:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIUXZX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 19:25:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B6E51034;
        Thu, 21 Sep 2023 10:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh5sqX0DP2a/gKnf/IO7Bl5SbqKHxuehyMkn/7aYz0iBfmljOLXXTziD0QBhqhyD0w3eZ9NVNkTcLrC2aGcP2ogf9RvK1TiyBGMR7Foupnz7skOT5YZUd5wzBkP0OCElSYvN1ps5SXIAo2Jm+FADbmrF4HDvvVnqmJKANajZQja1jWDNULjfkgxqgS9su6XfFE4hmNSM0P6rTuvRz47LFyRL9DxzwstvBPfbpaIb2FWQFh/Rby7iC1divZkgr6ZWXl30tzwhIStzmI/2cHDDz8MP0c2nqdhZV9oNZBra5RWbMNVpEBHBuAAluPHD+3VTfo7C3e9tDyUMc1ehrQvg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5+nyBqOuiKd21uZrsI7Zja02O0/o1Y0SbWzwc5LOqs=;
 b=XKSkchTWbI0VU9v2dNVLYYpmBMkpWYex+cIBPtuxgbbFdU2akZRwnZrKTMhY32QtY438r9ssRr1mY0sfEJ9IvusySdR0bNmYLpp//EQqOk8teFljcXhKq2wIiN+1g6LBhpU/XRLGrhVLOLXcFZFGdujyMjZTLpkRifTLH7s31yIjomwxei/xjxtiTdIT3G35lqidiiUGqMcGbz1hl6dS+nHsPheth5vL6Cs+30VbKIHmk1DQUS+RByn1x30LqiXjWy8KsrmO2AEXeWy5waqLKjynzxxa5oSE16Q7h0YDbtlun5eXcSOdFHPML2mp4l0Wj6SCEahQAVbaV2Ux6kZWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5+nyBqOuiKd21uZrsI7Zja02O0/o1Y0SbWzwc5LOqs=;
 b=L+Rx6DNtpG/GQsjOOY+vIdvuvrXPDC0nJY5jwlwRuhFZLEJIvB8Ch5XcH0x2eRsaq+mnCpOlB0bmjDTp6sorawCy3jEW5RRnhIKUu7hpbJPSGpTxumg5zzuPK9ED1QgPnSeopl+yz1aiJuHBQcVrIIXU000tDef1Q5tONgGnxww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 15:02:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:02:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     dmaengine@vger.kernel.org, gregkh@linuxfoundation.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org, vkoul@kernel.org
Subject: [PATCH v4 0/3] dmaengine: fsl_edma: add trace and debugfs support
Date:   Thu, 21 Sep 2023 11:01:41 -0400
Message-Id: <20230921150144.3260231-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8b3a14-b01f-4197-40b5-08dbbab3b7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA/7K/ooT45IYyz87fVENOZaPjLPqfMDqG2BO4kQYt1w9J0W7XqdTToPNnk9CGSS72h8h7WZFI3uwVWi59VHXrBfGZ8cd3ImO+gVcJnCOPnP9fSDIYdZgEw5gezYD86ni8b/jQrQLbckiaQ0KEfxnoGQKKoenD2h1NS5DalNPlBDUFTb9a50Q70dhsThwbzgvpel0+MOeH4RtxC0Hgarlv4x8pXgyDCudrJlPK8giYoo7qvLaz/qZFtLmSX+7LsJw+URNQ2rkgIuUo2D1Aj41IFtlj6oixrQooPBCBFtvM5bRZmJlkcFExK/k3At35WZBlhtofcf/sSEs9qbVyycAyjevHe3M1m4ycIiaP+LxoRj7PcJK5xs7XDnlHhoCV2JwtOsKE39uqTc+DK0QSgiSxdLjXSAvLfZSVu11MHq7lN/2kcOxK5imzsOBAc7SV+6TIFbuVmxAYflA/DVdweeBkbTRu79W8LxhRYcFCnxWJJCkONVqHEgcjYaOcwktCwAEn8F9jib4Qvt/+KiFCgYQZoGu7cAUSJ9Qq91IKGVxwXZeJ5FdV83ZPTucj5m6Dbhxt8OmE1Kj3k+Fe9oJjypwtrqu0lEb/3q1biauL8I4F0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(1800799009)(451199024)(186009)(6666004)(38100700002)(83380400001)(38350700002)(2616005)(1076003)(6512007)(41300700001)(86362001)(4326008)(2906002)(34206002)(8936002)(8676002)(5660300002)(6486002)(52116002)(66946007)(66556008)(66476007)(6506007)(37006003)(36756003)(316002)(26005)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWhQgfeG6HFooT9AxZUmPftAgBgti4iKJCcjGeUAKGjtSAiz2OF5ksrS7XFY?=
 =?us-ascii?Q?z9cP0e+PaEq6HYWahFwQwLJ1d6RaLHpDx4erHvIxOim/rilt1hNreKIDAxCB?=
 =?us-ascii?Q?pmul3cl5t/pzyAp83scA+m1nbZhV6Rc0rwGMkwjprCYTO6vbetRAS8hMk2b3?=
 =?us-ascii?Q?xWScjUx3JtCQq4ulF/bzsU5NuCE/yAFr3XZcw/xNpT3WYoTD7/pxIVqLnvB+?=
 =?us-ascii?Q?PtXZfDV5D1L4q5UfjSZaccNn+tJft8RknGUxmJUDWLwfxnb9GwbxLIiEtzhP?=
 =?us-ascii?Q?0tnJLukThmaAzHHIjr2fXqI97kTn/p5qbnX7C/fSYoeyfxb9yXpZJQYiLJ5a?=
 =?us-ascii?Q?XRX90AZfarqqmlpRhPBsIeRADQ/Py6DejhcMf0F340fDCSAWrUutjdbgGSMp?=
 =?us-ascii?Q?C7gJ1wGmCL/WCVSicf0XtceGgR71mcqDGe0mxfLb+j+NVu52V8l7+Bh2zD3A?=
 =?us-ascii?Q?7794q9bUS3Vt+jOrcxx5AXShunKKVkTlWLmpJp8VUQ0yQfTKAcKb1J5xc18v?=
 =?us-ascii?Q?4qnY2E9pO9kiq2p55awk2N40uw3qRODvJlVubfAqH+CK+KS99N1Xc6N/kQmP?=
 =?us-ascii?Q?/Qx12rFLuPMs0XGcFnwa4pRHygcEz1zrJyZEIdkujxT8Fw4CrA3a8R9Jttka?=
 =?us-ascii?Q?fBlJ9tYENa5Tqa9A953KIl8L+REcjHRE3g711tzEJ77Z86fNdtjiILKd15/1?=
 =?us-ascii?Q?jYet+WQ2gkqxJ+Z8ufCFiiews6FoGQsKE8/yx4C4xsnqZHGikNO9Z9i9oAEu?=
 =?us-ascii?Q?+Am8dCCsLCZz4wt1w3wqrtrwv3ZUTHFaLul8MCMeD92V4DG2xD/08PBcSigF?=
 =?us-ascii?Q?7i0HhsSd4Pu7gnk3kiFqjVKj2JLleboL74F2dX+r+YqVkSPAVWKCeXhL/tXC?=
 =?us-ascii?Q?PZmaBlBpIn7OFGosjdF8qCnrGwBGGu+Udu0tigCc7k9Do5wvPOGGQtl0tU6D?=
 =?us-ascii?Q?NMqMvb+F03y0g+qDUU0QjQCMg7CI6XfdwEqVNhs7df3gZizBDwNW4L2771Lb?=
 =?us-ascii?Q?VHk3CbuovoxpK1xCLTbRwrt/i1D4Pzpo1wZFyhtck2v4F+RGuEyFERJj+9ju?=
 =?us-ascii?Q?ufUpQ+O/9YvSIFyqZJfGZ+sEZqF5nYPshWrD1ny5EtahNGlpS7+K6ipAFvUr?=
 =?us-ascii?Q?QkN6MjAiojBuhWguXrwn0wqWgMcX69mHTjrzpPiEQiioq4S263b06SGeLhwF?=
 =?us-ascii?Q?75HHOk0wMQShJBuKIGlfpS+/W2lP21mxTwGkdOBFKPv/0SF1ScFrIZPqBCuK?=
 =?us-ascii?Q?NCdiL03oPgi/r86pO3vcXHi7R8ZMa3Lfvs16ep/tNa6DG5eccd1Zl9inBQAQ?=
 =?us-ascii?Q?jj0dGI4onWb+kvCf1j1RpKRbJauVShV/G2RMLHX+wBI9XJwSIvm0zZo2H0Qn?=
 =?us-ascii?Q?KF/LQG+UVS3BUn6MIDZ327cJ7jTJNYp4w3ywwZdSfiVX2j1WJZ5b5d97bJZR?=
 =?us-ascii?Q?zolR5RcBzH1EcvukQBxNlgqOd8IL3tRkQy7OgsQVnIXl9RALQOT31+OI2VH8?=
 =?us-ascii?Q?C0BQZamtwgiNefMum3yW7/BwgsfL24Vc1MvEF50RJBTeyYqJ7VY3+79RzTrj?=
 =?us-ascii?Q?wXxaSESdQl1lfoq5UH9vfNU0zo6bka4SR5wPprdZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8b3a14-b01f-4197-40b5-08dbbab3b7f3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 15:02:05.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdJKeOfStOKQMxttTfAOMtCKiWBI0EdzLwS6vYyPON3GBuFpUZZ88Szv2O6wY5EAsLpzjFRFNylJLCKO+Xfdsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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

