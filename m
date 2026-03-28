Return-Path: <dmaengine+bounces-9706-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPmsEkopyGnEhQUAu9opvQ
	(envelope-from <dmaengine+bounces-9706-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 20:17:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2334FC2B
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 20:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318143033AB9
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 19:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D491346E51;
	Sat, 28 Mar 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAj61LVA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768F1C8604
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725428; cv=none; b=dma46qBt8RlKOvUgLlmrqjnuio4B2EYOjxbeJ4vDMePG3i0ytHVDYvNLHmpDC7pplpYYlntrhwOJjZRzF5HjqfB34LiiFlu6eAuldxs1Jz15c+aRmAwdOp9nuzHSSkptw3Vxk0bLjGlHkAKCsT1mmry3XyZE00MyF2H5cg86Uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725428; c=relaxed/simple;
	bh=KA91jLkFZtNxj2oGP5XZfhlzSkR2p/GJzKrWyVJLYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re/kAeA0Nc8YdKJ6TzLrjxhOKY8oUrtwO3tYQSDoLoeKGLRXSUpdFNjpV7+D2f1cCkb9s6LzrjgxiCjy4hlfOVuddgkG5YqcQpoIGzWpZNCI8RzfY8YRgX0LT6FMX3bRBmJ6kiS8S4LIu43eravJlpAIjvp5QJ9C2eHtZtvMgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAj61LVA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82bae83318bso1495904b3a.2
        for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725424; x=1775330224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4t9PIf27Y9InCdf+CxT4mVnKUfDVoG1AnPBiKECu30=;
        b=WAj61LVA/iFQVdVhuuBgdRFhudViLCQLEEI9uunrIegMrdMm20v3sRp7pFGGzLq4o+
         EpdMJWgIh1T6M+Pn600pgsGJnu8bO6HsfRVbbhh9O0nds+PplfGYl3qKIoad8STNtlCe
         bd6wTaB7xMsVS0SH+cHWijmlxDoKrHM0TNz1SMCyHfmPCJeUgCnkTFoBqHSRvU0td00Q
         0wxNKIqbsmvR7rCcf0fAZcNZFCfjwDxZGRLpZ1RBoqk0zK1CnKMOhfn6MT/e+ev6h4IU
         /6oKGXDjU/Ah+FKBfitlGK2+R7LKCgzOuT3fp7nbdvnubiSM15lqXIbv/1ZqcZ8Wc3D/
         73qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725424; x=1775330224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4t9PIf27Y9InCdf+CxT4mVnKUfDVoG1AnPBiKECu30=;
        b=A5boYeic0OdQ603mnu7BcoY7RC2KD62mqQX7sXjMwNpIp9RfE8htQ3QWQGj/5V5WHZ
         ObM/x3L7t+gtog5H9+RbZzNWID1dEW4CH27J1gFij99cK+d9fXyd3O36s8Y48cHnTKcK
         TeBmTTerfNSY099DTKT2b1G8DQBBFCW8yFCJN83+krSayadpXKtp/c0Luqzz7S3G+JnZ
         krp390SFcoMth295wLjCkZQHD3d9myXNAw/E1Xx4azrKxeC3DIET2J/Obm0RbnyFXAJq
         E+23XFEopDk8kSX/Fz6sNQhk3V2WIPd41m5hVrMfTzgBT8mGuT3w80TEjxMBtw3a0IqY
         nxRw==
X-Gm-Message-State: AOJu0Yxkgx/WFTD8QAUPMnwLJIAECMSwmjs0d0qtfYtmQgEqwduRzvLv
	YdwT5b0BUof1PakzgoYLk7fsBpOmfj9vlO+KUfYQ/0q5DM8Ydg1+YAZZzuhSiQ==
X-Gm-Gg: ATEYQzye9dsM0rRxUXbJpV2zB/ALJYWlzD4d03UzhiOdcNQlnpiCcCE3sBILBgGJijZ
	bnMd1uh9x3IyiqNSXU1HisSOcKHUsur7GCaB5ZYLUhCX2h1ZZ6SoZ98fDuQzAH3/kZNQkm8TuYa
	80Wb5YUm/PJuYIzftJNaDuBOkdpK5lfoi0CDkl4DVhVxaAQW+ApdSCUx8udVDexn11r/HJK0+go
	UhEL4g2OdKLINrHExfREv81f28JJMOw+BjHLg3m2lOEvwgYaNmVHyrt1lLBKvmz26D+VrPe6luT
	MnycBfw1WIpaRfzKS5xAwR6wj8Qif1gpx6haPG51rBuoyr2AumUXznbJO2k615G88caPN88Cg+p
	vRPeRuIMpYEJVK+qgoBxTi/dhPmzcYFviNR/oN0oZqK7SaQC+orkuUZSGicOgjGUQg6tFPDGzox
	/V5zuO90JmECA6KRLSQXMPX49/vI7XWH6m7eoS4NOg4jKBucrliR5bYmA=
X-Received: by 2002:a05:6a00:bb0d:b0:82c:70a8:fae6 with SMTP id d2e1a72fcca58-82c95e71d96mr6682847b3a.22.1774725424350;
        Sat, 28 Mar 2026 12:17:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8464576sm2774950b3a.14.2026.03.28.12.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 12:17:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
Date: Sat, 28 Mar 2026 12:16:46 -0700
Message-ID: <20260328191646.312298-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9706-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7D2334FC2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct hsu_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: address review comments.
 drivers/dma/hsu/hsu.c | 45 ++++++++++++-------------------------------
 drivers/dma/hsu/hsu.h |  4 ++--
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index f62d60d7bc6b..78a2352ada8c 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -241,28 +241,10 @@ int hsu_dma_do_irq(struct hsu_dma_chip *chip, unsigned short nr, u32 status)
 }
 EXPORT_SYMBOL_GPL(hsu_dma_do_irq);

