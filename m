Return-Path: <dmaengine+bounces-7591-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAAECB9D0F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 21:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE8C23074A91
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44E30DD1E;
	Fri, 12 Dec 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjvMyWMH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14030F951
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572676; cv=none; b=LGtrIJEH9mW+TxeHX41ob07XhzVm5hFaJiQdGHAFGeyH22aUFl0919LeNgkU8w59QGSyY7AADFZt4E/d2dLc9zIeYZbOXgsmPhLJSQCxOARMPdXXG7JAPcUTJjVNvfp+wGGiWWNgaRWRLFRxIJk3WpI++pQGQJ1UD0JgsOlyN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572676; c=relaxed/simple;
	bh=HZElLVOBo++aUOfBn0dfeQ9TDOuzLpu6pDq8v/AVPfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOXj7u6jlXFcHl2n5wBKa67BBGm6uJZGAVQTbbN5K3V/i9y95kL+9knw25dBnVDb7uGtpOvhfWd+JSVlV6suLlcN/ghDtmk7NNHnUmsRSD2faEldgzGaaZ8pcwojZcj5RP4SH5z79ifeNf7dZXXi5pALa8KKrb4+e8XNF53gOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjvMyWMH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so308575466b.0
        for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765572673; x=1766177473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjtjqxP7XdUENHCexmCRFp1dqpJh3fEH6pKkpxM/TLo=;
        b=PjvMyWMHHSIcOvuxBlvgqeXIyqwyHl/64zAgza74W5+PoERM2K7LSB0VpAHZYTU/Z2
         MDxYT8rJe7HZCqz5v558ORBJZvPW1RKpf2AYY2huMPNnR/Z88K7RisCaPzG0/Slzaqk1
         Cd/H34KivsH/H+6ny/Mgth3Dxu1nyE5FdpYvQ+iWqXJLheuTfYufmKvM7915Zn31AbSA
         hh8QObx4YxqAQit4ijhwt4UdNlgWLyLqHBidFqT5SaQTagS6PkFYW0icpUrfpkT5onms
         Jf573kzZ76lkviqs8BSJ4WVYBvRUYveW7YmpXZcpcSypwLhKFi9S451c3Bkcez1zIFPQ
         yO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765572673; x=1766177473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjtjqxP7XdUENHCexmCRFp1dqpJh3fEH6pKkpxM/TLo=;
        b=DY42yT9plEglrwgIiCrL/LsHdUacXWZQtEmJhegLC2gRCpsu2tYFe4kkdNaXzcDc6H
         bqMmthOARoChSJNj1qu4egDbpg5zW0mxFC0wkN+bjJ3f9/z5QIGU2JtVX9cdWhAxOiI1
         WC8qmLnQyWGmF/vkG8BI2A57SC5UCA0Gj/tUexAUMSJGym1en9AUaNZWtUgcPyvfwpuZ
         4Gdrxh3H2QxiJ6VEQ6tgcuJIHv+MNJylHolpr4fzQptGJeuD0IJS4c3tEZB9Ex0JBcP7
         Q0t4XC95uLIoeeb3Hh8zB9BXV1i7AS7FNaF0yWORH9L2c/aQVLCJ1XKA2Jkj7Hn5Clzx
         eEgg==
X-Forwarded-Encrypted: i=1; AJvYcCWaPyqAQe/EyserfusgUqoMJ5dpWKQpYHEIW8z/57TljkRQYvu6DWh+9Y+jENysdksip/IdWc7K0wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU/E60RG9BMgURm2nti4t6KT1WWsqVqu25GuV9i6H9PwV3XkI
	9V2UzTrtCr/Lwysf+xqhFHnYh6y6U54plLbX+1lGeMKs2ZHWJmodMACu
X-Gm-Gg: AY/fxX7SZ0+mt+Dd0KSVCMzTkkJ9DBnk9xshSvVt+8qn2tUIPhYSehTJhY95pHyM1D6
	w/N+YE4fhytxFcB/VVSG1YsjLq1Gs/OcKbXlbpTgbcxhXbv7CcbbD+s/ISA50luVa0f/LPC0LsO
	ytTAdS2FVu2vTy5p3bowk1QRWzGGcynWaxgXMbK0ONZLiKBJluEuiFWiiWs2CB08OVHyvRV4L97
	n6qK7pUT52odpmGAJaTFWspkNCRhygxwQBDBhtwtoEBlBg3sX46MBM1MrbHtxMWhzfwRve+8V1s
	tozMjXdoOHQlPjT+UMgbN4RJioLVs7Xn7cQl7iVe4E7eudKdJG3385PAlSIM1cAJHQvj1x6vZSC
	FuJmzfwKjJ0UBCIzFK23b5ugLoSc3GzAvKAAy1yLC2b30hesEMoeoaROvqsRPB2qiRoaMBTkiTK
	EiCOmJlD1qffyAfw0=
X-Google-Smtp-Source: AGHT+IH0G8rGAjvaE42wch55hSIA5VimrXWt5TN/hh537MIqh383tSvfDzdlGbn8S/gXANm16as6JQ==
X-Received: by 2002:a17:907:2d93:b0:b73:7158:d9cd with SMTP id a640c23a62f3a-b7d23a22af7mr366919966b.52.1765572672256;
        Fri, 12 Dec 2025 12:51:12 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:1401:37b6:6a29:b0c5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa570167sm656400366b.57.2025.12.12.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 12:51:11 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] dmaengine: sun4i: fix resource leak on promise allocation failure
Date: Fri, 12 Dec 2025 21:50:22 +0100
Message-ID: <20251212205022.83482-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When promise allocation fails in sun4i_dma_prep_dma_cyclic() or
sun4i_dma_prep_slave_sg(), the contract and already-allocated promises
are not freed, causing a resource leak.

Fix this by calling sun4i_dma_free_contract() to properly clean up
all resources before returning NULL on allocation failure.

This addresses the TODO comments that asked whether we should free
everything on error.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/dma/sun4i-dma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 00d2fd38d17f..d81e705ae91f 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -861,7 +861,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 							plength, sconfig, dir);
 
 		if (!promise) {
-			/* TODO: should we free everything? */
+			sun4i_dma_free_contract(&contract->vd);
 			return NULL;
 		}
 		promise->cfg |= endpoints;
@@ -954,8 +954,10 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 							sg_dma_len(sg),
 							sconfig, dir);
 
-		if (!promise)
-			return NULL; /* TODO: should we free everything? */
+		if (!promise) {
+			sun4i_dma_free_contract(&contract->vd);
+			return NULL;
+		}
 
 		promise->cfg |= endpoints;
 		promise->para = para;
-- 
2.43.0


