Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD87A67C2
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjISPO6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjISPO5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 11:14:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E44EA;
        Tue, 19 Sep 2023 08:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdrVIdu21rnGYo8g5qd2KmjKtpGWlixa92ahxFj33jNYBxcU8DibKx7a1/OlovW1G6zbBL76kX29588DgBQVyvvkKsXbLyiCVg6rYfZ3H8wLgVfgX6JISKdYNnBTKKOW2NMo+j4syVUoyhy1Slg5GdBgMPAD62ERrhy4nPZ6xQUVVJdgON+0XsEtzrvXnJq+1ZK75iIxhEXWYwbJS5xUnOv5+mMGLgtgsyt0FKH7fI8EAVdBpJZtG1Hp/SWIBs72BUvftg/jvwEdClHLAYN8bEqbXjk3JXLRqluL4pDtMAj/xvqyMgiMa1Bi8j1lYEDh07YSz6km57/t+0jN6XGsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIj/8lMdi3AihxzEkrx82HQCCHbMv8G96ybKBbI7jNM=;
 b=Y0akuUBOMPestA3LkXKyhHkt6Kot8SUiBspWu02FXPjBDH/kOdK0a6mVcMoyKMINgcL9SYboX8mXeacTT/lQ9RV8HjzUGhjoJA2eSkDfe+mDqDv+ByTgutCdAPjJVZXA3a5nlbeCl1Cuu/DqgIbdhiaMMdi/dr8roh0Q725Swb9OfmI1c6hXnY7eP5/rbuNXaY9TWDSLeVF48i81D02k9HW8c1FsN4YbDGzc0triQN2pTNfARpwGYDi70s1elHP3eAX5TS43suUtEB9OEimWjaZ/w52mkEfr5IUPHANXd4VO0gycNBOFP0Tq1GlKssQ+o+NgdxJrgFNFq/UeKuinJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIj/8lMdi3AihxzEkrx82HQCCHbMv8G96ybKBbI7jNM=;
 b=Wx4Sl+nRy9BcLGH3ZBOHgCHYAde4Nv2YG7jrtn/kVPbvORI5N3G3pPlGqAVmOWu7R5NdM78F3dmvAss+Pzle5HwZ34Xc2HUv/yHed6BqL74zHkwZiUoIOWx8cWomhisAIUgmC4E/jpHzA1ki/juwrHJlWGpf/CE/O1zhZDS57ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:14:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:14:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v2 0/2] dmaengine: fsl_edma: add trace and debugfs support
