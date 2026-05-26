Return-Path: <dmaengine+bounces-10965-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLJXO5D/FWozgwcAu9opvQ
	(envelope-from <dmaengine+bounces-10965-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:16:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7465DC42A
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C064E3016C40
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841373BA22C;
	Tue, 26 May 2026 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUdFhHFj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920339732C
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826574; cv=none; b=LCItg/ehE07j+DHEV8Fy75ZrDp6BS1PDAaz/rngb+Zpp1+e2j79G9hVgnR1EkeArHSK2CtzL0TLGOaHhH6T5wtENCJnzyOMqy11m0hy56oQNk69KIT2WxcjMqixDPfSFOCZ9EPxDxCHvMQgYboUlR0Vg2haCt0oWmiv8HSki8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826574; c=relaxed/simple;
	bh=MzyTjID+CWb/MWHklcG9BXLprF41TsBCJfGI/gConv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmGLAeCReFRt5k/weTurST/bILcSQUG9AZ/8tCPHDSaAwBvV8ijl2xSR3DsIbOrzpsw9kTPA0xuulqpNitoFpP3QWu+Ea99yjiT721NPC6qLXTYmQsVjIR+Y/pdjXaNL8YJSU94T1MDB+OGVslMwoc/FDnD91Ctigrtm+sK1RHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUdFhHFj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e63771d91so102984981cf.0
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779826571; x=1780431371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku/vxDrBu7T4TGqb3O0QJz0UZRxcqf3H+SXkaiCq2AE=;
        b=DUdFhHFjDGpUyuPlF6VKN9qOXlnBqBa5NcLWJYlFCJQvdunvi5c+10MSDkhGmAgLbW
         X6GpIfNvVRyp+axHvrfnglG1hldkExhYeweu3sRk4UBhPnESfg+gAm90KVVGblKXCTUC
         QWFf3zFbo/HJKBNIqNG6oEt63cb+aJTa3WceVVx/YHT2y1jJcdAFXfajAFPQ+GsI7SJ/
         b5ortALFpnIRsjANgkkAMvERXVHnhkaqDWSQ4OyopTY/CTOsI0bTZa2CqdNrA+4tZNJ0
         zi6K8+37j1eJ8lO73W9bvfRQdDwuoXzunpuldv71/w5Td0nLIaxkshDG/ailnSYIl4BO
         w3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779826571; x=1780431371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku/vxDrBu7T4TGqb3O0QJz0UZRxcqf3H+SXkaiCq2AE=;
        b=Mfj4pB1ZxDdAbmvX8hZrTojJzEQzuTbVmMc84DA7YWqMOgIp5GxD/681pH9Re+OZxX
         WsB267io0aFEOlJ0TXQr4jADGCpHP8kjGvBgSVbneUuTCZxjLZ7wBBIFTzYAAWPn360h
         PHzznw/3vIX+p+V4e+HcEdMn20NXYm9iwFq0pSGzp2AUezzBFa1mgNZjJUesVjNkhjtT
         89CW8cndDns1DLpF9yepjHASIOeRt6acMhjTkPW+RTpXJqpSoxng3lXgMIlY0I9XWvTb
         OupPPW4s/fuM0N+oiLBRG5rVvALfH6gAyayftUSB6vZhewApy0b6ila3nHmbdWi45h+6
         15gw==
X-Gm-Message-State: AOJu0YxZooz9mgN/Gd47UpebzYudZnqNshskfVkvy2z32kwD+x1VfSg3
	qUSUxmKAsWSNukWdi+ZhZCgAxuE0TK+kka8u2eqg0OYQtaVeQ7PRv54g584POD9o
X-Gm-Gg: Acq92OH1+HtpzRrYQk6W7QIUPD8x+2ZTIc94GtXUvR8WloEa+E6TWhZyZ3hKk42sF0e
	zEiKjmyBd0d6PtRMRpvM3MHTxVMpg5rINvjjZpmmKw6ZP+upNsxJAqrDpZ8T+ueyKQ2uwqVq7NF
	uUMvHJc2MbHi4Sp7P6zSkGMhb6Mr/jwHaiT2gLF75hvwBtiBzPiFo0W1Seh8OklEnoUqTBvNrxn
	kcq9MjS9Rul2Gd1AgKukwakEapi8xO1cz6TlUmKAnQKbdfFE6copmnNZj59pQ9LnY56coSzl0UX
	3hGfFZItalzK5jWx13dhehjGs4RsLE2ZxNKBbbU4yw17FFeRLwdxVyQc+OFz4OcjJv1oXcX/Ph2
	b5u4mho3mpIB9FGVp4bCOaWjVF1r6L/cm9Ykr1+NiTykk9nPn0TieLE7nlGy7HaM1mqekfjsTG/
	wWAO/Rbye9HtLNj8MKI1v6SnxiWUc5hRXT96U/uDTbk1pj6MVQFS5L8nIonE3IM46A3F1Ql/bLZ
	z8TUbhyQshg+NWRma6J+1iwt6EQlrADtYoLMf54oV60kA==
X-Received: by 2002:a05:622a:4a09:b0:50f:bd79:2642 with SMTP id d75a77b69052e-516d463bd85mr282690521cf.48.1779826571221;
        Tue, 26 May 2026 13:16:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc9cfsm25433541cf.19.2026.05.26.13.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:16:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array
Date: Tue, 26 May 2026 13:15:52 -0700
Message-ID: <20260526201552.13376-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-10965-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F7465DC42A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the separately-offset phy_chans pointer to a C99 flexible array
member at the end of struct d40_base, and switch the allocation to
struct_size(). The log_chans and memcpy_chans slots continue to live
in the same allocation immediately after phy_chans, indexed via
base->log_chans. This removes the hand-rolled pointer fixup that
recomputed phy_chans from base + ALIGN(sizeof(struct d40_base), 4).

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ste_dma40.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9b803c0aec25..d3e3c4cd43f1 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -602,7 +602,6 @@ struct d40_base {
 	struct dma_device		  dma_both;
 	struct dma_device		  dma_slave;
 	struct dma_device		  dma_memcpy;
-	struct d40_chan			 *phy_chans;
 	struct d40_chan			 *log_chans;
 	struct d40_chan			**lookup_log_chans;
 	struct d40_chan			**lookup_phy_chans;
@@ -621,6 +620,7 @@ struct d40_base {
 	u32				 *regs_interrupt;
 	u16				  gcc_pwr_off_mask;
 	struct d40_gen_dmac		  gen_dmac;
+	struct d40_chan			 phy_chans[];
 };
 
 static struct device *chan2dev(struct d40_chan *d40c)
@@ -3128,6 +3128,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	struct clk *clk;
 	void __iomem *virtbase;
 	struct d40_base *base;
+	size_t alloc_size;
 	int num_log_chans;
 	int num_phy_chans;
 	int num_memcpy_chans;
@@ -3197,10 +3198,9 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 		 "hardware rev: %d with %d physical and %d logical channels\n",
 		 rev, num_phy_chans, num_log_chans);
 
-	base = devm_kzalloc(dev,
-		ALIGN(sizeof(struct d40_base), 4) +
-		(num_phy_chans + num_log_chans + num_memcpy_chans) *
-		sizeof(struct d40_chan), GFP_KERNEL);
+	alloc_size = struct_size(base, phy_chans, num_phy_chans);
+	alloc_size += sizeof(*base->log_chans) * (num_log_chans + num_memcpy_chans);
+	base = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
 
 	if (!base)
 		return -ENOMEM;
@@ -3213,7 +3213,6 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	base->virtbase = virtbase;
 	base->plat_data = plat_data;
 	base->dev = dev;
-	base->phy_chans = ((void *)base) + ALIGN(sizeof(struct d40_base), 4);
 	base->log_chans = &base->phy_chans[num_phy_chans];
 
 	if (base->plat_data->num_of_phy_chans == 14) {
-- 
2.54.0


