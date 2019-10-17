Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA2ADB110
	for <lists+dmaengine@lfdr.de>; Thu, 17 Oct 2019 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437988AbfJQP0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Oct 2019 11:26:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37696 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437754AbfJQP0S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Oct 2019 11:26:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so1877349pfo.4;
        Thu, 17 Oct 2019 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vyhAg3anmutQrJfhNeqhS0F5n10v6jX+HPYL+lL5K0I=;
        b=hG6D9mH7YEkyNfA5TpZwHpvmyrgPd6IQ807A1WzZQm0y4pDM1ulNyhmIcZvfZDwjZ6
         9RoCZYTJXpUX1BwnhX6Sbsw2fxZXKaJr4Cq3Qz4nsjvndWtwKVzP0KdPi1+pu5kW8ZMh
         nZHOAfHN8V/QbZp67gvCvqNGatkv4PgrGu1lH6q0gnT1Elxh8FpenGLBaABqOTzVZlGn
         iOiRj44ZR3V6X1ySRq+mIEqM6fDDx1oS5z99YouXlvsUrMnikH+Id9AbYAx39o5M08y1
         Mgsty7zmfXCgK/q3qvwq/SHPFA8n5z4W2o0Ux/bu9H0qk9u71qhHVA7GaB4k+X9H01Rn
         nwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vyhAg3anmutQrJfhNeqhS0F5n10v6jX+HPYL+lL5K0I=;
        b=tKpFpcr1L8scSiR7fDSZjrpc5yCZi0lTZ79fd4ClFW1jwWSNWpUkoUm1f5GCklyW5l
         /FJvKVa8Bu4Ay2bx5rpI69+C4okKTeITuN9lgx7mVfzSdUOPK5vrgDFRYcEmnWmf4zNo
         wYMaJY455xK7hSynJaZVop39ON5miMkSVfoPAQVMvGuD5+PxK3u2fcb6Qm+0SGXd8ngB
         3iA5fFhG5UGVy++uwOZc7VWUei+1pBbNqQcycq2s1yjWl8zb0dnFLhiVLELrohs3WcaA
         NAv104M3q6hSPgfHTGUB5gWcrVBuAbjfauoMPoImbL89tbX82FFek1In4izJ4X1RjevT
         DzRw==
X-Gm-Message-State: APjAAAUZmoc5hprw/3fdx+XcMhEeiczvFSRFFFRdk0BpDCaEgglnuoWV
        62v8i0TvjK9ctA9weNnEHbY=
X-Google-Smtp-Source: APXvYqy8N7+VVeYK9qlx19Z7TSu4BOi9k5sVMTvNj2rcnFbeDrL1oI7LgG/3gr9vY1LJLwWer90Z1w==
X-Received: by 2002:a17:90a:db12:: with SMTP id g18mr5119242pjv.32.1571325977238;
        Thu, 17 Oct 2019 08:26:17 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id t13sm3429237pfh.12.2019.10.17.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 08:26:16 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] dmaengine: qcom: bam_dma: Fix resource leak
Date:   Thu, 17 Oct 2019 08:26:06 -0700
Message-Id: <20191017152606.34120-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

bam_dma_terminate_all() will leak resources if any of the transactions are
committed to the hardware (present in the desc fifo), and not complete.
Since bam_dma_terminate_all() does not cause the hardware to be updated,
the hardware will still operate on any previously committed transactions.
This can cause memory corruption if the memory for the transaction has been
reassigned, and will cause a sync issue between the BAM and its client(s).

Fix this by properly updating the hardware in bam_dma_terminate_all().

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 8e90a405939d..ef73f65224b1 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -694,6 +694,25 @@ static int bam_dma_terminate_all(struct dma_chan *chan)
 
 	/* remove all transactions, including active transaction */
 	spin_lock_irqsave(&bchan->vc.lock, flag);
+	/*
+	 * If we have transactions queued, then some might be committed to the
+	 * hardware in the desc fifo.  The only way to reset the desc fifo is
+	 * to do a hardware reset (either by pipe or the entire block).
+	 * bam_chan_init_hw() will trigger a pipe reset, and also reinit the
+	 * pipe.  If the pipe is left disabled (default state after pipe reset)
+	 * and is accessed by a connected hardware engine, a fatal error in
+	 * the BAM will occur.  There is a small window where this could happen
+	 * with bam_chan_init_hw(), but it is assumed that the caller has
+	 * stopped activity on any attached hardware engine.  Make sure to do
+	 * this first so that the BAM hardware doesn't cause memory corruption
+	 * by accessing freed resources.
+	 */
+	if (!list_empty(&bchan->desc_list)) {
+		async_desc = list_first_entry(&bchan->desc_list,
+					      struct bam_async_desc, desc_node);
+		bam_chan_init_hw(bchan, async_desc->dir);
+	}
+
 	list_for_each_entry_safe(async_desc, tmp,
 				 &bchan->desc_list, desc_node) {
 		list_add(&async_desc->vd.node, &bchan->vc.desc_issued);
-- 
2.17.1

