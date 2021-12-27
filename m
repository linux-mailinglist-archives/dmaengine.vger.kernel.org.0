Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1347FC67
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhL0MG3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:29 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:39193 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhL0MG2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:28 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPooN-1moz0c02Lr-00MuJ9; Mon, 27 Dec 2021 13:06:17 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 08/11] dmaengine: bcm2835: pass dma_chan to generic functions
Date:   Mon, 27 Dec 2021 13:05:42 +0100
Message-Id: <1640606743-10993-9-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:/ASoI6d8a576GLw8ceiECC8ZP9um/XQc7ZFmSyZ3DjshYnk0qgp
 zvnN0uIFF9m4NVcmMs8ZrhdtcFL43eUsSgas2OxNLTM3ZhhkQYqcLSk3K2G7N8OBXAKzGIO
 QREGb8zDO6zrVWEjJXvTInOeh5XuJxXSBpSVv/JX6AdWV+/5Tne+eQe4I0Jeiw0XACj7DN+
 X/caLaO2QJ5Y5SBXU3MMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+EDVOE1HZWA=:bACUEyn5bgh26+U+wk5Hj1
 3qkWh+KM2HqR72vC6WIhqga+W819AmGqELyWHuegyDyec6DMCdsco1e7wTpue7zq44iareN1e
 RgaGjgH/kbtzkDAgrj6+46q3jG+yYVR+w1Su92p7ynfRtCEoZEc5NKUfpkanHtbgvYqeMbHd9
 NHdkwf5o6/AdMwpzTUunF6nVy28aVSJvUGXjAoLOtyldSpyqLVKDf3uEgNYtsTnDs8Unn7fTt
 nDtqrPphLap8Nl1YHPDdXLMoNqYqlEjP1XTw74F/v+jVCzV6z+k9R/IZh0srY6uLsv8W1fImz
 iMuFQ6m+qxGIEkpfKKHN5pgSkBLierhOVF6OmN8LZo8VUjN+kso/k6XGXp07WM8SkoNzBWZuz
 NTlSZDjrqwqTSSDB40UbRxhzg6RbGN52G90JYoTAD9Iy3VWEfvn5uGWTC+XGbH7z1wtLZIhVy
 +6FBgLnr/59Mgpw+GwQygcXPlW54I1QWiQa29+BgeLmnClbX/mPJWI6JnDnEAWhkhhDr4ohdc
 TUT2ZYXIoVHNFSxUP6Z68BNyd4fUiiUikJKOnd/6d0mpTLfLFFRAjEtBj2MHxb0z1FjmOPXYX
 qehZC+HL3Je0iYolr7JRBUmZdpWbvEPKweULgj/sqFU4xWZABlo/wByVfX0CpXam+CFTMO24f
 XGolWXiXsPTidG4Ky4qCE5wS1yNe3MRk7yvQGnRcYDc3OwekIpjg2e6MQVxlg1cvVcKut026i
 fqx54bT1DAWLo5LD
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation to support more platforms pass the dma_chan to the
generic functions. This provides access to the DMA device and possible
platform specific data.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 997fe6e..0933404 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -289,13 +289,14 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 }
 
 static bool bcm2835_dma_create_cb_set_length(
-	struct bcm2835_chan *chan,
+	struct dma_chan *chan,
 	struct bcm2835_dma_cb *control_block,
 	size_t len,
 	size_t period_len,
 	size_t *total_len)
 {
-	size_t max_len = bcm2835_dma_max_frame_length(chan);
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	size_t max_len = bcm2835_dma_max_frame_length(c);
 
 	/* set the length taking lite-channel limitations into account */
 	control_block->length = min_t(u32, len, max_len);
@@ -421,7 +422,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		if (buf_len) {
 			/* calculate length honoring period_length */
 			if (bcm2835_dma_create_cb_set_length(
-				c, control_block,
+				chan, control_block,
 				len, period_len, &total_len)) {
 				/* add extrainfo bits in info */
 				control_block->info |= extrainfo;
@@ -488,8 +489,9 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 	}
 }
 
-static void bcm2835_dma_abort(struct bcm2835_chan *c)
+static void bcm2835_dma_abort(struct dma_chan *chan)
 {
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	void __iomem *chan_base = c->chan_base;
 	long int timeout = 10000;
 
@@ -516,8 +518,9 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 	writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
 }
 
-static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
+static void bcm2835_dma_start_desc(struct dma_chan *chan)
 {
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
 	struct bcm2835_desc *d;
 
@@ -536,7 +539,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 {
-	struct bcm2835_chan *c = data;
+	struct dma_chan *chan = data;
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	unsigned long flags;
 
@@ -569,7 +573,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
 			vchan_cookie_complete(&c->desc->vd);
-			bcm2835_dma_start_desc(c);
+			bcm2835_dma_start_desc(chan);
 		}
 	}
 
@@ -597,7 +601,7 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	return request_irq(c->irq_number, bcm2835_dma_callback,
-			   c->irq_flags, "DMA IRQ", c);
+			   c->irq_flags, "DMA IRQ", chan);
 }
 
 static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
@@ -685,7 +689,7 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 	if (vchan_issue_pending(&c->vc) && !c->desc)
-		bcm2835_dma_start_desc(c);
+		bcm2835_dma_start_desc(chan);
 
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
@@ -849,7 +853,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 	if (c->desc) {
 		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
-		bcm2835_dma_abort(c);
+		bcm2835_dma_abort(chan);
 	}
 
 	vchan_get_all_descriptors(&c->vc, &head);
-- 
2.7.4

