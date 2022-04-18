Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156C2505AE2
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiDRPWw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345327AbiDRPWY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 11:22:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E80B26E;
        Mon, 18 Apr 2022 07:19:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 12so12426702pll.12;
        Mon, 18 Apr 2022 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8HB5UsMcYCH6dnCh61XsqKo6h5w3bfQReOb/+tBK5w=;
        b=WU9ydoNL8Xn3bewDq3z90aKYqnymssyAL2SVHjHgL1bqcAi1HiUt3jlZq9AD2KlvHD
         e+SONocd1RP+tpUBOTp4KUceRLJ9XmeV78B/lNq/ZXqCPOz7dbBWsTFuH6dTzyTp3HOU
         hSC7kJFZ6/qdFkDHR086kuDvduIb1BFAH1Jl0C7pdbV2+LYYxUwL7xNzZk0QQc/gAnkf
         RVNRkItIK9s4WQQLLlIq+9nXFKnkwx7W6QNQzhxkq8M7sO0OdyBJVt89+QxMSsldeZ3T
         iyRcHw8WlYj8Z7RgIdhDzRyqwprEBCsjRfR7NfipDNTHjo2uwuf9Jjd6b+0JQ96ScNJi
         e6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8HB5UsMcYCH6dnCh61XsqKo6h5w3bfQReOb/+tBK5w=;
        b=i4HXF4Q8TWiSPDMomuVgwxjhTESyut9zqCuYtWauBewsTdhclA6oE7rcWjLEZIivIG
         J47W3ryRLJjyC+acLJgSOlPlF67eL3Bgap3+2m5t1mZydNJDTESHNnEo+34vCojd7Yy9
         wfnwPyuipi6maqFhlguzzWs8eDiDmndyLSGhU4XeHYYX3PgMW4U3DnXjrIlUZSHl2+Bs
         GRm5eCbw9BZUNH+x1c9V7SKszbfV4yotC07TQh4ZMwDUsWEDdTAkmovlT5A6SHpKKI97
         TEWAHNwwCWa1jzD6shTjv3UgIsdVsbGa0H1HcW1gSpngtVnFBpKTuoyXbqKGf8x6CeYT
         x8BA==
X-Gm-Message-State: AOAM532PyTRcjszKUOun8PT0l6RryigX3u1S5wISHluUnakASTpjoKPw
        Av1hIb/9hXm/wdwt4rukGiw=
X-Google-Smtp-Source: ABdhPJzJYJJR4ZkwuBoCA0V+2271521Eaa4SR0LIZ+DL60TXBnyLz/51QR0qqQOMnyB+7OvjqbtUIA==
X-Received: by 2002:a17:90b:17c3:b0:1c6:b0ff:abf with SMTP id me3-20020a17090b17c300b001c6b0ff0abfmr13182032pjb.24.1650291585099;
        Mon, 18 Apr 2022 07:19:45 -0700 (PDT)
Received: from localhost ([210.21.229.138])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090ad80200b001d27824fc24sm5732955pjv.5.2022.04.18.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:19:44 -0700 (PDT)
From:   Yunbo Yu <yuyunbo519@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunbo Yu <yuyunbo519@gmail.com>
Subject: [PATCH] dmaengine: mv_xor_v2: move spin_lock_bh to spin_lock
Date:   Mon, 18 Apr 2022 22:19:40 +0800
Message-Id: <20220418141940.1241482-1-yuyunbo519@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is unnecessary to call spin_lock_bh() for that you are already in a
taselet.

Signed-off-by: Yunbo Yu <yuyunbo519@gmail.com>
---
 drivers/dma/mv_xor_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 9c8b4084ba2f..f10b29034da1 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -591,14 +591,14 @@ static void mv_xor_v2_tasklet(struct tasklet_struct *t)
 		dma_run_dependencies(&next_pending_sw_desc->async_tx);
 
 		/* Lock the channel */
-		spin_lock_bh(&xor_dev->lock);
+		spin_lock(&xor_dev->lock);
 
 		/* add the SW descriptor to the free descriptors list */
 		list_add(&next_pending_sw_desc->free_list,
 			 &xor_dev->free_sw_desc);
 
 		/* Release the channel */
-		spin_unlock_bh(&xor_dev->lock);
+		spin_unlock(&xor_dev->lock);
 
 		/* increment the next descriptor */
 		pending_ptr++;
-- 
2.25.1

