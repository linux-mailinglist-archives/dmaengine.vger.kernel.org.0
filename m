Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215DC527FEB
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 10:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiEPImq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 04:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiEPImf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 04:42:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A3BE1C;
        Mon, 16 May 2022 01:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV8jdjNAioHlRV3l/livgcylCAaItw7TeQxM02bsAOk5ODzPA8WOPuyohQvjYn9egdTdWiZTLVcvLNr8/QcmMj3rkdvM4q50hOXC/LnoxIb5pwRawW0wT2nnwOyWMIFGBmBTfrm+0lKjVCqG1hrihFVw9KDg9Q3Ui8clHvQmB2oiglTxYrCjfiD2U0+k6Qa2jyRi4nmRNNVpguka82afuP6QF2FTGtjInyyyyTmY2tzjkDNGcsrDYveIPGzSfTZ0fTvGJUy4nZ/GFWUqOw86csyoauUs79uChwmJWeWGEJtGLQarFhl+31E/ODoZTalkP5GR23REr1bVrhfM2GL6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofvvTbHAPPrz+0DHCbFm40sIvX/xXpp83GgZSUmLHVY=;
 b=l8g+3ZLgwotNGUE96cXMdojoKHdVowGbRgVQ0UMsu3WeuOVsOZrDrWHNJiLXyrNpOcyaYYnh+WQJ8v4EBS1AV9d8WszoJkkY9IrGWfWz6R13Tri76U5gQrLa2K47w5le+FTQOZGFZUE0ii0ZvLyjGZE9XL5VdYcOHh+KnEfYxUKtM9KeBfKYxhQV9MmmQKblT0oH0t4BGn/qpmA5pMWLU6pF3agNWPrxTK2yV8e5x3LoRsJW7tcBtaVRNXlls0P3GrHnvm8JDw+2Y5zHHAX+FnhdVrdcTXc/uqFLMYso5vvYGtRpGjNa8Z/Z1VQu4usDwqM1jr83x0zuIPJ0ulzPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofvvTbHAPPrz+0DHCbFm40sIvX/xXpp83GgZSUmLHVY=;
 b=c1dJV1aussKJcL0bM0tHmtI/I5AlZOFbEvQe4U4ffQTnzJgDnwxPerM+U4ymVBwabESTIYYYhryX1BZsCJhf8rlmOtZ+5SKm0gmcHftQjXI4nBvnym3gn/t9HLdZhH5YOsnc70Su5M4SoKZ26f5I/MMUQCNchE3kfgFMOp669Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2977.apcprd06.prod.outlook.com (2603:1096:203:88::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Mon, 16 May 2022 08:42:26 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:42:26 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH 1/4] dmaengine: ep93xx_dma: Remove unneeded ERROR check before clk_put
