Return-Path: <dmaengine+bounces-4346-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B6A2CF6F
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80B7188DCFB
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342641DFD83;
	Fri,  7 Feb 2025 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBR5wURb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C71DF254;
	Fri,  7 Feb 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963838; cv=none; b=H8xnSUuKwI4L3r+sMzbCBxTvML5lQ5///StBQPY8cKYeELZhmJETsBlx1uuZKkNLWZEvybMobDqcNu7gnr/HT5cUhGTuBuX4EoxP++MMDSirZNhmHvI02rvUq9H6psVpVAOZGOWHDFrC5ht0K6TFfjs8AFVZjjFqDM5SUvjHREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963838; c=relaxed/simple;
	bh=eMHZF1DoORYUOyj/ZZ8qW5nusClbM6PqWbv1Pix9bx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cemgA3xwbHNYyB0V5js7ewzbQHMRe6zxxqqQcvmO82D6xFv7tEd9pdhsCiZcebeZ/XQP/qxpXy1D8jS9X3VyEt/u5XjpmErypCTS57wTmgmIhnQyM9dGPLD/Dp+m8GyztrVnPQ1ovs9lAPh5td5Pcs6KxzXPZixv/8fW0G9rIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBR5wURb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65FC1C32786;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963836;
	bh=eMHZF1DoORYUOyj/ZZ8qW5nusClbM6PqWbv1Pix9bx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FBR5wURbRuGofUwX3skGdx1JxCFVESLiBAv/GnH08tQfthqbiBBq4cbTUy1dehvZw
	 ht1acFtuTNTnsnM3UvNHJSl4aZzHLBiaJ7pUHx8hX6JI5lWM2Lrmcn8HOBSDrIr2A5
	 edZ7uvs9OpL38qyeXTP1JplcHBIPOcBZ/qNHev2LjJ/d2i6o33mSVAzLzQv6XDvwAe
	 yF+IXDTZDos5P3vE9uVeLHp92+rqA5b0gG+ADiHssXc8zzyG4QaUdLcy8b1OtQGXxt
	 ZyEEOVy+iScUVZLU98g9o8mx/Dm1kThZv3gbeawthjlV+QhWLIIbBfWUPJ3gpGT4qT
	 a0T24uUixoYSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B3C021A1;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 07 Feb 2025 22:30:29 +0100
Subject: [PATCH v2 12/12] dt-bindings: mtd: raw-nand-chip: Relax node name
 pattern
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-ppcyaml-v2-12-8137b0c42526@posteo.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
In-Reply-To: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Scott Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738963832; l=986;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Bwo7Oi0fdIfwt2t5GuE37lozFcZAE9exVW1MqG+hZ/k=;
 b=SZzc/30AQUy3Myphn35PzhnrkOhxogqN5IKE9FSo7Vsu0rw8Ixof6uIexKpSYOqpZo3vubTfH
 x4L8/aEDHCICwoOgSwgmZwqJ/eM9pYppzwxGKFGZBkefo7Qh/p8tu1l
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

In some scenarios, such as under the Freescale eLBC bus, there are raw
NAND chips with a unit address that has a comma in it (cs,offset).
Relax the $nodename pattern in raw-nand-chip.yaml to allow such unit
addresses.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- new patch
---
 Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml b/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
index 092448d7bfc5ccd246ca4b2341464e18722a2d51..1c9e3a40d8f9f77115525e5a6be0951aae001ae0 100644
--- a/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
+++ b/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
@@ -25,7 +25,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^nand@[a-f0-9]$"
+    pattern: "^nand@[a-f0-9](,[0-9a-f]*)?$"
 
   reg:
     description:

-- 
2.48.0.rc1.219.gb6b6757d772



