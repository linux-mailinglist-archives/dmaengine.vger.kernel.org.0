Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67593368A45
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhDWBNl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 21:13:41 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:47422
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231261AbhDWBNl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Apr 2021 21:13:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjQKn44/IwoGxIk/B+nOaG8dk+a3WDAB6ikbiObRg8M4jJH8D/jwq1gunPlMq9jIEyxWXt/3jWHj3FKHg6Goabza2Rg2SzLFbLK2CPozmX6ax+wJy2lkh7VpJ9/wDyp6rWqrs73xEX8Hgpq/EHsBECt3sDVKxSy8vSKJccraF8u+BhiBohBrWhvuNCNEvihvJPFCsBG8Bgn4MyItS1Ak+NcNOSXj5sPLI3gEpAveb/7BCiPxic2dgizGvEeAlR400zi4wZ1EESovtO1EqQCa9peH4t7VShdULxB6jnPGeMyVUyr1OeeD325zSxDkceU4NNKpLS7/JiQmUGSYBUsWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QYRcgnar5Xfd/d33eWljYXHu+Ak8jzQYQ7F4r3HbHg=;
 b=Fs68qZKpNbN+mjJsa7NtD07HOYiPo17MoE1aWDqEtDvJuhdfzUOZc9vzhGrNN1dE+lcAlGXPpQNBaafi/WR1tLy8LFwfAlR0m/ecRp20FXYyP373SCs5v7IBotDdLO2KSvFqnt9LVifcNVvaZy8JTUjICRs89s8DYQUxU/8F5pdJoFZRygsmrxrvmCzEm+y18XT8XwXqeyXDj7x/PDe5MARUrIjL107NP1BrdAKoFFmfWKxnlUnvuyUL8QGpUKGTOsxdVPbiDkt3X0muTFbJgGLPWEd0bedtUNyV44hxgWMcq/VOCzodurVEj5snbxnkdTz0e81iMKw0dDzxtTO3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QYRcgnar5Xfd/d33eWljYXHu+Ak8jzQYQ7F4r3HbHg=;
 b=DVg2TvWSKsetUhSC1Z5ObpJAA7V5GJsF8xH0tfd3aFBiB5x/ERPUo3Ug3KYoUbVVAVwmmXpDzqNoP7RiMBnn5zd5s5iFOWj6EmE4bz4rs22nqimNYC5AFFaFU5/ljmNJ8OS71F2gGocaDAwChJ4YKOZDDGGxAKuhPoQUMzNxJHI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB5229.eurprd04.prod.outlook.com (2603:10a6:803:57::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 23 Apr
 2021 01:13:03 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca%7]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 01:13:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: fsl-qdma: check dma_set_mask return value
