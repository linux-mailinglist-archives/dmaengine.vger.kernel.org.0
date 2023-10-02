Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7507B5A63
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 20:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjJBSiT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjJBSiS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 14:38:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510FDAB;
        Mon,  2 Oct 2023 11:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeraK/+wyEjVKTQWo4DroImmWN5lD4syhKBG2GSDf+bCFqmT2PkkLkIFGLRRGl29XQPFo6mIInDwduUZdWsjbs5VR/qVrrtJlZmgjzqBy1JtUH3QboUeLJSOculLqh/+N0Ij5gx42GXc73M0v51CEq+WFypk3GPAVCWtcX9obEWrjVnyBdE+uT3ZvVhkPGGycCmopdTuD1KDFNjrm7hCnIPU4XtbeAIWzkDLro14Oi6n7y8xN+4a3tWyXlhWfBQMEc8IBIcwXo2/Wq/TMVZ1iraIIGVPLyTyaTuZlc7VE2BPHMY+H3y/xfMlsL7wnbhn+ZRkXQtuqs03xeuYS6azuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC2mgcIv6b4hQoVagsC+0nuvLjFRe3f/kYiGg9YYNcs=;
 b=iXnZFk+UMBgOUjkPy8bhxF9cKz/lYDSuZk9i9xxsva7+wJFArvur8gVcM+GHdlTn6eMu7V8NBUP+rys+bUZ1/lRNG/jFq5FpZfAMooKNGIHcjl9SGAobRQXkj631oK0kQrli4cp/TXFiA0ZYNdE4xnVVZeAFQw24o8DWOGpJFU8FOiRQslUK5KPIKpZdXgADL+Umj/NkNrgtPgcrqBLsSxK7mzSBW6wGoNKVx+FuYGhhhWzXUVl4i9vsINsmsZPIuf0J/CkVR6POyjyw5cRAqB+w4SZN5XKWk1XKcdmILbW8hsKm1IwljqZXnP8y8ScHihKpOkR6q3LZjq57W4M1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC2mgcIv6b4hQoVagsC+0nuvLjFRe3f/kYiGg9YYNcs=;
 b=oskeTVPumJU+Lk3Iu6uqRd746BJKayAXNKwSpPSqMmLHX7oZaZQ67POILX4OOy3Lp1GYG1C4q4hVDDsGVwqD2XzpTUuqVnwJM50VtWgf629Kf+WM3rLMQzQk6va2VatW2bc9rpvLTjejeJPugNxGZ1YeF2htvK9c2M5LuT8HsV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 18:38:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 18:38:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v5 0/3] dmaengine: fsl_edma: add trace and debugfs support
