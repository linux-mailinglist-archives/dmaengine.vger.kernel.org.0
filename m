Return-Path: <dmaengine+bounces-2158-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4718CE98E
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3EC1F227AD
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAE481D0;
	Fri, 24 May 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="TXjTMPjv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D873FB2C
	for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575278; cv=none; b=SLh8AaR6nLxu5GZmc9XN+zdxuvt2pv35M2VG+5TrD/341Gv7rN5GBtUf0jkJTr1mzNz5UiNLEgtpoN0dM5yF9etvEmThdg0tPV/grKMcZTE+boIyVEHpD6DJYnwnHGndurRuLiEGJgRgSPPlA3cnglY7elz9B20dcvzBa3pFjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575278; c=relaxed/simple;
	bh=KzZ2/ILylgxy50sk/StCVlBR9s2jedRDn061bSZ6QRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bcKs6FZVcabh4e2//CfHjqqAHCr/Ui4unZKysGh0zhKCARdhVqZYo1si8LeYsQS6k62mLYITR2YPzHgFjwqhz8sPnNInm2CaZ4PNQHMX/sOt8Jksl3CFByVXbfZnhoFtB2G9MwF/NpLFN1y82BWYXrTWAfK1tgxTx9d3JKgQaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=TXjTMPjv; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-4202ca70318so64599195e9.1
        for <dmaengine@vger.kernel.org>; Fri, 24 May 2024 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575273; x=1717180073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MV7QZf2fhH+OEhBA38QGxT92fUaASU1Nxo1nxUSVd8=;
        b=TXjTMPjvEB/mpo5ZJFhiMaaLnozrvLslAQ+8QJMzQMCPL24NoORbh/iE+2u0VB2MfZ
         1EfFvNlEv3pYHOX3PLnPH81gO8rl+M3C9pwpf76F3Ym4Cmroc3xhPvVpSak5XcrMHzHm
         D5mZhstvelzEAdDlKGhTP6mZHGx2SL2LLuA04oOSyJeQ+FQhAeR9LYDZn2a0FSVJcOeD
         W5NC7dvCF5W0HL2IU8T53zi9BLYm9nBfyYCdJDv1I0XaAJ2lJvQom18lNOpjx5B8xXTs
         qytn/30BOA7mU5yGUg/NF7guE60VaGTNLsr7ROhtnuCRWtpSC6DJpuLb4qAgg1xJpb67
         HmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575273; x=1717180073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MV7QZf2fhH+OEhBA38QGxT92fUaASU1Nxo1nxUSVd8=;
        b=k2cPB89bmt2ljGxvRqmyWjdCMUhn4t0PkMdpuahZR2znhgEnaSun5qsO11S82xvFpT
         saMtjxuHlOfxwY12PbcoWcwnp7MTBPCHLU4scq4JPbU+ya0pQOWlhQN9T2eqUyRZtVWJ
         SAS3B/jvZeefZsyeX9I1o8Io94e4A+sGsQWIWKFYmiafN+VayuRp+6cQEZF8W4mf7w25
         9rs5tW1bJJ41MJCFkJJpD7sUCIzK594O896g8WRtHqVUcM/xC1NEEOKpuytSCthC7pkm
         /r/pbx0BLICcQefmXZ+1bcqUFFg+4TxRplmGuaVai1vrOxcgMFEju61hXNhXjoaEZqUS
         A8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW7llVpS4txESvZHCEUumWCTENqwrssrpovWSqPZ/d7KlEAT/Nzntoh8Nq+/kx7Tu8SyZCpryyJhchcyeuj7PJrPd71DgzNL2nZ
X-Gm-Message-State: AOJu0YxONST9+m/1TWze1Lq8oTzohQYO9EBodqZiQLTIgpJNbN0MeLcN
	NlH++ukAkZoDqxX5lyNCpG10iqjkHTm0w4EzAueDQWQ+rNcnizT6y1hmuRiKNJrCF1URTVo5cmN
	/aE7vg2lORSE4i+2DX44II1Oya/ithytj
X-Google-Smtp-Source: AGHT+IHWZ0JTRBQwe/XochchvTJaAoc7r7/ijNNUJ35CDCjZA7ALjlPQSMAk7tENe+DW/f85sGYNAcbTrrfr
X-Received: by 2002:a05:600c:5799:b0:41b:f2ca:19cc with SMTP id 5b1f17b1804b1-421089f93b7mr26088945e9.34.1716575272958;
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4210891c6edsm1217615e9.20.2024.05.24.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 03/18] ARM: dts: bcm283x: Update to use dma-channel-mask
Date: Fri, 24 May 2024 19:26:47 +0100
Message-Id: <20240524182702.1317935-4-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the driver looks for the common dma-channel-mask property
rather than the vendor-specific brcm,dma-channel-mask, update
the dt files to follow suit.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi        | 2 +-
 arch/arm/boot/dts/broadcom/bcm2835-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index e4e42af21ef3..d64bf098b697 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -103,7 +103,7 @@ dma: dma-controller@7e007000 {
 					  "dma9",
 					  "dma10";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x07f5>;
+			dma-channel-mask = <0x07f5>;
 		};
 
 		pm: watchdog@7e100000 {
diff --git a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
index 9261b67dbee1..3ba8db8eed0f 100644
--- a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
@@ -46,7 +46,7 @@ dma: dma-controller@7e007000 {
 					  "dma14",
 					  "dma-shared-all";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x7f35>;
+			dma-channel-mask = <0x7f35>;
 		};
 
 		intc: interrupt-controller@7e00b200 {
-- 
2.34.1


