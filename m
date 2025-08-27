Return-Path: <dmaengine+bounces-6228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABBB38680
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A62166A2A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F4F2248B0;
	Wed, 27 Aug 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4kIK+y/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054C1E0E08;
	Wed, 27 Aug 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308300; cv=none; b=c0+t15gAtDWcONOj/Q6AK4D5o1cKzNLlr6G43pOQoUIjdqHSOY1p5QZgpLD4IaGd8iHCa3XmcgyUZCvTo3CdKqTA7OXIbgCFu/Cn+gt5UFV8zjEG31JyUPA4EV5S0XhWHA3OcS3Xs6HwfQmNGtfL9X1yTfaZizp5pEkoW2bcyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308300; c=relaxed/simple;
	bh=vCjR9l/2ifl81kRjbUqgUc73Cc/Bb0CwIdVVHnUqmxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UnCTYZkv/dWwIZhs9MoXSfjJYnWM+UA3NawbUTOoYkgZzE43RdwHXu4fpWD5rOyrMVpgT1w0pA0qzIpudnQ0TuWt25MmOBQN/hXraVg1V45cO+cr50Ggj7kEtcJeRyn4ge8yCSnDK0424v4qzmBa8FUE6be4hcXVc86wmWn/XkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4kIK+y/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso42808105e9.3;
        Wed, 27 Aug 2025 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308297; x=1756913097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXx82M30xW2kCpWwnPxMPInFyBrFrSqnkyvpgRTA3A8=;
        b=j4kIK+y/V2pZjkHjsXH/sWFUKaKykJPIM8R3Nk9JlKqxAj7LhrK8vvUHrLmU6XJlHv
         SFwaVOtBGcCHWsgzlkaTHEPDFfLyrZ1NPYJ1Ih62dqRpCJ78rYxFwCqtMAnnW6fKDRnN
         pL+MkmHueJZTE19N4+0lLyxnfmM5CqBB+BTLLAu7owDNfh6BasFZoyXTMDwwAo96yp5+
         GX7CjNXCpLH+fNRUVfxOlEG0gIQ7zi9rcwGaL0uoqQH9LLcqwFQTDYimkVPB5/dJj/SC
         cjINz4qPu8fL3Q9oEPp/rgOf4SWKNUpHVwpSeceVmljQl1gIgsUiGVoVI9SOVDZh7LsZ
         2StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308297; x=1756913097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXx82M30xW2kCpWwnPxMPInFyBrFrSqnkyvpgRTA3A8=;
        b=Sdz8ypk4VpgM5ZVn9NwC5eh+N3qM4Ki4c3rnnazqDBFQcJfCLby6xOv+4wRZLbjTQg
         0HJKDiA3Tf4wg1npvGX+LE0yYQ2WUY1pC0dk2Vah5YfXmlhRffRvLhI0n0y9Fmpm+vrA
         zK3e1gpEt+0bZZZKEmiKYpCU2PD51W/ZyZNvIqMleaUke4xFoe2UC1liMRoRK0BnQ6C1
         zGpFVum6lLCHMTYsYruo6uz4rCBiXzWYtmlREXVoo1Pq0ZF5BiPz63/Vp5iyaOI2KAVI
         rz363a73jAJIlVXDHh7YNecmbGt/tWipl43yqIvdfBjbLK3VwtzRL3iqNW9gaNvVKKAf
         xJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKZqupmlMEqLeIUpLLXO3db9GlirjJz48ugj3rGTypcqp9AOlrbBYarXZPZZtp/Pemsxy9ps/XEqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3Pad8qJPWKiz5Bythii+4dts0KRa9Ve6ccGU4SHaLDswqBUx
	ORdx5EUDASh3gizdOCc/X8q2DFjcBo6czpLCvWpAFAE42VWXXaa/nyuH
X-Gm-Gg: ASbGnct2AXkLBUKcZVsd4rfzBr8DtXw+TSb/S69S2LnmR/zPcENrsIwp0Y8O4m6ZcCg
	hj7t1lXuwiVM0/FVjUUiLsY5e6vVX+s4UCwJW+fIniEZvJuI4zbbzomANmcCvW0tmV5JJR9OVMW
	16x8xjv2RS3Y97PPJkiMzHQW1aLt+SGy/XOrU43HG2KOvjToZScw29Aq3X1nRUx7ZrCVkUTACdS
	kQX0ifFs6au6fO/O8PkNnImOFTJj1M++PQNR5DDcED+knDUCh72DnGd2AQoUdNoxxD/ymENAw+W
	6V7lZ944P4U4/lL4E6z1SeEEfqJhunyDzEacQP+jCqLbprSFsivbTq6JwS0zOgkt+Gm1R591MEv
	c6FmcAHYjo1uA5vs77R+TL0c8r5HpJDJTJNENyx5r0M8JktDTgWGl6UBbmx1zqXzFo3Hp7AVUW3
	1KBI9VgxFbyfc=