Date:   Fri, 23 Apr 2021 17:29:47 +0800
Message-Id: <1619170187-5552-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HKAPR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:203:c8::6) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HKAPR03CA0001.apcprd03.prod.outlook.com (2603:1096:203:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4087.17 via Frontend Transport; Fri, 23 Apr 2021 01:13:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20fe7b6d-7ee6-4d1f-2217-08d905f4f111
X-MS-TrafficTypeDiagnostic: VI1PR04MB5229:
X-Microsoft-Antispam-PRVS: <VI1PR04MB522946EC122055814987ED9A89459@VI1PR04MB5229.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+oM4hc9N3BSrv1txj1D/p3s/MVA0xbZmbq35mwnJB4acfib5XHfjILdQw8mksSAI+b0VKcQ5GsYC+yT1vkoQyZVDqn5UfFK6QsSOUylomUVrQKGlSWoIN9n03Wfrs+uwvErOvSaNFygakxdmCxmUOq8g/HWVSk+e8C62IzI9XHSebpxH/F80J19mLCjz+8T0uueGOsMahBW4ZucujSS2fVxRB+oPGArbKNqqmZCtlHVtY3u7w7LkeDpw04ZuXjJ7OdFHXpTX84owVQGqLGtB26FaYIel76BUlz4XvW72tyCOkE1uZvPbwmzyCOjZr3CGQ7nsHBr2M74FZmL8O6Guz5/zJBPSZepTVaAK5GkoZrnwyVnkss3hxzYQzohIhpyAvq49sHLjh9cz/LJFMvMjUt91Pu5EJt8AduwikPHr0GCBfg1jMZQhcm036vrcZTAtIpRSQlY9nvDwHaknINOhlAiCGaxxcm9pBXQ3opIZf7MAF6XZEnj89NUQNx7r7G+vSeGNixXb2e6khGrcLI0TWJaX9ht2LiShVCx7jTgjFXForpkXRP7Agva8wbohrDQakn4n6RSOxRPKbHDKxS2/zhNs2joXTCvMnIs/R3vS/GbOTlt++BQMZn9+xGZf5D2erCo1yxsbdS/09EiDuxn3mYQBW7nblPkTSbp1Yx45s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(36756003)(8676002)(5660300002)(83380400001)(38100700002)(66946007)(478600001)(66556008)(186003)(956004)(6486002)(16526019)(6666004)(52116002)(6512007)(26005)(6506007)(4744005)(8936002)(66476007)(86362001)(2906002)(2616005)(38350700002)(316002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nEQqowRei7gyP9Bjq2By1tiBJJz0XSQOUYQYZF6NRNlbPtqBsTRifYHCYJ1g?=
 =?us-ascii?Q?l0uFKXWA67CIWpdM9YKuHvDA34QmrTABnNiCE82emgoDWSoos2c786vgS5G/?=
 =?us-ascii?Q?kwXJ7W9A56X58mRGounRne271omJK28k/WEUPd7GhlyO87Gk9OAVm3tlGgw2?=
 =?us-ascii?Q?nw8Wym9PtiqMrFEsWsYEWBcS5pc0QF9fueVwuJNG3jJoEtNuLhO2OBtiUYcd?=
 =?us-ascii?Q?ZcSn+Nn7ixhGHV6631k81lm+fwHXZKLHo0u0SLvJoimELEjvRkmBIPiBR8MA?=
 =?us-ascii?Q?8mcT8kx2Qsmb+7wWFkd4h/UT4N9bGr6dc3OeHF+urWzJau6G/tQR/eqm1T8y?=
 =?us-ascii?Q?wbxl5ShOoIhZLwqozj153hyNIi5GXDFKeQanuJKMr06X7qJwmrAX//hp13F4?=
 =?us-ascii?Q?Q/BTMRAGCcxRYLG6OJOBbca2z92X7PHY1l6II5NM7CvicglJzq4ZHuEt66FC?=
 =?us-ascii?Q?VcwARBaf36O+yVCEqzcxt1fx1COKFmhmGVpIZGLawtg4ElLiP57qPapX5++K?=
 =?us-ascii?Q?o1E0fJIuVJfS3RC6kQ7wuGPotR6b9b26rvK6RUrQKy66wfv6ir99ItTKbD3m?=
 =?us-ascii?Q?hZssbwVOlQMA5oq60HgVyifsQl+4Q9T+yPezBkhH36fb1n9qhVKaJ8MpJ+cR?=
 =?us-ascii?Q?82nYAuY2ZE8YumFTk9w3l8wf8sy1CW+UtjD+LH5cAdZJHtB5IcKyDLOI4yKh?=
 =?us-ascii?Q?5XR1aw9naPE/kV1+qwSuHmwq/K2agkodm/aehxk/eujRlcAT1UqK0DveVZW4?=
 =?us-ascii?Q?oHq0bc9Mt2fbLTxaCWwM3vrvmPHQq96iz9D8Ir79wxZg2/Fkxl8wF75xhrE6?=
 =?us-ascii?Q?6zzHKVU8s7dUYq+1bIBKt4UpS0N6wZvcxAn66FiznyZ4LaGAw+xJRg4z63an?=
 =?us-ascii?Q?JL7imXrnllcBxAPJyLBfI2mxtVQ+QLdExQ/ig+mVa27LskjJ7Si8IRFVnybo?=
 =?us-ascii?Q?dzN503iynnff4+lQRJ+KRYktWu9Uytz7NlWPiCC4kIxwA/hqiRrcDsXFiPds?=
 =?us-ascii?Q?CrRDDCusS6viI4hs4quZNWC0tL32/XLpRC4TS8rpATmcYWNnwygaiQqv1CnC?=
 =?us-ascii?Q?KXV5QAvF1eRjOGuC2cH5ym4fblRIE5J/o11uBrYrLfdSezgxd8FQvU9b1bFp?=
 =?us-ascii?Q?fYd4Aoi6+MuOP74MOB/YHZRCd6OyANqsZZypMZPD1oa3WB8etFGSU+Q/Xcuh?=
 =?us-ascii?Q?eNM+SVGXNBX8lC7He+Gu/ka2QS70JfH/wA9adHokVQlJrI26w6Y+SIUQl/JG?=
 =?us-ascii?Q?BbIkCz1ONCq9JXq75wzehN9w5itxnmY0szARt6mfgPGL5BYd6ieCcsbWJGk5?=
 =?us-ascii?Q?XGCaCEalUfsz+tq0+l+l9FYM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fe7b6d-7ee6-4d1f-2217-08d905f4f111
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 01:13:02.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcIJI3S9M66K4OEIEVmavfybTGUwin4rKqklxr1b9JAwbiopdci7Xt1Wpr58aepUJ2RWyKC+C5eiidDV8X/odg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5229
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For fix warning reported by static code analysis tool like Coverity from
Synopsys.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-qdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index ed2ab46..86c02b6 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1235,7 +1235,11 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	fsl_qdma->dma_dev.device_synchronize = fsl_qdma_synchronize;
 	fsl_qdma->dma_dev.device_terminate_all = fsl_qdma_terminate_all;
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_mask failure.\n");
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
-- 
2.7.4

