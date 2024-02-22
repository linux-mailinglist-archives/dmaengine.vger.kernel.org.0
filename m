Return-Path: <dmaengine+bounces-1069-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826FD85FA8E
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF89282492
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE49137C2B;
	Thu, 22 Feb 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/XGtNPC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF09135A6F;
	Thu, 22 Feb 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610334; cv=none; b=ii1mCsGtK9E0OwbvQ3aMW4tw2BsVxV2O49iukb1Phen5kDPI0onDte08g0S+exlFKqntF3ga9xR8OLajMo1rTiLzRSKV7rHd/PfiHORSnHNarDfBvOGwtjAq0XrSGMsGhuCeNDtYtvxxAjh+ThZPNr/mS83Dy8RmrLAMAmWXEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610334; c=relaxed/simple;
	bh=BPj7ZTa0ybr98UPnmaRLp0/4ee86tORekl3Li+MJZ0A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BUbKaEjVYnLFcrZ/ly2ISLhfQungEHgkZGPH4CiUsWEXn5qXqV4vqR7sfLEGLlK2Joe0y2MgzSlWwGxm1ss9/kBIMbCAFQ4Sb8/7VmTSXiwtU3IeH8jPYowSpY4h4IFRNeu6kZSabgQMvhb9pcqdAKJHDOQkPaJJ0KmIPoIovJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/XGtNPC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5645efb2942so1522584a12.1;
        Thu, 22 Feb 2024 05:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708610331; x=1709215131; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsFRRGkWpORaXCmeXzSxC+JNHyxXCgQHjaZ6TzY3sLk=;
        b=R/XGtNPCZln/c+4ZCHVeaZ4DD+R1bYGfrmp0e5lJstvDmlfIYKLT66SN3URkCHso8e
         yJZw08H6tvFIYiI7ImgBWinfTDjZ0ZjP7E0xayb7wdKRm68OvzdNXLD6aE6fI9N4r5CE
         qhN2mxONVR30/iIUuWrgM4Tj5sQjA3G81umyWAkyz3+qvlvYW11O6IaYhPFZGJxCuZZB
         4CfeKakatucNFmlUYhjC3OLddWTDeYj9j3xoPc6d4dKyDuiPN9aOftCN99P2q84Hj+NI
         ZymJe7uyXH2uCPrNJqUfkK0Odz3VS3PLRwcgtadSbNvEo2mmeGupqGiuoBR102AsoNFP
         tqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708610331; x=1709215131;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsFRRGkWpORaXCmeXzSxC+JNHyxXCgQHjaZ6TzY3sLk=;
        b=gZLcuZqN86OyNOyUGYe75goJeai6LkZdVJgbWjY+Xj+Z9BcOYJhhGPC5clPVaSg/cj
         P0qkStfSxuXJwLxIsmUBax7ZlkLoStgGJme+S4nD4xYzfj4VXvaU7wi0Q4yro77SqT4M
         SloOFWQB51v9DWj596XlT0AvTgVrGWelEHsVGLA5l3Rjnkf6oM98ZQM8GxxeZqVXoVMH
         QtnYEV9tEoR66wdRtRqJKC6juv5+Y3i63o6ZkV+yLCqXJAbjXvSqWaL4YctVN3n4Y8dv
         bS2YehTWqCO3C+3uwUdoOnQ28WWoVH22E+KefPtgl+cd0/jIiNepk+CdapL1syUATJ3x
         cDoA==
X-Forwarded-Encrypted: i=1; AJvYcCVF+sLLeX8pnNFgqxj1M3ErvJoI+ACI9TWOO7UuAAtmTVPJcEV06RV4ZkHvpVWh/FjH/cWLC/WVvbhtMJ1OsS5drwuSaEiWe1qFz0cQLMbhvXMETRQYUvokNaExSjPPHMT+diKw8te3
X-Gm-Message-State: AOJu0YxC6WfRbtwbaqc7z5jT/5G/KJ8OWk47r2vyh0AW0HhqgAvRdikB
	KwBwRTdTQ/R4DI9v30Z04c7/JzcO8+OIQlAonLTM8LHKuuwst3+P
X-Google-Smtp-Source: AGHT+IFIlQeNdFyMQvX3AKp0V/AMXaTukTRqPqjOa9oGpQBWhBKGNXokCjDwSjAF5L3jJ+ukTvxjOg==
X-Received: by 2002:a17:907:72c1:b0:a3f:4fd7:3cef with SMTP id du1-20020a17090772c100b00a3f4fd73cefmr2878725ejc.2.1708610330935;
        Thu, 22 Feb 2024 05:58:50 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:e4dd:831d:c00a:fc45])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709060d8800b00a3eeb10acb4sm2805317eji.185.2024.02.22.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:58:50 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Vinod Koul <vkoul@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in MEDIATEK DMA DRIVER
Date: Thu, 22 Feb 2024 14:58:47 +0100
Message-Id: <20240222135847.5160-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Commit fa3400504824 ("dt-bindings: dma: convert MediaTek High-Speed
controller to the json-schema")  converts mtk-hsdma.txt to
mediatek,mt7622-hsdma.yaml, but misses to adjust its reference in
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in MEDIATEK DMA DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e27cc69a867c..28b2013031bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13743,7 +13743,7 @@ L:	dmaengine@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/dma/mtk-*
+F:	Documentation/devicetree/bindings/dma/mediatek,*
 F:	drivers/dma/mediatek/
 
 MEDIATEK ETHERNET DRIVER
-- 
2.17.1


