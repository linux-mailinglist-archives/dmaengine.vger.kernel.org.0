Return-Path: <dmaengine+bounces-10206-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMZ8O7wO+GmTpQIAu9opvQ
	(envelope-from <dmaengine+bounces-10206-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 05:13:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD44B82B9
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 05:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935DF300B608
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2026 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38BF16CD33;
	Mon,  4 May 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5yUS0/1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6AE17C203
	for <dmaengine@vger.kernel.org>; Mon,  4 May 2026 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777864352; cv=none; b=saCeMcsQxG6beQmYSe3l0fw7oIdnPvYJsemexHse6x6i1eRcc+Zlz5/vhRVQRP32Pxdn5WizPoXLwyFeGFB4p9nUFAahEm5p8T9lG6E6P7ff+NlnbxrM5ZCarF7KOwhFuPACI9KwN2dero0tUj8zsgDg13Bd9NrVHdN4s+3kXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777864352; c=relaxed/simple;
	bh=PzBoLGt+HSzA8hrxic0tw2YDmkzFCVSkTbJLdJVcrIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTriYMcSTPiEhVOsn8Wb/KS44W0tTRiNKNyYXMNtcRs9zBpplEDPP4MeZF8m0LOied7DPXPsLslpZTbDHOLxmnkn8l6QTjToCy95VyIaQw1CDxAZ7ao4c3PNtIwsOOEbfJUO7uubPdMeRYPxX5Ucdg98/J1dHkgmb80saFJgz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5yUS0/1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e594413c2so22637151cf.0
        for <dmaengine@vger.kernel.org>; Sun, 03 May 2026 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777864350; x=1778469150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix64vFLTMg1zfqNmmDku6bMK7XtzXkWd5VZgOslz+04=;
        b=i5yUS0/1h49THU8NwjqNdiORYWbIHKP1wPBLTadgua3Y5MitB1JeJ5yCnlF/4RyI58
         czlECQ+ZCSPmjuMUx/q1IFvZTd5eQTF1r0Jjk4dlxCMOkh3/QL9UDWnfUs7cpf9qRX33
         hsHRlOYkFkgElxDnPi7lqRhWRomsWfuHV45F/ZF29RloZsaWLf0X9cqf8fk3o/DtyJ70
         GAj+ZntA5I2QZTDHkRVhOWoRFUhmX8k40T14HoM3ZXtsRPoJJ2Eg0uqmZ+J1hlOJUrLl
         EJMJP9xvSkGqa7JT6Sq2RquxOAeziL3bqbsuxCj2ca8uM7QRKWu0zxLeHjE5Cme2YWtw
         lu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777864350; x=1778469150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix64vFLTMg1zfqNmmDku6bMK7XtzXkWd5VZgOslz+04=;
        b=RJEUPrr3iEDSyb7Ug96NOEJ+Ojyn4XzBBfdZFUjrRlY/f0PU6bos2Uxnkh0YcXPiHG
         /2ch1nhQsWTGXEhw5jYZsvhyvqu0Ckf9fb97TBjrNa8SJUxtgiQv2xomTa74yHpwmdkR
         9+zAe0sT8ONMe9paQxSDwpHYxePuSkPqaeiF3ZsaW+D4Ogj0zVrrCZqTF9Amv5k/7NbD
         cMolY0FHcrfcnIxBuezY/4RAa/ots0BUU3Rsyenw1FR8rOledN/EuSS86RFNnU0u12eI
         6Gkp7xUO369fs2E4Luewr5P8xlgBS0x8hbc1q0jeagZkuB+iBr45U4rw5cSllV797hml
         WXhQ==
X-Gm-Message-State: AOJu0YxmZJu0/JABPN4eDAgCo0594aaUSO+uiPNyCDPLI0OiyRRhv77a
	1YZKpb2/BiwIfpiyCx/AUXz1j7OXCWf24fIGSTn7xVum2JiQPBAgXo7SG6eiNQ==
X-Gm-Gg: AeBDieuMJnnScqjIR08tgOOW7rwXQEJtsWk9jP0/gt5H4U8wSbGEJnZDWwJKJrTDt+I
	149JpY9y8POiUW5d12bMnIAe6/ZJhbDoOBvc9yukRAo3xvLJCvHyCQmjwdM0Gpx4GdkSjE291sO
	91/pAmArsuhmRrEDFWsBC4W0XcLFW9TVyU+Rd9ykCI2WPBi6/YTS/EAhwHsIhi0oZ/tmm4EGOKw
	see0mUMwWtl4Ci2j40lwKHqIGydF/LQBVGBeps+NMIIbOpfIPH6RiPKtEUft2QuxESlGZqSF5e7
	XDpD1OIZ8rA9jjpxERWouSgwPFxJ/KpxsLPDWgDrH7CHO+bZRXQ7ttbauwe/RKPXclhkMnR827V
	YXt0dTzb3pOVXzNZx5U+NvjwedzwTeaQFYj0uG2OEFaaufwi10SY3ZrDT3IDV9FhUAlD/wzJ3+r
	XYFes041K9C7tc/LjZGEWHyEZ1XKIr1ZRCMQkXOIu1DiOf2mf13ibvqLkcFxw2QMfNR9nzjm3Zk
	nkTfMKSLnQzF8+isIcIlFg7kH/Y4VYZJQP1f8tiGhlNJw==
X-Received: by 2002:a05:622a:15cf:b0:50f:c9a2:1643 with SMTP id d75a77b69052e-5104b484d42mr108220031cf.11.1777864349633;
        Sun, 03 May 2026 20:12:29 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040ba8acdsm86540591cf.31.2026.05.03.20.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 20:12:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:TEXAS INSTRUMENTS' SYSTEM CONTROL INTERFACE (TI...),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] firmware: ti_sci: simplify resource allocation
Date: Sun,  3 May 2026 20:12:09 -0700
Message-ID: <20260504031209.618949-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59BD44B82B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10206-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use a flexible array member to combine allocations.

Add __counted_by for extra runtime analysis.

Fixup k3-udma as well since ti_sci_resource is used there as well and
needs fixing up to use kzalloc_flex.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add k3-udma fixes.
 drivers/dma/ti/k3-udma.c               | 180 +++++++++++++------------
 drivers/firmware/ti_sci.c              |   7 +-
 include/linux/soc/ti/ti_sci_protocol.h |   2 +-
 3 files changed, 98 insertions(+), 91 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c964ebfcf3b6..ad6c50d0b844 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4584,9 +4584,10 @@ static int udma_setup_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
-	struct ti_sci_resource *rm_res, irq_res;
+	struct ti_sci_resource *rm_res, *irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	u32 cap3;
+	u16 sets;
 
 	/* Set up the throughput level start indexes */
 	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
@@ -4664,64 +4665,67 @@ static int udma_setup_resources(struct udma_dev *ud)
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 	if (IS_ERR(rm_res)) {
 		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
-		irq_res.sets = 1;
+		sets = 1;
 	} else {
 		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->tchan_map,
 						  &rm_res->desc[i], "tchan");
-		irq_res.sets = rm_res->sets;
+		sets = rm_res->sets;
 	}
 
 	/* rchan and matching default flow ranges */
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 	if (IS_ERR(rm_res)) {
 		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
-		irq_res.sets++;
+		sets++;
 	} else {
 		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->rchan_map,
 						  &rm_res->desc[i], "rchan");
