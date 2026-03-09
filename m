Return-Path: <dmaengine+bounces-9323-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD3YMWZVrmlACQIAu9opvQ
	(envelope-from <dmaengine+bounces-9323-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 06:06:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24622233D8F
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 06:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D580300C900
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 05:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD12D592F;
	Mon,  9 Mar 2026 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1y7a2Hs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A51D5141
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032798; cv=pass; b=RnryJaYffAnVgyp1CftQLh/4dRmp217zAgicAwmfvfz7X7xtGWWgV6KV0CfnSWBFA4LNEULYKs2NIs4VB3JtzcFT4vLmM80jKNZsBOXu0E0TrEgxS9VT8zdunF7/oEjYRVMAG7kXInOMWHmsUT9KY30314TJONvaD1zJS0E0cyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032798; c=relaxed/simple;
	bh=GIMVmStjtbmmcCRCeCm9myZpzjRNN8wQyjoVN50bJm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK3wypa9DSLpWXD38sDoDsbbCYC0AGkazS7B6/VwNZhySVAYycVe9S9xMtQOFGiTy/X6oUdhTDrM2nKMzBqNX0IqPVCs+5jU8k6WJN0NyrPHKskhSGQo9o8onar1eirdruTBVEq2FnxyTYl/98mmS5vbbJcLic1RB5vVpuZfueQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1y7a2Hs; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so5599392e87.0
        for <dmaengine@vger.kernel.org>; Sun, 08 Mar 2026 22:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773032795; cv=none;
        d=google.com; s=arc-20240605;
        b=B7D9m7B/IhQqYfDqg7xip6dduiH+jLJVOQscT5DZg+f45Wx3AjnO4MzY/0POASznoh
         Ch9xjmYpXD/heHdAGTuWnGzFEHi6cOfZBuqJUxaRHMsVSoPen6ad5oCOjWyoJLZEtI00
         lX9SAqtk/M1XpcBA6ROGV6ghPu+hdXUn6H2Q2Jv+o7glzoU7BmTa6DNKcScy2LQD/rgs
         AqJvFgEnkuB9yBKuuFIl+5sAlwzsl2vywHqW5mFu/AfGpZbRhflB4TapNIaSLPQdlwmB
         K7sc/YqbGY/+yBw7ReP5N3MZe13UEDHsF5Si+H56j7Nk3xVYFMVD8tG9WxUJScyUbJtq
         N6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xRboZoSgRCmPY0VANyUKksmp/XjUE2Df8hgoiGF3Klk=;
        fh=TFpt27YwGRgwaNExZ0gLdYzpsnI7kDyYQSrrXjPnyP8=;
        b=SVHjBu3TAqUSAZny+oZaMYnFv8nSNsRANk+9Rl+pUmplIDDhPnHYVJVU4qwC9kCnad
         JJUqSeLt9Z0w4PfKIYk6RfV/cKbx22C8yIgRf0+b88n91CVR80//7EaqftbxyuRSZ9Zr
         kVmQngzD6RCcwZZCc9DxMYhW6SQS1yL7u8mGswkMRgtmDeAZKywDo4O6rhSVFesaeKX7
         5Kek0yxX+rv3ehT3Ynw5v+hLU1964pHMElph8xchWn2fquGfWo0/M+CdUL0iVLrfuz6H
         j8PPMrqbPfsiSQvYBl5nMdI7VmuRQ/4vw8+XVXZl2HOrxCK+sbpvKUBNNnfjNA4a+cUs
         T4ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773032795; x=1773637595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRboZoSgRCmPY0VANyUKksmp/XjUE2Df8hgoiGF3Klk=;
        b=b1y7a2Hsa1KkI7txeKuKdTPng+8q3L3H17zIsZ8bFM55IDfpeT511QdKV0H7wCoaja
         IDS8pfvfAdStlZSRD9VPZYIT+LmgA34zCIMvI+oSsc0+jfXv04BRUvfGlYV5uuxXs9CD
         0oYyX1q/8YKqPNQ0xVzqLQtjqCx+8dW161K77/Ez8f9JjkfGmsKnyn2I5cRlM/vXhkPc
         R45CyH+NQfZnssDItafgjz/Zv/btvt1vy5K+B0tKoa8mY+V5oqLMxZzcUb7nywuozfJT
         lcqSuJCdTKHGz65SLlDzV5V+K353oqFacdJjo1zAcblQOXDgOx+ixJ/VTcFTkf2aDXeG
         Yo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773032795; x=1773637595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRboZoSgRCmPY0VANyUKksmp/XjUE2Df8hgoiGF3Klk=;
        b=pla3P+bDTTCj1Eb9Kh9+2Uc1UctSA9ImcASsKi8EGWgLr4NZdadqgsoIb294qaUgvP
         6tN0Rl2DEaAN6cFjlic89y5Nilg91hJQaF49FrqX2B7y16QDdsApPJf6PJVAAMFeWlNv
         LKQxTrDQvSYos1MoXM1oJiSvYtnsfPaBbcc+ZH75nbk41XL+XzTWcnxNaM7dffSJc6WH
         RrbOgFb4bNG7I+/fo5hm1Ut8jrvft6JlN2DlEhAP7gwsxkKSTT7UESGQzdKdkU7/KbJw
         Wy/P1YX793MKBx4wPSDKNYxyd1mhKuyQAeCRHgCL4AjcqinMft2ueT8LzaqH0vVGnsC3
         EGnw==
X-Forwarded-Encrypted: i=1; AJvYcCXjtVSYPPY3p+YpahRkwuFukpGSFQNP0s7UpKjV+cGPsnvqtLy+JAAII/5FrTYMO48Y+kzR9Ie+p1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdpt9bnLeiPd2mIq5EKGjrpbgPnrBtT3zyteSrKpQdD7PgiDBR
	hz7GBitNhktM+g8ax0sRaf+AnDMT3qMFnhCpV5kVQu375DH9T/TL+Ffo7m7fJ2U3IQTD0rGdDIX
	DdnUz6K1lKuPb6F3OFg/WXz23bKZ3XII=
X-Gm-Gg: ATEYQzx/OhcuAV0Wuz4WOw8y5QPqf4fTa4TEYPuJLmOXpEhQrXp3sAayjPDZF4KudTM
	go+4qXY/RLqcmSv2elHU7M/0yzPyACNds+HUcwUSqMP7u/WV/jt7P1rNdALAklpA8x4CfAskt4z
	9ChI2C5MtvujEupBG4/poBZzPAjJP0OPvsqQyslOdZ5mcdTC8Bm8dbdYUqD6jRYjcmxeSkD7ZEi
	B/DRgElJ2uc0Mx71OqU4jq9BHIn/PWVSeJdWzv3Y7ejaMlzpQpD5EZibwx/1wEy86F4vUZpRZ5t
	9/UH9ogtAEa8XbR9ze89IX+UnYVnt+tqOto4QjToT+DtXFzW+TFr8bXeNV/jI1t+vE3oe9Zd/uU
	mIpBs
X-Received: by 2002:ac2:5bc4:0:b0:5a1:34a3:757f with SMTP id
 2adb3069b0e04-5a13ccf2956mr2349267e87.25.1773032794332; Sun, 08 Mar 2026
 22:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772853681.git.zhoubinbin@loongson.cn> <0a0853a85630724741061f6fe08680610e49a06e.1772853681.git.zhoubinbin@loongson.cn>
In-Reply-To: <0a0853a85630724741061f6fe08680610e49a06e.1772853681.git.zhoubinbin@loongson.cn>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 9 Mar 2026 13:05:57 +0800
X-Gm-Features: AaiRm51GSn_HaYCy7NTYWTwsmJ10yQbxHNd2i-pSCRpSalZ_FyuzjKsqLsqZXP4
Message-ID: <CAJhJPsWB8ma0Lfu=h=LZw2RkWX2wTV-S5q0BzJ0XLFdsgkfM8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dmaengine: loongson: New directory for Loongson
 DMA controllers drivers
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 24622233D8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9323-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keguangzhang@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,loongson.cn:email]
X-Rspamd-Action: no action

