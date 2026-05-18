Return-Path: <dmaengine+bounces-10494-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PRzNq+ICmrt2wQAu9opvQ
	(envelope-from <dmaengine+bounces-10494-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E9565700
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E1153002304
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 03:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5D349B16;
	Mon, 18 May 2026 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Hv+Ec8hg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D7219E8;
	Mon, 18 May 2026 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075242; cv=none; b=FW0e8nQkZRYz8oPSsvuUKevo3Ygca9ITyWoXEbjnHv69pkEvY1IgCvzPz1gyb1ipXhBFZC96qV2uYxg5ncaMfNdJWIe0VjtoHDAHZN7Tqtd+F9nliOTLSq2XfUJEkt7IONShuTbP4LIaO8ZgLkLW+AJ953SqWQsjPjHP0R2JE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075242; c=relaxed/simple;
	bh=Q7iJZ6VUq1H8Bt3WwDMb4K4clOEXomOap5ooldumwW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdSmmMoTwIQ3kD+9tnyB82RyQqx1Dmwiphyf4rzW3sA7QOSyqKqRzJ5u2llxz4W92nZ7gHashZZSE0htBHJJFbc9MZ2kHVA8C6Lh0e2mu4yJlKO/b6TelN1n4HlQb+HHu7zWYhcCwh8yGX16JuMwNCg6WoWApq9Hwqx8sZg5ZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Hv+Ec8hg; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1779075179;
	bh=gy+vLIjyMT6857Vtois325dTt+YrnhLSIrioPPR6St8=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=Hv+Ec8hgUmMLye2OnkQiMFf6pNZglDWaHNm5otFpf3mbNPl5A1P047LEhZolhwCTL
	 amNTCigG8Og5Y8hmBiSfG0RwyPcS/3cQUE0osyzpbZCpdReQUy3SK/2QcDYkJBNulc
	 F3VaOhavKdoBGuRAeeladZdrp2Ei56vQy+z8hg2M=
X-QQ-mid: zesmtpgz9t1779075171tf46ec625
X-QQ-Originating-IP: DRI+fk7/Uf0YrY164m/MNKWpAys+m6hYORxEOfYA7Og=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 May 2026 11:32:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2042237181081148708
EX-QQ-RecipientCnt: 21
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 18 May 2026 11:32:41 +0800
Subject: [PATCH v6 1/4] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 compatible string
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-k3-pdma-v6-1-67fdf319a8f8@linux.spacemit.com>
References: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
In-Reply-To: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Guodong Xu <guodong@riscstar.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779075161; l=1136;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=yaSmXSO5vYt5nKO5ZoIxkQx6dxueeCXO+Z09BlgFE88=;
 b=W+5F5yNPpwe5k4aNvILetfG8MTdaq9zRwfU6oC4yYxh+ievsDveayf932kijLZHal5EV7LC30
 PZvbYXimU2DAWfDHmLPX+hwbP9b2HvQFH3223XiI8PRhWzmrEK18hCk
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M8UYpcaD4/AyTVxWAAid9s0jQq/BAhkHQDxth8iqqpCeSeac47mut5LG
	k6jnognRm1gzKbPOc3aXX9xe2gs6wNeyNVqOzXXOUw7/Vwtciw+PsE0W8Nthm5FLLUCozrd
	5qn8yh5MLMjTluoXNLp35PLP+wKza6/8xkvugg82cKVoBNDJXDY+4UJEVsfxPicVwKXRPMq
	GV4PLya2EFlYNM8gWjllIkwhyPz9eTVR4UkBoxWl/BpI8kWz8+9uFTAQz1sA8e9LM3sfx6F
	iihIxirk4b6LZ9OusD9HLPIABOLDGeagjIWfxlezfdD1vjzJ7dPGuC53AuLQYrXXbrTy4u/
	+USwITUWmmy5WrzO77Kjm+gelIeIg9pNBLoTKxpayctCrHgWrr+TQk89W1qI1Bp1oCXRzAg
	3LSl5C43E7XFP30TlVII0x5ZgfwNJhxhaUjSzSaA8b7cfbP9sch3OgeaeH6cIIN+oC3QawA
	hXiEOAarfuKhwOUFboe/Ydf70Ijo6OWdHEYnOtE5op5lSOXqSPV4e3yDxbBPyoPdByIJxbU
	f2D7o5s7AKNIOcebZnxA0yE1NDKCOkupGMNFQ4G+DqMXnk8k/7gUWGC+oHnAFs6Hl3nD4w5
	2ZdoOgg2r6Th4A7UszCvYzG4VL4piz7XTc4USzY1Aa/aFwK9rX7sSd1/sefx3JO7n488w6e
	Y43Lw0yS7PyAUyb3oOKpYdZYiWE8jIEdDAPbR9fNkJMJiZcnr7EgnBuGQ6Q3XbEosvph58X
	0rwc22E3AFpZzTh3jTsFGeJhkNp1XUNUds0RZchr5z4YXzCE+9v5W414ZCYX4XHPdXoq8LH
	iu4DA7pIjK59ZeuKE5Yu1bUS1zXPw3SMiUgQWNXV08gc2sjf7dYandyZdCgt69DASOViZUM
	7oFJJpA7FGpMm6ZnrfnaGv0Ub0uRmFtPtHY+uulZrJBLjZnxV51Cti4foKcVqZvnft7BrP3
	rMjKJq7EZ0ONHPlKDJsrTC82LIo/cEArKz19GiJlKaPL+DPPkJlX860AjgC5MLFsj97rM0/
	GSdbhzaDl7+XvEc1NMajSdnA0FeC8DoVV53qtUfUh+G4ihYCAqHWoKspNW0IZstM6yfcoXi
	5AQJ6jhkMwEUplRqnF5S3sUsOieLXoyspkW9lWaNyJUqE3QfxC7cxpOKJOIzI5M2Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 2D0E9565700
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10494-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,spacemit.com:email,microchip.com:email,linux.spacemit.com:mid,linux.spacemit.com:dkim,riscstar.com:email]
X-Rspamd-Action: no action

From: Guodong Xu <guodong@riscstar.com>

Add the "spacemit,k3-pdma" compatible string for the SpacemiT K3 SoC.

While the K3 PDMA IP reuses most of the design found on the earlier
K1 SoC, a new compatible string is required because the DRCMR
(DMA Request/Command Register) base address for extended DMA request
numbers (>= 64) differs from the K1 implementation.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
index ec06235baf5c..62ce6d81526b 100644
--- a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: spacemit,k1-pdma
+    enum:
+      - spacemit,k1-pdma
+      - spacemit,k3-pdma
 
   reg:
     maxItems: 1

-- 
2.54.0


