Return-Path: <dmaengine+bounces-11931-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9anvMaU2RWrn8goAu9opvQ
	(envelope-from <dmaengine+bounces-11931-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 17:47:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2DA6EF5EA
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 17:47:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=mHpvIqwN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11931-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11931-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB0F9300A4D2
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB83B3894;
	Wed,  1 Jul 2026 15:47:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA593655D7;
	Wed,  1 Jul 2026 15:47:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920862; cv=none; b=taWc4nCy6Uf3Qui21pZaIvzO1fdPvlye6/mE3DjstpeN9t0+AlXsxY5BCPNdApnK8KmiI4+EZQ6sFkYQnPQQWA9IyvsDYQJI7e0g4rNrfPRd3bxXPLXKQwk9OoJY7h0RFny2EQZt1KjUd3SMOn87z+IeKVXwdJiB4rp9BigmWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920862; c=relaxed/simple;
	bh=Ky9AIH6/lq3FHpbsWjW7cQtA0kjqF07M4MVwKxOHcRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gI90PNxs7g0mratJmUXH9mIGLDRotabS3BP7g9wxj3YBQ7Ur4LUK2q5i8SkH8KVtL+vd8DkMhsLp+J8yP7KGlW/tjI+OLSwxSu0QfyWsVjLHnuGzphsKImMM3Gyal943cOaTnQpCauJVis9H2vCAo3QN+nI5znhoY2Jbma6H1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mHpvIqwN; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782920859;
	bh=Ky9AIH6/lq3FHpbsWjW7cQtA0kjqF07M4MVwKxOHcRs=;
	h=From:Date:Subject:To:Cc:From;
	b=mHpvIqwNp84u6/vvEm9g+BG98EFMuN+XKb/mWOpwbdTBqqkoW4jbvWpoqticz77at
	 tJaBSxNVfU5jTcA1Dqy17ROjbdQR0XdHldSAIWOLdSoxLDm4BtTNZ2fl34Ak6Qy3hi
	 xtvYsRUi+bmjICiJCukTyrwjy5VzY/c1sXw1WGSmNlERYFCjlR7x1lp8bS8T/Hsjm7
	 w9w/eaUo/5beDO/ZqtzTUnURFVyvqegw3C4pWlLStn7+tvygo222Pep/zk2+ZPg5j1
	 H1imdLxDMYAlFoClXT+8W2O3OQPV78xgbfEwfMxEQshAM9ZNrhysQYvVnoNO7dnq4G
	 9tTShUonVWYPg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 093D817E02CB;
	Wed,  1 Jul 2026 17:47:38 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 17:47:20 +0200
Subject: [PATCH] dt-bindings: dma: mediatek,uart-dma: add support for
 MT8189 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-mt8189-dt-bindings-uart-dma-v1-1-c7106216a40d@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6DIBAAv0L23E3AppT6lcYDyGL3ALaAxsT49
 xI9zhxmdiiUmQr0YodMKxeeUwN1EzB+bJoI2TeGTnZaPqXCWI0yL/QVHSfPaSq42FzRR4vBBO/
 IPDSRgVb4Zgq8nfX3cHGm39Im9ZLgbCEc5xi59iLRVvEc6buE4Tj+p2kPCp4AAAA=
X-Change-ID: 20260701-mt8189-dt-bindings-uart-dma-f8fdbe856ee8
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Long Cheng <long.cheng@mediatek.com>
Cc: kernel@collabora.com, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782920858; l=1072;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Ky9AIH6/lq3FHpbsWjW7cQtA0kjqF07M4MVwKxOHcRs=;
 b=ofMvNwFJxd2WVq31avixKD4TbRj35vFDFtRR0jcj91McrJ+rG7GfQZ47Vwn2QS6H9O8ZGXCOp
 xmk7QNrBj7BBEHNOkJQLU2Oeu5O4fFX1HVyVk6W14l0cMXrxUhzUck5
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@mediatek.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:long.cheng@mediatek.com,m:kernel@collabora.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:louisalexis.eyraud@collabora.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11931-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,gmail.com,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,collabora.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E2DA6EF5EA

Add the compatible string for the APDMA IP found in MT8189 SoC,
that supports 35-bits addressing as MT6985 SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
index 3708518fe7fc..bba20e88a6dc 100644
--- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -40,6 +40,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt6991-uart-dma
+              - mediatek,mt8189-uart-dma
               - mediatek,mt8196-uart-dma
           - const: mediatek,mt6985-uart-dma
       - enum:

---
base-commit: ba7c57499e5999aeae8dd4f954eb2600589d80aa
change-id: 20260701-mt8189-dt-bindings-uart-dma-f8fdbe856ee8

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


