Return-Path: <dmaengine+bounces-1357-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6787A90E
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E1F28884F
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745F46433;
	Wed, 13 Mar 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PSoErHgR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A045022
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338932; cv=none; b=Cc7bkLldnYI3+TysZKO9Q6aBYPSS3oGWNdb1mVnIiMKLNTEcP9rz5WFGkVxSzR3vbIzJcO64B+YkOdaD8o28qEi9YL2fNvQ2xeuztpha1sx5rVC111fqC3IFALuGFS775p9kL3+Z9VSa7z3pHk89C74w2TTnmVdO9BmVNIT6QwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338932; c=relaxed/simple;
	bh=TiV/x+MwIO7f4UmnRKt0r41hVI84TqUvspuBnnt5QWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzRhy/Ro7nBg3jbF5MCeKsYBD8/kr5jziL1qn920B1uVlZr0kG/kJGmyo0zJTDNZ+BvH7yujgDEknru2kJqLPbIm3yk53lvcpqmqjqhvkfMGNXETwk8Epbe2d1qIq3zBgUv0tbRDt7oFZBNvZ7Kr8EjwFWcAVXm4ZrzL2sseaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PSoErHgR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44665605f3so926208166b.2
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338928; x=1710943728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCjY7yma+RGAhMTh4u8gj7GTqPRw3rlJG0cUBmglS1Q=;
        b=PSoErHgRquG1TaVd3zofyHG2xgdk6ql+NlCYCN7r9W/Po7T48X3x3oyZYCX7d0HPKX
         a5a8yGAWvQgd0gJ9ItccnB8fSBAm4+7NP48TqAe6IKtvw9K3djJE+foTvIjKtXtyYscZ
         rVLXNh6Bbmag08XcfkOC66HLRofXiI3egEQZ2V/3dJajXW2BlvdsIpePXTeUNESB2zRk
         CiNIYqK11258EwIDiwsr4CEqJ6NGbALwMMqYJHTlByE6lWe2jpnTK9y7hBnELs3bu+K7
         pXpEuEHs/K3OXrdmIV4/YbEV9krX4/ixuQyzbNlVNJSJdvVcQ0B5MnQoTJ9RKaCka9GI
         NPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338928; x=1710943728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCjY7yma+RGAhMTh4u8gj7GTqPRw3rlJG0cUBmglS1Q=;
        b=iuqtRG4TLw5ATMzmMCsbG3P8nQzY1x3mj9ik5MrPcy21Q5Fj1qYzFTIqqph4knddIw
         sSws7+mq2KXzKkqPMpcqevOYqELUXavjGQw66mq5Op2862n9b0BykN5SnGKV1AkkelE9
         KZ2cfV7aol0gcQjsaSg4DZJkYyHDN+eprbQbQGAZayooxmoqcIFexXzZXZft7mjlPClY
         j9hgc0iu0KXc7pwJzFxWMCXvdnaKXXrcmoYe9HNN9b2bw+DFJYTksr9+7oPRoXhOZ4IH
         EH3V3g018oYswcBNO57TnUpFPv3F+0Spz+WN42ftskXt0SiZlWnisTB48moqSecwYl8c
         jYDg==
X-Forwarded-Encrypted: i=1; AJvYcCWEgPawg9ryACZJZW8giM6HQNfHf+3bdJIoAWvqqjEQC4RGjG6MIIf0dKaj1QmBZHdnnbsq4ufqltB1vi1RLKb3p0GSM4deOtyt
X-Gm-Message-State: AOJu0Yw7P1te/ttf0vH03UssBXHwiCVnMxzqnJNVou64StuKTbdM/8b2
	i3A6hM35mARpkOOKTeOmSpzavgcSGk5jgp4aj5agzewEyv64MJoz6Tm+6/w3quM=
X-Google-Smtp-Source: AGHT+IFJLbfeGtbha0JVbIZTeiai8FTB/X6n+UdCuNQI1XT7w/ymHZH+kptfqSeAe/qiMeK3y/y/zQ==
X-Received: by 2002:a17:906:b153:b0:a43:dae8:d43c with SMTP id bt19-20020a170906b15300b00a43dae8d43cmr8570426ejb.32.1710338927934;
        Wed, 13 Mar 2024 07:08:47 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906308100b00a458d52a5f7sm4848776ejv.28.2024.03.13.07.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:08:47 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 01/15] dmaengine: bcm2835: Fix several spellos
