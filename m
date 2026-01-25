Return-Path: <dmaengine+bounces-8475-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BEiGPx3dWnDFQEAu9opvQ
	(envelope-from <dmaengine+bounces-8475-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:55:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A63867F77F
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA4E3020A49
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F501DE8AE;
	Sun, 25 Jan 2026 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyyHXfgT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9DB1C84B8
	for <dmaengine@vger.kernel.org>; Sun, 25 Jan 2026 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769306060; cv=none; b=nZESoIu7K6NSL+sZ/755QVz9ZbkI9Fuwsoel+PClzHMO/QxLIhqPLHb7z3Oze61nONJPsKl8QLszyb7G4z5wzRPGB/zcGgZXb/ZRePLlUGmcFB9CPNIJXmdpJbQ0qvD2Okd/7t/3LzlKMJPVwFNnV5Ey2MmDG72RQALKx4XRx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769306060; c=relaxed/simple;
	bh=ElLVSpOd0QfcKbFjtwV6wieoHBISgJoimGks1OvEVoE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPMYN9FYh9tl4IP8YUCAxh9Ayx2uVxkkQEpmb5vukheN79vMcvh6zNcpZ6yXCircA8YF2/MlIguxNQR5tPgmDc7GQdUdV42nWklY0SYXtc+yQDJXBiFYyUlWLKrAdG1je9BO0X9QTgaX4y5CyNjmw2D7RxP1jujMEB26X0hot1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyyHXfgT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1294714a12.3
        for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 17:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769306058; x=1769910858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Em6gJCSvT52gjQNIp5QkjF2867CaDAQz1SVWOT21vA=;
        b=YyyHXfgTPetjuh/c5UJ0hNZAP6cQroGuwGdiLXk9Cyy4dKgNLXC/t9jvAK2cUEBGR2
         /U3mk4PXQ3TtO8HUQE5/X7n2l9gFyR8K1NVzvg+g3sMRvssKe+3fLbfnuyW0NPJXL/f3
         E5Et5D+3XB1LgbK4A0n1wbfMn+GCfVrUv/6lizne9hNhMyepTMeFz6F3XgiscaQzapDs
         1NtPulig91Mgcv/329DjlA7Fn0S4UYzBdbaMVmhmgFKWXvNWAk3D8CKft139anmGgAwX
         grzA124WyisB1oBBgKtHBJMHV6/C56slec3sLv3Kpii0vFyi3UzYzKTeCwni6zClwIs/
         te7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769306058; x=1769910858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Em6gJCSvT52gjQNIp5QkjF2867CaDAQz1SVWOT21vA=;
        b=ISw3XGfOLttlOfVvtHlVMqpC7D/8SgR4fX/DMKQlnjAxJ5Gwi/E3hyhlpHkhdkmdFv
         oiaxlARG6SIY+jTqlycImHcAFMsrbrqB+ndq7XJ7qByV/iyKtlxYQbshaD90cvyvnFIH
         F/lFg7xTHAWDVaqjNy8QtxSfeQfsJQ7ukNsswhkmq/lkXsOZPKX7If2FovMOry7Odoxy
         GlJzUhmiwgjP1ZatOzCna5AQSICVsF+YtQxCSQY3yJGdyE9K1NNiOF6WZQHZm791u9Ol
         NKrkvOlipp3mTY8YO+ggZziG2VJuvGb3tR8lXG6fVZASIhXGzw9min0uGuc/1XTH4HRc
         TBzg==
X-Forwarded-Encrypted: i=1; AJvYcCVIee7K2bYP3x4r5rjdAhaOZCsM8NRLO0cRJ1El9plRG8n9itOYfHCX3Tl/nDmcEXHoWBVmnZrVObk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUDY/6P8rbAh0XR/giUTHmb2wt5HYRwes++rZB8Yhn4RRZ0J8
	yrixCwDhX22XBpvYY0LOyT97pOa0bNGD7nuVxqksA+oUdnHp5thiEVHe
X-Gm-Gg: AZuq6aLbQn3bxM6Xg3BfoploVJ+77CHrh4BW03RMoeZoEvkC7qrmw76PGKt9awsz18t
	kWDxClBylEoM4VQmEQwQ8qVhOzE95o71Eh1Rd3jVhMNCdovzJjlcdUt0Mj2b+cr06d2fhm/L5TK
	XMo6CqtDLhlze4gfAysBkwZDVOk2Y4UDlEeJV3WV4fgwfUfBM9+ZdxgzFbvWEmmczvyivCEYzLh
	rHvozXfHVddk+HPCTkTvbNyHmTfYAtVA3rSEuHr88A5iEUtoL0OPD62xjmgN45nfqb7nvyEChiX
	J8YQN++jgaeN6YeidD/+OuJ2HpTJmGerP5yS3bk6JVDAn3+9g0V271WpRj0mY1s0yf2yWTA3KLs
	Dx7obgvtaVAyFHlwdstgq968MkHMDUvXBQQr4mIACyVv0m6pIafaLLQzN3yTh2rjrf2cb2E5Nmk
	monvP62HTH2EnuwjN8tV1Cxwp3VUMlnirjHeo=
X-Received: by 2002:a17:90b:568c:b0:340:2a16:94be with SMTP id 98e67ed59e1d1-353c40bdf75mr324701a91.4.1769306058158;
        Sat, 24 Jan 2026 17:54:18 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536b0300fcsm2689584a91.1.2026.01.24.17.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 17:54:17 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v4 2/3] dmaengine: dw-axi-dmac: Add blank line after function
Date: Sun, 25 Jan 2026 09:54:06 +0800
Message-ID: <20260125015407.10544-3-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125015407.10544-1-karom.9560@gmail.com>
References: <20260125015407.10544-1-karom.9560@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8475-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: A63867F77F
X-Rspamd-Action: no action

Resolved checkpatch.pl --strict warning  by inserting a blank line after
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


