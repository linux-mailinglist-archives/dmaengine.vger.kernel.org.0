Return-Path: <dmaengine+bounces-11080-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIEzDLLUHGqUTAkAu9opvQ
	(envelope-from <dmaengine+bounces-11080-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:39:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB56187D1
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AB0430416D1
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A01F09A8;
	Mon,  1 Jun 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIBZd50x"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA451C84DC
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274176; cv=none; b=SgxeFKLsHllRHy43W/H79+pHfteYOVT7m6tFlXVk50nsVOQaZ4PgpwhFZWQWdTgah/Vr4gm/KmMYK/7LtMgUPR+PLhxRjw/1PHVEvUTxlaHiU7/e3tsS8sZrPG96C6+2t7bEmPrNj0qmYH6XTslGOhVIiL4bG+CzTvVMeAktD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274176; c=relaxed/simple;
	bh=uuAw+Wh8b6dndSMT4KfsWlWqDY3OC7zXcn/LPa8xH08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKn3N7W5xM6utiyO8I6uISIwNC1vgOhm0UH/c7DceOXQ4/mLTeQIQd7MStyq0UDtrqFLJ0fM2Hoi4bUr/WscWd7iAnsxntW2PZe9BSBERQSK+2AA/+kYeWKvpCLXf8pSJEzA3+XAVqFNIcfYC8HjipRL84UiV4tJWBOfD7pqakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIBZd50x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0a5354da1so8571245ad.0
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274174; x=1780878974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URm5CekzJYxc5s9juYhDgo8eAbfkbMZqryXqUOBN3KQ=;
        b=UIBZd50x/9C+1VtnBElodaXc9/yLfW4es93wn2zOS3miRnXHByC/HL5/hfVIIqTG8d
         1R+NLAx4Okp7ecYs5bv90s7JmsacrrRLbWuZ0i1Pcx/jD/Yz1okx5Qvgct94mT8OytZu
         LfDBLCR+4SrIlvzIAwxolyJ+3XP4JP36e+m8G669Cky5yIg1u5pxDdxMvyDNH0DQWb0Z
         tHw9ICr4mLEiIxwo17n0LMi2DtowpVs2fn/U2wz/2hGssA0OoNLmvOyI3QZ609XKp7qp
         1en5vLv4bd+d7niJcUCH4nCUXDGPaLWz5bECKKwZjgVawgTHSVDPVCbpNdlLS+Bas7Z1
         ztkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274174; x=1780878974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URm5CekzJYxc5s9juYhDgo8eAbfkbMZqryXqUOBN3KQ=;
        b=l3oBrN6zyl0sbzUBsVzflm6UQzwq6EGKFIpFdz0okTRZdZRb3iQBzb6m7ZsN2iBaFO
         qEsXySAEv9l7tO8ENtnqUWVzcsC3tTm15D6lU9LeaPt/bh3dTrsDL66OnLzUtihb95c/
         gaEbjPUtOC4IK7UdltQYhHRr82HtCqd4zt8LZlkNg6/GuaJOP9hX2KDH4p1ZRM1L/rc6
         noFO83ivT284b4JzHlMwiYRF3hdus2hnqfUSyU/K+YpSwRUtlKGW5o3rFYaRgwRk0D0N
         9Ysz93Ggi1MBobKMR5oMNQW/F331D2fvp5B6rM4Bgw+kQEfvvY0xoQlJRs2VmAPsdFFp
         Ca3A==
X-Gm-Message-State: AOJu0YxPNDN1pkuAs9hdQR7OYbtYoODJ6IIihVpmeIsr4+NIj7eM/sXV
	BzeN6z8QpJSBtSiwNOrZ7ipmgm0aIoFWmCRNbT4GWKs1qSfk2Wu1IzyRARmq2Q==
X-Gm-Gg: Acq92OGqbZD0G8M6LZqNMMcUopI7kpYMomdXVkxWdHkPeqPX126I+7v/0+SBLVNpzoY
	atTUxDvdtNeP4p7qYVYJIy6ocfNnfjeXAUlAEgqqtm4UAU+4+iY2PXzVTZwCgup12ubFpTlL1vN
	WAHSdK23lLQMJ7COEVufAzVs1LWaSt5flrowNOqPvPWCWNv+XrJa5enAm0DXQuw4hY9m0hNdxwF
	FOxv2UGKlCLVRA/aoLrF9hf5hIdjpvnt4FaYUpl/sPnsWdlCHTAHJsWUizST9xWORHHCXBjfnY+
	X9umj5Hbb/a7X1KjqLrhlGx58s2LWciR/j6RWSIuAqsu3cyb1qoq2Sa2JBeDYtKGj8fwbMYkdVv
	bhy/o4ymJ0In5EvVPY98bP9L3YPhB6YxZvpMtixI6Oe7+5JFo6twn4F6+NqDDwWeaaxVtekZ0c4
	fBchQgd9KmbLqJWEnMnkdOXItvPNJ44denDJ0faX7sme9JKSuSxtldPnWGowe0ISOuHaEJRCyEj
	bdSmBT53o+1KluW8HFA4RE/ZOjWbfD+xBIAjr6yLe6Hvg==
X-Received: by 2002:a17:903:2acd:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bf20533582mr107605305ad.20.1780274174045;
        Sun, 31 May 2026 17:36:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm111929565ad.41.2026.05.31.17.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:36:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/5] dmaengine: ti: omap-dma: fix dma_pool_destroy before omap_dma_free in error paths
