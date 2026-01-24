Return-Path: <dmaengine+bounces-8468-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG9NIW8ydGmm3AAAu9opvQ
	(envelope-from <dmaengine+bounces-8468-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:46:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6617C3E7
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52FF6300F1A6
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0522127E;
	Sat, 24 Jan 2026 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLVs5jDM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EE20F08C
	for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769222748; cv=none; b=ia0pJUr5GIkNZIP8zHCuvwu7IzHw6CUDmPPqSJd22l8j1NVs9pWs5bbpfeJjxvCFs32nrSoO3DTjmUS+lpVMuL7gGQoiCXSZ3TBOSyizQDE8dVovskJwdNOXG7Gs2XoXzmeS/dvrmnuY/IkfFmxdNiLBWK0w43CeEjt8kBFVxI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769222748; c=relaxed/simple;
	bh=pITg/TI5DG9dnS6gImX7cJ3AjbnNEEMpM9FS0bjwUDI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAK3PgFSw+VTyX5PrP5B8AV4joSktstcgKBhpAhPl6p70sz3xFxreuZf9sMg6Vb+nWE+HNYY7r5FoX5wov5u1pQE37l0vx4T7L2mxy1NX9rKBvHfcXpurwDSp6cWjwSio/KzluT4A1PYI9rxS01K0fXmydMYhrTtMpi02S3nga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLVs5jDM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81db1530173so1504324b3a.1
        for <dmaengine@vger.kernel.org>; Fri, 23 Jan 2026 18:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769222746; x=1769827546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcGe0voZUdVl1NgdCzMM48kaoRqFckcQPcSO7GQVhxs=;
        b=XLVs5jDMuZNG6/Ap+DncCiXaM5oeDBuk1MdwzGezlQYeqY2CLBg0stW6C6Yczj+FJy
         jiQuH3yMJJc+3FnXF2DhaOii+yVzwgwFCJl+aLg99Zwc7NN9qQsLzsdL2kpqNiJ9AM3e
         00mFvhoMP+SJCKwEKNsFVjj5iGO2Mu5dEUr6cz+SO/n2+zm/EZXyN/Ojt8JRKvDnr7OM
         cbE2zdFw6LWxiKtfne85at7wbLPhC5TZDv2WPrYB7YPh6p1DpVYOhQLIeSl3Jg5uMRm8
         GGanJ6traBuyxD066sFAI1LULrHYgD6Q1m4xlLrmBuazqnrEjF6KCgLIe6RaNgxcJ+Id
         Caag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769222746; x=1769827546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcGe0voZUdVl1NgdCzMM48kaoRqFckcQPcSO7GQVhxs=;
        b=D08W6ShrhRxmeI2ZCfjHr8NuPCeCh/zxaVe9k25imo9cE24J8Pu/RDH7F3cqr8tsqJ
         0tISEGiCGkWKtpdfADugzqpin3JzQnJxFY5PvkQUr4rqrQGVQK7yqW7gIleaqPvDubGu
         aoUi+HKZIUeAi8NvR+PbL7k/k6nrQ/L/tlKtBX/j7rCMdfJf0Tr4RC4LJvAkNn0UWVU8
         4BT59WVQoOiLKJwqd0AxeF41/1T/mC0O+2Ve+ZXzKjA8+g87KAh1NWy2JBsLruPVZtiU
         +l7a+ExnzcdclUlpBkrb2XHxr28T0Qxx17sygMIMT7rLLtWnY67yAsVRUUnsNTuMjR6y
         E51A==
X-Forwarded-Encrypted: i=1; AJvYcCUVe1XCFADLDqt0FTv8Pg+5Tj2/8gVDLAOLxYoVEBwUKWX70qdKmmzy+LDPZS+FsxxAdcZJKy6Q8ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmk2jY805j+bSJzvi7ScnZrIh2B3mgnO5aI64jWQzpe9jHS0tl
	DiqY5sp1BXX7BrJcyQfcLxlYRV1axxOXogTOrTXu4o/kzpM7vzcN3g5l
X-Gm-Gg: AZuq6aJEVcLWF34iEDJc4LJUCeM00kFOxSmyd4F4fzod5fCYS7ftov7LXKvA5SYE/au
	x3iMeY1SUOIiQsWW1eTP4apUfX7a/CvvRhUK2OpMUlXNCNRL595Q3zqwTYQroLZ8TFdSH+G0oGA
	7dvGlt8p8i44BJfZJgdm8/+gp7kzcC+7wmBTeVimYMBmFyag1UMwLREH0eEqdzLJIh3sB4+0Yhx
	vhZz0s/9y0wmqFARxaQ76Z+cAwDV5t8wlZZH2A5d5Jb/7r1yp9Ol8xcNW5ZvKlFJY8mi+1NcrZp
	zIyr8irKsgqwbvHbI64yUtWAccjGAsj0fuF38RIULtYQSsn4EpbSdwSPvEjkJhwmSkghVmZtenv
	A0/GYnV5wdVmsgQQhscHKqmYStXrn7DqLEXatcjWPp05eM8SGMon8K+Cei8YGEHIibw7HOva0bw
	mz+5doICt7lxASmZv+DTJLMDGlQ11Agq5m/8Q=
X-Received: by 2002:a05:6a00:1d87:b0:81f:2140:137e with SMTP id d2e1a72fcca58-82317df2df1mr4486910b3a.30.1769222746355;
        Fri, 23 Jan 2026 18:45:46 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318644989sm3279598b3a.13.2026.01.23.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 18:45:45 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v3 1/3] dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
