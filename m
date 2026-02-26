Return-Path: <dmaengine+bounces-9124-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNq2LFzWn2kYeQQAu9opvQ
	(envelope-from <dmaengine+bounces-9124-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 06:13:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037821A0FEE
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 06:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 377B43015724
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 05:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7253389DE0;
	Thu, 26 Feb 2026 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxJn+/FQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A9287253;
	Thu, 26 Feb 2026 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082745; cv=none; b=BJVc375YTEU5W2Rx/fd/bGP3CeWcgRHuy9xLE31kvhpnk01EOS/d2eSh/w7OAOSXV/mMs5eJ48/2ujgMD2yZ9IjMOvQx1JrsB8QkOxcTLiNC60hhUSDQevGEFKXK/GXqD0YUmQSXlAADo0FqXeoq0OGVYPp0lXFAwPJ7GMraWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082745; c=relaxed/simple;
	bh=ylk3+PwGHSF4af3iWtOwVBcvgxKwhdl4uCvtpQxJrtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aU2dnzKo2rNku6LtDIV5BiGbTdpveQ8tiywNI8SZ/MxICOtxBsxhFYmQD38QYl7GQR513dq/4AvYJepsuRJKlVb1MStAlvtEUyTmfxxkWOH/exHSQRWLoKmoTE/fSELhORQRnj1GmScj5qHG7EOG1IWlHVzIf8MbR8jm4XzPplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oxJn+/FQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MBwNyNwsAXcXiZseHhSAbS6xtXvxrsrDgwhLAPWdzLQ=; b=oxJn+/FQmqNLZSXcQwhq5Xnapg
	Yau/9KheZ0Rx8Uo47rpSBB19BxPoto/C6qLsOYpqd+S40TygLNxmxde1aAMUcgkNJJE/ExHo2dbu/
	tZoWp+wtIFzEo1qqKDso/dHM5owNNZ/WaoyhG1xXDtzacrZMMERuZfOoyh2YV0U0Q55Org4CncY03
	boJoMdqzoiMMsFJQugMUbDviOVD1ndHSXrxwhEFTKKv+ao7B7LbCsSe9rqs5/HlmMTccHA7u2NhTj
	lR9cWSYt3Q5svQKyzd/SkID1RR7E81nv/eHSLR9LH7uS1C9NnI82mj8tufIb/OsGw3Y3OObUY97Lh
	xAftGVhQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvTfh-00000005PKh-0yCG;
	Thu, 26 Feb 2026 05:12:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dmaengine: fsl-edma: fix all kernel-doc warnings
Date: Wed, 25 Feb 2026 21:12:20 -0800
Message-ID: <20260226051220.548566-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9124-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 037821A0FEE
X-Rspamd-Action: no action

Use the correct kernel-doc format and struct member names to eliminate
these kernel-doc warnings:

Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
 'dma_channels' not described in 'mcf_edma_platform_data'
Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
 'slave_map' not described in 'mcf_edma_platform_data'
Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
 'slavecnt' not described in 'mcf_edma_platform_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
Cc: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>

 include/linux/platform_data/dma-mcf-edma.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20260225.orig/include/linux/platform_data/dma-mcf-edma.h
+++ linux-next-20260225/include/linux/platform_data/dma-mcf-edma.h
@@ -26,8 +26,9 @@ bool mcf_edma_filter_fn(struct dma_chan
 /**
  * struct mcf_edma_platform_data - platform specific data for eDMA engine
  *
- * @ver			The eDMA module version.
- * @dma_channels	The number of eDMA channels.
+ * @dma_channels:	The number of eDMA channels.
+ * @slave_map:		Slave device map
+ * @slavecnt:		Number of entries in @slave_map
  */
 struct mcf_edma_platform_data {
 	int dma_channels;

