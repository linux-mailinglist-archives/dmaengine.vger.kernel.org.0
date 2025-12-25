Return-Path: <dmaengine+bounces-7951-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C7CDE04E
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECA533007968
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A204224B15;
	Thu, 25 Dec 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="rKSid7x1";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="rKSid7x1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DFF4F1;
	Thu, 25 Dec 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766686530; cv=none; b=Pt9nig5iUih8+1IvUkZ3WyerbGLXo1bzwXhO5nsuQiZ+QKbfs5cCD/gGoy7gth3UfVFYd2obiBG8SWcWxx0T6rDxz/IGUxy7RAvSfcFBwjQMYUcgDu4fTv72hQmPC2IHfb/SoVQs1LYe8hpA/E7a7mzjLjiX8YVBzCz7aPfUWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766686530; c=relaxed/simple;
	bh=tNowQMQMzpnovUwXiG0zD2EcvOR26dswqhTFIyI8BxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSSKw7HdIaxf+IbMvXocKxwgYJNlx3D+4SeGZWZ7o8onG5Sief7bHQxcWXYjSdTnkeD/hgL0gtkwUR8bDCrc7AtDOJ/nvw60W70lZvcTmWavtqCRMfyfY5LVx5Iwx2l7SROLCAMBsa93aGISz9tAHzKiAIgHwAd5ZNroFXZ5Ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=rKSid7x1; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=rKSid7x1; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766686526; bh=tNowQMQMzpnovUwXiG0zD2EcvOR26dswqhTFIyI8BxI=;
	h=From:To:Cc:Subject:Date:From;
	b=rKSid7x1KCEiIx14Eo9Oj1Z6oJ6D7ISGnMzLRWj36+lCHTAG/XkTMX99edC9BhGVE
	 Egh8oUqiH9Pn1hUPUTvjcV5EPXORnEMi/O5IUu/8Tsp1s3GKRtgBrYskK7l2x5F15u
	 5nuj5/TBQFQoVzRRH5QMnoeOfFg732mz56Rw5+yNC9s9ZgdYxgSwqPdG60nssP9zy2
	 M3gZBsh5KvDQ3c+zT0Khmt87xpo8uV72TuHmlNB3RDVBk1t3XoMkbu7uKa13svTXzh
	 +E0femCur+OhxhZ2jkhoChp2pceCD6MgY48T4jJ2F8qjCUE1Milub2bG6y/MEdJSjj
	 0vdshHGptHxDQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id DF15F3E8C62;
	Thu, 25 Dec 2025 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766686526; bh=tNowQMQMzpnovUwXiG0zD2EcvOR26dswqhTFIyI8BxI=;
	h=From:To:Cc:Subject:Date:From;
	b=rKSid7x1KCEiIx14Eo9Oj1Z6oJ6D7ISGnMzLRWj36+lCHTAG/XkTMX99edC9BhGVE
	 Egh8oUqiH9Pn1hUPUTvjcV5EPXORnEMi/O5IUu/8Tsp1s3GKRtgBrYskK7l2x5F15u
	 5nuj5/TBQFQoVzRRH5QMnoeOfFg732mz56Rw5+yNC9s9ZgdYxgSwqPdG60nssP9zy2
	 M3gZBsh5KvDQ3c+zT0Khmt87xpo8uV72TuHmlNB3RDVBk1t3XoMkbu7uKa13svTXzh
	 +E0femCur+OhxhZ2jkhoChp2pceCD6MgY48T4jJ2F8qjCUE1Milub2bG6y/MEdJSjj
	 0vdshHGptHxDQ==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 5A1153E8B7A;
	Thu, 25 Dec 2025 18:15:26 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: pl08x: Do not use plural form of a proper noun PrimeCell
Date: Thu, 25 Dec 2025 20:15:19 +0200
Message-ID: <20251225181519.1401953-1-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251225_181526_930463_BA1F4DD2 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message. 

As a proper noun PrimeCell is a single entity and it can not have a plural
form, fix the typo.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/dma/arm-pl08x.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
index ab25ae63d2c3..beab36ac583f 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ARM PrimeCells PL080 and PL081 and derivatives DMA controller
+title: ARM PrimeCell PL080 and PL081 and derivatives DMA controller
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
-- 
2.43.0


