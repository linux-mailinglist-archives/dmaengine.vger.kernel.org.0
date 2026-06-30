Return-Path: <dmaengine+bounces-11896-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zfaLCW0gRGqrowoAu9opvQ
	(envelope-from <dmaengine+bounces-11896-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 22:00:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E8F6E7B3A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 22:00:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=kaiser.cx (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11896-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11896-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67094302CD32
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA3364927;
	Tue, 30 Jun 2026 20:00:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86439DBE9;
	Tue, 30 Jun 2026 20:00:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849642; cv=none; b=Onv8hPk76/2X3a/inJU87ttMsFW/TURGH3je/1IbxO9KOl++uvMAJKVVAKT22MJaYlFJqtzs2BGDFKC3uvuYdKrgBGotfJIaqiYkhe4Ck2g2g6GFO/ZJSr2rkLDem+ZaKeUl/NSbtuOKta1RCXZGJ9uo8c9v9TWVT+EsH6BKwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849642; c=relaxed/simple;
	bh=D3Y55NQcFxqGkbe5kqmU6GpsSL8YwbnDASIQLku/BIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QU+T0t4G2YPMM+CXz9M1tOWoBGW5T0ucrKeDozjFgYLMDFrASzdLAu8sWmKxdlQLv0TiI66JqdKA5uAX0aO1mV5i/nGSDEIicHUU8yA7y95j0ivAFhwZuo+LvGFIpLk6vS0WRkHZvXFpsGZy8M3XfAZF6gug2pprnqlZ84rvEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1weedH-00000000LCC-0iJs;
	Tue, 30 Jun 2026 22:00:35 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] fsl-edma: tracing: no ptr dereference during log output
Date: Tue, 30 Jun 2026 22:00:11 +0200
Message-ID: <20260630200022.1826420-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[kaiser.cx : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:martin@kaiser.cx,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[martin@kaiser.cx,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11896-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@kaiser.cx,dmaengine@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kaiser.cx:email,kaiser.cx:mid,kaiser.cx:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81E8F6E7B3A

The fsl edma events store a pointer to a struct fsl_edma_engine in the
ringbuffer and dereference it when a log entry is printed. At this time,
the pointer may no longer be valid.

Event injection can be used to trigger a crash:

$ cd /sys/kernel/tracing
$ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
$ cat trace

The log output needs only edma->membase. Add a membase field at the end
of the event and use the new field for log output. Keep the existing
fields for backward compatibility.

Fixes: 11102d0c343b ("dmaengine: fsl-edma: add trace event support")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/dma/fsl-edma-trace.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
index d3541301a247..45d964a3726d 100644
--- a/drivers/dma/fsl-edma-trace.h
+++ b/drivers/dma/fsl-edma-trace.h
@@ -19,14 +19,16 @@ DECLARE_EVENT_CLASS(edma_log_io,
 		__field(struct fsl_edma_engine *, edma)
 		__field(void __iomem *, addr)
 		__field(u32, value)
+		__field(void __iomem *, membase)
 	),
 	TP_fast_assign(
 		__entry->edma = edma;
 		__entry->addr = addr;
 		__entry->value = value;
+		__entry->membase = edma->membase;
 	),
 	TP_printk("offset %08x: value %08x",
-		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
+		(u32)(__entry->addr - __entry->membase), __entry->value)
 );
 
 DEFINE_EVENT(edma_log_io, edma_readl,
-- 
2.43.7


