Return-Path: <dmaengine+bounces-8635-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JGcUGgU8fmkhWgIAu9opvQ
	(envelope-from <dmaengine+bounces-8635-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 18:29:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC7C335C
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 18:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3375B301C149
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FF33D6F5;
	Sat, 31 Jan 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gghjNzsj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17630F7EA;
	Sat, 31 Jan 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880578; cv=none; b=brAqbTUsvaNfwNSbU8D+pMsSiXCLcqc5/4u7xQWVXpwdNkDX/1kdPikZrkneOhcdTYQbbBY544jufW57WgM8WTkN3RhcXk0swqaULfPPhpenhfc/+KyiTk1XgApJEHfI2m1B2o2DoKhLH0g5cXx1MpsR6iz80gSjHPe5qANjW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880578; c=relaxed/simple;
	bh=111sFrCMC2KX1L0YRhT+g514MKW2WAswAFDFNAO9Ogs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4eUfuQQb9dQXwwCtZwrJ8cBdNeKsftN3c5iRXdDDP9Sk3lG46hl1dP2btjW1ubMF5BWvJORZjLgR2KSBdHB8X17ka1Akyx2tjpniCvywXsulCP22igdVFs6SI7FdwcqnB7d1cNp32T54eZpzrTIoSQgxCICoZ6Lt2gpH/F1VIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gghjNzsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB42C4CEF1;
	Sat, 31 Jan 2026 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769880577;
	bh=111sFrCMC2KX1L0YRhT+g514MKW2WAswAFDFNAO9Ogs=;
	h=From:To:Cc:Subject:Date:From;
	b=gghjNzsjYKgZh/eoZdyiIw3GR+7agi7OsItOZfP3v01hFQBOgL9Ta/aLVPVun/w6t
	 FILuwcaTiEe24IO/L96ls+S8sfu8hPJh1vFby5BbiAJo9C7pd+ABwpH/atwvTCqNNu
	 CMSFVe8by5ONiVzCvaPT4KoIEkohVz9JQwlD+KzwrKBW/jqEUg6wyP0Zh5xSn9ghwc
	 TwnoGTgNLBwkpLKLCBGUZHpag1EhcGakKpXzwu31w/8cOCOZTr8py1/eYg9mUVk70+
	 pzd40HYKtL0GuqWVP2T9haPorpvKtM8sz81dJbXSauGjPcp9DkSrCDF3pAXy98Obml
	 8VvVb9Hciw+ZQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org
Cc: dinguyen@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
Date: Sat, 31 Jan 2026 11:28:56 -0600
Message-ID: <20260131172856.29227-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8635-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dinguyen@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email]
X-Rspamd-Queue-Id: B0AC7C335C
X-Rspamd-Action: no action

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

The Synopsys DesignWare AXI DMA Controller on Agilex5, the controller
operates on a cache-coherent AXI interface, where DMA transactions are
automatically kept coherent with the CPU caches. In previous generations
SoC (Stratix10 and Agilex) the interconnect was non-coherent, hence there
is no need for dma-coherent property to be presence. In Agilex 5, the
architecture has changed. It  introduced a coherent interconnect that
supports cache-coherent DMA.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 216cda21c538..e12a48a12ea4 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -68,6 +68,8 @@ properties:
 
   dma-noncoherent: true
 
+  dma-coherent: true
+
   resets:
     minItems: 1
     maxItems: 2
-- 
2.42.0.411.g813d9a9188


