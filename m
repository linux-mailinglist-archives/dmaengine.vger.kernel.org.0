Return-Path: <dmaengine+bounces-1365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8187A925
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFA51C22A55
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94434F615;
	Wed, 13 Mar 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CPdAylgc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4734BAA6
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338943; cv=none; b=E8TjMELk4g1W7CpwfIQq8h/7RkgxK2DBnOhXd9m/94X7DVGkYGpJgguh//qH8URN3E8HnjDYmyNdtcfV6gM9MYjNj4iW7bnt1elofJ0hVfA4e442fLGr+2twpfsfr0jsF9ci1+Us03ZQ+dRPThEQR7iHtjrpvoX+faCpbCXaBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338943; c=relaxed/simple;
	bh=cxjZSR8LRDYJ/W/QF37SUMynPidomrXSkI+hkRn0XJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfFP5MB21SH6XrgymHq4oXHv2hBOZgqItVDb2AQ1jNyNYzKF7MqueVi8zphc7Gtr3NEtDfhNe1aEBZNXgd8MrHnwT0D1rK8VBL6e0ApN2Xgv58fMLs46Na0f00UHaMKk/tto1xf6zwHU8KvapCHPHdkJnLW05/EzCPdgAGmtKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CPdAylgc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44f2d894b7so140309766b.1
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338940; x=1710943740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aA326qloufGfA/9FJeIrf9CjXOtqN0+M89y+6rWqCo=;
        b=CPdAylgchuHZicfW3zJDNEgvIO3Z4iq+PaefWzT5AfmAnMWOP70oHgXi8J2rSqC6Xy
         LOkp22dpQhEmSCs0Dl+CYVZWQ2NHMIHZbJT8TsH7pEFIWR2ixgTO2bk1eKe6fMeYu/2i
         TIi+sAocolWuiVLCVD86rvJKm+ZxWtyiGNq2oTyxIqH/yo2vMI4rY5GsFzTLtbkWIsfd
         fS72wQGVgv7Pbk2As6TEf2+XPZvElAtSggs+vxXc1oHFzG9azCwBLbOzorc7vd5g3aVh
         GaQiC98UCZ4wwXnjopvQaKJ/8jc9Wif3eUsXu35u7vROZzfQCsUDoQ1n6BLWs6Nv6hC9
         dqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338940; x=1710943740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aA326qloufGfA/9FJeIrf9CjXOtqN0+M89y+6rWqCo=;
        b=mbG4JH1flk7lirYu2/TDY7qLBeIdh+HDdF1WYohxouSGzpwOBglJozoAN7sKh5IboT
         bcYdvAHFNym2ZcHCkzPgco7qXz1cAn+9BJaqa/Wlcsyzf8z7RuOWewv8o1Sry+ZU9z27
         ooyHwsCZr3+hVDgJUJdfguBrh9f1U9pNZGVRaWBInkprVoISbaIIEKWehtVfvGfTnys4
         YroxGtw2+OMJWnDCTnhcQyVTy4fiSrOtHCWCDCEjuNnN2EC1qD10e2bd81NxRG7fHxm3
         0NUyye28FRN27U+NPKov5vr7nQYjD5vrVdm9+axUWWIwtsMVKtdxX5czh89XCKEcm1gz
         Fz7w==
X-Forwarded-Encrypted: i=1; AJvYcCV0iUPbalkMixNFhE4mXn0AwiAspozgtEXS+7vZ+QtBsY0QMT2/c/Tia6F4MijXTLV2Q3rAWw0zS6SmbryMaFEbXPwq/7LMxeik
X-Gm-Message-State: AOJu0YyEzYUJW8ibaUhP/mC7maN73E/rDnn5vi16w4NrA9e8UvzQJ+Gi
	6SEXXaWyxSGhYldQjTHI9alwD7rtx/CibRyU2Fnlpexzjm2W6TR7eCn4B/NWszg=
X-Google-Smtp-Source: AGHT+IEctktss/OIn1LKfmqGYndGaQjoPtQ3Zxp8D5LODaIB3jm5ZeIbTiROFzeL2/JTnhkfLCvRuQ==
X-Received: by 2002:a17:907:94c1:b0:a46:181f:c1c3 with SMTP id dn1-20020a17090794c100b00a46181fc1c3mr5229468ejc.70.1710338939952;
        Wed, 13 Mar 2024 07:08:59 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906a41700b00a440ec600e3sm4885228ejz.121.2024.03.13.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:08:59 -0700 (PDT)
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
Subject: [PATCH v2 09/15] dmaengine: bcm2835: make address increment platform independent
Date: Wed, 13 Mar 2024 15:08:34 +0100
Message-ID: <0bf87ad0dc970c34199fd6bc6dbd19b47d382066.1710226514.git.andrea.porta@suse.com>
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

Actually the criteria to increment source & destination address doesn't
based on platform specific bits. It's just the DMA transfer direction which
is translated into the info bits. So introduce two new helper functions
and get the rid of these platform specifics.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index b633c40142fe..6f896bb1a4fe 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -274,6 +274,24 @@ static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
 	return result;
 }
 
+static inline bool need_src_incr(enum dma_transfer_direction direction)
+{
+	return direction != DMA_DEV_TO_MEM;
+}
+
+static inline bool need_dst_incr(enum dma_transfer_direction direction)
+{
+	switch (direction) {
+	case DMA_MEM_TO_MEM:
+	case DMA_DEV_TO_MEM:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -355,10 +373,8 @@ static inline size_t bcm2835_dma_count_frames_for_sg(struct bcm2835_chan *c,
  * @cyclic:         it is a cyclic transfer
  * @info:           the default info bits to apply per controlblock
  * @frames:         number of controlblocks to allocate
- * @src:            the src address to assign (if the S_INC bit is set
- *                  in @info, then it gets incremented)
- * @dst:            the dst address to assign (if the D_INC bit is set
- *                  in @info, then it gets incremented)
+ * @src:            the src address to assign
+ * @dst:            the dst address to assign
  * @buf_len:        the full buffer length (may also be 0)
  * @period_len:     the period length when to apply @finalextrainfo
  *                  in addition to the last transfer
@@ -430,9 +446,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 			d->cb_list[frame - 1].cb->next = cb_entry->paddr;
 
 		/* update src and dst and length */
-		if (src && (info & BCM2835_DMA_S_INC))
+		if (src && need_src_incr(direction))
 			src += control_block->length;
-		if (dst && (info & BCM2835_DMA_D_INC))
+		if (dst && need_dst_incr(direction))
 			dst += control_block->length;
 
 		/* Length of total transfer */
-- 
2.35.3


