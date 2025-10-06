Return-Path: <dmaengine+bounces-6768-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62BBBE0F5
	for <lists+dmaengine@lfdr.de>; Mon, 06 Oct 2025 14:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116EA1891F60
	for <lists+dmaengine@lfdr.de>; Mon,  6 Oct 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEBC27A919;
	Mon,  6 Oct 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9+U7GdH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DD27FB1E
	for <dmaengine@vger.kernel.org>; Mon,  6 Oct 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754474; cv=none; b=JBCyldg4tRjLvNmLLk06KF5+76Wiou2ivWlJdD4a5zCgYbltWobqfp3tR4zwvdc/jH1+J6N7eGbPkEpmAGqLG9i/I8BxRnHP3HeKJ1gFEJauSJilx0aiCmntEZX6wwmfJXbtWpdVDC9gxSU0e0A4GonAXYWdzYivaFd75ygvmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754474; c=relaxed/simple;
	bh=1q+VIFZwiIkYLeXafY/FJdneXiBfYWG4ku3gvwDgztM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIQ9RcCN0lUfPw8bku67AT2FrTAG1OpGDC5t9zyI8Tp2LlpYpkz50m92iPUOeLfkTa8iOQYUkj2vYUCjPDK5YlgGNl9jrdoR++eJAtKzPEhYXclkzJF+HdMKDtl6Z2kY+6JRJrza4wXNKkhCQg3abiiiLdAqnrs21kmwp5dLdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9+U7GdH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27ee41e0798so73746985ad.1
        for <dmaengine@vger.kernel.org>; Mon, 06 Oct 2025 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759754471; x=1760359271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1q+VIFZwiIkYLeXafY/FJdneXiBfYWG4ku3gvwDgztM=;
        b=Y9+U7GdHVxlxRcbLWgxFnJhZWjv0WuHwhBR1aJ5YyAcHU6lgYg8sy45faBEexJm6LT
         Sq99XY3WqRecXZ55MDt/PYIGkKgEzUkq3eluEd2aHRDCfzQrXhuKRaIsCJqx7jnAGe8d
         temHYUkj6XZ/Ix9bzJaaeY973feecNInSJ/4icGgRlx9UocHnrfQIpPaaE5Fedtbhqgj
         fZDp2hEvSaddKWIF3PJo4xFI3eJvt67d/BQM0w+HVmxGkpjQqlqGsSDt6pOieypeVleV
         F6bgM+8BlasNmovR2EZPlTgSx3s8qr8GWVQH+z4SJYkxijDRw+9A1kuz9y9F9F0btEVn
         qK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759754471; x=1760359271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1q+VIFZwiIkYLeXafY/FJdneXiBfYWG4ku3gvwDgztM=;
        b=KDOS919aVsqMyKqIoheX2HhLTuHE3x7sW6MXjFyRuN1pp9RNCV5zjBUSnCFcmYg0PZ
         O0kekN6EZJv2el3du1h6GUjZwy722M009xmgUcKnACqGRpF1MUHI72OTSk8kLoTI51v0
         DiLUTVVjNg3EUp3qNwdtnxL+IFgXM9joULb6YCL/MZK58L3BC3A/MqHIviq/cEd/2DZ5
         0ND8bG/7cM+ox9cnONhuVxHtUgKuE8Fx1hNGp9CUW9h9nGGuE6eWKJ+sWKEPJlRcRzYu
         RFhHWXbDS8ka6v1tiI32KuJ8WQ4+7ZSW+ecvTuTq+PlWybUogxYH3xXhUup9EQXTL0fJ
         7knw==
X-Forwarded-Encrypted: i=1; AJvYcCVeKW5VfElWaeH+UagpqdGLLxo252etga8iBouk+DR9P/5DRHuaCfPdPtE0voj+5WN+zLFhfT+4eq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/9Pq+/PkxB3r/G1PSacBIcOAD3G6KViBR66LpfUngTg0bDr9
	sAea6mF0NUX7y08tQiEtabaroGRkzlxFb6OPnAC/1dMohxPfpMoL2I1MdTqTr/sY3HTt4H4+wql
	YTF3X5wjbMolbjnql8BCpTgGR/GwKqfdRShTAZtGz0w==
X-Gm-Gg: ASbGncvNiHiBZSw63NVjRfWTl67Xb/xjiPOH5KH7O4B6XKTtnsCyZZ0Mflb+qdMb9De
	QqjpFMzW+vmubg6RJFJ2qtns71O83ieRanptv3k822pC0Yxk8ZHf8hM04V1M7tiaYQoJFJXQI82
	0hc4ao9n9UCGuTs7zTR0jc0HSnBqwmPd3S/+RJh9GgyXLPRph7Eepi14aJHYB3aoprI/IsHyuCq
	JWpsLUenKgk7pwGcidxC1lwQS5VJ2erhycxMj/3Qn9s5ahKvCmwi+w+qcSK/OKuzTgkj7FU8r0X
	PS8e7lc5pwD54dgJRpeDmPjp
X-Google-Smtp-Source: AGHT+IGsLKBTasVAqEZ4v4KXBEfDfTM9A9ENdzksSzZ7BVLlJItKpXfKx4hZJPWcb6hfrOA5/IrXwYs5mVLZOS99Jts=
X-Received: by 2002:a17:903:238a:b0:28e:873d:91 with SMTP id
 d9443c01a7336-28e9a6563f0mr137927955ad.29.1759754471396; Mon, 06 Oct 2025
 05:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
In-Reply-To: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 18:11:00 +0530
X-Gm-Features: AS18NWASLNw80j6ptJPPHIfrc8HYOqH-1LzEniT9J7aBBeWXoMD5tLZ1N6aS2Wg
Message-ID: <CA+G9fYsTz6WTetGeWn=NX0fyX_j6qRR9XA_ETmJiYWDfCwyHWg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mmp_pdma: fix DMA mask handling
To: Guodong Xu <guodong@riscstar.com>
Cc: Vinod Koul <vkoul@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yixun Lan <dlan@gentoo.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, elder@riscstar.com, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 19:57, Guodong Xu <guodong@riscstar.com> wrote:
>
> The driver's existing logic for setting the DMA mask for "marvell,pdma-1.0"
> was flawed. It incorrectly relied on pdev->dev->coherent_dma_mask instead
> of declaring the hardware's fixed addressing capability. A cleaner and
> more correct approach is to define the mask directly based on the hardware
> limitations.
>
> The MMP/PXA PDMA controller is a 32-bit DMA engine. This is supported by
> datasheets and various dtsi files for PXA25x, PXA27x, PXA3xx, and MMP2,
> all of which are 32-bit systems.
>
> This patch simplifies the driver's logic by replacing the 'u64 dma_mask'
> field with a simpler 'u32 dma_width' to store the addressing capability
> in bits. The complex if/else block in probe() is then replaced with a
> single, clear call to dma_set_mask_and_coherent(). This sets a fixed
> 32-bit DMA mask for "marvell,pdma-1.0" and a 64-bit mask for
> "spacemit,k1-pdma," matching each device's hardware capabilities.
>
> Finally, this change also works around a specific build error encountered
> with clang-20 on x86_64 allyesconfig. The shift-count-overflow error is
> caused by a known clang compiler issue where the DMA_BIT_MASK(n) macro's
> ternary operator is not correctly evaluated in static initializers. By
> moving the macro's evaluation into the probe() function, the driver avoids
> this compiler bug.
>
> Fixes: 5cfe585d8624 ("dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/lkml/CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Patch applied on top of Linux next-20251003 tag and build test pass.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh

