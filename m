Return-Path: <dmaengine+bounces-8656-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LcB1Ovk9gGkY5QIAu9opvQ
	(envelope-from <dmaengine+bounces-8656-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:02:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E8C86F2
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C64603008E15
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 06:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12716280335;
	Mon,  2 Feb 2026 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5kQPB3u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADE1A58D
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012151; cv=none; b=kVcSGCJRwAvj/i/mdtUN9+laAxvD+REznxn26uD8VRrrbI2yAbPb7W5//X7i1f1wf1QyL2qSgx2Tv94KOFmpiPQvtCdi71Xzso/qckTxBb0HgffhzfwomhA8plRETJuKhlrxcn3CDBr8Ls6U+mjcdNmTVId66qY+0X/OoeXnUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012151; c=relaxed/simple;
	bh=XcKG05EIplQ/ZD1tcJ0z/cX1en3jUHLrzx1Vqn76jrs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YWM1Z5tWBcKG9LquWk2A+XzgNkNfZjlcv8lVvSjev0s7t9WCOxENOHCAN0FrqelenKYV+k4UU4u5PCXEIJddCwXi7jZR+o3CIfZnAX7dfWcg65k/Tljgp0M05uy8YYseGAydSmkAkIDbpT/I/vtgF8dhoD5Z+cq7bsXEevzTePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5kQPB3u; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c2f335681so2070705a91.1
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 22:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770012149; x=1770616949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GO09mCp5MHqRJ57Thq9GngZEU4mPDO9VDFh/q9/vc4=;
        b=V5kQPB3ujmwCa6LH4heSvs5lopZj1ToayPpNM9HwqmbEjWy1/FsDu3DJV3U/Wf1TeN
         0fnrCHjmF6qZz6sradnIbR8fSskf88qCRWqf9ECMd4QUyF9kOGLRJpcA/LviPfH+6jRj
         dfpRrLkalbonIZI9ScIqnx6cqbW7g7r///YvIcuQD6ykwyXg2jh873HQMIrSuoUP/ki8
         K+9UJu5qcUo+FPJbsSIGZeG0M8nDMA/vEGWhkkBbKxmpQg2QRhDvVhcffymPCKBJsYBZ
         BVMazRDGAV4U8RsPSFuC5G28z5PoL3mO729Kes/ynscCZcWm55dJqnzz1p8gpWHNoaHS
         HY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012149; x=1770616949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GO09mCp5MHqRJ57Thq9GngZEU4mPDO9VDFh/q9/vc4=;
        b=U5vFVxaziyHynfoZoytYjqbVjPD3dWsRaWcGioamuveqr/7Xtd8NakICHcs/briNDW
         xCCJpFnwTsJCEVSH13LOIvgsEscYAHwReghCe92MobgPigY7EN8VNJJIi3FYMeQInyMl
         UcZaF8OLRMbsMds2XA9bV/TUkd0nxtE4Z2mULFDtHwNwXZIzpXCQRMSHXFHOXPpyPGIV
         qurv9Fy8RjjHsgIJUmEfo5vXwSDag4OQoW+V18MU5/J5QVx791jjFDEX73jQALXWOrKh
         cy5CXFc2CPCns7zUkWuFnQxo54ntaG2hkZ3gcPY0ETKdRHxJsNNF6rt0FXK7Iy4oXSpf
         wWLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2g0vgImSTmuU/iC+1MH/p1WvVo/SrJE2kM2fNzX+PBbkmGseD7DxD72kFzSHxhVnaBneoLgp2uvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTmtrWb+SHHvt7Y7NTTwYL3eEaNBAVZ51lxIM4YfZG+FpnJgJ
	zpgRVkO0Z/3icUa/+9jI95W0qSLdYkac8le8ozStMthrYre8DtPJXr2X
X-Gm-Gg: AZuq6aKCLvtBK2x25+GUAqheQZ8ohVOvHdJwwzGK7HUGQvsWgKtEP0w+0KxPkROkhTo
	l3WccGPHfZWUNnaxuM1YP2OJESzIKnAI1oBHHjpszrquFW4crQl7Ul2a1mwg+YOV6pf155mOQCH
	/4YMRurxgQ1Lyf7bTCXEwKpq4gxIwvgbDnopGgv2DAbBTVggHGMaPkMhyK7oKN2fLjraI6lQT3d
	nJ+XqW8kXJRSkzqR7PDH/qDqIpgBfYXkbQPKiuuEN/4WmWsSdt1juOt8SY0eCCl7Amt1o+gaZti
	qQUKebeZJB5y9aP/UHe4AfcPj6JRkuKHa7mds5XhwAWV3aP9AUGPOAoITDMGJybdF9cRGZTg5s4
	aaVFvih7yDPjkLwkGRv1pBp4Serf9Jy+5mKgy6YikV6/6JcOXZXuAK8nbvYUc/SmTSBFH3iwm68
	k8DB4wwz+GCBlj/PNQhCJt1o6Iov0qwaU1IgSn1A0TUhsqbQ==
X-Received: by 2002:a17:90b:3b8b:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-3543b30ad93mr10104391a91.12.1770012149163;
        Sun, 01 Feb 2026 22:02:29 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm14212294a91.0.2026.02.01.22.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:02:28 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v7 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
Date: Mon,  2 Feb 2026 14:02:16 +0800
Message-ID: <20260202060224.12616-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8656-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 604E8C86F2
X-Rspamd-Action: no action

This series contains a patches that fix minor coding style issues in the
Synopsys DesignWare AXI DMA Controller platform driver. This adjustment
possibilities were detected with the help of the analysis tool
“checkpatch.pl".

These changes are purely cosmetic:
- Adjust indentation of function arguments and debug messages
- Remove an unnecessary `return;` statement
- Add a blank line for readability between functions

These updates improve code readability and maintain consistency with
kernel coding style guidelines. No functional changes are introduced.

---
Notes:
This patch series is applied on dmaengine maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

Changes in v7:
	- Refine summary on every patches in the series.
Changes in v6:
	- Refine commit message on the patches.
Changes in v5:
	- Refine the commit message of each patch to mention the use of
          checkpatch.pl analysis tool for the fix.
Changes in v4:
	- Improve the description on every patch.
	- Mentioned the commit the patches addressed.
Changes in v3:
	- Split into smaller patches based on warning type
Changes in v2:
	- Rebase on top of newer merge commit
v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
Subject: [PATCH 0/3] *** SUBJECT HERE ***

*** BLURB HERE ***

Khairul Anuar Romli (3):
  dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
  dmaengine: dw-axi-dmac: Add blank line after function
  dmaengine: dw-axi-dmac: Remove unnecessary return statement from void
    function

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.0


