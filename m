Return-Path: <dmaengine+bounces-11067-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FTFNrqXG2rvEQkAu9opvQ
	(envelope-from <dmaengine+bounces-11067-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:06:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2925D614347
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 037813012556
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B736309B;
	Sun, 31 May 2026 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcXsBrBq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC4362152
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193164; cv=none; b=nJ9FaCwLukvWPnlsCA3y4LMaogHqrF5BAfBxJ+x4O5ETLrqGNS0nmDE8zsjd2FT4xtw4MbHBexyv9AtQLmIRlR/+tvQcnKCpbj+MXDLw4BRZIkUlLNvjP7OZYs+OxBRc8x/ygM13m2SJ7iSe9WDUHIEgmL2qaAa3TurXeRplbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193164; c=relaxed/simple;
	bh=+vEmttP1J8GOoBDHqfYa/fLW6iRDwX0cvWqBNR8PBec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhUZs1F3300VxnaqR7+OKbgFHq3iT0bUbmeDUaVZwsPEb/vdeCaOlCo3ylaQQTUOkajPWkaM4ugvIYXxCtw2L/ZkxP/n+q1kgBdQNIbX5UwkkMf9950q19t/jlv1HJiNq/vn6Oue5hzOKgEvm83xBSCHO2+LzjiVi1cTo8+v9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcXsBrBq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9155183b42cso23871685a.0
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 19:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780193162; x=1780797962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyq/RMSWHbsnIwvCCwV5ErKhL2n7goa+ev6cXyqX25M=;
        b=IcXsBrBqGgl9KJDaDJHczozAMurrvj6t32FIqbkHu9gnKHPTpA/OtdJDqcfjBFr/0c
         Y6kaObaTJmC8B3etvoIMN5zaCYUsqC8Cs2n6leVftI5pk7nb/x6TnupkzMMQfoQwQGGD
         pG2GG91Z6uYNVCLdpY1B22xKFwWNFz/HRVoNZBs02yqL7vCCM+RDmmmdEeYh9ZvLg9Jn
         CSJYQyPoGoNIGmyNvFTh3YNRzP7QdTcyeX2jl3bFNb6HPaNco60kRY1uVfuP6+DSKF0t
         w7NIedjL5lAXyZKqwWZCAogUeu9WiZXWmxtk9XLHVN1PnqvaKKIehpY8n5PwqMbplqRt
         9t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780193162; x=1780797962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eyq/RMSWHbsnIwvCCwV5ErKhL2n7goa+ev6cXyqX25M=;
        b=PUjp00KT1GL9DShbGKAeCeb92PXRZ/i91G1uLrEkHx3S/tlR5RyRLNKfbKN5k7ecH0
         wqC5xM3fyImFx6cQqCscgD6e5/WPUS4eaUs9FpSTgmhRNgBS+eTKpnm3RFss644cTGxH
         NSjvR+bTFqeBNxVFMEQRv9CmsCmmYXmEMaelBnXhHK34e7vljVtMD9yQZsGPL/XfEQHs
         +9kj/FTt/Fftt2XRmHwU7UWPJ4E3eAWHNczEfX1VIkvpcrpH2Y61j3U6t0PTEVOJJzyB
         a/VfVyI86e6LOgZZlaojlMXyzFJf3P8ddRrCU+nM6qz/29d2CSjlwLy7OnN5rZZYvmnD
         1cAQ==
X-Gm-Message-State: AOJu0YxTVWjWnAeg7Wr0lmfFmAj+IPHwe4nUVO9EgY0jJBkd/xGkV2HV
	CUOONue1tdcJwZOt4Z3EIVbehMZCqGqJtHmoFpINC4wqZdlIo3nTr6lgTqWFAckt
X-Gm-Gg: Acq92OGohtestYyXHGgwNn+DUtvRm5iz+u174OXBAQVKYPQcx+kKVUS7Tg095ovpfr9
	sDptzJIWGdrsUbxF8F2s+XiTDu60/TaEoj2GPtgUfZpXNj3uwbc81mnc4GCqy0A1CJNhENkASIQ
	wmQMxEtm3AHz0/NPDgMf4Jooc9wyEv9l077KS2tG8QSc2zw9D+xLjpeGGNjzAcc/HkU2TyZuTuo
	cUWbRvKV4yIggMPl8uuV9qI/W4jmf05G2kAGdwa6qcx5JgHQX6v4FPsSvI8GymmicJUnJcfOIOV
	9v5G3Jnh2yWdyvllLWjRPCy8PdqQbmKHYhGk7/fzgqNym0RuBFzkeMqUJlRCYjBEKAdAmNwaMze
	y3BEpTug6M+cn30rXfQ9kJjbOnJlHAj7adHi8W+WJU0OXwlM1q416jQ3DWmMFKzvXHJZByt5Hm7
	jsoLi+3zmYIYtTSB6j1b/epAW2IwP9Qp4hHJ2iGq5x45RZysL3LJg1pj8f2naWpf7d7QpL67IIr
	DBmx7jqOV/lvp5lEV5ZBfAwMXdf1BmC9zcVwrhmqAFsZg==
X-Received: by 2002:a05:620a:470d:b0:914:b31c:7001 with SMTP id af79cd13be357-9152f8ce09fmr1030710685a.6.1780193162583;
        Sat, 30 May 2026 19:06:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324745cfsm620246285a.12.2026.05.30.19.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 19:06:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] dmaengine: ti: omap-dma: fix interrupt handling in remove
Date: Sat, 30 May 2026 19:05:35 -0700
Message-ID: <20260531020535.594460-5-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11067-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2925D614347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The remove path had three pre-existing bugs:

1. Interrupts are enabled via IRQENABLE_L1 in probe and alloc_chan_resources,
   but the remove path writes to IRQENABLE_L0, which has no effect on the L1
   interrupt line. The DMA engine can continue asserting its IRQ during
   removal. Write to IRQENABLE_L1 instead.

2. devm_free_irq() was called before disabling hardware interrupts. With
   IRQF_SHARED, the hardware may still assert the IRQ line after the handler
   is freed, causing unhandled interrupts that can lead to the kernel
   permanently disabling the shared IRQ line. Disable interrupts first.

3. platform_get_irq() return value was not checked before devm_free_irq().
   If it returns an error code (<= 0), passing it to devm_free_irq() is
   incorrect. Add a guard.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index fd1ad3b4268c..ad90ca226db3 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1859,16 +1859,17 @@ static void omap_dma_remove(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-	irq = platform_get_irq(pdev, 1);
-	devm_free_irq(&pdev->dev, irq, od);
-
 	dma_async_device_unregister(&od->ddev);
 
 	if (!omap_dma_legacy(od)) {
-		/* Disable all interrupts */
-		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
+		od->irq_enable_mask = 0;
+		omap_dma_glbl_write(od, IRQENABLE_L1, 0);
 	}
 
+	irq = platform_get_irq(pdev, 1);
+	if (irq > 0)
+		devm_free_irq(&pdev->dev, irq, od);
+
 	omap_dma_free(od);
 
 	if (od->ll123_supported)
-- 
2.54.0


