Return-Path: <dmaengine+bounces-7066-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F106AC38D96
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 03:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF761A22494
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 02:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744524503C;
	Thu,  6 Nov 2025 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz5G2w0n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287823D7C8
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395637; cv=none; b=RsasLx7lraWT1zGzKCI26WSfYYb23nki0aWPUGF30aiR2kFo6IePNFdp9ZUGtjAHuWIf56AkKCVMQYDDzTTTzwDgRVu5Ru6dUP2mk68mVKhs3EoAc6+nmO4ftx9JRh8x/h2QypfXV1Z1Fh8BpglYGEVbPOo/Z64/VK0EhAvfYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395637; c=relaxed/simple;
	bh=rSbLt+ddIiogMpjgjBnkgQxOsiw/eWenHfzbMTcNGic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbhPxfiCtVZnLOEGrhFDtZTvg1TBNelyUjppgaGDvcH3n3N369XuD0NwYQBUFgwJ0sUBDZpYATKJfjQ5qA0ELFWJ9H0ziqV+4p1Ptg3bRkaVpZZV4AnrnqA7vy2KV+98RGYh28YmNp3YUPCtgzhFBZrkkGb4QB0F6A+r8Cv2MqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz5G2w0n; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7810289cd4bso469460b3a.2
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 18:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395636; x=1763000436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr0Vse2Y5fi04cdwwrJDnW3ctvlVERZyfsaruZe18ZU=;
        b=Cz5G2w0nyhS/43Q8+hGuGvxSFWdb6c3ZcWY8f/5qJOO4Vyv+2PeQRhDfRKjbpRM1ax
         JriTpYxU9jAtMxxUHq2lXxza7P1a02RQQHEqRuw+HtXOdXIFjA3VWecj6NOCWMhvfPCy
         K0DYpZdO4llPIZkiMsdZpjM/Ke/TszGP+PJ/LNopB4wnM95QqqqwZXzyiAuKz/baMTr/
         lilMCoojnDHV0lCj/6q0umZ+bSwrWbZP+Y3ECr/n7qdu3IPeAiibdcGmO6vqH4A9WqSH
         U6+qpVb//h3+19dmkMVu02roBj7A1MJF1Yoff2rqNEDhDsS1loOeUMl8r3ePInGL5qe2
         S5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395636; x=1763000436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr0Vse2Y5fi04cdwwrJDnW3ctvlVERZyfsaruZe18ZU=;
        b=Kl1aUG0VP+7m8JP5KesG12OW8E1v4SozrZwOb99A+rdSnL3kDugIv9MAjvmKw3lXgn
         ZFKmkFND8AM35HXeNOGdYd+qg7jrxB0iqfU2vmjHOj/BNViWbh9ShYfJX1SyfGf8qlaZ
         0pERxG7xud7stXxINYIBfOgzmWJ4wlnFz1AVsjqtlVDM5aE6nxv7vq82KRPJbsIGX5g9
         6auJsve5+WXwwYYPdOUafhn2xJUpoBdRqAsq1Ss35ar+lQjIMoma+7ioX4+gDDXl5Jwp
         phwftVP7Fi0bcp98yV8SidawYqpFO/CT/PVr04+VaBXnHGmtSwGoTyHu5NAf01pdUxz3
         WkZw==
X-Gm-Message-State: AOJu0YzQfcuwhZFVS8O3zzFIhYSv3sZ+BFVCre1dysA3nZxJRtKCAeEb
	pd84A6AktEzubezMFSgsDPRSOQACOk2nqmMnXGA8CKOOh/eZZJfY3uHkwROq3Q==
X-Gm-Gg: ASbGncslsvuzLLhiMUclLMeNc5bn81ICYghu3zgDsbTKm1v3/jJHtz04d3z+j11Y0S9
	a47xf3auQTs86Q/A2Qukm3kc/TxAokyqVxJtiQ5qQu7qr+i1pQe4wEIOgYTkOjD8xvtjhO5vgSX
	Q6SQUcGEvBmh8GIdyHtyWBX274PCPY3xZzHPIsZ36b+YoDqn/TL06PPslk+uMDN/naeG/JrYhJB
	bDWw1eqtSbUjxoPt26CYOL/zqccGJWaqGSSqesLPlrRWmB8rGSDjurE4uOocs65uBTmI6YPRfVD
	5gJF3tKKu/ANAZy6lZdmpW0g8obAWPYo1uNs3B0WAHJlPykLz6E3rvFmOHTGXn0Y+nwJwpb/5EY
	a/Aylnh8fhktjbPsTxdipUAHr9WUBsUXYEW208rAqT9nsxTA=
X-Google-Smtp-Source: AGHT+IEQBBkO+M7qfWlA674bZguEe4T/U7VSYvqSNvaqCY06piaQC5cOyLjhg4IkWXUoHoyzszlh0w==
X-Received: by 2002:a05:6a00:2e91:b0:78c:995b:4e9d with SMTP id d2e1a72fcca58-7ae1cc608a0mr7699152b3a.10.1762395635714;
        Wed, 05 Nov 2025 18:20:35 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd57f91sm830516b3a.23.2025.11.05.18.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:20:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE)
Subject: [PATCH dmaengine 2/2] dmaengine: st_fdma: add COMPILE_TEST support
Date: Wed,  5 Nov 2025 18:20:15 -0800
Message-ID: <20251106022015.84970-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106022015.84970-1-rosenp@gmail.com>
References: <20251106022015.84970-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add COMPILE_TEST as an option to allow test building the driver.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1e7c8f031b19..243d3959ba79 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -590,7 +590,7 @@ config STE_DMA40
 
 config ST_FDMA
 	tristate "ST FDMA dmaengine support"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	depends on REMOTEPROC
 	select ST_SLIM_REMOTEPROC
 	select DMA_ENGINE
-- 
2.51.2


