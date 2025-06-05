Return-Path: <dmaengine+bounces-5307-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7BACEB51
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 09:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA6A3A5BBD
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14205207A0C;
	Thu,  5 Jun 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlZk04lI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819392063F3;
	Thu,  5 Jun 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110141; cv=none; b=qJD5bY2mvix+AlckIRag7LvP3MZ6sI8euSvIXnDQ3SW/zPdE2NLaZ17Kq/T5AMLKFmTNOj91nkSyRVcqx8k4+ZUhcJTxGTV3qm35xL03y8VYPT1tFiUb/CDjV3vpKQla8ydv8Rnr3wE5lwAwJDGSXwMvzGuWr+Tzw2Y03PYyN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110141; c=relaxed/simple;
	bh=2xA063MC/kRWwLZ2fnrCOQUwpNQHP8a730Tx2EfSIpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiqGQfkC1KKj7Jykx3t8t3REf3bOrUfX22a3zM2SICbX4+edufKFtm4x8MQrW193EDdLK3ufB4iI4PPWohpZh2SACdTJaYwQIUUr/6hKKJcbbTcCGNAHJIpwdlEAbMYatN3SL5/ws/aPFI8G4jYCuJMI04zPiLMpxZRy/AMhaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlZk04lI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33677183so6007455ad.2;
        Thu, 05 Jun 2025 00:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749110139; x=1749714939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvczEWOtd3+xUjc0wRT/ahzTCf7ZeIPM0+H+Q6/x2ZA=;
        b=SlZk04lIZc6TINH97kLREBGQlxcQ0WexEw3Rv7xkuTs7QZfXd5gqBraHHzfOCaL/im
         OBW/71gjUQvfNcZolODu/3cqrZYSMmlQ3e3EWQELnoRBGgtYyewcRimzj3UYDtcV+CIH
         SpcHexYVUlCrP3cVbz4Zkuhowi6IDGZ0Sxhp94JBUQ+FFQqJIaFRrOcLGJjlB5We+dhH
         5ZupHMGCmp9SbitKnPSJFoks04gbQ/ghEZUQQV/W04Dg+wegMY8orhWVKM8eqB41JkqL
         g8Cn7qecJikCuetVtnuLKERd/wCbeMChsheqspMFZGT4cATGTCT+LmcAFjkGzM9rI8TE
         V12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110139; x=1749714939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvczEWOtd3+xUjc0wRT/ahzTCf7ZeIPM0+H+Q6/x2ZA=;
        b=NGvw2HpzGY7ZC63955bm4yNFRPN21hnWjPZZye5hJ6ZZlCmftCiHI9u1nF41ky9FPu
         9oJEZ4XQV8pf0m8441deEnu4KC0yJFoEmbws1lS2KduuiGLSO6lLIzCHndcp9UiqOkw/
         sh2/NQW1f9sV0thapc4fhH3QC5h0tjDo8k3bRkO/EcFzx0eSk0e5N735o4Dq61TRJank
         Zg3o9M4b9WgUls8oep/OxME3qQJb8SnouqAtEHDd9mP9iV/3ySO/NP/kXzB7vl0o76I+
         qmMvuTzx3uhyH483y4CsVe2WRsYca3xXNMoGSympASCLLzu1lK58eWZT1M8iPQeroT3z
         0ZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcCB8BULLC9ohO204PezP8c8geyJkFgPpltKsnUUhEQxxlPkTSGWccRtXCs/JfVLR5AnzZL+Is/d9m@vger.kernel.org, AJvYcCUrTJnAY/iTgHZpqM5ov6wGvccL5l44RxXcMrJij9cqgpc5T23ybmIaF+bEY/eg1pisYytcKm+CHo2o@vger.kernel.org, AJvYcCXm8Vva0rnFgIlr5l+98tCpDyZrVsspQ8/zacw4kHYy+oAideTNqnAXvzzwIS41qtxN/YK+SQu3bYKTKzWU@vger.kernel.org
X-Gm-Message-State: AOJu0YzGf5q2WFMVzAfhmx42gUQFf06tj98zBUV5fJWQIPOv6In0NOt1
	Z9G/c9vZk280txj28tS/9aJvF/3Rxd7vVXm2gtkZGIUADpD0t0IOom2D
X-Gm-Gg: ASbGncspBDj/OYCbgh6TJPSLXUiorAq5Q65A8qCR+HckoLiCnWp63bxh4Nm/0pAuHQn
	E70aXF/dLSsy3+6xLOK/0UoA4isweXOJndO2mFAlTSl4AErPiMI8Y5Dz6Z70hbZIMrdNi99HLa2
	/6JuvgWNsV7z++VObxbLGT7DeiDvWpenw2zKkESgyFg01HxWPGX5LYH96NcSTsDLQhaVary86LE
	uFZ5RUyY2n9sQMmemr/WdsyFOXAvBFxY91f8GrHTwVEEpinJlHStEo7jj41V56UqDxT/SmambLG
	XlsAxB4yg8YvaN7p1wH9s/r29HbeQVbsk/8oXitXYhlnfmluPw==
X-Google-Smtp-Source: AGHT+IHDBtVhYgZv7Nkx8O5e23AQ6vkU0MEDQDC0hGmYlT0A5bgGGLDgSHJWQgz3WLF35zxAQbaZ6w==
X-Received: by 2002:a17:903:1a6f:b0:234:f4da:7eed with SMTP id d9443c01a7336-235e120069emr90257885ad.44.1749110138600;
        Thu, 05 Jun 2025 00:55:38 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc86cdsm115201015ad.8.2025.06.05.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 00:55:38 -0700 (PDT)
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
Subject: [PATCH RESEND 3/3] arm64: dts: qcom: sc8280xp: Enable GPI DMA
Date: Thu,  5 Jun 2025 15:54:34 +0800
Message-ID: <20250605075434.412580-4-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605075434.412580-1-mitltlatltl@gmail.com>
References: <20250605075434.412580-1-mitltlatltl@gmail.com>
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
index ae7a275fd..3fbd0c005 100644
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


