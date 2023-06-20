Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9717375BA
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjFTUM4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFTUMq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:12:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24161731;
        Tue, 20 Jun 2023 13:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIxQk4cJKHhr66QmbHDYSkahxxJ4jlTPZeb6QLImbe0NPrs9NcVqY16GZqnKCXobI3GnfMh7sI/5iyNwobYZLyINK/276kinVUVxPQNGTsOw41C6QlxnkihLUIU6RiDv6UJl67MRU5zU7oU3z82ADqequsTcnVI2PdNyt7vrKQfacNq+McLAmvIwHGEKOmf+3icm9vbfq/wts6Pgb25mMIt/J8KLGK6H/9O+1MmXZYapbsgy6R5VusoWuuJk+f2Ww3aC3eQoQUXTmBRd45mxw/LktlQd8cFaXS9AON2vD+ocRR+LioQgt50Eg/5ZOXOcE5yV6bcqcND68uPnNIyu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PiQca/rhXI4tmiaMBYojKL4cq8Esjj9EehlE5LYftI=;
 b=KmIId6WcMcD/xSlrx2QK7wEFaK8jYrMkBap1O5GsGHtwxySwetUxqfxPxalxSJUoDU1wedJ5qf9a6i3BnTk8gQpGfYmGEgogYRKoRhMhB4GR/H7D+Gs7cjWk5zIuOYf8G2bWVcQa3MxYdUa1DxNP+iueOggQVwi34kpvgCKypiHu8Dum7z9EapHb5mYboXlH121TAM/OvXqP8mefvuq8NJovVtMeOHEC7bJYQ1qI+h1YYCMosmScP0mRVRhk5rx0RK6DUg3eglXCkBpb13D6Z2270ta0t4W4zrhWcAujMTZ3iIGsLxiZmmZxeWfjv8La/lB/LJkqdUgd9XPWT2BUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PiQca/rhXI4tmiaMBYojKL4cq8Esjj9EehlE5LYftI=;
 b=ShHVJcQUdo5hEgGtzeiZOHPXiio9bBlrBuGgnH9vMt3IHkdAgvfOROxthiETgp23EM+tGYMAomS8TW+2TWqJoMaFSD6u00OZYPRjW8cENF/vSejTGSmJis512Xa9EGEzyEz7CLIA0ewgq/YTXUUrZ5RokaE1ugd1zRxJ6bKC13E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 01/13] dmaengine: fsl-edma: fix build error when arch is s390
