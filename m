Return-Path: <dmaengine+bounces-10667-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDnYOkkqD2q3HQYAu9opvQ
	(envelope-from <dmaengine+bounces-10667-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:52:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52D5A8AF1
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D85731D2DC2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8E227A47F;
	Thu, 21 May 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEGTSSJV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D7264617
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374881; cv=none; b=ePOXQaR3sTaF+SB/otVQH0sx1hC1KcGIofX2OVUbsapsqg9Nsc3icwrNgIxvv3OxvBjRtVSAOMgBjoJ3BDRTCJKWsk5VON8LX5RWXxvnLbKG9tv19GZg+8ah8oD4XcUhxTptU1+3WgvfU8bTP0oORBBzuNQEzyPds1ZJcaaaUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374881; c=relaxed/simple;
	bh=WLhHq04fBXG0DNoal9+1yxqpgRYusFLymvrxnQKKfK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WH/PYEY9L4tF/l4viCWzp67p11GdGP+paVj1nHDOTbb/1ofR+y2ZYoEjjrh5AtH/xq8Gvjhv5V+2QlNaPAwMqT1VGuLHjF9Cy55ns0A4ITfJkgkhaXpT3F1VosuVtLlw0nUW4OtMKvPdBwpAp3fXYV8/mdmkT+qx0aLbqXmjSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEGTSSJV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366be8040a9so2624644a91.3
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374880; x=1779979680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nO5Guq8P5pYUyNX9rihjVTq3LCCfxDcguL6lLRydU30=;
        b=BEGTSSJV4c3sQc1QF87dxrc+5R3Kf2zaAiVFkNpx6A8jikBnaMaKgAG64v+qH0bmpf
         +FrFo1j2GlPGtrfYBXFXsi/NwGv9zMVE2G6aS6D/w3pjgq6rvoDgOyeuprEtg9jK1I9h
         sh5TbXbBT0fZfJ73BGDUCuw6v04RS8f6nrkO1ke+BUxUWF+Fd8S0beJ0u3B/M01Dpqvc
         xBwMqIvSPp97ci4U8R3ejrCmBie4/uxbD3pznKIzZYSKnv0zwbbuX7z5+ojxhYhtQvsq
         BJ6Q4MFzB/bDHteMAamTY8+Wn11xBOzCndHbQ55+a1RHFd4sQavmGNx+ulqjpKanMoWt
         AC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374880; x=1779979680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO5Guq8P5pYUyNX9rihjVTq3LCCfxDcguL6lLRydU30=;
        b=pKggTVDSXuiRODydJVATeONBtPQAlDIt600F+BljQ2CPtjrtJD0xLXaAj6inrYmGqF
         sKXLbmAbtJ44i9xLiuVY1jRcI25vW0hSVtm5ZkBOJ30VDSDHegzUNrhDU8+KBguowBFh
         zwhegi2cuNjc6j8C5b5dPjPEV2OMZx/O7ff3t2zxdqPbb9Biyop89qQiRsyY2Hn1oz/9
         PEZPVXqBizGmcMrx9Iv9gHTCea3reJGZjcQV7/QshXGRG9qJSUsrdmDno6mDB8nf5ApP
         MyzM5t2Hj51Qq7qfQA2Rruk7+Hcg+eU8Gp8O7t/93OIGLrosEKX2qoSvu8P4MNrmuucx
         h4sA==
X-Forwarded-Encrypted: i=1; AFNElJ8nZ4RMiVhCiIUkRpXrsQfTqs9XmO+RVXdKuDibfpypKkWdz3eHGDsbvIjfhHanHvzNDBIbf1T5GTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Drjpx2RSODAE5T1QqEcBcYvAD9t6kWByBC0GlGGrwptg05Kg
	g2aHKzgJlXHTyG1l+1WwrRGQbtj3NiqVN8ICN5hNv1Ys9o4OKCniqjyg
X-Gm-Gg: Acq92OFjg93HpSeo2+EYDhw2PsC7iLxQAy5YdmpZK1BpDwWoFje42fd4DsFIg63k+8z
	j6k8ykR6YR/nYCX4C15Kcr5QaZq5+NTcH8AB3lD2cU+Fn3KW+vlqSexpHAUBEyHtH7XCf70p/DH
	gScwN1TjXEEsrzQEUCAWsiv0SBU5DpiFt3mQe/mwLvReLoECDbeq4MTTKJi1qpawiErZxeaac93
	tns5kXidY8hAGBP9huGzz2OtIptRlxJ7pz2L4wZku04Jwq1/nXs9vF0Kr+z2rqLOg8aAA07DYrh
	8BlExUje2p44M5fLQJyCAzaFXW+6RUMRl3IoIdxypwvj++vZrtzTDeT1EWHQQKfxx1Bl3YEbSMn
	xX3nXtayc2mIv/WTgaAzfOuyDgxIXQO1wOmNjHlkVZhsQw926DCdwht9RvE6aByf41VBY3Tg75t
	ytYub2Qapgi+wjBACjLuwFP+0hJLpf9Pskh/nyyUHG3CmC+Dgw
X-Received: by 2002:a17:90b:2c8d:b0:366:4782:1375 with SMTP id 98e67ed59e1d1-36a45658e79mr3220163a91.22.1779374879710;
        Thu, 21 May 2026 07:47:59 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc5643dsm3773472a91.7.2026.05.21.07.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:47:59 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] dmaengine: fix dead empty checks in mpc512x and rz-dmac
Date: Thu, 21 May 2026 22:47:53 +0800
Message-Id: <20260521144755.3476353-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10667-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E52D5A8AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two dmaengine drivers use list_first_entry() and then test the
returned pointer against NULL. list_first_entry() never returns
NULL, so the NULL check is dead code. The author intent at both
sites was clear from the existing recovery path. Switch to
list_first_entry_or_null() so the existing NULL path runs.

The two sites were raised in an inquiry on 2026-05-20. Frank Li
confirmed and asked for a patch.

Maoyi Xie (2):
  dmaengine: mpc512x: fix dead empty check in mpc_dma_prep_slave_sg()
  dmaengine: rz-dmac: fix dead empty check in rz_dmac_chan_get_residue()

 drivers/dma/mpc512x_dma.c | 4 ++--
 drivers/dma/sh/rz-dmac.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--
2.34.1

