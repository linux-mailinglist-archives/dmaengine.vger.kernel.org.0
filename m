Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2554262FF
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhJHDdx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:33:53 -0400
Received: from mail-eopbgr1310090.outbound.protection.outlook.com ([40.107.131.90]:18336
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236610AbhJHDdw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:33:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afct9weluOm2QxcHp3VedABro8bSE1dikPv350gq4AZO9nrZokSOadDDwjL8FzPRWw07J1ZtVW522+Kvqpev3Xi8IS3uKdOq/VikTv/+Fd0SHQZm7PLGMTguEtnGIpXnfsMh6C/F6TvHzJwYy3lPWI6aEm56vQ9WdoofRwTEZZ64aRUdYf+2/KBilJCmy0GkPGAFeNy6XZq3cCHzzaToRC/q451r/o4ROHp6kQF6e8kPrYuMExTS1X+jtXxyfEgVPkNYx2BuzTRNIb5tDRdV9rqVv5LKjzH2j8RLnptvzwE0cAvNbkdftd+2VMh8NDUrm0mTrAlysdfoOIn+lG7GNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZttETy33AyCw9rFq8Q28YuRLGez4P/p/jDAegGd5QA=;
 b=XYhTHk9ceQTUUzufKOhYn6Y3C/EwoZ/UfqV/OzFcLocFfQ5aH3hcMXNwYYK25VbOibbbyZJ56/7UYwEnDxGWwB0EihFaV0zfmQfShu5oPn09pL8R7r+7eFBJYvOJFGjEjKh90WLc9hvD/EHbUyHLBVdKnHhfyikcFzWnUnIronYe0V9xt6aL9CKepsko2FSvcay47r1WykD0U8ffEZmQPDL4xxYxwLBy6OsVvFDpgvUb/glUrt8GFsS4zfH2NUMl7ZEK3dIGp4B9mL066NmIrsTZBQ1IxGbRFwyQK23jk36TSzNBkibIXX5+iGqoHad0plMbDqXvUHRrZFPVeA3HLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZttETy33AyCw9rFq8Q28YuRLGez4P/p/jDAegGd5QA=;
 b=hf3NA5m1A3Hk3qM4kADI7Vj0ZNyXbPA852qheAKV8nmg3Cy2/tqx6XiPZ+VjjFA1B4M8n5KDppISJBd92JAvV07EJ3yRdx/g3fQq4VukUrpGSrCe0NErmujX+a1eL+4+2aaVrx5Lwz4M88vvaf+z2v9DGZwqsHsYMCkDf13fokk=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3385.apcprd06.prod.outlook.com (2603:1096:100:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 03:31:55 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:31:55 +0000
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
Subject: [PATCH V3 5/7] dma: ioat: switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:28 -0700
Message-Id: <1633663733-47199-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 134d82d3-51eb-4292-96e1-08d98a0c2d32
X-MS-TrafficTypeDiagnostic: SL2PR06MB3385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3385E98D42BC94EFE6CFD398BDB29@SL2PR06MB3385.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1EZivlUlRq30pglCc1VF8ZqRsxkN00xIzxabep4+rE74E2yxSSmDxHsjgJ7nfhCVfTBHyGq2qYNmolHjLRYNSA8F2vrinv/QeM6eD4zv/QTidJdlifKbXvzTuOphqogRCiy4FkSA/2ft9OyvEMxdQ95rSyZeeRIOhZk4qU7CVlHEKLELn8CThIGzwM+CaS66bnmVEoafI8iOSMSuV0KnMZ0g784zW2YZvd1gLRaUcMuTVxvaXvrXh+sAo3Yo0wDpb7sZ6rH5BUgntWTsyAQJi+9WrNOGo6Qyy4LzIkV+t7TIe9FZlTCD044BNkCuQqO+Nh+CV6x/dH5s6U5yHS9OWbJ5tgznEaZRijK+06xGHgFahrGZqOG7/j3tNx6bf40+ZCp7T/GmvNprga5sE8CiJTihyIo9B76tdpJj1loHpYFb+0MPTL0IpFKExgMP6mpMpraMkRenDEfom+7vRhEruGSe5EBzFg0Bu5jifU18yf3xiBlTwlxQz3Pp2XAHV1lTleUtMWKEoabh/6xsLqMoAL5ehFZknQ7rBsCSluDVpxlMEqN1V1ZpKX/U5/gofrtUNs5Qlb+/Z7b7ILehx7pC1OH8YMgaCfJZqwozYbnd6WlS1XjQKubAJDT/N2i6Xl7Z6QZiQwyWI+GDA5ETlaMubUmT2e0DVS90HIgRJjQAmcodyFnNI7VH2pdE8Grhw6D6dsxcxnu7JSYTQBxyKaOxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(2906002)(4326008)(38100700002)(52116002)(36756003)(38350700002)(66946007)(66476007)(66556008)(6506007)(8676002)(186003)(508600001)(86362001)(6486002)(110136005)(107886003)(2616005)(8936002)(83380400001)(956004)(316002)(921005)(5660300002)(6512007)(26005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhdLzn5mo0aVDDRT2Jm5YGXYNOehObTBSaoRp0UrB/vJNlIxGKS77+v1v5vV?=
 =?us-ascii?Q?yt3RlprVrem3qtZvUG5mXa2DWslVeMH9PnY9WPLsyPCoEBheeCty0z8Ye8fL?=
 =?us-ascii?Q?jJHUsbHENK3P0fW5AhSgAGkwyPSBmdeZtaMK38xrCwhZNGSTnmd9njFNvXxP?=
 =?us-ascii?Q?6LGhNsMP7sCEyxXUVl6yo91+8PBuoBYP+fHSkSlIlaU/NK1AlHDeHxFWl6zV?=
 =?us-ascii?Q?O8f9eIxy2QX9Bpq/Ko8NnwF62pkbI5qp0SuesPCjBRWdKkK3oy9/s4Uburct?=
 =?us-ascii?Q?ume9jKGtruTUG1TgiTHq1EiFbOuKVt9LJeiMMMzCH2LsMMDrnnXTGKmMoIR/?=
 =?us-ascii?Q?JfiKFtwVCdnwWTmJ6c6+oP51FPk7Z4+ki1eqjAuWForO58YNNM5Y8h6+5Cov?=
 =?us-ascii?Q?vXpF5w65ancRK+eftLr92kvMaH6v6VDw/lnRiPT8fiK5WBHDvwgtRMZ7t4jO?=
 =?us-ascii?Q?yst6s98b+xivQZiK4RUc+M6DM/qqGI0MV7JK336yHH6r9M22sXw9K5ll+cwV?=
 =?us-ascii?Q?K1F/EhOCa46Nh5p3BOUBvBL/L0QVeFsLytVZ9FbasFZdwS26U6fhSLTr46HR?=
 =?us-ascii?Q?QHKsBQPqsdPQ3Fpt0XSoaXzm6PwCYQfLidZKuWByW3HbruLmaMzdlstY0I5G?=
 =?us-ascii?Q?npX+4lLcKNfeVmVlv+A8LUlX8bQwNnrLqAJbO592HhE4iZpqBu8WYwnNUiYT?=
 =?us-ascii?Q?+JZL9Rg3evWdg/bk0kvvx9Dvv8KGAb+lcUDWRg2W/n9WW444mRmcmiqPTXZF?=
 =?us-ascii?Q?UpvvJB+R4GCdwecguAb4VtVwSDfMJI4lNMWhBSFsB5laFxxI26NAQRGUMnvj?=
 =?us-ascii?Q?aVCh6AZMD1ghSz4NsBAaie9pVJQItSA3A+Xx77drs/UspwwM1sKDmVFFINg2?=
 =?us-ascii?Q?rIzgeOLEtwW6Ec5MXYlrzcdPeJZnqSIzCFFrFJwtcyLr8gyglfcbrcU0/oyx?=
 =?us-ascii?Q?7wKCStGq/pnp0L2uxRg5Z9KWhJE8QsFKfz7aG8LBlaGMBMsliWFRmXWuvwak?=
 =?us-ascii?Q?PLFYzft0p4/S3QSWSbglEdp2Dm6mnATPb2wGFIrCbBOL/tNucUHFNQFAQXgB?=
 =?us-ascii?Q?9x7duhvLWk4ttcLm/5S+kN04HD4ILAFsthglZQs1Z21jbQfQgIfPUp9T9ZDd?=
 =?us-ascii?Q?9JKs4TttimvrlvMa7JMNo9knzuLEpXAhINUSC69c0r0ArsYJTmdr9Y5Q+/TR?=
 =?us-ascii?Q?hktPQmLp55nsmcD4B23xLKfjYHRdVG3bz1SBF7VdSho4QTxifVolOKVNdy1P?=
 =?us-ascii?Q?fszPztKgmkwUnhWxVpuct6VbCDoKdH/tC3Gg4v/DdBMtjp//MEz06Pu43eJ2?=
 =?us-ascii?Q?ASyj6OoeE6stLhmVp4GQVpwb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134d82d3-51eb-4292-96e1-08d98a0c2d32
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:31:55.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FKjAlggb8KUnkvlPokHBpy68cbnlw+0ONuuiF0uOdCHGU4KC9BBBrC0n3HdGIhXm+uCK+FgrHTJNwN1AU19GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3385
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

pci_set_dma_mask()/pci_set_consistent_dma_mask() should be
replaced with dma_set_mask()/dma_set_coherent_mask(), 
and use dma_set_mask_and_coherent() for both.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/dma/ioat/init.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 191b592..373b8da
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1363,15 +1363,9 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!iomap)
 		return -ENOMEM;
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err)
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
-
-	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (err)
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
-- 
2.7.4

