Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426BE782E11
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjHUQQo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjHUQQn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:16:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F31E4;
        Mon, 21 Aug 2023 09:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/EogkJFDNDsDmxA3/HLICnJPnRFnE/uiVk+t4yGCMP70VXsvAW5T0yEMuBdQpqldswiY+KMtywhkon88D942WILhWV65BbIhe+g6zpRyFSrbD7O4xL82U6RCcOYXR3CCsVIwtVFlqp+LLHpIniaCNc2qACamsG74BsG0adnFA2x1ANSsicswF2PeltEntoPccM1OzADj83CPDAxq0YinYu/8Ywhr/timrQ6TTJjNelL7wpGG5xmR8b+g6KaVK+Zuk0URvvKwxz9TLX9I5hdPPcsfhMHTeOBjuvV5LZk4Rkw6wcdxkw0mSfSddb3JGix/Rg4REwAyeO9uZH/h63a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2d2C7cVO5dQoYoKug7C1JBtBk8wgTLooZg1aY4eJ/M=;
 b=b05NM1jbEUOYiRAG49op5HjHWFl2k8dvUd5bNflOWHLfz/WDEvIA9BHZfP9n+8sWnSrvzNgYGAaZ2O+RMWSyOLyuX7YatVhbzhnh5C+A4wjVMK3Ueum26p1UgKFWozJAew9FL1qCxIPwn2Mx+f8DkBcXDjud9G1tOkwf1OS5eLHDyHz6XVKh/LahMlkfsO06ayuImmqBFiYOB1REtkUz2MI2xqJe+1dKByaH36asfVYGQvCBBsjUD34aPwBrVb8tCjcDX2YSYW/KFaXOG+YSqS6nE6r1vO9hZO4ZRh2gHSs9j+2k431PAvJtWQOV46rsCIG9ioFRih+UgADHwJmR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2d2C7cVO5dQoYoKug7C1JBtBk8wgTLooZg1aY4eJ/M=;
 b=aU5c0ZM3KDXowJnObk9fRxDA9qCBF2lGZONFwqJk/WaLzoIlumptQWWu0HFwFTJrY3APkIX/u13JXVlq6OfZW5iYjcFhAL6X6oFyotv1pCJviiOF+/pesjWCCyct0DGtVyC6n0yuduTKFppMkKI0Fx4MQYJvrHlA30puqMxanSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 01/12] dmaengine: fsl-edma: fix build error when arch is s390
