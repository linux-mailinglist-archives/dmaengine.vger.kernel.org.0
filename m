Return-Path: <dmaengine+bounces-8469-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cl3HmcydGmm3AAAu9opvQ
	(envelope-from <dmaengine+bounces-8469-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:45:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C5D7C3D9
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D27F3006681
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 02:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F083223DFB;
	Sat, 24 Jan 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKvEMG/q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1561668
	for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769222750; cv=none; b=oyVAvxToMBkRiN4V9IklXMQ2HPLwGQAZ8ODZoA/S4So+UN0aPbEwnRE9nkSwbXhO105BQ25LcSzgwIpw5DTZ4YRZV9gHFh/kge5iJfrvFpxxQPFBfC64xRhUYvcDtRLlNzTpX50aKGLa0jV6c98U8Z2tLNQfKpe4sMbPehBdP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769222750; c=relaxed/simple;
	bh=6qNe7alfoLaNkb6A2ucPP3PR2IONBpr3FT69Eohp1pU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4f0YzNIxFQ6MzdfDoKwVpawIlYZhBpcXkOtYdAI/0yARpx0dT7U+RrSA7LZSvRRDlqKGOMhJm4c1V2A8F3eYezoorrKJQ9oekPyOjDIt79lcBoFGXmoaUXzV65nVcBPWHtdbTAlfM8EpkzdsLilKWgs3JJThPDmVhZSOAML8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKvEMG/q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823075fed75so1520086b3a.1
        for <dmaengine@vger.kernel.org>; Fri, 23 Jan 2026 18:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769222749; x=1769827549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdDjbq1xjg18vF2UkMDVffVrXUmHaDZL8tdcqunWuEo=;
        b=SKvEMG/qYj93lrUdq93HkHGwg6EU/fBE4AdoAWdcUlFgjJiF2MYOrYbNXpp5ubPUvm
         I/FFu/orvS5vpFLrZYyPYBp4iAA/Cl/2cKHRP2P+7wPg52NQEJ0tJ8PBeJ5CcJwIGNjv
         Rajaaz1PLobqHC1gDDXPE4oJvrLlrVDUm6H7mI+ln+8jaBdEwJYBJdSAndHpmZrHWW+C
         woHXSmC66QSdpAlHYwNwWGwwyq+Op3ZRyQKqYu7urqu47IFkQIDnazUu17ygdRiqiJgU
         hmsW+cJgCFiQ3H+moUz84SibpG6IzGRtjVhckET31pT/yVRgKkFFR3bCqERD1H7QLpGM
         UX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769222749; x=1769827549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OdDjbq1xjg18vF2UkMDVffVrXUmHaDZL8tdcqunWuEo=;
        b=R9hzXzxfbSmBFAiZTuhwDiZDVxyBqzXOgjCLBg9iY1g9TdlLWbuk4OkmNPopCYZxZm
         1LWLp2UCV9TAgGf2bkKgT7RqJqxDYhY1pfVQTcmny/+sjU6A9XNg8vJORkVeCMltA8Ly
         oRfQNCq6cI4RH3I6wpSLA1vhFluihzNsnXAhA4Mt5zGs59vpvOk/WM21oKr+kRm7qheh
         qdaUMbN7UUdFYP5NNY4NG4hKP/dO1nUNGTBBYVF+ni2ao02XW/XKb3mqbG7JOT+COj3B
         GQnvHhNJq+f4THPURpon0zr5XeARHP9G5OuAPBY/4uLQJaTP3K9VN8RVmcC6F1mjN/ev
         V87g==
X-Forwarded-Encrypted: i=1; AJvYcCXYQeHNeVejUdmKmPOWHUQE/Fxugbg7VstR3zmNjMjxuXitI8mUZLJCxeHm2KsLTI6qbVFnyW2BXkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3+XaxbTONAm2qE2wDK2WwYznK5v7kmVqh4wTMEdnfCku9SsJ
	7aRW60i5oL59Jo6MgcG35oLwL6s92AWUSKCUGWEBMRNJF0VcGMfwEZWp
X-Gm-Gg: AZuq6aKk5TGXrNGgn+M2M10GnLgFPUvg102wJcZHrAxQq24KXRPa0ZPLzvSFYDcNfOJ
	J85YkzbAEOWXNl13jeFKvo8RSjejWE7wDdcgeHZz8aV5fchgXAB8gCKnpWCUqpaG76YYXTBtteE
	OKm8F03tswQSugGhLmDvHnMe5tYRnmbnyzNK5VnJCmZf/ntoDZuCAicPjFCxOzrAJfiR9SE07Gi
	AdAxRhDhUZq7zwAU6nzyrqylPkRluzRCkXMUUWcrz2wotMvT+A4sGTrVQGv/L26kIMnXGhTkZzn
	ewToA4ueIz4TivBajG4BZDukAgQN8yUbqqg3UwHY3nBUonTowSJLn2WgKXpSwGjB150mUakNHck
	SZ2TkvBZH1LTGgrXLawuj2N6clIFW2na1+kQQ4W3aijauZqb+8aB68WzXKW9NZaarZP34RYSAHA
	e0f+j7WjC0LynVuxQOINltN/30JNwwLJbtl9oN1Q6zVl6rMg==
X-Received: by 2002:a05:6a00:c91:b0:7e8:3fcb:bc3d with SMTP id d2e1a72fcca58-82317b01bd4mr4645708b3a.18.1769222748554;
        Fri, 23 Jan 2026 18:45:48 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318644989sm3279598b3a.13.2026.01.23.18.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 18:45:48 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v3 2/3] dmaengine: dw-axi-dmac: Add blank line after function
Date: Sat, 24 Jan 2026 10:45:38 +0800
Message-ID: <20260124024539.21110-3-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260124024539.21110-1-karom.9560@gmail.com>
References: <20260124024539.21110-1-karom.9560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8469-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35C5D7C3D9
X-Rspamd-Action: no action

scripts/checkpatch.pl --strict throws
CHECK: Please use a blank line after function/struct/union/enum
declarations:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:422

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
Changes in v3:
	- Split the patch into smaller patches according type
	  of warning.
Changes in v2:
	- rebase on top of 3c8a86ed002a "dmaengine: xilinx: xdma: use
	  sg_nents_for_dma() helper"
	- refactor the commit title

Reference to v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 +
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


