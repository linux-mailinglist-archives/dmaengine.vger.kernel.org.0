Return-Path: <dmaengine+bounces-2559-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFBF91AA31
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9270285304
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD34197A88;
	Thu, 27 Jun 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="YxSf7E1T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC3197A87
	for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500561; cv=none; b=F5iJ8H65lt4ITCoUtnd139WYr1Kc0PWkyMyOg0H0NFgycWLUD4XkUzGTY9g4/bsoEof4fZXm78NkZBRrngDx0bvM/GEvsnQRxD+IDQBlM6er2ElpR68HjCI7bkyhrhqywtxldepEfB5A0JnuCbJMlS3dmMJBkPEuHVaA2U4Dy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500561; c=relaxed/simple;
	bh=8swFldKlKLstLXY6Asg2tgwwu4NDMzYCnaw9E3FvaAg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAAboCBclZEviy7GcX5FAsTJxXsThtfVvtZWGXn8pICCs6MzCuwrwyQHciPs4dWDmO6nw3YYW7dXlS2RL+axodBrAeoLoSF1Y3lcDGwlejeLVanAjoAkDK2NXt4nt0aAqtsTYjamSSMsSfE/IQeJucYuhjLvDHCaPbGqqji6wlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=YxSf7E1T; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a72517e6225so642731066b.0
        for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719500558; x=1720105358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9ppopi9ppNssy3Y6kMvZbEvjKhcjUNqGrL0dAUL4ao=;
        b=YxSf7E1TQ2QCVud/qcFgSbt0Ks5V7IlA1YBkTSCJ7Hxv9usyITi8yY/Nc4wruyEmfA
         kE1ceJl7uIX93gmUZPwuMKqcEbBB9S++h3HBtoE7WNCFgfQa/vfDjuT/j5Zfo5T4aRpB
         5nIEBW4n5WVqgOhmlY05cLCCF9ZOe3r+TIVH0FnE0jD0AqRCQnB6RVONso0ugsZra30Z
         Epwj68m2/rogO4qKGYQGqiNvE0uMLA9c2Bxgv3hLwVCjidlH5UXbT8jZ4wsmkz5glCVP
         mgbb3EPMLpuL/+JnET9mz+7B+ye3/zQUT+hgThUM7IZs0kWIOj1gSkhc4FxhO/KC9YYj
         BV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500558; x=1720105358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9ppopi9ppNssy3Y6kMvZbEvjKhcjUNqGrL0dAUL4ao=;
        b=xUvTZiVGPVUTioQQdz/TGOqQ3rc13L4pwI4VJeBaSak8khCtQut75UH/iliAb7MoQ4
         bGfeXY6YNGWGSxc+wb1NyIQ5a+C2IPzHhbchI8k2xJqK10b10y2oUsVLyPt9wqKIn1E9
         3wMwv/H5h8B7DLzejMKW74UG9aOPAjL9kobfpp9HzMkzvP9akKMd6AU8iCEid/t4D4Kp
         Btm4CGJ2yNCDgrsyOogPV/133bHg1dscVEHGZQsY/SDJkuQQDtxAb6SrQhRvuGTTAN5H
         A6T7ZMdmK/H5w2OUBW9LM0mLuyrudbjoWYHqy7rJfQtU8okI+Q+NoSASdD9mi5baKYdf
         LoQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGAX9auUEk1YeyZVHm9vDwAUfHksqgInENxsBq7DMij+TzcWqxwB0epGW5vaP+d8wqKhvBRds1VrlQRtezBlYqo4tYp32PeXq
X-Gm-Message-State: AOJu0YxDi/H3aMJgm+mjWb+Vbr1soiPQxXiN/gdXIBbcUOZ1Ik8CHwi/
	BwyRyEa40xUl2FOsHrvgtMYvXbRIrbTUOs9+FGUV04qml2IVQRxNTiadL0/lkbQ=
X-Google-Smtp-Source: AGHT+IHNxN4PmRPFk0RxdcCHSntPRfVHwfmOqM6zTS7G+/s/UPca4WGfngbQvLyYCR5O6HreQqUr+w==
X-Received: by 2002:a17:907:6a0e:b0:a72:8296:ca42 with SMTP id a640c23a62f3a-a728296d1cfmr421637966b.49.1719500557261;
        Thu, 27 Jun 2024 08:02:37 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca289sm67189066b.222.2024.06.27.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:02:36 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Yangtao Li <frank.li@vivo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Li Zetao <lizetao1@huawei.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Corentin Labbe <clabbe@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [Patch v5 04/12] ARM: dts: lpc32xx: Use simple-mfd for clock control block
Date: Thu, 27 Jun 2024 17:00:22 +0200
Message-Id: <20240627150046.258795-5-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
References: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock control block shares registers with other Soc components

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v5:
- This patch is new in v5
- Split previous patch for lpc32xx.dtsi in to 3 patches

 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 974410918f35..8bf88d141e5b 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -312,18 +312,17 @@ fab {
 			compatible = "simple-bus";
 			ranges = <0x20000000 0x20000000 0x30000000>;
 
-			/* System Control Block */
-			scb {
-				compatible = "simple-bus";
-				ranges = <0x0 0x40004000 0x00001000>;
+			syscon@40004000 {
+				compatible = "nxp,lpc3220-creg", "syscon", "simple-mfd";
+				reg = <0x40004000 0x114>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+				ranges = <0 0x40004000 0x114>;
 
 				clk: clock-controller@0 {
 					compatible = "nxp,lpc3220-clk";
 					reg = <0x00 0x114>;
 					#clock-cells = <1>;
-
 					clocks = <&xtal_32k>, <&xtal>;
 					clock-names = "xtal_32k", "xtal";
 				};
-- 
2.25.1


