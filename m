Return-Path: <dmaengine+bounces-3771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AC89D61E4
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 17:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D57B25BF8
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C21DF250;
	Fri, 22 Nov 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="PAL9MxsD"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880161DF755;
	Fri, 22 Nov 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292226; cv=none; b=Qeq4lumISmaaVYitTiVXMKmIDx4GEGA92Oxrh3iqKvxdOi7kzNyQR5Et6KCXxUhn9QVgpqwrpATKizOl8YzE4c96WCAdzqawWjFhmOYIN36/G3HBIXGfwnvFNGrf9AHQ3MrrzWHoWKqfa0GFa3A7TTMu0y/kXEmLmwEuibrsfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292226; c=relaxed/simple;
	bh=ir6r4uve2AbZDqjyE5oHzV6jdFhDtSE6EcSXfu8OCAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc50iHQ42PPQrqpWEL1P4LJZQbU1UtPpwzl3n/Nsd0PrWrqcnUlMW/Oxm09ZSx7YR+VsnB5qeyGaJzASht7uiYLZZc/pUzTMNtNuw2hMPOu2UiZudWwUhw/gccAznqlYPikwvHBrZI5azs97qntm02ER124ed1c+JOqCoGcMpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=PAL9MxsD; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E7047A048D;
	Fri, 22 Nov 2024 17:17:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=IJZcZJ9UkGG88e0G4cRY
	DgpG4uPgV6cApvRZoFsAFwQ=; b=PAL9MxsD2fUN13MxW3PTlRXDEuEgueRpIMkA
	YdQ6l31eY/AHQQUaXxyX3aPkj8y9tQPjblAl4m1e8X/6ErvyNUiJqlsuPCPyFR9q
	kza0etZ8VJGfZwkXIMR9ybxmr9oNmtAc4B5YjDWONFf/Kx3kwHO03B0sJ471Gd55
	flztN1VxxJvHqrX1I+v03hMUIMWCgTVpl/RfY5CfwnAh4nCO1dVmGYQQEQuZyKz+
	4mMAVMvgfsTDwTn6BHccPmYbrI0LfeEYNQMDkLrxCeG/leLsvjUGBDGlaUD+rv4/
	NX8wkyJBB1RtzKxNwCh605HaCTIZPvColES0ZN6/taCjksvOpeXiESsNkNmREiOT
	059Zrenfnbf3SHVRASpmKXYRwREBZLDNBUQ37txQMrFba2AVnQqpNIk6AMgtsXfv
	CnweBToegWAlJlJbjKYIb0ZMSA20PnE1GlNZ+lHVGhVtfWPmoKGeXm16aOnZArMH
	Tk1sqlY7WGvLLh9hCIGcIQYoSYLS69SGfa19i608Ypm15TLF0MLXuQ1aj9SdScUl
	EE4iSneFJwGC6DjdnD0aWiINViXNxHQWCkLXuhdDH3n77MjwEgTIFy1mwBSApOhx
	LCUfTzH6ILbAoJFeH6LiakW50ZztcHssJI5rr1o6FYs4KMruiDfF5nNwruKCk1kd
	Ryot9YU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 3/5] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
Date: Fri, 22 Nov 2024 17:11:30 +0100
Message-ID: <20241122161128.2619172-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122161128.2619172-1-csokas.bence@prolan.hu>
References: <20241122161128.2619172-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732292222;VERSION=7980;MC=1574022941;ID=75610;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855607263

Add compatible string for Allwinner suniv F1C100s DMA.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
[ csokas.bence: Reimplemented Mesih Kilinc's binding in YAML ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 .../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
index 02d5bd035409..9b5180c0a7c4 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
@@ -22,7 +22,9 @@ properties:
       number.
 
   compatible:
-    const: allwinner,sun4i-a10-dma
+    enum:
+      - allwinner,sun4i-a10-dma
+      - allwinner,suniv-f1c100s-dma
 
   reg:
     maxItems: 1
-- 
2.34.1



