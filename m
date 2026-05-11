Return-Path: <dmaengine+bounces-10284-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJwiJEZ5AWqMagEAu9opvQ
	(envelope-from <dmaengine+bounces-10284-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:37:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E65089AE
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E485830065E4
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 06:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAE32E12E;
	Mon, 11 May 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBMWipPX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F12318EDC
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481475; cv=none; b=hd0dGIIiCwNVZgpxIqhdj0ybcdvLiYMm5+TNRP0ZDMiLtMR6NsdTmkVwaPuyOBC+CEYqUZXsrPCkbQ36XoLn0YcrgfvACr94IXoWA9To5pBsYAWRpjsqfSzLWi1oW5cUdVGUjXyk2KrDrC+4H9+m3FcagsLYiFtc59owsF+1DXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481475; c=relaxed/simple;
	bh=rp9TUgqWsAEGx8ZoT9kL/TuCnQzCen5V/DE+nTxNcxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8FvNMGbXcqqeHVZSveH02a38z8l0bFUQyryJM3+jzU3WS5AM8j20IZvM56IdYd6mkE9LkwncpwSibTOYd0SNpeZpySXFsoVTROcomqwgD42VF66gjR9FD7O8tVOR6BMdzadEmXOAnClxgLVT8y9ANZDAS+L8laYZP2QcgjQDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBMWipPX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba0714574fso21320905ad.2
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2026 23:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481473; x=1779086273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU4crZfic9RXpArU6RhLb52aCOiXrQ2Y+zb7DPebOwE=;
        b=OBMWipPXr48sxrFwvRIhlOuRZ3n4qxZ9o/uGQdN2orJF+wYyRoyQMzjccKZMRDeh+1
         rKHIV2nk9SUekZUHaU/pdZzixGFiVNAGihHQEC9pshNescKp3vDaJzb5N+hu/FXY+feB
         2qja/dDlbEZjfw4ixWUgBTuUsw8vPOtay7g5uJBckv46L0hpZqLdPwYkurB55HLNk7VJ
         64UKdci8sg/Kk+Es04lVFVsSg/HGvu1Sx4FY9Ca7nkddtyAL+eTzcl02L2yh+EL2fOs7
         Wi0DqmOIS3dGBlAfjm6fJCAa5pX3QY9yVKCYVurR67f/hYM56+2Y8gKDGSHfBQcoVVCA
         jcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481473; x=1779086273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bU4crZfic9RXpArU6RhLb52aCOiXrQ2Y+zb7DPebOwE=;
        b=UrRddchgsDA1lvzyBoQVQs1NLhsfOnv+k2VDY/RyF1DlKVN6Nu57LeRS4ehYEwtDa/
         uzCYVeG0X2Ta4vIulH4JZnn51t8Qo/+X+OLFOgTypGWHmAauu4C7dZwxPVkutAEE51KL
         F6Hbyzz0GLiDuD8vnTLEAbTNgBv5YRxisJDxEyruhyctYajpoLhwXKzRaAYL6XeafMWe
         FRp04HyeX/ovto01d2sBd5Kayie47i7dSi4PpPatUhNHqKrwD62TZPlirkOdcEQrBQVp
         tcdtTSr55QCXDPO58jm22WbsYDps9V2Xrb1qfJXKTOOlSGAPPnJIpBGheHaYPXMypJ4i
         ibNQ==
X-Gm-Message-State: AOJu0YzLL9Q4RYKTcjHJSCCbGG1KncfxHACbskWAzBn92N0InaT8Trg4
	g6kO4xqz2Nc8M5H0BkelyfyHCV0fIKn1V58vMKAFRBJFtCwnPitZvBqy
X-Gm-Gg: Acq92OGZEUDFSkQpoLaPIf+1vD87NC1In/aLid6cZxyXYlwIGbc71FxT+JUL1awwOwZ
	Wd+yOt1+SBnCWRfOtU4Q5Ajt7RF/QBkSBKD074KMYxywU9DwaUy/b3sptAIJ6TCZ/Edqlnw9ign
	53CN4b2USLQILUt3OpGBaTF2ycfP+ZYfo4mCY1aBwQJTovmF7qrUTlTc3+Mpy1i5hhmmVE0iDwG
	oncwHJBdoqdBTbaEuIjwauMRcD/i7iINd51iuVI6ZpvSA90QzOo7M1UgALXJ6SoVtFZtzIB350R
	ucURN0i4n8i1q292NW+tvj/N6JWp7VTTzNT0uYhruTdXODFlzVNQDLMoTVErR+mdKTimDMok/R1
	eJlePIpZOtL085gojCB8bXsRKBxCSR2sXygHMjsq53xIS1NvK1kJrNM6hcXS4W9PL3AuGrrAptJ
	V2PKO7GyzXInVcls8DufX7g4g=
X-Received: by 2002:a17:902:ef06:b0:2bc:8634:c35c with SMTP id d9443c01a7336-2bc8634c747mr79731485ad.21.1778481473488;
        Sun, 10 May 2026 23:37:53 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3fee3sm86095085ad.18.2026.05.10.23.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:37:53 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add fallback compatible for CV1800B
Date: Mon, 11 May 2026 14:37:17 +0800
Message-ID: <20260511063719.460049-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511063719.460049-1-inochiama@gmail.com>
References: <20260511063719.460049-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 606E65089AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10284-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The previous version of the binding change only add compatible
string without adding the fallback compatible, this breaks
backward compatibility. Add the needed fallback compatible to
fix this.

Fixes: be3e2a0419c6 ("dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 804514732dbe..0a30a455b0ee 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -21,11 +21,12 @@ properties:
       - enum:
           - snps,axi-dma-1.01a
           - intel,kmb-axi-dma
-          - sophgo,cv1800b-axi-dma
           - starfive,jh7110-axi-dma
           - starfive,jh8100-axi-dma
       - items:
-          - const: altr,agilex5-axi-dma
+          - enum:
+              - altr,agilex5-axi-dma
+              - sophgo,cv1800b-axi-dma
           - const: snps,axi-dma-1.01a
 
   reg:
-- 
2.54.0


