Return-Path: <dmaengine+bounces-12440-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pwhNL5yCVWqupQAAu9opvQ
	(envelope-from <dmaengine+bounces-12440-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 02:28:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C174FDC7
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 02:28:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JJ6aCtS6;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12440-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12440-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDD873001A68
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF651E7C23;
	Tue, 14 Jul 2026 00:28:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5361DE4FB
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 00:28:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988887; cv=none; b=a/WWG3kftcEPaL9xBl91X/Lk45XTPuhgLdScfP+5Y0c7O0DaKBUo/6vCHkUuRFiSvvfYdHHumgE1WbTWXnP+qxCISa9M+0aSc7p0DdnzQepU838daiPbyNjvwlhLrk8LQNKzPDTfNEdk3+knhi+R+Gx8tvbxVItBH1WTvTjuR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988887; c=relaxed/simple;
	bh=5iy63XHbqBSfeIqFa1/srtHbQ/+BlH6A+g/VbecZvj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnNfsm1D8T4s+FSTDsX/XB0cOzbut3U5Nju8TYuRARKeh2NDDUqAm2Fo2L+N9x6HGIJMCwcym6XIrhgiY1EcF5UOaMZyxt6eRDoiBvxbohJ02fRE0vnhCom2iIpgw5XcNI/FnLsFjqdQ5eSkgNDEmdYzvkj9JNxya8YvZfe33fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ6aCtS6; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8453427d3f4so3191560b3a.3
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 17:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783988886; x=1784593686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R35+AhKuoC4oYnI/b9RPi99MFz3JDij1EKLCf/1SkNo=;
        b=JJ6aCtS6EpiYAzKDFBUTICrNovfM8m+axwNwhXLld8pOECCKV/XIuB07fM1TdLlHck
         Ce6HX0paJsk9SWVG9WdY+73m7DvdPDTmy2AO+OY0vNtA/MZ4OiyBuYVHai7DifM2QLjH
         f5kU1HRzSmRelgKBDqpgLchlX+S0CWcjOwxDHMeUlz03STbdOEOx5wW23dl4UBRhsO+z
         pQsI/Jd3A4SRsWUhdd70DZmMFghvgTxQn0Jp8zg1vES5PYTAzKl4EyNyrAkKFvuGrgqj
         ve1qDcFk+jZ2tkuiHjOfTml4GWRL5FNPD9xmLALjyuZBCpvcqpIR9l7aBQ4FDbbU7WiP
         sb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988886; x=1784593686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R35+AhKuoC4oYnI/b9RPi99MFz3JDij1EKLCf/1SkNo=;
        b=GjK82YF4STh0qlsgJxRd0o7FQvE1iPE7l4qbCjsUj/2NEKfB/yi2omzOafFfdbkXOx
         bXf1lGSNlSKEk8o67ebEzxYbfwqngIUTtkHYkS0Xe9NFcTTTXOq+GqLuy+IWKLQvmW1Z
         rWnmPwvjXj309K0c+fz+41iSNPa30IOsU4UDuTSJC2hiZptBB7mu3E14amk+kjZK9lL1
         3vYetSgttGbDdmp1aErdAndIpYLAKZJjizTScSsxvdDfnntRd1264r2J6OVWPS5tJ8oD
         /kpqRQdZX5h+h3WUwVHeDNmrrTQnJYFX29A+imqSVSUwUQzeqUjWaEekuKcWh+mRp+ou
         DI1Q==
X-Gm-Message-State: AOJu0YzSobYpCN2m66MCQnbSFGF4kmWZeDeYRKvH27BUGxOVvbtH+rvf
	BOJ1JVNRuPqG/nmqi4W/v0E245lelY7vvMQ85E4MFzBeSOu8Ptu+ItG6uqlrqw==
X-Gm-Gg: AfdE7ckK04DqcVOHlpdn47eYMwu5QQJUSj5izrevjpNqJJMtZADknltzV9O2b3EMnJD
	UZ1PZtrfMkSs+KDMvb4Ng4nsIH/vRNlfoqFYKJqBbs7UzSEiTkOrH4oUztLGJfOyJIX/HxB2WZU
	4aJ+PAmOFAHhfIutCi3S0hal/pW7vP61MUZQC5d/AskVbKRgz/xKY2eXlwIWzYaAxDKF2aOqx0u
	1wWcsuPl9Y7rtdJ8wfbYxAuId7ASg8slrbEZVqQ4RYgpiaXUhQfYHCHv1sOjdAY2azLDRhoyDA+
	BxCqO5NopL7NBnzQwxOMySPJg8Y4lF490qnEXj+03zx3mP3/JZ33bNdEWacSOlnU5Fy9wnCxL8n
	2XmQGZBDnqvT6gqDRDgiG92LK9TrLd2qxKXLnqDLwE9rTVr/TfLSuZe3G948a7abnTn1d47V5MJ
	HUS85bjHj7LC1zYLuqcDRIMD0NhG5IM865A06DDC36X6XYMKGKFhKu/J9o/BQaCQ8AgzDbpzDUV
	45IUExGJxQxls9b2PRBT++vAmRZ/2PrOABUMXmFStMbtRUc4c2hKaJEiF/j594H7w==
X-Received: by 2002:a05:6a00:12e9:b0:848:662c:cb85 with SMTP id d2e1a72fcca58-848895dc921mr10952862b3a.6.1783988885724;
        Mon, 13 Jul 2026 17:28:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f81a5absm537906b3a.54.2026.07.13.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:28:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] dmaengine: mv_xor: use devm_platform_ioremap_resource()
Date: Mon, 13 Jul 2026 17:28:03 -0700
Message-ID: <20260714002803.1414307-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12440-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:nathan@kernel.org,m:ndesaulniers@google.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD9C174FDC7

Replace the two open-coded platform_get_resource() plus devm_ioremap()
sequences with devm_platform_ioremap_resource() for the low and high XOR
register windows. This folds the resource lookup and mapping into a
single call and returns an ERR_PTR on failure, checked with IS_ERR() and
propagated via PTR_ERR().

devm_platform_ioremap_resource() reserves the region via
devm_request_mem_region(), which requires non-overlapping reg ranges. All
XOR nodes in the Marvell DTS describe two distinct 0x100 register windows
that do not overlap each other, and sibling XOR nodes interleave without
overlapping, so the newly-reserving mapping introduces no region
conflict.

Built for ARM (defconfig + CONFIG_MV_XOR) with LLVM=1;
drivers/dma/mv_xor.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 25ed61f1b089..fe2e6b9ec185 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1309,7 +1309,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_device *xordev;
 	struct mv_xor_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *res;
 	unsigned int max_engines, max_channels;
 	int i, ret;
 
@@ -1319,23 +1318,13 @@ static int mv_xor_probe(struct platform_device *pdev)
 	if (!xordev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	xordev->xor_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xordev->xor_base))
+		return PTR_ERR(xordev->xor_base);
 
-	xordev->xor_base = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!xordev->xor_base)
-		return -EBUSY;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -ENODEV;
-
-	xordev->xor_high_base = devm_ioremap(&pdev->dev, res->start,
-					     resource_size(res));
-	if (!xordev->xor_high_base)
-		return -EBUSY;
+	xordev->xor_high_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(xordev->xor_high_base))
+		return PTR_ERR(xordev->xor_high_base);
 
 	platform_set_drvdata(pdev, xordev);
 
-- 
2.55.0


