Return-Path: <dmaengine+bounces-5410-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCDAD69BB
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1771BC1DEF
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330A6221FDD;
	Thu, 12 Jun 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0z7WiOb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92780221FD0;
	Thu, 12 Jun 2025 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715084; cv=none; b=Q6Qys0cGts0Z/XW5qXqxom6oKLQoW8w4vKz+sWCQ1bNdgq39lVygi/8bZwAdkkxyh+oOWxBJ8s/qaDECM2s910CLCrOIraF4DCEEfh8+Szg/rV101FOfosIPtby0DDpU/igTDNDDuI9LHPnk6juAAVENXNDUsadpTIRdoTV7J60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715084; c=relaxed/simple;
	bh=KFB3DCz4acEZisjnfBMufBTffXLke0ujyeAE/cFShPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtM8Wjjb7m1dCxrU5OeN4UJ29HczwGfxW7D06uJNuq7x/v8rIjgFM4HIWnIueOqH8hdaCszp0otdLScRG2+QQMNM//r2ME9hDNu+b1N26qIBBbyA9NI/mA4aSqeJaTa8vcql/oP5xMIFroq6Q7X8u7G1GJBSDE0BERdUcwwavPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0z7WiOb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2353a2bc210so6256975ad.2;
        Thu, 12 Jun 2025 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749715082; x=1750319882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcyeoD4VkXnfj6qA/Wyovr4xZe9t2h16kdcl3nc5BhI=;
        b=Y0z7WiOb0Fquz15NqcofzHcXP6wFU5xwqOsBTy5meqaCLw4EubmXn2LEDRQknG1zwL
         13wgUEdGexh4jIzjjU7ctOyoVVlk4TWFpkv192bF7BzIBrHGuVVzC+hlUp2oWTmUUxMQ
         pD63/Zzxmg6WE5C7rA56Ms9+Pe6VDvAa7oKTkcQksYsnpEBkNESCzpB1bwp2SJwS1Es+
         FRWYMXbai24Zv0IWQtx7W5YXl85u6KSHH88ucfmut8CuWtPuOZ/hBPfw1Eix9Ahd82JT
         evwWx0iabHV8BhMb1gMdsyDPmNRBGHpvaPOtDhLfrRXX+z6niDM9Rk0wldthlKo+4Zrg
         lkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715082; x=1750319882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcyeoD4VkXnfj6qA/Wyovr4xZe9t2h16kdcl3nc5BhI=;
        b=E7AEB/nPAXLjMw+ORg+jk7xFFhvjeEbM8LjiyBWuNZXeyBzU+K3+QvQ3WJpNqWno3G
         6zphscjMqThm0yhwcbkSKK2aJkW6ACyBcFOv0zrR8Gabf9vRYgtlG4ynujXOteYlGuO+
         NV7NwRQIX1Hd4W66DUyIzyKqwJUlDfZY2trZZ86Co6w/C1dIV+m8m5LeFCpFL7BEITUP
         BNOMYn9cGJkom4fhP0dcOB/cWgslXiMPGkeyvhdfEcMY6ltGdVjEQZ3KqAHx4bkKWPKR
         in+eFKESdIhRwnwOGyqoFrAmkCRIGaPyQoM+oODyRqseyhJyxd4fS1VPMjzh0iTaYqXW
         qg4w==
X-Forwarded-Encrypted: i=1; AJvYcCUEb5VJXdHuhz8o5Pd8DGfNEW5KiMsDwwbkUDZ6ROb1gY4F96YxCyInCXRhe8mbYJYUFYU46C11pKPa@vger.kernel.org, AJvYcCVBLRhE3XKFS5tXU0bC5hG5gq8PIYIGvYw3lHBxwsIade91BKFBlrnCWPda4jQxpbVB/BVY8tTUuPoq@vger.kernel.org, AJvYcCWvakF/q42l4XUnChEjdZ+/MdmmMTFv8v4vMhknts6m/b8oGJnGA8fSA0VLKE7vbKi8J+iLp3mr8sUvwrDn@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSbKoZa3Kv8Lymd82bDaygNOOqZhTmLqK4pEHBPW4CAFRuLZV
	O5iXwU/f5p3Y4FJiEdqqZAYZfU6wMNarYtpfzg/bT4HWm6PT4UeQXKeB
X-Gm-Gg: ASbGncsrsjZknikDpJMliCFFfzyueQFUgD05wZ1UpEZPZ+V1WZipuy9PDw5lAQwUB4c
	uosHayjayC/Psxk2g2ZFGMcrBPQt/ijOPxe75b8S38voUNXdiyX9UQjBsDvbE4sKvoc0fU7IURy
	Q1AQgLuialj/QsskIP7bEaJPhhdgFUnoP7ZNOBeTbGJyKEdNJ2n0+EA0JuBcqU8/rTGrv8N91Lj
	cLTka3cct62/sVpjWgiT6qy+3RP4wC+sZSKvjMzZAeJFYvVx6ubA2Je+cgAtqwU+YifV9Mulkw8
	OarlIkM5A8FrxLBPOFtpI3sy//sZ7sNX1vDw5IDHin4gdQAWfma3qWMCJwa6
X-Google-Smtp-Source: AGHT+IFWQQYtsEfz99nTCQ5xg/uh4dOec/IyZuOoSOnpk5y3R51YoXj1FG97XCJbi3bwVar52P9IQg==
X-Received: by 2002:a17:903:1aae:b0:235:27b6:a897 with SMTP id d9443c01a7336-2364ca4c0demr39347385ad.34.1749715081735;
        Thu, 12 Jun 2025 00:58:01 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e7345basm7880235ad.245.2025.06.12.00.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:58:01 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Enable GPI DMA
Date: Thu, 12 Jun 2025 15:57:24 +0800
Message-ID: <20250612075724.707457-4-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612075724.707457-1-mitltlatltl@gmail.com>
References: <20250612075724.707457-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable GPI DMA for sc8280xp based devices.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts            | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 12 ++++++++++++
 .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++++++++
 .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts      | 12 ++++++++++++
 .../boot/dts/qcom/sc8280xp-microsoft-blackrock.dts   | 12 ++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 8e2c02497..667d840db 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -495,6 +495,18 @@ &dispcc0 {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 1667c7157..0374251d3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
@@ -586,6 +586,18 @@ &dispcc0 {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index cefecb7a2..f00ca65fe 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -708,6 +708,18 @@ &dispcc0 {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index d00889fa6..aeed3ef15 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -448,6 +448,18 @@ &dispcc1 {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index 812251324..55ffe615e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -565,6 +565,18 @@ &dispcc0 {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
-- 
2.49.0


