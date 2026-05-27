Return-Path: <dmaengine+bounces-10976-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDRiISfzFmo3yQcAu9opvQ
	(envelope-from <dmaengine+bounces-10976-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:35:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A525E50BF
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6812F3090879
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ACD413D76;
	Wed, 27 May 2026 13:28:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C540F8DA;
	Wed, 27 May 2026 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888532; cv=none; b=VD0T62jUGV6jaeWzK/Tu6GxAL7gIR4+Z9G60DzxUkhbu82Dc+nMgyn4z7WK08KeqgHFLdFi651ISZn9NFY5RG6U8SKp1bSjgjrX9HVnflYJ/IpeHngtXGUSWGyFmiBE8cE6pF/IiPlPRl5mWBiHdhyKrQrULLuGkjPUJgQk1TsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888532; c=relaxed/simple;
	bh=UjTkrlKgTJwEiQPEsetHLUC/6cirW0uQ9Qqe2/6l/co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfp6lzMc3GspeDVLIfExDaThvGi/1yTgStxb5qgX0i1oNfcXe2CHstG9fub5qAndjB74ib6/0nw7PY9geS7RtUsBRLrbXF/jqaTAEuoGMOvf5v1G6Oxka3DeWv1OQXqAk+6ikBznVaKT4L5sBCAHOiwV4OmKPTQw40AJQyyNE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 64RDSecv095694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 27 May 2026 21:28:40 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 May
 2026 21:28:40 +0800
From: CL Wang <cl634@andestech.com>
To: <vkoul@kernel.org>
CC: <Frank.Li@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <cl634@andestech.com>, <tim609@andestech.com>
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for Andes ATCDMAC300
Date: Wed, 27 May 2026 21:28:15 +0800
Message-ID: <20260527132815.1211195-4-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527132815.1211195-1-cl634@andestech.com>
References: <20260527132815.1211195-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 64RDSecv095694
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[andestech.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10976-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[cl634@andestech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.965];
	DBL_BLOCKED_OPENRESOLVER(0.00)[andestech.com:mid,andestech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F2A525E50BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a MAINTAINERS entry for the Andes ATCDMAC300 DMA engine driver and its
associated Device Tree bindings.

Signed-off-by: CL Wang <cl634@andestech.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..0d17580a6d17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1868,6 +1868,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
+ANDES ATCDMAC300 DMA DRIVER
+M:	CL Wang <cl634@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
+F:	drivers/dma/atcdmac300*
+
 ANDES ATCSPI200 SPI DRIVER
 M:	CL Wang <cl634@andestech.com>
 S:	Supported
-- 
2.34.1


