Return-Path: <dmaengine+bounces-8658-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CX5lF/89gGkd5QIAu9opvQ
	(envelope-from <dmaengine+bounces-8658-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:02:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA168C86FB
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 785F63003D3B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204432F12C6;
	Mon,  2 Feb 2026 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBxZXvnC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60B19006B
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012156; cv=none; b=LSs04hZzI2baNfyEUKzs38yv8aW79cbvR+TZ51/8mVzhH/LrOUlTkFk6TC0Qa4UyXhiFnbQcG4SC7DNguXVktfntq7Js3kMlwiYfTdabRd4lFwYuUi17CXDtawXpbNUdc8hmnbd/nGDr18zn+gftx6mftNWW1teWVUzukbUe6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012156; c=relaxed/simple;
	bh=t/R2UaNXcS31oB2v+9aA9x+KjXAVXVSekUlsLcapVVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUkW3koqkn0Y8Oj1khB+0NTWsZxj33egbUfQlTrRHWrJ/69OznzR65NaBV4SIZUo2UMzPEqqql1tUWRWAFzc7bOeoKVS2u9vgZSAQI+6FE6TEp3DFnvZkBaxdNYDQYlqBVcz9VKzwml4SWvEPEBtvf7XOpyPF/pwAADyQP2gIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBxZXvnC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c21417781so2057217a91.3
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 22:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770012154; x=1770616954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBAZZg6DWx3jZgd0edGfy3lxQmykPlUP+fMCaeAJK54=;
        b=nBxZXvnCB0GVzmCf1t+/yWdsexGj/mFbvdCPCz3hPLC2+JE6wzBkW3cWri3OEsObjD
         Jp3Q94mij6mA22f2kHl6TRP77bNnTQD6oxVBV7mLKX1uZ6aUZIAJBvn7tHyeQ30q34Aw
         FoESoNxi2SpRzTz32FF0ckDeqMkKB8JXhYYvexnemSIg7eEuWs1+vO6HBHE6Iw0zU48N
         fokQGcm7Dge9r2f56nkwKGWwOujg0X/PWh9EUnj25ra5JXAq3uuwwf/M2UqwTgu8f9mY
         D4Sel09tS/UPKFZ4aweG84lCGEO6K2DTntPfgUoPr3vjde77Gxm8DAkXkw7hZMourYcv
         Y5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012154; x=1770616954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VBAZZg6DWx3jZgd0edGfy3lxQmykPlUP+fMCaeAJK54=;
        b=PpSKJ4cEmXuxFwLsULCLg5jxt96cnTxi332V9jDk+WWxlogD9Vcc4b/sYqlhZttGrG
         Ao9WGyGzFLzpt4pUXXF5tl03mRozOptkgGBIoEr2606McLr5ZQ1xeWOYFzf3BcnLj8pK
         F8jAW1Y/KAzRS4KobCaS9ertudwOgz7xMjAhvNdruFJdh4RfrjgUKJSK8WNbKPDFAnJG
         Nqc7HieNLocbxKhvIXQSkQbMKjRhm66xqtm1u5xk3MF0Q7seA8meWMD57SPR3FwMukO1
         AwFDzCgfvnmLDNotuT27cZTQTF8kLJKOwkoDAVn+SPaw1QYAS6ZqjLIF+tx1lpsgQcBT
         oe3w==
X-Forwarded-Encrypted: i=1; AJvYcCXV0n46BYFjdkCIW8dOyA8YTKvim2qvRn3zogbsVZadDwgimmIcmdJ3VEb+Tg+tvhjM1lEoJcbDpZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rGPnGhyBBGYyo0+jd5gmaM4ibrVQB+4/Pwd5qGdC2KMJUlKD
	NzcRd6jljuATIzTNvjeDLW13282nbg5HO+kcGI6hzlQjiBSr0cWFni3D
X-Gm-Gg: AZuq6aJXy4SKL8G17cDP7cd6gLLIDxWNMfMFcY2/RplR/5O1+TJ2Y/miJvL7r2+YOB7
	v/95kc8jFqrwrjY7YacT5htl/tq4LPgAVexAvF0P4qHw+d56HvF5BU5quVnsILg0pTCECDf6QKJ
	ZsZ8O2NcXKiCcmT/BiCAtGpdktBiEFicD7JuvtdqBMfV5ZULEzWId5BPEwkaLmKb3kc7xf9WVoQ
	W7dXYKSRigfXmWhvpMxDQ+SPho+8fpqakcn1+AW1WiBWbgKcj9PDYz78JUyeJQ6wEPrvWUdm3+6
	vLF9yg+Qcd8dStVcxmam6vcPn+HIeTkT2RkwH9/Wkph8GiLa9qqKjW6IHBhScOgJCpliMq4/+Gl
	87QWqifeIQBARM5G1GQCSVaLbCVMrKLpN/RHguH/BZOpllhc45gOf4EQHQ8r95J0oxxhzapIgbm
	deyJyAJSn1X7Nb+Heq95iFuIcWLa8uv4mMyRs=
X-Received: by 2002:a17:90b:4a8b:b0:340:2a16:94be with SMTP id 98e67ed59e1d1-3543b313144mr10089523a91.4.1770012154139;
        Sun, 01 Feb 2026 22:02:34 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm14212294a91.0.2026.02.01.22.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:02:33 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v7 2/3] dmaengine: dw-axi-dmac: Add blank line after function
Date: Mon,  2 Feb 2026 14:02:18 +0800
Message-ID: <20260202060224.12616-3-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202060224.12616-1-karom.9560@gmail.com>
References: <20260202060224.12616-1-karom.9560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8658-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA168C86FB
X-Rspamd-Action: no action

checkpatch.pl reports a CHECK warning in dw-axi-dmac-platform.c:

  CHECK: Please use a blank line after function/struct/union/enum
  declarations
  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:

The Linux kernel coding style [Documentation/process/coding-style.rst]
requires a blank line after function definitions to provide visual
separation between distinct code elements.

This patch inserts the required blank line after the closing brace of the
function definition after dw_axi_dma_set_byte_halfword(), placing it
before the contextual comment that describes the locking requirements.

Fixes: 82b5c9d6d4de ("dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD registers")
Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
v6 -> v7:
    - Refine the details that was not included in v6.
    - Add Fixes that was not mentioned earlier.

Reference to v6:
https://lore.kernel.org/all/20260201000500.11882-3-karom.9560@gmail.com/
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


