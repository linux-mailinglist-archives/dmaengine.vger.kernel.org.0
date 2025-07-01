Return-Path: <dmaengine+bounces-5700-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92296AEEDDF
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 07:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293ED1BC38BE
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 05:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B025F793;
	Tue,  1 Jul 2025 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="m77tbtHS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF343242905
	for <dmaengine@vger.kernel.org>; Tue,  1 Jul 2025 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348306; cv=none; b=oJumE3eqDPJWfKUdys6uYqxR0rX9TGqLkXOM9exhMjvyzjlnuFxDMsmfjcHViNhwMd+GYWoVKHOlYG99m/7yhI6twi9TKGxECTG0YZpISQgXrJAkUJYRaevF/YZZHQt/4gUYgDs68LhD6YF0QaRf1nnIU6kqX1yRs989GwRxY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348306; c=relaxed/simple;
	bh=cSpWpN4ROq4hNgdz7Ah51Oslr+OjvYL60oNVPcd1qRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tvm7xlPersMppbT7oMQ8A5pBxNtcoJeaABmRzQYYL5+xGSPMVa/CnDs8HSmXL/YYUl7f9fK6TAX49ktGqYAPkw/wd4pZBPTPP9GCFYFc+R5qwnbX3rUId7xN4yIpzBV/9DOiAzTv8KHX5ktoRX+KSpAGawbvY/jKv3oT+FG6Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=m77tbtHS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2363616a1a6so22773835ad.3
        for <dmaengine@vger.kernel.org>; Mon, 30 Jun 2025 22:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1751348304; x=1751953104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkkyJkVw0bfJeEfuvrb6+q04bt1dqt1H1Dk83FQ9SZU=;
        b=m77tbtHSjLhsqaw+B5m9fdlgSf/b5NpcSchwdQevScoKKo2Fiw/5SirIBl5N50t/tL
         njbR+xXU2FOuUuTxsg/TQPhV1z/U2VqXpWXL/n+TNxkrq3/PjbfTXny5g9mIM+GPkj0a
         oJdSePdHqsJBpmcWATl1mVuup2vd+3ts7YvmaaOu2C2hJY/XSDAVEOAUoiksOrw8jqkF
         u+YNZeThkYuZ2kdps1MnQ5ELYEi0VRb5dAeYA9waKgz57hLZxxDUFMov79UfaKmsrHju
         PjIJL6rHVsl+LIdi59J26Pjtjl2AZ1akeJKbrMcDj/O9zfFw+5VppLNPG1ts5XSjNWRE
         a1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751348304; x=1751953104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkkyJkVw0bfJeEfuvrb6+q04bt1dqt1H1Dk83FQ9SZU=;
        b=A/lzWuAUSi0sD/Vkye5wI7XXNcQlpODh+IJXLdjlxA3iCBXnv1i9lVHj+qU+vqJNms
         UG6HzdB1ioZJEjGNEbgQ2UcKYqgyKbsllTMvX7tmDmheZkFIlu6L61bZTsfhxyvCBL+U
         8ot1HIqUApNF2gzREG9wzhO4LVORRatDNRmYOuVOZxebPSXJgH6sEeNg1dO9Sa717fek
         E7u34HEqNs5dUxO+YZ/ryL1ObudiWETnTMvqjHABIT128D8pjKEb8q8NY+4Yl0KGXGzx
         ilmhFZuLrY2XXNSKHK5WAp08MpiKZeiK1mkX5FBguVGbft7VZHaffwZVpsSvBbUBHg2j
         84ag==
X-Forwarded-Encrypted: i=1; AJvYcCUyr1ybB4HwFRqeHnQOUeG/qQeerUDWZkpHKJeLW05RqeBUGF5BMnikBdMdTp+zPSbfmPud76879SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5MmxYa16y7puzL5LVv+e7sFx+6l9SnG71SFdxv9OKKO3KQH7
	RbBMr2h56Lu6yX9f2j7fh47N+OkmT9mW0oYiqjBuAMpXh2V871s8lP5k0LMv0K38hSc=
X-Gm-Gg: ASbGncu6SXFu3xyxvpb1A0zk/2MCxaWVBf76MRytoSBalBqe+9d3PLHxdJ1PEZQI5qV
	Pin/1YnTSlef45mv1UBpsgqsjD+6Wd/3BRFdfNOdcE1vRHFHRbxcJyalaiCAof7chfELIiNAO1k
	QPHk+sm81gNXLr821kYEDVBkgU2Nh5MM7Adh5CwNXHOwWFR/kMTF7B+QdZUCON6B9+S3Axd4fp8
	Ehn1R8Ct8Kqpzror7Do46CJRTCFwfH8Sivy3cyUyAe4rRAguncO2gjSlXcd66F0BhPrAEcjwPoi
	FK2vXNxuyLxEW3Qo8CdhfCKGKpX5GeWpyBYb1Mw=
X-Google-Smtp-Source: AGHT+IFV0sJft9TTbW6Dof5c+OPMKTEfD4ooz1HCHFSKDnOrbvDpDaREUu+dR1A/ELAjaCh8Jizt9A==
X-Received: by 2002:a17:903:2983:b0:234:aa98:7d41 with SMTP id d9443c01a7336-23ac4685adbmr249282415ad.42.1751348303953;
        Mon, 30 Jun 2025 22:38:23 -0700 (PDT)
Received: from [127.0.1.1] ([2403:2c80:6::3092])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bf5fsm101729865ad.115.2025.06.30.22.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:38:23 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 01 Jul 2025 13:37:02 +0800
Subject: [PATCH v2 8/8] riscv: defconfig: Enable MMP_PDMA support for
 SpacemiT K1 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-working_dma_0701_v2-v2-8-ab6ee9171d26@riscstar.com>
References: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
In-Reply-To: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Rebased. Part of the modification in v1 is now in this patch:
     - "riscv: defconfig: run savedefconfig to reorder it"
        , which has been merged into riscv/linux.git (for-next)
     - Link: https://git.kernel.org/riscv/c/d958097bdf88
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 37c98c0f98ffc0ee9d021e4d07aa37a27d342f7a..b6519fcc91c0bb56f71df336fd3793af3d64fe78 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -240,6 +240,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_MMP_PDMA=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.43.0


