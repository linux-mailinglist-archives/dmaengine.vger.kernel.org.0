Return-Path: <dmaengine+bounces-9457-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPmmJmaiuGlygwEAu9opvQ
	(envelope-from <dmaengine+bounces-9457-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 01:37:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBC2A24C8
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 01:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32BE3023DC9
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 00:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264BD221275;
	Tue, 17 Mar 2026 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDHtL+Rf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8F186E58
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707871; cv=none; b=QoU0aLJ9pus1aDFgiKOd5Toi/KnaTUiyQugTfgzFL7Z8rqaPsfo6Y0yeywKfLm+US9HsJKzOGwJhzAQV4Uc8pVkHMWNoCXlgqEnSz1rcrBZj/GS+N1Z8rlLtzbPnCb6RzsOo3Nc0cnVL6cPUSXfbR92Idi2iETjnyrYxDdS/75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707871; c=relaxed/simple;
	bh=NBUx/E1eiB5B4UIv31tdu/QKTosgVuyh/723Ruw5qWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQsVYDDAvo4b/813RF6aV6BFyzHCi3Mhvv8dsPOAtlc1GMMb79STHt/B09rhqgUQbYvw1Pe1pxUuXWpt1sSDUsvxQgBQ5Qg3GriGFXo5a1EgDaHWa95KU35deo7W2TvrRml5H/jNgoanV1kP7D1oyKfGzgs2EfF+I+oMdYvFPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDHtL+Rf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70f91776fcso2035840a12.0
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707869; x=1774312669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YvdzXjDD8G0Iw759gOEg4e+kzUc/b7ysSStVnoVNAU=;
        b=XDHtL+RfLbPFsCozxR/f1EJ1p73BE/XW2SNZQsVgoLXWjKQ1j2C9EOlzxKHVHBDrKT
         ExYcq+Hgf6ieLECazVgyK8UUw/temaUE3l5RUZrFEC8jlqusD7cmXomztX6KQfntXmjE
         6idcRy2l9OsoZJrFtD6HuP5f0ldtlqQutQ8KVFsuPicVwu/iEUGLwSdAIHwxJ1q/rzef
         HcGMUBvxW57Z5b81PhXlHX5Dz5abtplXf3P4azPyp4zza1siwjj8sllJuJi6gj/wdPkr
         hhJKscZ/SXpC9XglsaIbYuZ6WyjBO/4p1kLesd05KvcosUyAbBVKib11w0U7ACtUODpz
         M69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707869; x=1774312669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YvdzXjDD8G0Iw759gOEg4e+kzUc/b7ysSStVnoVNAU=;
        b=AuHNTyjozi1hQWkRUTuvhiIGCZtfdWnB8cKn9itT0+3GzcbuRZpvgA4DCA49Jaiaeo
         3Z9xzUWen79Rq+LqikfLJ5LbN/YfTh1nYWndCEoioflhfXoNM4NpdwfNkF7H0FXTmTkr
         pi1yeZzUXDHbJeMzBOmQpkCmDFVSHo5xjXFBWeWHsp5JQ3XlNFAvIlD5rCTxau/pIWhQ
         oobRP95gPfsUdGTHyxPWHzF7LGJRZsaULVttiOJunS2IsvKHBQVWAb7mAWzBXcCj00W4
         a3vUsJkSnMjzATsTidwI7JlQhwOrf0dBXVxQgHXFcdGa0bOD4b81uyRf4hBJpJ1L92Un
         /lZA==
X-Gm-Message-State: AOJu0Yx5vpUV3+CXAVT4P6et1jgUyJniUq3HveXXJJ9r7c76u8540WYT
	7JFeUyjrXIBsZmf2cXrTfaFt9FWbFEj058yfvIMkEjfozSHBZ9cgvt/+S7r99vLy
X-Gm-Gg: ATEYQzw7BRz2akIeszkIv3CU9HTeSM06CIXgXYICTKtAm36bVzYlj+0UxPez+590gaT
	FTpvwlKnNL7/6mz3W3JuPAHbqE2VF4Ia86vcgoDRlji32tfdOHKw2j0acs/bqqx0b8nzgdfJg1C
	QeCHD4eDRgDPGRWFguk235XalVOxgxRFnbES2xvIAbWuSSOVEm3KbxG/gizM68T6CMZ/NjGRffd
	dbt/Hne7bUe+dHECtn7w6XHp2nou/vk8kMQ3pQA7hKfcTcvIbxL9LdlvAmMiRwhybBEtWxYHbsM
	8vSyagYuWlDeFDa8CyWE1j4Hv0e0Bd99WZ6sVMqAnx8Ktk3f8mJuuj3qUz8YFkTQvEqTOV9+mlV
	pRVlGIwEtwoc89nbrmNwb3cP7nlm/2TtYydPs6xJ2ixmIUm8zXxpX58yjbGsiiDtZ00xsDHZ875
	wnkHcKaVfNt/JKy+1xNvhO4xpOs0dLYa5kVO6RGRtKSPFa1U97awTTgIA=
X-Received: by 2002:a17:902:e841:b0:2ae:a45b:42f7 with SMTP id d9443c01a7336-2aecaaf604amr162102125ad.36.1773707869018;
        Mon, 16 Mar 2026 17:37:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ede79sm155391855ad.53.2026.03.16.17.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:37:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: idma64: use kzalloc_flex
Date: Mon, 16 Mar 2026 17:37:30 -0700
Message-ID: <20260317003730.72379-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9457-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CFBC2A24C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Remove idma64_alloc_desc. It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct idma64_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/idma64.c | 30 ++++--------------------------
 drivers/dma/idma64.h |  4 ++--
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 5fcd1befc92d..cf0399251ea9 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -192,23 +192,6 @@ static irqreturn_t idma64_irq(int irq, void *dev)
 
 /* ---------------------------------------------------------------------- */
 
-static struct idma64_desc *idma64_alloc_desc(unsigned int ndesc)
-{
-	struct idma64_desc *desc;
-
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
-	if (!desc)
-		return NULL;
-
-	desc->hw = kzalloc_objs(*desc->hw, ndesc, GFP_NOWAIT);
-	if (!desc->hw) {
-		kfree(desc);
-		return NULL;
-	}
-
-	return desc;
-}
-
 static void idma64_desc_free(struct idma64_chan *idma64c,
 		struct idma64_desc *desc)
 {
@@ -223,7 +206,6 @@ static void idma64_desc_free(struct idma64_chan *idma64c,
 		} while (i);
 	}
 
-	kfree(desc->hw);
 	kfree(desc);
 }
 
