Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9297128AB
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbjEZOj3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243984AbjEZOjW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:39:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDA8E78;
        Fri, 26 May 2023 07:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxH5tvGvN9uF4P8LUKiGLBwhX+wnO6GZLPlHVGTuYUNQbP2A4kfP0s0sFHN3URIf8Jumh8sp4EbQN7Vi3B8qnJTOYyuQfN0qnHR11vTBo/V2yMVYx1HZDOPRVXY/pWQr+hpjnrDKKcEvkf9Rc7PdtL3sRov3ECZERroUQ7qViXxfpv3dMeyJIv/X3Qj9Y676F6zD+b66ISnF1RjgvUmWQ/8SMjmM4ma8Qapvv+uKB1SQv5OcG61OfycgI6XNbcJDgbZOU6EKRryt5DgO5usblF8l3n81oTpQHa61yR7xcVhxHati3fm2HF4JajvSx7hH8hAsY5j3IJumaKhqkEsdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISKgrdPrxzKwoDu3CGTHqw8SLWtu6pWcUHBCYREGJL4=;
 b=NJrfVcPjJv+NOoVTc+jLLh+oE4DSND5VapAlYDzOW7JJ6y3P+zDEtUz7/nHuhUf8qAkIjUS+JkpopoYeNRRFE5Jl3Wb9SKxPaC2QEeyJFyVMZ+6V70vSgo/GebIzGUZ2KBh6c0IzmWwxHzj3vgeH7YLAkrarQcFZJLvy8ut6hzv2QqvPYuU12K3DooO756YCmyBy4pFUE4fTWtZsG4l8xmFEFO9z285YDrgUzMgYoqmtv2C6up5Iw1wEsyA9gbIGgIBT7jhd6XQFlI99iugiFJtThh9iyNoN8kCEvM34BB2RTtPkDQQNE9HgNKzYc9z4IhHMGoUid+iqeVP2/g7VkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISKgrdPrxzKwoDu3CGTHqw8SLWtu6pWcUHBCYREGJL4=;
 b=VT/lM2btaU9hnfHd3QKXp3rQ//smnrXhcs7I8WUNrO+UwNbSAvJkb76z7yRDtJbiXo+iC8gPslr+hFo9/wsX9MDY/tlatFKTcXgy/ZuYcJW2FR+Mb+vZKf1wu+iwlYJOjzIRpft6CH2P9kVwBquhhVMB5nODo1SL1bL7oKkp0gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:22 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Fri, 26 May 2023 10:36:36 -0400
