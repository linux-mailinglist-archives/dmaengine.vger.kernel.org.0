Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AD34C03E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhC1X6t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhC1X6S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:58:18 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2349C061756;
        Sun, 28 Mar 2021 16:58:17 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id t5so5702082qvs.5;
        Sun, 28 Mar 2021 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y32tInUapaLYbNEAI6jhNwCPrGHOxbt3T1h9KOpxef0=;
        b=IkSy4D1TkXi7lQMZ6smgafSA8mBcR9dJT0+IXc5N37pT9vxabM+SLMm50H4wvaA2Tp
         lk2+hXnLnaOUCms7sELVhOI/WPyeZdnXsdinIxZIuQnUF61PVACtUXO8CzQJmpUg/8F/
         kd/qUNl45u1Q/Z/y4MVvg7AMaZOTYLhOVHKm6Nt+ekWZZfILUbrp2yYgvZ/PqE0UZkxu
         yfiYNr5lsWA/xZeBftAd/5ys7cnmg2vNyOHsMfAKtVfKra3pkeqYar1Fa02kv/vB8uJB
         v4N4zgVPfp5L/JTA/n+36bVEt3mIlRbpaEf64PY4DjGrJu9ef2ZC8nn+a6/daLkbdFVL
         X/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y32tInUapaLYbNEAI6jhNwCPrGHOxbt3T1h9KOpxef0=;
        b=CidCZJzI1nhjIHgHHFc6ExjQhYDw0/uaLwo8RW0i2YvE2sO/vlz6yWvJs/Pwf8ko8C
         qSCEgwhHPqjFsei2jzKcZPiE0FoHTSe687Tu6tnQ7hZPcg/j2FdJI7IaUipR13YdOaAS
         YCtXFH1UnNxU7757VP/y+4QH8EV1La5XhjvT/Rw+AdlrZggZYccdh7bF3wW1dFuG2WqF
         V1SSiReNwDVJyfjydpP6wFSwcBkK6fiBWw/NlvqqheJdkSNE//kbcCC5PWhOUJqShNC1
         YiA4yjkUqdQoG0TVLFWUh30T/mvF0QonRcpokKJuAi1xjjMFuHarpCY+mF7qWKNvRJNp
         DU9g==
X-Gm-Message-State: AOAM532T7v4pXedVDn3xhEgJrzdAahBPaUcGD2SQwgxlX+EhfHFOPEkk
        G0vg6krbFlIaiI70WQ4KnGg75mv1lcJnY8fh
X-Google-Smtp-Source: ABdhPJyWc3zpPzhGmj++XGZnoiKJeId7+5rJvoWlZFi+DgW1DNMSXYY/0RU9k5f3zIa31roOCCmQaw==
X-Received: by 2002:a0c:df02:: with SMTP id g2mr22816522qvl.40.1616975896740;
        Sun, 28 Mar 2021 16:58:16 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:58:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/30] usb-dmac.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:24 +0530
Message-Id: <7458e5dc5058076cf2ebe15de57c94927dcffcca.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/descritpor/descriptor/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/sh/usb-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 8f7ceb698226..7092a657932b 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -301,7 +301,7 @@ static struct usb_dmac_desc *usb_dmac_desc_get(struct usb_dmac_chan *chan,
 	struct usb_dmac_desc *desc = NULL;
 	unsigned long flags;

-	/* Get a freed descritpor */
+	/* Get a freed descriptor */
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	list_for_each_entry(desc, &chan->desc_freed, node) {
 		if (sg_len <= desc->sg_allocated_len) {
--
2.26.3