X-Google-Smtp-Source: AGHT+IFXWUPgHGrP+uNLPGa3/2CQapMwXzCmzoM4UyvpiUxIHyeEW55l8dCb+VdFT5SjVG5ypuvzJQ==
X-Received: by 2002:a05:6000:2802:b0:3cc:929c:6595 with SMTP id ffacd0b85a97d-3cc929c6b17mr1653393f8f.15.1756308296365;
        Wed, 27 Aug 2025 08:24:56 -0700 (PDT)
Received: from localhost.localdomain (mob-109-118-41-117.net.vodafone.it. [109.118.41.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc37183670sm4907199f8f.58.2025.08.27.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:24:55 -0700 (PDT)
From: Thomas Andreatta <thomasandreatta2000@gmail.com>
X-Google-Original-From: Thomas Andreatta <thomas.andreatta2000@gmail.com>
To: vkoul@kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Thomas Andreatta <thomas.andreatta2000@gmail.com>
Subject: [PATCH] drivers: dma: sh: setup_xref error handling
Date: Wed, 27 Aug 2025 17:24:43 +0200
Message-Id: <20250827152442.90962-1-thomas.andreatta2000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the type of setup_xref from void to int and handles
errors since the function can fail.

`setup_xref` now returns the (eventual) error from
`dmae_set_dmars`|`dmae_set_chcr`, while `shdma_tx_submit` handles the
result, removing the chunks from the queue and marking PM as idle in
case of an error.

First time hittin DMA, if something's off every feedback is welcome.

Signed-off-by: Thomas Andreatta <thomas.andreatta2000@gmail.com>
---
 drivers/dma/sh/shdma-base.c | 25 +++++++++++++++++++------
 drivers/dma/sh/shdmac.c     | 17 +++++++++++++----
 include/linux/shdma-base.h  |  2 +-
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 6b4fce453c85..834741adadaa 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -129,12 +129,25 @@ static dma_cookie_t shdma_tx_submit(struct dma_async_tx_descriptor *tx)
 			const struct shdma_ops *ops = sdev->ops;
 			dev_dbg(schan->dev, "Bring up channel %d\n",
 				schan->id);
-			/*
-			 * TODO: .xfer_setup() might fail on some platforms.
-			 * Make it int then, on error remove chunks from the
-			 * queue again
-			 */
-			ops->setup_xfer(schan, schan->slave_id);
+
+			ret = ops->setup_xfer(schan, schan->slave_id);
+			if (ret < 0) {
+				dev_err(schan->dev, "setup_xfer failed: %d\n", ret);
+
+				/* Remove chunks from the queue and mark them as idle */
+				list_for_each_entry_safe(chunk, c, &schan->ld_queue, node) {
+					if (chunk->cookie == cookie) {
+						chunk->mark = DESC_IDLE;
+						list_move(&chunk->node, &schan->ld_free);
+					}
+				}
+
+				schan->pm_state = SHDMA_PM_ESTABLISHED;
+				ret = pm_runtime_put(schan->dev);
+
+				spin_unlock_irq(&schan->chan_lock);
+				return ret;
+			}
 
 			if (schan->pm_state == SHDMA_PM_PENDING)
 				shdma_chan_xfer_ld_queue(schan);
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 093e449e19ee..603e15102e45 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -300,21 +300,30 @@ static bool sh_dmae_channel_busy(struct shdma_chan *schan)
 	return dmae_is_busy(sh_chan);
 }
 
-static void sh_dmae_setup_xfer(struct shdma_chan *schan,
-			       int slave_id)
+static int sh_dmae_setup_xfer(struct shdma_chan *schan, int slave_id)
 {
 	struct sh_dmae_chan *sh_chan = container_of(schan, struct sh_dmae_chan,
 						    shdma_chan);
 
+	int ret = 0;
 	if (slave_id >= 0) {
 		const struct sh_dmae_slave_config *cfg =
 			sh_chan->config;
 
-		dmae_set_dmars(sh_chan, cfg->mid_rid);
-		dmae_set_chcr(sh_chan, cfg->chcr);
+		ret = dmae_set_dmars(sh_chan, cfg->mid_rid);
+		if (ret < 0)
+			goto END;
+
+		ret = dmae_set_chcr(sh_chan, cfg->chcr);
+		if (ret < 0)
+			goto END;
+
 	} else {
 		dmae_init(sh_chan);
 	}
+
+END:
+	return ret;
 }
 
 /*
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 6dfd05ef5c2d..03ba4dab2ef7 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -96,7 +96,7 @@ struct shdma_ops {
 	int (*desc_setup)(struct shdma_chan *, struct shdma_desc *,
 			  dma_addr_t, dma_addr_t, size_t *);
 	int (*set_slave)(struct shdma_chan *, int, dma_addr_t, bool);
-	void (*setup_xfer)(struct shdma_chan *, int);
+	int (*setup_xfer)(struct shdma_chan *, int);
 	void (*start_xfer)(struct shdma_chan *, struct shdma_desc *);
 	struct shdma_desc *(*embedded_desc)(void *, int);
 	bool (*chan_irq)(struct shdma_chan *, int);
-- 
2.34.1


