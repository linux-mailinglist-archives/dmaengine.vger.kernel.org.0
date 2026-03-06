Return-Path: <dmaengine+bounces-9296-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OJ4Gj3MqmnUXAEAu9opvQ
	(envelope-from <dmaengine+bounces-9296-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:44:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09E220E32
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2838F30221FD
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F452701B8;
	Fri,  6 Mar 2026 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RVWOeo7C"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FAF26FA60
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800901; cv=none; b=Ji26lqEgCuMGSSCrZ/B3AFoZ+q3Fa0gPGV6GZsitEFLdH/tIWma2wrGZ2NFYjh6GiuXgkiPV0u/TF9N0BaH5ZLHTThMSPmCaOSrVoZmmQjkcRjcSktkI1tHmj8vNYfQl1/qTTVk5BtvXThb2zB13DhQ8PE8QLtGsbW2qwt1D5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800901; c=relaxed/simple;
	bh=RN3Xvj39V/yKMYYPWCiHYcUQb1LTVs8M5GbjU78OU3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsBMOsFvU8nqDLCgSwSVBZiuAhzLfSpgEXRJ9YnUmv2H7xQNrHzWSfOdDpBmWvyAS3nojNiI/SB679px+rJ463PahLhrMlKJUeJSeS9rl77fKzyJ4Aly9ZEdiSZTeeTGFfFM9ljEghcRbfhi5FA0VXecESNNfmM9bHDgHs3+aD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RVWOeo7C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48375f10628so60976215e9.1
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800898; x=1773405698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtXHbNPdEBg9KTwTT66W1+1GRh4EUiwex5QWGP93Nrc=;
        b=RVWOeo7CE058x4pBoPeHmEvS293hHs+QKwqnHkENZwvtidN7/KMhlnwHt+mGd/VQ5Q
         X5lbP7fQ/fGFjRfM0PifMT/Hz3kxtjMiNXwOoJMam4H9MIduxKGUkTOFdObcOt/AMKWV
         HsSN8lFae/NrXks2R0u+txhrnl6gVoFcJ4w0vjFP+sVubZ+ZgOb6ijVoF+c+Nz2bWtxo
         2AzAsaf1D7i6cBB0FzTYW7LCyR7LXIjZKQqYFyxNWLFZJI8G9qy20xEMo36VMQ/aDIMW
         WCe3qOaLmdEZj6nbzb3EZFo/8Nem5z6/mKWi06TzHE/Cg1n1+NYWydTVeoqIjSWgB9iR
         vRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800898; x=1773405698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JtXHbNPdEBg9KTwTT66W1+1GRh4EUiwex5QWGP93Nrc=;
        b=eLuP3ULYtTGTFnOfLulZSasRB5BBLvtTP/dAmuRqwi+Is29fKADAQ4Ezq7RbdCv7kq
         F8FhFkpiLFHTTZ5LgDfnptrNfRr16Mf44EEpuVMbd2L5UuOnDSbPQVYOZsQRraW4WJFV
         CbKw/dpHU/wO+So5X4BnkRLoYEB4SPETIAUdxxZxj8tlke+gddnS2j4FBZ+oiUJ5E7b+
         psAtW0dj5XP/vETSzYUfGFWBpFKxLnGGq9J20+TrIa2OBm6xVuKaLzeuAUqtDieMqECa
         z59WjbLMJqpY9ZtnBOBTMde6tdrB1aSgSDbSNuscpnrPdz4ebHwYeaX/qu0AAQOqMfzC
         trxA==
X-Forwarded-Encrypted: i=1; AJvYcCX+/8eg/ApapYAS9eVPRyUo/1HPP7XfoHllD5oJm331ssigEhdSL+Wscbhq7n49iEhBnwy2aX68LtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5FZvP9MNdZKjaXdFy344Uqv56zto1HHiYt69s5mXt5yaFY0l
	1OVJbQPzhO3WFSXkTC7Ky4JTf2XPxBd8vPwNgXGiAZxDHlkveubrvhhNRy9WZTqrZd51pFyr8F+
	4mzWZ
X-Gm-Gg: ATEYQzwJ5qhPiqN94G0u2DSQr+29KNE/4ohptLNbiohsrpgC+BkJ/nE68WawynVjdIP
	7E8L0uo6cxn7s/6XeXLORqCQAgcNqHRJnmyLj51hJEgqIg3E6mnxXuqVJcHDfbDoa+PakbwwopQ
	hyhGKc5+HQbOxAt5u0bLemWfvgosKYqwgMNejv+ZFiwpHtQ/QIFBEnqB3kASf9hei1IDESRvvLz
	TPmutuEXXypMi3Hy+jypnZZCap887OHZ2HOaXQ/r6JvDDw3xtbQA1Fhq5j2EHmsOsWeyLw9S1LR
	Rz0ElcWQTmezTlLBT7U9GSQhxQbKeHAR5GVG+FJ6fhPAwg0TL6CiHgEVO2klkJAIJGlrMBTEnUs
	mS2tZAesivWIYg0g0/6byWl63U3uEGxF8OHDsG2cteiFFl1e80QZ123J40BlbqEPYBmMb6icun8
	ZsM7tewddqLI0jFlgzqWfpaUHocyhVpKBiMo188YGxfFG0yh1nU281
X-Received: by 2002:a05:600c:a086:b0:483:75f1:54f with SMTP id 5b1f17b1804b1-48526982991mr30474875e9.31.1772800898064;
        Fri, 06 Mar 2026 04:41:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Fri,  6 Mar 2026 14:41:26 +0200
Message-ID: <20260306124133.2304687-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A09E220E32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9296-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v9:
- collected tags

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 57 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d84ca551b2bf..089e1ab29159 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -447,6 +448,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -502,18 +504,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	dev_dbg(dmac->dev, "%s channel: %d src=0x%pad dst=0x%pad len=%zu\n",
 		__func__, channel->index, &src, &dest, len);
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
+
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc->type = RZ_DMAC_DESC_MEMCPY;
+		desc->src = src;
+		desc->dest = dest;
+		desc->len = len;
+		desc->direction = DMA_MEM_TO_MEM;
 
-	desc->type = RZ_DMAC_DESC_MEMCPY;
-	desc->src = src;
-	desc->dest = dest;
-	desc->len = len;
-	desc->direction = DMA_MEM_TO_MEM;
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
 
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
@@ -529,27 +534,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	int dma_length = 0;
 	int i = 0;
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	for_each_sg(sgl, sg, sg_len, i) {
-		dma_length += sg_dma_len(sg);
-	}
+		for_each_sg(sgl, sg, sg_len, i)
+			dma_length += sg_dma_len(sg);
 
-	desc->type = RZ_DMAC_DESC_SLAVE_SG;
-	desc->sg = sgl;
-	desc->sgcount = sg_len;
-	desc->len = dma_length;
-	desc->direction = direction;
+		desc->type = RZ_DMAC_DESC_SLAVE_SG;
+		desc->sg = sgl;
+		desc->sgcount = sg_len;
+		desc->len = dma_length;
+		desc->direction = direction;
 
-	if (direction == DMA_DEV_TO_MEM)
-		desc->src = channel->src_per_address;
-	else
-		desc->dest = channel->dst_per_address;
+		if (direction == DMA_DEV_TO_MEM)
+			desc->src = channel->src_per_address;
+		else
+			desc->dest = channel->dst_per_address;
+
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
 
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
-- 
2.43.0


