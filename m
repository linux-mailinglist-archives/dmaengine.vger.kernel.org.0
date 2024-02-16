Return-Path: <dmaengine+bounces-1022-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0EB8579D6
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 11:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF5B285739
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4151CA86;
	Fri, 16 Feb 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGzRSAUZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FA1C6A0;
	Fri, 16 Feb 2024 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077774; cv=none; b=ifGwK5+1b+nYgluSI1td4F5il4RZLh5zDuz0lBXba0/B/9nIBclVO+qI0stBNN0m5bk6VubsIqQOVT0JcqTq1to/pDKeAcib0Y8//4AYH9LLldHx+51yDY2ngRc3yZjnHfPj8y6pO/3b1VyBAfRnERS953yt5M9W654L1ROhfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077774; c=relaxed/simple;
	bh=IfQgRdKXeDU2cuydr28jpQ3er3ltiRCVsT8Oao+apnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGKmmy7jIUPF8JV08hs34C0gwwQKNPK5pZwO5nZhjuNFiTo+n59cZbkoKSCA9E/un0kCJnxPWiuhcAGiiOD0T48Qy2jnK4NrEPfRgzfRUizPM5a5kNXqqvaIN284KbmsJrCRvPUWGNlP5HS8Dv7MwK8ZDBixmnzTNoLqJJCdkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGzRSAUZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso4356801fa.1;
        Fri, 16 Feb 2024 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708077769; x=1708682569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYAodHIG8Kts+r2cf/WooO9lWPZfRnR3+oSzMbThTMk=;
        b=FGzRSAUZ1jPndT3mjKYzRhuxKNcCdU/azX9qwtt75NXEhvsQIwSBkSXeH/Iww4zPmn
         FOMUJ5Q9p+BPqIhaMdK9ktKLeP+KiTvukZ/iiFzSc3sgL4U7inFYNuZ7WxbTF6ylZ4/B
         0aMj06IS4BxSwYYShgT9AYG8pbHMWfXRKDmVd0tFUb+CKC7SSUy8gY4EgdqRhz1Iqhre
         2zXgAOln7NEIlzU8E9On3CKomNT5R5mJBlXMjd0R49copqmy2MErNrEOkllIpyvySGt8
         6mMrXQG8XaXET/9ktCnUKgoosbL4PEkmWo7T3jFswJsYrJRCKfIgBEasGYheDkI1Abc+
         HixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077769; x=1708682569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYAodHIG8Kts+r2cf/WooO9lWPZfRnR3+oSzMbThTMk=;
        b=BkQ0OPrqwoo3sxJXZ5E9eH/AN0k12dLOmK+Hr6R4AXUofwMIEbmfqOaA/j3OXVxMtt
         h5YsjCHqHBpYSNWwk+BuYfezElSTTrREZ6RFDlB+Yaa0KoLqiGQxffYta6LsXgAUPxAn
         afmo3GGJ3MrKu916hpjOOrrVwXpZPknmqklvQMIlgl/sI+padV4Dzqmmo7EhK/03NIH1
         xXgp2mbxTFDXeTVzR06QZ1QwFjOyNoFdrkj9c6x7o8KdZ9rZ7XZE22zTAzRCbPI2MDyp
         JOdzqKSY6mfB0x2HdXVrUDbbhwTIjSo+LWcissHDkDTMiFSQWp+RpjKXIG9YAvo9iaHq
         +F8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXot5WcSJEo236BUwJl/ZMxQedjWhkyA2CLAi53quoZN3hfdTCeHy7TWTeBfeYETQcssFtRuIGCVofBylMKE5+vyqhOYTV8XOpa
X-Gm-Message-State: AOJu0YySpFFNmddoarWVb5zwVblFmXpb1/fI2YGw1l6exvqjuJfHyNl+
	k1JVUhMx5swqTNvXJbfLyzdQRHmbuYi8+6cjYE73YOEZuN9UUoS5Rs7hzQdq
X-Google-Smtp-Source: AGHT+IF83jhQvvc3JcDaAEg2EM3ssGQ2gj6HAurgJNJADC/zD3PfMIygfWSCrSdVOAB8vL6pTjVkpQ==
X-Received: by 2002:a2e:9dc7:0:b0:2d0:b244:5f09 with SMTP id x7-20020a2e9dc7000000b002d0b2445f09mr2991501ljj.51.1708077769127;
        Fri, 16 Feb 2024 02:02:49 -0800 (PST)
Received: from morpheus.home.roving-it.com.com (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681::1c8])
        by smtp.googlemail.com with ESMTPSA id bu13-20020a056000078d00b0033b4796641asm1808213wrb.22.2024.02.16.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:02:48 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: linux-tegra@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA
Date: Fri, 16 Feb 2024 10:02:38 +0000
Message-ID: <20240216100246.568473-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216100246.568473-1-pbrobinson@gmail.com>
References: <20240216100246.568473-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the architecture dependency to be the generic Tegra
because the driver works on the four latest Tegra generations
not just Tegra210, if you build a kernel with a specific
ARCH_TEGRA_xxx_SOC option that excludes Tegra210 you don't get
this driver.

Fixes: 433de642a76c9 ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Sameer Pujar <spujar@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---

v2: fix spelling of option
v3: Update T210 -> Tegra210
    use "and later" rather than all current devices

 drivers/dma/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e928f2ca0f1e9..ae23b886a6c60 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -643,16 +643,16 @@ config TEGRA20_APB_DMA
 
 config TEGRA210_ADMA
 	tristate "NVIDIA Tegra210 ADMA support"
-	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST)
+	depends on (ARCH_TEGRA || COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Support for the NVIDIA Tegra210 ADMA controller driver. The
-	  DMA controller has multiple DMA channels and is used to service
-	  various audio clients in the Tegra210 audio processing engine
-	  (APE). This DMA controller transfers data from memory to
-	  peripheral and vice versa. It does not support memory to
-	  memory data transfer.
+	  Support for the NVIDIA Tegra210 and later ADMA
+	  controller driver. The DMA controller has multiple DMA channels
+	  and is used to service various audio clients in the Tegra210
+	  audio processing engine (APE). This DMA controller transfers
+	  data from memory to peripheral and vice versa. It does not
+	  support memory to memory data transfer.
 
 config TIMB_DMA
 	tristate "Timberdale FPGA DMA support"
-- 
2.43.1


