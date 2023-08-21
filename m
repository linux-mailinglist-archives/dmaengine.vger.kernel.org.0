Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774DA782E29
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjHUQSU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbjHUQST (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:18:19 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AFF197;
        Mon, 21 Aug 2023 09:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTfQvyWvcn5wBx33AzqU/F9f3CxFshaPFF39rC/cfpFj6IV2b2Lwjkah+6AGqpicq4pGWuWY4wp9aS/7BesV+WF9hcwzhR1xY3a4XezuAWrm2Q4wXhKdPHTAOonWwrjj7tXcXVFCp6/3FSmM3qoDenrrlScusrJ4IihWZjxt63FcsX0tjoE24P/FjeGU0kGiU61GDpJZVCBXPbisR7iBW6ycJT8fiho53oQh80Kw49I0thGsvDQHxa7IerWp2d8kEPv6GvhoAGYRI49BS8iF1G+I61O6210ibgK6nT8aJSa4eAZ1O18UmFKmmGlRSkXFMtY/dh2i7APvd6cTc3A9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jN4yfm/zuTIxWq4I+CWS78mTYFJN2/bunYE4cANRQY=;
 b=HtvAif5Z+BKYOLVbfBElFUILPerGCo1azxuLfT33CHjdVgvJ4Bj5o7UJNhU3tFbv9lBBb+N50rrdBYzC8XE6rBnqJyz9GoRz2ZXRl4hy7DqvH7dGpJswo6jC4aAhzDuGK4qgx+x5bpWgigDazVPen24LeVnWrLQaIBWjohS2KE4i6yM1h+A4i7iMz+74uLTlkFC0uHurAVaZQTlUYz++r3SBESktqys1w7l1IsdxvnTXcZzeBTewm60AVzLogHnZ+if8/7Kf4/wLouSgGcro8IF6hYuEjMLofwVgDzEkNwmVZNIR9anntGj9OeJwNZbJ9hwFPRii1yN0gT1W2v8Isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jN4yfm/zuTIxWq4I+CWS78mTYFJN2/bunYE4cANRQY=;
 b=ULscLtvlqU+XurCNnK1E68RTstgx3TCRF+9I/Khhsbu1u8oYtCKc1jRV4WC9BmKXO6PGHVQ6PQ4LXnxkzqyQxc30gCm5faGDgmi93nDDIoS10zJO6KU5L8aq2o+P81PtdgrfsduPPPWAo6WYmNcxcG1JQ0fcKoHefy36Dy3P/Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:17:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:17:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Mon, 21 Aug 2023 12:16:14 -0400
Message-Id: <20230821161617.2142561-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 866787eb-5a91-4298-f4f2-08dba2620e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2iT8QUe/aLkyht2ywmSojoqimW5U188ayUmLsq8w6ERV1xdKBqAZfKaUPJXw2rQHXeBKvQbIclfK9AYv3r5RVURS86SmE3ziOFTe4tZzEPNKqaoMBW1pBbuvOqdWWwZhus3BIsgSE4DpkcRpVhlqlbru124DoID1GLuiq3wsFs3E0KaUwdH8X0zrf99uM9iI6P+RV+UKn4aihxaYYK772qa8Dklm/hD05RUuft2Ln7N7OrpynSGYVNcRXt+Qa76TYEiwWqGIwEF9wO/n+ukzt+ROSpvpqrBrnR4I5C22dfRxWyBdsOvXFx0EiUziPCG31tnkapIYN1S4/sbKDH5AoJbmxqDQ46d48zte9F8I6uasOgiDpJA73UJFETbqQvpGBKffxQv9UtVQFuy+whKOJGIFTnYB8O0zkNYOflRG+MCwzbjUa1ffeDt0IVqoVsrd95iu0E035AxByhZ0I8WFpEBTQDyVCa8A1jUqhmXT0WZoyccakNallOYo3hBJ1q/y/U5MdBtB3UYR1QnsBrnxWLivmkht0YXZcvjRMNFlt2kmg/5qVbQWHI1PCP9xQCcyIO1/6gUOIJ7T/MbU8eDhohQSV/f9uHH/EqzpVfjHa2f9LNTjMG8LJOEJ96ETt/B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?unuUoO5M7BF7Z3uPGM0fw3OlaZZq2Jkgo6DD7Go1L/hA6ZBWINkmX8FYvAuA?=
 =?us-ascii?Q?x6L0LruMppeMu+UqaRQgVyS7x41g7tBCrun8Km0wzZe/KLyFEPfX0EkTvlHA?=
 =?us-ascii?Q?V44SDiZKb4VdyTsPw1SaTRzSE3f7tNqhxYS77C7zzirhwZSGq4riExd+lHJ3?=
 =?us-ascii?Q?ygdFqCh7djV1JT727GGo4lg6JXGimX/BynuOZ0qfYjJHh/is367C2IDah5oy?=
 =?us-ascii?Q?ttTjAi7B6RkpVTBylb5i2lDON9Zae04mxHtwd7dSrv5h1ASuc5Z6fHvQlc66?=
 =?us-ascii?Q?FiA+3TFJhXH8KaWK04g0h+C7Ll2znRrYhA7egC3NcpT5oUGAhxDntUTlkPL/?=
 =?us-ascii?Q?EW1bimxZZRwsR1Seht9/RdBwKMIqcu8K5UcVQ/hcTnFjt8W82icIFnreDiXu?=
 =?us-ascii?Q?E21OOHc1nShiFHskVBbIapCJnNlvnc+hdmIe+YqiWTijOAwUIKDeaZVanTTJ?=
 =?us-ascii?Q?NNjpHbU5y553nVOXvqbKTzDj2NiujbP6sB5VpR9wFCfnDpgSH7v1o0SlTbY8?=
 =?us-ascii?Q?zJl3KuPPXusEvKFoYiIb4N5qMAkSpVJds4GgeSjj2cWME9c/X461mrQCmmpZ?=
 =?us-ascii?Q?LwAK7ksJGU5R9VSbMjS9CTxQ4235gzXVO81lYeUrK7jW4YQwJn+17TuFWUJS?=
 =?us-ascii?Q?XOBWAMJedKalwKwU2+dbCSblaI33ykXPso+l+60MK45Yy9o32RUSY4xjMqWV?=
 =?us-ascii?Q?sgb1fVdogiV8FHVmRUq13d4MAXlW/bxsJKLCAFMbdyb61GpRfMfgDUO3uoYH?=
 =?us-ascii?Q?18fsnegs9B3KYbAn8ciojVo03R62yKPQUVfyU8udzh/0BVkU8YKSdcXP4yP9?=
 =?us-ascii?Q?wC0fIj/w/ppsg4HkjhkTnJpl08EmuTgjFMCdjO/YRaiOqRzZZ3PyYbBMyyMV?=
 =?us-ascii?Q?i6KJnQw9ksls3CaQvKeHD8Z+KfzNGJ6Bwv1rM8vYipZa+/8T2k41bhvWRbJ4?=
 =?us-ascii?Q?WUyyVLa6+/VjSN3r3qQMvgbrfU19JXOao7UEsgYSXJEFc0CZM1UTOgBMPUvF?=
 =?us-ascii?Q?2ReTYix2QIIYXe8haPlM9lnMl8IPzfuw5INbQGDYA8t0uG7ydb6pD+N3MQZ2?=
 =?us-ascii?Q?11uAmn62HOOMuoiWyBATjU0Jxn04LSkBeaPlUukPg7UVgbSfId+g9W/bUaqz?=
 =?us-ascii?Q?7l6KcBnyc1ssGlCoc/rBFdHAbGpjLu9gukNk8cy+t0kYB5D8RFDj5Xg0b89t?=
 =?us-ascii?Q?dwnMd28n+LxeoMBqxHKmDdXuJt/61Ny6GjD0+0Csz4z4HhuYEH24H5nvbRpy?=
 =?us-ascii?Q?Gxqq77kBaf6YL/f4rc+UyppwD9UC2BnkaJeXBCPCVSP/0ysBfie3Zxcz0ONd?=
 =?us-ascii?Q?BSG9XfmMnU//U9nGoqcqcBycEZlYAhnz+j5+cEDDASAlDqMmkgcUsH2Cc3Ec?=
 =?us-ascii?Q?28kaC2eR6OL+qFAPHs+1L8ciHS2AB9T7MsULNce9j0M5aph9RNetlZYYU6YY?=
 =?us-ascii?Q?Z5LkkMOgGxw6gWgDsUPCP8HSh7BiI6zhkHJ4kQOEa/l9BlbmmmfHpd5ipEGF?=
 =?us-ascii?Q?+OZVhCXG/vPNyabh0/jGZa42gITqrOKU/3/xiv4fdsSh+bRRXAKUZUz3k1Co?=
 =?us-ascii?Q?zyMvJtBLex9R64l+YvzCMP46PySgmMnlEdoinx74?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866787eb-5a91-4298-f4f2-08dba2620e10
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:17:03.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XNcwot5bTGfc9enK2OW4/riz4CccWWLZPZU4c7asQhOpOZVi65YYm9kmUR1x8/qXXkHpasdBwElEiK+lV1cdQ==
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
index 521b79fc3828..316df42ae5cb 100644
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
index 111cfa2c4572..d68ea16ddf1b 100644
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
@@ -313,6 +311,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
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

