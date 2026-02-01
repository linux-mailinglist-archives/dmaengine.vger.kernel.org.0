Return-Path: <dmaengine+bounces-8641-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE2GEOSYfmltbQIAu9opvQ
	(envelope-from <dmaengine+bounces-8641-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:05:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92CC470F
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF4A3045223
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 00:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8603D6F;
	Sun,  1 Feb 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZOLR2d/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D4CA5A
	for <dmaengine@vger.kernel.org>; Sun,  1 Feb 2026 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904313; cv=none; b=KIQJ+0eYwtyjhhjgKB9cntQcyv6o69GlJnmassgXJFFk5+5aEVnlFKw2w2NCIlLCLeCNcVHz5fj7rux0dvIr4EWFTb5cVusgvf8jJyFaubhidAgIQJJTB3WSlkMZadi4H+JkYj/G42lG0MdljcX6WKMxB50xeevOgqbV+RTflWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904313; c=relaxed/simple;
	bh=FU7QAs6lDJjAWOxIjthlXDhH5MBnDGtaT0tPJgdxXKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+7uTYdtYXM0btP0WO8ClJTzeof7nUpzYRlbzPMmjSuD2tymEpnFjEVmUuMBiY9KRS4RU9hkA9x2I3r6g0xnVQXIqCGgSMniQTfkSM/3WuUreVeUHh9i/llBFQpeKHfqs8oEAl5b9Uqjr+kAo4N5JDpMq6Zi/2hbIT6hx9Tm0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZOLR2d/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3540266d356so2082964a91.0
        for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769904311; x=1770509111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Em6gJCSvT52gjQNIp5QkjF2867CaDAQz1SVWOT21vA=;
        b=LZOLR2d/spg9r5kKQzR9USpKuN5QT2yJPrcW0K1Ri72wa8ZYm1bAEtn1ZhIURJw9Rg
         GjbJv3F5t9lXsJ2lqYUcdjbf5IHcWxMKT6OtMGKkxVz6oDxdmzr1nugng89UGtPWuOlH
         wObDkejj7eiRhb3IE3IEWeITUlMGy1KsCajYJ+6NnHF/Jtuw40Q7ypg5rhG2R9SGtRMq
         WF2rI9jJUY1rl/BKxZiredv3LSrMDrDeAUVY9RePux6KZgnYuPxx0UnoiJT0FgvKaisb
         XZkKrS9s/13zir/ZJn2LCELOOtHx+jjEyOMueqaI5PrdofZ9V+cWTuOsTG2vkuoF80PU
         mSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769904311; x=1770509111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Em6gJCSvT52gjQNIp5QkjF2867CaDAQz1SVWOT21vA=;
        b=K9joqnEWDN5vnobfJe7Vw40nodEGL4SrUW0Dw8AfJYzHzz4LcEGCm0R9uzpN7qp/WJ
         sFK9Dmev4DkT6J5yIXE+NMxZbP1Xo6H6OfYFZdxpXi/ORTeaJa38egO5w4RrMAwO5X6P
         2aIU5nkuuvqoahi5wcv1/Y2cRAr3PivBF0xSvabvbvk05hSYbud8aJQ0poUje8z88EUS
         FhTCjmv7JQJzv112JIwhDYTValj8v8TptKZPi42qjf91JKZmjD4MeoXMc80mU0RMMSZo
         vfurP/BxxEUYzoox/trInGAxLIRIqDXxa4ogc0sRJRB/OsOy5sZFtR8TSyiPYbgZG6mD
         t9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKLL+HHe7r6owvgZtyIgz25YPD6qGa8Svj2zBTACcdxxXmauqg4i7CiPLK0GvlaaA4teky0KvoD6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw57pRxHlKbKthsNhPg4YNgx5uRvanSQgtNYO8NTvTlDmqItBp
	HeN1LSPDPPcLCnqrjkD7LMjKHdjd2NiQa3OLjF/nPvGlmXIb7Z/0uwe3
X-Gm-Gg: AZuq6aItvB548D+CPS90X/RZuI1VOkrVKWht5mP4PPMeMF28Jvfot+dYNk7LZogxIAq
	ofTo7EDEXvEWKnweSLDN/H0MXT0yzmBRbyfEmwQTezp1YR2WZGGf1+26NIgIVRVygw9I/qSyXrr
	CRJHZXgh26oZ8UGVOm9ITY+9z29u6XjJX+bO7OE+lXXMHl6WFEUIvOTIEfHGK5ij4/ElzCAABf2
	qrRXjXBiynyoBFkXjBwnfmuh78jQptkav8nkcRVR6ZGc5oqK7/ifucADtIphI27l3+mR8Lko17U
	O0fNgOkY61w4U+8Drn0eRXrz3PxqRRG/850laxM4xi/x1IG+u7koApH5HBrwy6mLvGVai0Qx1bD
	5t6gE99H5kPvMeRshPt0uLXGs9CD2kjYrnTn4u+j4NYWVERd+jOJQIH1SI3fH9cL7WqiS19/f4U
	2aFrgxnORUaAoSB+tcInMYfTndMB2sJ49Hxx0=
X-Received: by 2002:a17:90b:3fcc:b0:34e:7938:669c with SMTP id 98e67ed59e1d1-3543b3b54fdmr7000883a91.25.1769904311185;
        Sat, 31 Jan 2026 16:05:11 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm10295901a12.26.2026.01.31.16.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 16:05:10 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v6 2/3] dmaengine: dw-axi-dmac: Add blank line after function
Date: Sun,  1 Feb 2026 08:04:51 +0800
Message-ID: <20260201000500.11882-3-karom.9560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8641-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 9F92CC470F
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


