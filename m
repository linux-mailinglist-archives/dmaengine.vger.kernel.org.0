Return-Path: <dmaengine+bounces-1970-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869C8B5965
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 15:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C6728B7D7
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E6854907;
	Mon, 29 Apr 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="bi1G/8Ph"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84B54905
	for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396030; cv=none; b=BpQSd6VfVno0CUOypsJzmhUvisqDMdHk1swWI8AqW+Gl7WY882SsAT3AIWIgeQ3kXS9V1Vz6YTL+cw6wahkm/SeBVoW6P4lJslRtzPCkomtB6aR9n1uYRdTuCGmrt17fBbSVEqi5cHYjGZqPArbwaZQFoztaqHORLO9m7S8MGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396030; c=relaxed/simple;
	bh=6kDnXiqbQdsH/H5NTq6U26avFeFF6McIX0qLc4iE4Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=u0akv2XMYkLGP7vUC5PJEcrO4m7T2kgPYDxCnpln9Ygdzz+gqOfI0Pbb2c/ITDrdvl7kaOAVwLMD/2YFpPWT4XSa39mJ+JV85JLFKrUhXBYgB7AoeMcgOIRw1ik9yDg6+wltOc9pvIVXXXWr/0Rcs+pet0lkWrWcPHJVzev2zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=bi1G/8Ph; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41c011bb920so7547175e9.1
        for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2024 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1714396027; x=1715000827; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZRPrMlHGD3fDHC4owvg0QIBCdoBOtdp1RpKqUI6R6E=;
        b=bi1G/8PhbphjZfgiM2yqLOeAWme50B3lYJsk7msZMQRHqI6OhfG6NZfj1/l9smmX+s
         02OlKDCkraPxTUd780lo1Sw/H0O5qNVa2UXqOmuBK8Ojtr0ggpUtZfAejPgNYB884Zb2
         91B5ADlJNJo0tQ4yydeHlnxpF4PiRKDhU3juo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714396027; x=1715000827;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZRPrMlHGD3fDHC4owvg0QIBCdoBOtdp1RpKqUI6R6E=;
        b=SiF15XoI4sowZuUC5ccb2LSrFsgS2iSKEEw3ccyt/GK9xoPjsXGJ/hIW54gbJ04SGh
         j3DXP+4po0822Mc7KDQnPzKkFlQkBeLMVEkdPWjp/S9qasdQYoGh3W+mVdwrVPVZNZVk
         +EjIRCQyogHI+wrRifuZi/ChgPQlhEXtuEz2/ccvtQNcJUGpYMNsN4MbNfeEPZEl7NgN
         5aoN8DBpEBRKBD4nWGsstPfofp9I5G8MJMlO/qrEUrGIl6FFFWSmh6cKq6H+xYra+JEl
         Qhr+Ki3kvISV0yJPcBt7ekj+gxR0MPOD2W6xradQIY+6X97o+gDg8q98kqpOpnvPav07
         fVPQ==
X-Gm-Message-State: AOJu0YzqTA359P5vEXfhdGqCKaloZlropbv4OFEsasYIEqyu9BU1+0ds
	65EwsLyVY/bzA84S21jF3Pn9KPnowTIv4MxmIoW/sl0oo73huYpBo3yDc1YVsfYxQhgUaRCqQoD
	gpaoFYLZIyxL1EbVJy4selqvaX06mUesmhNiXv2V6y9+36frE/9KFtoLSdjDgnYbjV5RY0dPYKe
	GKm9jv8Gq6nwiFcKGvLxXljF5sNo+KZXdi8HFi
X-Google-Smtp-Source: AGHT+IEAH0VJu1mwNYFt75tthnqmXuDzLpyDb/fT1CM2NBp/bkiH3EN27BUsQ1ls9MEpAtFFAhcYJifQEu+9Z7VdjnI=
X-Received: by 2002:a05:600c:1990:b0:418:3d59:c13a with SMTP id
 t16-20020a05600c199000b004183d59c13amr6405560wmq.9.1714396026912; Mon, 29 Apr
 2024 06:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALYqZ9k4MOLp7_0fKPSc--DyBjSCX_DGTvAE9HhSu69C32iP9g@mail.gmail.com>
In-Reply-To: <CALYqZ9k4MOLp7_0fKPSc--DyBjSCX_DGTvAE9HhSu69C32iP9g@mail.gmail.com>
From: Eric Debief <debief@digigram.com>
Date: Mon, 29 Apr 2024 15:06:41 +0200
Message-ID: <CALYqZ9kpENdyJWMbj7+ASVcEy_-LmO-uGw58eUsmi4eEQa7KNA@mail.gmail.com>
Subject: Fwd: [PATCH] dmaengine, xdma.c : NULL pointer check instead of
 IS_ERR() on devm_regmap_init_mmio() call
To: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Reading xdma.c, I've found that the error check of
devm_regmap_init_mmio() is based on NULL pointer, but this function
uses the IS_ERR() mechanism.

Here is my patch :


From bee2a90fc1959682afa4ff1a90adbc2a18770abd Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Mon, 29 Apr 2024 14:55:31 +0200
Subject: FIX: devm_regmap_init_mmio() error is not a NULL pointer.

This function returns an error code which must be checked with the
IS_ERR() macro.
---
 drivers/dma/xilinx/xdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 313b217388fe..74d4a953b50f 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1240,7 +1240,8 @@ static int xdma_probe(struct platform_device *pdev)

  xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
    &xdma_regmap_config);
- if (!xdev->rmap) {
+ if (IS_ERR(xdev->rmap)) {
+ ret = PTR_ERR(xdev->rmap);
  xdma_err(xdev, "config regmap failed: %d", ret);
  goto failed;
  }
-- 
2.34.1


Hope this help,
Eric.

-- 
 
<https://www.digigram.com/digigram-critical-audio-at-critical-communications-world/>

