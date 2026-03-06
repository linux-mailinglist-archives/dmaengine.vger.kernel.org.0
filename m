Return-Path: <dmaengine+bounces-9305-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMqMGBztqmlxYwEAu9opvQ
	(envelope-from <dmaengine+bounces-9305-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 16:05:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1112223669
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD91306377F
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566123ACEFA;
	Fri,  6 Mar 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjjixAr6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256E3A9D8B
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809105; cv=none; b=qylwY+Wu9eXVxm4F4yx4pcj9PwvyKgIA3oSpgOwe9iYwKuVVlmF4ieyQdnRPonwIihF0wqKNsD0VrmX68QzTXepraoJiGF8PN/Lfi7IeHhD8GXaikmGurYtcsgdXVoUbbhCElTKtskluE7M/uYPQDb9a7xkBh8okTEBDdlUhGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809105; c=relaxed/simple;
	bh=sKJohp6JSfNRiIYkryKiS5uEOD1WyzlAH27hQZmGU6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NycKX+UTOHdhMgLz6dEssihXJBY/Ai+qwy7ZtIXfvUlKcL09AJNg/LPM6Zq9tQL1CJ29AfDyLoFaitQIG+dA7eTCJc//gSgE4Rrfmcdd5Nc+yTxBQj8nCZHnTNA/hokf4c5jzts4f0LoZyKvl/wabsMcsHgY+sUfF12V8MVfFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjjixAr6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso81266815e9.3
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772809102; x=1773413902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IlAqrQXAoNRrPdFE8T+jJIC/19vJ3Es0LkJ9ayYBZk=;
        b=LjjixAr6Q1SWC59DDySsjYaoAof4UHRyb6bUQa7nWmHXJ3vBM1uWddvdm9yJtM1g/3
         4y01cm+p4j39EvMkn0E7JYg2eGZrOjO2T1HlccHu4elrcIhamQ42HdxuCzn+Ulyn8Vub
         xNGEDmtBxQ3usGSHaK28iNc11rWc9zJzvVKTkTmjHlzSXt9PebVTUt/Rna4ZcPhHQXiW
         tB31YE7eok07mOmvaJrJ5Df1v4Nx07I/d2HEU/6p8cLxLhF1I3HTrMsRy6DTgEyecCZd
         H9piss4/ZP7sLVY5qiwUcUrwXcLlvd7NYwc0tv/TyvPZ/V3CMIGg0OTcBEZql789oSyJ
         LfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809102; x=1773413902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IlAqrQXAoNRrPdFE8T+jJIC/19vJ3Es0LkJ9ayYBZk=;
        b=VSnYpHu0d1tYuadMd48oTsOHKL1k8p1RjljBZfxly7wJTd6B5YtIBtkrvu/Vu3lu5J
         oVATc9xyx53JxCaiI5wcuK80W+LpBfLSRgZTJxqZGICOJ86HGdmwSK0+H+v9UGZkpXf4
         4OG8y3ACeLoVhatpMhlOpHSk5QAxAKHtXWE4KGogq3JDpeaGMOWD//smW7RKb3/iCL+P
         OurF1gK8+CtqxtkctKZgs3EmbEeKNnKk1ryj0M/XSismha1z9a3pmhwmPWDC196OBRf5
         iIrNfNSXUu6g9xgphwm1aN/3UeLEl5Mmu0lvJQkUoz/G+aymHomqb/i7vH2HNSWPYfxF
         MrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+bpW+nkOD06Qx+PZZdnWu0CANPSdaw3DkwVQ01eCip7jF8XdBfZniKkuxs8ayV1GQ/oegJ/c6ocY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynL5VCXWSTx/njXcae9IhW1ifuqhquo6uC3/NhiSoRVAaEfIWh
	DZaOXMyOU1Uhnvbqvv8RWM1+skHN7//WZAiFXJOkdmwYvL0OaTcZA216
X-Gm-Gg: ATEYQzzitLeUW7VnhxXfTc5JznHcxw6oW88JsgoUD0l7fqxNbdixtyi1Qsjhos2kLeI
	/Ck9B4pqJi8D9qawvNTMzssBfCJcj1HPLnTFp0LZMnfN8DMgO4iE8sp8QZIO8Q5kegcHMyhONBi
	fkMOjkzQnHJPt4EE+/pRR6Zi6gk6VC+eKNWwDugDL5zN7BZmSaq8BPvIeCqMVhklfbA1zTWzBAt
	eND3Mc7eoBRv5g7kjDndR+jVgmGKw6Fyyht9oav73WUK2Y7rOEv9lGztRnPu8KWbqDclh+ZBqi3
	ifPuisYPYcGAfD9tHHwVii9CIz3EWLAnx9IB75CulBkBzbY2wj/kCrB5Cq4cJEBvs3f89V/69+i
	n/jLZafhDDuyoRIHgjapMpzj/DdNaQFOmxp/bfANRdU/EBFQXTw8iOXU8jR031HKUlHeChk/dB+
	ri6nzdPQJ842zNw6scCR7tFAZimV78xE3RKya/ad1Xlzji0Ls=
X-Received: by 2002:a05:600c:4e89:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-48526951430mr42154915e9.21.1772809102033;
        Fri, 06 Mar 2026 06:58:22 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:d0f3:534:36a3:523a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fad2812sm201153175e9.1.2026.03.06.06.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:58:21 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] dt-bindings: dma: rz-dmac: Add conditional schema for RZ/G3L
Date: Fri,  6 Mar 2026 14:58:17 +0000
Message-ID: <20260306145819.897047-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1112223669
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9305-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bp.renesas.com:mid]
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L DMA controller is compatible with RZ/G2L, sharing the same
IP. However, the conditional schema logic that enforces RZ/G2L-specific
binding constraints was not extended to cover the RZ/G3L compatible
string, leaving its bindings without proper validation.

Add the RZ/G3L compatible string to the existing RZ/G2L conditional
schema so that the same property constraints are applied to both SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index e3311029eb2f..31f3c153a793 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -132,6 +132,7 @@ allOf:
               - renesas,r9a07g044-dmac
               - renesas,r9a07g054-dmac
               - renesas,r9a08g045-dmac
+              - renesas,r9a08g046-dmac
     then:
       properties:
         reg:
-- 
2.43.0


