Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4D426308
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJHDee (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:34:34 -0400
Received: from mail-eopbgr1310127.outbound.protection.outlook.com ([40.107.131.127]:3200
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhJHDed (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:34:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgGTR0AMushPtXUy3WYjYlqcgLI59txVYL/x61C7TRj8rcOFpp+h+Ujo2MgAFpvBrNh29DDWaZ9D3xNqGTQujsWWYex3H34zHp5EHea4RUOhKRCoGvKjQqd4h5dY452muurilZwlOUsxaIHWV1vLvaUPkdx/26nqqvndve9drBepANekpJ6bC87R7SG8PeA4lPHUQwAyn0JD2Zi6idfmyoZhdATB228ydSGin5JKmft7lTFjGmgIN1yjxtNB35+3Q/ld5SK3nmSliIx6hzd/DfvOc14W4xkOYOC7Rj33FH4tb1TkWFhk9ba7JY6zz7vBVx6BJbwESUaIc3dqYfxEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUioWZgj2o/OdSpMnMKqYg9ZwE1wWxylkGVJk2z6JIc=;
 b=CLZaXIvBeJ9g0KSQDwUp/scn1q6EY50acAV4CXk/pGMZPO851Kj5blW+I4AqxcaSSlrhs68ku6mQbt35aYd2azAz6FADPuZwK+s2yIkbjQEueGS3gl/sa3YoOGoZ1eWG+FGGQ/QYO8NXXAu3XYJXGkdmb3uyz4h8lQaSr0usDDvqi1/OUe6TKiCpq+8CPkVDP219g/eb67M3N+FnmyD91xBkev5zLeI8f+k4+pKVzzDSMtJ/9b3vPkerkDcTjmZcnilrYUbqh8nBXbSvXetUIWwxvO/scQNPP6uSNskGTzo5pdpgxdDBVu9Xet/bLKrIBQFTa7ZCq1CX4NPYHMwBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUioWZgj2o/OdSpMnMKqYg9ZwE1wWxylkGVJk2z6JIc=;
 b=Q6S532VPjOq9KbeHy5eVuLm0YY4q+fqXqF2UavGUt+6w9uff0RyEfdf8bZfW+2TK4AvjpyLUXbDxyGj+PQIQd6+HXNYdpsryGmMJnv/Lap1Ls1QxAVufRkll8lwTsjxTg4AqYqwOXkCPg/9h6x4NASNpe6chKD4CO44hU3WBYUQ=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3385.apcprd06.prod.outlook.com (2603:1096:100:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 03:32:37 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:32:37 +0000
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
Subject: [PATCH V3 4/7] dma: hsu: switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:29 -0700
Message-Id: <1633663733-47199-4-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:32:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ded3f6-76b9-496b-6011-08d98a0c45ea
X-MS-TrafficTypeDiagnostic: SL2PR06MB3385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB33855AA6994CBEE59B91232EBDB29@SL2PR06MB3385.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4pag+RJByIydXEqQDI+gmgiInUeUxrAZewt3cDEHAO29U5CrcM2ck0D4T/K+dw2OlsDTHkzp/JJ0dmGSE6c9kZ/hSTvAeMJKizLrpYqzjyG9HIm2m/7Nr4tvjk/hkrLnQoBJLWR5fOsslVQ8lIlG/6tV95YNdXsttRw+ZQ1M3rYlKWFMBECBte5cjz5MCepaPNNPmvz/E+gZSNUcbWAhIkTm/yzipJYAJcKNmhr15czjtxSD+dtk9tHC9iGnOVTbydXFE143ImGOPhFnVFjMMTeJyXZT8zoBHGIjCPvv2H4d54UajRsXRGzpBNSbq9LMvTKeijGHRFIBOkbVuCKcAOm+JcNaoJMIUDNdIpQ6FObyLQBe7B8laDnC5AyEa3OugWUJzvpjgkTT2aAZw0/gbS4bkVw4L8d8E3FdQSxu+gqO1vrcCPrLX/m/F1KSIXGuxqV0P/jBVq6nliOqUOpE78CPx2SMYKnUSrp/jlOxnNlkA1QHSBwFyQTmaFcuV3Iy2P/MhIkHCnGDC2kC34Z7cBtKS8hh6xRxClgNKHnqNXQinLji4z3esehxAz8OlVrIodxVBTkPNG2vuu0qlvypmkBJg7PpyxiUGeNLvw4rSCWBPDuTqkZOms5SRoDonIDUCLPUWgM9kZQjpt7B7agcoVJdDKWjKFEvV8HLV7lBnz4PPzFJzbGipSRcriEAxKabf+66GI6i2fAKrwRfsh/KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(4744005)(2906002)(4326008)(38100700002)(52116002)(36756003)(38350700002)(66946007)(66476007)(66556008)(6506007)(8676002)(186003)(508600001)(86362001)(6486002)(110136005)(107886003)(2616005)(8936002)(83380400001)(956004)(316002)(921005)(5660300002)(6512007)(26005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzjew0gh34OWTzLw2kb81RI+VIXNfklUP2rZG3tIYc9UCBylSdNbg384R44+?=
 =?us-ascii?Q?bcHH5d7GKJ+mG/5CPiI7V4ZzrcTrLh63D8SUta1CmcflIMtrIB/q9uOOR0bE?=
 =?us-ascii?Q?Fw72Oh6gPG9rDf9KCeRQilhC9RJl1FODsJDR8SwvT4PGzmpgDANDeLE3NGmz?=
 =?us-ascii?Q?+oUpQAqMTQG+i9md3404BUvR5uK2FxpX0m7TRNpXtq7pYQW0p+Q68MZX3Zs0?=
 =?us-ascii?Q?jJLDgrVxkIx4o7TgHYfIwLMZlptccDHaaloD7aPVvCshmIHMd5it1/SuNElf?=
 =?us-ascii?Q?wIJMhuHcUw04ADp8SK0SNwjWH3ebYZRYcq/9uY5hmJ5yn6H2O8ZD3gyW3aFC?=
 =?us-ascii?Q?FgJ5pq4GSiEpELQjH/gji/pNN92A7lw2hF7vKDSdHc/zBIjVkbygkYFkpSCa?=
 =?us-ascii?Q?k4XknHOoC6QZ+P512aRdAZj0hNPX5/BR7/6zybhb8V6egpHnK5B6DGQ4MNB/?=
 =?us-ascii?Q?3g/b81hyzkPyqph9NpRMQgz/Wiew/CDJVmn/9luqDr9/5XKlC3Cv/0L/44sW?=
 =?us-ascii?Q?ykMg3qe4Y4b5G6QJyOu3mTBYvJI5QCoT+ANBPLtYjVnWeCL8OXOAyGbvIxWW?=
 =?us-ascii?Q?hH/a7IK2JdHwjUooPA5C5C15PLa5q4MkOs7tdW53A8VIANUhYbFOXz7DxDmU?=
 =?us-ascii?Q?xKcAWzVcu+rc0NBjmR8z/oDCPwRLD0XS2UgBktSoQ5XZ/wklmVxaHuZIU4SR?=
 =?us-ascii?Q?TIcB9Ng4VEwPNAWUIzT73N+8fUQ3CM3AxV0QMlgsrtW+8o/cuPA+Tlg47GWX?=
 =?us-ascii?Q?O8cWUiKNyxCiCg8Z499fGtfr3aEFxHMygL5rk9a5x3dCyJ3ZfiOieyTFbX8Z?=
 =?us-ascii?Q?czMKsxdrfncvWh1a3+jP9aOknu60lY5rnR++g79JhFSHJcBTs46Va209qx27?=
 =?us-ascii?Q?er/Ytjfgj8AjbC3pF9KE5bSRpLfwjoT9HR6HFqyWqtNOSYNHUqCgLqv0G5qg?=
 =?us-ascii?Q?5ZumoX4TUZ2Habq0TyIvEVFcOZ5cUEqFzY01kLeLQBKcM+1aVIi4eelfLymc?=
 =?us-ascii?Q?JNIExg70U0vewiKA4OZv2SXJDlkKZaBquSWuFnPQZqhflCAzaplYGQKjZn+E?=
 =?us-ascii?Q?BT84l0X/FHyuWTKfb46A9kYT+9k0p1qnPWyjVyMO59PH3J3/cnqF+nydP+sp?=
 =?us-ascii?Q?VQPGvtxJ8fGqFh0R+jlIhJdBOWiyLmkln1bbGc54hmpdMgzGymNl7hPmqtMC?=
 =?us-ascii?Q?KQRUZLfptcJ0QdbphnE+AtOXgXkEFF0ilIIp2yVWOrdfz0F4T3sHEpVpDksv?=
 =?us-ascii?Q?2wpLhTJAB7X7dH49FAmFOSFUh74tO/zkageo2yiiFRIpmKvHtGg5ena4m9X+?=
 =?us-ascii?Q?a1m6Xp6oEDE2ZipzNgZJfbyL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ded3f6-76b9-496b-6011-08d98a0c45ea
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:32:36.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8qs2WNx0UgWvvIZuRKwdhKX7YY5aHDHn7i99i9FpGklMXJwqD6Q6wVFo8x6bcj5KCIxuRzs9TWUuihGU3D6pQ==
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
 drivers/dma/hsu/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 9045a6f..6a2df3d
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -65,11 +65,7 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

