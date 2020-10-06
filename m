Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C938928452F
	for <lists+dmaengine@lfdr.de>; Tue,  6 Oct 2020 07:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgJFFFN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Oct 2020 01:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJFFFN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Oct 2020 01:05:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E18BC0613A7
        for <dmaengine@vger.kernel.org>; Mon,  5 Oct 2020 22:05:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t18so631362plo.1
        for <dmaengine@vger.kernel.org>; Mon, 05 Oct 2020 22:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FKy+gU/hAo0IiU5AgZhGB7kLD4/JLy7JC/8oBKH/XM=;
        b=jyORSCv/lXawb+DYgHzpjBSIJBiQK8N+TRUHKnJ/2cUqjeRZK1e5ofbbA05XNUstnr
         fMUK+rfQR+u9MsEe3X/eFgZeOGvhhK+kkNF5MZbBdt7E3FQQ/U5WhXqld8GsRrWAAOAG
         Hz2kMHxleuT/D0FVlsPfXaLO35jezws96vkoI4ye3PMk/esCqGYSgCQWlg4U2eDjCcaH
         f844lIQH02WrRfxYCD7X0ZAqShbtpWwP52zvp0thoHOpKprdh42hrVYijgCkgE7qA23p
         ZOFFe+VrfNcHpcsbmqbw4JsNhBFKnoDbhQv8On55NZSord5SHt13uJ9lX63TlV/bLSeZ
         VNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FKy+gU/hAo0IiU5AgZhGB7kLD4/JLy7JC/8oBKH/XM=;
        b=JUtxlBdzdhE/36im8oneUt8bi8Ev3piIYup4nb6vzCLFMONTlP6SIXEJcmyXL74YqJ
         Xw88ZgdecclLXc8l2blMamEG8Ab5/Rhd38BCRyNi8sZiOHaNKuwwluMaMIV9hGgZv+HY
         7wUm2BDd+IZ+fJn10ug5bH6JXLP4ZUtjJ04RFdvuL3y53p5BZorwnbwaowzCdFo31Zsb
         wy3SicaJoBUMeEzuLeB+ysfL2/04JsF6ZNgwCyl9bJ6zfBUfrWoAusFA8IDDNrP2fsZn
         PwJ8SvvtxJcVUVfczOpyk42uJdqtNe7CXVoYvIhAeTExOUhebeWArPGcG05luHLOvOH9
         4n5w==
X-Gm-Message-State: AOAM530CR+sn0k+OhbfwsDps+OQyh4maJBpA9fFlTsiTFdqvHH3KKSLD
        szcfSPGa4XErRb4OWNb9GbattuaFuN0=
X-Google-Smtp-Source: ABdhPJxkwRfpKajnaSeApn9t9OmfY/4GgfJ/7gx/l2+6olK837BBGOrf+aPEnwEoMJW2GadqAd5ANA==
X-Received: by 2002:a17:902:8494:b029:d2:63a3:5e87 with SMTP id c20-20020a1709028494b02900d263a35e87mr1661761plo.40.1601960713086;
        Mon, 05 Oct 2020 22:05:13 -0700 (PDT)
Received: from localhost.localdomain ([49.207.197.157])
        by smtp.gmail.com with ESMTPSA id e196sm1755437pfh.128.2020.10.05.22.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 22:05:12 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     green.wan@sifive.com, hyun.kwon@xilinx.com,
        dmaengine@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 1/2] dmaengine: sf-pdma: convert tasklets to use new tasklet_setup() API
Date:   Tue,  6 Oct 2020 10:34:57 +0530
Message-Id: <20201006050458.221329-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 1e66c6990..528deb5d9 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -281,9 +281,9 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 	desc->in_use = false;
 }
 
-static void sf_pdma_donebh_tasklet(unsigned long arg)
+static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
 {
-	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
+	struct sf_pdma_chan *chan = from_tasklet(chan, t, done_tasklet);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->lock, flags);
@@ -300,9 +300,9 @@ static void sf_pdma_donebh_tasklet(unsigned long arg)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
-static void sf_pdma_errbh_tasklet(unsigned long arg)
+static void sf_pdma_errbh_tasklet(struct tasklet_struct *t)
 {
-	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
+	struct sf_pdma_chan *chan = from_tasklet(chan, t, err_tasklet);
 	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
@@ -475,10 +475,8 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 
 		writel(PDMA_CLEAR_CTRL, chan->regs.ctrl);
 
-		tasklet_init(&chan->done_tasklet,
-			     sf_pdma_donebh_tasklet, (unsigned long)chan);
-		tasklet_init(&chan->err_tasklet,
-			     sf_pdma_errbh_tasklet, (unsigned long)chan);
+		tasklet_setup(&chan->done_tasklet, sf_pdma_donebh_tasklet);
+		tasklet_setup(&chan->err_tasklet, sf_pdma_errbh_tasklet);
 	}
 }
 
-- 
2.25.1

