Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D9426310
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhJHDf1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:35:27 -0400
Received: from mail-eopbgr1320111.outbound.protection.outlook.com ([40.107.132.111]:7275
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240622AbhJHDf0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:35:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtQhRC0eD2Nf1WPUssDHeC2vEyiYeT3b9FpIIrDnCndWOuuv0/Js+rhIi5InJchFZwgMmsdVgOG708jqeoaVI3JgyHKFWK2azxgPZwP9mqm2atoT91sq6uJWhUlaPGJbTt9ncU+ybr5MAFErUYS0TssnaiZ2BbJd5HCObQiRz2vYiSEYtFLZSRul/0zFR879uAiZpF8ZT0/WOV80NvkQTpLXZSojHubBh6RAzTFgl+1W095rW4CZBCPc2qCeZi/uu/Q2rYII3nPnJRk89fOwo8TKpp+TChmW7Yf2SUYZ6oYFyRx5a+IV90qn5x+bXtLBexJVxx2qYBvCx5IWC5WWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUX4tIqjvrCqn8oNAd572nlHD7cCfamaFccMMWNEKxQ=;
 b=Yvo3NEtAluvqg1jbXKSFYsYnBZI1JIDB1gGk1TpQ4avz01PAbPSW34uS5ySXPMwUvSW/8UfpOTxv5yFCWb0uSCTlwoQcFbfteU2YPbcwn+0JcMSB4xnR+18l98a0tTw7QzLhfm5m5GIQnwUD9Mr28Fq7yetS2ccPzs9sQB6LwprFISEg2wJPhxcHrUHgP+K8v+mcalIU0JQOD5K5wJah2ZCSHODDQPqCFl8eGrFXXsP3mhrPkrBtWekYp3ClK4mEPitX0fywx2S69GCTqP6Kux+AqSYh1mMglK3ftu7OMR3+/fHVo2/TtiY0Siy1BHKQIIjO60wlZJRrTAajihS8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUX4tIqjvrCqn8oNAd572nlHD7cCfamaFccMMWNEKxQ=;
 b=X0zFUA7uyB57rvVCgTK3aQmOZxTR1GGcBbJIGFEvci8QXwHI5k030ay0xHrIXcjQV1vIyi0AQi15xLUC6CIcKVGPEYxpX16bgRqE22bhPkuhmpMSGPsav84cAW+WQ97vYg3elm7SOfe75q+pfvKABbANkZUtAa3iZwXdv8fR3GI=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3115.apcprd06.prod.outlook.com (2603:1096:100:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 03:33:27 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:33:27 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V3 6/7] dma: dmaengine: switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:32 -0700
Message-Id: <1633663733-47199-7-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:33:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0643f18c-43e8-4a97-0a5f-08d98a0c6436
X-MS-TrafficTypeDiagnostic: SL2PR06MB3115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3115CE4B5FE70809B45D89F8BDB29@SL2PR06MB3115.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuK+LERqeWMcnH+iYHngq0LZyuVUrDCnrR8jgWD4UEZwXwgaRLpI33kAC+uWVKvOjwyxK8ktg3SrDBkwxf2P/1g2DAfA6JFa6qkTXBX/qXUEhmu0IaxSB5WTbm/jChRwRt+MIIg+qZVg0ihjbxFijQwTtyp+yhBoU6DXVepWgtuxyXDAO56YZpIBKf9HuNGWuXNwT4EUwkXcCWxqZ4bwm6x+zrf1R4nfii+t0aLMYIstgQRMqxx9bTYgd1yfkDlrMmkW7CQgPEKN8PFivTQ2vZcEzrU5mQljHtJXrbUky6kpwSuoFBO2nqFlB2gMi6xnfNEYCILd2lyIodXSbesNAzCUzh8vD+rIQQCCPYcKE3SCVaw4jtvmXUiPq2s27EhyY30rZuo5JtOeitS0M/9cL3YBXz/EGNLSLPCqmC3P+U2p5e6hTfrmeE9w6QE5tDIK/Ipe2t3iv0WPjk4MF35nvLE1h6Urrb9Xp1qPrpcrzPpiQYFthTvsnqC4Sd7yze5PgHmEK/9FC1BJ9+yk8Yt7aTYZ4/uUyj6BFLgyoN121RDOARcJG2Wzc7lBz9cu+tGIvU6Ir0TA6NeSCx2z/vL+EsaHMfik9xiNuZyG6b6l918VYwty54aQhj/DoNfQ8Lpwwvtr75EspUSEPaDBNgUOnrW6B7ahGKmPtR5rDzzIefYov1fXwxzVfoyXEPGUZ8GZa37ThxVw+RcG6V7b+h4T+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(38350700002)(8676002)(38100700002)(110136005)(921005)(83380400001)(107886003)(86362001)(956004)(2616005)(7416002)(6666004)(316002)(4326008)(2906002)(36756003)(66946007)(6486002)(66476007)(508600001)(6506007)(52116002)(66556008)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BmmiBXLrLwijWLjazzfE+67KZnP9M9nHEr5QOo9rOlWxhNcPZI5U2gIU6AII?=
 =?us-ascii?Q?gpIlJc13a3jprSdR4BjEnJOvEhbK/N2jgWRF/vkSokWXn8hlquRqBBQUi3Be?=
 =?us-ascii?Q?uUe7/pMJqup8yqChLWH395/QIvrzjhhy/hshnuvzQ29QVMHZ5OGfwGUiLVZl?=
 =?us-ascii?Q?6AxdZNM2bAi45AKVU43q50j1IGSoAf/cqdAxZeBvQVoHCgHHJx8ZfWJOpTvg?=
 =?us-ascii?Q?r+GUIVRUTOdQUu3MlkP+bEj1BqRcFMsXFCiDnF2snWlHldQlwdwzj1Yenafs?=
 =?us-ascii?Q?Jj7PpuerBk1yLECb3jo4oRwqkdybCnhA7gIr7/IOY2r8UbYOd06Pm38BOEMP?=
 =?us-ascii?Q?GXbnMFfTza25xWRg+WaMiFYK6hOUXNEuMkADzcdJnQ/BCq5WAdeW78udSU9D?=
 =?us-ascii?Q?eGF3oVhIk3TXjeJuSlAdkg/0cwaGv8dPHMfyhSWGA55bMT3YsKS6rF4vxm//?=
 =?us-ascii?Q?gouR5sx1v9kfD5svQc9mM5kXZB2tJk4GaFx7h59wWfOsc2lAOi30sz8qIxro?=
 =?us-ascii?Q?JgBIkb2MakVV6ZiU7obe+iWF6P6yElDZh8aPh+1P8qgTVc2MPIZo3OSB5KDE?=
 =?us-ascii?Q?8a4o7DvZBgq39lkVDQVMTmgkzCDOupYk/iP2hkSr589u7Yb+D+ShtDGoKIKy?=
 =?us-ascii?Q?ctE0lbA1h/7ep660Jh9i0dDa2/zbcTJeD8xmqR2hEKeEdJ1H+2vnvBnC/JDf?=
 =?us-ascii?Q?WHKXG4VrDAP5eUw73ClRiVF5+csgxBUlY++5rSMoA+965jB/04Ht10joorby?=
 =?us-ascii?Q?t8w2gP4ogFwdU5uzVzvgdwn8V0KycgXDaWDx8/hhL7Y0AxscZXWxV8Ok8/6S?=
 =?us-ascii?Q?UddLU+IM1HNCX78f2ifujC3P6reuTx9j/8zJxY6fVnrn4y70JwKZ0398qDFf?=
 =?us-ascii?Q?OnZhu51qsAc4ax0c6bHGl8xdoT2935nVt931BJA+n2gZjTQsnYAss8mI4Sra?=
 =?us-ascii?Q?B2eYhUcf6uS3GYKZzaIH5mvscxNlZ2JxM49vRKgkqpt5OBNn43fztSxhFfhh?=
 =?us-ascii?Q?T5ZCxKs+rEqmGPlDDfcf1ZGf8M9y1UUnfFTT+EbQLqdjUeA+yokIJQUpVFxj?=
 =?us-ascii?Q?8NBUDwYw62QBwALLi5NcPHu2RTemJWITVyaEKlz7MTvGZWRud87cskKRyvGb?=
 =?us-ascii?Q?SN0OMuEXbsVwe2NBCnx2RXHDEPdHZ4MiS6B66dXoi1gBiYZxAb1CfpJ/fJU5?=
 =?us-ascii?Q?RmMUTL8XEDAfHNZhrMm3wyte9k4zpCZmkxPZ/k0Bd1V1iHVa5cZ8scuZwR9+?=
 =?us-ascii?Q?B7ASS3O803gCZupmtfBIaAP8VDVUq7oQkbXQODdfj4b65v7t5c3UpPa/yp0z?=
 =?us-ascii?Q?mA8YIck40ixDJZoN2VRbOThu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0643f18c-43e8-4a97-0a5f-08d98a0c6436
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:33:27.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ9K8LObCoOrxHF5eTZw+qmoq6vsT0j5b7A3vbrVosLmrNI1Aam+ydOZve4PCOTVY+DS0U68V2F70w69CSNZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3115
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

pci_set_dma_mask()/pci_set_consistent_dma_mask() should be
replaced with dma_set_mask()/dma_set_coherent_mask(), 
and use dma_set_mask_and_coherent() for both.

Signed-off-by: Qing Wang <wangqing@vivo.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/plx_dma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 1669345..1ffcb5c
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -563,15 +563,9 @@ static int plx_dma_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	if (rc)
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (rc)
-		return rc;
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
-	if (rc)
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc)
 		return rc;
 
-- 
2.7.4

