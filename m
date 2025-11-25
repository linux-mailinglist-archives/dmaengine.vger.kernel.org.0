Return-Path: <dmaengine+bounces-7344-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1762C8738D
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 22:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA34E3750
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389DB2FB99B;
	Tue, 25 Nov 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh8ERUM8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422B2E0B6E
	for <dmaengine@vger.kernel.org>; Tue, 25 Nov 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105993; cv=none; b=a07yGYNbTvD3ZVEsdQzA0QHg5Y2xrEIoxq8OH6vdxrTI5LpdEOIHUNYx5Ybn3t0hS14Kzcn7aqCANNiOwwMcoEw/UrRbRV7cY+dLwAMq1OM5wJptcDNdcn9r0Fn7Fal4UaCissMwt3/eJfE5wP22eHjkmwBQKYKLYOKj9Qs9ZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105993; c=relaxed/simple;
	bh=77ztk+4qh7ZS6QbAc7V6wDs6rYUaAyd++plIusTMp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGyoY5Swb0TdWgq+DGLCT/dlJR8SfafUkfs6H3qi2+I+VSqipabZ/m3eFOWo0ZLeKSDrlADXgSyrGGYZ5sMQly7Q2PWva9atyb2IBnG1obzSgVL4w67yCJ37nn3rOb072Tj6C0aAL0/nLUprbRW+YafaHPi1/sNukAkQnHOAhZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh8ERUM8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477b91680f8so47317015e9.0
        for <dmaengine@vger.kernel.org>; Tue, 25 Nov 2025 13:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764105990; x=1764710790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUIpmmh3zCHBkUgTRjkb7/r8Rtv5eeq4uS5BejYx488=;
        b=hh8ERUM8r0OCNqsJ/O+7OUEBfK0GqSAglDTT6wVTf2mW6O9jBO2PzRsFbJXQyrd4cY
         yyiiJTQlChwrcDici7LX7vk3z9Lg8lvduLIBwKVIp9vshOtERrSRd4q4IivuGl6E9RJB
         TCkiT6xQZ3vV2wPZbtCoZSmT/+pjp2u1A9ic4mwQIKzZspklrKgRVNM2XRXlU3hhp+F9
         I2+zoE2NNBujmar3w2rrllXN5cV8zeqEwUOfV5nSzRRhERWS+obZjIKodhbPaT9b9xdo
         RKZfI6LnqW4NTn6mqTNWIVEkOe0RBLJ1p6jfOogZBZ8TwzeWKWxAoj280n/xKOPHEezJ
         ZZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764105990; x=1764710790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUIpmmh3zCHBkUgTRjkb7/r8Rtv5eeq4uS5BejYx488=;
        b=SBW6WZLxYeXBOxjaLuwElr3zCOdus7VIeM9m9WK5vbQS2qWj/oeFZJvVmO5UZELtdf
         mOZ7w9gtXPxGNpvH10sOP7A0lRQxhqwiMEqdk6ucNeLYM+hmlqmEVyrlvwx2rAV/c/sJ
         lhuji6fndIrwlSrlU+7fyKhJ2HxuJD65D6jE4zfowDMHNTmmfhiClJ7Mr9BqYuXfCuzX
         AiTY5MVQQH2G4sShixFP0oEFNFrOGADx/+iFYOdwPf2/GR+XCmrJezHIGU0OnE+9nsF6
         XXXRRQ+Z+L0ZVTdTW0zdTJIN9MoJN8nY+rSyeZvigmLwG6ZNwFD8R2G4JVpJhRkG23kZ
         aCZA==
X-Gm-Message-State: AOJu0YyZJftpI2DYxiJ+mlJxVUaAataoOrRKOIhhpYGSvMdh50q6/Lkt
	ST2x/PaqtKe5eyXzO98M45UZugzE8J3eQrz5Rfk0enqkdlmlv/cysb1l
X-Gm-Gg: ASbGncvlZT/fIKvtiWTk9D2vKsocxWQ6Qx8XuebgDOGwdDOYhniAUg8OnjZpEoM/Mhw
	I6xuFKJf5TtgOn6XVCaaR650WS+fnJM6JcB/rhuidvUNdECJqT4eahC+tky10NFYorg8U1uZdIX
	5zeDbPl2A1rYMmo1/yVOs7FtEISndjD3Tmx/caGbuo74S72JpwpAqJNEjPXwwX0bUmBscW52ORD
	4N1tI4wA3CP8QyDK2bvT1pFefgoV9AwK5vutcO416RCkeRo+sxYmsO7ETfoqhHoyC5OJeQqUe5s
	VXspIrXmf2MjbkYWs+GZeG6iASFso29D961j+Xcenyrz+I9y81EY+ROg1198TfY4LvHdwpaCiq6
	iv10Jyg7yW2YJ+rPvDkC8+X2pNQgeoOevZMpO05JFdUvG+8hpYeuHb5OEz8rPqmGXoWNqS6of1m
	DHmhPf7WYaVYpwDdGqkgBgvvmEvkJXa8oGIQ==
X-Google-Smtp-Source: AGHT+IGINTwYKB3f6O0/4a/8uVo/WBSVTCjYyj22/LVPwO2J94ZGb1EjOdonlWG2c/DD+UhzBLngQA==
X-Received: by 2002:a05:600c:474a:b0:477:b0b9:3137 with SMTP id 5b1f17b1804b1-477c10c8886mr182927205e9.1.1764105989434;
        Tue, 25 Nov 2025 13:26:29 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:325:d7d3:d337:f08b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc6220sm9606055e9.2.2025.11.25.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 13:26:28 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
Date: Tue, 25 Nov 2025 21:26:21 +0000
Message-ID: <20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the DMA controller on the Renesas RZ/V2N SoC, which is
architecturally identical to the DMAC found on the RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index f891cfcc48c7..d137b9cbaee9 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - enum:
               - renesas,r9a09g047-dmac # RZ/G3E
+              - renesas,r9a09g056-dmac # RZ/V2N
           - const: renesas,r9a09g057-dmac
 
       - const: renesas,r9a09g057-dmac # RZ/V2H(P)
-- 
2.52.0