Date:   Mon,  2 Oct 2023 14:37:47 -0400
Message-Id: <20231002183750.552759-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d62ea1a-b2b6-4b1c-124d-08dbc376bbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ah7FOQ5NFudowORALoAsIn91qrMvtri3xH/yVxsSYyKU15vb9BU96OrozGwp5CwAi/3y+zYZfz6dRikbb1yMl5PraGi8khqOxCH3sc9cytgVtgixORBhGckpik3DCtsTcfXbIkIe6/9gsMRpB1GBOdz9csZAW//gO0eCubW73qL218WjxRbUvf6CNxrjbBQ6D9PdfC+Qb2Uh33i9HOLYZzyumVEkgagfiHU/xN3ER6w7OKb9wT6uemA4nqsGBpil/ZAm5OEIaMF2+/vVoYUdfrV6S3X2xJXa9Yeu2H5E/zlIEvsykb8pb60sBlsqAHg5QAcdk8/k+vNyKlvUcElWh2Si/wUjK8GshxU+ILK74qmKb/8wDN5Y6sQ+SE9B+eP4O6rGu/v1NOqrOLVBuLIKl3gPxqZLLKBpm4Rm4bbTicQwX2n+1F109dSHBE5RAkI0Icm3Sa/bpykjQ/mUgezn61XwADzEQXzX2SBrJ8pSr0GqYFjpELfKRoJCKfTG2/UT2nDocxrwAbzGQMYcRS9EVY3w01YgZjxcCEVA8LOKhWn56+pPD/ym4aa/oNV2WX+NePtbfL3PM4Ggq3Ig2WHYU59qA0jHrwYcA0Ns56XiAbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66556008)(6512007)(2906002)(66476007)(316002)(66946007)(7416002)(41300700001)(8676002)(4326008)(8936002)(478600001)(6666004)(6506007)(52116002)(5660300002)(38100700002)(26005)(1076003)(36756003)(38350700002)(966005)(6486002)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6QFIG0J5v2VfiW1X2NGBPod6vCjCCbZu4ULBq/2lwjKth7naHwvToaDMKRlr?=
 =?us-ascii?Q?EH/1Hx9ZXhEEyvlpU+U4aiSlioSpnsHhauLgjEHBLoaRo19PNnUeBSKFMmUW?=
 =?us-ascii?Q?wOAe+oEfH2bbFDRD9exK6OCuSSNeF/FnX/Ro4CLTh3Qhgz+YraSBwlN0F+bt?=
 =?us-ascii?Q?F7suDXKrf/U6cbObZHf+wskDM0UiFVXgWmvViVhym/SNtg1wr86iAuDb9Byi?=
 =?us-ascii?Q?SPHcxrxTn7E005eX3fOock72eW9UGfKKMra9M39GPHqPXI78IEki1uVhw0yS?=
 =?us-ascii?Q?Uvx4EC3rUBXYUOhXs6PAJJQWZ5IDhdHzzTi2E7FcxL/+gL+E2fXJVmChHp62?=
 =?us-ascii?Q?gfVMum7jUGdmM9wyquEHGs8Srb3+N+jFK2dLXI79HS4s+Qn9lg60CU+ff1xy?=
 =?us-ascii?Q?P2qbGgKQhjQ9Tp1a/HFCvxcARKsD/2keQeWoznXlsDJsrUq7vpcqAnFZuR0A?=
 =?us-ascii?Q?NOPqfLaiXs+i/6kkUmruNLvEsh/CzHsaYacRzRJPN42tWHn58RNKjAXtJiii?=
 =?us-ascii?Q?uxM6MJUnWzjB4M4FKMH8FXHiltBEIJuLdcb3Xdkv0mgrIdOnVFK9CPa1Vozk?=
 =?us-ascii?Q?SPzaFJCl8h28z9CZ0KCfWpeuh9Hhcs+GKFD4THLHZ8aPYq5Rhk2496ysoaKg?=
 =?us-ascii?Q?TJJ179p/zQopM7wCOpHA0RL/v8oglVQcH92zUQGs4W4ODLj4WIbfR6DTwHkI?=
 =?us-ascii?Q?YqT60n+w0JsKpr8ssjkaoJ4IVidrkUIfIE4/eLLGIWWsaidAhDTEWfaEK6s0?=
 =?us-ascii?Q?DDKmQdoycSmfUI9gwIayNSAk6qXJZTmzbkKnpkpI8kXlPLm6MD/UBM9vHsop?=
 =?us-ascii?Q?1isbJGwXQc0P6eTqocNhZqDEHakB6VaBXZCMoalgyZQjF7/HNZzcDZQl4BKp?=
 =?us-ascii?Q?2IAUQtN2ZaNKlykI+J+qftL142PEcykumyKxBYRq5fN5TNROnZ8Paa+NtnVg?=
 =?us-ascii?Q?1QgTUn8HD4h/NZIXO2Q08QZSkRVsF7ZQnJ9KEDO5+RE1x4Htytj7k0jZpPx1?=
 =?us-ascii?Q?trm52OquBpnAQ9HoXRL1tDZZ+6565ZaxgAbAisKtP6I+1ladQ6Pqf2Khvx0/?=
 =?us-ascii?Q?WmucqvlTc4GwIBlc5wr/SFqrbE5J22eQLJizKN1f5iz/A4rp1lhCH8oaLw9s?=
 =?us-ascii?Q?FIPl96jmfo67nEqw9GU3XopIGUGf389WYS4IHc65+RIi9b+Dof91F4eIvs+/?=
 =?us-ascii?Q?KVweOFhuQcjySc/MblOwGs4rGecKpTWeRaz4oFkCeFW090yenZp1izoR6Cwr?=
 =?us-ascii?Q?55S5E1z4Ip8684JkfwoC1JqG/JryeqknLjYozS7oZnnDdREX/1AlH/iToY/W?=
 =?us-ascii?Q?7V1RsJGYFQh8iU/jOebh6ZC56QFeSV/HsEyPmGwc7vos59XH/2Vz8ie3WOlI?=
 =?us-ascii?Q?sdSbcUppOGXZpA0HBNNJLUC20/GqdGXzHFcCIU0OQUhbwt494ty56glb0Cec?=
 =?us-ascii?Q?aC7coSmBjYd7xlYhNoiM8cja8wP63xQdtKuQvsk1e3lvtFV/x55NNg1ciCoX?=
 =?us-ascii?Q?kDn6q67gKel625EYTs5yit6Hp1Fyv1FQ3Zdo+7FMhSzG7qKTgOpWNtgN4DiH?=
 =?us-ascii?Q?TmXs9e4FJUcOtGtSJBzR9ebW7CLpO0FV8X/qYdlz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d62ea1a-b2b6-4b1c-124d-08dbc376bbb2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:38:12.6928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfE7y7avZ7t5myvjcFQS3MduOTW8kjIDXMgOfgI/AL34rN38Vot5vYAWWLCY8Kv5JAszIuDJZSBZKlnux2fwLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change from v3 to v5
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
 fs/debugfs/file.c              |  53 ++++++---
 include/linux/debugfs.h        |  17 ++-
 9 files changed, 428 insertions(+), 28 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-debugfs.c
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

-- 
2.34.1

