Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33E4843CC
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jan 2022 15:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiADOwT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiADOwT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jan 2022 09:52:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D67C061792
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 06:52:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j18so76688851wrd.2
        for <dmaengine@vger.kernel.org>; Tue, 04 Jan 2022 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhyRDcAYAg3Q0/LJrN5ssj0ohBsXnQFjSjpKgIyyw9g=;
        b=qgCriQxq0ntL+4GWVQmaiQbCYwfNvSE+ijumFfWDf94KcM354xt7AQnCwuPBt8LkPk
         Bp2PTyQnjNUTsQXx/UqkErPk7lMw17PugWe2DNPie5bhUhBDbsHZYbjPAuYZcyjq9B3D
         NVACFsYSb6wodjHq2ZDu1iqRrCASt+UkhHctBDMxhXoxEVHMRz9WsO37F0pCfhSC/mJv
         +OckIbta4YJCfwLq3xVZsoyVhvVcBRBk18z/w7xVeCZHAuJfEQaZQ/s70TYzd4O4s7ri
         knk8KuM0cffgzY/Arv58IeIZuhE/Sf8Z6fqERNSR+3lV0o/XrX8Je1lqYqQfOYd1wjoh
         jn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhyRDcAYAg3Q0/LJrN5ssj0ohBsXnQFjSjpKgIyyw9g=;
        b=OqnkYo6V1VLyHMKzekILCrXYUTUKxkIXuwaoi2KKs5cvt4tJHh6oa7JWeS/HHMmUqm
         KoGJp9VZmJjBz2CE+5i+1FZcgSF0r8Xegg7+Vue0GbVCBrYoF+3dgWSCW6eKAUS3GVqK
         5FToprmW+ilcyzCHL7DsAqYhTg6is87/txQhK0TUbrx66dTpZEPBi1VjX3fOycUshXfd
         aEn9vqHZVIVXNLtcygDTCIKKiUyxAbLuhsc+bioPcreaOCAMaUPn3S5V+w3Rl4LB6ceR
         4kBGeEH5oCh0dmhvJ8cQ1W6ttGGJ7eW2yor6AWe+e+iWbKk0xb6J317Pp8C59GpL4KJi
         7i9w==
X-Gm-Message-State: AOAM533Oq26ilVZGjq1Vn/j2DEye+/tHWTrXBAYrcXulP3uwv4YEi2e/
        wNhBuYilli+kPMF76ZCkGzWDdg==
X-Google-Smtp-Source: ABdhPJyu7XA8SWsiYPPQCj6xPaOAbwDu2a0ry2jooPPLmfASRRiymsHWP0AZCLawD0zJKoMYS6lP5Q==
X-Received: by 2002:adf:efd0:: with SMTP id i16mr43370519wrp.86.1641307936801;
        Tue, 04 Jan 2022 06:52:16 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6da:6ac:481:1df0])
        by smtp.gmail.com with ESMTPSA id s8sm44631911wra.9.2022.01.04.06.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:52:16 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org
Cc:     linux-oxnas@groups.io, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/4] MAINTAINERS: add OX810SE DMA driver files under Oxnas entry
Date:   Tue,  4 Jan 2022 15:52:05 +0100
Message-Id: <20220104145206.135524-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104145206.135524-1-narmstrong@baylibre.com>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the DMA driver file and bindings in the Oxnas maintainers entry.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..782332ab0d9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2371,8 +2371,10 @@ M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-oxnas@groups.io (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
 F:	arch/arm/boot/dts/ox8*.dts*
 F:	arch/arm/mach-oxnas/
+F:	drivers/dma/oxnas_adma.c
 F:	drivers/power/reset/oxnas-restart.c
 N:	oxnas
 
-- 
2.25.1

