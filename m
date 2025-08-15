Return-Path: <dmaengine+bounces-6042-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 464E5B27844
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 07:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230071C2802C
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 05:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F541DE3B5;
	Fri, 15 Aug 2025 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="AMcKf4Va"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6702BE633
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235112; cv=none; b=SIkiMyvxSSd5MJSxMMZSshyDcWM7HiuKyKKaOY1RLmIiSpl58doiKVSGD4FCmx6kWYgh1r8Z6GZo8YLMehqt2NnBld6wTO7/Q8yHlQCyjFOojuMlY6brO5OnpLKUDd4JTtKno4HDpAcWGvI0fHcbVIQo9aN8JXGZXF87Bmm3k/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235112; c=relaxed/simple;
	bh=GE9SRjuuSCv8a21ZTqK+ILZ4fs5VYlehz02IXPUa02c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DljcpZXa7/T2BDji/eaxwo8wm3WILpqxLXO0TS5KoGV44pB7mx5XI9ZDDtki+A2kVjCRBr/HN3oCJGVaUObz0f5UeP2pvzKAS2eh9I733IWLqKJyY1m8tCJE5xs04a9XsBtzF/jCBQ7SNcDAahC3zv86nAGKZmvaD5m7RxgODG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=AMcKf4Va; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47156b3b79so1252191a12.0
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 22:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235110; x=1755839910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc4I4GnyT4tSPzGGnUSG7Sj2q1K77d2MqUPufhFRRW0=;
        b=AMcKf4VasHexc8B/jr4YdlKYUh+mAWofj58kYoRsXlUokFuYawfhhxzYh3rJr7b5nY
         3RhlAfjS+YPQE2tuJp1jaoBpb86FNqXb+udDmv/7ne1C1nxol3fcWCDdHaMMTFzMBFUC
         SDbcecJwXmqflcs6nUsvzNhxNG+TQfU9VsYnutsSeNkiIaYjBZundHbHer1zz3zP37L2
         nG12PVeSv3ggWjxjrAlhVO72qakIJLTO4tHY5vImaZoNhMdJQeKZzz7v1dI7HoPU+T6j
         iPAFdJ8SJO82mGN/JneFvPP2NBFXYtKnh+Fyp+kG9GVBkqbgTRICZUydP2XX8rbzJo5c
         EnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235110; x=1755839910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc4I4GnyT4tSPzGGnUSG7Sj2q1K77d2MqUPufhFRRW0=;
        b=MPsW40gz6cQFQH34JnOS5vUMSvkiRdDm4dy9i+cvJziv8a0ZIcz+QIgp8K5gRo7SEQ
         MLClBya4vTLpa8CTrWfAX/pq3lukHRAkLa1HcozfBudXkFyLAGP1WCaXIxRp55k5Jj9d
         3i7TZ1jJNoMdbleEKwM6aiT8VCR2NkPXF4v7oLT4uY3NZYjV5ypBC5BhwKWyK4imB5N6
         5qIytEifXszNzlmrcAXGMSv7ZJ7y/v0Rrzzt7jryAbBP4a/c8NvmEiH4p5kn5QTwn2cR
         ivbvvwVGC77W2mBkwqRQnwIe7tJnn2dQsbSwgQkkY9PNnMsO9YlH1wD8hInuO5Z/6gcH
         qw5A==
X-Forwarded-Encrypted: i=1; AJvYcCXoSH9DkImbXz4Qw+XTWsD4qedzI68TboUfVZlU6XniDcv/DFoe8zmGLiPI5lCRP1+3GVNMFEXiOeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGHSGprlfnsXpKlfWfRCYs5cd4Yr33G5/R12hGAl/Hnk8FDJH
	EWnYoivJal5K0qrldaixF2qNGIr1kUFX7i1zyW70owWrFM6eYiMI613A9Kb/h+BvGFg=
X-Gm-Gg: ASbGncvYTLn4aZxB+joi3CAXBntnTnyROXtkoyWsQoaiuqXv6PIxxFB39PWhsyo/0dz
	sXSCQ2yiCfsDGtQfXmPkugFhdSxmfEDRk6Sf8wAbygBeZ/CcQSMxjv2GUKz3r8azue2DHYJ9YwR
	G0+V+41WtzSoY7bF25UIfQPkvosiAYIy/Kcl30IdSJ6kbpUxdJNEw0WNSIKn2ZPX/hZ1Ue2WS7B
	KuEvPk+smMr2c5YfJ95S0bHz3n9u2QuV0VQxrbmWJ8n5JysUGlJgO8A80McTCD7SmUiQrGR9OnR
	BHLXIyAZC13CO0L22JJtjnUioXfk81+3ByQRq7WqEFtx/MLlvoR2RhiUYbKeSTc/VWZ45ZFJxL/
	j+tWFA0nMfvB/4dUfZMV9dg==
X-Google-Smtp-Source: AGHT+IGivtfLCH94EwiqNLknns+DxOUwFc2vsl21qa22pKrZqAF+FtlV7AV9pspZ7Xlow2+nX+AUYw==
X-Received: by 2002:a17:903:245:b0:240:3dfd:99a2 with SMTP id d9443c01a7336-244594e0c77mr83625715ad.10.1755235110149;
        Thu, 14 Aug 2025 22:18:30 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:18:29 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:30 +0800
Subject: [PATCH v4 8/8] riscv: defconfig: Enable MMP_PDMA support for
 SpacemiT K1 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-8-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: No change.
v2: Rebased. Part of the modification in v1 is now in this patch:
     - "riscv: defconfig: run savedefconfig to reorder it"
        , which has been merged into riscv/linux.git (for-next)
     - Link: https://git.kernel.org/riscv/c/d958097bdf88
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f25394d088d0d3cbee41fa9fb553c71e495036fd..b9ef2da15fb22f08bdb5ee5d1bba9f6eed49ff97 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -241,6 +241,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_MMP_PDMA=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.43.0