-		irq_res.sets += rm_res->sets;
+		sets += rm_res->sets;
 	}
 
-	irq_res.desc = kzalloc_objs(*irq_res.desc, irq_res.sets);
-	if (!irq_res.desc)
+	irq_res = kzalloc_flex(*irq_res, desc, sets);
+	if (!irq_res)
 		return -ENOMEM;
+
+	irq_res->sets = sets;
+
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[0].start = 0;
-		irq_res.desc[0].num = ud->tchan_cnt;
+		irq_res->desc[0].start = 0;
+		irq_res->desc[0].num = ud->tchan_cnt;
 		i = 1;
 	} else {
 		for (i = 0; i < rm_res->sets; i++) {
-			irq_res.desc[i].start = rm_res->desc[i].start;
-			irq_res.desc[i].num = rm_res->desc[i].num;
-			irq_res.desc[i].start_sec = rm_res->desc[i].start_sec;
-			irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+			irq_res->desc[i].start = rm_res->desc[i].start;
+			irq_res->desc[i].num = rm_res->desc[i].num;
+			irq_res->desc[i].start_sec = rm_res->desc[i].start_sec;
+			irq_res->desc[i].num_sec = rm_res->desc[i].num_sec;
 		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[i].start = 0;
-		irq_res.desc[i].num = ud->rchan_cnt;
+		irq_res->desc[i].start = 0;
+		irq_res->desc[i].num = ud->rchan_cnt;
 	} else {
 		for (j = 0; j < rm_res->sets; j++, i++) {
 			if (rm_res->desc[j].num) {
-				irq_res.desc[i].start = rm_res->desc[j].start +
+				irq_res->desc[i].start = rm_res->desc[j].start +
 						ud->soc_data->oes.udma_rchan;
-				irq_res.desc[i].num = rm_res->desc[j].num;
+				irq_res->desc[i].num = rm_res->desc[j].num;
 			}
 			if (rm_res->desc[j].num_sec) {
-				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+				irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 						ud->soc_data->oes.udma_rchan;
-				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+				irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
 			}
 		}
 	}
-	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-	kfree(irq_res.desc);
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, irq_res);
+	kfree(irq_res);
 	if (ret) {
 		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
 		return ret;
@@ -4746,9 +4750,10 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
-	struct ti_sci_resource *rm_res, irq_res;
+	struct ti_sci_resource *rm_res, *irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+	u16 sets;
 	u32 cap;
 
 	/* Set up the throughput level start indexes */
@@ -4828,21 +4833,21 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 						    (char *)range_names[i]);
 	}
 