Date: Sat, 24 Jan 2026 10:45:37 +0800
Message-ID: <20260124024539.21110-2-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260124024539.21110-1-karom.9560@gmail.com>
References: <20260124024539.21110-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8468-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D6617C3E7
X-Rspamd-Action: no action

Check warning is throws when run scripts/checkpatch.pl --strict:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:345
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:356
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:494
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1165
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1454
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1648

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
Changes in v3:
	- Split the patch into smaller patches according type
	  of warning.
Changes in v2:
	- rebase on top of 3c8a86ed002a "dmaengine: xilinx: xdma: use
	  sg_nents_for_dma() helper"
	- refactor the commit title

Reference to v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 493c2a32b0fe..8bb97fb8fd4c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -342,8 +342,8 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
-		axi_chan_name(chan), descs_put,
-		atomic_read(&chan->descs_allocated));
+		 axi_chan_name(chan), descs_put,
+		 atomic_read(&chan->descs_allocated));
 }
 
 static void vchan_desc_put(struct virt_dma_desc *vdesc)
@@ -353,7 +353,7 @@ static void vchan_desc_put(struct virt_dma_desc *vdesc)
 
 static enum dma_status
 dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
-		  struct dma_tx_state *txstate)
+		   struct dma_tx_state *txstate)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	struct virt_dma_desc *vdesc;
@@ -491,7 +491,7 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
 
 	desc = vd_to_axi_desc(vd);
 	dev_vdbg(chan2dev(chan), "%s: started %u\n", axi_chan_name(chan),
-		vd->tx.cookie);
+		 vd->tx.cookie);
 	axi_chan_block_xfer_start(chan, desc);
 }
 
@@ -1162,7 +1162,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 		axi_chan_irq_clear(chan, status);
 
 		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
-			axi_chan_name(chan), i, status);
+			 axi_chan_name(chan), i, status);
 
 		if (status & DWAXIDMAC_IRQ_ALL_ERR)
 			axi_chan_handle_err(chan, status);
@@ -1451,7 +1451,7 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 		if (chip->irq[i] < 0)
 			return chip->irq[i];
 		ret = devm_request_irq(chip->dev, chip->irq[i], dw_axi_dma_interrupt,
-				IRQF_SHARED, KBUILD_MODNAME, chip);
+				       IRQF_SHARED, KBUILD_MODNAME, chip);
 		if (ret < 0)
 			return ret;
 	}
@@ -1645,7 +1645,7 @@ static void dw_remove(struct platform_device *pdev)
 	of_dma_controller_free(chip->dev->of_node);
 
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-			vc.chan.device_node) {
+				 vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
 		tasklet_kill(&chan->vc.task);
 	}
-- 
2.43.0


