Return-Path: <dmaengine+bounces-12358-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pY8fFPIOVGoMhgMAu9opvQ
	(envelope-from <dmaengine+bounces-12358-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:02:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A544A74617B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:02:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YXXxbKdo;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12358-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12358-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2195F3034A81
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6637BE74;
	Sun, 12 Jul 2026 22:00:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428137C0F8
	for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 22:00:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893646; cv=none; b=FHAhZwuQJA4jr5ZQiGeWPyjR0jJsNNsTPPglzsBIVEZy8UsIK1sl6PABMkVT1TefQWZpkipANo1Fgz7RMQ3lyGtlKNfP7CmXrWt3pLxKERkrbfHQNytLyZ9LO0F+WyU/aMzltBmMbMQuXu/+PXMOMtq3moq0gwkX4UwDizMjxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893646; c=relaxed/simple;
	bh=Gx3dxzU1ikPSsJPBUGCijZOLWZz13mRAOiy71j67q18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fflg0MATKzEr8gDyq9ZmeKA8fZXrYgFN/GRb5Pv2M9aSRw9TqqczOREy/3Oegntc7Dsfue2/D9mbl0IrXk+HmkLuZajGbBlllOxd0F7gx7vs6kjb/UQBWWhCT1TSH0IBBVtmZJ+8dbQ0mK0feiGNNBHTAxuxpwfTV2rx7XU6SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXXxbKdo; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c89636920a3so1281475a12.1
        for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783893644; x=1784498444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SvXQuEtFeagFiyEBtM6YkLZtwS+Bnd8V2JTSeJNcHAg=;
        b=YXXxbKdo0RqwQllr3uOKdgmBGyT2A201J+hNu244zf8Z1JihKGvA1YZ+UWzMpYTe8s
         gDetAsNQbrWRx/2i9K3Bf8Omxylz65GizhNJy3YlmkzMO53tGEm3HQqee1y7mKibnl9c
         T49JA+hWiu6EJw/HRk/iUvw3mNgXGy7h+U/ecdHKEb2p1F/ScEW+nlnc2SMXrIYVfrYM
         r4jKBaTaW8BMYetW77vGQAo1hs5HNd8lo7uYL3MjJoKvKBhX+4fd3aOnxYP98+9okNun
         h44QJZ5PmPDNqApP98qD62rXcYHRuZTcVJL376EQ5+6Khr+hSRmnYAXZNlGGEi039VXS
         ZfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893644; x=1784498444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SvXQuEtFeagFiyEBtM6YkLZtwS+Bnd8V2JTSeJNcHAg=;
        b=dP4xeNz2jwB7I4EWdBgyOWeLM+dkb/rfSEdAo7h1aWsDEqMyPcYfdqatXXglRbYi3X
         4mL5LC/JSjumem7N8xNXIO6WXrdiMnm3JbxPoP29ItnnxEE9Kif+JmpFczp5z1kFTYaL
         FWvzxWa/iqiTstzXwKlJAJBduaKJaljkeNq4IV76KId1SbDdivZg23nUuX6jediYxfwi
         SneBGeQ13grh7wW5KyUVqCcE+DGlv3HdqnVI7qGn2P1PmjTz+95DJRBjJtxNwyeW4sls
         5oxX54EzA6faIONJQDvzI4XU8pTUroEgaAKMlw7Yng7YE5H5O/wTS8MaRZWaWogPNKWz
         Q3aA==
X-Gm-Message-State: AOJu0YwQTFkw9MKqWj+wRM1b9ggG2ht5nS4EvbIbLDT2vXutirW1F6Rj
	j3JsqGjKokyooIJvODxlnXcEpb+8FsRbmt52amCmFJnARcrvXAmjcrKazY1KXQ==
X-Gm-Gg: AfdE7cm+X5oIfrfOw4DM/Ctjbdf9HSPPZiMAMqJIwVpvPWlL28lNImxDGvML3ZvAFlW
	UwD5p+YY19xwvAsh5FG/XOp79MLtasfsDZUosK7d7oA0lPkhWlVsk+dl2SkLFiKcCm6fHiIgJiL
	Edg/bP7SUZXdUmWCvLDeo0qb/+Joy7mns4/VecyY5Okq1702Yc8EHt/RLWAQ0TZbgdwNHHEirIc
	cEumMTHizYrUbzMg0Zhbd2aluvr4m3IFImhlR0cuSX629McNAZVY06X6ksCWFpb5O7WrvBe8DV1
	H1+ZmSchXqzzA4cYaG7WAm2uEmr1kch8LjpznQcbIDF0bsaQK/+SvGDCzR/SjQkJkDormJSA74X
	5kRMtN7KvcLgOV4PkoOh5w4GfGJHLHo6Ms5iedVDEu8FaihuNi0zAJu2kmiQIRjBFEHhVUZEZar
	xaNvVEwFIWsto8OBTEwrskfftDV9QDTgD7ZoGeUZaYWhxfIwyL1sVIp+59XlXuFb+j6Rt8/Q3T7
	6+GSDyzZ8mEG3cbTTiVYjY29CY+Alg6Ux494o943sbCanS4m745DRqMxWWpwiPSXg==
X-Received: by 2002:a05:6a21:4cca:b0:3b4:8a40:85ed with SMTP id adf61e73a8af0-3c11077686bmr6798012637.7.1783893644125;
        Sun, 12 Jul 2026 15:00:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm14856305eec.13.2026.07.12.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:00:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 2/2] dmaengine: idma64: use sg_nents_for_dma to respect hardware descriptor length limit
