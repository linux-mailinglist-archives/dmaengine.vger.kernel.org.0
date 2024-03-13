Return-Path: <dmaengine+bounces-1371-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495987A93A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA60DB22652
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B55820C;
	Wed, 13 Mar 2024 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d0N9Wa5y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE354676
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338953; cv=none; b=JcqbxLaRpMVHztdNEkYgrM7CYLN5W/No5G0h5OZ3GSgD0JgOtckElQ6I64C5567GkwF1aIjOUGfkic6iSycigL+14ZlnG+0UkTq9Exeak/VZ8PqcosgaL+252V+uv7jYQzoJS9cIAS9kRiWNjotl4AVGaSxnziHwXkcV7WvlFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338953; c=relaxed/simple;
	bh=ydMyNKlgJjwenSdKz23pqgfrZw8hKMeYS+sXWLgsu20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdCcgEnL8de1EA+U8CfIn0Ln1QJzLky6cDHez+RisTGQUAjx7ZRteBRjxbV0uMk0yKf6P7acUC1t+7SqZcJFRprTA8idNTrHA2HBnjug7UySZHpC4uRPqMxkBO7ZIHv8ZigD1eJy1jtMxsrnz722jxBAWGHxHQJX9l3aXotiubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d0N9Wa5y; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso1432385a12.2
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338947; x=1710943747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHhJLSPwlFyN1v47/5LFzL8wYfsbaOex6ckiVXFurW8=;
        b=d0N9Wa5y5sjTOnBo9sCYT1phDUcaKpF1yaHfxWy4wwBuqXtFlGheVHtvqyGXTR4PNB
         D+FCjmmuOq34D8weCwsVKKpkkKJ1K5ECSA/PBGd8VBPIJ1gZ1O21oHArHVy4mzuHRGE1
         fkwWou+JMcUTadJ6ZV/ifbA7R4gRD58+BVowuPtXSRQJBMIqolCFKif1QOBOSaexukc1
         VlHvLPOaHCZusSfvSiSHNCsiUe/wXOKLWCbPD/yPaZLdAzyc2FLqsceiUUeMlBAIgNEu
         Q9smUMvkwFgLvKqNYrQrbdeARsr+FfvIM93BUDd/tpNAT4e8wnGx88Kvgxg/1qj/vtQj
         /DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338947; x=1710943747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHhJLSPwlFyN1v47/5LFzL8wYfsbaOex6ckiVXFurW8=;
        b=llOEz0IJtiLWmRSyOdFQYviG62/kFZwbadGexyoTkFIHvUmt8JFO6rxXamOLfyso8w
         /f0ZhZIJP1EeO53h3ZvPb60q4/T80yDOBtpkqp1vNO0BOsJxtWe3lKo0sWI9v/VP4UP+
         VQ0BL8CGpqa/jV3J+45CCNUPUJJ3YrSwbqsqvy2Qti/b0oHKGyi0rKCH9jv8VTzLa34Y
         ohKTyKayCbQg9x6sCcab/2fXWdaZ11oC1wCuWfaabb4XeifyYan8/2AxGsCtT1qNkGwU
         jK+uiShWCuimDiTD658MkVsL/qBEK5s1pd/44bntR27fKuyV1uGOfi+JoKxJqmRU4mtF
         j4LA==
X-Forwarded-Encrypted: i=1; AJvYcCXDoKQYwxfi/+MfbN7+xgpwy3HvhPTeUeutN+7HlTPCyyV8x5zlR7G9MzCnVzvWGDKYvULr3A8xeA+UCxszkZ9KGsdLD4VngLmy
X-Gm-Message-State: AOJu0YzJVs1O+4jr7J5v9NsLOPACqZh5/qoXgcmuTq/UKADhDqZByZ9q
	IEceqbJylsQ/+bClKa7HtIidUw2Fsq2KJD4VC3hAgOwYFZpoDVPPNYxNg3GQddc=
X-Google-Smtp-Source: AGHT+IFZfUFO6ec8Hx97O9B1PZ+LLxyMeP2rh4T4+M4aVsshiF4u+OjXLBBsFevavT315MEjdHrngA==
X-Received: by 2002:a50:ab19:0:b0:565:7edf:41b0 with SMTP id s25-20020a50ab19000000b005657edf41b0mr2660468edc.6.1710338946596;
        Wed, 13 Mar 2024 07:09:06 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id s21-20020a50ab15000000b00568699d4b83sm2404091edc.44.2024.03.13.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:09:06 -0700 (PDT)
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
Subject: [PATCH v2 14/15] dmaengine: bcm2835: Add BCM2711 40-bit DMA support
Date: Wed, 13 Mar 2024 15:08:39 +0100
Message-ID: <8e4dceada017ea4804d7dac16c2a4974807a2c01.1710226514.git.andrea.porta@suse.com>
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

BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
to access the full 4GB of memory on a Pi 4. Assume every channel is capable
of 40-bit address range.

Originally-by: Phil Elwell <phil@raspberrypi.org>
Originally-by: Maxime Ripard <maxime@cerno.tech>
Originally-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 553 ++++++++++++++++++++++++++++++++------
 1 file changed, 466 insertions(+), 87 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index b015eae29b08..5c8dde8b07cd 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -36,13 +36,15 @@
 
 #define BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED 14
 #define BCM2835_DMA_CHAN_NAME_SIZE 8
