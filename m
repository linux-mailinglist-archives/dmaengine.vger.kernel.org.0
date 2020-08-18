Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E2248179
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRJIx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJIw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358EC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so9646867pfp.7
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=otxsu5o9cde9DrIHOXDNXEgKF0A0Yvtv94mFiTmu/m4=;
        b=i+2YRjvy3Xy7p7mYJ+xyYu0JHsMysoDT1lMe9RF9UJnBn+W0iSF/4aT8UMaIEuNPA8
         V4DkLVr9oGYqmZEyHXO3Hp51I4NLkU/O+gAXbOO/mQSW5py2R62q3bxuXWPfO7p/sTKW
         U2HGPr9fFEKifXVKa5u2CMS05FeKdHLtyUSzSSmrp5NeFrIb0RYI6Jn+CNsqhJ2grHe9
         c7vy2gQB2VcjV9QR9WXjuA59IZwEaND81o68Bm7s5LcOtZBKmuVv4wQbCzFJiyyOPxLh
         L3/gtCJZS1DprICk8elwV8bxEn7opbIPGQQU0Ulh73S6Uo4GXu2lqjIoTbwhNJNrbNMj
         7shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=otxsu5o9cde9DrIHOXDNXEgKF0A0Yvtv94mFiTmu/m4=;
        b=NKl0zxdWgK0KZ0sJikHRUZJosj8LMwnOYMFt5R84nVM1VTlDpGmtV//04AxpKEytme
         J8Tio9L+kXNXwKfvF0vPbzJr0g4O1MxhBUMZuLUIvan1CwyofTj6HIF74Tz9hT6f60Hr
         E5H2cdjT01eo5Wu6G5gFZ4anbEdFYgkxiPK4Kj6HIcrR3EbpB8v6HCkm4auI3as0fJQv
         B/FhrQnKEf0Obi2S2YncxqtZaqYGsmBm8kWCn5nO6olEGJRRLYQeCVfQ2Ajo1Vw1hoI6
         0Zj1foN2Afb4EquFQ1zzjZZuOhxhsB60BbKSurgyBj+xOIontJhQPB6kQW2/mEqvm5od
         EK5g==
X-Gm-Message-State: AOAM53337QvUEDsKVhoXSXqrtrn7kG4/v33uUN+uwkcVZbJNpfYzuHEx
        UOp8L+d3Cp1dyB5KPvnfRAU=
X-Google-Smtp-Source: ABdhPJzvZ5SriBHAjupGYbv3p3B/1V2Ts+DTy03/VllRwRbLxmpOQTAa//mfTqWK/7Ar7J9AJp4h0A==
X-Received: by 2002:a63:4557:: with SMTP id u23mr3658432pgk.197.1597741731934;
        Tue, 18 Aug 2020 02:08:51 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:51 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 25/35] dma: ste_dma40: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:28 +0530
Message-Id: <20200818090638.26362-26-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/ste_dma40.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 21e2f1d0c210..ec4611ae7230 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1573,9 +1573,9 @@ static void dma_tc_handle(struct d40_chan *d40c)
 
 }
 
-static void dma_tasklet(unsigned long data)
+static void dma_tasklet(struct tasklet_struct *t)
 {
-	struct d40_chan *d40c = (struct d40_chan *) data;
+	struct d40_chan *d40c = from_tasklet(d40c, t, tasklet);
 	struct d40_desc *d40d;
 	unsigned long flags;
 	bool callback_active;
@@ -2806,8 +2806,7 @@ static void __init d40_chan_init(struct d40_base *base, struct dma_device *dma,
 		INIT_LIST_HEAD(&d40c->client);
 		INIT_LIST_HEAD(&d40c->prepare_queue);
 
-		tasklet_init(&d40c->tasklet, dma_tasklet,
-			     (unsigned long) d40c);
+		tasklet_setup(&d40c->tasklet, dma_tasklet);
 
 		list_add_tail(&d40c->chan.device_node,
 			      &dma->channels);
-- 
2.17.1

