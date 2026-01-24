Return-Path: <dmaengine+bounces-8467-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x4nIG14ydGmm3AAAu9opvQ
	(envelope-from <dmaengine+bounces-8467-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:45:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C52987C3CB
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3206A300F16C
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA061668;
	Sat, 24 Jan 2026 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4XckxWm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB140125D0
	for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769222746; cv=none; b=njDIloto7OAqCPBISnM+Ha7/FfFJjmRGRLcWjv9D+XE/z0swUzMYe+Llg+6iZ9g7R6oPWgCceArbr4pRmVdlgofbA+B3Cc/j6hcQro4+1enNCkeUwkAukfe75Sai950oPH7e5pZc6DGE1H75E+iVd1VImx+O8LklXr6dVhkB6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769222746; c=relaxed/simple;
	bh=fcjXigb/a1QuXaDLuXhkexaihtngl+SVF24juKbNvMw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kGKg181gNzWy8YmvXYrJQQuYG9bZkHZcTi2KSpgnNj7kPd18GXllzKyHkwBvI+NY+hkXM/NvauAVe4pol1Pp/l5/t8EFoNCQroNXj5UMZGZUnozQBMefpIo3h0ai9FReB3FJIALK5Ht2T6Tr4upKjJnlbZg/hp5Udljs21rsr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4XckxWm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1087372a12.3
        for <dmaengine@vger.kernel.org>; Fri, 23 Jan 2026 18:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769222744; x=1769827544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoVOB9eiRTspm8eBznoz6GBE8y3/j7/oXWvjeJMKNuI=;
        b=m4XckxWmcEio7Cwnu4gH96UcimqDsk0hpf7HAVjAeedNxYtxJc7WFSkoQOEj3ktNs2
         760bYQy/osxiyEkEusIQlEMkK8o0Sorfg5z5Iil9fJP4rltQvFaeLmHJB2AY/Pcj3PuV
         IquyMxlpaqOzv+aPTN8kOn1WtdmDUNJUcP4mDSAfs2A6teuiLiETtgGrntDjEW0Jrh6M
         2EIYs3iGItsgXeIQcC2FuBpZ6BZarwDdKzFbkIBZYkl6MIPWrTMunfCtaq1vCvnuug8t
         vQjCY0IuWfgZgtrGoNHR6CEW+Vsf1Z87lleGXavkpJFcn/t1O1ffRllZthXaagMjNu23
         539w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769222744; x=1769827544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoVOB9eiRTspm8eBznoz6GBE8y3/j7/oXWvjeJMKNuI=;
        b=t+Je8h+EIQCnLa8SCZXBpLPOeUeV9fAz5Nq4N0VxWUHZ+s93Ncw+Y+Cxqgo1jjwc1M
         v5+3c3Quf20O8IRW1UCbWT+DVDf15aAPL4/nsf8ihxHWO6kKwfxIr8pu5ZG0M6JiysYn
         eBu+DuOgThkeL+2otkaCstOxTrcFDUjWK5AEl7iwAj9suwS3yiovZLSn8ENrAPuYskD8
         Az7EaaCfkMY/Ix16o41P5KS2pKTrD08YCKYpKy7C3i/OO6Rb4Y03XaDSUVWmW5E2AOvr
         e2lRHQh0VQ8a2Cyag9pCjyqdqooeVzwsRkbi/bZedYcKQRWms88hzzJkpPm5WBmHBI+u
         BJXw==
X-Forwarded-Encrypted: i=1; AJvYcCXwZXoNstqi1jAoPhhj18cSUBlgWDSqS4AFlobEHeWCTJnXV81wtX1yBmbELgPd/AqMofNqk4FytkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxR4c4qwZOmA9roo8NdISuBmusXb6b6EMOGL5uYLtaEInMMFu
	IUIH5UtvRM+o9uN1C0KS31+/XzPv+4BVdyYEq2EZBSpn3WkRx+9Zk4SZ
X-Gm-Gg: AZuq6aKoZ0jdkhP6XAJ+WVywlFMrQ9+Wj1+KNQR7I9D68cpSuzMGnRmLA8hHW6BoDFI
	i0qc4cil8BHhdREiYqTUQavu+WnvS/0RL4Gh0Lm1Kd+mEqVmSssTo6QXNXYf8q+RGOAoMePIDl+
	06gTevQ8F5mv5N8Z3N2Z1QcVoVqTBwuufGE2Rhlnxv0w5gc2RPnq6ZgO6RkMQVOXSodVh1v+hkx
	k0pRGH66phhrkYxR3WhpC6B0fsrpbiIQM3axsGwRe3EgdBD3VmZmcZZ3YrKiHX62G7XH6/0nBJm
	It4wO7yS5asMgesXeuXrGTbZs8BVR2zylieovAu7uCR283VkIWROIpn0KTEFD5+bXRVdtET0Dfr
	You/oKXJCl2jD3PXWJ9pFCjwx3wu9rElQQpU/0fAmzjfjvUpUPfksjgiv3Ok7TybhVfCQcwOSl5
	kXoox0C6Y3i/j7ZPlgHjUgjhIciLdPA824rV5bZtTzizED2g==
X-Received: by 2002:a17:90b:1f88:b0:34a:a1c1:90a0 with SMTP id 98e67ed59e1d1-353689506ffmr4031378a91.28.1769222744123;
        Fri, 23 Jan 2026 18:45:44 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318644989sm3279598b3a.13.2026.01.23.18.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 18:45:43 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v3 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
Date: Sat, 24 Jan 2026 10:45:36 +0800
Message-ID: <20260124024539.21110-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8467-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C52987C3CB
X-Rspamd-Action: no action

This series contains a single patch that fixes minor coding style
issues in the Synopsys DesignWare AXI DMA Controller platform driver.

The changes are purely cosmetic:
- Adjust indentation of function arguments and debug messages
- Remove an unnecessary `return;` statement
- Add a blank line for readability between functions

These updates improve code readability and maintain consistency with
kernel coding style guidelines. No functional changes are introduced.

---
Notes:
This patch series is applied on dmaengine maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

Changes in v3:
	- Split into smaller patches based on warning type
Changes in v2:
	- Rebase on top of newer merge commit
v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
Khairul Anuar Romli (3):
  dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
  dmaengine: dw-axi-dmac: Add blank line after function
  dmaengine: dw-axi-dmac: Remove not useful void return function
    statements

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.0


