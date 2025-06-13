Return-Path: <dmaengine+bounces-5433-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE4AD8AD2
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 13:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9801F189016A
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C82E336E;
	Fri, 13 Jun 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="qHGBdf+Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A62E2F0E
	for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814920; cv=none; b=Ehe/tIAIk+9G7ulP+AqVP0QwSD1ORCRZ46Nfox5D2Sdd3Pm/Zc2yff3DFvt7la6XLWkLg0UMI3db4t1kuiwYtw9qbc55gocgwdIcs7IRm3FW13DX07GDXfibpciL1TtsWCDst0kUdpuGZOfq9KLVT+VrBMgOwZCfCl+ylQxeJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814920; c=relaxed/simple;
	bh=Jkh4xI1xZFk9y2KS3JrFZenLMgrJyYczEnPNCHPbPOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxFNF+OSw+LRgpaaBZFVG5YWUUZZHGTgRqiviVR3zL4W6+2b0ZR4nMOviu0bF6N8ViwkwlW6FfJmWLsNjPMMRTK+rXi0DLccpK+1LWNK0nWAEZJilDotNv096GpQRnEEj7tBH/3YmlUnSa+wUjybsCNPzz+PAnQBTNAFuWGPeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=qHGBdf+Y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecf99dd567so22396396d6.0
        for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814918; x=1750419718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gog1CrvxeaBvJs1XxgKi+JJwPn/cN8uX820mkK4YWuU=;
        b=qHGBdf+YjtcW4VY5lZTmf053Vg490Q4jam7CAqIXI8Ly4eTAIxvAiU2lz3NmHvEPBK
         PHlo6RcyJIRFBYVBa1kYLG6z9NjqOdC/coMqD1/VgzkkNp/KFqBIJQV4wGWCu0DeBuYE
         EzyUyepGwVe1TmA4XYFbsEcfjwxmKj8EXHyaroZ3XUIslxIX6I/QP/F276iOpl9T7gP7
         WBRoGLkhNcOPIcZ7HuNqRRzrpWzmZVFn96Ej/uHYOXFIH39jmJt6p19YEX9xULozQQjW
         sFkDMdXUNogsPypUwxUuTWDIt/0tTtj5thFVWSnh9awILgD/7QbnGrRy8tUNHx7KygMz
         vAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814918; x=1750419718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gog1CrvxeaBvJs1XxgKi+JJwPn/cN8uX820mkK4YWuU=;
        b=Ay3xFqg2vUDxbZmi2HR27AYghvApa6KapitZRQls/4STuoNe6MgXH3V+PynPpqU9JR
         +kKOkMD7lSkPT+PsKTK+kpCIMmXB8BdDZ7Qe41UMVVivW8/AwBogrytJIRbaidC+Dk90
         zI+K0XqvmxK1SIzNMJBxpEHKGw7ptkQ6gvBsqyfAMeE6omgZkn522kkYfvNU0I3IrVAY
         KihrEvLe3fHtONrL3DfxoZoBBrLkGukxyfUNZSR1Fj1B6Wis9cyE/KaCoS6DzBq0yG+7
         9MAyhb0DhMfEFZo2Og4aUx4TEiRbRW7oG2Ln1AUHtYbVXYK5/JFJ5OrXsogL6EXgU9Ep
         c1uw==
X-Forwarded-Encrypted: i=1; AJvYcCW2v1vZk14lImkLH6DixCjgi4y7w1ZgZHKJJoYiAcqsYwiSBmSfNGBVUhSL1ktzox5/CQSe8lRBlvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQiERmtiWBFx4Q/5CtzGsTCVAAiuYi75irG1ijRcod3N+0xllZ
	zvYpiZAY9lHLNcibyt6jqGmwDMDxTcS3o4PSjpHmn9MneCbHHKczSRCszAG4L8Ei5jc=
X-Gm-Gg: ASbGncuEjGRoI0A/by86mnIdxWTacmBFHOTbZ6epjhc6Fkp/v9RTpZo1UYhHVJhci1R
	kEbd/zuPh8CVWu4xGc/y4c4fYKLl+YPJC6AZ763a5r7jJZbaSnwG2d4dIORpxc9BljUwsvNiPuR
	pMmqWQakUZZrivsZCKMlLpDiDZ+UyBgOxruy2gapc0tPiIXNw9hOtp3M0Ut3W89R2t/kB0xiufx
	JLM3fIR8OScEwxAGdxcgMdLmQtpuLVtfGKEuKpWnOhVmd2zKB6MtUJOK7EjFY7R/PCjLHko4sNf
	LQStofCFc1+/lMrl7exqrV0fqiKY4jgXUNCvAWZWa0vtAjiUYnUf35qYR5WiroMHhZzGaKthKmY
	4JU6RgzrPfnj/FIZwOA/VRw==
X-Google-Smtp-Source: AGHT+IHFfRslU2JdUQwTEst4+2qv7pFwoUnipsx+0jTm3bc3ZWeEjmqIo+cvUGJbAhVMc0O3WiescQ==
X-Received: by 2002:ad4:4eaa:0:b0:6fa:cb05:b455 with SMTP id 6a1803df08f44-6fb3e5fda72mr39185896d6.35.1749814918080;
        Fri, 13 Jun 2025 04:41:58 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:41:57 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	ore@pengutronix.de,
	luka.perkov@sartura.hr,
	arnd@arndb.de,
	daniel.machon@microchip.com
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 1/6] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Fri, 13 Jun 2025 13:39:36 +0200
Message-ID: <20250613114148.1943267-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613114148.1943267-1-robert.marko@sartura.hr>
References: <20250613114148.1943267-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the Microchip LAN969x ARMv8-based SoC switch family.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Daniel Machon <daniel.machon@microchip.com>
---
 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a541bb029aa4..834910f11864 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -133,6 +133,20 @@ config ARCH_SPARX5
 	  security through TCAM-based frame processing using versatile
 	  content aware processor (VCAP).
 
+config ARCH_LAN969X
+	bool "Microchip LAN969X SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for the Microchip LAN969X ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The LAN969X Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select PM_GENERIC_DOMAINS if PM
-- 
2.49.0