Date:   Tue, 20 Jun 2023 16:12:09 -0400
Message-Id: <20230620201221.2580428-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aa7b8b-497c-4a7a-142f-08db71cab2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0rX1QPs005Pxe6yUhUOSMc7ImXWB6QwoFkNO4aOzxNziu8G4I9tUMnaTZ1YB+iK36TXV7U/sMfyz53W+uIJi7VVOyS+uY3ltm/sEBOwhE9Z4KxuQ0IV6F8CCu6LCzJ8fm7snZ+CyVXsFokb/mqyaPUhvyZH4ZiJE0L7y6aUD+TAUQEqSb4FRdt/Ed1+oBF5yOGjN8AJmnAcqt4XjO1sdLTHXk0HEmYPmnDCWfhiCLxHwTbGk6bV7I3QQ/EdNUr7NRIE46km09KvSHz6vPQLtL/mbFlP5SpsK4IJ9k8riFvIWhK4NNllT6vQ1qFOmT9QU1AN764e2hzL/9NGw8VWESolm311WlVvb4f4FAIgkZksuIGcofqyXOtz6L06AwegopkZsCtX3Kqh4G46pAVn2rs74WDuUHuce2JKOmf58Bw21274o3RVbXEIaYoncfK/1S+bLd6vp1ruqmD+8iCqjb68zMFuGRbpm/F4T9J/dXUsLGazQ7mK4Cr8va35ioTdlrRPKUYhqOOXeFQXc48LxgjiM4Q5I6rs+z3rLjVKng+3nv06GYQSVHnp44NVHNYOhNCepiRYXRP3sVTdBPFeJoeqRzbbf+mDGHX3brxky91ngfUl4upgm/uowkM41/GK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(4744005)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(966005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZj5hnw7Y6QuGEeW3Gwc5tONjarFdZpVzjuWe96r6522Kdu3y43Gic8O2Hn1?=
 =?us-ascii?Q?RBowavKTpCMFSlDk09MznvanLYyn+g/Ysh2iF7Mnu7EuuxNM0nKo7Il5BujP?=
 =?us-ascii?Q?gSmVlabl+o2ymlMxMGzX0F8e4g3l0p3DoXP9WTnPIJxZZCWvul7gupUHVoOa?=
 =?us-ascii?Q?64JmqfkgwJFjShldgpzB1nD5W4vx1YFvp66CKPCx/xH7FrtIap4aMLb+wVOS?=
 =?us-ascii?Q?5GBOdM9aefbEBQtJGTJYMOkLxOCgo2OSWt95hJHCnmz1hsimZCR95Bt0HWLW?=
 =?us-ascii?Q?l1cCOyypI1zxLkQYS4y30gHgtmJqDd0YV8gAvK2q59UBamHhJDuHdHXnPFk0?=
 =?us-ascii?Q?a6rZD+G3LJaFbTeVZotZjp4o75eblmMMVxkAJGXOeNKqAGwdEeA0bj/46jHv?=
 =?us-ascii?Q?lZYZvDBL6/opK/AZs8u7OpJto3fFbgWzga/ShVU4en1xOKZ448fIWFC3zUpG?=
 =?us-ascii?Q?bhE7UYvC8mxEWMlvOuNja7YgXB2wLQnwCWn6cOJLhEHqQBd+sgN7bVonMQsj?=
 =?us-ascii?Q?h+mUMyG7z8kE5qKLoE4YGqHAkveySVIN4hs5L5nRRcHva9tkjIkctR1vZ2OV?=
 =?us-ascii?Q?w8K7OpbYQmTWxf+AFig4bDzmMny3PZXZFLzuxe7kHQ7oHEF0taUdyHoTZn+b?=
 =?us-ascii?Q?urtIcunmNWIfKsIUFSMEwu79AyAYvwYJMH5yOgfO3Ng1OBoxHMS7NkIUu7jA?=
 =?us-ascii?Q?0mIlzldpr42RQByysThNPrFLzDcwyCwW006gZ57GHjQIJ/JKkLEV1VtdyIBI?=
 =?us-ascii?Q?SXrsHTFuRukdIavf6Xh6G1zUad3rgEDQIEPwfaswBll/f4MF2GE1fu2z5nSd?=
 =?us-ascii?Q?FgBWjeybTzV/DB0CRF3Dx0D04ltIqwhTR3MQ+psFgCIwbZTH9JMf5hVLuJFs?=
 =?us-ascii?Q?9xCMMu3ar/bD1o94I1d2SiLbLZQAgfGNMleSFdv2mOEkgRgIhh7n47YRZTen?=
 =?us-ascii?Q?Mg0HB8/SPbJGtJ7xAeO6NjX9h6F5xQbqLo0/AT0XWVEj/sTBNItFEB3XWUGW?=
 =?us-ascii?Q?9ZH3Iv8QR4uWZ2OMdVeWZa0/qqVH1p1ME4FLdW7c88Dl0UQDY+Oy9Nzk8F5J?=
 =?us-ascii?Q?nKmjb4ReOhue9TPKGO4gMiwz+DgRwD5n7pyovL3nGL47Z6GTGnaT4i0vWIf0?=
 =?us-ascii?Q?L6kyWHvLvHhHH+s76iq0oa2tBasAO/b/hgLONvb0XtwqKrXcMxIEmsIgJrwU?=
 =?us-ascii?Q?eH82QM5cm+PBPBaSEQn4lVs7lkiOvE3pNr0CexaN9TdOES3wKAkjo4ZpMhhk?=
 =?us-ascii?Q?0qVLhCFKbVtNJU4ZdjMvknD/i6HPjcx135tYDDH+Wb93b2A4DEqGd0f8mpNu?=
 =?us-ascii?Q?Vn4qh29EsBCE+9atR6lQ8xM4q+ItFxhp5hx+GpwvHP6Nwa26Z2IOx40dD/vY?=
 =?us-ascii?Q?KN4fA/N3otJRSTKm2GmeFQXp7adBxwanbFQ3VyEINDYglosXgvBM4xelk5Lz?=
 =?us-ascii?Q?rx3rKokoc3Fwi/gdMKAIi8qw3EKnTtULaZAdyb88+AVXOkGvXEllxqJ9ypxB?=
 =?us-ascii?Q?GlbWu0/kKHe6gkKg5U10OanNTMpzIg4nr3hqXdnXWhuJVhsg1ZR8xqbCBP7d?=
 =?us-ascii?Q?aWbybRKdJ6f+goEaKf3nnut2xHuIz/LZB3gK0dy5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aa7b8b-497c-4a7a-142f-08db71cab2ab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:40.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqNOE9QlAyE+NERVjc1DRPiG2vbOzHnDrOyo/Y/sV3wjErTwU7a6WlQHGJFobd+9Ni5SCYs6wMS/6J+SZYh7qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

fixed build error reported by kernel test robot.

>> s390-linux-ld: fsl-edma-main.c:(.text+0xf4c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306210131.zaHVasxz-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 644c188d6a11..c1065c444cde 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -210,7 +210,7 @@ config FSL_DMA
 
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
-	depends on OF
+	depends on ARCH_NXP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.34.1

