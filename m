Return-Path: <dmaengine+bounces-8705-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIqTBHvcgmnwdQMAu9opvQ
	(envelope-from <dmaengine+bounces-8705-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 06:43:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E694E20F3
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 06:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3745B30254D1
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FAE34CFC0;
	Wed,  4 Feb 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/i+m9VU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5183346B0
	for <dmaengine@vger.kernel.org>; Wed,  4 Feb 2026 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183800; cv=pass; b=D7WC0/vO8OI6DhfAPLDsN6GBLk1cn4GSFPoe944u9ErgaihvIx9P43Ft/JlkU0vPt9CqdI9auBjBw9QMVP/3hBItVl51NnqqPrls7NKYQ87IPKQIbRoR4ZWdrg3ofaDFMe/yjeHbJ7YDgmkqshlAnoTeXzMYo3eqTLuLg6oJA2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183800; c=relaxed/simple;
	bh=zPFVPmCmcOcYnQuEuH9JJtyahErTF7xD+xn4hX31KSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUjISmAfq427g+AT70lU2EaXYdy5FFv0CnOWG8163YvgUHWWg1SojyjaQg8Z+W8L/03dG4Y7HmC1oyK/MMskezK9LMDF7WwfYuMnmClVyaW2LxX+y+70135m5MOfM5HRThyzCChC51ImJcJN669dIpobcgENlAr2CF8FTLtdQ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/i+m9VU; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dd3e979ceso6700853e87.1
        for <dmaengine@vger.kernel.org>; Tue, 03 Feb 2026 21:43:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770183798; cv=none;
        d=google.com; s=arc-20240605;
        b=aOiB9z/vgXvKwjy/0dkncpgVDposrbd9Xp/jsYYzChwu+RcMM5Mfu/zSiH3L58SvVH
         TUHedlCfKnsZwrC4uvaZvg3PpBlwtrA/VJFDGq4XzgWrqKOmuhr2S+9yzFTlr18QoYry
         aEU7AUzeKKPe7E0qH6zQPhZ6RnzeYC6h/QIKXI+Axh8itXEdooQuM67Phvj3FRautNkY
         CWj/8AN8kyttbArSyLVx+RZ3RScpsttrJBMD+tDCA1kCoNknlrlFTwG7fWHnQX9I+xuX
         eHTyp2YbZIholbFx2bj97NoJmbOe9bTnpKyQQ4gGxcS+QqGA8TiP04auRXigEF4fMkFl
         zzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QSJi97R9hFG0MQsbDlpL5CHjh0FH6IDEFC8BDQFDq64=;
        fh=qaaPHMkwUdHw+DTl4Uo5jCO15jGVLr395CqBnyktkTE=;
        b=BK0edhWY7OVHGsyf92kDNF6Eh1nH60nl12Ib6ufHyLeQ5woYF6DEv5XSIRj1CAqE/d
         I3MGZI55IlXaIlMdycPRFyBeF+lIVyFUwVYICMe6Bku+cv2elAVpSNbpbaXt2jKs8FPf
         dxsL2ZN9fgv7QKu2lIO1BozbuaxDvzJ1fPEjB3ivgyb4fcq2ueK2pxFF5RiTlnb6lu3M
         6eC1/nyOVqF67GHe7Y1Q2MXMlALbpeVjac+JHCfn5Pwfv5HaAK9Z5IGh5JJg3y7aeeNi
         F5iaKxCmh4ZW3a+68667uHuqfMW4H2b6LgcizhZ7/JkQ1ce6UbDCRV4+zVZPQeym2OiA
         NK1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770183798; x=1770788598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSJi97R9hFG0MQsbDlpL5CHjh0FH6IDEFC8BDQFDq64=;
        b=m/i+m9VU3rc3QIdkMcVKorNem19t4O5BGjqbYiY33fkLRKN562q2Oai8/+aDYooWij
         VqQk53VtIbZLCq5OwhRWc2oERyxVmAsI6xmp7UUht/hOUszXpHtzWtSyDV1XZV533qMn
         tfrgscD/G3aAni/KDPzaLyihp3m+2mRPt735MZSn8VfktVW2knTbS9T4TMaiRDc1gAGt
         rjX/ICh0whgVN75RQz6lCcDDAslSRkqBzFEWWM6Jjcx3z+JoUHSJ1pPfInKYtGBq3E7e
         xemAZ1bdItDyD7vIsNWSp+HcLaNAdT5zRxsIILCNrBr9O0cQ/iPhTp9/jcny78yIrcq/
         jNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770183798; x=1770788598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QSJi97R9hFG0MQsbDlpL5CHjh0FH6IDEFC8BDQFDq64=;
        b=dtUcnlvc2tTQG0viqL56ZJora7yQV+gKiFuiWc5bcWPTzavsWamWySkSBFn6UcQXER
         ziFF37DeuoBnshAtQMCiMZXJYxgz1shnwhNq9b8G8AizjVO3/ejkdkdLTdqDZZz1fxF3
         4s59xlEi9MTcQLKWILi94xHZb9rYalnNrPKXhZKJD03VBWRtVXZNYRxMlTXzjPq63xfd
         HqdJOVDqbXly5db+YKbUEKN+Hwg1rrYUHUCcj8pZ5XD2R5zOB6MFG6hn6h8fHZQcTm+w
         4fLl+Ltm/ySBdTtRnjtoJwT6JCIE0srSBHj/cy8ovt1xafsJv9Nkz+0Zq+l3pOoENGcE
         QuIg==
X-Forwarded-Encrypted: i=1; AJvYcCVEzBSUGgEH1CLE5e/Lo2YI0hYKXS1MlCec88sI565OqVRTkhC1ggg2QpHgenB+faGC70b38CszRR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDCUaLIhXL+HAZlc1/jHMZTxEMgRsmWYZOdxkg7rDirHwBz43
	Mvjx1gyVFpCEPwJAlk3oL16CMMNiwhXxepOOB+3XB1r0mkUC0GlbnHRzqrDBIW9hmgT7gXMlGWJ
	k3NpQtqTY47bZp/Zkq38P+gsEVGuvmLzzumTmkutATw==
X-Gm-Gg: AZuq6aJr4NMAKiJc1HzHZ6OGo5eG04si2z7vodj9rI+pSTH1h+x4szKsvNL9iYSM9U1
	J22Cj05hWT+1GXF2PLBIYA4ZOv/Z8mAO2BMJQRcxf15D0FvCY+clfwPSVFczXDI/gyJ5sGWdod6
	LuUty3JUWH//xZ9uM+jh3NdpPGLSLuXCCB+Vi9NUrDmGXQ5To/5/s0+uzNUDBrfOHoRdNjRYtcN
	2M91/pLHhiNGRTzZAlD3Kq1QAXRxbQX9+OIm217PXrPpACf544zEKtXNqHucu1KBwQywuhvgOZF
	cc5BQHUcbJROpz6UijtmoEfkg80cgAOdCWcnUZ8L6m6WSwUzb1EBLlx1Y6W3RywJKF0j
X-Received: by 2002:a05:6512:340c:b0:59d:d551:8856 with SMTP id
 2adb3069b0e04-59e38c59155mr593281e87.48.1770183797626; Tue, 03 Feb 2026
 21:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770119693.git.zhoubinbin@loongson.cn> <d7a73d1fe8a3e4e57055a15a6ec03170f0d8ca21.1770119693.git.zhoubinbin@loongson.cn>
In-Reply-To: <d7a73d1fe8a3e4e57055a15a6ec03170f0d8ca21.1770119693.git.zhoubinbin@loongson.cn>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Wed, 4 Feb 2026 13:42:40 +0800
X-Gm-Features: AZwV_QhF-LvUnGZh1miRttDH8iCfO0e5TXYSBWWevas_BXwAX93FSFlLbvMfixs
Message-ID: <CAJhJPsVRZe_E6FsNBUa6K=GmPp3FXRrOH=yguvTY=K1cGwa62Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dmaengine: loongson: New directory for Loongson DMA
 controllers drivers
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	Xiaochuang Mao <maoxiaochuan@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8705-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keguangzhang@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E694E20F3
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 8:30=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Gather the Loongson DMA controllers under drivers/dma/loongson/
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                                   |  2 +-
>  drivers/dma/Kconfig                           | 25 ++---------------
>  drivers/dma/Makefile                          |  3 +-
>  drivers/dma/loongson/Kconfig                  | 28 +++++++++++++++++++
>  drivers/dma/loongson/Makefile                 |  3 ++
>  .../dma/{ =3D> loongson}/loongson1-apb-dma.c    |  4 +--
>  .../dma/{ =3D> loongson}/loongson2-apb-dma.c    |  4 +--
>  7 files changed, 39 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/dma/loongson/Kconfig
>  create mode 100644 drivers/dma/loongson/Makefile
>  rename drivers/dma/{ =3D> loongson}/loongson1-apb-dma.c (99%)

The file loongson1-apb-dma.c was moved to drivers/dma/loongson/,
but the MAINTAINERS entry still refers to the old path.

>  rename drivers/dma/{ =3D> loongson}/loongson2-apb-dma.c (99%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..66807104af63 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14776,7 +14776,7 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn>
>  L:     dmaengine@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> -F:     drivers/dma/loongson2-apb-dma.c
> +F:     drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
>  M:     Binbin Zhou <zhoubinbin@loongson.cn>
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
> index a54d7688392b..a1c73415b79f 100644
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
> @@ -88,6 +86,7 @@ obj-$(CONFIG_INTEL_LDMA) +=3D lgm/
>
>  obj-y +=3D amd/
>  obj-y +=3D mediatek/
> +obj-y +=3D loongson/
>  obj-y +=3D qcom/
>  obj-y +=3D stm32/
>  obj-y +=3D ti/
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> new file mode 100644
> index 000000000000..9dbdaef5a59f
> --- /dev/null
> +++ b/drivers/dma/loongson/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Loongson DMA controllers drivers
> +#
> +if MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
> +
> +config LOONGSON1_APB_DMA
> +       tristate "Loongson1 APB DMA support"
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +         This selects support for the APB DMA controller in Loongson1 So=
Cs,
> +         which is required by Loongson1 NAND and audio support.
> +
> +config LOONGSON2_APB_DMA
> +       tristate "Loongson2 APB DMA support"
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
> index 255fe7eca212..e99247cf90c1 100644
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
> index c528f02b9f84..0cb607595d04 100644
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
> 2.47.3
>


--=20
Best regards,

Keguang Zhang

