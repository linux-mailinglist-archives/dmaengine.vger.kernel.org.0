Return-Path: <dmaengine+bounces-3659-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A49B7AAC
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 13:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEED01C22A31
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587819D07A;
	Thu, 31 Oct 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bsBp1wd3"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D219CC1F;
	Thu, 31 Oct 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378194; cv=none; b=Tn5hEbV5THwdKPyrfKmx3mivTIK1c1r6iEx5GaFcm2KFYG3C2xoSMdoVk/SZEudQrPYShqtq8j2kEIaSFNBKdEpC20oJtjfhRmgZ3Dx3u1lAfGvAu1TSByy+afT1IgXFg4/geBaEYy+LAyPC2eYObQgi/N/1D2mpbmBCxy7sf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378194; c=relaxed/simple;
	bh=on+3n6AX8EH0bGq2EJvJqehiEym1ZHFWXYiM7nG3xAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNM42JhAudviJOiuh3F6cj6OjSzWcGg8/u05tx35mnz2fPsipoiFpNy/y5oL/J/+GEyKt2TPqHKfPGTgGnZZKYPXVLEWez8eqM4FsdBtkYXVyhGSREHC9fFQ4/Swr7EyVJLxU22AipDEZ2BEvFocCQP4jX9KUgblfowTxu7i75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bsBp1wd3; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3C8EDA0E1A;
	Thu, 31 Oct 2024 13:36:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=EWnfSa/E3TDYuPzWXzSP
	ismhOqK3UCMzs66VsrbxYl4=; b=bsBp1wd3R7oxbjn+pvTcVaPs1IEbBjigVzho
	8liOxlU3iAnxVSXxrT4Qp/Hz93vf6xWdKq5TWt0x5F05znD6GF9poIZaMj+Q+R3X
	EEPbYIRdHmr8GH2e7C36mc6blHdXCCwyjbXP/IsaTFky+Ni4gozKOYhQ5KjtJsVr
	cyRNUTPKbSQhM8mxovvvsera6vNT1UGTojfnR9yOMdcTGwL3U4xt/q3FLJC3BV91
	D/qEB4UXHAan/kBJ1fjv9B/9JNKVFg5kvCAwPt7Re80HIxdPBLceVfw7eUriSElT
	GDPdq0dxOZNMJswCqDnAce8SB579WE8qJOLqSeauEXIbRLIBq2EglXHFXlSxh1yu
	SL0ngDczD3dnWrYqqX0axBnITluqlhP01avLcxt5cMw04tmol7eJbJlhxzCM/v3S
	Wigi5ur/mVpdAV94l3TwUHYDWBpxrttkpRXRv/iUfg64ULifiTFeg2eyUd6AXI3n
	DoGg69VFtORNDBEw83qXEUlLxYyFg9tM6ddzSSwLEuvw7dB/75tweSLBrNEO5Lzk
	MoQuegi5J7Q5jz6Psn05Tyt+BOH+mkvBWI6Qgik7EtiDvZIXw2VYHw1+Tf/nixak
	nPvCOP3unr29hjGnGIPVsTr8HdKW3M2sYKJ+yXY+YNjrcZLsJ2lW+yI/3+PfAjXt
	ATKHe3w=
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
Subject: [PATCH v4 03/10] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
Date: Thu, 31 Oct 2024 13:35:29 +0100
Message-ID: <20241031123538.2582675-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031123538.2582675-1-csokas.bence@prolan.hu>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730378189;VERSION=7979;MC=2199548629;ID=207183;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667667

Add compatible string for Allwinner suniv F1C100s DMA.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/linux-kernel/20241024-recycler-borrowing-5d4296fd4a56@spud/
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



