Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F141B2D7
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbhI1PVb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Sep 2021 11:21:31 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:11935
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241566AbhI1PVa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Sep 2021 11:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRqr5QevY1REm/zoddM+BbziZvDRL6Ja6B53OHaxqvxR3FCd6NaPAXZ+KnlprX7zeUa/aWhlDtXINk1IyyhvY6whcQk0YN0kzqD+xOfkrA7Q3ZQiAO+2/p8XdsJ8k5xXvuSlupYYDtXKn2YmdcBYnVuFJLalaDczLL2C9pSn3iITjgt4YVuXmAI0kgtAT2Azy+A5hA2AyuryXMalA9n4UvGx8iv8cBYKiB0LeF/xDPAbcb0PTfclKYvpqJe9z8zvRdQvqGuee1ZZdzy4BV3mASzXgG88moNey9PF+Q98YrqMzAxv1NicREXH4t2bnLoeqqFC+HbTuSC2t81jzeOQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=g4QWkTVS1FnXHgzMMRvfhNElA52or+CUNSVpMmYLj9w=;
 b=S6rbYymZpKqpWZISPq0Lx1Aw9chDt0y+pCafhvjr6rPVvUP6D5zMM+r4xw+79WcWcAyv6Q99Y3VFcxr3uyhYwTK1KQS4vMzqPNU2fvNjIyg8cUkcp5AW79cdjOx/Ur2nx1puymdPi7qWIR1xzeJoJULE8gvZn2ffUTYitzv7xBWRjrv8k0cXOKQvL6MFwA+NVFGDns0hkd6+dbHnpIPS7ZIieUgVBUClUqgf6P/DgECt26i3TGsEvNDJNw+h1CMukx3ubO9eSNnj9NpRC8OsETSxPX7IQ62DFWwGnJ1d+gxEiyKrrICRTzKXWcQ2oOhh0n/3gwwajY+5++tuGM7KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4QWkTVS1FnXHgzMMRvfhNElA52or+CUNSVpMmYLj9w=;
 b=Lt7hmsbODhUIteRpbLfoGxIfxHg4OfH3zQ0XYKx/+888cPR54rXBU+RcooM4fHy6F3e7RsSgXDaIvW2M9TIswRlp/J0Q1JAzfIS6noAeHuNeVoTP/CcM/CvTMLcC2XL4Mz2QuhAqa4QKjonNKe5VWzkzKnEVEGJOzTt8VZBIiCM=
Received: from DB9PR02CA0007.eurprd02.prod.outlook.com (2603:10a6:10:1d9::12)
 by VI1PR01MB6655.eurprd01.prod.exchangelabs.com (2603:10a6:800:184::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 15:19:48 +0000
Received: from DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::67) by DB9PR02CA0007.outlook.office365.com
 (2603:10a6:10:1d9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 15:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=asem.it;
Received-SPF: PermError (protection.outlook.com: domain of asem.it used an
 invalid SPF mechanism)
Received: from asas054.asem.intra (151.1.184.193) by
 DB5EUR01FT060.mail.protection.outlook.com (10.152.5.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 15:19:47 +0000
Received: from flavio-x.asem.intra ([172.16.17.208]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Tue, 28 Sep 2021 17:18:51 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 4/4] dmaengine: imx-sdma: remove space after sizeof
Date:   Tue, 28 Sep 2021 17:18:33 +0200
Message-Id: <20210928151833.589843-4-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928151833.589843-1-f.suligoi@asem.it>
References: <20210928151833.589843-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Sep 2021 15:18:51.0142 (UTC) FILETIME=[2476AA60:01D7B47C]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32b9a15d-b68e-400b-2bff-08d982936880
X-MS-TrafficTypeDiagnostic: VI1PR01MB6655:
X-Microsoft-Antispam-PRVS: <VI1PR01MB66555E5FD9031DD809651A13F9A89@VI1PR01MB6655.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygPcL3FFnISekw23mNHYFtMbLNGtr5puwnnzvlujfrFjtBA6Db6QHuNSiC7UF9cRvxARv+fyRzASfKg4ZGgtut8jBdYe+XL/lTUJiO99K4ZUiUajGhRys4rl3WbsyCB5AUDSDW6wHsEOkRrrnIxTi+DQX/55y8mGhaLOTrqSCjDDFWqQx/5N6Q4BL1PQ3/Z8FIfzhVTJp9w45viPM4bnWHNlnRhzgj0jI8PHP6ns7POc7mAp/07X5OUGP+cGuf4k/KoFmnyihsEr1QmH9Et87rMS3bkhH/utbmX3T7ddj6BoC6fXpg71mhy4I1iCsOUQtk50je/b0VVBROdsA2rYEvjAVRBMa+kvVtVkDaMorKzdI6RtKoimQKHJFfBI8X1CpbAwbmPV+xnx9+ZX+KhofXA+BpQCnuzVaav/+EvncBBVmZvbYmBNzJE5OCr8fjGvEc6ddR1YZUnkTQC9njZs+tJWIiA7VCWjw51ZmL2NvRg/Kt0lOj8rymuyTEvkNDJpym9WstzmmgL3KW0rJFszdPTekpktZty75FaKnTyuh9lMDV3lcx3DviI3isSOFF6wpE1Nj/lBEtB7xWoj4AkKIYbDHBqJRkiOyTCSL5ou6+VtL48p/7wS4zMNXQgmgMKrX8v/8HAcm1mUHlxJsXB7dZQO+KI2Ijn7+B8yTKZqAao7CfAWvb4PI40yfYrdGasGbSv6O+ko+NXQHBfBYXcv3E2tQd8a1Kc7IipUoaeseAY=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(36840700001)(46966006)(81166007)(54906003)(4326008)(356005)(336012)(36756003)(26005)(6666004)(186003)(82310400003)(83380400001)(2616005)(1076003)(110136005)(70586007)(36860700001)(5660300002)(47076005)(450100002)(8936002)(498600001)(2906002)(8676002)(107886003)(70206006)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:19:47.3240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b9a15d-b68e-400b-2bff-08d982936880
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB6655
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Space prohibited between function name and
open parenthesis '('

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/dma/imx-sdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 7b3bd3608651..75ec0754d4ad 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1955,7 +1955,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
 	sdma->channel_control = dma_alloc_coherent(sdma->dev,
-			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control) +
+			MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control) +
 			sizeof(struct sdma_context_data),
 			&ccb_phys, GFP_KERNEL);
 
@@ -1965,9 +1965,9 @@ static int sdma_init(struct sdma_engine *sdma)
 	}
 
 	sdma->context = (void *)sdma->channel_control +
-		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
+		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
 	sdma->context_phys = ccb_phys +
-		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
+		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
 
 	/* disable all channels */
 	for (i = 0; i < sdma->drvdata->num_events; i++)
-- 
2.25.1