Date: Sun, 12 Jul 2026 15:00:39 -0700
Message-ID: <20260712220039.924958-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712220039.924958-1-rosenp@gmail.com>
References: <20260712220039.924958-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-12358-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A544A74617B

The iDMA 64-bit hardware has a 17-bit block transfer size field in the
CTL_HI register (IDMA64C_CTLH_BLOCK_TS_MASK = 0x1ffff). When a
scatterlist entry exceeds this limit, the driver would silently
truncate the length, transferring fewer bytes than intended.

Use sg_nents_for_dma() to compute the number of hardware descriptors
needed after splitting large SG entries into chunks that fit within
the hardware limit. Split the loop to iterate over each chunk.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/idma64.c | 44 ++++++++++++++++++++++++++++++--------------
 drivers/dma/idma64.h |  3 ++-
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index d914f50ec309..6954ec2cdeae 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -287,27 +287,43 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 	struct idma64_chan *idma64c = to_idma64_chan(chan);
 	struct idma64_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i;
+	unsigned int i, nents;
+	int ndesc;
 
-	desc = kzalloc_flex(*desc, hw, sg_len, GFP_NOWAIT);
+	ndesc = sg_nents_for_dma(sgl, sg_len, IDMA64C_CTLH_BLOCK_TS_MASK);
+	if (ndesc <= 0)
+		return NULL;
+
+	desc = kzalloc_flex(*desc, hw, ndesc, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->ndesc = sg_len;
+	desc->ndesc = ndesc;
 
+	nents = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct idma64_hw_desc *hw = &desc->hw[i];
-
-		/* Allocate DMA capable memory for hardware descriptor */
-		hw->lli = dma_pool_alloc(idma64c->pool, GFP_NOWAIT, &hw->llp);
-		if (!hw->lli) {
-			desc->ndesc = i;
-			idma64_desc_free(idma64c, desc);
-			return NULL;
+		dma_addr_t addr = sg_dma_address(sg);
+		unsigned int len = sg_dma_len(sg);
+
+		while (len) {
+			struct idma64_hw_desc *hwdesc = &desc->hw[nents++];
+			unsigned int chunk = min(len, IDMA64C_CTLH_BLOCK_TS_MASK);
+
+			hwdesc->lli = dma_pool_alloc(idma64c->pool, GFP_NOWAIT,
+						     &hwdesc->llp);
+			if (!hwdesc->lli) {
+				/* nents was already incremented by ++ above */
+				desc->ndesc = nents - 1;
+				idma64_desc_free(idma64c, desc);
+				return NULL;
+			}
+
+			hwdesc->phys = addr;
+			hwdesc->len = chunk;
+
+			addr += chunk;
+			len -= chunk;
 		}
-
-		hw->phys = sg_dma_address(sg);
-		hw->len = sg_dma_len(sg);
 	}
 
 	desc->direction = direction;
diff --git a/drivers/dma/idma64.h b/drivers/dma/idma64.h
index 1a67dbb24db5..297a91594b31 100644
--- a/drivers/dma/idma64.h
+++ b/drivers/dma/idma64.h
@@ -8,6 +8,7 @@
 #ifndef __DMA_IDMA64_H__
 #define __DMA_IDMA64_H__
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
@@ -51,7 +52,7 @@
 #define IDMA64C_CTLL_LLP_S_EN		(1 << 28)	/* src block chain */
 
 /* Bitfields in CTL_HI */
-#define IDMA64C_CTLH_BLOCK_TS_MASK	((1 << 17) - 1)
+#define IDMA64C_CTLH_BLOCK_TS_MASK	GENMASK_U32(16, 0)
 #define IDMA64C_CTLH_BLOCK_TS(x)	((x) & IDMA64C_CTLH_BLOCK_TS_MASK)
 #define IDMA64C_CTLH_DONE		(1 << 17)
 
-- 
2.55.0