-	irq_res.sets = 0;
+	sets = 0;
 
 	/* bchan ranges */
 	if (ud->bchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->bchan_map, ud->bchan_cnt);
-			irq_res.sets++;
+			sets++;
 		} else {
 			bitmap_fill(ud->bchan_map, ud->bchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->bchan_map,
 							  &rm_res->desc[i],
 							  "bchan");
-			irq_res.sets += rm_res->sets;
+			sets += rm_res->sets;
 		}
 	}
 
@@ -4851,14 +4856,14 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->tchan_map, ud->tchan_cnt);
-			irq_res.sets += 2;
+			sets += 2;
 		} else {
 			bitmap_fill(ud->tchan_map, ud->tchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->tchan_map,
 							  &rm_res->desc[i],
 							  "tchan");
-			irq_res.sets += rm_res->sets * 2;
+			sets += rm_res->sets * 2;
 		}
 	}
 
@@ -4867,36 +4872,39 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 		if (IS_ERR(rm_res)) {
 			bitmap_zero(ud->rchan_map, ud->rchan_cnt);
-			irq_res.sets += 2;
+			sets += 2;
 		} else {
 			bitmap_fill(ud->rchan_map, ud->rchan_cnt);
 			for (i = 0; i < rm_res->sets; i++)
 				udma_mark_resource_ranges(ud, ud->rchan_map,
 							  &rm_res->desc[i],
 							  "rchan");
-			irq_res.sets += rm_res->sets * 2;
+			sets += rm_res->sets * 2;
 		}
 	}
 
-	irq_res.desc = kzalloc_objs(*irq_res.desc, irq_res.sets);
-	if (!irq_res.desc)
+	irq_res = kzalloc_flex(*irq_res, desc, sets);
+	if (!irq_res)
 		return -ENOMEM;
