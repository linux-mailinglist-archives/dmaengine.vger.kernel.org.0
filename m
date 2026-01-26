Return-Path: <dmaengine+bounces-8496-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iARiOXREd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8496-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:39:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 161BB871FB
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8518C300E5FC
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745129DB9A;
	Mon, 26 Jan 2026 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyOK+XV4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70156331209
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423822; cv=none; b=C4a7bqdxNdyPUjGpdfwJAHpLhaJGlNdqESxu6Q9oF9XA9F1a+PKieFxyqH4pFOXxrNRFBi4zXQJFxDd6koaWLBKJA83EepHg0TH/X0AYCOlcN4oadwhwx1s/EOKcTtxbWMmR58EgS97vq5oxIl2MtYfWXVCBXdLNhwWpzKfhEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423822; c=relaxed/simple;
	bh=Pqwnx5Gvg/14/y4VyuZlzPLWof/sNh6OUm2EnJ8bALk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsuXIx1L0j/gQg5C3/FaEqNWOoYJotKerIhVVKT+59o8DOYhnTQ0jY+RwtDBA/ORcPxbOyUSNrbv2likYVcbWk8nCXgBXa8fGsndaq5XjF/GzK/NnlO2x245BOB5HEn4MRsNW/2+lYtafn0huYSOtUqXb02nVeuMgtBFFGpl5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyOK+XV4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso30313025ad.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769423821; x=1770028621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OoXAiCAyZ8IzO03SSiROoe55cw7QbTZXgwMcUKSmRY=;
        b=cyOK+XV4KdfjMXW/XJmQ0nbdPSzsaFbjiAkX4M290JuIHMTURDJo2tWpTuQaUJbyn1
         7vP2axaVFMPwYExk+0txEVBt4nSAw0wcznJdn2KU4L9bh509F3FnX8CtrTTMZU4Cvwtc
         9IrSyCGgqOD+zZ1zQT/QNEkaDoYy3A+WiDTArCWxl2U8TnosPccMPXmrp/C/yW2loPz3
         a58/JmeV4GZVYxEWPJsiUTwiqcyj/TQ+rd4IAY01jFCx6yVLfn2U2R/yFfXBTJqkOZQC
         /lGNTnsvxzznxTLh4VFQRSoaRNq23ahsuXU0aXwem4cmPAm0cKMSLgTs1g8kPw/itxmb
         HElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423821; x=1770028621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9OoXAiCAyZ8IzO03SSiROoe55cw7QbTZXgwMcUKSmRY=;
        b=T0uxdfxlFR1/6wcJABFRNwe1861xr4f0jIXq8b2qXYnPzzgyNcbsX4Czcx/a5XDxvV
         xkYBpAH5snr6vkrI6zTI3LHplb/Uef56dZOth2iuKjgIlVJwcvqGtfOO8DPqoA+Irn62
         hR2egwVLL18mbYP7Jxdp/uicEXWZQP7Hp8cv85BONBA6dHb7FeoSSNb1ghuWsPM3qVkx
         14S5Ek2g1cpT2zpWtRjQrY3Q3sTmvcOPaI67yb/w9vLqIjvXRdOAlkOM1pi7QY2Wi9aW
         m8PkUzFtfdN1gAM9Ou+PKg6AQEej0YEkg8yikR2hxFDGz/z2ur+lSZZnOv+nDadsV0aY
         agiA==
X-Forwarded-Encrypted: i=1; AJvYcCWbmLorgPkaSv+DubJpO8qqZ7ul/wyKnFGMAIs+4+x5H0o7QlTl59yIVJ3bl/SjYSz4swIzH17k4xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykY6uNxdG1KZDqZ1GMBjDsIW9waMn0v7l/CS8Od6Epq4HE6tlo
	2l3tnEIacChnvV4Fzi1d/CcHiimNdRP29nhiKCnAgZFDiaLT2FNRfzpf
X-Gm-Gg: AZuq6aLjVLxdvwL8p9U2YQUKVyKLEU5GCMxgMQbFDsJW1H98t2OZiYkjSkN22k/suWl
	ZI6CUH6ZjPT+lcNAPObIObJY9n+L8Pd++Da5PrFQgZ/EnG8DKGfCTzNRlHQnrpIl++cTATSr7TV
	M+Bl0a6Thq1CLwiW5WiYS7HIr68EUCSjzsSyvszMiFWI1cV/cgpT1nsul1tmS6josGJnALpdnq/
	Xlaqdi6UZRaBAeEgxd3WUvI0jdJiAHsZY7F084RewqacDgr5jrxeIttU+o6/YhfxjVV2O1QLzec
	ChF7AOEfK7Mr8WDNqhsygF9chegulIE+uqGPa5rSy4hzbh7HLxUynSf7/ME1CgypZLJ8uwHz0Tt
	gQO24d1DjcM55FHvMQqtVTUVM8CSFVqzXh7Z+8Q97TT1gKezURQ9ZPoYUI+FmLEe1VIyLZpPrDA
	CeukcythFkEPY8azmFI28KFygzVUkksfptV+M=
X-Received: by 2002:a17:903:2c0d:b0:2a2:f0cb:dfa2 with SMTP id d9443c01a7336-2a8452246e8mr36663335ad.13.1769423820541;
        Mon, 26 Jan 2026 02:37:00 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f9762esm86827545ad.55.2026.01.26.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:37:00 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v5 1/3] dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
Date: Mon, 26 Jan 2026 18:36:30 +0800
Message-ID: <20260126103652.5033-2-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126103652.5033-1-karom.9560@gmail.com>
References: <20260126103652.5033-1-karom.9560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8496-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 161BB871FB
X-Rspamd-Action: no action

Correct alignment issue so that continuation lines properly match the
position of the opening parenthesis. This alignment issue were detected
with the help of the checkpatch.pl analysis tool with --strict --file
option.

The fix applies to code introduced in:
- 'commit 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")'
- 'commit e32634f466a9 ("dma: dw-axi-dmac: support per channel
   interrupt")'

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


