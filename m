Return-Path: <dmaengine+bounces-6742-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E1BB3EEA
	for <lists+dmaengine@lfdr.de>; Thu, 02 Oct 2025 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38593AACB4
	for <lists+dmaengine@lfdr.de>; Thu,  2 Oct 2025 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C229CE1;
	Thu,  2 Oct 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8dLD5dw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9492D46CC
	for <dmaengine@vger.kernel.org>; Thu,  2 Oct 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409264; cv=none; b=RCJ/KRHopilTYp+w2EF7dz1mxfVAvHidoFuB56TjieXs4z6E2a+DQM5Fhy1VpeMQMaxgP8RFTtuVb55RkB1bRJnJYLVkk+6Bl2+6q2SL9eF9GGCM5yRRkAZix+/8AZ6pfGJvrZOB0Y4gn/10ZVFnhwwFTBmO4alysTkDyDh/n1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409264; c=relaxed/simple;
	bh=hyCU+EM5MVqp2Ncmpf7/x1Fq6EYDnoCdRL4dsEkWNw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qp7TbcWIcg6qAfP9hpxrqJuJ+iW5hGtPwPjk9BuigM7AbTG/KmZ4lFPvA9iyrhqWAaVQnQyz3eRcF0Mr8hAPI4a5IoHwc2UNTuzm6r9EbjLItxE2eVeINhoMnVadooQ6ieBOA2e4sWjSSfoQIbofslrQFLB5Xl12I/p7GvW+5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8dLD5dw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso6479305e9.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Oct 2025 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409261; x=1760014061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ET4ihU5LqsfIrlbYUc19Lai41MLJqMKOlTXkrUOUnQU=;
        b=i8dLD5dwe8nGG09ze/WTvKMjI872cwhtOzII5+iJ0WGFP835a339ZhY16vJlcN1Uka
         CmuD7KGrOF0VLOEaLakxYahtl8rxCyF9DS83WSxaaqcr6q23YzuDdNWPbCILkFsMsz1u
         Fblm6DJHKQAzIaszN5CS4oKjI7YR+fZa7p3DczDTXRKh4uRfa3ZXQb5dkNfpgE2mWCTa
         sbO1AqTSO7rtZS4N0hPq8yahRC9frX+SlhK9WDjGKDJto/+8X6mmTgTwuWzAeafC4A8D
         bRM5sJ3yxrC3uATMo/l/y1DAvTNV7z/yJQN1IQKDEUJCvC7FzJ2f1WBIoX06v43Ny5bo
         w13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409261; x=1760014061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET4ihU5LqsfIrlbYUc19Lai41MLJqMKOlTXkrUOUnQU=;
        b=lfSAL/A6Bwrdc4myk9O+altudntETgFJuKsNzcI/Oy5Fc0fgaUQJ4O8sn6Mg5rWK2/
         mKJsXVfZX92yucCiLATZpp+WDFkI5DpRTm7OHW0yTmMmLDlshCGcS1NbHv1bbX6ql9YK
         5FErY8MDZA4Kpcq930+6ZxwmasmTqqKKH1uTu/Faprg+aT1MPEDIgtABMVRxbT1LYqDr
         YB+oAiKuvmqSnXl+Z7ZdwBrcA2eJsBAwgi2s1cIiZBoThsn0KZFZvFd6/O/j6V2jmP5u
         l59gKnC0X7QMl1ckXI08uaCrWZvRiDDoP+SKFi1LYKL1gJVqGXmIuReW/E58l+uSj89F
         p/dg==
X-Gm-Message-State: AOJu0YzRclTCmqKaubnsOkhqVm6H+C8G5sdjqvIBs81f1oa5UH52Fmbc
	b8VP47uHMP718hkqUr/Xon6naOIpr+DZxk9Qof6UAzF6JbvWfTqnW3wy
X-Gm-Gg: ASbGncsi1FQOhpieDQ8bqWXKz80v11i/WuOZyXuvAPjNjSSUgJ3Jn/JdF0ms/i8RLQx
	ZDbQboQ09N8+WQJnHy06dYf5nKwlnQVos01HufMUjfjUklW20M+YXIusoKiU48IvKmxRiBoeLJW
	VEAK+ebUSJdeMZpfrmQSObQuS1uftmELGF6+M3q+5HmxGEqoXUIqy8iUNFce5w7SsEY6VsO+K4w
	Fb+NaAxeYfwval/ooCE3wmKXmJBomYLP0ZBIwng1VC15O4EJYMkIhmLpflYQLDF/ZXwkh3EVUVR
	WmVKlcN3UkKW7hLCdPjvzi6tLIg+JTGpFSn82zF8VVBBS/O2Kc+YEgfmXOqKNZa2rBOIEu3jjSV
	aWe0o+4QuYVCxihPKDw7ILMUmZurusQCXAsgXldz6jpig7ILI90raqCoJkg4e4Trq7FP+ex1C5i
	n6j3KDzsFk684/XaE=
X-Google-Smtp-Source: AGHT+IG14FNYlyj1SOve2+lpdu6yCG10mUv6KZ7dieXzI0BdMzJSkDE4fwEUuAUNod2k7Ird6LY+WA==
X-Received: by 2002:a05:600c:314a:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46e61285328mr58217715e9.25.1759409261152;
        Thu, 02 Oct 2025 05:47:41 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:607d:d8e6:591c:c858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6917a731sm34541085e9.3.2025.10.02.05.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:47:40 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dmaengine: sh: Kconfig: Drop ARCH_R7S72100/ARCH_RZG2L dependency
Date: Thu,  2 Oct 2025 13:47:35 +0100
Message-ID: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ DMA controller is used across multiple Renesas SoCs, not only
RZ/A1 (R7S72100) and RZ/G2L. Limiting the build to these SoCs prevents
enabling the driver on newer platforms such as RZ/V2H(P) and RZ/V2N.

Replace the ARCH_R7S72100 || ARCH_RZG2L dependency with ARCH_RENESAS so
the driver can be built for all Renesas SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 8184d475a49a..a16c7e83bd14 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -50,7 +50,7 @@ config RENESAS_USB_DMAC
 
 config RZ_DMAC
 	tristate "Renesas RZ DMA Controller"
-	depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.51.0


