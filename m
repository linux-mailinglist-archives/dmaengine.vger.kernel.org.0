Return-Path: <dmaengine+bounces-8309-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFAED3851B
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 19:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B171A3006E33
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D57399A43;
	Fri, 16 Jan 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlUCJCIT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AC346FAB
	for <dmaengine@vger.kernel.org>; Fri, 16 Jan 2026 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589978; cv=none; b=Q5ktt3jd7FYLxiPLXEuye+3ZFAO/BQn99nRkLKt333APFGEwaDBOjq+WjcDit60VjZLztoGrG0F5zijNIZQOF/JnBkvz76vDNS6iWzyF8Pcz7Wq8uFHTqSXPP9PixuTvsTvw9ue/0WG5ALiEmIAhF1EP3ZKyLA2K0R2sjAJdeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589978; c=relaxed/simple;
	bh=TzSo+tlzxFxHwZ9wkSBmczjkeQhikq+vs+l7Oy23ORw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSDTUdc77a27pcO84huJHLC65N1wlSkf7AYm2nud7EIKiIlnQsuPZ+igUp7FZqOW6ACh6V8daxHIGiNg381AHAJ8MNSDBZ94P3QdYWYdgjRu4uCjtw6TYb7vmDLTqD8/4s6BhKVMpqSrI4yS9/VCmWTECVuDs2fsk6XTumlFz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlUCJCIT; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12332910300so812780c88.0
        for <dmaengine@vger.kernel.org>; Fri, 16 Jan 2026 10:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768589976; x=1769194776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsdpmGsyOkVZsi/y+GsHdikzRvoYJyk6QlblSikl37w=;
        b=dlUCJCITWmOW4mqAG7Xbkgj7NRmaG6VLpoK2ZrOwa9PzqpvHtGbpNt5DdfpbMfI6f8
         MBGic3fBcQxkFvtOjk955jVpueQA5L71DVScE8srthwcmmWi6tvUIoZqdNi2YffNpGmk
         nqVy3jRkPUWNZnptHQNu2KRgIOL7hsgUSXO1eWclnZgNriW3n4x8V9A0JN1Rz/eg+0fz
         I5uYs8QjYI8lqZOB6xDQN9pNTWgLwmbwOgRq3tRDln7ik7iB7ngax4onYVoAZIby/bP0
         gdQh79wASr6VolTux/EhIL5Mm+IT6ZYbr2SZABz4upgyfMN2j/1vF4xkRiVh0oXGcBrP
         GlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768589976; x=1769194776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsdpmGsyOkVZsi/y+GsHdikzRvoYJyk6QlblSikl37w=;
        b=YMMbbW5gEPS8jOrALsuYZ8Lgh5JY9OMtf9YXAeCSD2U2MoiNuFe7VTJ5nPuPHwhWCp
         /r303mxFVrbxfrdzPGykoNKGAXZBHXetNx2a7Y5qwBRoFEEvunAgFHheEYqBT8VjWPKl
         HJx6LVx67HXhR7P7mAKblh+DUZMCxVk+QOEHxfvdPK3PC2oB22w7xHn18BAEhr0W/KrP
         bl8O3GrVI8/XWzB72XOpCS1owPnVaGb1Gba5LDf4+2YCfStvjBK55KBOAlJb6Ofzvyg3
         VyHEw9cWVfa3rq68GN5mxQe8MmNxRMN0jynj3pSd6G8009TvtOx3vUmqMcB2j00W1XaE
         Jdgw==
X-Forwarded-Encrypted: i=1; AJvYcCWCzyWiRVWRi1gbyBMFHr+NwXjfoTxqiD8D4uaUcrODpEk9pPYf6flfCys3H9csifo4b+d/3D0zcIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3o5uZFcR3NWzHWAiWdE8iiQG6lsEtVbxqm2SczZHcxViGvm5
	aFVBfPxe5f1vV83NBo+n92ZVt1HKaHRN5Z9/F9EaNAhLanOaDMdLZaRI
X-Gm-Gg: AY/fxX5S/uEihXycpoomTsvCJIjZN0Ki2TjGGdYTHxTs/1S6/YY8Lr5zZ+9zUQ97PEh
	xzSeOwcIcI8UnQ0wEdGBU7oQhQnk6qHIGNqJ+GCN0y0TcNYvLFjyYv8Ys8AjLny+XA9PWMf/L/r
	q70BM3rV1vQ8rHhClXhXyAjeOYBpDCKJcAO9MLex/Q3BzSxV02UKgvG6QKwEyIlttlwtclblwXw
	MhJL+cl+YEku/NVUS165E/E/dvjb77n4Wd4zbW4U6EYFN+brjy8w8DjGDtvb8B8/pqD1E3B0dae
	J30wB3+SaQ4x6XJdJulFyTmumhpWUkj4iEaP8jaiJdGd7pOHofiYn0yoFz/NDMUDOGHxbitZJ6s
	rQ5LAlH3V/w5yTaQZxQ2LJAUZWkh9RCTOKlL580XWZJacjLPejHhOKXIwihJhKwLJPMC6FCOz5H
	d9R607K3lyKSP8VOUGFAOQOn++4OYHV9bFVeZFE0viG6F63Q+t4yVHUVFEEJ9hdasGw2T8hVNaj
	CuHiy4=
X-Received: by 2002:a05:7022:2397:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-1244a75f051mr3682555c88.26.1768589976312;
        Fri, 16 Jan 2026 10:59:36 -0800 (PST)
Received: from localhost (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm3522534c88.3.2026.01.16.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 10:59:35 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Sheetal ." <sheetal@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: Re: (subset) [PATCH V2 0/4] Add tegra264 audio device tree support
Date: Fri, 16 Jan 2026 19:59:27 +0100
Message-ID: <176858995889.167465.8638060731154515673.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20250929105930.1767294-1-sheetal@nvidia.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Mon, 29 Sep 2025 16:29:26 +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
> 
> Add device tree support for tegra264 audio subsystem including:
> - Binding update for
>   - 64-channel ADMA controller
>   - 32 RX/TX ADMAIF channels
>   - tegra264-agic binding for arm,gic
> - Add device tree nodes for
>   - APE subsystem (ACONNECT, AGIC, ADMA, AHUB and children (ADMAIF, I2S,
>     DMIC, DSPK, MVC, SFC, ASRC, AMX, ADX, OPE and Mixer) nodes
>   - HDA controller
>   - sound
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: dma: Update ADMA bindings for tegra264
      commit: 919f6cd469c605f1de2269d46d04ebf80a1af568

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

