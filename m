Return-Path: <dmaengine+bounces-8657-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Kl4Jhg+gGkY5QIAu9opvQ
	(envelope-from <dmaengine+bounces-8657-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:03:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04291C871E
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EB403014C11
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 06:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC7F194AD7;
	Mon,  2 Feb 2026 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3fdE3vS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE362F39D7
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012153; cv=none; b=C15IVxwWu8K8d4SZ6wazw0rZHmbP0+NFd1BnMN4FOamxTjUS5Mhq4Y6lKgUJbyf/VkVKEJBeEl8A/XYMsktRF+vRk8LnvR/Pd0fWJdyc4QjSz8xffdW2VwDaaLX6ImqzdIiswUhw2+IEsZj3VDZpcHxfMMck4wACVKa54fGOtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012153; c=relaxed/simple;
	bh=I5B7AJbCH7As2yEWsbVpfdFdE5fOiK/B2fNAmT3r6kM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4Avnnaa+r14S901+D9COqcnDiOEGWsMhJ85rz6FMchTRkTGcBiX4cD7tf8xJz6xoUkToQw+qwln+W+tk/8gmUNyH5YwVBfhAmprMDVDDq08PpQnMUfHfWSsC2EK3L14PGTTiee+tDZsAfkZq/9pfTlvhmrfTlUmne5fLy/d57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3fdE3vS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c718c5481so2517764a91.3
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 22:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770012152; x=1770616952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaSd5xHb0x3sp927EpfrEVbqVinwErLxbtJRKDKA/uQ=;
        b=E3fdE3vSmi5Tgx+0GGgNake8qSv2pd+rIBr2/wS9H7ruPKUYXZ5TgBtgyTXTiI7CtW
         1NCi5iY40LvMpFi59Ts9l/PH3NqIFhF9KBfiK62HzsBomZnLHLsiw/VxMWx+WusUOT2V
         wG4ac5+JxnN5NEJPHyUb3z3Q1jrw3GkDuGKY/76Pxq4jIEkmoVW+rPaICrkZ2N9qmWD5
         UhDyIGC6ymvCYGj5Z4gU50MlFSgwENXF7hxtarIHbaWkfiBoRbhEW133tmhjUJ3HfaLR
         XaBOgIPbAvoer3lldvIAD/lJFk4nyyyz2DUVJUglkaJ/LqSZHSJacLFd9rMhXS90FL/U
         7I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012152; x=1770616952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UaSd5xHb0x3sp927EpfrEVbqVinwErLxbtJRKDKA/uQ=;
        b=CUXnOvSjh+VizVEMqFmeSzBFTv5yWIGF5mvE7jdPszUt3xSLxI/Di1Rs0CutttdKLp
         SRlhmYW+Xu7lU/kockq4KteIPp8ZDtjM+lFbUQHNmtRKb3VkI4SSZTJ21ECemqQD7kD1
         4LBKfq6NwBACV1OCv5l9X2CmW1H0xMjRslFNCJTvZLxQ4qkaG3cAswbUy8s5Yo1yHetu
         j7UrdHOl1F2ucvcV3J/l+SA9IbdhtT2hW5vm1WxmdafRDG9ly9qN+N+tJhUHNrIZo/D4
         GB+zgR+6Cn5eGWjwDVi5grBYPzi3ctRDHr4NS09BjiO06rD3XYHX+hkLnItdA7l6U3mO
         I5pg==
X-Forwarded-Encrypted: i=1; AJvYcCViYt/Gl/ay3w7xFi77EwQUAIy+eMQXsep8G3bYq3Q6hMs2Du/BwpYtV8jRRY7aeVCe0lUPLxE0E7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzC5qnuHjPyC0Tf1YO56OdQe23BrjB/65SOvblpKcgrXL8pyfW
	ubcqMqQLfZi/SN+Mbn0AXeAGbwosP+AEqpru106qpV/AsSDsaQ+g1ZmH
X-Gm-Gg: AZuq6aIO5y1NmVJ5uAoL4Q6cAg1ZOQbfo3XADQOaaG69DXOfqWSQs5h3WIZaabK1eFi
	euXnk+Vlf0afEvGuWtH6DcAAK5OXUj9vsPXh5FiN1BZmMUsJPKGxk+RDtl3TphCxyI9xLjP02jS
	KsMrtHUd0dMbpm49eP/iGHyHEyLUM8jrcn6G3EXvj8i2jqtnkh4YAD3BWCGCvmXRRRfAzg6DJiN
	WLl3GX7iQoj0BjOggR5X0r291I/TUuB0E4lzN8tk7EE5d7w0t2sz4YZ45UZDezAPwTQe1t+adGh
	qefyAZOc6vpPkunfBATkagYQ/X6A/nSK+mW+bchJfFV+veEHkXKhvKnT+t5dnrAeuKdgYAuDGee
	RwLhUepA4NDgTA2qEXex0pC6LRiUenBn7Kb2n5PN7MCCYhEke+sdDDyQwfnmqR/+lLJyxA64VjA
	iwCnP+jZECLoqlzHGnVP51pHukJCeK88zT8IE=
X-Received: by 2002:a17:90b:264c:b0:34c:75d1:6f90 with SMTP id 98e67ed59e1d1-3543b395b8fmr10327607a91.17.1770012151621;
        Sun, 01 Feb 2026 22:02:31 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm14212294a91.0.2026.02.01.22.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:02:31 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v7 1/3] dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
Date: Mon,  2 Feb 2026 14:02:17 +0800
Message-ID: <20260202060224.12616-2-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202060224.12616-1-karom.9560@gmail.com>
References: <20260202060224.12616-1-karom.9560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8657-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04291C871E
X-Rspamd-Action: no action

checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac-platform.c:

  CHECK: Alignment should match open parenthesis

This warning occurs when multi-line function calls or expressions have
continuation lines that don't properly align with the opening parenthesis
position.

This patch fixes all instances in dw-axi-dmac-platform.c where continuation
lines were indented with an inconsistent number of spaces/tabs that neither
matched the parenthesis column nor followed a standard indent pattern.
Proper alignment improves code readability and maintainability by making
parameter lists visually consistent across the kernel codebase.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Fixes: e32634f466a9 ("dma: dw-axi-dmac: support per channel interrupt")
Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
v6 -> v7:
    - Add more details in the commit message.
    - Moves the fixes from v6 to Fixes:
    - Remove quote.

Reference to v6:
https://lore.kernel.org/all/20260201000500.11882-2-karom.9560@gmail.com/
Reference to v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
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


