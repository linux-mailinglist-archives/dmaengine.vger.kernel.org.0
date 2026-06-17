Return-Path: <dmaengine+bounces-11572-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vvDWDSBhMmr7zAUAu9opvQ
	(envelope-from <dmaengine+bounces-11572-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 10:56:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 957FE697B28
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 10:55:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codethink.co.uk header.s=imap5-20230908 header.b=AL5sK6QH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11572-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11572-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=codethink.co.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 214F8306B723
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD83909BF;
	Wed, 17 Jun 2026 08:49:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39737F732;
	Wed, 17 Jun 2026 08:49:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686194; cv=none; b=TQaDZkpDpx+lS/+bysqr9kvFOK+Y5MMHette0p2Ut2WhPxbldgLuQzTy10kBM2ZWeHc0pA6WO3oiepFC15C3HEbWe78iXPdVYj6wsvwPScps/E7IhtXI1cInbyKujAB+DQwsI3YK42zpzBNYXcMY3slRpuVsopzr+msPBULwvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686194; c=relaxed/simple;
	bh=xQPSdirsxv6ijUtoiDaS30xqu54Aw5zWX8fwQOuw0y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p70lfsXF7MetIMqrZ14Uc6nGCRIj0PBWt1mrt3ieeI1V53gILKhP2dmyfj1g6x4UV0D2nHEJho1nrLxYn1S+DguBF4RJpM7zabSXom0MPAxNfFtztylo/1xrl+zKPM8qAIBuLzDVZv7zSvU8TJwck0zfW2mz8osoxfNqhbfEoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=AL5sK6QH; arc=none smtp.client-ip=78.40.148.171
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=BgoFfRHevUv2LavsVuNuyGpqu+MEvM7WfElqq2spw7Y=; b=AL5sK6QHvubTC4
	urlMTkGc7EbMWiJii6Er8UFL1NYCnh3ROfWg9iGLdroZ5zj0YP8ChfMjXzokAw87xkXPnc9NjMRMv
	g5zD616oxZlYs/OZZ/QHlJmQWyELMwGxd1DBCvvT/DvPDHT1vjaF9myNPwJME5IrWNHHfzk8182Lf
	XnV5W/hL+WvTzujObtpQB8JUzZSydOgyzTosbce7ypY0blZ4oCvC68pEWH9ujZbMgg9MQDv1wlCy9
	i8tBG3JgjdLY6Na2/cGesPN5rx1ehHcvPcBGj2sw8tFaIO+T5E+K5RkWnW7V4ihIQDQzRLonMsnJk
	kW+i4UvFtqUSLHLgqxVA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZlxx-00ChOV-AY; Wed, 17 Jun 2026 09:49:45 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wZlxw-00000002xTT-46Cn;
	Wed, 17 Jun 2026 09:49:44 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] dmaengine: dw-axi-dmac: fix __le32 on set of CH_CTL_H_LLI_VALID
Date: Wed, 17 Jun 2026 09:49:43 +0100
Message-Id: <20260617084944.705266-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[codethink.co.uk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[codethink.co.uk:s=imap5-20230908];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11572-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Eugeniy.Paltsev@synopsys.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ben.dooks@codethink.co.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ben.dooks@codethink.co.uk,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[codethink.co.uk:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.dooks@codethink.co.uk,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 957FE697B28

When writing the lli->ctl_hi, this is an __le32 type so the
value being orred should be convered to __le32 by cpu_to_le32.

Fixes 1deb96c0fa58a ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
Note, the call to axi_chan_irq_clear() is passing lli->status_lo
through which is also an __le32 but it does not seem to be set
anywhere. Is this also a bug?
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e9d2..8311df2f11bb 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1123,7 +1123,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 				hw_desc = &desc->hw_desc[i];
 				if (hw_desc->llp == llp) {
 					axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
-					hw_desc->lli->ctl_hi |= CH_CTL_H_LLI_VALID;
+					hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
 					desc->completed_blocks = i;
 
 					if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
-- 
2.37.2.352.g3c44437643


