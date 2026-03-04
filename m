Return-Path: <dmaengine+bounces-9231-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zOAwFafVp2n+kAAAu9opvQ
	(envelope-from <dmaengine+bounces-9231-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 07:48:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391601FB4CD
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 07:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03BC43024A41
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428E53537DC;
	Wed,  4 Mar 2026 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SIjPI8hY"
X-Original-To: dmaengine@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862573101A0;
	Wed,  4 Mar 2026 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606878; cv=none; b=tFOk2/oIYwTwvsLk9KKJugReekDwgEGIn0KkyeR0JYzJWFG00jJ98RnZ9qHn0P/GAhXymDmcXUmXPZgDiJFlPNHkQGbtspKSyhflDdjrDNvBz8vx1eg+2yzdHBJZfcpHtmUyfxr1MZa1G+VknwCXJMYEaudwGpVVlXVWhBXRZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606878; c=relaxed/simple;
	bh=rVN1jgJQiG9X1CGMlV93IPVpGeWqTxuCFkbLgJ0Z8rI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZjsKdDwCP/FFTbgV5BMINlVEgzO0rrqD2by4i/KHeHXx0yx/RY0BnKbCjUH4QDcgF9JIhjFa31QBumptJJUWMFzNIjm6sibkQQo6zvS7IGgHMVZMip62ShwJ+BEzoj7yULHp0SBZ1AJU7jI1+5vj/1Mp+v2W5/TYuZRXzLvnELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SIjPI8hY; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772606869;
	bh=d2HTv4xTfxIrHQwYgFn5wbpYYYq45cjpmX3ozWUVOgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SIjPI8hYWs+SsuxDMgrlgOEUKJ+WYLVSRUNpU7uqluyICCnDkntc7+/O8s0nz/5Ge
	 ToeF1DGwXI6rPITiQp+JM1Uj8ONNhYWw69WAYvxIhXYsoui9hGLwoC31brlqZR0zx2
	 tSqQQ1EsiOMvUuREoYAHTevpbdzQyzKCYTf26oDY=
Received: from luohw-ubuntu.. ([171.213.183.153])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id BA5B2A65; Wed, 04 Mar 2026 14:46:37 +0800
X-QQ-mid: xmsmtpt1772606797tr5kaul2k
Message-ID: <tencent_CB11AA9F3920C1911AF7477A9BD8EFE0AD05@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuAsoFIV4FrEpHIfsH/Ff30Qt86QfrF16WdoK7BTKVTmHVJgrTzs
	 U4xONf+/dGxnwNdczW0FtLrzxSIyioNPxFb9MEnyfjEhdToQjWNhioHq6EmhKOvZlPPXHO2plpN0
	 0mV+8gMjsT7PzDR1lec2JCDuZrUbCUt+Wvb9jKeD2KtyYMAhvbua9cRRE8zl2qfQG60n9L6CU597
	 9va+LDbF89omvV8S8T0ewi+R+bDb6UVTyhicHz/nOmJipj1YsD7kVi6h2PHw5kthRHh59r5YVvzy
	 D8OuxhQgll57wGZQ35NUIQjMebaBufsaqApkSiKdJVPTRPCg55hZsms9YNOoJR4R7i3KwFUK0+WW
	 qUIqGmuBTz7G/anCLUPEQXvzH1lOl35nrkbExLQ4RCwK7QFsT4X3Q6mZ/glZCfHcmR15wgIU3MuU
	 20++QUdCDgFIlqjnQsxqeBVkBLO3AABDyx+nygi4DiOgQA3qVgXdWy4rcUJ37d+efSfQjVMuM1bL
	 0w+lxS2Mquf8NkqC6/XzEcvQh3I5L3WK9VxzgV3jtxYIqwCmM/KgLrOfVb2Ct2r4uBRq8Zilhm1x
	 KYcUgCuljHqoHWHbAgGw/V/uOF8DEXhJggv62IMtcuMT3sX3AfyOQqvfvCcrRzlKakYN01ey5eRa
	 B7n7hMSF/GXdw/4q2TmpaUqqH5RD5aTMJPJ/PZSQP8pOlRYz/H9htCI1bC2SfCEJruemEn5KsyGH
	 /q/UGxkoe7cDnqa0NiJWaqzAvTJc6czGw23lxqHf2a2/ta/5yy8XvPcHH8IIu97KyjigWjuzgn1r
	 8ow61XNyU/TJY4+sociR4+M6EncFvQNUcHxeJFJGLx0XwgOFQAhdi2MiAadgtdmvYyjfAJauCnXp
	 l+aGx80O+ufblPvTe3YD9s9jh5m8M8siIZfgSgu6/hv6tgo+ia1v3MY3u1ODZjkxLp4jyRq9L6uA
	 lha/uItp3oa3wrI4FHU1t0R9qoRlcG5peS8G9fi/LjkYdsxRfeUIWs9496xJVkw2pbNj45pqu/PM
	 h8ZDWYleCknbxwpLx8dWLt/6laj94m8eCKWgr9BQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: LUO Haowen <luo-hw@foxmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	LUO Haowen <luo-hw@foxmail.com>
Subject: [PATCH v2] dmaengine: dw-edma: Fix multiple times setting of the CYCLE_STATE and CYCLE_BIT bits for HDMA.
Date: Wed,  4 Mar 2026 14:45:09 +0800
X-OQ-MSGID: <20260304064509.342170-1-luo-hw@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304025049.324220-1-luo-hw@foxmail.com>
References: <20260304025049.324220-1-luo-hw@foxmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 391601FB4CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9231-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,foxmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luo-hw@foxmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	DMARC_DNSFAIL(0.00)[foxmail.com : query timed out];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid,foxmail.com:dkim,foxmail.com:email]
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

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: LUO Haowen <luo-hw@foxmail.com>
---
v2:
- Add Fixes tag as suggested by maintainer

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


