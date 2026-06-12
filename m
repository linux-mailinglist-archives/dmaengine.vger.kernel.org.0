Return-Path: <dmaengine+bounces-11498-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mds2OTiALGrURgQAu9opvQ
	(envelope-from <dmaengine+bounces-11498-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 23:55:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B9167C995
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 23:55:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CT98+UyT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11498-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11498-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8C4313409C
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473CD3845AE;
	Fri, 12 Jun 2026 21:52:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EF381B02;
	Fri, 12 Jun 2026 21:52:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301169; cv=none; b=iLoEJRjdKbElzUMCuHuAm09p3b9CeSCxR2A3wQQn55k+eJyO0QcB4rPdXhHzqvZuHpnXK2fGZ/GWio18B0ur33LcolCjZUAIEs0XGyU4Sp2JuMc2ytsgxyTa5JJP4sbN8ezQgAVzS3PigSNj0hCqamIIY7uHHIB/b2zg7iVHKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301169; c=relaxed/simple;
	bh=Saev/rHSYpIRmrnJ5YLW8IUTvrvlBH+qaVe67sPKts0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGadU6OYFwLdQgh+zOVbN1E6tRwmtBYk7v3k24JyC7c4p8VpWQga5ssZZ7ieNMvnHenU+Dkt55Y2iwj+R1iFU/T2Bxa6xE5zBCiY0om/vubkmmOjFaLYwaZ7ji3lgNnaSEDbHnrbETu3uXqFCCSt5gpXBWsJAIXbqwU1YC4VfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT98+UyT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08051F000E9;
	Fri, 12 Jun 2026 21:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301167;
	bh=/mgJaxjsUKNCc5mQk0mLWPO6Egk9qnKCndvJ4uafpjo=;
	h=From:To:Cc:Subject:Date;
	b=CT98+UyTiOHRp1+zzntxdqkhzI0whaW/wo5sNpx0259IEDY1UFCVpwEuvuVTDkBiI
	 b1F2kt80KbMkA4pWRR8JvBs8jYvGU7mFyC1mf4+N+2akzT0JUT6xj7b2H0w9EF8F6k
	 ASv9qXLK7L1nhYnNaOtU0ExoOYFRYJlG1FXURJmQ3XwwKrWvTrcNJDxC8L1RukFr9O
	 aNOOL0nBUEjBz6RmSNx1vwlD/az1WfHeeyYRVkCxaBPGV1FLsorOPJC8+S5orfrJ8U
	 EjuDvcwHzqc4gzlN/EDR1EGP79Xo+gyiqKubtM8FfpmsHpumjW/OdNhSG9kQu3h4sD
	 lRsEeZvt/OLCw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: xilinx: Treat "xlnx,flush-fsync" as a flag
Date: Fri, 12 Jun 2026 16:52:32 -0500
Message-ID: <20260612215233.1887921-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11498-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52B9167C995

The Xilinx DMA binding documents "xlnx,flush-fsync" as a boolean flag.
The driver read it as an integer cell and warned when it was absent,
which does not match the documented property encoding.

Use the boolean helper so the driver follows the binding. Leave
"xlnx,irq-delay" as an 8-bit property read because the hardware field
is 8 bits wide.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 404235c17353..cbb23fd6e096 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3262,11 +3262,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 			goto disable_clks;
 		}
 
-		err = of_property_read_u32(node, "xlnx,flush-fsync",
-					   &xdev->flush_on_fsync);
-		if (err < 0)
-			dev_warn(xdev->dev,
-				 "missing xlnx,flush-fsync property\n");
+		xdev->flush_on_fsync =
+			of_property_read_bool(node, "xlnx,flush-fsync");
 	}
 
 	err = of_property_read_u32(node, "xlnx,addrwidth", &addr_width);
-- 
2.53.0


