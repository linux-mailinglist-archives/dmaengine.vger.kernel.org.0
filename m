Return-Path: <dmaengine+bounces-9225-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I3NJDKep2nTigAAu9opvQ
	(envelope-from <dmaengine+bounces-9225-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 03:51:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8631FA114
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 03:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEC623026DAF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 02:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E973264D0;
	Wed,  4 Mar 2026 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xhLjd67m"
X-Original-To: dmaengine@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669034DCCD;
	Wed,  4 Mar 2026 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592684; cv=none; b=CeWcR6wc9Bb4tL3tYwsE0dei1wuCjr8PTBelnpiB4CYVl9m+vLOuVNaCRkg9HN5ysHRTlhNuVm7N5WZUtM1ZbjMk5TZGuuKUqo0yNW1Rd3Q6A6B1+AalSgS+tngsOFIlrSpsfTK+9JQfScyWwlxikLxA7OKkNI/TyTamLX7/GII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592684; c=relaxed/simple;
	bh=udAhC98i0kXNzveTW7V3E+SAD3n55ZN83aMsxg/asa0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=quqBFp8mTycSJopb/OdtCXvsBK7vMf7c79eBU0Gagqt5bi0t6a587lzOyRqkuPPSjudvbYCLUJpocrWv0c6bE1Ti1+kaqvKUkI9YQglj32evqfmVzPTT0lczPzGOnAbx3X9UIAbEXSD61f4bH5DQB6YoZoaHX5OCdv3wbWpgYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xhLjd67m; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772592668;
	bh=ZYVPgeIqo00A1XWmX2XqkojHrWtVloQmGzGJ01aBjJs=;
	h=From:To:Cc:Subject:Date;
	b=xhLjd67mey4h6LASEXZcW8mjy9JHWRbvVhhl1Ry0ZU4PYt5V8jLoqWVoNYkHuk9VS
	 +mT89yj7YdQpVyNugDdpG+fxYT6w/gtoV5TTaDvJO6qUf4OMfvblXuhEvd7VQSJp09
	 08XDDCGNLpv7tfscYQC6jPM/qpaPUAU5fsZbKChA=
Received: from luohw-ubuntu.. ([171.213.183.153])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id CC618E70; Wed, 04 Mar 2026 10:51:06 +0800
X-QQ-mid: xmsmtpt1772592666tyf59obfk
Message-ID: <tencent_0ABDB1BB5F3160C21114F754FA9B18E34005@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe5nxAnpEvlvbqcXsAZ419e0Z7oJTzqrjjArfZ0QJjmLnqaFoOQk
	 NkS7blso9VHP18LBznt5yvjU+F5kYJFgIv54fBgiDOA5EQd4nxb5OwWwKWc8wc3T58SvBCxnHblC
	 8vyLzX66At9JMAUHe5cqF5gEUYe+F4h+d1LRUers5Z/jhencsJlVMDI5XfSFvuZnhZI6H8b7YfA/
	 I/Lzg6DSYgH2iddqIVGarnb9XTI6NmCUtD9zvz5YLhN8Mmt8PsUqRTH7B5xAw0cSKbWPHUTLW5/+
	 gAIRtO13+xHylLytmkIkl9qvKfMUEn304Ws9eKqJBl6oPUQs7YNdhUFNtA8eFARlRdgAt3F+2NM+
	 ILnz3tPylD1glT6kQ711K811kmdmJBZj06ygbyu5CB71miQfTcP5GpC6asOed205OLx08G/gZknG
	 6NQlzOrKkGd5xqSJ2DOaWi8LaSX7WeEYNWVB94MuXybAzjfxJnlJSNvUX3LM8vwL+qCRpw2NWFFK
	 5OvuGc/6tW9EdQ7ORCpS5XMUqNMfleu9EpBdI+EKnUJKVV9QFFNmTTva67Lrub4/gxNjgXpoG6Rw
	 ZfXyf8nZ2WD53RLjTb/rclUja/XjJUAbtF7IeiledjBRwHMVIB+vty4YT5svtnc1H0mog7ZlsHXK
	 iO58GubQ2FGHJ/po6iiWjk/HsljtEAJkDgXJ7wMyrnmBkTsHulwhtnB8XwW5FRAvB7E/mFaV1Z6C
	 9ako6DOK1Hr5uND0XUVYGJ8ktBEmM6jOQUoOoTKmNO5Q7bGCib/9u4TfOy8KSthUilpXSZyWVAFQ
	 qKotk/FWEvbeF/2DRbZVtdADZuL/ZaUZb4Z8DbXXaLzr6IqpblBeg68WMfYEtZzAaOLTLgqNOHr0
	 4p8y/RKqAtsVQk2bh1+DHXZ5vjfJGbFmampY4ChfDDQp4nLNkJpA3Ve3n1f86iNO+XQJKyTsnHWi
	 d0eDgh5rN93WtPM/ipncK2M1rq0mvBRXBFQHcMGlico1ACz5j8ObEk+Mlzc43I3M/OsShhIDl8Al
	 9YERlfwC4sUzRWTv6MMqzsHVyse1k9glWuUJqN/vDL41QW0j8XQVpIXpxc2+acKTVzdbiCBA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: LUO Haowen <luo-hw@foxmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	LUO Haowen <luo-hw@foxmail.com>
Subject: [PATCH] dmaengine: dw-edma: Fix multiple times setting of the CYCLE_STATE and CYCLE_BIT bits for HDMA.
Date: Wed,  4 Mar 2026 10:50:49 +0800
X-OQ-MSGID: <20260304025049.324220-1-luo-hw@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C8631FA114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9225-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[luo-hw@foxmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qq.com:mid]
X-Rspamd-Action: no action

Others have submitted this issue (https://lore.kernel.org/dmaengine/
20240722030405.3385-1-zhengdongxiong@gxmicro.cn/), 
but it has not been fixed yet. Therefore, more supplementary information 
is provided here.

As mentioned in the "PCS-CCS-CB-TCB" Producer-Consumer Synchronization of
"DesignWare Cores PCI Express Controller Databook, version 6.00a":

1. The Consumer CYCLE_STATE (CCS) bit in the register only needs to be 
initialized once; the value will update automatically to be 
~CYCLE_BIT (CB) in the next chunk.
2. The Consumer CYCLE_BIT bit in the register is loaded from the LL 
element and tested against CCS. When CB = CCS, the data transfer is 
executed. Otherwise not.

The current logic sets customer (HDMA) CS and CB bits to 1 in each chunk
while setting the producer (software) CB of odd chunks to 0 and even 
chunks to 1 in the linked list. This is leading to a mismatch between 
the producer CB and consumer CS bits.

This issue can be reproduced by setting the transmission data size to
exceed one chunk. By the way, in the EDMA using the same "PCS-CCS-CB-TCB"
mechanism, the CS bit is only initialized once and this issue was not 
found. Refer to 
drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_start.

So fix this issue by initializing the CYCLE_STATE and CYCLE_BIT bits 
only once.

Signed-off-by: LUO Haowen <luo-hw@foxmail.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe..ce8f7254b 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -252,10 +252,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  lower_32_bits(chunk->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
+		/* Set consumer cycle */
+		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
-	/* Set consumer cycle */
-	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 
 	dw_hdma_v0_sync_ll_data(chunk);
 
-- 
2.34.1


