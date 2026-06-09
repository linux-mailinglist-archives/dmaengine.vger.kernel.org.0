Return-Path: <dmaengine+bounces-11363-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G8iPOECSKGqiGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11363-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:22:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568736648A6
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:22:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="RKdQ/v1u";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11363-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11363-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE5830EDB24
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828394BCAD7;
	Tue,  9 Jun 2026 22:19:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224E48A2DE
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:19:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043598; cv=none; b=u0tMNHAFlneohx3lKKIN9HuQOWXkl2Xwh3xrnjhuFghDZPPRQ3qx3uu08MHC16fPlcq83PhCbvKdFVLBs5DeXZbNnl/oXYhnmmxF76JAV/XNJt2nLGZZreNDTcvVAkS4Qq1nDNXRZSPyK087LR2hTpjUKQg1CLWQgCt63Zgzlqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043598; c=relaxed/simple;
	bh=lyTXMgabiZFV1r5MchNd6Qy8eKJqo3LxCHLLSTQ8EzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa5N9TNLX/lTdez3B6BJ9AVGcHaCIDjZbjUuXP/YeWpW9IsFcE9HTpUOIL9MLqhjrLIMUvsktu6WC6ftQvAuLHMhVptK+nqrIrnMmN58HvOt2REAr5kBDhOlWDF4pobkLPGGqE678TWOgDAPlu7IzeocYvdFuwWkdvkBCbj//cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKdQ/v1u; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c855599a77aso3016759a12.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043596; x=1781648396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
        b=RKdQ/v1uAFcxV/ocjx5v6hRmdWG+zS35WfgBSYeRthUQa93HZ0ES+XI4rB8m2KaqkF
         g5jDDUogZrFBdnv80jOgkkU+qQYH/WSewqkNeIUynlU/QdG731kv0Tc/+Go/xK34T9Gh
         NsQOA09KqGg5pYGcJCwZo3K2TjHj7z0/MVIg1OtbHBIxZhXXowxJ0VdX/JG2AGGKFgTt
         IXRUYb0a0HHXO/KBHQ8wztWifJEAqTGCby1RDVCr4t66/qKYWJmVNd4qBJ1XoY4oaJAP
         peD+TBSnwRgW7nYtzIhWEHUmjz2ab8SRbIOgsu6iB/7zMU4fih5F08KDiI8geU5okjKE
         UCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043596; x=1781648396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
        b=bdPBSHncbBELYc95Cp+SyeCVQbo/uMRvuk1ld2pmPFBLgtnuv/sF066tlLIfOwKF+r
         72NWCno6Tp2XcS2uMJc5on2VAg4svOT8v9Su4QQK9f21ft4OidYV1qFPs3HTdD67+PNp
         4BfX/UOMrA+qqsoLCbL8+WhGTEyGj6pDh3u7K4uXythgU0kkGas48U5rEsuZP/qUkcz7
         nV0TMAaPJb6gfRtUg9l90bAx24lXZ+nekUsAk/uxqJqA4fPG6BCHXJZb9iN2YgORopku
         jyIQLmTh+M5vMAY8Dag5C0FWCoStbSWgop9dVF1b9eTtSGz8Iu2IAedXSu5UatLcUEUa
         +vHg==
X-Gm-Message-State: AOJu0Yz8R4I+7ke8z+mN1dCIe41xfNJ9DyFoLewLMg2IJ8bsVk+D0ubq
	Om9BpjqPDSt9amvpwllQ4qy7DBFrE8xb2JRYALqeLIyUnnKifU/g+4OS1vxI9wKk
X-Gm-Gg: Acq92OFjDHG199xTDCE7sefm+v4uDpZm7Hu3FB1pcFLZNfUHWr45UqGS/wxoNitc5Y7
	/cjSKEpgqk3IXZcHwD9st5yxOMweSurYi4DoZhpxjEjoHKPgO3TxlKiKQx/Nra67X37HL/M/A9c
	vFnb/nTwUqBdP+bf2KnlvVHQldOtI1Nd00gJYwqjz4oiur9nPVY9TLJMzhw6uOetxh8H+Ct9rHj
	or8cmNtcwf/kta35FWnN0UD/gNjbZGRGdk/GAiu7JZzb+pCM1tJMTInYJDf51AQID8WSq43Sf+Y
	dFavGC7KcTL3ILT141oMYh3Dm+Qk3YE3RCUve0igmPuwfuTHg+Y5PXOFCZtcAuv4WiHjxwe8V7d
	MIyts92mE4sl9sJhC88yrFInRz7l+Z9ReDa8jAjzYd/xolgu3d0SwYxe/k6QUllLQ78+Wte4kO+
	kEvGTtUA9cz2dMztWUhfV5XxklF6ZD62oJ3tcWIhxlKbgBXbg/zpgejXK21pls1EJW0m/FpCNHm
	zGBmEpecFJ4huQCykrsXxg3WXMvLON/a6cFuzRMPzQoZA==
X-Received: by 2002:a05:6a21:7a82:b0:3b4:85db:1bea with SMTP id adf61e73a8af0-3b4ccd1b486mr26738313637.5.1781043596210;
        Tue, 09 Jun 2026 15:19:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv3 05/15] dmaengine: fsldma: check dma_async_device_register() return value
Date: Tue,  9 Jun 2026 15:19:16 -0700
Message-ID: <20260609221926.35538-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11363-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 568736648A6

Check the return value of dma_async_device_register() in the probe
path and propagate errors instead of silently returning success.
Previously, a registration failure would cause a NULL pointer
dereference in list_del_rcu() during remove when
dma_async_device_unregister() tried to remove the device's
global_node from a list it was never added to.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 43d817f6ded1..3009e1531292 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1303,7 +1303,11 @@ static int fsldma_of_probe(struct platform_device *op)
 		goto out_free_fdev;
 	}
 
-	dma_async_device_register(&fdev->common);
+	err = dma_async_device_register(&fdev->common);
+	if (err) {
+		dev_err(fdev->dev, "unable to register DMA device\n");
+		goto out_free_fdev;
+	}
 	return 0;
 
 out_free_fdev:
-- 
2.54.0