Date: Wed, 13 Mar 2024 15:08:26 +0100
Message-ID: <f57e15192166d696aca23804f8ac79dfe81fd399.1710226514.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710226514.git.andrea.porta@suse.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed Codespell reported warnings about spelling and coding convention
violations, among which there are also a couple potential operator
precedence issue in macroes.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 96 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..428253b468ac 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -51,13 +51,13 @@ struct bcm2835_dmadev {
 };
 
 struct bcm2835_dma_cb {
-	uint32_t info;
-	uint32_t src;
-	uint32_t dst;
-	uint32_t length;
-	uint32_t stride;
-	uint32_t next;
-	uint32_t pad[2];
+	u32 info;
+	u32 src;
+	u32 dst;
+	u32 length;
+	u32 stride;
+	u32 next;
+	u32 pad[2];
 };
 
 struct bcm2835_cb_entry {
@@ -116,8 +116,8 @@ struct bcm2835_desc {
 					       * AXI-write to ack
 					       */
 #define BCM2835_DMA_ERR		BIT(8)
-#define BCM2835_DMA_PRIORITY(x) ((x & 15) << 16) /* AXI priority */
-#define BCM2835_DMA_PANIC_PRIORITY(x) ((x & 15) << 20) /* panic priority */
+#define BCM2835_DMA_PRIORITY(x) (((x) & 15) << 16) /* AXI priority */
+#define BCM2835_DMA_PANIC_PRIORITY(x) (((x) & 15) << 20) /* panic priority */
 /* current value of TI.BCM2835_DMA_WAIT_RESP */
 #define BCM2835_DMA_WAIT_FOR_WRITES BIT(28)
 #define BCM2835_DMA_DIS_DEBUG	BIT(29) /* disable debug pause signal */
@@ -136,9 +136,9 @@ struct bcm2835_desc {
 #define BCM2835_DMA_S_WIDTH	BIT(9) /* 128bit writes if set */
 #define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
 #define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 */
-#define BCM2835_DMA_BURST_LENGTH(x) ((x & 15) << 12)
-#define BCM2835_DMA_PER_MAP(x)	((x & 31) << 16) /* REQ source */
-#define BCM2835_DMA_WAIT(x)	((x & 31) << 21) /* add DMA-wait cycles */
+#define BCM2835_DMA_BURST_LENGTH(x) (((x) & 15) << 12)
+#define BCM2835_DMA_PER_MAP(x)	(((x) & 31) << 16) /* REQ source */
+#define BCM2835_DMA_WAIT(x)	(((x) & 31) << 21) /* add DMA-wait cycles */
 #define BCM2835_DMA_NO_WIDE_BURSTS BIT(26) /* no 2 beat write bursts */
 
 /* debug register bits */
@@ -214,17 +214,15 @@ static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 
 static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 {
-	bcm2835_dma_free_cb_chain(
-		container_of(vd, struct bcm2835_desc, vd));
+	bcm2835_dma_free_cb_chain(container_of(vd, struct bcm2835_desc, vd));
 }
 
-static void bcm2835_dma_create_cb_set_length(
-	struct bcm2835_chan *chan,
-	struct bcm2835_dma_cb *control_block,
-	size_t len,
-	size_t period_len,
-	size_t *total_len,
-	u32 finalextrainfo)
+static void bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
+					     struct bcm2835_dma_cb *control_block,
+					     size_t len,
+					     size_t period_len,
+					     size_t *total_len,
+					     u32 finalextrainfo)
 {
 	size_t max_len = bcm2835_dma_max_frame_length(chan);
 
@@ -260,10 +258,9 @@ static void bcm2835_dma_create_cb_set_length(
 	control_block->info |= finalextrainfo;
 }
 
-static inline size_t bcm2835_dma_count_frames_for_sg(
-	struct bcm2835_chan *c,
-	struct scatterlist *sgl,
-	unsigned int sg_len)
+static inline size_t bcm2835_dma_count_frames_for_sg(struct bcm2835_chan *c,
+						     struct scatterlist *sgl,
+						     unsigned int sg_len)
 {
 	size_t frames = 0;
 	struct scatterlist *sgent;
@@ -271,8 +268,8 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
 	size_t plength = bcm2835_dma_max_frame_length(c);
 
 	for_each_sg(sgl, sgent, sg_len, i)
-		frames += bcm2835_dma_frames_for_length(
-			sg_dma_len(sgent), plength);
+		frames += bcm2835_dma_frames_for_length(sg_dma_len(sgent),
+							plength);
 
 	return frames;
 }
@@ -298,10 +295,13 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @gfp:            the GFP flag to use for allocation
  */
 static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
-	struct dma_chan *chan, enum dma_transfer_direction direction,
-	bool cyclic, u32 info, u32 finalextrainfo, size_t frames,
-	dma_addr_t src, dma_addr_t dst, size_t buf_len,
-	size_t period_len, gfp_t gfp)
+					struct dma_chan *chan,
+					enum dma_transfer_direction direction,
+					bool cyclic, u32 info,
+					u32 finalextrainfo,
+					size_t frames, dma_addr_t src,
+					dma_addr_t dst, size_t buf_len,
+					size_t period_len, gfp_t gfp)
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t len = buf_len, total_len;
@@ -343,10 +343,10 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
-			bcm2835_dma_create_cb_set_length(
-				c, control_block,
-				len, period_len, &total_len,
-				cyclic ? finalextrainfo : 0);
+			bcm2835_dma_create_cb_set_length(c, control_block,
+							 len, period_len,
+							 &total_len,
+							 cyclic ? finalextrainfo : 0);
 
 			/* calculate new remaining length */
 			len -= control_block->length;
@@ -369,8 +369,8 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	/* the last frame requires extra flags */
 	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
 
-	/* detect a size missmatch */
-	if (buf_len && (d->size != buf_len))
+	/* detect a size mismatch */
+	if (buf_len && d->size != buf_len)
 		goto error_cb;
 
 	return d;
@@ -410,7 +410,7 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 static void bcm2835_dma_abort(struct bcm2835_chan *c)
 {
 	void __iomem *chan_base = c->chan_base;
-	long int timeout = 10000;
+	long timeout = 10000;
 
 	/*
 	 * A zero control block address means the channel is idle.
@@ -438,7 +438,6 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
 static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 {
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
-	struct bcm2835_desc *d;
 
 	if (!vd) {
 		c->desc = NULL;
@@ -447,9 +446,9 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 
 	list_del(&vd->node);
 
-	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
+	c->desc = to_bcm2835_dma_desc(&vd->tx);
 
-	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
+	writel(c->desc->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
 	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
 }
 
@@ -560,7 +559,8 @@ static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
 }
 
 static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
-	dma_cookie_t cookie, struct dma_tx_state *txstate)
+					     dma_cookie_t cookie,
+					     struct dma_tx_state *txstate)
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct virt_dma_desc *vd;
@@ -860,7 +860,7 @@ static const struct of_device_id bcm2835_dma_of_match[] = {
 MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
 
 static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
-					   struct of_dma *ofdma)
+					  struct of_dma *ofdma)
 {
 	struct bcm2835_dmadev *d = ofdma->of_dma_data;
 	struct dma_chan *chan;
@@ -883,7 +883,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	int i, j;
 	int irq[BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED + 1];
 	int irq_flags;
-	uint32_t chans_available;
+	u32 chans_available;
 	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
 
 	if (!pdev->dev.dma_mask)
@@ -942,8 +942,8 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 	/* Request DMA channel mask from device tree */
 	if (of_property_read_u32(pdev->dev.of_node,
-			"brcm,dma-channel-mask",
-			&chans_available)) {
+				 "brcm,dma-channel-mask",
+				 &chans_available)) {
 		dev_err(&pdev->dev, "Failed to get channel mask\n");
 		rc = -EINVAL;
 		goto err_no_dma;
@@ -982,7 +982,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		/* check if there are other channels that also use this irq */
 		irq_flags = 0;
 		for (j = 0; j <= BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED; j++)
-			if ((i != j) && (irq[j] == irq[i])) {
+			if (i != j && irq[j] == irq[i]) {
 				irq_flags = IRQF_SHARED;
 				break;
 			}
@@ -997,7 +997,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 	/* Device-tree DMA controller registration */
 	rc = of_dma_controller_register(pdev->dev.of_node,
-			bcm2835_dma_xlate, od);
+					bcm2835_dma_xlate, od);
 	if (rc) {
 		dev_err(&pdev->dev, "Failed to register DMA controller\n");
 		goto err_no_dma;
-- 
2.35.3


