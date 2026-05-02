Return-Path: <dmaengine+bounces-10204-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK5IEcWU9WnUMgIAu9opvQ
	(envelope-from <dmaengine+bounces-10204-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 02 May 2026 08:08:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E70964B1203
	for <lists+dmaengine@lfdr.de>; Sat, 02 May 2026 08:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 802F1303E2DE
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2026 06:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B322ECD32;
	Sat,  2 May 2026 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HIS5a7YQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53C2ED16D;
	Sat,  2 May 2026 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777702046; cv=none; b=j36EnbC6fR8j3JTVvkJE0W64p8QxGLzKMFIAq2TV1z963n1DVIcKRNGLGUDGgdR1Vc1dXFlSIxR9Do5QXiC8sqnGl5cNb7hPHs+ce9Vna1DlarukHG/3boqMDXhxM+38TwxBNqDAPFQWpE3AniOnSgk6V+ghbf+aMHZJ8eFlA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777702046; c=relaxed/simple;
	bh=qiA9TIwApvjkB1pcKhTev8aAAXW+kknNg6MYs9yJqHI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=N+SV9Nf6tDD28pal6SYmkwaw2EXEwZ2NWEn7lvXo0U8taHsTMbzuKFWrxmjlEHphIL2k/vOHF/gPI4OeMZMBVqByPmCBQovkjbw42dMmBQGoE7Tkl9ygIyol0dFQMZAJUqWU4aBdmI2FNUPVdjVYdNeeXrSqbpLq+tzNdutTW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HIS5a7YQ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777702040; bh=fa5pN4GGt097LLhhH34pMrgAbO6h8NqyL1vvMQH7N0M=;
	h=From:To:Cc:Subject:Date;
	b=HIS5a7YQMRMbe42UBnAIGpqFgbA6UM/eVZZcrcme01NeSwbBoWKfldv8yeRtoQbPH
	 YuZH9BTTobxjwValOiXb+NKyUqbc2NMzKXxzPb6avkfeeiXxx5DRPstU8OWobMLA6y
	 +HdX5bhl+LX19DUcy+sXq8iOIR1BrlBVD3f+kDt0=
Received: from Lang.smartont.net ([223.88.152.211])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1D18E2C2; Sat, 02 May 2026 14:07:17 +0800
X-QQ-mid: xmsmtpt1777702037tn75go5dp
Message-ID: <tencent_74E58D3B06F4908B89C4AC39C688F4B26A05@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPrOjpcIiCj8G5d3sem9tPL/VqhNowV1YY7BZmFO9oTCA2QWhgOY
	 hXL6LLRRpxoeCXhCXPWgcdszxxa+wAaWEFLKr0YsmahY7ydV9Blkapwrgvv8uWfS1u4+U/il3rVo
	 AraNI0XM/uv2dwe0u2+4SopwqVKcnRzeh/rRneJLipo20hs30EPeLI3WdZ7pI3fPrO041v3/eB87
	 Ai9C49A68n5mRPMCbCcCUHmbiPL/pzyRXA0lvImL0S5Sz15Rk8i/fwvZznGgFHgJ34dNtRDXGj4Q
	 RWyxo2zyl3zBA+ycP4diZSq1lIg4XwkAhmqesbWjxM5xzDaJzbMyS8jznydFynNVYeM69qRs47j6
	 +66ZPCr8ZQgMRB3HvYTeSmjVqD4XUQl1Ig7HMFloHskFRVwVNdbGbT3OVAiot++zh9lZW9WBzhYt
	 soDk99aX5SVRIOsjBwFNUE+cQI8fRd4sf63Vb7hG6NEUWEytnsJjFx1Zldx27JQWfNdy2aPRE9Sz
	 1cZ66QNYAB16TWoX7AeovDmNK83XcMp7rDK3194LHePKZa3yP6/TLbCYg/P1kmp/5IXJBhf6pf29
	 UDO1HLvjzYrpBa4oTaL6Lj+agP8ZawB1XLSd9ArsbxcJJUeMxrpnXjGjf4qMdQaArHIi1nxgSVIF
	 zwxmyxFPVW375f8SQx8wjFrwqY9jRG3GSGzOwbYA3JevHLDDMZSAm1OrbRJk3a4gkHW55AFLE3Ya
	 0bbPTIxZ70JbkqS8D8YMXhuTGG5XDoBlheVaRne6aKqIR8AZaidelQE6i2OeZXTg15b3hdPapOKY
	 a9c0Cjznjj9q/950TKOI4AP/Mm5IVphCkQjwNcvY1tEhvNAeql7/b1Q338sjpv1wa/dOFOQIvDNH
	 lcVNXBZMepgnG6lybxWHJRB3AwYmDGKeh6FRkcgDGJv3usQ0A34j0dFadacTQOyfI/ZacizWWFyS
	 7o+pUIVBJVls0LJwPJjcrUywPy1ga1OnSSiiZR/qa+yWhJNf3PQBLw0XdIypkcrC9e0Axx9tJB2L
	 /Ve5WvLdy+JFzzQ7L7y2++2xr3vFmiNE4ICniMLxPtbpPGoMeyV6YYPMcPdtzongfAGf6bGxK7oq
	 CkvetxlhStwUuRto8lV6jkl6VcIA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Wang Zihan <jiyu03@qq.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wang Zihan <jiyu03@qq.com>
Subject: [PATCH v2] dmaengine: dmatest: fix preposition error in documentation
Date: Sat,  2 May 2026 14:07:02 +0800
X-OQ-MSGID: <20260502060702.142296-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E70964B1203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10204-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyu03@qq.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:dkim,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Change "built-in in" to "built into".

Signed-off-by: Wang Zihan <jiyu03@qq.com>
---
 Documentation/driver-api/dmaengine/dmatest.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
index e2a63cefd..dafb84afd 100644
--- a/Documentation/driver-api/dmaengine/dmatest.rst
+++ b/Documentation/driver-api/dmaengine/dmatest.rst
@@ -108,7 +108,7 @@ Example::
     % cat /sys/module/dmatest/parameters/wait
     % modprobe -r dmatest
 
-Part 3 - When built-in in the kernel
+Part 3 - When built into the kernel
 ====================================
 
 The module parameters that is supplied to the kernel command line will be used
-- 
2.54.0