+
+	irq_res->sets = sets;
+
 	if (ud->bchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
 		if (IS_ERR(rm_res)) {
-			irq_res.desc[0].start = oes->bcdma_bchan_ring;
-			irq_res.desc[0].num = ud->bchan_cnt;
+			irq_res->desc[0].start = oes->bcdma_bchan_ring;
+			irq_res->desc[0].num = ud->bchan_cnt;
 			i = 1;
 		} else {
 			for (i = 0; i < rm_res->sets; i++) {
-				irq_res.desc[i].start = rm_res->desc[i].start +
+				irq_res->desc[i].start = rm_res->desc[i].start +
 							oes->bcdma_bchan_ring;
-				irq_res.desc[i].num = rm_res->desc[i].num;
+				irq_res->desc[i].num = rm_res->desc[i].num;
 
 				if (rm_res->desc[i].num_sec) {
-					irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+					irq_res->desc[i].start_sec = rm_res->desc[i].start_sec +
 									oes->bcdma_bchan_ring;
-					irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+					irq_res->desc[i].num_sec = rm_res->desc[i].num_sec;
 				}
 			}
 		}
@@ -4907,28 +4915,28 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	if (ud->tchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 		if (IS_ERR(rm_res)) {
-			irq_res.desc[i].start = oes->bcdma_tchan_data;
-			irq_res.desc[i].num = ud->tchan_cnt;
-			irq_res.desc[i + 1].start = oes->bcdma_tchan_ring;
-			irq_res.desc[i + 1].num = ud->tchan_cnt;
+			irq_res->desc[i].start = oes->bcdma_tchan_data;
+			irq_res->desc[i].num = ud->tchan_cnt;
+			irq_res->desc[i + 1].start = oes->bcdma_tchan_ring;
+			irq_res->desc[i + 1].num = ud->tchan_cnt;
 			i += 2;
 		} else {
 			for (j = 0; j < rm_res->sets; j++, i += 2) {
-				irq_res.desc[i].start = rm_res->desc[j].start +
+				irq_res->desc[i].start = rm_res->desc[j].start +
 							oes->bcdma_tchan_data;
-				irq_res.desc[i].num = rm_res->desc[j].num;
+				irq_res->desc[i].num = rm_res->desc[j].num;
 
-				irq_res.desc[i + 1].start = rm_res->desc[j].start +
+				irq_res->desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_tchan_ring;
-				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+				irq_res->desc[i + 1].num = rm_res->desc[j].num;
 
 				if (rm_res->desc[j].num_sec) {
-					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_tchan_data;
-					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
-					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_tchan_ring;
-					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].num_sec = rm_res->desc[j].num_sec;
 				}
 			}
 		}
@@ -4936,35 +4944,35 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	if (ud->rchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 		if (IS_ERR(rm_res)) {
-			irq_res.desc[i].start = oes->bcdma_rchan_data;
-			irq_res.desc[i].num = ud->rchan_cnt;
-			irq_res.desc[i + 1].start = oes->bcdma_rchan_ring;
-			irq_res.desc[i + 1].num = ud->rchan_cnt;
+			irq_res->desc[i].start = oes->bcdma_rchan_data;
+			irq_res->desc[i].num = ud->rchan_cnt;
+			irq_res->desc[i + 1].start = oes->bcdma_rchan_ring;
+			irq_res->desc[i + 1].num = ud->rchan_cnt;
 			i += 2;
 		} else {
 			for (j = 0; j < rm_res->sets; j++, i += 2) {
-				irq_res.desc[i].start = rm_res->desc[j].start +
+				irq_res->desc[i].start = rm_res->desc[j].start +
 							oes->bcdma_rchan_data;
-				irq_res.desc[i].num = rm_res->desc[j].num;
+				irq_res->desc[i].num = rm_res->desc[j].num;
 
-				irq_res.desc[i + 1].start = rm_res->desc[j].start +
+				irq_res->desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_rchan_ring;
-				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+				irq_res->desc[i + 1].num = rm_res->desc[j].num;
 
 				if (rm_res->desc[j].num_sec) {
-					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_rchan_data;
-					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
-					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+					irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].start_sec = rm_res->desc[j].start_sec +
 									oes->bcdma_rchan_ring;
-					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+					irq_res->desc[i + 1].num_sec = rm_res->desc[j].num_sec;
 				}
 			}
 		}
 	}
 
