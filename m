Return-Path: <dmaengine+bounces-10203-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMsOMPeS9WmOMgIAu9opvQ
	(envelope-from <dmaengine+bounces-10203-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 02 May 2026 08:00:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A844B113F
	for <lists+dmaengine@lfdr.de>; Sat, 02 May 2026 08:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2035130128D4
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2026 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6641EEA31;
	Sat,  2 May 2026 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oprKaMp+"
X-Original-To: dmaengine@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679512475D0;
	Sat,  2 May 2026 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701619; cv=none; b=q0ZnoYhmLY2YXysjqhg/6ksPF+6BvcjbfxnuZvfbhIP/MAdPsf9j6ItSfjgtl3v7ttLYjQvUMSXgrObCns8TFCbRKSunmJTCtqAxOGqjICOMH5Kohc+Bb4So39D0FBPBVcBNROqOUyawsNSmzXnbrQeORSdaEq9kSfU9lyPywQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701619; c=relaxed/simple;
	bh=qiA9TIwApvjkB1pcKhTev8aAAXW+kknNg6MYs9yJqHI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WMFfooIVCpGm/brhOMY90n7wleReHanCkqmtnq8l6xAcpbewG6maVUNkHmUukvHR11Gf1rwRpM1/d29k1M77SZu5P2ARwKvR7pJsdL1wVYGzy1+avOu9j5xCOInj0rEj4zSBMEalC33dksa5+k3dKWP5qxHENmhdsLYRZIkJoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oprKaMp+; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777701615; bh=fa5pN4GGt097LLhhH34pMrgAbO6h8NqyL1vvMQH7N0M=;
	h=From:To:Cc:Subject:Date;
	b=oprKaMp+XuXxSlUvV4CwhAgxBOvVeSox1sZ6RpmsIfBcTfVIkZFMaXvDZN5SpZQBj
	 +MRqOk+1KeULTHZY08zSEvzu4zow8zNUT4V9P/7fKpItNKIz3nFUhNz6hDkKM+62no
	 iJakQzqAygmkCjjBlBhUxcrHD4lLD4/w0FWDTx1I=
Received: from Lang.smartont.net ([223.88.152.211])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id C9ECE5; Sat, 02 May 2026 14:00:12 +0800
X-QQ-mid: xmsmtpt1777701612ta0ocwnfu
Message-ID: <tencent_BB6C24EBCDC646F997612BBBDC93A0B55C08@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ9m2bkjNIpItVO1phl3fiuTO9gAtD48TAgL+lpcAG7F2TpXjtoe
	 2EDQEMGdw8b/2boIqS9N6RVTmLlmli2wgtUDw7tTWqUCgMkqWaj/pQMGJjlxnjeIDynXR6vVCUP3
	 mOJf9G08BDybP06KG0Frfz1R12Z35eMWar9bFU+o4bwZrie5bTao7SuNQtHO3VZRY2aXfJiV1Aqs
	 xXz+JKiXgI4zDmxohYHGNi1jKjFV3y3pQ2r+cuT3nXM4kPVz5n4yRRa0IupbYfK17B8EuHQE7bzp
	 o3T778IwuKNkmd7BaDI1LEBHZJp0yr6hhBXSCvATRw5+IVn0t/HbQaY1hsqd520GPCN+Z6+MbP25
	 1aSDLQ5FxfFgp5hpfNozE9JsHwb9f5YZXIXA2PvQ9u6s7Jw7DlZgS2HC9oPuPwpuD80N1ASIPSu0
	 Lxe+WkOpmzM51XQ/Y+4TQslf/4G55UQzlbv/67IHfHci0lUlf6YtkhghzDJ3LVigDjELIiNNiJ5z
	 DbQ9+Vel2vSoruHG8k9QgH2rIme7V7s4unxGzINjCdgQ7jKaVAiaYddh6p3s1EzC7ZgMv0AJ86lq
	 O7Nba0X74O/GXuPpww2cJxi9wdW/fglDYNIwfokx1SMSeT2ae3jgcabeVsYAuB373AYQlZAL4eWf
	 xBPjr6N9kXYhABeoU33ItVT3eCyw+M+8hi5lxkeZfoFQu7rI/7Ir6pF0RUgQuy3MOu+sTVOvRGqX
	 qPcqfdryiqZchVWY35WCCT0xQPHcAvkFAw/XaCmo+KAiibIAFymxBidD9nQhqq2qon3KFzIzaqpS
	 wtfs3eP5Ak0QgSNXgq3JXiKl7Jy0KePevVbpXxGOlkqijxLjehkrWOZw9DkxwnCWgpnD+I1zDuCn
	 riUhoM5YoxRISgqkJrMbuyEaJYF75SDvsInQbcryzPMtp8v2CDTD/q7ZbfCuFNflNUKv99Xq0uqc
	 WIzUU5QaVCpOSH/pLtV0ztTL90Uv6mIl7aZBacAylQ/9h+XA/CtQjAZhO+oEZhN4bzosP8nzwgg+
	 zmTy1OEtjRoLEIAXIf+KJto+l4uF3jMbv/7ozjFN83ZWgdFdQg
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Wang Zihan <jiyu03@qq.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wang Zihan <jiyu03@qq.com>
Subject: [PATCH 3/4] dmaengine: dmatest: fix preposition error in documentation
Date: Sat,  2 May 2026 13:59:09 +0800
X-OQ-MSGID: <20260502055909.116546-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34A844B113F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10203-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:dkim,qq.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


