Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4041A627
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 05:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhI1DpV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 23:45:21 -0400
Received: from mail-eopbgr1320097.outbound.protection.outlook.com ([40.107.132.97]:2880
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238849AbhI1DpV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 23:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWu0lGnHjR+s19851rhH2OcGJQ5OKa6iAHrcIf6ieNjyjJ9H/OvmUBrXI/rLYWONksO1zulnW7xuwmxLWlNSB0r3HasdVr3YMT1gCQSy7BvQOuS7DoasfhslPmUNkdvS14wfNBRdCjdaL1p6NvJaEEyAre+qnDZLccy0zgf9CxdFIKqQBoTOyLegSywjYWEbHKo/icLyRNJek7bWZg8SDXY5t4OhWowWdwpMgrqSAtjV5ID0TE6GbEQei4fCMMRYRUGokWn/czkL7bYMIk/+abiaJyKJ9MN2J9e2EFlacL1/xwcw9uqc5KrLzq8y8GLOwO9k6rkgX3rQZQrVLAK+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=olqt4TrdowC9fe1XIxjGJhri2CBGGaF+Z71nalY72U0=;
 b=aurrKCPsJD+T9ZURefqRajnaepbanDIx/Ozsvss0xIWn9FyUcxK+44f3s2X11LIdY2GMhHcX7paM7nBB/T59+bjFlYitpXv1cwKhfmmzdzgkzuU7YkSOkV09b4FxOUAboBPXED1H817lb7zxB3T6/WzdZXXEwOXLVSZdHjCbGY3J6UnVInI+zAGWw15hiPGlmIhv7Q33bwsf1W0Uyc4Pj5XKntT7DEWYeHeydvEQEGXq5CSTJ/Knxh0BvtKV8vaP1S1WtbBeM9KiLk+SSZlOIBaQsIXo1dnfs7nMMB9GNFOxylUfwvD/Hh+Gq6iQtYDGi86gz3rXgB1kzLANGsqDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olqt4TrdowC9fe1XIxjGJhri2CBGGaF+Z71nalY72U0=;
 b=JiwCq/3O4QHL+C1K+QfUDoGe6zFHrHPW0D4pWMXIQ4jVTOKttraTFxsBeobXyDmv2AJl+2zNMQK94kWtmtOhBmx4VzyBvD6PPO9pa53Nm69bj1k3ndVVQsTiHHHu6fXO2/aQWi35z3edIUIwPq2bEA25zZWfNPWAbawc4p+QiYw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3401.apcprd06.prod.outlook.com (2603:1096:100:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 03:43:41 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 03:43:41 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2] dma: hsu: switch from 'pci_' to 'dma_' API
Date:   Mon, 27 Sep 2021 20:43:33 -0700
Message-Id: <1632800614-108666-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0029.apcprd03.prod.outlook.com
 (2603:1096:203:c9::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0029.apcprd03.prod.outlook.com (2603:1096:203:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4566.9 via Frontend Transport; Tue, 28 Sep 2021 03:43:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4718c09e-98d9-43e7-121b-08d9823229a4
X-MS-TrafficTypeDiagnostic: SL2PR06MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3401456577794BFA772F2221BDA89@SL2PR06MB3401.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jxij4cJDyI1Bx1a+mw2pUqFvrM66lu44dTcqQDMCikrt6L4HvM/Kaxcx9+2lJ8zhsQGfhDueIjdCYgOVqivBtMkEmTKF019dFPRkdHyVXLoun/AmpvEW3CRhGA71INyC6S6FvHGWEEPbaYC073UQ8qYWhvXyyiuci8h5w30rzcWv9GTOcsYZh54x5Aywnjs0v8licCHbUu0moZ7FJAOd2Za06ul6smwY5r3hZBh8erYS7vRkWiv//YakO/MldioQPaZunVJLnb5ngrzMs/TiBCqHEa+rNYjuYTT/v+wiZwoINPf1UEoICCRRjp7kE28Agk7A1FB8kPwKNrHiBgYXzKPLZMWKo7EiXiVtSLvhSc9LbC2qJq70QelBj9EM7bveHLr9angUV8ICTW8WjMNDZaHMhrd4xqLKOsx3dqyuuKRFJnJbiww67Thru3tHo1PYQH9jn3+GWdQlS18EVDBKF/uRRcB6ymuA1l7BMM1MwpBJCteiBsz/cb3r7D3hXoTGHJQRq+r7teKRqQuu5d9iFshKtmD9qLrBwsV06YSvJi5Kw4vrz6Sgb2TmZy+fPHurGPeaI0V3QiYjWwqAJICGUam+CC5W9pGGHfskn2Ep42+8otTHAMHQKxYhpnavC7+DxeAhFLJbUQfyFjD2IHnfXZ3cDN97goIFpnQjSgvZMFVkFe9h65WUriYjrWWGC/tA9mfkHM6fQiyK0BDt+0t97w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38350700002)(26005)(6666004)(66556008)(38100700002)(2906002)(316002)(66476007)(66946007)(508600001)(6506007)(52116002)(36756003)(2616005)(4326008)(6486002)(5660300002)(186003)(8936002)(6512007)(107886003)(83380400001)(86362001)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hLy+zENTYmmnPAXyb2DoACNmzt4AeU3vLdfiP+iVoqIpITe7PpCZaSUwh3j?=
 =?us-ascii?Q?ov+TI5XtC/KQE4gY/PJkU6vWF9bkTmJsHdOi6luSSgWCaqlCgmLq7fqQdkGX?=
 =?us-ascii?Q?bAbDpvHBNmd9+FHaC/vglsGhNDnNHO8W8zEgFKI9YcItOd78E+Bfdcd+B4Hx?=
 =?us-ascii?Q?n352bMybCWhkmeHxBmTEnqRu7og0Q6mPn5AEkqzS6TwEAqu9ti9ZsWZS3zhE?=
 =?us-ascii?Q?kODR2ZP780sOP+Tm7xbHdFolhsRTEKlkjW4kdoH7xRd8iJ/Yhq6xh27MnPYK?=
 =?us-ascii?Q?VDzw/0dtthKxaq4vLDfnvVGV++VOsBMoC4HN0VfXxVMpIzTGjOroE7vSz/30?=
 =?us-ascii?Q?LxtV5BK+fFhKw0ZIWB6YU/REo03s7iWt6j/vCdBPXWh4Z/Sbud9xCfdd9Ld0?=
 =?us-ascii?Q?Z4QuwVLl5TLkuf2YkK6bSr/ptxO16CCva7iLDGASYakgg+N2DLcJC1CaOegw?=
 =?us-ascii?Q?VF1BkDHwc+u22Pja1J2SS+jFW8boiMN7rJpi7EXMQiE+pmuXKkrQ7KV6vfe7?=
 =?us-ascii?Q?/wCwwqsf297fbBxxl9Vdff3leKsXQutlrSQ7lKtsjaNiFKsYpVdBnmVakaTK?=
 =?us-ascii?Q?gdDv9CWXqs8YqowRkIDhR/xKTX3+4u3NzpbyhrI6hGYrBlSvJooeBnnIKvwW?=
 =?us-ascii?Q?4jmqr126+BO9m9XR+mUTdcS7fACz6tbKytv4SiWnjx+nfY/ix2EWX4jrojz6?=
 =?us-ascii?Q?XbETBWEv1v2+sTvgEJbY8kjFKg6lHbP62XYlg62dwNFHeA+bezQvvJ6GhYQM?=
 =?us-ascii?Q?YvsKMY72qFcvas7V+NQs4sWKmLzMwD+dlhLNdnRTjG6s68mqJsEblkGMNGSC?=
 =?us-ascii?Q?B6FN1CQ/LQMNAxxR1CDdYShrRuApvh5qQ9XbIlw3ysGrlKOKfBcfFeRKMUD+?=
 =?us-ascii?Q?F7n2WdJWPqfF1khbvIg6nb5f1xIHB8adeekNSGa85xhAXBdyaR730owwCsS7?=
 =?us-ascii?Q?KzHWGJ2GSwKH1bEoe+D6JcUAo/i0iWsCh2AU9u8GlErZAYCKTrJhri+rFHLs?=
 =?us-ascii?Q?eTyLbyZlDZPpy4tqtvVM4MISXhmTDr6bZDjuhBco9NJYS1lcfvPc7C7Tba+Q?=
 =?us-ascii?Q?rsIhXPcZowJOF/27HDauTBtVCCXgbkRHb87jk/EouFvSrjQhTwL5F2SeHp3p?=
 =?us-ascii?Q?PorQ+2lvCLJc4w03FMneVPrbR1smsgM5coz7KuXlgj11rcx3TA+kybeD6fj4?=
 =?us-ascii?Q?F6hm8TXv94cvdGrrwpF63qweZFRdPqRZvqxgOILlcRIKEVORylzKOWreel2U?=
 =?us-ascii?Q?CugzxZ4+8xeXjzIm6XPRGevRUtNPbAKc1GqSizpy6cgxUiVO5gxmOHZ0i9sK?=
 =?us-ascii?Q?Xhu/XQEe6geeBZMJuZMbzX8f?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4718c09e-98d9-43e7-121b-08d9823229a4
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 03:43:40.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSW2N3x4rxAfBtsPWrvnkWfAvmEFm5IxvnqV1FCvYbcOKVQFQ39SJ9CF6pm0bN8YSyy1AHPUtbmPaopxN3i/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3401
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
updated to a much less verbose 'dma_set_mask_and_coherent()'.

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