Reviewed-by: Keguang Zhang <keguang.zhang@gmail.com>

On Sat, Mar 7, 2026 at 11:25=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Gather the Loongson DMA controllers under drivers/dma/loongson/
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                                   |  3 +-
>  drivers/dma/Kconfig                           | 25 ++--------------
>  drivers/dma/Makefile                          |  3 +-
>  drivers/dma/loongson/Kconfig                  | 30 +++++++++++++++++++
>  drivers/dma/loongson/Makefile                 |  3 ++
>  .../dma/{ =3D> loongson}/loongson1-apb-dma.c    |  4 +--
>  .../dma/{ =3D> loongson}/loongson2-apb-dma.c    |  4 +--
>  7 files changed, 42 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/dma/loongson/Kconfig
>  create mode 100644 drivers/dma/loongson/Makefile
>  rename drivers/dma/{ =3D> loongson}/loongson1-apb-dma.c (99%)
>  rename drivers/dma/{ =3D> loongson}/loongson2-apb-dma.c (99%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..e8cd1e2dac13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14953,7 +14953,7 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn>
>  L:     dmaengine@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> -F:     drivers/dma/loongson2-apb-dma.c
> +F:     drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
>  M:     Binbin Zhou <zhoubinbin@loongson.cn>
> @@ -17721,6 +17721,7 @@ F:      arch/mips/boot/dts/loongson/loongson1*
>  F:     arch/mips/configs/loongson1_defconfig
>  F:     arch/mips/loongson32/
>  F:     drivers/*/*loongson1*
> +F:     drivers/dma/loongson/loongson1-apb-dma.c
>  F:     drivers/mtd/nand/raw/loongson-nand-controller.c
>  F:     drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>  F:     sound/soc/loongson/loongson1_ac97.c
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 66cda7cc9f7a..1b84c5b11654 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -376,29 +376,6 @@ config K3_DMA
>           Support the DMA engine for Hisilicon K3 platform
>           devices.
>
> -config LOONGSON1_APB_DMA
> -       tristate "Loongson1 APB DMA support"
> -       depends on MACH_LOONGSON32 || COMPILE_TEST
> -       select DMA_ENGINE
> -       select DMA_VIRTUAL_CHANNELS
> -       help
> -         This selects support for the APB DMA controller in Loongson1 So=
Cs,
> -         which is required by Loongson1 NAND and audio support.
> -
> -config LOONGSON2_APB_DMA
> -       tristate "Loongson2 APB DMA support"
> -       depends on LOONGARCH || COMPILE_TEST
> -       select DMA_ENGINE
> -       select DMA_VIRTUAL_CHANNELS
> -       help
> -         Support for the Loongson2 APB DMA controller driver. The
> -         DMA controller is having single DMA channel which can be
> -         configured for different peripherals like audio, nand, sdio
> -         etc which is in APB bus.
> -
> -         This DMA controller transfers data from memory to peripheral fi=
fo.
> -         It does not support memory to memory data transfer.
> -
>  config LPC18XX_DMAMUX
>         bool "NXP LPC18xx/43xx DMA MUX for PL080"
>         depends on ARCH_LPC18XX || COMPILE_TEST
> @@ -774,6 +751,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
>
>  source "drivers/dma/lgm/Kconfig"
>
> +source "drivers/dma/loongson/Kconfig"
> +
>  source "drivers/dma/stm32/Kconfig"
>
>  # clients
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..963b10494ee5 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -49,8 +49,6 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma64.o
>  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
>  obj-y +=3D idxd/
>  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
> -obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> -obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
>  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
>  obj-$(CONFIG_LPC32XX_DMAMUX) +=3D lpc32xx-dmamux.o
>  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> @@ -87,6 +85,7 @@ obj-$(CONFIG_FSL_DPAA2_QDMA) +=3D fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) +=3D lgm/
>
>  obj-y +=3D amd/
> +obj-y +=3D loongson/
>  obj-y +=3D mediatek/
>  obj-y +=3D qcom/
>  obj-y +=3D stm32/
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> new file mode 100644
> index 000000000000..0a865a8fd3a6
> --- /dev/null
> +++ b/drivers/dma/loongson/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Loongson DMA controllers drivers
> +#
> +if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
> +
> +config LOONGSON1_APB_DMA
> +       tristate "Loongson1 APB DMA support"
> +       depends on MACH_LOONGSON32 || COMPILE_TEST
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +         This selects support for the APB DMA controller in Loongson1 So=
Cs,
> +         which is required by Loongson1 NAND and audio support.
> +
> +config LOONGSON2_APB_DMA
> +       tristate "Loongson2 APB DMA support"
> +       depends on MACH_LOONGSON64 || COMPILE_TEST
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +         Support for the Loongson2 APB DMA controller driver. The
> +         DMA controller is having single DMA channel which can be
> +         configured for different peripherals like audio, nand, sdio
> +         etc which is in APB bus.
> +
> +         This DMA controller transfers data from memory to peripheral fi=
fo.
> +         It does not support memory to memory data transfer.
> +
> +endif
> diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefil=
e
> new file mode 100644
> index 000000000000..6cdd08065e92
> --- /dev/null
> +++ b/drivers/dma/loongson/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> +obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson/loong=
son1-apb-dma.c
> similarity index 99%
> rename from drivers/dma/loongson1-apb-dma.c
> rename to drivers/dma/loongson/loongson1-apb-dma.c
> index 2e347aba9af8..89786cbd20ab 100644
> --- a/drivers/dma/loongson1-apb-dma.c
> +++ b/drivers/dma/loongson/loongson1-apb-dma.c
> @@ -16,8 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "dmaengine.h"
> -#include "virt-dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
>
>  /* Loongson-1 DMA Control Register */
>  #define LS1X_DMA_CTRL          0x0
> diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson/loong=
son2-apb-dma.c
> similarity index 99%
> rename from drivers/dma/loongson2-apb-dma.c
> rename to drivers/dma/loongson/loongson2-apb-dma.c
> index b981475e6779..fc7d9f4a96ec 100644
> --- a/drivers/dma/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -17,8 +17,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "dmaengine.h"
> -#include "virt-dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
>
>  /* Global Configuration Register */
>  #define LDMA_ORDER_ERG         0x0
> --
> 2.52.0
>


--=20
Best regards,

Keguang Zhang