Message-Id: <20230526143639.1037099-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: eab5f83a-ed9c-48d6-1d7c-08db5df6b799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALBcz71hxqvtpLqcPsdiqubOWVAD2kN1f2CDvM6tWVEzyjzvwHpPGaezLYTX1sXRd5MB56x311KoCJrwAJ15NFXlOxp3Ugcq7gesmPehqLh+tlHgGOf7p9Omii8DX1d036tk7gGqvBUqrdJS4HLToO1oGO8rYdcxBc+YZQmpc/RGesh6XQsX5+EW7B8atmluelLLYCXw2qRbbHr9hlAuOIyoj9aPl5OB7nHtMtKZGnlwGwGqFJ0HQESZ5VXH9xvd3AciTWDfvNHCpYGXRliKL+io5uZCHYO+gflET/tT0ktpw6HzHgNO3mhqCgYMlFD5xCw8PoV4Jz+HyNF8g5wLFwmW5hofYoPtqByHjNpjsMkfmU0TQ4NCo4lOgWdLJEGXebC11x3EgGtaEtNog6IRB97cCnl543c+Jfr7/G8A1rIBAs059vrJar980Ojskxb+0JOAU3KwQcxpmaiq9yGnYExNhBeO8pgUZViO34SxyjruxWFAUI7td23zeI+087pRHI/SQM89kQx36ZuY9uA3YhxNEJFzZeR/sHTYM+kU0r3LrKzuyz/p+qfpUKDn1C9U8Fb4RT2XMztz/5baw4HVsbYI47BQ7CT2djfsdW1+uwteLwHaXfbqalVyk17co6Fpz2r7galT7t/5bx1hAn5FGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LKlUxHf8vz+AHO9a6NDb/ERpCUOKrEXQqbkoMVrrhdNvmrs3vYbODqp0Sbg?=
 =?us-ascii?Q?QNf+5ouxFzaXIRlD9C6R0LDyWmO9+gj+/z+nAWTSCzgvupbz0rHFN9umy8mG?=
 =?us-ascii?Q?TeKRDjdc1X56bwFO4Bk91F/sWPxLjnBUUVL5SuXPbXfQCfdRXi5DtQXq+l7W?=
 =?us-ascii?Q?XIczKFdMi8VU16ouVCJHY5m3BzOIQ+fOAN8BHm4scefjfKYPnbUFTzgZlu5Q?=
 =?us-ascii?Q?41bttWheb9GAbNKzkaRqIbjbbR5H4QSPOKDNnttftWgA0AXo9LtZ/ClsKqhf?=
 =?us-ascii?Q?cX3SeQg5667YSb3d4is7wdnXeAnBs9GwojfBbZXKAxMRYFCZ8ylU5F1xlxz6?=
 =?us-ascii?Q?aMztoFPOtbC8xG/LgFodBIdySza8DDzkoNLlfFcaDJfiAEluLy/kW58byztw?=
 =?us-ascii?Q?WkXedVvTHNYd1wgcPEVhOgGNQVqLccUI3fBq76Hl7tLsEBEaG71HW4CZ9G9o?=
 =?us-ascii?Q?e1S7R+D90ieIXKR3UkestkFO3Pmpw+M88irwhiYVVFhrFQqcSnpjrB6mKr2c?=
 =?us-ascii?Q?LsP7DBM20fnXYIE0shfIOOxQU4/di2ar/Tj8NpCCKHnkcwMnCHZvxqHbU10X?=
 =?us-ascii?Q?9tmPAa9MwEGE1LqdrDOAwMYbtfS8LEUYVzFUJt3NMbqJozqZvqIjTsoZc8UH?=
 =?us-ascii?Q?raZHXX8kyBcrDzSZ3q9oRKu8MgvSKNYAJ5Rza0Ug3THjgKvkcfpDwrkTcYN6?=
 =?us-ascii?Q?QDewB5gCS16t7zyus8/L0hOf5DvAhbaGmlapQXOPGFOGE40LZPAvFQZd5Is7?=
 =?us-ascii?Q?1zSYrAK+PMsWvX3HYH2+xkztc4eQC7VAJEXDdgSjaRvginJeXi2/UeulA7Xs?=
 =?us-ascii?Q?pAo/79VFMW4kKMKGzpk7D/y0PaDxYe5Ag+1luAfxvwAPcO+hOCKjZ0qNS8im?=
 =?us-ascii?Q?JthqZ+HuTG6cacltDISZMBGYlPYfgKGLES4TqNRmsVdhNBAlx8M63obqgmSg?=
 =?us-ascii?Q?8WusttLYqmiKkKxBz+AP1ZVkFj6TiW1aMOkD7DYgcQuxOw3Wq/3YNZELA3nG?=
 =?us-ascii?Q?G6GECGQVOc7q+Vr7VBUjLYKDevAjjh0pcM0i1gQrbaux2cBI5Uxpg8ktHzbt?=
 =?us-ascii?Q?EIZj5H/IUMqFxqXX/16U1ItjG19I/zdPReHB4DOqXCiu5wjZ+0RuZh2OqaDi?=
 =?us-ascii?Q?KZwWVq+thT22xHtswNLhzW4jIUAY+zpfcXl1pkZiojHSaJyNwG4GXwda4OkD?=
 =?us-ascii?Q?6rh1+FdL0qRDiJnLwVTkkEG2uSrVYtxu9eb+phkkKbEgsL0z6HxKseVZy6iw?=
 =?us-ascii?Q?PM8yWIOCHYKhP4BxddL8O8dJkvXg47sflA1C35J/1iJ3yj1uzHi+ph/MMLjE?=
 =?us-ascii?Q?jxm1KoNu1vE+lxGs16exS1iGoxWaIQS6KKBHILVnsCqvNrCgbPUN0/Fwp2BF?=
 =?us-ascii?Q?bmPJe3sF1cRwPICDKr6zj55H32DvcclUFyv3izeLVWTshc/4ss+FiyeD2SxR?=
 =?us-ascii?Q?xkIlle92dAy11KB7ZOmpRXAC98XaPoMSktoG1pf12acb6ZBIny0ISL1meMJ5?=
 =?us-ascii?Q?TxsmOFgvLKEDC5i4rKg0+m/Wiqw7eI2s+7LFvVHGJ+LQGVkxIX72AG6lGl9S?=
 =?us-ascii?Q?UV68WWqyQH2otmn0eXC6uzaCfn6CBXKckfsiaQ/d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab5f83a-ed9c-48d6-1d7c-08db5df6b799
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:22.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSoGlHTaI8ptg1MRbzmfhdYgyEB0gLjGcW88zB8k9DKjNporKS2GLBX5T/BlTB32GY1Uw6zLs+aslMFU9iaGcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Relocated the setup of chan_name from setup_irq() to fsl_chan init. This
change anticipates its future use in various locations.

For increased safety, sprintf has been replaced with snprintf. In addition,
The size of the fsl_chan->name[] array was expanded from 16 to 32.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 +-
 drivers/dma/fsl-edma-main.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 3991956dbc11..39b5f903ba87 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -116,7 +116,7 @@ struct fsl_edma_chan {
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
-	char				chan_name[16];
+	char				chan_name[32];
 };
 
 struct fsl_edma_desc {
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index cd734779f2eb..722ebecdc894 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -175,8 +175,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 		if (irq < 0)
 			return -ENXIO;
 
-		sprintf(fsl_edma->chans[i].chan_name, "eDMA2-CH%02d", i);
-
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1)
 			ret = devm_request_irq(&pdev->dev, irq,
@@ -305,6 +303,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
+		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
+							   dev_name(&pdev->dev), i);
+
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->slave_id = 0;
-- 
2.34.1

