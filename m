Return-Path: <dmaengine+bounces-8640-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM7PD9OYfmltbQIAu9opvQ
	(envelope-from <dmaengine+bounces-8640-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:05:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A83C4707
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 967703018287
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0113EBF27;
	Sun,  1 Feb 2026 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xck1V1eb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AAD23741
	for <dmaengine@vger.kernel.org>; Sun,  1 Feb 2026 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904311; cv=none; b=H5MTujUZEFyL+dbZTZnLJHruwBRk4sHDYk53lK00ewWlxY9C5Uxhy0Au0iRyP6WBcId76IKyJ29wjvL9P01AJ4pnZngQKFnm3+qFlAG6M3RgA/bpSMhIbxAHnpsmk5HoGz50/TIOeMhH7hbFSk5PNIT7fYYwV2313GqK3UbQQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904311; c=relaxed/simple;
	bh=UbQoYssfQpzEfMkVx5WUyfGb5Mr94ytWd8DZAK+pEA0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwxR4kJXao5X3UPXuzc0mzVZJFDX1D8uU2Gq5cSq10ZEXMZF6P0aLs+qJ0fg74vuJWT0Mnx0X9Ic+2W8sJtFB6Vk11BPynNIFH3/4VP+59D5dMlMZbHoKMn5o6AOKDq1KqaEEgxFzDzcEGhiNlQEBUmPokVFtmQTyhQGW9lB5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xck1V1eb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1724384b3a.0
        for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 16:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769904309; x=1770509109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpbWVNAIIJzNB3VD0jenIFFFWVd02w5rkiWOHsNargo=;
        b=Xck1V1ebxvzqASSk07oKX/mhhrrnEJdQSHq8r6c8Nksu40th8BabbHMGzBPU+q+7yC
         mg0MGqd0+vNZhcb91QYRu2BaVj20zqJDcW7Syis1B5S6K/hPzvE07u5kTTGRaBRPl+kw
         aVn2sAGhYnHdOl8fB3+ggNUcz8TUk0s/Ir0Pgs4DpmPbIhMRhXbC6v+g0imeL4UP67TZ
         GVHLRLof8ht3Tn6VGNFzfatg7HR3f3xWR+Jc3dKkwLJakdmElqPzkmOHXnq+htGIdqFF
         GaATrcBHz6GROGLjQo9aSwPtLXt/gFLNWz83yIJTV6cxzW0YcdzVwBpwtM2FzDw+kSK+
         GWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769904309; x=1770509109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XpbWVNAIIJzNB3VD0jenIFFFWVd02w5rkiWOHsNargo=;
        b=cZoY6blid07y34bOpJ9SyXqGRe8xuAiZXr59NhFYEbCO1IbHAv12UC2aMKkMor0q3E
         e3reucvQQ8Gs4EuCAallHpGNw6HzG5FVUMuhTEpcRRa5vAzt5qFsb2E+gEoTEWlByl+Q
         67YOUIAur/AAW+Ao+69e1/gJeiDaEhx/6kRedUqRlNSjLrsv3c/+Un0jT6mbxq59ppJu
         aYS8n/CQ7Q0SPmkHbWQ2axJOkz6iffauPSaQGCGQOrkNCTsAfMA79K2T31DUGu5VWM2f
         4V9lRQfus/XgMVpkzWZaZpW6VFLipbHYWO5xClMlF/TkDMTUaG1UvzpLIw63X5/NywSX
         NayQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxKswQyQ4q6ptvpIcFlOhJO7KI2b5iKQ/xfdwVqOLDOtZlJjP6XEEDelwSDj3AYP7kV2+pls/jOT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTZjqF/99cDgy0B8oc5+kohs/0ggJcM5VHkaldWiobCljZRMh
	vKd6lEI3IKQ39otVjSt5dl1UXS/xVhpV6SAHOf0c97EEZryXeEkyPd4L
X-Gm-Gg: AZuq6aLaQlCWATQrq90zMCgJL1sT2ijX9yT1XgG2pxfjZI2Wv63hYygWX+nVEJbFE2D
	fUV6Jjik5x0IHx+2BZhTM5Pgd+r/yrwZqxi4wQjHYF+ewTxYNRzCu+WHDNmsAWG+edoMmJVQ8XI
	6KSderBKcPXAMgThiTPOdOf5wyrz4GwcOeYbr2BNZnkfX8BOwbwYOq5y5wx9Y4aKBHPrcdJvUc0
	bYiqglp1nWSkcdEAVI9FAkPJmYJslFGVaHwK82Ld+1lIF3hKufbNyE8kwBknwpyyjj0WQqcL0hs
	RBseHet8x6690OuvoX0FOo2P7UG2Bab92ntYZcvo4atkZNbXJt5bj/K4ya/QFWnBVA06DqosIGN
	lMi2B8TO6FVdNtxW2nnKH7bL8PGhe7/Yzsh8F5BWxxz08c8zuWKpiK8UOcto+0lj2mYfgSdNR7H
	ss7d2Z4a3HRUzLkk3s78B0scZ44fg69kb9VrrhTEF5g0wNCA==
X-Received: by 2002:a05:6a20:939f:b0:35f:7e97:a08a with SMTP id adf61e73a8af0-392e001069dmr6765678637.9.1769904309001;
        Sat, 31 Jan 2026 16:05:09 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm10295901a12.26.2026.01.31.16.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 16:05:07 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v6 1/3] dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
Date: Sun,  1 Feb 2026 08:04:50 +0800
Message-ID: <20260201000500.11882-2-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201000500.11882-1-karom.9560@gmail.com>
References: <20260201000500.11882-1-karom.9560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8640-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: B4A83C4707
X-Rspamd-Action: no action

Correct alignment issue so that continuation lines properly match the
position of the opening parenthesis.

The fix applies to code introduced in:
- 'commit 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")'
- 'commit e32634f466a9 ("dma: dw-axi-dmac: support per channel
   interrupt")'

This Alignment should match open parenthesis issue were detected with the
help of the checkpatch.pl analysis tool with --strict --file option.

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
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


