Return-Path: <dmaengine+bounces-10101-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNuwB74o62m1JQAAu9opvQ
	(envelope-from <dmaengine+bounces-10101-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:24:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78645B68D
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67E3A3037422
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137E232860B;
	Fri, 24 Apr 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="K+pJdg3o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21331A80E;
	Fri, 24 Apr 2026 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018939; cv=none; b=e1yI6H6P1OC8r6T+diZQfKh1HpqdJdTIutbD/B9CMrUWaeCm5WXfOrNIU6c6Dssn/WZkL3hIFuanIKfwSE6Yrweg8s98oeU+ta5wR64SBsttX1KJ0TlrMllfL6yMSeUW7sAVOeC8EFxBTvYGwTfrNyro4u0Z0cXpugE15AA5Ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018939; c=relaxed/simple;
	bh=FHzNWN6py8dgaVDL8Y8DSxgHBZLKjHjm+xoQXgPNxCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5TV892S0oiUwGLH5qcP5D8BNyZG42VooLHlcxpOhw7pr6WYqxqcd62Kx6KRccbo3yduXvOA3nn7W0hdprHiIR/R/5YIFm3O5LXJgkXDod7RV6qhx4CySowGwkhhdX+JwGkINr6X9x7qHhu1459ESGMyeAOMqgt8ngKdR5sxZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=K+pJdg3o; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1777018875;
	bh=brvNO4gsNvQne038G2C4scixZLOaufrseD/dFebxobM=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=K+pJdg3oY4n+fOHf4tYwxc26BDaSgN9tfwpWuluyEmOgz0EGGuQV72kBlWL0CmUha
	 BLXqTmbQpbVaQOS0QlQpGvNP4TN0GHHZpS6Ri1kjItl6Ox0fPmuviB0MvY9d1X6yxn
	 wcJ+MnWFR4WC4tA7gq8qkAGsFCsYqj32+asBCbJM=
X-QQ-mid: zesmtpsz6t1777018873tb1ab1047
X-QQ-Originating-IP: ufEdjdipWm7MGu+Vu3Yk26YwIrbAkY8MV53i3lNL3ro=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Apr 2026 16:21:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1477805861798057828
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 24 Apr 2026 16:20:29 +0800
Subject: [PATCH v3 1/5] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 compatible string
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-k3-pdma-v3-1-efdf2e414a08@linux.spacemit.com>
References: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com>
In-Reply-To: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com>
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
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777018865; l=1083;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=Lo/DwZzuoZUiWvEIhHh7o6kJxCCRQoshN/v5iQysrmY=;
 b=vnCQ3ZLAs9KSQIQnKxxJvybwJqfP/CL41CYNlk5lBFzIuIXAy5Vfjir+tJ9zfG/3FzU1IBUo/
 JtOShwruYsmDrmsPAwEtoEvZVUD/xw58L517uzVgSsKfQ7ka0FVF2pK
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NvH2zBBgt3uT3LqkNSbETk4XKvG8OIUj+p436IV9O2xhzCTBcY/AdgX5
	MsEFhI4z9FzVHYTkmLyVvxKU72gdZ7tdcnHc1p7qipATbtUNPrzWviUvNRxfXQtcjlaf7ei
	mwJf17awioDD6nTx2X5JrEJgPJCp8chBKCPlOaIhnwJhdV+sP4Pd9rWNhjkzZVsUQtj7M96
	YB5azintr1nfrKSIYUGatdF+kDRSMxrhQa1mpASE2XWJn5EpBYQTVJefF3H3vPkTE9L+zx9
	zK693npWbynorh4xaIfCFbV7bgVUE+9NJ9+UjW12H2oaj3BT5NDW5hbxDYsHBi1vryABYJw
	fiHBUgr2eLV8sDsSRWy2ZHlitk1OPb+gEUBwxgNvnQWnNHdT92wn+HaW23Nymt0dnOZR4KQ
	/RXbkD7/kq6HDFSynsO09llYnnJ9X4HwK0ovbfNlKmRu4S9GWvfIrw7MvVl2HxhobElnZTB
	hKHw3r4X1hQTyM0ZFGjDk/tqcNs8uqxubBB14/+FI1E4UduZms3aGenuvAXaRnXq9/qA3F7
	qx9X7GKjuJOqbNFqBVJXWF5UpO+n3gqx6cxIIbf0e7hcYVRi4LQmMocXP94UGIFcf7DQdF9
	Tm1F7635RHbR/WOhQJPMBRvQsfxggHkHNQ5v0D6kuLbF6vwsD6vCKwfox/KlN6Lj7bUua0e
	5rTOEs0AynqW01secAnIFg0TKEP+EgyNJpJP1DKk8KCh/KfTLevBEyeW2J5f8zxYOWhIaEy
	8GFeMiDm37VaMPvn2xullOwqSPObHt00crPj2P6flxueXbOHTl2ntEnLXJ8V9fsrwolKOwJ
	XxWPfYqlflz57p3vy4OIwqHWucJM2BRSvZHMOwa0dMSy8FcClZ4uSg7ANZyOfrk5uLBOCcH
	iGjiwLbPoQrtNsZWOaY0zmBwLAuOn/bkf/lp28mUsCxK9EidK9efh4c+twpF2whev4NDTue
	5L0wErhUoPPgXgi4Zs0+Woq4BkElL0jPoJdPBB7946adBrwdVfua50ADqw8DrgcBlMcYzWE
	Mv2xY3b1iMMlGYbPOfc6s1tjluk6VXHBXN1F/ou0SNCwVPzeDZYS39M9LBqBM7ZsPClIiag
	9NzOpoMoo8OHX6mnNQzJD25aUR8lkJVMW8Rnu9io4HE
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: BE78645B68D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10101-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spacemit.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid]

From: Guodong Xu <guodong@riscstar.com>

Add the "spacemit,k3-pdma" compatible string for the SpacemiT K3 SoC.

While the K3 PDMA IP reuses most of the design found on the earlier
K1 SoC, a new compatible string is required because the DRCMR
(DMA Request/Command Register) base address for extended DMA request
numbers (>= 64) differs from the K1 implementation.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
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
2.53.0