@@ -307,10 +289,12 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;
 
-	desc = idma64_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, hw, sg_len);
 	if (!desc)
 		return NULL;
 
+	desc->ndesc = sg_len;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct idma64_hw_desc *hw = &desc->hw[i];
 
@@ -326,7 +310,6 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 		hw->len = sg_dma_len(sg);
 	}
 
-	desc->ndesc = sg_len;
 	desc->direction = direction;
 	desc->status = DMA_IN_PROGRESS;
 
@@ -541,18 +524,13 @@ static int idma64_probe(struct idma64_chip *chip)
 	unsigned short i;
 	int ret;
 
-	idma64 = devm_kzalloc(chip->dev, sizeof(*idma64), GFP_KERNEL);
+	idma64 = devm_kzalloc(chip->dev, struct_size(idma64, chan, nr_chan), GFP_KERNEL);
 	if (!idma64)
 		return -ENOMEM;
 
 	idma64->regs = chip->regs;
 	chip->idma64 = idma64;
 
-	idma64->chan = devm_kcalloc(chip->dev, nr_chan, sizeof(*idma64->chan),
-				    GFP_KERNEL);
-	if (!idma64->chan)
-		return -ENOMEM;
-
 	idma64->all_chan_mask = (1 << nr_chan) - 1;
 
 	/* Turn off iDMA controller */
diff --git a/drivers/dma/idma64.h b/drivers/dma/idma64.h
index d013b54356aa..1a67dbb24db5 100644
--- a/drivers/dma/idma64.h
+++ b/drivers/dma/idma64.h
@@ -113,10 +113,10 @@ struct idma64_hw_desc {
 struct idma64_desc {
 	struct virt_dma_desc vdesc;
 	enum dma_transfer_direction direction;
-	struct idma64_hw_desc *hw;
 	unsigned int ndesc;
 	size_t length;
 	enum dma_status status;
+	struct idma64_hw_desc hw[] __counted_by(ndesc);
 };
 
 static inline struct idma64_desc *to_idma64_desc(struct virt_dma_desc *vdesc)
@@ -187,7 +187,7 @@ struct idma64 {
 
 	/* channels */
 	unsigned short all_chan_mask;
-	struct idma64_chan *chan;
+	struct idma64_chan chan[];
 };
 
 static inline struct idma64 *to_idma64(struct dma_device *ddev)
-- 
2.53.0