Date:   Mon, 21 Aug 2023 12:16:06 -0400
Message-Id: <20230821161617.2142561-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afe33d9-97ff-42e9-1a4d-08dba261ffc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXNO3tCuLkVWKSV57TGvJBVNha+apG+1xgQPjBWytx+BFN3T8ZbAjyIe6cK/yf2mD07TyN2AjF2kZu82mTffW4+5J7ucxlp1rCiMCRMHz6zhGIYjGF8kQTdhaetOCUczlFwOxyYDgYig5lTUPo1lnn7M3miN/J2C1LccRwzU5ntwdIqjAdWy2ax0CGt4VAsXNknmybWd4o84NIj+ilzPK+09WemoCp2wEWBuBZfbYnnVEfmgxe94XBFcI7iJTQR+xeY8NHsyHI6eHfORp+e4aQeVVDaZA980ZpEB90R8ldheWWTsQB4a/qF9TcYOumc1FF81lXDEVl0fkBcfm2tYS3GVJT1liOZpceHe3nXq6JyzRGXHtj08DiZm/7YrNaLCW7zRzEGJF2k0EvDcA3zWrQYE4eabRblIIWk4y6xwuPjNvTUNuJxsomqIGZSU/HasgfnisZC9YerMNPUAydoGq3qs4amqhsop2aw4KKNQC7Qn8M6ZJ0etoRCVpv4kx6nxQI7dWCjYwIB8Uwxhh2b1XWGHf3P+mhfGWIZbfNqj9fYbXZmhsTgzHZ5eqsNCCN6AxiScGX1Lh1PP0hN5yEQs6952z+tVb2KkLXzt5lwHBZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(4744005)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(966005)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JtGcQ7GZ8xR8+1yoYIMd3GoYNBoLXJwT7HB06bRFDTz0aH3f0rLyrGVEULkQ?=
 =?us-ascii?Q?jUUelvwjgXopodvWPEZWRj8gC2ShIhLx/ZNO71k0eZAvFiTbsgXi7lEGVtD/?=
 =?us-ascii?Q?0xJbUDqbqtsFkl1sHcsEvfZ2SIu1SJIyDDb2PTnD/gNdDwBaup2NHoCtt63n?=
 =?us-ascii?Q?yHHfQv5KxwqUhReTy8Fbk4oPdclmce4NOBaoHQhChS/ov4nNUzOzPuvUZrLT?=
 =?us-ascii?Q?8lXp7zTsEXksUxtCVQgRD9qW8ny8dDpPB0ZGi3btgX93mrNoVR5OWZlW8V6b?=
 =?us-ascii?Q?Sn0ESNpTV5IfVAe3WA2k/cztoplvP83CNC8bxU1JXvz5RB2wzkNEqa9d2iTC?=
 =?us-ascii?Q?vD0VSQsPm+s4PkMfNjK7drcEv3QpVGBO3T6cklWxTQBEIUkZNj91SoZ3BNHi?=
 =?us-ascii?Q?sxYY9k0n0p0e4WVuxLoEU4+qmqbTmPYkESimBNHb40XYlAgE5E1MXpW+yxCn?=
 =?us-ascii?Q?XKQEwzgZjuoyPyiyi7FD0VyeFyhh0LZQoo1rwWrNn9KBNJLn4vJbPVBlxxVX?=
 =?us-ascii?Q?tfoLvBVIzArZpIrIuQjXrV7kul6ZYrQog7/HyxOyltxp02imQg0YLBRqrJrY?=
 =?us-ascii?Q?kN5wtxWfKpoVR+tnmJbL/uurC6Gc+MhewxGv1NWA9AFCky7ua3z64D+8m2Gs?=
 =?us-ascii?Q?hvMIhlsda9G/Vaf29HJioBRqv6TyemtGioiQDu2uCkQHB3KO4cK6+unHcm5g?=
 =?us-ascii?Q?F2P1UIzj+VUS854V7RElQ6CeZAiQ3bGsYWfF21+IG400xksn+0thaSBj7a89?=
 =?us-ascii?Q?LrI9at52QYFWX+/Frk4ugJ+1w1YhPqQDai8TYdx/D9NsUv4ZT1AiKrxpEV95?=
 =?us-ascii?Q?m7O2Vv40cbkQhH998zIrdWulGV75wPYbUwUhFEbeQ+Ws+jJoUs7t835Xnf4m?=
 =?us-ascii?Q?HUhiWWFhkAABTrdSifxesnr6V2+5eFAup1zHG5NH3NIOl7sImfEtTacCjaVo?=
 =?us-ascii?Q?yTSj5pzek5L2PySRcFyPt9rF7f5/dId1VS6rtyBDlnrCT7QhpixzbLT5frdP?=
 =?us-ascii?Q?eROP+2o1mODP1VvZ9YxzwLnBnYwUkgXfb5ATp7N8LSgPiaw3Ss5NvgNEIyLI?=
 =?us-ascii?Q?mU3x4UiOeEgzt6S6PcCD17ZmW2NvKc17JJmq80p1PBxrTzJxj1cdXTScOq/s?=
 =?us-ascii?Q?0HoWuXijgsZudUkynjN6tf9X7Er5JarHO5sBe2rWKNwRiFWTp0EK4s/Hgu0k?=
 =?us-ascii?Q?DQgH6YLdUBmnRfvtcV94PDclImp20fjufKw1LDOHo7mqRjpOjpg1sn1s6a76?=
 =?us-ascii?Q?uIhmDvH9U4L29YR8/tXMDHRVLPUdUHorxLKgJ0e/93wAC5Uls31Mi26Cf0y3?=
 =?us-ascii?Q?eGM03BJIJ8UWDyX+I8TvdfTudcGliqnsbiygsZVbnLrLKlIuKK4GsUFMax8S?=
 =?us-ascii?Q?RM7fHZqVtjcCtaiANNLGQeTiVHTZo1pxapd8Lvg4/pYnGiwsk2M+j67hU4Ts?=
 =?us-ascii?Q?9Ng6Oi2VFvy1LFuh2/AD5MsWg2yCLBvhGI4QTCbbW3SEMnwqKD/izXwElyQZ?=
 =?us-ascii?Q?hH+uGt/f45tzKLZekcJ7BHwhcxczVthNHRrX0xGE8f2KRMb5k89XFKfwZyQh?=
 =?us-ascii?Q?UfijgaFzrgjcPviMfKE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afe33d9-97ff-42e9-1a4d-08dba261ffc3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:39.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vhB6IvPYVVUFf1cEVQkwYpwZJkknEtm9jdBBgolRBdVGhRuS/vHG4aWMkDZvnzQvpqQUXlx2AYjUhOnas19pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1d485fce91c8..f52d36e713f3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -211,6 +211,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.34.1

