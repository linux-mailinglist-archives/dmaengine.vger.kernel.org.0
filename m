Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB920DF9B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2020 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgF2UiW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 16:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbgF2TOU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jun 2020 15:14:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBD3C008760;
        Mon, 29 Jun 2020 01:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWyXRl5DbAWSJan8Zwn8EqBAOkKDKhLbxPEqjT6PqYez9GhkBA/bbxEM6RI0hCVOCbiWGY5TIEgs+DJh+U2DDmRqXWZcMpf/PBY3ESxqJo0bWhaW4/5+e3O2VLtgDtLp/ANPdqX+WOnDYjppKaMr298G5p2HkOsMBshPWWs0oLceaktWPBAPkPDTGE8Hnt5aMNbr6oob3ZRrsAs0ilcPqegk43XRg4cjrOIk8ZxblwqCik8PDtqvjry7VTOc7h3EAKVW8cmTR1m31f6Df7ixuUTxASWawhFad5yybvDwiqlvieUuA4fErKa4Jsz2jZmlMroB7Vi51weeWqJNtnETXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS7zX6/BlwoOeFbB6++4OHrcCuGutA1PWZCjsqN3HB4=;
 b=Le0Qm0iAewqC/d7OR/ZO1HhMUJRjcCUlsMIAmPM1lQv0Z/wyjuSAFhT/UnxokAymNiQ9RAvCeHy4d8D0JBRJb9XU3FFl2F1XPung/gu+J7Wi2d5CtnAUy7UdUfYwWIgdzyhpbNN3uFhWuOVAxDNOP5YM8mP5025QU6oPlUCdDbO/96HmlwXk9oo4sGLldsXUzniE3soGMzUygydSI53m9MPlBNBf57ct/KIvBYMlQiI5JNh3mPgvq5Uw1jF4+2AbPxOUtb/2Ww654dEXJM044ZB0dJZ+K7Yh2TSTunkOILqgmsC3bOhLFBgiWb0BEEziE1iX3rTENGEErWi2gYfvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS7zX6/BlwoOeFbB6++4OHrcCuGutA1PWZCjsqN3HB4=;
 b=oje8ILZ8qhD7FdMn9JMkfmawtuvQZ3b1dbGUH05NVCBHX6fA0bODT2Ni1rMNher54h6PXfBwGki6u6WcgmGr25WZ4C9yPhW7zCJCO3qgKP4aKpal02DpIco+IvYbYt9Qdj1IIRGOATtThyu256mUVqmHp2wr6nkV17H0hqMJM70=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6014.eurprd04.prod.outlook.com (2603:10a6:803:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 08:53:02 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 08:53:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, angelo@sysam.it
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1] dmaengine: fsl-edma-common: correct DSIZE_32BYTE
Date:   Tue, 30 Jun 2020 00:59:58 +0800
Message-Id: <1593449998-32091-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0142.apcprd06.prod.outlook.com
 (2603:1096:1:1f::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0142.apcprd06.prod.outlook.com (2603:1096:1:1f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 08:53:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a00d131c-ccd8-418d-a9c4-08d81c09d489
X-MS-TrafficTypeDiagnostic: VI1PR04MB6014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6014153393A81A8086123CE9896E0@VI1PR04MB6014.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lY1LaeZocvBuqaHQyb+PLQJDepy1EFa7/uRozccgMCJmka5pj8M950AJz1AtO/SCWfiq+6UvnHkPIFedDGoDjmaioWG3LP5Cs4q6p4yoP1bfIvEKeZSXNl61U8HjZnCT2Qw8Giz7NLG2gGv9Ez9Vy5uivUUFG1UXH53nKXywJnOzmRFm61SQzfFYQYo1EJ5f3tr1gt7Yu1Z7poDD8PAI6uWlhFz3x3rxv09EU8uqxaeU44VFDEECLXQGj+3jHpGBcCj/qqIGluTOMip8jXdY++EPsAiPprS1vVlKeYFLvEP5S3jOAWQ1tuH+KskBeTo/TMcjykdsgF5DHKfuEiAfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(36756003)(16526019)(5660300002)(478600001)(8676002)(83380400001)(86362001)(2906002)(6512007)(316002)(8936002)(52116002)(2616005)(26005)(186003)(6506007)(66946007)(66476007)(66556008)(4326008)(956004)(4744005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FhWZnMGH5Dhh11RzJNXh7hL5S/Fcoz1rJii+Bby6evkq7xxhox4gC8MTCsIt5YifVS1iV38mcjrwZIn68RFvlbPSLybMlvBm5UdYQdYu4IbQxdNRKhfBTOqX+RBJFUb/Ji/xP7cSiko0kdjCQyBd5R42uWMC1mUIPLTWpaS++0XGy0T/LpkNa9+IPAFfT/P8EwioPeiKwTxzz5gELag8Wrw1lHxGPqyKq2SlJdTSP5QB+k6+yknDuUvFCmAr1zo2Xp9VLVrJpyYCi7bbmBaXqBN1mwPaszEq0VPKAhFqOHtAwVEKWHRv1lMqEY29j+ddj1z45tku+/d9ZdW9K630rmxthXNotnAtrf54ZYLg2ddCMTBz+ZlMzYamVTb90I8/nO0MJpVFew33+Gf33izEU9Lx/efB9utnebOY7NqfoyGuGDfukYAlPL96CLurkE0cPl+mg1s9e1Wee1zjqlFU3qE/zGQfUmKko+srQMdx6WA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00d131c-ccd8-418d-a9c4-08d81c09d489
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 08:53:02.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp7CirtKShLLyy1G1wFfLpougfcsLemLiMXqNvDUZDghb+pJm2Nxg2QAAwD0eG2Arw0wd9tQy3YcOgZqoudS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6014
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Correct EDMA_TCD_ATTR_DSIZE_32BYTE define since it's broken by the below:
'0x0005 --> BIT(3) | BIT(0))'

Fixes: 4d6d3a90e4ac ("dmaengine: fsl-edma: fix macros")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 67e4225..ec11697 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -33,7 +33,7 @@
 #define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
 #define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
 #define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(3) | BIT(0))
+#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(2) | BIT(0))
 #define EDMA_TCD_ATTR_SSIZE_8BIT	0
 #define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
 #define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)
-- 
2.7.4

