Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6776E41A625
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 05:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhI1DpD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 23:45:03 -0400
Received: from mail-eopbgr1320097.outbound.protection.outlook.com ([40.107.132.97]:28176
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238849AbhI1DpC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 23:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfyRAnHcPjngszf19ey1JqlDGh5eUk+d6/SccyKJRBM+x2cOh66Sc9Ex88VYtTFHh8riOCm/vyKsIXuVwiceSl2uoW9XwSE2mN8IKIxyHePnikRp6HSCKY5aBDUEeGAl9u62SNKITShjvNvZMCFg51oNfbLIStiWsWf1rt8YAUaTZr5XpVaMjifXKWbFlp0QGfZgWGdrJbZBFtG4MMSS/FKOigGzT3ULW8hn+88D8Q2zV+yg9Cs+1EGsswnYD8BUYWeL4z53E41hQI9Yn9V479Zgy8vxP2BvgUzLgk5kcWWFRQNodIe9Tg4vD8KuYTHJmVOoTv8CEIHEXBG9q/mcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m5u6JdV5/wRNVKgtLlGfLRHF810sPODkz6bk5HbI8/4=;
 b=iCMSnwFF9APzftnKq8enMxbcEeuZBSnaadRD7IDjdT10RLSeoqGG74YPz75kvrvhMUD48XyYGQwhC5zLEP1p5jelagWPzrNEa+9C/vWuIeJ3BoUFEnK5H/x6mJ2iV6XK9G4V6glPn3jK7Etyi47EO/kIpZv0UWI+bDB2URD985Bg0iCaGBju63cYutdztDgKcrWqxWuAmjus48SqwiZn4okNYgmO5mF5ghiSE3g+U+TPR+mVWNAITUWZJvJhLebr6/eNGZBcSDmKuSFbj2PLRAk7mtsN8kjwlHvG3tgu4FGg0ewlD72x+RZfbW6Fg3D9HrM7HbVJbSgyLalw4se6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5u6JdV5/wRNVKgtLlGfLRHF810sPODkz6bk5HbI8/4=;
 b=kXyUtJksnd1mrMsVVStOte0A2x//StIskN7y2g54TI0YXtAvmKAmHscrZm+q5xyCbA0mkq5bLCzzIdQwzSj9H+SpfSs9ex6R3zMpESIUQF1pvrQ10+EYWHRhz3v1YG+gpdmeqt1A3PxdUJMRZZ4vdAcXqb/L3znYcX0+IlcVioo=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3401.apcprd06.prod.outlook.com (2603:1096:100:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 03:43:22 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 03:43:22 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2] dma: hisi_dma: switch from 'pci_' to 'dma_' API
Date:   Mon, 27 Sep 2021 20:43:14 -0700
Message-Id: <1632800594-108617-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::25) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK0PR01CA0061.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 03:43:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fdcc029-ab30-424a-8c31-08d982321e72
X-MS-TrafficTypeDiagnostic: SL2PR06MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3401A3E6C3D8934D21B00844BDA89@SL2PR06MB3401.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5AUS6Da0PjeCmuY9EM19yLQmCG4hAhvfe9mY5dpLGgSkCPPUTc9Ua26+3Dz9q4SPtPBAZT6HKkRJLjPSPI1/gqFq6FvzE3GxMUUjLCc2S5aTZE1ZdT2qVPzyJq6u98GYsnBi6rGhp4wk5i0H+oRF4FOO6iXW4GXKVTICQ357wwhq1sdauKSJov74EUciXsU5QydLCNWnTJwr82rBZCwSMBaI/+Em5G9ma/my6PxfZdAR8Z7GwzSIQ0F4XSwL2k6FzE7yufrOOtXXT5Wge8w99lhO+qA0iFdoIhWWNXu3FKiwMhBXKL+/0fWxe4UuM/79sfAOBuTgZMxfk/24Fv6qqNQkFSP66vhtJoP0YONz0J1RJMdQ+7eL7l6wAVuJfPvkMynAY/OXkkdtrbrQ6EAcgHkDLo3FrigpsHr3nI0PtNwqHWbIK+zF3mCgB98K2oy4KryMixCeWA44xFzzhR6HyDQNB6JV1bgHE8kmEoX8Gb5DTiLbzoZrxar39mg4MTzB6fJ9oiYQRZVBJD6UWzSvViVD8AKo03rDKLhomxH11PxsPg6EU8evfquK893GpYR+xkiiY0BKbhI1Uz/BeaB3VKN84IehhTqzno8dQugw3HsO4yzJQFmKIdTwZLQ56VCzNmdHE0SplahTDODr8EaKe0lmAwJDV+QszVryKkMUMT/7PRQwND7KGYuya0H7hIYD2Wy9P3guN9LdTaycSKuXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38350700002)(26005)(6666004)(66556008)(38100700002)(110136005)(2906002)(316002)(66476007)(66946007)(508600001)(6506007)(52116002)(36756003)(2616005)(4326008)(6486002)(5660300002)(186003)(8936002)(6512007)(107886003)(83380400001)(86362001)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HHfpfTfspiH3WYV+U0f+33eOnHs8a30cDdONx5mOWIgLn+/9GGr10sLuYUjA?=
 =?us-ascii?Q?uRl3Nep6Kq9ey/aXU0UisKdBda+NusSgzdEY4nHqxPEWGbUeVdVsOcRpgNIb?=
 =?us-ascii?Q?DaxEaE8ygRLJT0uOGoeuT0AkVQdAFKR9Y+hwkx/yiM7DllHAtmMuPLgMJ4UO?=
 =?us-ascii?Q?AZoO65j1/Kkot6r3whM65tRonKrzgo+fmeoiTcWsiR5qRflsAoNGNSOXSmVE?=
 =?us-ascii?Q?yp7H15Lp8bsVa6tFNdTqBjPIiZz2iFbkYIHXzvx+9SjeSF/hK0FXAZpbCK1t?=
 =?us-ascii?Q?yWFv7AraN92WP/51YWdgnljOmjEigaBU9Mf1Kt6TtrqKpmmb45G92mTVAXdS?=
 =?us-ascii?Q?FpzEsc9LN8hg1f9+5qrHe47tlSXHU6o1Ke6TVWtrSaW7WPU+7pNPVnwdSM5U?=
 =?us-ascii?Q?Kt5tRIj1PY+zyY/DQPanb9zF/9IxnTmEo5M799/Nq8G/T6mA1w5iLD9t73Tm?=
 =?us-ascii?Q?lLE6hAdp4ogsOTkpQT1hUJYQ7kIlSzIvnhPJWRenDnaEqjaXbhI6ngGPQgfO?=
 =?us-ascii?Q?SI9cNESaXStmE8cnVGtmeyChAkGjOlf2snm9XzFzN6Ogfu9+IGAgJbsB/x9B?=
 =?us-ascii?Q?y3LNbZX1ssl0QmbmvwFSLTEtPmqByHsBEH4TZrekhMg2LHy9+AyU75bBnW4+?=
 =?us-ascii?Q?4wDGjxVJGi60O4PkstZtFSHUGnTkNehZzHqSoojFEtCGyv8Ww6eAowq2xKCE?=
 =?us-ascii?Q?o4u71zpDYCKfvkIXmhuS5Myok3aTtkYhbCxa6xCnGOnK/UE2i8tttAT7oL4Z?=
 =?us-ascii?Q?hUEcmfUPp8DLfKzq2hxVPmJqWTA2aRjbI/B+C2ia4ZsF2sg9+eilthhafatM?=
 =?us-ascii?Q?mv7cGQ7UA2IQhGIr4ulQa8QGxTkEG+X9oUWSoHqCERplRK/6JpozGaPTLOcf?=
 =?us-ascii?Q?egZrWEB1sTGlA81gPxOgoUyMqBCtu3uCO5WDhu5XyuGhkU7xntDkhiDyQUoW?=
 =?us-ascii?Q?mW75yPCDXgY7wfCeZUWnRCpxUHXy69Mh1XC+MbGvMqhND0wbqRgz6uXV3Ntx?=
 =?us-ascii?Q?o9FkprJwWPHXNqVOJypTY3B1ScM/DGLt4jaGBdDfbRTuC0ATgqw3aqPJMEaj?=
 =?us-ascii?Q?MxpAE0/efzDnI3RnMQND33FwG2JtQmcqBKETc3Ev2Rtl6UzmXDV6G2lY/ddQ?=
 =?us-ascii?Q?le2DGUVy4o6FaPZrEA6Hs5MxI0h+SOsV6+S3Jo7UOcmqnuYxzHtQVknKbxXf?=
 =?us-ascii?Q?j8pnipfqcg5zBuBW/gFgO4jGGEJfqwhvd9JCDjYkQrJW4N3zO2vunTr3KDQR?=
 =?us-ascii?Q?sgsw2cJDgGha8/Or0EkMm96UqwiN5Z47iC5UA6qfkbBJfh/x2nVwaMz/5SlW?=
 =?us-ascii?Q?N1cDEen6nMcH6QAOJq0oBsm3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdcc029-ab30-424a-8c31-08d982321e72
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 03:43:22.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDM5T9MR/RJ129BzLTEXNcIbJ1t1c1ONqnzIxbSTR0bj3nI+iFnqT22T9pTEcyuufmfCnDdXUF+mBKyIKuiCOg==
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
 drivers/dma/hisi_dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index a259ee0..b86f856
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -524,11 +524,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (ret)
-		return ret;
-
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret)
 		return ret;
 
-- 
2.7.4

