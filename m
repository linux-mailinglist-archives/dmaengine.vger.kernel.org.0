Return-Path: <dmaengine+bounces-1608-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B688F9D2
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 09:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDD71F28AAE
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1FC28DD5;
	Thu, 28 Mar 2024 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGPu1T60"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FAE52F6D
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613618; cv=none; b=DsRtFcirAL9+Qtg8AR+3hjaD8x+47AZocu+TMc18wnXHtzOncVyIr702BJUvwB5I1/1TqecQ8poP+rGdCYeLKrK284ZU07qUeQYchf+Og/Y4DC8ItinIJHrZgNWC7sv/sPV4J0LhoBuo+kGlCqvL14W+/bbsuDtPBSJRDWLDjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613618; c=relaxed/simple;
	bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlbKuzo1J56WLO/DS71er5iYMreX8HwmmMZwFgQwcH2/cIbNTy6H6lu/EQi7XsvPMCctRtDT0k08jz4kMKhvMJkmNY/eDVgywT69O7HNxGKNxdewtu6uht82EVPRMYdOJrp8YV1XyJ6QGxWRdwsX6vcGYLuibZc7LipD+D/kQYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGPu1T60; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so633719276.1
        for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711613615; x=1712218415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=rGPu1T604f65l8GfP69kX6JRbPffcFy/o35NPUwWnMiP/cna3H+Xg6fNhGYjtKS/G3
         RIy2e+bzL2xqdVXw2Z1021NrZmaTNrC+1qdFbpX2LZqGwUoNEmPWAS77AlCMMW4R1tA5
         cSWIy9kTz/13r0R7fMarsZB+7B37iGXCyyY1o7kKFjbQKdV12c9fuQ6zf7oNTGQI/Ko6
         V2B3lNf0ejPgsV8efoBeRELRNgcYaL+zkX6oTjEZlZVS8/14Q2x/vde5CdsywG8B4+Pf
         LBzjuPTq03IHDAXgBa1udYhNf2GpW0xkAEoYJkI662J3Uv+5MWzozByvFKcN88G83Svw
         ejkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613615; x=1712218415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=GCLvNi7fOneQC2Sm7Drogihxm1tg2TWNwBWFBou6xzy85WiCwo9paJOIPdJQfyv1K+
         1Cs025J4gF+nomlbzBFz1NaVwgP7Z2/RHVnqZMCCRbpL0bNgXB6VTPAFkof+g31J99Ml
         ASH/S27L1HLibNe5njHBKauPApPSaCdIAd86fr/sGOSSN/Lb8Dgiw34xRef219EWsg8r
         61XxyNgYqp7380L9O5IOttXQfc6eA14j5RM9OkElJBcfFhLKOcmUVf+v+D/AhvUuEcdz
         L1gfXAQ+fBQslUoOzPUEiEy610Z7SBihH7dGd6PPxNtrERgs3PFoh2JLj7h3OeVw1ol4
         JFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBiMOPFMQWhXpTqxdpUjWrMYPjpkqVdBNmy0rvcHqBlobfwBZAgYmcky2ZI/criYUr5qfVs+0dJZkbFCBfOsaazuGdRISCVJL6
X-Gm-Message-State: AOJu0YxTcFvHDMDPTjM4kWaGDBX/fADHKUgYeZlWFPif6OCMyH1poru2
	zVgEBQFJeJpoosiHDrdzM2qBl5Njgo13KRMMyoYD8hLpoygTVGxlFunCcHx0y39/dtsd53DU0ZW
	o7RR+L4j2+3OkqNSWqRvxzQ+sh0auNDiaifiscg==
X-Google-Smtp-Source: AGHT+IGMP4Tk1rGQykOPNpks4MpJ7aMlQvkvBPR1XoNvNcoaKqQfOEDiNp35dK3mcwnlEPOwTL2pN8U5wfPMlD/HYFQ=
X-Received: by 2002:a25:4dd4:0:b0:dc7:4806:4fb with SMTP id
 a203-20020a254dd4000000b00dc7480604fbmr1887988ybb.8.1711613615243; Thu, 28
 Mar 2024 01:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org> <20240326-module-owner-amba-v1-14-4517b091385b@linaro.org>
In-Reply-To: <20240326-module-owner-amba-v1-14-4517b091385b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 09:13:23 +0100
Message-ID: <CACRpkdaXWOp9C+7ahUO+6eTGodABW1D3CAGoE-6RrXbFcpd8OQ@mail.gmail.com>
Subject: Re: [PATCH 14/19] i2c: nomadik: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Michal Simek <michal.simek@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Amba bus core already sets owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