-	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-	kfree(irq_res.desc);
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, irq_res);
+	kfree(irq_res);
 	if (ret) {
 		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
 		return ret;
@@ -4977,10 +4985,11 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
-	struct ti_sci_resource *rm_res, irq_res;
+	struct ti_sci_resource *rm_res, *irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 	u32 cap3;
+	u16 sets;
 
 	/* Set up the throughput level start indexes */
 	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
@@ -5057,13 +5066,13 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 	if (IS_ERR(rm_res)) {
 		/* all rflows are assigned exclusively to Linux */
 		bitmap_zero(ud->rflow_in_use, ud->rflow_cnt);
-		irq_res.sets = 1;
+		sets = 1;
 	} else {
 		bitmap_fill(ud->rflow_in_use, ud->rflow_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->rflow_in_use,
 						  &rm_res->desc[i], "rflow");
-		irq_res.sets = rm_res->sets;
+		sets = rm_res->sets;
 	}
 
 	/* tflow ranges */
@@ -5071,55 +5080,58 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 	if (IS_ERR(rm_res)) {
 		/* all tflows are assigned exclusively to Linux */
 		bitmap_zero(ud->tflow_map, ud->tflow_cnt);
-		irq_res.sets++;
+		sets++;
 	} else {
 		bitmap_fill(ud->tflow_map, ud->tflow_cnt);
 		for (i = 0; i < rm_res->sets; i++)
 			udma_mark_resource_ranges(ud, ud->tflow_map,
 						  &rm_res->desc[i], "tflow");
-		irq_res.sets += rm_res->sets;
+		sets += rm_res->sets;
 	}
 
-	irq_res.desc = kzalloc_objs(*irq_res.desc, irq_res.sets);
-	if (!irq_res.desc)
+	irq_res = kzalloc_flex(*irq_res, desc, sets);
+	if (!irq_res)
 		return -ENOMEM;
+
+	irq_res->sets = sets;
+
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[0].start = oes->pktdma_tchan_flow;
-		irq_res.desc[0].num = ud->tflow_cnt;
+		irq_res->desc[0].start = oes->pktdma_tchan_flow;
+		irq_res->desc[0].num = ud->tflow_cnt;
 		i = 1;
 	} else {
 		for (i = 0; i < rm_res->sets; i++) {
-			irq_res.desc[i].start = rm_res->desc[i].start +
+			irq_res->desc[i].start = rm_res->desc[i].start +
 						oes->pktdma_tchan_flow;
-			irq_res.desc[i].num = rm_res->desc[i].num;
+			irq_res->desc[i].num = rm_res->desc[i].num;
 
 			if (rm_res->desc[i].num_sec) {
-				irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+				irq_res->desc[i].start_sec = rm_res->desc[i].start_sec +
 								oes->pktdma_tchan_flow;
-				irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+				irq_res->desc[i].num_sec = rm_res->desc[i].num_sec;
 			}
 		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
 	if (IS_ERR(rm_res)) {
-		irq_res.desc[i].start = oes->pktdma_rchan_flow;
-		irq_res.desc[i].num = ud->rflow_cnt;
+		irq_res->desc[i].start = oes->pktdma_rchan_flow;
+		irq_res->desc[i].num = ud->rflow_cnt;
 	} else {
 		for (j = 0; j < rm_res->sets; j++, i++) {
-			irq_res.desc[i].start = rm_res->desc[j].start +
+			irq_res->desc[i].start = rm_res->desc[j].start +
 						oes->pktdma_rchan_flow;
-			irq_res.desc[i].num = rm_res->desc[j].num;
+			irq_res->desc[i].num = rm_res->desc[j].num;
 
 			if (rm_res->desc[j].num_sec) {
-				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+				irq_res->desc[i].start_sec = rm_res->desc[j].start_sec +
 								oes->pktdma_rchan_flow;
-				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+				irq_res->desc[i].num_sec = rm_res->desc[j].num_sec;
 			}
 		}
 	}
-	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-	kfree(irq_res.desc);
+	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, irq_res);
+	kfree(irq_res);
 	if (ret) {
 		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
 		return ret;
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index e027a2bd8f26..04d99c1fafa1 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3574,16 +3574,11 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 	bool valid_set = false;
 	int i, ret, res_count;
 
-	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	res = devm_kzalloc(dev, struct_size(res, desc, sets), GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
 	res->sets = sets;
-	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
-				 GFP_KERNEL);
-	if (!res->desc)
-		return ERR_PTR(-ENOMEM);
-
 	for (i = 0; i < res->sets; i++) {
 		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
 							sub_types[i],
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index fd104b666836..7632bb11c862 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -599,7 +599,7 @@ struct ti_sci_handle {
 struct ti_sci_resource {
 	u16 sets;
 	raw_spinlock_t lock;
-	struct ti_sci_resource_desc *desc;
+	struct ti_sci_resource_desc desc[] __counted_by(sets);
 };
 
 #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
-- 
2.54.0