Date: Sun, 31 May 2026 17:35:51 -0700
Message-ID: <20260601003553.72573-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601003553.72573-1-rosenp@gmail.com>
References: <20260601003553.72573-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11080-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FBB56187D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The probe error paths and remove path called omap_dma_free() after
dma_pool_destroy(), leaving the desc_pool dangling while freeing
channel descriptors that may reference it.  Reorder so omap_dma_free()
comes first.

While here, fix two additional pre-existing issues:

- The probe error paths that run after the IRQ handler is registered
  did not disable hardware interrupts before freeing channels.  If an
  IRQ fires concurrently, the handler could access freed channel
  memory via lch_map[].  Disable IRQENABLE_L1 and clear
  irq_enable_mask under the spinlock, then readback the register to
  flush the posted write, before calling omap_dma_free().

- omap_dma_free() did not drain the virt-dma descriptor lists
  (desc_allocated, desc_submitted, desc_issued, desc_completed) before
  kfree() of the channel.  This leaked pending descriptors when the
  error or remove path tore down channels without going through
  omap_dma_free_chan_resources().  Call vchan_free_chan_resources()
  before freeing the channel structure.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 839e04f53fc2..dde270646bb9 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1522,6 +1522,7 @@ static void omap_dma_free(struct omap_dmadev *od)
 
 		list_del(&c->vc.chan.device_node);
 		tasklet_kill(&c->vc.task);
+		vchan_free_chan_resources(&c->vc);
 		kfree(c);
 	}
 }
@@ -1808,9 +1809,14 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (rc) {
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
+		spin_lock_irq(&od->irq_lock);
+		od->irq_enable_mask = 0;
+		omap_dma_glbl_write(od, IRQENABLE_L1, 0);
+		spin_unlock_irq(&od->irq_lock);
+		omap_dma_glbl_read(od, IRQENABLE_L1);
+		omap_dma_free(od);
 		if (od->ll123_supported)
 			dma_pool_destroy(od->desc_pool);
-		omap_dma_free(od);
 		return rc;
 	}
 
@@ -1825,9 +1831,14 @@ static int omap_dma_probe(struct platform_device *pdev)
 		if (rc) {
 			pr_warn("OMAP-DMA: failed to register DMA controller\n");
 			dma_async_device_unregister(&od->ddev);
+			spin_lock_irq(&od->irq_lock);
+			od->irq_enable_mask = 0;
+			omap_dma_glbl_write(od, IRQENABLE_L1, 0);
+			spin_unlock_irq(&od->irq_lock);
+			omap_dma_glbl_read(od, IRQENABLE_L1);
+			omap_dma_free(od);
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
-			omap_dma_free(od);
 			return rc;
 		}
 	}
@@ -1869,10 +1880,10 @@ static void omap_dma_remove(struct platform_device *pdev)
 		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
 	}
 
+	omap_dma_free(od);
+
 	if (od->ll123_supported)
 		dma_pool_destroy(od->desc_pool);
-
-	omap_dma_free(od);
 }
 
 static const struct omap_dma_config omap2420_data = {
-- 
2.54.0