-static struct hsu_dma_desc *hsu_dma_alloc_desc(unsigned int nents)
-{
-	struct hsu_dma_desc *desc;
-
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
-	if (!desc)
-		return NULL;
-
-	desc->sg = kzalloc_objs(*desc->sg, nents, GFP_NOWAIT);
-	if (!desc->sg) {
-		kfree(desc);
-		return NULL;
-	}
-
-	return desc;
-}
-
 static void hsu_dma_desc_free(struct virt_dma_desc *vdesc)
 {
 	struct hsu_dma_desc *desc = to_hsu_dma_desc(vdesc);

-	kfree(desc->sg);
 	kfree(desc);
 }

@@ -276,10 +258,15 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;

-	desc = hsu_dma_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, sg, sg_len, GFP_NOWAIT);
 	if (!desc)
 		return NULL;

+	desc->nents = sg_len;
+	desc->direction = direction;
+	/* desc->active = 0 by kzalloc */
+	desc->status = DMA_IN_PROGRESS;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		desc->sg[i].addr = sg_dma_address(sg);
 		desc->sg[i].len = sg_dma_len(sg);
@@ -287,11 +274,6 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 		desc->length += sg_dma_len(sg);
 	}

-	desc->nents = sg_len;
-	desc->direction = direction;
-	/* desc->active = 0 by kzalloc */
-	desc->status = DMA_IN_PROGRESS;
-
 	return vchan_tx_prep(&hsuc->vchan, &desc->vdesc, flags);
 }

@@ -428,22 +410,19 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 {
 	struct hsu_dma *hsu;
 	void __iomem *addr = chip->regs + chip->offset;
+	unsigned short nr_channels;
 	unsigned short i;
 	int ret;

-	hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
+	/* Calculate nr_channels from the IO space length */
+	nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
+	hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
 	if (!hsu)
 		return -ENOMEM;

-	chip->hsu = hsu;
-
-	/* Calculate nr_channels from the IO space length */
-	hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
+	hsu->nr_channels = nr_channels;

-	hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
-				 sizeof(*hsu->chan), GFP_KERNEL);
-	if (!hsu->chan)
-		return -ENOMEM;
+	chip->hsu = hsu;

 	INIT_LIST_HEAD(&hsu->dma.channels);
 	for (i = 0; i < hsu->nr_channels; i++) {
diff --git a/drivers/dma/hsu/hsu.h b/drivers/dma/hsu/hsu.h
index 3bca577b98a1..f6ca1014bccf 100644
--- a/drivers/dma/hsu/hsu.h
+++ b/drivers/dma/hsu/hsu.h
@@ -71,11 +71,11 @@ struct hsu_dma_sg {
 struct hsu_dma_desc {
 	struct virt_dma_desc vdesc;
 	enum dma_transfer_direction direction;
-	struct hsu_dma_sg *sg;
 	unsigned int nents;
 	size_t length;
 	unsigned int active;
 	enum dma_status status;
+	struct hsu_dma_sg sg[] __counted_by(nents);
 };

 static inline struct hsu_dma_desc *to_hsu_dma_desc(struct virt_dma_desc *vdesc)
@@ -115,8 +115,8 @@ struct hsu_dma {
 	struct dma_device		dma;

 	/* channels */
-	struct hsu_dma_chan		*chan;
 	unsigned short			nr_channels;
+	struct hsu_dma_chan		chan[] __counted_by(nr_channels);
 };

 static inline struct hsu_dma *to_hsu_dma(struct dma_device *ddev)
--
2.53.0


