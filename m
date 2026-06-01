Return-Path: <dmaengine+bounces-11079-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJnNDYnUHGqUTAkAu9opvQ
	(envelope-from <dmaengine+bounces-11079-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:38:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD9F6187AC
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3928A3026F24
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 00:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44431D798E;
	Mon,  1 Jun 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItnLthEj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F78175A83
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274174; cv=none; b=uYak6VS0CkysdyDtfZDZ85rENCRHaAc8pUtD80XDMf4qvQbPG03HzZVnELcpCFxMx+zu6JbEOoScUvECv8Oqt2j51vOmJJhBzcj+AlvnsC+H7EzKIXO4YwZPzQb1jA28YEY4xhAwIYz7KxmmVEDRlLdGoGsXTtQNq8k/WplXwd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274174; c=relaxed/simple;
	bh=IQfxgm2MWgvf9AN1+HadB8z6n3kjnD8BRuJ/NOZfTVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc8dDaHYyWQq2O6CXcc9fg9c7pqNT+sA2faapBhXBVwO2UORmBrs9wKHnOlNWv9kSwk7Gng4mYH+aqYO1YIJblFbY6LVxF7lQmJhxGmrXwHnXOZCG8xbMikDz20Fw5YVLV5ywHov4EC26dmMxGPZqeHJ2X29AZH4HfRC0n3i5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItnLthEj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf30d530bdso21531235ad.3
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 17:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274173; x=1780878973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev7p7h9heSSNp8XX7uho86JPebrwudJ97FaZXIjk1zc=;
        b=ItnLthEjG6BRR3uZqcEr6OCP+yLHKI8gJQvfXw/GbO1FzwWbQzDoQW74AZiwU5ve1K
         RG4qIlpDRkfUrTv0HddR+fYiqV/fF1UsXa23pwwsJABveVWEQJpO3PpjjUGAQlOnYTmg
         JGHYvoNQeE94S4NAZbmT/zDSAPdkANtp5I9gvPfhg8qL596qVngdMPD5KjCVhiedDy7E
         JE3hxbrjb2scKdJ0W5xmY3KC7IQTMQZdrhMTa8s3Vf0x0jp+x2/B3mYwA6DgsKHAdZaV
         xQ7HwCK8ESWWYes34CJoZ8Wg4C7nD01RibGuls2CscYxz9UEubJTTlAsNZ05MYTIVwl+
         GR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274173; x=1780878973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ev7p7h9heSSNp8XX7uho86JPebrwudJ97FaZXIjk1zc=;
        b=hD6/ov/IKJUqYlD9zLKounUOeHTBFnxPuHZAqA0cdxTmjcIfzObKqI3LPJtj2zVbg6
         48tilj9wsu2nVw1u1ugS18G5w7zp3YXe/oz/HfUGUji27xI7wmNYDWoVRDNP4qziDwP7
         MQGherRGw3eAr2md1Kua101X7dwSjZhbUkn21Rn26Q5xH8BkOkRzanAbIOnNRJQmnovI
         EOrt7rijGFoQZmBVSO8rg39cEf5xICOTnl9NbXXYgs6ttsjgSc8CZ1qSMPt6S0fRWVAN
         27gRDuMF8fh10TZK+WtwRhdh/f1tdBIo/MzxJyI4/cG/K61KJWj6n6NLqA16ahYWD0wH
         9kTg==
X-Gm-Message-State: AOJu0YzoRc0Y7UvIBWDZgZPj2i/l6/1kWZfHdf3elrPrA+x52qQb0F9j
	swLrA0ZpR+8a0kSYqeM5c1Q+NnR4L4YgLEfDjuBWPNpAeSMH8HHSm/sSgcbKdw==
X-Gm-Gg: Acq92OE+dQP1VMd4FSYQHOsb2JZdtdpCnlWxdtCI04fjQazgLu3H+Cx+bwtYU6mVCi1
	Nn995vKcguhN2CLRPilxpNBEKGYujt8b77HDqkkgvs9h+upGggBikQ2xS1DRByEUH5YcNDNkcXg
	2W4+vh47sPoFWQ1W+48HFiLsbIrkcCnATtEOWtF68Ha+XLstisG7a7de1ezL9VPSUQ1My3bWYiQ
	h2JGd/V1Hbu33w4yAv3eNEJatO/Lw8hgV1Re8oUmJqp7tqg/aeD7nWFLcYlXQMoxEItaw5b1Y1d
	blO3AFA3ZBNtnK9aJu6bqWVVHNIFdXWXhuel1WWMPkx6G5sKzWOb4wzblT4E1rYXewnSwce/LpK
	G9TMgtMSR6oe7ZvOSsnUflB6vtJTd1IJ4S/iSzel94au+OT7B+CHBwxH+3lwPjG2rrkljXgg+c+
	llyF1OOZLQOl4nI8yG1CvN0ivDU0NiZUHreJrxTAYl97tGb3TQ7agA7OwQJYtrO3oBtKpx8KayH
	yu2W1fqt/D46L6jrZw2I1iJShM6Dm0JFjdwUR3F6A9B2g==
X-Received: by 2002:a17:902:c942:b0:2be:39bd:8dd8 with SMTP id d9443c01a7336-2bf36841438mr103458605ad.33.1780274172925;
        Sun, 31 May 2026 17:36:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm111929565ad.41.2026.05.31.17.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:36:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/5] dmaengine: ti: omap-dma: fix notifier leak in remove
Date: Sun, 31 May 2026 17:35:50 -0700
Message-ID: <20260601003553.72573-3-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11079-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8BD9F6187AC
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


