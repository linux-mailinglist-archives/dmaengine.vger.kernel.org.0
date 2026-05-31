Return-Path: <dmaengine+bounces-11063-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGYnCZGXG2rvEQkAu9opvQ
	(envelope-from <dmaengine+bounces-11063-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:06:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B46761433F
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E966300B9EB
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEFD360EC5;
	Sun, 31 May 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asR50VCV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA33148BB
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193158; cv=none; b=XsmPsPaJDGhaos434wuJm22aGaqil9kA+KKFIVyGWNvUmaAODt/9dd19nkLIBYB9Eg/3Z8O+nplxiCTubgMu9dtLCu9UxMCkkOIg7l7mv/gAm9gqgA2k4IEbwhSerTP8wyES3eL4GUlwTitkLrlV2FUDYIsQSYrjoRSQqdeDaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193158; c=relaxed/simple;
	bh=2Hl/t126UT2ARfsqNAQ7uSYn4K26LckazbqfBd4LIAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWDzKILOyND9LQ50KdIDtVaFJ9vI35yvP3WaI4rmx1W4ifP0oN99JkAzGgPyNLC9L7U5um9sCT5lFsYFgHJZ9iVJKHpVrtFpnyL1CXB8Kv99QBE12+mA2CZtYHhlmEZiZhsN559HXAu12X/tbgH5t7WIaxtypAdroW2e5gSAnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asR50VCV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914c1ced558so457566785a.3
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 19:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780193155; x=1780797955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlfQ+qYVuJAI6IXrv6eZVrFU8dqWYnOZvMFjlXkYQGc=;
        b=asR50VCV/k0yq5qlzSlzcrSspp8SlHzGzDDLnKSyot7lo9ksx+GWJH3sQYTZfeOAUH
         w0MID80nJrZUtpSjYlqPrjTNx3jc8V8o6iEETpgeT70D2fs9763Kt8B22S5+XDvVHH2F
         ldwF/s0pQdlmJwNU3rXRe4f+P3Noyepx9oUWLC9hFujxeJ2S/UJIXuo3IlXH61wG/4tV
         sM8YCPgSl/Va3Pdt2jgxRqPfQN2ZmT8ZVcgwOE8DhlNgFqb1jgar9fQwHiM17xGfqTAp
         WgWp5DhKOAiXXFPpD6Ja9h4dSb7P6rBL1o7FT3tsKOB6alQ7dNfVE1NT728DonmHBFfk
         ebEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780193155; x=1780797955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlfQ+qYVuJAI6IXrv6eZVrFU8dqWYnOZvMFjlXkYQGc=;
        b=ee1HHqD3j/ck/azwtt7Kmv5bBLt3kLRcvAlQlzpiXPY8Hm9jVOWtSxozPeSIZtoa7r
         04eG3cnztr6Rv8aHfQujttA66ohqNtFlVMiX4kDllDpLg/C6SvcuW6HdZQhi8ejMKmDv
         6bMD1HZa+JtSK9wChuu/v9wniAZSrgM8bzXYc1fBxUB2erlRSYGw4N2C2RA37qBrh71A
         CQUY3apl5/pCj3kvLIK4pnkdp8tsL3L58NCKA0giW0IcWSkJaUUrlY8/aYm4IjE2Cq4i
         uprTx3YJnbymbkV2QQDNz5PL3UlihlIV54K1Ph3ab7YxomfmgwrJbworK77tz3YbLXIa
         l7ng==
X-Gm-Message-State: AOJu0YxabZfLpkOc1RA3kA7CHSIF2NwUGXpjlWGaAGXl9ixA74MgdZPZ
	HkpHbu7deOl2WRXh6dK8SaelNxoeHYY6R1ZEPDBJg6wg9G6vvD3uztASM32jkNfw
X-Gm-Gg: Acq92OGAfFNJJTDrDAYmYQO/oTc8XaUEs2ZxGVw8E6EBBRrhMw6Lz1Yr0QXKG0Hc6/N
	DSuPD6cIZIqkHTuVe83ZmyYjhTpF9oR7TTPKa0wO+3/bNJaIcB6PBHZ2F7nEFq4UFgvj0gI1dfX
	pZye7jYp0/z0RjCmWuEsEpis51Cx8Rx0nIzVAdgJXTBdBwvkJJyORiUJJ93TucDX2UZkQOvDF0L
	oV78DHedLWLgWD6jod7bRDbWnNo1gmDm/qOEnBk7WT/VI65Or/Il3rBKgmmC3E4km/3J8RjrbWM
	V4YGmQTmvHv0ZrpoZbkWdF12ANxftk2EooP4QrERcfnDEo2Bc7dFOm9OfTyYCd2bd+wGMVfRsWp
	xaVsinWuV3D2bK3adlcBqeEQNVfmnS/8brEb+CN2s4aeQAQXmjilKGqhgWZIp81fS+NbwCjms9C
	5DDQFzI7woNbH8u29tuXCy7IThIT7zLfeqdp0aDxRGcOHSWXzyTl+T1v+ZIgqKIwLSl55U06WjM
	U+JawutN60vlnffosLeYcHnExCbANRLf8sQSSy+cdJNvQ==
X-Received: by 2002:a05:620a:8088:b0:914:ca7f:6a02 with SMTP id af79cd13be357-9153db742d0mr911657185a.58.1780193154804;
        Sat, 30 May 2026 19:05:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324745cfsm620246285a.12.2026.05.30.19.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 19:05:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] dmaengine: ti: omap-dma: various bug fixes
Date: Sat, 30 May 2026 19:05:31 -0700
Message-ID: <20260531020535.594460-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11063-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 1B46761433F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes four bugs in the TI OMAP DMA driver:

 - Patch 1: add missing return statement in the probe error path
 - Patch 2: fix a notifier leak in remove
 - Patch 3: fix dma_pool_destroy being called before omap_dma_free
 - Patch 4: fix interrupt handling in the remove path

Rosen Penev (4):
  dmaengine: ti: omap-dma: fix missing return in probe error path
  dmaengine: ti: omap-dma: fix notifier leak in remove
  dmaengine: ti: omap-dma: fix dma_pool_destroy before omap_dma_free in
    error paths
  dmaengine: ti: omap-dma: fix interrupt handling in remove

 drivers/dma/ti/omap-dma.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.54.0


