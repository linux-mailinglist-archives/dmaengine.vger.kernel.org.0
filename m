Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58742630D
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbhJHDfK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:35:10 -0400
Received: from mail-eopbgr1310094.outbound.protection.outlook.com ([40.107.131.94]:64336
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhJHDfJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:35:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBiw4GHEA/R1g4GV5ZSS775oto6bkkOYsVhuOuxAgbhaapuXeAN72YjiiprfzqvQcyhLGoRPJfG3Hfl5xVOIzRKeqeGUVDgRW42wKvYNlx+8/VVxt3rtklLfjdyiisUk4eY1h8/qVDOT87RDvvQCtmV3dQy8HmHE05gxfNCcOAFFwL9+2/x5wZ+LyP3CUz/Spj34J6E09yUZYJaa+7QcnQ1YAfgZEgs/f7vEULV76m0Nh41VoFO0uKCebsVbJXShg7x8IW9rESxZ8e/G6w6uteQlGrGAOiAecDxS5IViVGfUX3b808PjEuLwLxh3y2JNwODVu9KpCVbE8EnXfRWy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=029/jm95S78LNSwOZlQt68KUOnMC+fqeFdSj6kUvYNw=;
 b=DTd1BhYSKa/mmopyn2zoWpJjDZU6xxIcErS3WCz5CgGXzg0uNkw+r21tLUM9OMa+zVK31JhR8cXwgihEsThLjsPoM/ynpA0tloyFbzpXGCap9cFTogBrnlbAWk8epELAGfsGx0d4vO97+Jc/aNsXThraIVQnJ7mgy13UsaKBgpflfIHL4UKAIF/VXbeHC2zikd7C5Tt9TAMC/IBGKIfShxDzGh8DLPuOy+xOTLT24+KrbiYsaGojveFALep2FkQzJglI4COB8YmYa748pJZIZevZUuB1OQhq5+98mqiBPzwJ/7+njE8BDNIcE3UifucQwBZTOLWyAk+ddPWzsyza6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=029/jm95S78LNSwOZlQt68KUOnMC+fqeFdSj6kUvYNw=;
 b=TKjzIyG7zoxgQOnGj90or2PJSwOoIb8dG845E6cZs3H4m68f3MdL/M3Ln8POAlbjWjYM2bkvj1tIkXOgGv5GcjjxQ9jb64AfZPjmLV99gcw2qlmKICqjeT1i1ZlXJSwlphc/lHqjI0k1/x5jfK1PHIYn03edumisVJg6AcuZgRI=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3385.apcprd06.prod.outlook.com (2603:1096:100:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 03:33:12 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:33:12 +0000
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
Subject: [PATCH V3 2/7] dma: dw: switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:31 -0700
Message-Id: <1633663733-47199-6-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:33:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c421ad-fc53-4e3c-991e-08d98a0c5b21
X-MS-TrafficTypeDiagnostic: SL2PR06MB3385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB33859CDB1A5E1E336179D373BDB29@SL2PR06MB3385.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryBsn7ALlyCeYbkloTzIP/KJwq6mPpcbUmgkBIc9jHzXWrQojeyGHx8VSrzP/76QlfLAe8nl9qTzuUZ60bKS4PV4e8vf0nOnSaxoQgNaTWAWGiqpOj+B9LDJQ0ucs3naghO4PDLpFHkbfDuu9saaDT8WgIEZEHofYuMb4vJjQ6bTCjFzmtF+eDJRp9yM1yt0Cryu8q4ZsZHnZ4BLlOVyglyaWsqaaXqZbHO98SMOzG3dEaH1ATfJ/yaDZCe/L2FKwbEqHS/ldPYTiCsdLT4YeOkz4b2M7TvVpCXUWm3Onf/xJUJbE6LJfq49nWPmVRepEE6Y5WTBwUspNeISfbwZoWtatoJ6Gj2HYSrXnb3HvwB4hqqoTgLC1/Ea2h5bUkh1YjQnbuhMj+1K2Nbi5mAzc2qg0DgAMNQFvcZeZ9qBGwF4yrYXCF7TKQa9Fri9FQPuCn4zvrTnCUNx61y8NLINyxSSjMdE5mjI4xJNGBEUkZFsQdrmYskFDXSC/DTySI9TDoelcFMNJyzVe5tkZB95YsHGU4XkDFIhV0npaAahX6uW1ia0uXzhxLiWgJi74XxU4M98Z0//Oc3EpqwPc8znZPii/ptHOL1H16QvzZxczJMZKhKkgK/RIAUWZ7YsafhY93rlxkIrYd38WtfeKcE3YcajBcoOnqt2YGzdq1PwtRX4hK75gC54H2a6Md8QWmFarcxiOb6DItbq75Xe1VkoQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(4744005)(2906002)(4326008)(38100700002)(52116002)(36756003)(38350700002)(66946007)(66476007)(66556008)(6506007)(8676002)(186003)(508600001)(86362001)(6486002)(110136005)(107886003)(2616005)(8936002)(83380400001)(956004)(316002)(921005)(5660300002)(6512007)(26005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fXTiZnFJQTvXp0Vr0tHJmh751o5AKuUxRgVl1oz1+TuDJRyN1vu+PBPYBgg7?=
 =?us-ascii?Q?m4F5vkkbVpQCttcyx8xicb8MZ9v+pIWg3iNMKyoVQvea+c4EsDPV4EMTKt9W?=
 =?us-ascii?Q?DeqpvA0fP3g08Wrb1RTlIeOew2ticatDlB/7M/IyTog/4JU9CD5BWE3wdeXx?=
 =?us-ascii?Q?29ZvQceiRarGcOG/Lt5M625BmzJgEVYuOmwrzpBMW3gNUtTSrBZjWXLeqj+d?=
 =?us-ascii?Q?H+B3EntwSFYgu0lo1E+s46o8wPTTbYWH8rd2zBt4yVCX68VwLFT5rCExUeWa?=
 =?us-ascii?Q?9G9CljFKi2OVKYNmK5t8S2R+N4Ar2rvFZFNaypc0DnC/RTjftuMmaRTlP5dI?=
 =?us-ascii?Q?pHDUClB0mLTpPYuJ46PAPxnew4gFzJadsr4lkVdvUEAzcJnX9PZahAWODEgT?=
 =?us-ascii?Q?6//5uIb935UR0Ac6CGtTweSl66uMEOW/U6ZBDPqMVVG8lTc7wkFEcF7txzPi?=
 =?us-ascii?Q?OlVL9LNvFYvezVUwOgsgifj3Ul9aXjGtJmGRmyDoFTlFiphGQg6SoVoTNLzD?=
 =?us-ascii?Q?FpwBmjo1hRkolAh9hrUSyp7efxOQXhV561AsdN92shacTUFHDX3M3PmwyVwB?=
 =?us-ascii?Q?x90xr8SABMDLYzo4wZlwaKxVScwx47CxPCjpZt6iLEQv1Ylcs4tvzmbAnsuA?=
 =?us-ascii?Q?fi6KrojRKnc8DCT5clzYMapfktnvYshCdaB30G19YMRpe2afqVboDxsBgL9h?=
 =?us-ascii?Q?ZFzO9gAkSIgB0vbqcv26faaohXEhnpIb8/uiN3Ea6zUda76GFfqll+hy1Rc+?=
 =?us-ascii?Q?8+CQV3cPgEokBvuAR3Kj9tz3caFGWYkAU1+S6/Zo8kH9LGXnFPPd4X3wHH3X?=
 =?us-ascii?Q?oRVSUc3o3nRaO1OE5n0OE+/BU3fz1ZzeVVFsp8uQDWPU0iM+V0hcxt55uXGe?=
 =?us-ascii?Q?Z5/0R5PFjhQxHtyF4IcX5cXyaOMxdOTKMV+cikv4VtxVTdk6/zaIBAx6SQ3S?=
 =?us-ascii?Q?AhHvX2hin+r3Wy/FoveWBVgklJ4A9xEoyKG0vDs47bH3wzxOw6BT0j4C5ZT6?=
 =?us-ascii?Q?207vYZgYcaqqA4SRUSgJGdB21FgO8XXA2CqwijbKyEIh/4pjS37c2RQpJim/?=
 =?us-ascii?Q?PkALQQHJuAtbFpPeoO0/9DUT7goP6AGd9qS1A8IbIzIgpHB8+H9T9WmlB14T?=
 =?us-ascii?Q?0QReobHsjYL5/iigPndPKxQhS1L/ymUys/Gi53Xc05pWkG0ztos7h9c0exdP?=
 =?us-ascii?Q?Dafn7lC3UrG2rZlw08INyEw+5KvpDJI9fDHgo9j4h3l9lIGQTXurkgvzUHhI?=
 =?us-ascii?Q?JyU3gCByqfEEGkrh/OtY4rTYP4gt5Tdb/lNFLu9CHhQr0/IVyECNa45i8yEc?=
 =?us-ascii?Q?9j7RNTfFfu9ystLsh1NApzDa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c421ad-fc53-4e3c-991e-08d98a0c5b21
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:33:12.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgOg+j/GzkW0VYb8BiUxysn03eQfPtVnedaJogPa3nSNYtW17phsU47NzUfuyOJGHEiW1c7MxjSv2Fd/VOu3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3385
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

pci_set_dma_mask()/pci_set_consistent_dma_mask() should be
replaced with dma_set_mask()/dma_set_coherent_mask(), 
and use dma_set_mask_and_coherent() for both.

Signed-off-by: Qing Wang <wangqing@vivo.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/dma/dw/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index 1142aa6..1dec1ae
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -32,11 +32,7 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-- 
2.7.4

