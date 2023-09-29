Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E3D7B381C
	for <lists+dmaengine@lfdr.de>; Fri, 29 Sep 2023 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjI2Qtp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Sep 2023 12:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2Qto (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Sep 2023 12:49:44 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F4ED6;
        Fri, 29 Sep 2023 09:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtAC0qX9O0ToZfgiOa1xI26/9GLb3pRe91Xuaf385Xo323spueJTYKcDgv2Z8St5hn8Agfof31E15HX4WzT8L43dJNZijkHtNbKgqpl3x0K4zFc+Px0Sq6gjmp2gy2PN13nqFsV4utucDjT6YJlDKuLzMDCZuxbqh/XEXqXdKJ+LgCdMOovTWml1fRSZPJL2a1cFIlKV3PKaZWmhyBaaHkFVafQsQgLYGXgEsPaYhbriMFfBJvRUo9INfQ5/Yv6Z+dojUueLfQerohCDwl3P6QNCshbVXe3UtsphF1gnv41IRWHquqQ+tV0XQN/h5y16y8+CRFXwjTOO6eO4MVHebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIGpldLgwWYVgcCVMxTDtuYuvJB1dM06tEydz3s2ssg=;
 b=AER7Hma2UaF9KTMyssCdTGv4xnIWCHU1pEvgbudP4Tmt5KIshhuejmoD0QBwSlwZ2oVPVizvnMy/R+ZQpl6a+puFWFyOC2CA96E1CnRxLzB0MNtD20W+K0Hh+/PKupYseGkVg8KT67NInZL3IJUdKOQJBoc4jbYGC3t3XM+0fyry9ZB8dJ2IMjGd7gsFyaaLdqa/MV3wn+b6aVQ+PXg9RhX+do2RXDt0Psu8Lb8o4Je83aPNE6vAbN09YCqwaTOhSy8A7MrkppeXVmfcP6vH0d0nWHKQbZU3dlFqx7EhRk2IYauosTmQcY0E0BvsuDPpwMhaLWO6HmJ8TMSJtVBtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIGpldLgwWYVgcCVMxTDtuYuvJB1dM06tEydz3s2ssg=;
 b=RBA+ECl6qapVsHH25L/Wmlr1vikOPYCB4+n4FvQJvNeUbI8miy6CRW+HNubqDKarAkYB4Rk9AaOk+N4y2qTqBdOwh/IQYMvl66UUMpNqwkKRY/IvEWRt7z6tc/J+OOww29gg6NqkBclbLhIuTnYKtlX/ZqsCq5ADdTLvgNeXPEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VE1PR04MB7278.eurprd04.prod.outlook.com (2603:10a6:800:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 16:49:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 16:49:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, bhe@redhat.com
Cc:     dmaengine@vger.kernel.org, frank.li@nxp.com,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH 1/1] fs: debugfs: fix build error at powerpc platform
Date:   Fri, 29 Sep 2023 12:49:20 -0400
Message-Id: <20230929164920.314849-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VE1PR04MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a2c8ad-5314-4f9e-3a9c-08dbc10c11a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTJUd6m+PIIghn1AoQtgVR9de2iHI9XL0n0WuADCdWv4jcpXhYjRTgkKeotSv7cQL44HR/fGRH6ek+yt4wHMTTAC8d5gVV4RQ3f+nZqax9BC16pY34tu0KB9Cv59sch//zpjRe65LgG/MhogS8tW9NXcqIpq+AFbaOZ2UJwvNchlJFW95tjAGzHkK+HaA4AKrjSBiO0yVxeVr4BFnDcarSUD5gwOu8Oz7vVSjeSZm/A3AHezrSXCDDUHwW1+tha18d4D+xIuTJI8UnkkXQzHgNHDLknUhVCMhlwQiZ7nwUYrFelaqj55Fmjpvvfuk00i/cdHXq8UXPZB61s4DcOlzszHVYSYT4lM9sTCs22wt5JfiPp0gk6h3gmGzbZrKs1PvDuczh4oEAYASb6Ot+0gMdo2Leega3Se2Bot9h0o9P7C8+ai5Nv9XWiQz2tg40qHuYmlveI7On+cW4iqIwwvAxp8Dvl4NjPR0uIn++8vA7xipWHwqhUMnxzqQO4EQ+exSikOBC1W4gvT45xPp0g1Cmh2wk92N32yr92LFyf07r3vYAVe2DPOe0Q7FhmGM78aDOkTferVXGtXRhg1IyAc3LRYL4nfHUc5+tuVb5JuL+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(2906002)(83380400001)(4326008)(2616005)(4744005)(8936002)(41300700001)(8676002)(36756003)(5660300002)(6506007)(1076003)(86362001)(316002)(6666004)(38100700002)(966005)(52116002)(66556008)(66476007)(66946007)(26005)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UU78yoG8N1XQrfvroGFHnz1jV5bWLONgvfZwFQvKvcrG7821VY5L5OMoLb96?=
 =?us-ascii?Q?AWsDu4NCS0uN0JgQ8m0GUO8RZmRQtf5hksjr5tjUKCiELtu53IVUzy5dNWFk?=
 =?us-ascii?Q?f3ofPQvLyTzgSKaGexKKPR4bHCHyHUaPSpMnK+dg7so3A/3jw49XBYs7rd3z?=
 =?us-ascii?Q?4dabkjz/a5gib6eH3KqTQH27O35jhFjeDjsYX4lDN/R+zwHtMzNhVQn8LstX?=
 =?us-ascii?Q?QaWfke1bXK7lzV4XZ3dakUc6dDvH/Q7/SSJVR4U/8YQ5uXErL+YVZssrb8Xc?=
 =?us-ascii?Q?uLsvJ/aVl4BCO1774+1Vxwgz33AXGcuAobGOevXUCF2M6Am55vmqO+60Oawj?=
 =?us-ascii?Q?34RyHRnW1U3aTW2Zpr9OsMlvaTGZZ9Rs78BWnTMIyFguAIUkTxYbgTPichK7?=
 =?us-ascii?Q?TQ0abDyT2c826ykIiPsEI6p4O5fBcc1KInL6PSD5qqTIuvPW4ekX01QUnIxp?=
 =?us-ascii?Q?tBUAPNc7eWOlWLQYxhpMJMqWkCyaJxRr1o1bT5Z7I4IIwMPW4/nMdTHLxVxj?=
 =?us-ascii?Q?ZRaLd/xytnec80IJWLYoEWBzCbHzUTlm3mOw3OOF0ZuGHm2dc4GD2YBs+WxN?=
 =?us-ascii?Q?4EEqYcuYATHu5Hfng+de0sXsFzr7CPT7u7cxPUaNoCMpTIzAP9ojtkiHjwd2?=
 =?us-ascii?Q?Xd/RXFYVCBVZMWiNaH0/gSEPITaffQ1KP4vCud+lFPOP0AhNE/wksoEZa7ar?=
 =?us-ascii?Q?nZHrFHJAF3k8+DH4lIcqLDnu0PEaEaTnBFyPdIyh1l8G7/AEiWesAYU6mjBD?=
 =?us-ascii?Q?b8rj5kaF9BLZ1/LyHAEbaIARQrAs+QCia6KrR04Ae69QbgYjnjw4DS7Xjujw?=
 =?us-ascii?Q?3PscNp8H5k6kPPyYUJ5YVX90RxErDNGAgn9/4JWmEFJvgNufM2DB2azYh+lX?=
 =?us-ascii?Q?qcCTbkNLHsMJKepkdrW9lMhG19Qw7Q1ju6WG0PwJg5C3adK/afErXWTa/NHf?=
 =?us-ascii?Q?j58pZ+xa7m59as47frPNf5BG3ppiDNS5pJ2lqbAfv0K3wvSrTCs+lppT1tit?=
 =?us-ascii?Q?Jd3pbw9xmc3K6QCXPNbUuZFKsTr5M+dJcBoWoMfJzRbfHN9VGgoMElA6jECL?=
 =?us-ascii?Q?BVNFs1w32LNx5H7uoXUIdRuk4X/wjecZVI5og2NV3KuEYYeSaPAUfiWUJttT?=
 =?us-ascii?Q?eJ1YjYRmY27jB/6GIR/X4XZ5pHI0d0DY+RnCQ3ELQyqsZse6j0ZAoSpdh5IR?=
 =?us-ascii?Q?m3qd3X4s12hVGdwY8vDA9OEISEAmcXjc4T1I6QL4Pj6R4CIW6tp/EoLOoUZ9?=
 =?us-ascii?Q?Rcd0/BrNJpIfOYVtPVHf1bgeHySrXUCiE2xp2CSJ+QkV1NklP2XpMUmhWZzN?=
 =?us-ascii?Q?tIwbFu20HF1AZIz+Lb8HYaF9yt2NvD6j71MIrmJmo891H1ddSZYC+M5iKChv?=
 =?us-ascii?Q?Qg0wrkJ6+tbX0OuRAv4qhXSmRv6de7H9XKCiEE0Iv2VBEMTK9kFjV8P33T5Y?=
 =?us-ascii?Q?LnJrACo8u+7D1IhU1pChSrYjg6Oiwh3rqBbn0DfXPuLCARRoTpa9FlPsV/y7?=
 =?us-ascii?Q?osHfxsKrfKCb7kPb1azsKIeNvqh5sA7mYXVQpw6qszms5L1S3CmycU+lESqj?=
 =?us-ascii?Q?BraA2TQkIf04wo7k2bw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a2c8ad-5314-4f9e-3a9c-08dbc10c11a2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:49:38.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dn90hgNVHaAUbrYuZtelgweixDwN648ZhuKUoYGnWpVY5KAP+9lY/4IlNezsP5JIA/MB45lhqruUCbYxRG1HFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7278
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

   ld: fs/debugfs/file.o: in function `debugfs_print_regs':
   file.c:(.text+0x95a): undefined reference to `ioread64be'
>> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309291322.3pZiyosI-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 5b8d4fd7c747..b406283806d9 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1179,7 +1179,7 @@ void debugfs_print_regs(struct seq_file *s, const struct debugfs_reg *regs,
 			seq_printf(s, "%s = 0x%04x\n", regs->name,
 				  b ? ioread16be(reg) : ioread16(reg));
 			break;
-#ifdef CONFIG_64BIT
+#if defined(ioread64) && defined (ioread64be)
 		case sizeof(u64):
 			seq_printf(s, "%s = 0x%016llx\n", regs->name,
 				   b ? ioread64be(reg) : ioread64(reg));
-- 
2.34.1

