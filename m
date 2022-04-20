Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304B50881F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378526AbiDTMaq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiDTMap (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 08:30:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72451286E1;
        Wed, 20 Apr 2022 05:27:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id md4so1775746pjb.4;
        Wed, 20 Apr 2022 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rgC3I+iqqqUp1PHdhsqQ/5UpMdVaI27WpJzN5EqQ0o=;
        b=UGM5Eh58DsDjHpa7nNcL2iYPr7H3jomqww1iieFcJ9FAozdXVrSQyVCA3DU//ilKrH
         JhskawuZ8V/b1Dsts7EscM+vdOXejX358hTErctCe57b/iXJWittsZAqr0WGNCGalda3
         F2vWYpBV+JgB64C5y5QH7O63S6GcPKOLbEyhDmIaXmhdRkobV3j6Od7CHz8+d9ibuuPq
         2X7JSQFMQI02XV/POgksAl1N/hlcs0UEn+z6F38MQagb6Nl2iVQbQWpBopFoHLEtLiFF
         QlM4HjN1wtf03uCfb9IXkHCb3qOhGsVsduPY/IpDwhaliaeTWBcprHaOz+GJVlP03aDi
         IFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rgC3I+iqqqUp1PHdhsqQ/5UpMdVaI27WpJzN5EqQ0o=;
        b=0jFmZr7ikzaWYljz0CJA28zOGscCkR4k6O5Q8yyIR6QkjZHmozA+IUCy/oVIcs7Jsq
         HlQDKPIa3dRuUbUAJZ46JghYqCd3jwqzEeil4Wlq2ig159Y1acUSgaS5wAHQtu0DBrtd
         d2bhmvNk1+5Qn9sf9YPa7eDBVeN/oTEiwnhoi1og5gLqMwZAlQwhgZou5DsXKfk3UprP
         Vqbx8TYNboa4zI5a4PLerp0BGmHZ0WEdDcw51peYpP8izOOis4/EXnQXC8mQ5FIcnnAb
         fE0GGwaASYjVQdKmGS34pF17WwuX6ZZfdpvu+Z9wkYJrX64rxuYevOElST9DkWRUMLSu
         cK+A==
X-Gm-Message-State: AOAM531Fo1G3yrNueCqUxCfIbmHJGFRCKvS7huIeV04q9qgkQI+KK8pU
        sSX6Q3tvkEQGeYAdgYTZC09KQRcXDUb6hWld
X-Google-Smtp-Source: ABdhPJxYOvV+V5ct/V2av3/g8FMFoEI1RX5Phlpozz4cV2U7tuN8Fcj4UAIBFH7GIHP0XtsiG24+Aw==
X-Received: by 2002:a17:90b:1c0b:b0:1d2:7a8f:5e1b with SMTP id oc11-20020a17090b1c0b00b001d27a8f5e1bmr4111093pjb.237.1650457678968;
        Wed, 20 Apr 2022 05:27:58 -0700 (PDT)
Received: from localhost ([58.251.76.82])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79182000000b00505a61ec387sm19575935pfa.138.2022.04.20.05.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:27:58 -0700 (PDT)
From:   Yunbo Yu <yuyunbo519@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunbo Yu <yuyunbo519@gmail.com>
Subject: [PATCH v2] dmaengine: mv_xor_v2 : Move spin_lock_bh() to spin_lock()
Date:   Wed, 20 Apr 2022 20:27:54 +0800
Message-Id: <20220420122754.148359-1-yuyunbo519@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is unnecessary to call spin_lock_bh() for that you are already
in a tasklet.

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

