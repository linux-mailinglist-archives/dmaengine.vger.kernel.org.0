Return-Path: <dmaengine+bounces-11065-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHyOCSeYG2rvEQkAu9opvQ
	(envelope-from <dmaengine+bounces-11065-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:08:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62D614365
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7E1A304B6B5
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D833630B3;
	Sun, 31 May 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MInsIqZX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C4364047
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193161; cv=none; b=lLtE2gWSs8A0AshAOSWTbpWF8SAHlY7CMS5q9zl5yxOHs3uE43zw6jP763QeqZw6YK2dLW62IJmWH9f+5uxfZbj+WP4Wtx684SvtTgSxw0yV7K4zTV86SvXG/lgwaBMzd3dM+jgxyV7oztPH9+2Iz6Safnbai4GfdSWP6MWfagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193161; c=relaxed/simple;
	bh=IQfxgm2MWgvf9AN1+HadB8z6n3kjnD8BRuJ/NOZfTVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0N0yI2GBAMwKNhS0yE5WDKqtrB4XnvYgmF6m7xx6qSPJU2R+rW/JDLj7+VZm/FqNLbED2VM53Ojew8k5CaAN/HyWqKK01oWIQDcz2J5joWgGrtowcxtecx0TNd7skOHAED8NcV5Og4VTzWBxvlM5AvgdFOavg1XWQb1ihRgrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MInsIqZX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91550fe1619so30565385a.3
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 19:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780193159; x=1780797959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev7p7h9heSSNp8XX7uho86JPebrwudJ97FaZXIjk1zc=;
        b=MInsIqZXa3920VX9ttZr3tTamgorsxkFsXj3sLsA+1PxzSoK5qBV39iBP9cbtW4VvS
         COaETIHJRwj2ZJ1M4NszFy4U/gLWQszUY5vzimFQX1mdF5lJD4kvhBZeZpJpZQ2Qc7j9
         Aizv8xOHqTbdyFPT6R6tOypxpGtsuR6ArETUT3R00jjMN1ntlhdHEvHZj1yFEWJk1LUx
         /L1Hnfsq9hG9xs4lYs0qjHf248h0PcrjTpG6DirrJrpR4zrIzBzoxqpTdVh/OSBs0b93
         lE7ebQEtRZJlStchWChL+PAKyg25MbF6+gv+gqla/6e6VVqfZwLuu8sPe6soAL4lek93
         cEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780193159; x=1780797959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ev7p7h9heSSNp8XX7uho86JPebrwudJ97FaZXIjk1zc=;
        b=LAQqXXyf6JIOdYBpxvke4hZ0y8lc9k0fDFzN4bPTbgW3SYJBSyeVdVS9hkeybTOyaP
         g34JH21hfcF/HFxZjouQMFc/czpVnp0Tf7u4pifENSFojQMEoTVd+EBYiyQJcZ4RQ0f4
         70c0eIyBqTUS1zF2OTZ8W9UiX7j6VI14lcY1ZMKAmqful2HL0iDW3Sf+0WwR5vz+Gaje
         jGN8/aAEX0uBiVgyypWNgxMXRIYvTAcADZVwtdfbC6wKAw/4XRJWpyCEk7kB4Rzd9w3J
         v/ShqRpTU1Ej62F6mltKMovv/ZdQAqhk8DEkoYHTkqUDRHCttYopqQoLEu8DQM2Ck8dj
         8F2g==
X-Gm-Message-State: AOJu0Ywi5VT+/4+TiVadaul2Dd2lU45wGHDOIB5CAqFmZdRz4FUpPg0D
	GyNJW6Pb6e8iGHeHSH6F9hTbTj7qbl12/qKPZrZezwlwXcQpO+crfPr/3pPiZZqw
X-Gm-Gg: Acq92OG7FMa6EuhuW/wO9FGAjIPSeHzFizT1R588Eii3lZlbYbasdx+nw9vTw3ffjBC
	siSUVIn1ubymVBGmExVTPaPiDk6E2s0/r47p2IVUuWJYGG5SJZ1UIPTaPEvkIzGii+IHWVR/VKW
	DqPO3wVclJbs24nPvl0oOZdpMD/GgYNB6MD0KR7RamabAQVg7M0jo7/uRSbQw6BSG/xEFaTD5ey
	ps7mBpt31CfkrSBeYyNUyn86NkJMj2Sx/bAaT4JfOXljJGlOPM9ndAcJ4VwFfwIpSvM41tY9QLS
	1cdjQejlEGnjmAzm97QrVgySj8rMtbzi+aDhVRxFwJ6ep2taA8Smc28la8JEUaVC+wgzL6pr47L
	6EWlGLMocaOyfOlh+3o3Hmv7MyhfmOBj9z9t8t4p48S6ZJDcCZfAKI79RfrQ6RNiunLgevAmhMa
	8HbVMjW3AfqM1XcwkdxtDTuhZKP1aGV7H5yYsOYmgaemDH8eCo+dpQvhXBHznCxPDBHxblNG4qB
	YDfBWmbYWQnG2q3VUzCS668vzKOFMgwUxlwn2HkkaCsGA==
X-Received: by 2002:a05:620a:2610:b0:8f8:cdd0:df82 with SMTP id af79cd13be357-9153dcb4b99mr938551185a.58.1780193159498;
        Sat, 30 May 2026 19:05:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324745cfsm620246285a.12.2026.05.30.19.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 19:05:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] dmaengine: ti: omap-dma: fix notifier leak in remove
Date: Sat, 30 May 2026 19:05:33 -0700
Message-ID: <20260531020535.594460-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531020535.594460-1-rosenp@gmail.com>
References: <20260531020535.594460-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11065-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9A62D614365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The notifier may be registered for needs_busy_check (omap2420) rather than
may_lose_context (omap3). The remove path only checks may_lose_context,
leaving the notifier registered during driver removal. Check both flags.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 0f6dd6b0a301..839e04f53fc2 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1853,7 +1853,7 @@ static void omap_dma_remove(struct platform_device *pdev)
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
 	int irq;
 
-	if (od->cfg->may_lose_context)
+	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
 		cpu_pm_unregister_notifier(&od->nb);
 
 	if (pdev->dev.of_node)
-- 
2.54.0