Date:   Mon, 16 May 2022 16:41:36 +0800
Message-Id: <20220516084139.8864-2-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516084139.8864-1-wanjiabing@vivo.com>
References: <20220516084139.8864-1-wanjiabing@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11924982-b694-4328-826b-08da3718010c
X-MS-TrafficTypeDiagnostic: HK0PR06MB2977:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2977315347F25304F035B095ABCF9@HK0PR06MB2977.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUZL67Qaj6oAfTTWGXjJYcet0c05bRGbN8JEIY8rhkPdGv7GwbmwqYfBvV8eJMbz8Of9kzflTN9ua7MICeXvU6zh3NI6qpLBb9207MdHOUfdQ6DrGevUsy3sL8HJXtU+H1MP0AY6Jn0qCX6YYnQZLzQsl6X3whOeQGveDM+3VWuouwc8KYAjTfUUVyymIOR9tG576SHgaURVmGLYJdHeSfrMmJapbGoLJn701R4TG3Efh2G8SiGZmq3vU0I3ehJziCLb8W27FhU69SS1W+t247mgLFQ8tQMsGxFj+uIJPNxGhszX9T5w6yHHC+nV1IYPcKvN8WSsygeKjXHPZeku9qmTcQvky3PNRBfyE5Mc27xB/yi6LTQCpRhxvJMM81UbRnQr9Vg8lVGkK+jhXEGixoyKxVyJU+kAmPj7u0xyDmlEEjwkah/jpO9uAvKtXTKhICyC3rNCK9ebQU+6TAqirsYj1uuuzmk+uaCT8jL0dlJNwmMwLgVo3NSGKzvEwnmQhGXB3UvpTDGvp8thmfp45blPddHalAXy2tBKiD0y9OD0JdWMcjvcBBa6HEue+alaaF3Iv6o21+JeEbT0luZDBes3zXQNvh9339SEPVS+ADAiz7JjDEWcmhRIxSipOYf/AHvuH7yKneF0HiCQvL3KYBnZRatgI8ViMFRc4KsQ4z/ne1+DNTf2QTcLo4ddk9Z159CbA8r0XxeSSS3gOSvQCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(38350700002)(38100700002)(83380400001)(316002)(110136005)(52116002)(6512007)(66946007)(1076003)(186003)(6486002)(66556008)(66476007)(4326008)(8676002)(4744005)(5660300002)(508600001)(8936002)(26005)(6506007)(86362001)(36756003)(2616005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p34xn27CEhJvzwOcFVPG4jXwuUuaLbXHnVzGL/L6voYqV8sR0h4JzsUbaH3j?=
 =?us-ascii?Q?9rmHkKFu8XtHpNSxDOVSv+8OZ653cs/iZEQiDUEGcCozrMpd+fXTIAvkg22z?=
 =?us-ascii?Q?E3mS4XCq1+hIz6aj/qnxL/BmFXwKbpZM3BiN9r2mvi9ZISEAiwRk0Bxn+pzh?=
 =?us-ascii?Q?K4konullo/2bm3kYavcmbzmH4a/upAZOsY0NdCs3pgWIanveDO6ueOv0XuRU?=
 =?us-ascii?Q?skFyiSABOmssiFZcqEJYfrjYILkxfqh4k2/LWMVK9Wb2QUqdXd326plnjug/?=
 =?us-ascii?Q?E+Zj/8e7DoXzc/Wjcf8/YcLJd0YdO6XY6J43/ZfE/a88Fp3tiO2RdoLr3HzW?=
 =?us-ascii?Q?4NWR2pdGQg0fMj3cWxaXDipi1rTo1wBZP1kxJGkAifqHmT6m/N0eS92pRwVs?=
 =?us-ascii?Q?ZVvwp0ugMIh89eOUKBf/h68n+1VxunkZHenF9z0PrwFE5lnUCTr6nQgxI3/n?=
 =?us-ascii?Q?mJzWWEqO8LxKfd3SbTEunmOQqPA4nQOv+mGj/b0pNq14z+HiGknGjmA+qnwX?=
 =?us-ascii?Q?EwHAstbgT8QXeRwlX+v7x/eDS5INH0ugMRRrovmVFjoZM7FARL0DM3Kn4cPs?=
 =?us-ascii?Q?2mE9E9r1ftAa0nFItxCnVK8fl65+2ENb91zh5pKm0ptnl9/XlP3Ap8+a7Xek?=
 =?us-ascii?Q?XWzGtv8kEOyGLbezWnY5KXlANKzqQVxiSU1qvMXbbq+UZrgITiddJD20E7UC?=
 =?us-ascii?Q?Hj9q+zBhOIfEbzUMmtZu34lOBzWMA47McMvSnAMSrDM5xsBk/YspbDmm8N29?=
 =?us-ascii?Q?D1JqUdISBTN0ha4V8FKbB88WoZVHjtwUlEpWylepdBwjAin/swPEJ8gJ0dJS?=
 =?us-ascii?Q?l4tBNOSo/9ODmvDynPYfOv27b5UeYuD4ZM8oaZQ7nTOuA5Lrl8K0HGqxpBwS?=
 =?us-ascii?Q?FaJcg7cmDrpzhYVRWMRgwGuX967DPg7QOds2Wz3SCPNMfGA2esylVQQDjCDk?=
 =?us-ascii?Q?E6I13lQFJe0xeJ299xn8F0NgPI37qY43+nAEqUYu/C5fdpkO+4+KtoSPcwox?=
 =?us-ascii?Q?lG/5MfY9St6Stw2nFMGhe6IDcrhgAD8dFyrdpEDx18er6Mwu+nYxCGujvONq?=
 =?us-ascii?Q?4ZdCV+w2FRQjZjREWiq71uS42Uqk2+jNttHY/A+viqiPOrcSPE9SOTvyAcKD?=
 =?us-ascii?Q?ewqMZkH6cZgsddlTPvl2+BlkXMhEJtXR1EAHbKYCIP4Vi+/l+SercbhnsNQf?=
 =?us-ascii?Q?Znd7UjNgLsibV5zkj6WChx4cQqHYsWm5cu3g16zfhkAobcsnvQyrF9bTmnRj?=
 =?us-ascii?Q?C5SkXC+4RkZ0zXAdTcZw4PIl2iGf6fHtS6VYb2Rlc6PLtsOUaTi2/payMsBV?=
 =?us-ascii?Q?S+FTGQqKZMAdS1CALNR6n3rp9Le/uV2VFlK77fAeYS8v5y7H4OmUIlhkLij2?=
 =?us-ascii?Q?D6M6ckQcUrchIYX+99EbkTtESc9XQWs+zcoThqk3Zb3/B7ftXEFCtaPsziPx?=
 =?us-ascii?Q?ppoJWKAErWh+p29IHlpfgdocnvYLTSQaGk+cpu8iJBKfyZVIDGScjMT7SkmM?=
 =?us-ascii?Q?mk6e+/lT9UpR7BGS2GB93MHGJHRVwvarxnBRX4Ox1YxEob67sa/z4NUANebq?=
 =?us-ascii?Q?qdTGyCVuchfDM17XhCOiLjinBMwvmrtgj9yHA4Lv4HNGgiONeL3Tcbuh3aNL?=
 =?us-ascii?Q?lyQ1wPrd/0J1DMH88rTipY86hcbU7/CKSk4x80O3dpOUSX7PihCwgZ8AGC4P?=
 =?us-ascii?Q?vi7ycrPGgySZLawC9zEeq8RD4IufKLZno6wetJKTIwSaMlxHcm3IpzK4ecGT?=
 =?us-ascii?Q?TBtxpSi9Gg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11924982-b694-4328-826b-08da3718010c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:42:26.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi6gWbbpyTk+q7rUWA7XjMDvk5salpemoyi9F6aH6u1Ub2Fysbzn5hfLUwbiAcNTCfiuUdasY2K7k7BZbO2Kfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2977
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

clk_put() already uses !clk and IS_ERR(clk) to check ERROR or NULL.
Remove unneeded ERROR or NULL check for edmac->clk.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/dma/ep93xx_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 971ff5f9ae84..60dc7b3f3d0d 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1398,8 +1398,7 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 	if (unlikely(ret)) {
 		for (i = 0; i < edma->num_channels; i++) {
 			struct ep93xx_dma_chan *edmac = &edma->channels[i];
-			if (!IS_ERR_OR_NULL(edmac->clk))
-				clk_put(edmac->clk);
+			clk_put(edmac->clk);
 		}
 		kfree(edma);
 	} else {
-- 
2.36.1

