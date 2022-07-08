Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74656B56A
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 11:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiGHJ2M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiGHJ2K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 05:28:10 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A24532EC1
        for <dmaengine@vger.kernel.org>; Fri,  8 Jul 2022 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=s9U9h
        ZkjriE3SjTOTlg/9XOwtII0+lUWePWZmZlMKhI=; b=UI7m3pH8HlEMSlT6oN+st
        WTmr4NvO3y78rv2VWUjMvndfDNOLL7SvG3EWhxsYYVYG1pT3J07rmZLB+SEuchTC
        bRSlFJG5MUOoiaORLF3394s+H42JJEr+p5I//v5TJlIl9EjRsjAcw1053vZgUYGV
        YfsMTWpLCv5gVmczWOites=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgDXHcqb+MdiwSNjGQ--.49936S2;
        Fri, 08 Jul 2022 17:27:56 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org, windhl@126.com
Subject: [PATCH] dmaengine: mv_xor: Call of_node_put() when breaking out of for_each_child_of_node()
Date:   Fri,  8 Jul 2022 17:27:53 +0800
Message-Id: <20220708092753.312034-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgDXHcqb+MdiwSNjGQ--.49936S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWUJw4DAF1Dtr1rAr45Awb_yoWDJwc_u3
        WUWFW3Xr4kGF42v34Syw13Zr98trn0gr1xWrsayayaga4jyw13ArZ09r1DX3WUuF4UWryU
        K3ykXr1rCa1rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAOz3UUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7Rw4F1pEAXIpdAAAsu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In mv_xor_probe(), for_each_child_of_node() will automatically
increase and decrease the refcount. We should call of_node_put()
when breaking out of the iteration.

Fixes: f7d12ef53ddf ("dma: mv_xor: add Device Tree binding")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/dma/mv_xor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..3a5c87f992d1 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1392,6 +1392,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 
 			irq = irq_of_parse_and_map(np, 0);
 			if (!irq) {
+				of_node_put(np);
 				ret = -ENODEV;
 				goto err_channel_add;
 			}
@@ -1399,6 +1400,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			chan = mv_xor_channel_add(xordev, pdev, i,
 						  cap_mask, irq);
 			if (IS_ERR(chan)) {
+				of_node_put(np);
 				ret = PTR_ERR(chan);
 				irq_dispose_mapping(irq);
 				goto err_channel_add;
-- 
2.25.1

