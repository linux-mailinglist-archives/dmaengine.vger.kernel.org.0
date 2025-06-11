Return-Path: <dmaengine+bounces-5354-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBACAD5650
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2841BC45E8
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9023A283CBF;
	Wed, 11 Jun 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="hM14zkjr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4828314A
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646764; cv=none; b=uYhLuYvSHKOW6iH5bU5ISJlc3OKjMc2JqXIQ4fRty789aKms0thOaEjw4ADMpyK4zEOGeMCpa4MES9X4BD4EAiLaFxL6J2h/L5PrvVHFzyxO3RWB/ye/XA8RZyIhPpHbHAc3uM4/thNBff1i8sPc/lLVTpA3+zxuEI60d92Tsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646764; c=relaxed/simple;
	bh=mfvf7YBc75gKcXozHj9WT3obpDew9OmkoOmyIZbUJOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIQznyZ60V6UsDgJrEH0x0HpYcAeNwCmYmQ6LedYIrys8z6nGH6hWlcSD8Q3rOYLPEkmooGg1DRPgs+5vDy7qHRBumnDOmRcm+Il3Vv6e0IBdPA+wxHdoBoz3OWSzqjm+1Z5UoQC2r0O0Lz3fHo0k9n8MooLl8H1yjlmE7Vg3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=hM14zkjr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ea292956so62909565ad.1
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646762; x=1750251562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgXKWx6LT0v0t2kW4DENrP//N1tJL1EVc4tejq3gXuU=;
        b=hM14zkjrM1Ob8vaP99XQIs1taUKdX/jLl2V0nQTw87R2W1T3Gca1eoLENIDYvm0lVu
         WMtT06rB7UI3i38v4/k3A5AzDPnpxk19swoDBbdEujfm7tuIICkkch+pepJH9/f+Z4Q7
         nMWQqC+w/Dbtib0ItgoIJKIRpjZdt7KgMPWZKvkFi0hXPEZu75eONtrSk1AEnwfAdcA3
         C36riXVgYF/XeK8mEqe6HkV066cJsUeEyGgIhU9UauS+WZZrSsClQoPi3cekf2dTO6Xf
         R0XDH9nSn/ag9vFosJMa03nLYpbaDG1iaLdRkW5TvtYpjGCISMOOR65fX0c+B3gMWdwq
         dL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646762; x=1750251562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgXKWx6LT0v0t2kW4DENrP//N1tJL1EVc4tejq3gXuU=;
        b=hyr9iWqyZBGuiGBrg8ICZPv/OQpgbzSmk8aXvAMjhK74i3TyDHQK+EQCP7AYrvS48I
         JkQBQxRkDFsu1TJj9zhinKp/NpmCnksPQx7gxr6HeLTYdRMr4PBK9/rGkUNo28JB/gjp
         o+2MYMBCeGyeDhoRhFWPuun29XnjynFDbKbrjWdQsh+5c2SJnUTGrUd9DcFFua2YUY1L
         7r0QD3/7JISv1wbEZWXlGnTtlQYmd2qmArAdzb1hl21hRnlCte7HdvgqNb9xvIOxT/z1
         xA86BbSJOYl1fh6pAb+ij0WV047J4BB6RIZsRLTcciO4wQsm3Ehs4QHnYI1NOphqCqY+
         nNbw==
X-Forwarded-Encrypted: i=1; AJvYcCVmD4+Hhl8M6wTa0niTtmMq9vSFoBD+P0T0uJAn3IWsskhY3WV1wtdYz2Z0jmODU+mU4dixtYSsfuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNlpQacjJXrw7OcWNm+p+isOjTKF7pspLwDlDohWKYDKs5lF2
	HVvlc6HUUCnL4EgE9CotBD8YdJ4bdBAunUx5kHvEFyLL/HM672dQqKmn7IoXjPVZOz4=
X-Gm-Gg: ASbGncsgCPaB+fgwwVSWpLajN8sWlSljNp9SudxjYgJjyRKQ2VpFuon4E/zvWXuSZ1T
	EEBflLZ7cUzOAIu+BH+QNxBiTALMlWDYohbt0ZRxL07ifHSr0YkPFxV9lvbGPuWUCTZ07HMqovb
	DVulNQOoQEwNWFstfwqmsH69uNqZ0PpsIesJjOrkd6d2Cb+i7nXVc0RoNZRxZHY7yqRcOgmnS7b
	MYhebsXJ8MkdzbnRKFKz3heGpvI+eshQSstQ+cmppYuEopvBlA0OtRHJ4XDxrJR2MJvDpgokCeV
	2saFzkaqDkQLRvcfTOpspAGgK9coHC+Ef3reDbOrEM5r+JhzXC1GofLkpJrZybkR2+I25iKWLq6
	K4poZoGWDfDsUM/E4hiC3PmWPWSCTqN1r
X-Google-Smtp-Source: AGHT+IHP+0owmszooM6L86XNZc5ha8+zkwg20Qojl6bQqCgBkl02MT2JBYiauh7dcDoSUFp6EUtZTQ==
X-Received: by 2002:a17:902:f78b:b0:234:b131:15a with SMTP id d9443c01a7336-23641a8aad8mr44833385ad.4.1749646761961;
        Wed, 11 Jun 2025 05:59:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:59:21 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	emil.renner.berthing@canonical.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	joel@jms.id.au,
	duje.mihanovic@skole.hr
Cc: guodong@riscstar.com,
	elder@riscstar.com,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 1/8] dt-bindings: dma: marvell,mmp-dma: Add SpacemiT PDMA compatibility
Date: Wed, 11 Jun 2025 20:57:16 +0800
Message-ID: <20250611125723.181711-2-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611125723.181711-1-guodong@riscstar.com>
References: <20250611125723.181711-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "spacemit,pdma-1.0" compatible string to support SpacemiT PDMA
controller in the Marvell MMP DMA device tree bindings. This enables:

- Support for SpacemiT PDMA controller configuration
- New optional properties for platform-specific integration:
  * clocks: Clock controller for the DMA
  * resets: Reset controller for the DMA

Also, add explicit #dma-cells property definition to avoid
"make dtbs_check W=3" warnings about unevaluated properties.

The #dma-cells property is defined as 2 cells to maintain compatibility
with existing ARM device trees. The first cell specifies the DMA request
line number, while the second cell is currently unused by the driver but
required for backward compatibility with PXA device tree files.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 .../bindings/dma/marvell,mmp-dma.yaml           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
index d447d5207be0..e117a81414bd 100644
--- a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
@@ -18,6 +18,7 @@ properties:
       - marvell,pdma-1.0
       - marvell,adma-1.0
       - marvell,pxa910-squ
+      - spacemit,pdma-1.0
 
   reg:
     maxItems: 1
@@ -32,6 +33,21 @@ properties:
       A phandle to the SRAM pool
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  clocks:
+    description: Clock for the controller
+    maxItems: 1
+
+  resets:
+    description: Reset controller for the DMA controller
+    maxItems: 1
+
+  '#dma-cells':
+    const: 2
+    description:
+      The first cell contains the DMA request number for the peripheral
+      device. The second cell is currently unused but must be present for
+      backward compatibility.
+
   '#dma-channels':
     deprecated: true
 
@@ -52,6 +68,7 @@ allOf:
           contains:
             enum:
               - marvell,pdma-1.0
+              - spacemit,pdma-1.0
     then:
       properties:
         asram: false
-- 
2.43.0