+#define BCM2711_DMA40_PHYS_ADDR 0x400000000ULL
+#define BCM2835_DMA_ABORT_TIMEOUT 100
 
 /**
  * struct bcm2835_dmadev - BCM2835 DMA controller
  * @ddev: DMA device
  * @base: base address of register map
  * @zero_page: bus address of zero page (to detect transactions copying from
- *	zero page and avoid accessing memory if so)
+ *	       zero page and avoid accessing memory if so)
  */
 struct bcm2835_dmadev {
 	struct dma_device ddev;
@@ -52,7 +54,7 @@ struct bcm2835_dmadev {
 };
 
 struct bcm_dma_cb {
-	uint32_t rsvd[8];
+	u32 rsvd[8];
 };
 
 struct bcm2835_dma_cb {
@@ -65,6 +67,17 @@ struct bcm2835_dma_cb {
 	u32 pad[2];
 };
 
+struct bcm2711_dma40_scb {
+	u32 ti;
+	u32 src;
+	u32 srci;
+	u32 dst;
+	u32 dsti;
+	u32 len;
+	u32 next_cb;
+	u32 rsvd;
+};
+
 struct bcm2835_cb_entry {
 	struct bcm_dma_cb *cb;
 	dma_addr_t paddr;
@@ -102,14 +115,16 @@ struct bcm2835_dma_cfg {
 	u32 s_dreq_mask;
 	u32 d_dreq_mask;
 
+	u64 dma_mask;
+
 	u32 (*cb_get_length)(void *data);
 	dma_addr_t (*cb_get_addr)(void *data, enum dma_transfer_direction);
 
 	void (*cb_init)(void *data, struct bcm2835_chan *c,
-			enum dma_transfer_direction, u32 src, u32 dst,
+			enum dma_transfer_direction, dma_addr_t src, dma_addr_t dst,
 			bool zero_page);
-	void (*cb_set_src)(void *data, enum dma_transfer_direction, u32 src);
-	void (*cb_set_dst)(void *data, enum dma_transfer_direction, u32 dst);
+	void (*cb_set_src)(void *data, enum dma_transfer_direction, dma_addr_t src);
+	void (*cb_set_dst)(void *data, enum dma_transfer_direction, dma_addr_t dst);
 	void (*cb_set_next)(void *data, u32 next);
 	void (*cb_set_length)(void *data, u32 length);
 	void (*cb_append_extra)(void *data,
@@ -123,6 +138,7 @@ struct bcm2835_dma_cfg {
 	dma_addr_t (*read_addr)(struct bcm2835_chan *c,
 				enum dma_transfer_direction);
 	u32 (*cs_flags)(struct bcm2835_chan *c);
+	void (*dma_abort)(struct bcm2835_chan *c, const struct bcm2835_dma_cfg *cfg);
 };
 
 struct bcm2835_desc {
@@ -233,13 +249,110 @@ struct bcm2835_desc {
 #define BCM2835_DMA_DATA_TYPE_S128	16
 
 /* Valid only for channels 0 - 14, 15 has its own base address */
-#define BCM2835_DMA_CHAN(n)	((n) << 8) /* Base address */
+#define BCM2835_DMA_CHAN_SIZE	0x100
+#define BCM2835_DMA_CHAN(n)	((n) * BCM2835_DMA_CHAN_SIZE) /* Base address */
 #define BCM2835_DMA_CHANIO(base, n) ((base) + BCM2835_DMA_CHAN(n))
 
+/* 40-bit DMA support */
+#define BCM2711_DMA40_CS       0x00
+#define BCM2711_DMA40_CB       0x04
+#define BCM2711_DMA40_DEBUG    0x0c
+#define BCM2711_DMA40_TI       0x10
+#define BCM2711_DMA40_SRC      0x14
+#define BCM2711_DMA40_SRCI     0x18
+#define BCM2711_DMA40_DEST     0x1c
+#define BCM2711_DMA40_DESTI    0x20
+#define BCM2711_DMA40_LEN      0x24
+#define BCM2711_DMA40_NEXT_CB  0x28
+#define BCM2711_DMA40_DEBUG2   0x2c
+
+#define BCM2711_DMA40_ACTIVE           BIT(0)
+#define BCM2711_DMA40_END              BIT(1)
+#define BCM2711_DMA40_INT              BIT(2)
+#define BCM2711_DMA40_DREQ             BIT(3)  /* DREQ state */
+#define BCM2711_DMA40_RD_PAUSED        BIT(4)  /* Reading is paused */
+#define BCM2711_DMA40_WR_PAUSED        BIT(5)  /* Writing is paused */
+#define BCM2711_DMA40_DREQ_PAUSED      BIT(6)  /* Is paused by DREQ flow control */
+#define BCM2711_DMA40_WAITING_FOR_WRITES BIT(7)  /* Waiting for last write */
+#define BCM2711_DMA40_ERR              BIT(10)
+#define BCM2711_DMA40_QOS(x)           FIELD_PREP(GENMASK(19, 16), x)
+#define BCM2711_DMA40_PANIC_QOS(x)     FIELD_PREP(GENMASK(23, 20), x)
+#define BCM2711_DMA40_WAIT_FOR_WRITES  BIT(28)
+#define BCM2711_DMA40_DISDEBUG         BIT(29)
+#define BCM2711_DMA40_ABORT            BIT(30)
+#define BCM2711_DMA40_HALT             BIT(31)
+// we always want to run in supervisor mode
+#define BCM2711_DMA40_PROT		(BIT(8) | BIT(9))
+#define BCM2711_DMA40_TRANSACTIONS	BIT(25)
+#define BCM2711_DMA40_CS_FLAGS(x) ((x) & (BCM2711_DMA40_QOS(15) | \
+					BCM2711_DMA40_PANIC_QOS(15) | \
+					BCM2711_DMA40_WAIT_FOR_WRITES |	\
+					BCM2711_DMA40_DISDEBUG))
+
+/* Transfer information bits */
+#define BCM2711_DMA40_INTEN            BIT(0)
+#define BCM2711_DMA40_TDMODE           BIT(1) /* 2D-Mode */
+#define BCM2711_DMA40_WAIT_RESP        BIT(2) /* wait for AXI write to be acked */
+#define BCM2711_DMA40_WAIT_RD_RESP     BIT(3) /* wait for AXI read to complete */
+#define BCM2711_DMA40_PER_MAP(x)       (((x) & 31) << 9) /* REQ source */
+#define BCM2711_DMA40_S_DREQ           BIT(14) /* enable SREQ for source */
+#define BCM2711_DMA40_D_DREQ           BIT(15) /* enable DREQ for destination */
+#define BCM2711_DMA40_S_WAIT(x)        FIELD_PREP(GENMASK(23, 16), x) /* add DMA read-wait cycles */
+#define BCM2711_DMA40_D_WAIT(x)        FIELD_PREP(GENMASK(31, 24), x) /* add DMA write-wait cycles */
+
+#define BCM2711_DMA40_INC              BIT(12)
+#define BCM2711_DMA40_IGNORE           BIT(15)
+
 /* the max dma length for different channels */
 #define MAX_DMA_LEN SZ_1G
 #define MAX_LITE_DMA_LEN (SZ_64K - 4)
 
+/* debug register bits */
+#define BCM2711_DMA40_DEBUG_WRITE_ERR		BIT(0)
+#define BCM2711_DMA40_DEBUG_FIFO_ERR		BIT(1)
+#define BCM2711_DMA40_DEBUG_READ_ERR		BIT(2)
+#define BCM2711_DMA40_DEBUG_READ_CB_ERR		BIT(3)
+#define BCM2711_DMA40_DEBUG_IN_ON_ERR		BIT(8)
+#define BCM2711_DMA40_DEBUG_ABORT_ON_ERR	BIT(9)
+#define BCM2711_DMA40_DEBUG_HALT_ON_ERR		BIT(10)
+#define BCM2711_DMA40_DEBUG_DISABLE_CLK_GATE	BIT(11)
+#define BCM2711_DMA40_DEBUG_RSTATE_SHIFT	14
+#define BCM2711_DMA40_DEBUG_RSTATE_BITS		4
+#define BCM2711_DMA40_DEBUG_WSTATE_SHIFT	18
+#define BCM2711_DMA40_DEBUG_WSTATE_BITS		4
+#define BCM2711_DMA40_DEBUG_RESET		BIT(23)
+#define BCM2711_DMA40_DEBUG_ID_SHIFT		24
+#define BCM2711_DMA40_DEBUG_ID_BITS		4
+#define BCM2711_DMA40_DEBUG_VERSION_SHIFT	28
+#define BCM2711_DMA40_DEBUG_VERSION_BITS	4
+
+/* Valid only for channels 0 - 3 (11 - 14) */
+#define BCM2711_DMA40_CHAN(n)	(((n) + 11) << 8) /* Base address */
+#define BCM2711_DMA40_CHANIO(base, n) ((base) + BCM2711_DMA_CHAN(n))
+
+/* the max dma length for different channels */
+#define MAX_DMA40_LEN SZ_1G
+
+#define BCM2711_DMA40_BURST_LEN(x)      (((x) & 15) << 8)
+#define BCM2711_DMA40_INC		BIT(12)
+#define BCM2711_DMA40_SIZE_32		(0 << 13)
+#define BCM2711_DMA40_SIZE_64		(1 << 13)
+#define BCM2711_DMA40_SIZE_128		(2 << 13)
+#define BCM2711_DMA40_SIZE_256		(3 << 13)
+#define BCM2711_DMA40_IGNORE		BIT(15)
+#define BCM2711_DMA40_STRIDE(x)		((x) << 16) /* For 2D mode */
+
+#define BCM2711_DMA40_MEMCPY_FLAGS \
+	(BCM2711_DMA40_QOS(0) | \
+	 BCM2711_DMA40_PANIC_QOS(0) | \
+	 BCM2711_DMA40_WAIT_FOR_WRITES | \
+	 BCM2711_DMA40_DISDEBUG)
+
+#define BCM2711_DMA40_MEMCPY_XFER_INFO \
+	(BCM2711_DMA40_SIZE_128 | \
+	 BCM2711_DMA40_INC | \
+	 BCM2711_DMA40_BURST_LEN(16))
+
 static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
 {
 	/* lite and normal channels have different max frame length */
@@ -270,8 +383,7 @@ static inline struct bcm2835_chan *to_bcm2835_dma_chan(struct dma_chan *c)
 	return container_of(c, struct bcm2835_chan, vc.chan);
 }
 
-static inline struct bcm2835_desc *to_bcm2835_dma_desc(
-		struct dma_async_tx_descriptor *t)
+static inline struct bcm2835_desc *to_bcm2835_dma_desc(struct dma_async_tx_descriptor *t)
 {
 	return container_of(t, struct bcm2835_desc, vd.tx);
 }
@@ -296,9 +408,8 @@ static u32 bcm2835_dma_prepare_cb_info(struct bcm2835_chan *c,
 		result |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
 
 		/* non-lite channels can write zeroes w/o accessing memory */
-		if (zero_page && !c->is_lite_channel) {
+		if (zero_page && !c->is_lite_channel)
 			result |= BCM2835_DMA_S_IGNORE;
-		}
 	}
 
 	return result;
@@ -324,6 +435,66 @@ static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
 	return result;
 }
 
+static inline uint32_t to_bcm2711_ti(uint32_t info)
+{
+	return ((info & BCM2835_DMA_INT_EN) ? BCM2711_DMA40_INTEN : 0) |
+		((info & BCM2835_DMA_WAIT_RESP) ? BCM2711_DMA40_WAIT_RESP : 0) |
+		((info & BCM2835_DMA_S_DREQ) ?
+		 (BCM2711_DMA40_S_DREQ | BCM2711_DMA40_WAIT_RD_RESP) : 0) |
+		((info & BCM2835_DMA_D_DREQ) ? BCM2711_DMA40_D_DREQ : 0) |
+		BCM2711_DMA40_PER_MAP((info >> 16) & 0x1f);
+}
+
+static inline uint32_t to_bcm2711_srci(uint32_t info)
+{
+	return ((info & BCM2835_DMA_S_INC) ? BCM2711_DMA40_INC : 0) |
+	       ((info & BCM2835_DMA_S_WIDTH) ? BCM2711_DMA40_SIZE_128 : 0) |
+	       BCM2711_DMA40_BURST_LEN(BCM2835_DMA_GET_BURST_LENGTH(info));
+}
+
+static inline uint32_t to_bcm2711_dsti(uint32_t info)
+{
+	return ((info & BCM2835_DMA_D_INC) ? BCM2711_DMA40_INC : 0) |
+	       ((info & BCM2835_DMA_D_WIDTH) ? BCM2711_DMA40_SIZE_128 : 0) |
+	       BCM2711_DMA40_BURST_LEN(BCM2835_DMA_GET_BURST_LENGTH(info));
+}
+
+static u32 bcm2711_dma_prepare_cb_info(struct bcm2835_chan *c,
+				       enum dma_transfer_direction direction,
+				       bool zero_page)
+{
+	u32 result = 0;
+	u32 info;
+
+	info = bcm2835_dma_prepare_cb_info(c, direction, zero_page);
+	result = to_bcm2711_ti(info);
+
+	return result;
+}
+
+static u32 bcm2711_dma_prepare_cb_extra(struct bcm2835_chan *c,
+					enum dma_transfer_direction direction,
+					bool cyclic, bool final,
+					unsigned long flags)
+{
+	u32 result = 0;
+
+	if (cyclic) {
+		if (flags & DMA_PREP_INTERRUPT)
+			result |= BCM2711_DMA40_INTEN;
+	} else {
+		if (!final)
+			return 0;
+
+		result |= BCM2711_DMA40_INTEN;
+
+		if (direction == DMA_MEM_TO_MEM)
+			result |= BCM2711_DMA40_WAIT_RESP;
+	}
+
+	return result;
+}
+
 static inline bool need_src_incr(enum dma_transfer_direction direction)
 {
 	return direction != DMA_DEV_TO_MEM;
@@ -342,6 +513,12 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
 	return false;
 }
 
+static inline uint32_t to_bcm2711_cbaddr(dma_addr_t addr)
+{
+	WARN_ON_ONCE(addr & 0x1f);
+	return (addr >> 5);
+}
+
 static inline u32 bcm2835_dma_cb_get_length(void *data)
 {
 	struct bcm2835_dma_cb *cb = data;
@@ -362,7 +539,7 @@ bcm2835_dma_cb_get_addr(void *data, enum dma_transfer_direction direction)
 
 static inline void
 bcm2835_dma_cb_init(void *data, struct bcm2835_chan *c,
-		    enum dma_transfer_direction direction, u32 src, u32 dst,
+		    enum dma_transfer_direction direction, dma_addr_t src, dma_addr_t dst,
 		    bool zero_page)
 {
 	struct bcm2835_dma_cb *cb = data;
@@ -376,7 +553,7 @@ bcm2835_dma_cb_init(void *data, struct bcm2835_chan *c,
 
 static inline void
 bcm2835_dma_cb_set_src(void *data, enum dma_transfer_direction direction,
-                      u32 src)
+		       dma_addr_t src)
 {
 	struct bcm2835_dma_cb *cb = data;
 
@@ -385,7 +562,7 @@ bcm2835_dma_cb_set_src(void *data, enum dma_transfer_direction direction,
 
 static inline void
 bcm2835_dma_cb_set_dst(void *data, enum dma_transfer_direction direction,
-                      u32 dst)
+		       dma_addr_t dst)
 {
 	struct bcm2835_dma_cb *cb = data;
 
@@ -445,6 +622,124 @@ static u32 bcm2835_dma_cs_flags(struct bcm2835_chan *c)
 	return BCM2835_DMA_CS_FLAGS(c->dreq);
 }
 
+static inline u32 bcm2711_dma_cb_get_length(void *data)
+{
+	struct bcm2711_dma40_scb *scb = data;
+
+	return scb->len;
+}
+
+static inline dma_addr_t
+bcm2711_dma_cb_get_addr(void *data, enum dma_transfer_direction direction)
+{
+	struct bcm2711_dma40_scb *scb = data;
+
+	if (direction == DMA_DEV_TO_MEM)
+		return (dma_addr_t)scb->dst + ((dma_addr_t)(scb->dsti & 0xff) << 32);
+
+	return (dma_addr_t)scb->src + ((dma_addr_t)(scb->srci & 0xff) << 32);
+}
+
+static inline void
+bcm2711_dma_cb_init(void *data, struct bcm2835_chan *c,
+		    enum dma_transfer_direction direction, dma_addr_t src, dma_addr_t dst,
+		    bool zero_page)
+{
+	struct bcm2711_dma40_scb *scb = data;
+	u32 info = bcm2835_dma_prepare_cb_info(c, direction, zero_page);
+
+	scb->ti = bcm2711_dma_prepare_cb_info(c, direction, zero_page);
+
+	scb->src = lower_32_bits(src);
+	scb->srci = upper_32_bits(src);
+	scb->srci |= to_bcm2711_srci(info);
+
+	scb->dst = lower_32_bits(dst);
+	scb->dsti = upper_32_bits(dst);
+	scb->dsti |= to_bcm2711_dsti(info);
+
+	scb->next_cb = 0;
+}
+
+static inline void
+bcm2711_dma_cb_set_src(void *data, enum dma_transfer_direction direction,
+		       dma_addr_t src)
+{
+	struct bcm2711_dma40_scb *scb = data;
+
+	scb->src = lower_32_bits(src);
+	scb->srci = upper_32_bits(src);
+
+	if (need_src_incr(direction))
+		scb->srci |= BCM2711_DMA40_INC;
+}
+
+static inline void
+bcm2711_dma_cb_set_dst(void *data, enum dma_transfer_direction direction,
+		       dma_addr_t dst)
+{
+	struct bcm2711_dma40_scb *scb = data;
+
+	scb->dst = lower_32_bits(dst);
+	scb->dsti = upper_32_bits(dst);
+
+	if (need_dst_incr(direction))
+		scb->dsti |= BCM2711_DMA40_INC;
+}
+
+static inline void bcm2711_dma_cb_set_next(void *data, u32 next)
+{
+	struct bcm2711_dma40_scb *scb = data;
+
+	scb->next_cb = next;
+}
+
+static inline void bcm2711_dma_cb_set_length(void *data, u32 length)
+{
+	struct bcm2711_dma40_scb *scb = data;
+
+	scb->len = length;
+}
+
+static inline void
+bcm2711_dma_cb_append_extra(void *data, struct bcm2835_chan *c,
+			    enum dma_transfer_direction direction,
+			    bool cyclic, bool final, unsigned long flags)
+{
+	struct bcm2711_dma40_scb *scb = data;
+
+	scb->ti |= bcm2711_dma_prepare_cb_extra(c, direction, cyclic, final,
+						flags);
+}
+
+static inline dma_addr_t bcm2711_dma_to_cb_addr(dma_addr_t addr)
+{
+	WARN_ON_ONCE(addr & 0x1f);
+	return (addr >> 5);
+}
+
+static void bcm2711_dma_chan_plat_init(struct bcm2835_chan *c)
+{
+}
+
+static dma_addr_t bcm2711_dma_read_addr(struct bcm2835_chan *c,
+					enum dma_transfer_direction direction)
+{
+	if (direction == DMA_MEM_TO_DEV)
+		return (dma_addr_t)readl(c->chan_base + BCM2711_DMA40_SRC) +
+			     ((dma_addr_t)(readl(c->chan_base + BCM2711_DMA40_SRCI) & 0xff) << 32);
+	else if (direction == DMA_DEV_TO_MEM)
+		return (dma_addr_t)readl(c->chan_base + BCM2711_DMA40_DEST) +
+			     ((dma_addr_t)(readl(c->chan_base + BCM2711_DMA40_DESTI) & 0xff) << 32);
+
+	return 0;
+}
+
+static u32 bcm2711_dma_cs_flags(struct bcm2835_chan *c)
+{
+	return BCM2711_DMA40_CS_FLAGS(c->dreq) | BCM2711_DMA40_PROT;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -470,36 +765,34 @@ static bool bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
 	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
+	u32 cb_len;
 
 	/* set the length taking lite-channel limitations into account */
-	u32 length = min_t(u32, len, max_len);
+	cb_len = min_t(u32, len, max_len);
 
-	cfg->cb_set_length(data, length);
+	if (period_len) {
+		/*
+		 * period_len means: that we need to generate
+		 * transfers that are terminating at every
+		 * multiple of period_len - this is typically
+		 * used to set the interrupt flag in info
+		 * which is required during cyclic transfers
+		 */
 
-	/* finished if we have no period_length */
-	if (!period_len)
-		return false;
+		/* have we filled in period_length yet? */
+		if (*total_len + cb_len < period_len) {
+			/* update number of bytes in this period so far */
+			*total_len += cb_len;
+		} else {
+			/* calculate the length that remains to reach period_len */
+			cb_len = period_len - *total_len;
 
-	/*
-	 * period_len means: that we need to generate
-	 * transfers that are terminating at every
-	 * multiple of period_len - this is typically
-	 * used to set the interrupt flag in info
-	 * which is required during cyclic transfers
-	 */
-
-	/* have we filled in period_length yet? */
-	if (*total_len + length < period_len) {
-		/* update number of bytes in this period so far */
-		*total_len += length;
-		return false;
+			/* reset total_length for next period */
+			*total_len = 0;
+		}
 	}
 
-	/* calculate the length that remains to reach period_length */
-	cfg->cb_set_length(data, period_len - *total_len);
-
-	/* reset total_length for next period */
-	*total_len = 0;
+	cfg->cb_set_length(data, cb_len);
 
 	return true;
 }
@@ -523,7 +816,7 @@ static inline size_t bcm2835_dma_count_frames_for_sg(struct bcm2835_chan *c,
 /**
  * bcm2835_dma_create_cb_chain - create a control block and fills data in
  *
- * @chan:           the @dma_chan for which we run this
+ * @c:              the @bcm2835_chan for which we run this
  * @direction:      the direction in which we transfer
  * @cyclic:         it is a cyclic transfer
  * @frames:         number of controlblocks to allocate
@@ -587,17 +880,19 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 
 		/* fill in the control block */
 		control_block = cb_entry->cb;
-		cfg->cb_init(control_block, c, src, dst, direction, zero_page);
+
+		cfg->cb_init(control_block, c, direction, src, dst, zero_page);
+
 		/* set up length in control_block if requested */
 		if (buf_len) {
 			/* calculate length honoring period_length */
-			if (bcm2835_dma_create_cb_set_length(
-				chan, control_block,
-				len, period_len, &total_len)) {
-				/* add extrainfo bits in info */
-				bcm2835_dma_cb_append_extra(control_block, c,
-							    direction, cyclic,
-							    false, flags);
+			if (bcm2835_dma_create_cb_set_length(chan, control_block,
+							     len, period_len,
+							     &total_len)) {
+					/* add extrainfo bits in info */
+					bcm2835_dma_cb_append_extra(control_block, c,
+								    direction, cyclic,
+								    false, flags);
 			}
 
 			/* calculate new remaining length */
@@ -607,11 +902,12 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 		/* link this the last controlblock */
 		if (frame)
 			cfg->cb_set_next(d->cb_list[frame - 1].cb,
-					 cb_entry->paddr);
+					 cfg->to_cb_addr(cb_entry->paddr));
 
 		/* update src and dst and length */
 		if (src && need_src_incr(direction))
 			src += cfg->cb_get_length(control_block);
+
 		if (dst && need_dst_incr(direction))
 			dst += cfg->cb_get_length(control_block);
 
@@ -621,7 +917,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 
 	/* the last frame requires extra flags */
 	cfg->cb_append_extra(d->cb_list[d->frames - 1].cb, c, direction, cyclic,
-			     true, flags);
+		     true, flags);
 
 	/* detect a size mismatch */
 	if (buf_len && d->size != buf_len)
@@ -650,7 +946,8 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 
 	max_len = bcm2835_dma_max_frame_length(c);
 	for_each_sg(sgl, sgent, sg_len, i) {
-		for (addr = sg_dma_address(sgent), len = sg_dma_len(sgent);
+		for (addr = sg_dma_address(sgent),
+		     len = sg_dma_len(sgent);
 		     len > 0;
 		     addr += cfg->cb_get_length(cb->cb), len -= cfg->cb_get_length(cb->cb), cb++) {
 			if (direction == DMA_DEV_TO_MEM)
@@ -662,48 +959,81 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 	}
 }
 
-static void bcm2835_dma_abort(struct dma_chan *chan)
+static void bcm2835_abort(struct bcm2835_chan *c, const struct bcm2835_dma_cfg *cfg)
 {
-	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
-	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
-	void __iomem *chan_base = c->chan_base;
-	long timeout = 100;
+	long timeout = BCM2835_DMA_ABORT_TIMEOUT;
 
-	/*
-	 * A zero control block address means the channel is idle.
-	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
-	 */
-	if (!readl(chan_base + cfg->cb_reg))
-		return;
+	/* Pause the current DMA */
+	writel(readl(c->chan_base + cfg->cs_reg) & ~cfg->active_mask,
+	       c->chan_base + cfg->cs_reg);
+
+	/* wait for outstanding transactions to complete */
+	while ((readl(c->chan_base + cfg->cs_reg) & BCM2711_DMA40_TRANSACTIONS) &&
+	       --timeout)
+		cpu_relax();
+
+	/* Peripheral might be stuck and fail to complete */
+	if (!timeout)
+		dev_err(c->vc.chan.device->dev,
+			"failed to complete pause on dma %d (CS:%08x)\n", c->ch,
+			readl(c->chan_base + cfg->cs_reg));
+
+	/* Set CS back to default state */
+	writel(BCM2711_DMA40_PROT, c->chan_base + cfg->cs_reg);
+
+	/* Reset the DMA */
+	writel(readl(c->chan_base + BCM2711_DMA40_DEBUG) | BCM2711_DMA40_DEBUG_RESET,
+	       c->chan_base + BCM2711_DMA40_DEBUG);
+}
+
+static void bcm2711_abort(struct bcm2835_chan *c, const struct bcm2835_dma_cfg *cfg)
+{
+	long timeout = BCM2835_DMA_ABORT_TIMEOUT;
 
 	/* We need to clear the next DMA block pending */
-	writel(0, chan_base + cfg->next_reg);
+	writel(0, c->chan_base + cfg->next_reg);
 
 	/* Abort the DMA, which needs to be enabled to complete */
-	writel(readl(chan_base + cfg->cs_reg) | cfg->abort_mask | cfg->active_mask,
-	       chan_base + cfg->cs_reg);
+	writel(readl(c->chan_base + cfg->cs_reg) | cfg->abort_mask | cfg->active_mask,
+	       c->chan_base + cfg->cs_reg);
 
 	/* wait for DMA to be aborted */
-	while ((readl(chan_base + cfg->cs_reg) & cfg->abort_mask) && --timeout)
+	while ((readl(c->chan_base + cfg->cs_reg) & cfg->abort_mask) && --timeout)
 		cpu_relax();
 
 	/* Write 0 to the active bit - Pause the DMA */
-	writel(readl(chan_base + cfg->cs_reg) & ~cfg->active_mask,
-	       chan_base + cfg->cs_reg);
+	writel(readl(c->chan_base + cfg->cs_reg) & ~cfg->active_mask,
+	       c->chan_base + cfg->cs_reg);
 
 	/*
 	 * Peripheral might be stuck and fail to complete
 	 * This is expected when dreqs are enabled but not asserted
 	 * so only report error in non dreq case
 	 */
-	if (!timeout && !(readl(chan_base + cfg->ti_reg) &
+	if (!timeout && !(readl(c->chan_base + cfg->ti_reg) &
 	   (cfg->s_dreq_mask | cfg->d_dreq_mask)))
 		dev_err(c->vc.chan.device->dev,
 			"failed to complete pause on dma %d (CS:%08x)\n", c->ch,
-			readl(chan_base + cfg->cs_reg));
+			readl(c->chan_base + cfg->cs_reg));
 
 	/* Set CS back to default state and reset the DMA */
-	writel(cfg->reset_mask, chan_base + cfg->cs_reg);
+	writel(cfg->reset_mask, c->chan_base + cfg->cs_reg);
+}
+
+static void bcm2835_dma_abort(struct dma_chan *chan)
+{
+	const struct bcm2835_dma_cfg *cfg = to_bcm2835_cfg(chan->device);
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	void __iomem *chan_base = c->chan_base;
+
+	/*
+	 * A zero control block address means the channel is idle.
+	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
+	 */
+	if (!readl(chan_base + cfg->cb_reg))
+		return;
+
+	cfg->dma_abort(c, cfg);
 }
 
 static void bcm2835_dma_start_desc(struct dma_chan *chan)
@@ -722,8 +1052,7 @@ static void bcm2835_dma_start_desc(struct dma_chan *chan)
 	c->desc = to_bcm2835_dma_desc(&vd->tx);
 
 	writel(cfg->to_cb_addr(c->desc->cb_list[0].paddr), c->chan_base + cfg->cb_reg);
-	writel(cfg->active_mask | cfg->cs_flags(c),
-	       c->chan_base + cfg->cs_reg);
+	writel(cfg->active_mask | cfg->cs_flags(c), c->chan_base + cfg->cs_reg);
 }
 
 static irqreturn_t bcm2835_dma_callback(int irq, void *data)
@@ -1106,6 +1435,8 @@ static const struct bcm2835_dma_cfg bcm2835_data = {
 	.s_dreq_mask = BCM2835_DMA_S_DREQ,
 	.d_dreq_mask = BCM2835_DMA_D_DREQ,
 
+	.dma_mask = DMA_BIT_MASK(32),
+
 	.cb_get_length = bcm2835_dma_cb_get_length,
 	.cb_get_addr = bcm2835_dma_cb_get_addr,
 	.cb_init = bcm2835_dma_cb_init,
@@ -1120,10 +1451,47 @@ static const struct bcm2835_dma_cfg bcm2835_data = {
 	.chan_plat_init = bcm2835_dma_chan_plat_init,
 	.read_addr = bcm2835_dma_read_addr,
 	.cs_flags = bcm2835_dma_cs_flags,
+	.dma_abort = bcm2835_abort,
+};
+
+static const struct bcm2835_dma_cfg bcm2711_data = {
+	.addr_offset = BCM2711_DMA40_PHYS_ADDR,
+
+	.cs_reg = BCM2711_DMA40_CS,
+	.cb_reg = BCM2711_DMA40_CB,
+	.next_reg = BCM2711_DMA40_NEXT_CB,
+	.ti_reg = BCM2711_DMA40_TI,
+
+	.wait_mask = BCM2711_DMA40_WAITING_FOR_WRITES,
+	.reset_mask = BCM2711_DMA40_HALT,
+	.int_mask = BCM2711_DMA40_INTEN,
+	.active_mask = BCM2711_DMA40_ACTIVE,
+	.abort_mask = BCM2711_DMA40_ABORT,
+	.s_dreq_mask = BCM2711_DMA40_S_DREQ,
+	.d_dreq_mask = BCM2711_DMA40_D_DREQ,
+
+	.dma_mask = DMA_BIT_MASK(36),
+
+	.cb_get_length = bcm2711_dma_cb_get_length,
+	.cb_get_addr = bcm2711_dma_cb_get_addr,
+	.cb_init = bcm2711_dma_cb_init,
+	.cb_set_src = bcm2711_dma_cb_set_src,
+	.cb_set_dst = bcm2711_dma_cb_set_dst,
+	.cb_set_next = bcm2711_dma_cb_set_next,
+	.cb_set_length = bcm2711_dma_cb_set_length,
+	.cb_append_extra = bcm2711_dma_cb_append_extra,
+
+	.to_cb_addr = bcm2711_dma_to_cb_addr,
+
+	.chan_plat_init = bcm2711_dma_chan_plat_init,
+	.read_addr = bcm2711_dma_read_addr,
+	.cs_flags = bcm2711_dma_cs_flags,
+	.dma_abort = bcm2711_abort,
 };
 
 static const struct of_device_id bcm2835_dma_of_match[] = {
 	{ .compatible = "brcm,bcm2835-dma", .data = &bcm2835_data },
+	{ .compatible = "brcm,bcm2711-dma", .data = &bcm2711_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
@@ -1147,6 +1515,7 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od;
+	struct resource *res;
 	void __iomem *base;
 	int rc;
 	int i, j;
@@ -1154,34 +1523,38 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	int irq_flags;
 	u32 chans_available;
 	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
+	int chan_count, chan_start, chan_end;
 
-        const void *cfg_data = device_get_match_data(&pdev->dev);
-        if (!cfg_data) {
-                dev_err(&pdev->dev, "Failed to match compatible string\n");
-                return -EINVAL;
-        }
+	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
+	if (!od)
+		return -ENOMEM;
 
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	od->cfg = device_get_match_data(&pdev->dev);
+	if (!od->cfg) {
+		dev_err(&pdev->dev, "Failed to match compatible string\n");
+		return -EINVAL;
+	}
 
-	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask_and_coherent(&pdev->dev, od->cfg->dma_mask);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set DMA mask\n");
 		return rc;
 	}
 
-	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
-	if (!od)
-		return -ENOMEM;
-
 	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	/* The set of channels can be split across multiple instances. */
+	chan_start = ((u32)(uintptr_t)base / BCM2835_DMA_CHAN_SIZE) & 0xf;
+	base -= BCM2835_DMA_CHAN(chan_start);
+	chan_count = resource_size(res) / BCM2835_DMA_CHAN_SIZE;
+	chan_end = min(chan_start + chan_count,
+		       BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED + 1);
+
 	od->base = base;
-	od->cfg = cfg_data;
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, od->ddev.cap_mask);
@@ -1233,7 +1606,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	}
 
 	/* get irqs for each channel that we support */
-	for (i = 0; i <= BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED; i++) {
+	for (i = chan_start; i < chan_end; i++) {
 		/* skip masked out channels */
 		if (!(chans_available & (1 << i))) {
 			irq[i] = -1;
@@ -1256,13 +1629,18 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		irq[i] = platform_get_irq(pdev, i < 11 ? i : 11);
 	}
 
+	chan_count = 0;
+
 	/* get irqs for each channel */
-	for (i = 0; i <= BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED; i++) {
+	for (i = chan_start; i < chan_end; i++) {
 		/* skip channels without irq */
 		if (irq[i] < 0)
 			continue;
 
 		/* check if there are other channels that also use this irq */
+		/* FIXME: This will fail if interrupts are shared across
+		 * instances
+		 */
 		irq_flags = 0;
 		for (j = 0; j <= BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED; j++)
 			if (i != j && irq[j] == irq[i]) {
@@ -1274,9 +1652,10 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		rc = bcm2835_dma_chan_init(od, i, irq[i], irq_flags);
 		if (rc)
 			goto err_no_dma;
+		chan_count++;
 	}
 
-	dev_dbg(&pdev->dev, "Initialized %i DMA channels\n", i);
+	dev_dbg(&pdev->dev, "Initialized %i DMA channels\n", chan_count);
 
 	/* Device-tree DMA controller registration */
 	rc = of_dma_controller_register(pdev->dev.of_node,
-- 
2.35.3


