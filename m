Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B75740F2F7
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 09:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhIQHSa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 03:18:30 -0400
Received: from mail-eopbgr1300100.outbound.protection.outlook.com ([40.107.130.100]:26624
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237083AbhIQHSa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 03:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWNSpUUqjzeo3NncCWTO3+zyFXV9K9cKhOpNsb8bYxwcD8ev9A/SN/11/p/zJvzKtjd2uig4EcsMvg3yjeED9ynWo0mb71SEh7AgKUnRsc88F1GOXftGLgzRy4V8ehV1JvYsMiYp7g+dMqxGPclzm1PY8V5uEpgOxBo5oODtRYbUqEo2FLfezdI5uW9JGlwA7qoh/xE74AFtFRwl247OXpAPmXqROO1a57nKANPvF3n+7BZAk5L64S+ZyScvjbhH7YlJ6Aj4t32y81Ya98zY2Mfymiw0PE2w8ZBEHdAC7ztw5Zfk+12jh2GvZ3RPtdxy4RG8c5qHoG/EWvjiaWaN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wBoC6uvBlLZ+CO0oy1OYmE34+WItnS0F0+Fmml8pLXc=;
 b=h8LU+DLKbyFXYUHC5dCh0f1HHACCa2rugQSiXkkkVM+SejO7oRJaB7o98tZz+2HYL13IAUhakSRxu8PoaPPDnsz9Khb5yIMHZ1JwfquU6Hn9N57KFBJG+7725DB2KWtokvpXzicFnr4K2wWMbcOybreM1uYJkcfYmrODvnKlWXXGxrw0B0Xy8Ut7lpHOBy2Yp94d1bWKOhYhmYQWmp2dDs8Evqyn/8GcCXtn7FwQf5RCfa2DlcoCW1dCSm+CrMq73NqS1TsH/6ynJtpw9EoWF8HVeUcLOFbva786I3j0iImOLFFZnRg24mOQpfyzH+RNOI+O52Nk2oblbVngneAwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBoC6uvBlLZ+CO0oy1OYmE34+WItnS0F0+Fmml8pLXc=;
 b=hEVUn/onwY1qwdnmGRzBdCVEr/GsUzei9bLnng8VX1RqL5oHRMSgykcwgtH5W6GJOP+Z4E63oA2QUIhW83H2ZPw/h3KyG4xYsubdRBis0l2Csj5VCMjVKgDWmIPyEVB9dbggAnqT6K5Psy6OtvP/bL7fgbmAe39qMw7Bmm0Gko4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3068.apcprd06.prod.outlook.com (2603:1096:100:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:17:06 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 07:17:06 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] dma: hsu: switch from 'pci_' to 'dma_' API
Date:   Fri, 17 Sep 2021 00:16:59 -0700
Message-Id: <1631863019-10083-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (103.220.76.181) by HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:17:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0510418-3c62-444f-2b65-08d979ab27c6
X-MS-TrafficTypeDiagnostic: SL2PR06MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3068E3FD11BD3B805DFEA77EBDDD9@SL2PR06MB3068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M86B4nQrDb/u2fofL42SuwI0KNZt5eBXCXXC/6otSF7Xx7wati3kHv/9/8lLmJOXFa9JV4xhqXuhIvpQW2fip6bpUEGhUlGn9FgFE+PoFVjIDtaQPUz/v7ZIhGZ2pvj8I1dnJEAtn6C8rY2qY63hZ3HGhyKqhfBW7TBhTo2AB81TDjj7b5qcjeN2wbgYTXrCnc87KRJziQgK0nMJReQyBWNCn9NyHckAu1Zunz5FpNU5DuuP2b9mc5YjYODHWg78BampDdjx6kv+Yy4ITAPG4c2Ix8k5D0WHAcy4xRH1MxlCqv7heG4vOdq7jYIbfGoj/DJkmykASuSKz7ELjDsTD9wf2udYTvvhtw8l9IRJOmyde5snjP/WC1B91fo3iomsrNU/U868lY1wyhfJ7mgqDWPs5ctpMV9vH4heHc/KsGmvXAA+tkmIPPmHvLABLhgtE3PAko8o6RcJU7MHLzAE7Z//ARAdlIG3eWLiIPdtnhUTqqJlLeMWINGnPbaZAO6Xw1FQztv2JcP0Yu7r1x3rjxm3WLWmEpLTxhbNlZXD6Yk5SQt8LCW5OqfXgKe3DuIaOt4+4ur3mhBaU9bT9HL8jgFaUTalCRp5cEHqTZe7JyuNbi5K7fOUxd8L34WSVjr8QC7H+9kVk162S3AIrbgbfElbFF1x6IgmyqR1TlcPLn0KfEPzZcbXe6WNNVFRlqI939BhrxUeh2DiVciBifhG3JHs4mEt5zO2i5G91GScTXbXJhPmwaKogmtM2ukkA7Q3O1WFyhCnib0qBhR4Wdlpsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(6486002)(83380400001)(36756003)(38350700002)(86362001)(5660300002)(38100700002)(956004)(316002)(478600001)(52116002)(107886003)(8676002)(26005)(966005)(6512007)(6506007)(6666004)(66476007)(66556008)(66946007)(4326008)(2906002)(186003)(8936002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J4LYcuq4pf2Aq3mfpG3XS8+Vq9GrO0sDI81twaM67HxTcwxB/xOkVThX+wfv?=
 =?us-ascii?Q?lBzF3+KRYCQcYEE5D8rp5bxmdOxGCbZlU//1h6o/q8sVKnzxJ2za7u0RvoG3?=
 =?us-ascii?Q?WWh/8hv17JWTxyEJXh/+7/H23iBVa742pTQa6ELuv7MWn9DPi4qdbwWKaNFs?=
 =?us-ascii?Q?FJNavhOuiIC2L0a0EqUU8Tybsgtk1lHDOM/IK1RxdDTDaRKI/WjgMqIPMJaO?=
 =?us-ascii?Q?L0/+ESbd+No3i4JK7qMPTSU9y8hIKcbgCOenzULmYq7Glf3hf/uvoKBkuY9T?=
 =?us-ascii?Q?9HiYH5XRYF2K1ujpDJgyO34oCXtfIfrKs5JSxibfvS+sb7P35BqOzFRzhnvj?=
 =?us-ascii?Q?SGGU8tjWjclD/n6LTBd4rPrJE11ve0yusqJbo5mEkTm6A5ij//u6MrZnMXag?=
 =?us-ascii?Q?Ebg44aL8ul883Di9pCKtrbAe38nGYgyiLAQ2pdk0VOCI6PIi4DHfWdGJAK9A?=
 =?us-ascii?Q?aoKPK4of2Vi8ZtnzQO2T8ANeSQ5uYFqZYJUW5dMKoiFvtYwGvLq14ObD2HQg?=
 =?us-ascii?Q?TKknrETqlzLdTgxJtfi+QylgwCQpK6TkPz9SSw80R4jjtv06Z8brzg7GCxjj?=
 =?us-ascii?Q?69Mc1XOaZ0d5Ku1CBuAhdLDha/MSQe3KrA+gQo6eJpUVmvukLuzh9AMeIQ9E?=
 =?us-ascii?Q?mvcCUU/A0hiLjc6WsqL59YFOcGqVUeMDC4Jp0UBqv0xTOyTSobgIsGU87pYL?=
 =?us-ascii?Q?9DLC+yHOx8MnLlgxjdOV0c+EYWRebscYhSVMAwHJuM6WdvSV6AJ9O2QpR2/C?=
 =?us-ascii?Q?FiTPcPv5ux5U/ynvp7pKHT9nrD1UFPJzMNxibHFjI1IW+sBU8vvHetemZDSt?=
 =?us-ascii?Q?RA3hO+3PUIIqLU19wwtlPhD/tsYUOeXKkasecp8Pzelc8H6o3+pwTNOOuffi?=
 =?us-ascii?Q?+yqgLqdupo9Q7w8mmqL8oSduXalEwJl4Sjr4YA7VuzGGvYksWkTw7L38QSYn?=
 =?us-ascii?Q?9VKzStrU6x6Z6CI2oIyUhijAPr6pIj505xFfzFiqCSgUKgrqgM0uQzHJnc0l?=
 =?us-ascii?Q?pPNrRbpG7O0w6UdiEZSpBLD94DwCsotI9WT9DiJ6btywcDIKzhChRNuDBk/V?=
 =?us-ascii?Q?L7+OXU8j28julvE4BazW70u7sWJTpUHIKzqelckjyupH/IFAlwE1XIZEptOw?=
 =?us-ascii?Q?s5ypB8HV7LK4ig+QGKk0Dc7iWXHbJWvpdi33M5yquuyrVTH4kFs4uqWVBlj2?=
 =?us-ascii?Q?rEjDLAqSfmK1xmYv6DDH+ObWRvkvhLaK0nin1NJZnGbtcRmE+xx56tLRUU+V?=
 =?us-ascii?Q?IT7XwIvPLaWYtBSKORoxN/moLyj78tX7KsWaArGdE6V5xvQFjlYHQBzdd7Vq?=
 =?us-ascii?Q?706t1Xg+yVfo+TF2GoVMuR7u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0510418-3c62-444f-2b65-08d979ab27c6
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:17:06.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oTJoEhZ0f4bE/ijyRV1i2WHgZQVPLzLf/3TJkx6fe7t0IHHNhuIoc5LVGwwCjzwej3NrSNlmOASPRIJ3+iO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3068
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

This type of patches has been going on for a long time, I plan to 
clean it up in the near future. If needed, see post from 
Christoph Hellwig on the kernel-janitors ML:
https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

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

