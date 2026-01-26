Return-Path: <dmaengine+bounces-8497-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHZmCeJDd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8497-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:37:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9687170
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B608630074BF
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1B330D23;
	Mon, 26 Jan 2026 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBFldPUZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35AE330B36
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423825; cv=none; b=tY/uWSGgLwmfulJXd9d1xrRFYIg8b4Qzu2vJE2M53M4maGOVX8lkOu0ROUNPvsthI++cuBK/0UeoA54RRthbtmbPvLCk+Ht6+rfhT+ZM8QUB8BEQDnO/BWurt9g8eLjGrX8ELkm4argXtYQo6UEWIQxMIcZEf33rMeIjGrAuMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423825; c=relaxed/simple;
	bh=FU7QAs6lDJjAWOxIjthlXDhH5MBnDGtaT0tPJgdxXKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkDNm+3O804QpOoaz3VVzPnTcDutVZaWKX8ztZepnoILo8m4HgYRHanZyDff3aJm2nFkP4WCPT0rBVOPtzpydF/6TnxQts2shScJSLLZZx1qaQ7X9yAB8AmA1GGDNH5xfaf0ZG8EZjajpVHwA9c5AUSiMXd+7DnD43rMFFRim9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBFldPUZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c635559e1c3so1298899a12.0
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769423823; x=1770028623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Em6gJCSvT52gjQNIp5QkjF2867CaDAQz1SVWOT21vA=;
        b=SBFldPUZnDfb8zz9d/rkZ/BBScPRM/BJ2DZ4stzOeSNLCJpUNcxWO+a0W88saMk8OL
         hi/1rRxzNx1FC0XHS2NtqSwrhI0oZmnHnSXgS/G5WRlhUfcta7sKF+A3Ecpb+NXULd3z
         N7pt7wo0ePNpg/z7E6qZcWfwkvt6y0LFnpADQ13W6O6JUBRd/yTA/AKdcnroV80A2aTR
         CG6gC6O7uYpy65ctI5k/CsKVI8K2uV/cUJG9mZqtsjDAFyCKnGgQsBMoICuxM9q1KkBe
         cDEuxQ9iKmOfQBkBU0JfbAqu7D9C6Eip2637EPrQZvLrHkWCV3Cj/ah0cjwwarg46Lv7
         0q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423823; x=1770028623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Em6gJCSvT52gjQNIp5QkjF2867CaDAQz1SVWOT21vA=;
        b=O0WYCuMUv6ecH96NCyAWj8h/wr19fEOlOtUzkbjre/HoNnK6kbtASTA5oU0yIvCv4d
         MGHKqN+Lzw8xC+hNxj1JXzKpIe6yzM0JyUZPpzvYxR+VzBz16E5NEzeqrIbrPNXF8EXm
         oGaSzsVup+FC6epzO+DnhhHBsKpxTAZDiFTZmOvkksAZ0dYl0Ugq5W9aLiPhpJ3ch06S
         za/4PgD4m8cZ6IcQpaEtKn8Y/y857KxtD28xp4wfbX3jOXXcVbTR3bIbrGBTbJoSNuyf
         B8D/mFD4eCsBltU+lPBsIEcyt6LXDXNBn+T4USaCWvH+fRyNoeQ+zA/8+qMsaZkbSWnP
         ZcBw==
X-Forwarded-Encrypted: i=1; AJvYcCW3fC2kzou3bxTzJUHkG4LkxjcjPuo9DTIks5oIhMgsqx7TVnK4BXdxs8UQIRsUJQf9Abs/RB4fuNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZnOa+lRIuFCI32IythvDWIfR4h3biR18o0ICNJJz9VKk76e/
	al6oTRK+rR4IuL+pzWKNpj6uexh5nXcz66/skzklJsymJx6RUkkn6JzF
X-Gm-Gg: AZuq6aJqX9oKSGJvyoMyHdaGQ/SwNx5zo3L5ewsAcNfi98RTMknE8NQcU4CFP2sSNDx
	Sl8sgr/4GffdsQjqWvi2YnxSJYjl+j+I9N+/ld8FGZfUYyVrpT6zGxVBh/62+sDU+5gELqO728x
	ctWYlLVu/uzEpym0J2keEu6wdFbLo0CUqDgg9DVu4wcLK8CNxqbru5qeKKgU0lrvHhVUtqz8VgK
	FkkprpAxP8Qya3VK1xobRSN3aldP34iLjbbq/qLS4lDC2RBFBMuUraPWjlWTC2X2aRXcWpfEFhI
	ULzx8vFuwg9MumdknrNCxIFgGyZ5lDKF/NwQKdEL1re/uIhNjyeIfJbdOilabskkCEZTXz/dtZl
	UTIzmxRqbSV26/qCVBddY09yGZdbQvC3l8aDzV8TiCEhi2hQo4vtxPsvUHT5gTmWOGv+E0zdNO2
	P/wFT0hFVWycarjHSHu8iyEuCmm8QpyAYlDqJ44gkjZi4+/A==
X-Received: by 2002:a17:903:4b30:b0:2a7:90f2:2ded with SMTP id d9443c01a7336-2a845589033mr40116825ad.16.1769423823207;
        Mon, 26 Jan 2026 02:37:03 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f9762esm86827545ad.55.2026.01.26.02.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:37:02 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v5 2/3] dmaengine: dw-axi-dmac: Add blank line after function
Date: Mon, 26 Jan 2026 18:36:31 +0800
Message-ID: <20260126103652.5033-3-karom.9560@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8497-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C4B9687170
X-Rspamd-Action: no action

Resolved checkpatch.pl --strict warning by inserting a blank line after
declaration.

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8bb97fb8fd4c..e59725376f8e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -419,6 +419,7 @@ static void dw_axi_dma_set_byte_halfword(struct axi_dma_chan *chan, bool set)
 
 	iowrite32(val, chan->chip->apb_regs + offset);
 }
+
 /* Called in chan locked context */
 static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
-- 
2.43.0


