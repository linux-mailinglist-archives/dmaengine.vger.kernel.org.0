Return-Path: <dmaengine+bounces-3459-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479239ADC8E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 08:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52101F24B81
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0678B189F47;
	Thu, 24 Oct 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="RSD2mKmN"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9A189911;
	Thu, 24 Oct 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752662; cv=none; b=n2CgaYoC4X894XHAwqsxatYqSEIhnV9XmhqGG76ng92PCXCkSs2J86+DJHSFCzhybfn+RgDnef5mzaETDwta3NR+Wsz/4J8mboC7PCbRDCCCph7MgU4R7/Joc2am4eRS6OzIZQ6mGh3UUlqbXQnQ7CYS4il8v/+v+2ykFc7ifHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752662; c=relaxed/simple;
	bh=dp+DSjy0O9qZHwMwnoGVEI8E4uceciDPmkCtu2FWcF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzWjbH8DzyqtE3iZWhG0xsbAh6SBqS6BIuRPbx88hxQGVGZBYej3+3GvVl5sSKRuQeLlMzlFo2QKtHuyx9UD9yzYqCqDnSviiL/3looTpaIwdH+gQ+O1hFYQZGEbGPRs09w6pPNGT0PsriKuELw+iU7OrkC3gw/dUYPY886Ttas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=RSD2mKmN; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C22C8A06B3;
	Thu, 24 Oct 2024 08:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=REUvKdAlvm77Y+j57Tey
	GIN8QeQ3OrJBLD44k4+2Y8A=; b=RSD2mKmNiQD3HVPIe4kTtusuYd9QWpcd8NQZ
	2W/K+Ubbmn172cqm/rR7yt9G7bnNq3oxixEe45YKe6qUJ0zQs9UQXC59nnoiqgMT
	J0WF3hlZKxJmHIUTCDN0CmiIjVLaM1DpTTspSY/AV+GCychkyuAIt9E/S994WUez
	/uXZ7X6qKaEoW4xMR0GHkRHNqtdQjLCxcOpjWhp6ILUxCMeZ9ddhcLi5/7qmEGDx
	hR6lpjzoMIKfgC5F4gJIs/CKga1LtQ2bFn9IhDh0A+1/oFS4hVvHUfbysbKDxCpU
	+NxQnlHLX2ISI5nq4ABlfYxYEJCM9boi57vJDUBPvy/Er6qUa5M6RznA6/Q6Jjlm
	ZPj50sZypExkrfWca7qaFaF2ZZDu1VNwTRGX8ZltasSFfCZ5AxweU0gnOjQhaD3+
	fjFOwYdd5ur+24utWJsGn8PmH1k4ILCBfImxbcEzWEangQ0kkCR7sLvZm7fyn07g
	jcqSv2RJ+d4yD784cqdHyxcOU49QHGDkVZlRfqq1tIHDBbPO2XgZG2o9DOpIvoym
	HACMF40TvjiASuvrePIJEjKbmYw89O7rp295Fj+QwMzuytmL914eFdPAWv1HkkKy
	BH2C0V+P6gm2p8Cc8ApgEr7hrOYQYobEPN5ntH5lHd69QuELPIwErihUTtoSJd8f
	CEWxfpA=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Vinod
 Koul" <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 03/10] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
Date: Thu, 24 Oct 2024 08:49:24 +0200
Message-ID: <20241024064931.1144605-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729752651;VERSION=7978;MC=2906467838;ID=135550;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677065

Add compatible string for Allwinner suniv F1C100s DMA.

[ csokas.bence: reimplemented in YAML ]
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