Date:   Tue, 19 Sep 2023 11:14:28 -0400
Message-Id: <20230919151430.2919042-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fa1259-9190-4368-0a45-08dbb9232a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVmFAfnrERPXn9/rFdTFa818Z2i35jiQ9NJ9gijG3CFKH6KvSPelaJjnQiaD/RQgd2KMLf8Rm48eDUPPZfKQSLjuPItpgnXNUC7zTyWtl1Myx2eUbLuRHbUlCw10MYe9tV2Ks+3oTEx2Tg8SndD8aEv0Yg6EsxF2HW/siuqa66fwE2BeIpbZhpSM8Zcy/ySQK37JKzUWvHaZ+/0CYfTmCvdM6jcCOu26Je/dSwAnRiTrfb5f0reIIU0d/tKe+ouZBd5oUjV2JgaHp/73oIHTdpyo3ONU025T1xp6PwW0u3oitSrtUW+BdXLsXbsGSNaNaJcBferrzX/gPXBtukfafOghUWzU763R+wNnFc3KRV/E/C0+4prT359xJg4tnhV3Vd1Fe+ozqTwe6dL1WPkOZIg7cxm1ZB+J5ZhKDZ+/PO1VDIEQp2tQXpxPoebkXIwm81bAUkP/U1bJXXDUIPqv7iElHgd0GfpIynaamdI9CweKuuwvn2Phh2lmxPkGiE9V+f1iPtiOb83U+jEqQZJU+2DY8f3E3yiOQR93VO916sgX892D5pgXvoCJCx2mYo2nOSM+4pRk+010YJ5kXz/f/jWpI60s8nLAcHS0I3Gg5MiSeaHNnGsiyIog0q1qfL/l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(5660300002)(8676002)(8936002)(1076003)(41300700001)(316002)(66556008)(66476007)(66946007)(478600001)(6666004)(52116002)(6506007)(6486002)(2616005)(26005)(83380400001)(6512007)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WmsYYlw//FoJNwAxTM44+A4dSbF5w1kfjsvAATSIhXtpFAxILOfELRNPeQwM?=
 =?us-ascii?Q?Su02Ede0xwErXG27YFt/5+pbgmy07M17uJ/UWHavYN8O/+artkGtgV+QEjuY?=
 =?us-ascii?Q?H1Ocv3BxFECJPbf+ss62igMQNuE0fYtuhwwuswIMlaXd3I3uzs0WKN727yNt?=
 =?us-ascii?Q?ImU7vnijV8HEVEwBN33mz+LvZKOE8isNEq6fLBo8X41pM9L3YJ848f+0FNw0?=
 =?us-ascii?Q?6U1tJbevdkbqSolGMNcwKpDafa/rGs/48cboXgGqQpx4NjgdUPElRn49Dn7M?=
 =?us-ascii?Q?5jdyUmlZZsVZ04ZogJb6nube1XcTrcv1vYiwOVUGWRdnve6PEm1Lgn0pvDL3?=
 =?us-ascii?Q?Ywq2Lo4rxf1xoVkSl6lgqGJxn9ams5x9thuCHg2uMOAz1dQGcMin/70jP26L?=
 =?us-ascii?Q?etAONLUApaEExX3jH89DiZ3jGI2QK9jw5A96QIcaP6KiaE3ExWwEVduThsoT?=
 =?us-ascii?Q?lF9a9c2K2epjG95IEHjwDpWEYrsjmRtTJl9/l+mdVE+XeMYn3g/54KDXNiKq?=
 =?us-ascii?Q?KgfhQ0aYB12WZC9ecY3sMXyrtsqrvMXWghvTBAOHcZBRPECBpI6nfnUFhnW9?=
 =?us-ascii?Q?XG5hfbb6XcP9c1ix/3RtIilGNAlHkAk1tU/WUmRzVUMrJwCrbRgwvFIqrLtD?=
 =?us-ascii?Q?nkzbbjCFpArgwaIx833SWqxf3UC/WVysKo/xScyRjc6zuYeJUqGGPIZRA1Ii?=
 =?us-ascii?Q?RVxms2RvDgJ/ngG+EE01bK2Reo653y0nsaR59goqZAP5RQJHSLGK1OTLsJ4l?=
 =?us-ascii?Q?cw6XuXSOi0ODFVXfFrVf4ATUaaSeVs2OtJSc6RgeIKIKlsXF0YNnXlW+UXBu?=
 =?us-ascii?Q?yM0IDqq6Jaky8jOQsLafgQpYne2CcnVZDCwo4ZtyC8LE8HRV5CIbwuJUKhQA?=
 =?us-ascii?Q?xiPf2yf9YF7Zlt0tKpJAwV8zCxD2j0uJQWSeh0lN6q6sjfLchSIzS08P52x9?=
 =?us-ascii?Q?X3VH3gsKwlw4MhpXbeSigVKn9fpv3R3YDoGU7vmLMi/itGq8idH4EipKxFMO?=
 =?us-ascii?Q?p/JVsjsweiPPfJbK/EboNt8/PebXQYT4yWgHwacBPyMo8ii6eX7XWlXspf9c?=
 =?us-ascii?Q?8yfuVhbZz2p6/2N9dwvpdPSsvJAz+3S0dr/fw0verLOrKS7jQxe4b/vSfX0u?=
 =?us-ascii?Q?FhTSP5PjkyuomNYVlyOZ3QQlsDaUIRW3yOZL1c/J7BoFWVvNVpg3C7Jd/zmQ?=
 =?us-ascii?Q?v/7pLwehigJBdCKXoXU22seuqyLFflTCJJYfsn7GRvHcXUsi0jygYTNfoDhH?=
 =?us-ascii?Q?yUo4jxHupvrRP7PILBtUXXWcLEHlrpIKKwsMwswFf7E8R6I5OxakyhIK9yIo?=
 =?us-ascii?Q?cyDG0Va672daigbgO3rWqugdKwe5XkaOXEBvV7iIQ0FXQGcbFkUuhKN/2drc?=
 =?us-ascii?Q?Gr03AospWqcGTSmx+GLDn6ZuNmktVKcOoKGA97IDqFvX+VSD/uBRFtBsS77l?=
 =?us-ascii?Q?pcnlphi3i6wIg1Y+FiHqPt6WCdLVBOd4Yqe9ajzsJ6aHIq934cKBxK9k4Ftk?=
 =?us-ascii?Q?HgPQAPGRUo8R68Xl/LoUU+84W/gFF65T83wGmbVJKxVYksQ0ar25URDft1cw?=
 =?us-ascii?Q?8Bt3yYd+TEwAhZfq56c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa1259-9190-4368-0a45-08dbb9232a71
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:14:49.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ166YtK8R6DbvSaj7s9loldny1nu43ffKVjZ3xz6qi87s6bOjYNBPiSWS+xZTc8EdInyX/uNBaSjpgkvKwS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change from v1 to v2
Fixed tcd trace issue, data need be saved firstly.

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
  dmaengine: fsl-emda: add debugfs support
  dmaengine: fsl-edma: add trace event support

 drivers/dma/Makefile           |   7 +-
 drivers/dma/fsl-edma-common.c  |   2 +
 drivers/dma/fsl-edma-common.h  |  37 ++++++++-
 drivers/dma/fsl-edma-debugfs.c | 116 ++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 drivers/dma/fsl-edma-trace.c   |   4 +
 drivers/dma/fsl-edma-trace.h   | 134 +++++++++++++++++++++++++++++++++
 7 files changed, 296 insertions(+), 6 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-debugfs.c
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

-- 
2.34.1

