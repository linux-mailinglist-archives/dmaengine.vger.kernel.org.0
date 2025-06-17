Return-Path: <dmaengine+bounces-5512-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A993AADC7E2
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6966D7A0F47
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560E54BC6;
	Tue, 17 Jun 2025 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TncdHnXi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0C5383;
	Tue, 17 Jun 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155417; cv=none; b=qIFLfq+kcTUiDrfXTwfNzkOmuTbCiyxXwF+kZal4ocWnbbx8GPBDP8KucfbAcaYotnGPKKOL47qEqiwbURN9cgSoavmIwjrfvj9WHsAm1XGQ72jYSvJkBiI5yY3xDs2y3YhDxAeiX75HHen3wng4YyOP5sgylmYcS713nsPvVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155417; c=relaxed/simple;
	bh=DPlIYqTyyfH9zQ1OipNd3MPqtFULRjZNzvYW/rJl4WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nksPqh5Fi6ViwQS2wVPRvmXbPeCj+VfOEcSzTThIFlZ7h4SyzujaL7jN0UlaaVj4jfW9tSbiVfX7G/jhvfNS1N2aJX3/4qbmQzBhmKgz4FOFMV21jQ7PC8PQDNXMtyV0+NzZIqXnFTP9UD31OtXDfpur1jUDMzZj356REcS7PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TncdHnXi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade5a0442dfso1042454266b.1;
        Tue, 17 Jun 2025 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750155413; x=1750760213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1BQLCs3QVKPn1zOJEl7nzLsz+RyTRYHWzr3Kg/rsm8=;
        b=TncdHnXiykEEUZlFdT01+Pt1pajQqPbnrJiaqBrQNfvNy5L3lfKpP2akdhE6UoQ7FQ
         fvEYRd6baW8XiNXRw7Iy0e7Sjrk/9jeiFgeGPyXLFhKvaOf2pfOgj8Yz/Do0CoKpXlrW
         R7RJKhg0HaiGWItYbf5V0b67DIM1a7A4HlCGWqkxxLFoOTSIY7PlNRNf+8eIOj9eYY3/
         v+3O+NClyjsLV6PhUy/RkfNGs4u2bPvDPK5G7pvrDRtYMHaC/AMyTk1RbljIi7SKkwL8
         1DvS0GRUWkoGQFXkY9EIt/UHxxWdWq1PKS+NKEGGLpiDZFeabbamsKql+udlG90NbK7/
         /73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750155413; x=1750760213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1BQLCs3QVKPn1zOJEl7nzLsz+RyTRYHWzr3Kg/rsm8=;
        b=bkUAccmhG4hfylFnRBipIbpMvVpsQYsGb/OCWvf1a1Zyi0A3gpHlp+z4TUssxIII/N
         yluL+XsWje82GCbbGxFErIdP8eY2/+U4LXiWg4YN7CELcVNhaQypXT6qtPzzQlYWzBmX
         +uHEVuOZz0k0CATh6jRd2qwCHwHt2FDZzuwbO8TkYEso2fxMD5krs+HVKtsLIQJcM7UK
         UvlQd/EmA2a7e1L1dcmlpc+PsZKzBydhpa222ij0LY/r7Ty75ajR1H0KtTQIRoT823uZ
         gJ3TbANyNAY4C6xmEaZQt4FkGEzu9x1rHrl9Lw8k+Yg+WNn5UzRJnOX/5ZrUjSOSW/Eh
         3G/g==
X-Forwarded-Encrypted: i=1; AJvYcCUBAamDnkraeDAl2MzvDfxS/wbBM+VguR482VMSe4BsV9HMveTfsUItvBz/LSbPRbRBqNAFla3P3ao=@vger.kernel.org, AJvYcCXnyeZ983vpMb4C+SeSpn+j9eTG1mozf3JbNNtyU04Eff+pRaqK5zTp5oRdrHQpSUEESN+hb+3hZG7NHord@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tEKdnVfFEWYisJvffTk5f6lFhWhgeJs8VZmMO7gTG6/LDAsE
	3hrhlXPxTF7RCu4DyTgYgyBmSNjdelFKLlrPRN8OaVKYTiTbitJa1b9JWkkqXR19vhRwM+M0zMz
	Qd12UN2EXQWenh2mczrvVDI6HEcwnJEw=
X-Gm-Gg: ASbGncuZbToN03/jjw/djHdlDL5ueJ88YBNfdaURCYEcQ2IWpjkyIZDRGEQuP092/8i
	n4FuZR7n/wlDe221MY+KSRqI3yQNhlaExxURTzIBTools9WvvrxPiGU2doXA27sRepavZtx55if
	CcTcPkLytSqE2jbPGgYgdY1wGC1eHTGAuN1E0EHb1zug8=
X-Google-Smtp-Source: AGHT+IGZsQWICwckSP3b2A/yEqf6QAf/v1WHu0gLl/m8FVvwmEfrxdkna7L79TD896H1UvMJ3x7ofwFDoZFqRTZvsZ8=
X-Received: by 2002:a17:907:6e93:b0:adb:413e:2a2f with SMTP id
 a640c23a62f3a-adfad365283mr1103914966b.9.1750155412920; Tue, 17 Jun 2025
 03:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616124934.141782-3-al.kochet@gmail.com> <202506171615.p1kpBZuQ-lkp@intel.com>
In-Reply-To: <202506171615.p1kpBZuQ-lkp@intel.com>
From: Alexander Kochetkov <al.kochet@gmail.com>
Date: Tue, 17 Jun 2025 13:16:41 +0300
X-Gm-Features: AX0GCFuxsOFnF7ihDGQxogLna4LSxLetO5zCScp4jCArx8JNYI2Bkdgw2EP7hRc
Message-ID: <CAPUzuU1oqiOhKcV5e21rhjP_XcscGGLq9oZMvcK4DB_B2yZ7Jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma users
 on ARM64 platform
To: kernel test robot <lkp@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Nishad Saraf <nishads@amd.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Paul Cercueil <paul@crapouillou.net>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Longfang Liu <liulongfang@huawei.com>, Andy Shevchenko <andy@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One more question. I can translate all other dma drivers to BH
workqueue. I cannot test all of them, but I did this for sun6i and it
works as usual. Fix straightforward. Is it a good idea?

That happened because of this change and this driver doesn't compile on x64=
.
Any action from me? Should I send v3 without this change?

diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index ace75d7b835a..224436d3e50a 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config QCOM_ADM
        tristate "Qualcomm ADM support"
-       depends on (ARCH_QCOM || COMPILE_TEST) && !PHYS_ADDR_T_64BIT
+       depends on (ARCH_QCOM || COMPILE_TEST)
        select DMA_ENGINE
        select DMA_VIRTUAL_CHANNELS
        help

=D0=B2=D1=82, 17 =D0=B8=D1=8E=D0=BD. 2025=E2=80=AF=D0=B3. =D0=B2 12:31, ker=
nel test robot <lkp@intel.com>:

>
> Hi Alexander,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on vkoul-dmaengine/next]
> [also build test WARNING on shawnguo/for-next sunxi/sunxi/for-next lee-mf=
d/for-mfd-next linus/master v6.16-rc2 next-20250617]
> [cannot apply to atorgue-stm32/stm32-next lee-mfd/for-mfd-fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Kochetko=
v/dmaengine-virt-dma-convert-tasklet-to-BH-workqueue-for-callback-invocatio=
n/20250616-205118
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.g=
it next
> patch link:    https://lore.kernel.org/r/20250616124934.141782-3-al.koche=
t%40gmail.com
> patch subject: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma=
 users on ARM64 platform
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/2025=
0617/202506171615.p1kpBZuQ-lkp@intel.com/config)
> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df=
0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250617/202506171615.p1kpBZuQ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506171615.p1kpBZuQ-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/dma/qcom/qcom_adm.c:245:7: error: incompatible pointer types a=
ssigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsig=
ned long long *') [-Werror,-Wincompatible-pointer-types]
>      245 |                 src =3D &achan->slave.src_addr;
>          |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
>    drivers/dma/qcom/qcom_adm.c:251:7: error: incompatible pointer types a=
ssigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsig=
ned long long *') [-Werror,-Wincompatible-pointer-types]
>      251 |                 dst =3D &achan->slave.dst_addr;
>          |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
>    drivers/dma/qcom/qcom_adm.c:309:7: error: incompatible pointer types a=
ssigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsig=
ned long long *') [-Werror,-Wincompatible-pointer-types]
>      309 |                 src =3D &achan->slave.src_addr;
>          |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
>    drivers/dma/qcom/qcom_adm.c:313:7: error: incompatible pointer types a=
ssigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsig=
ned long long *') [-Werror,-Wincompatible-pointer-types]
>      313 |                 dst =3D &achan->slave.dst_addr;
>          |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/dma/qcom/qcom_adm.c:848:59: warning: implicit conversion from =
'unsigned long' to 'unsigned int' changes value from 18446744072371568648 t=
o 2956984328 [-Wconstant-conversion]
>      848 |         writel(ADM_CI_RANGE_START(0x40) | ADM_CI_RANGE_END(0xb=
0) |
>          |         ~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~^
>      849 |                ADM_CI_BURST_8_WORDS, adev->regs + ADM_CI_CONF(=
0));
>          |                ~~~~~~~~~~~~~~~~~~~~
>    1 warning and 4 errors generated.
>
>
> vim +848 drivers/dma/qcom/qcom_adm.c
>
> 03de6b273805b3 Arnd Bergmann     2021-11-22  745
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  746  static int adm_dma_prob=
e(struct platform_device *pdev)
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  747  {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  748        struct adm_device=
 *adev;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  749        int ret;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  750        u32 i;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  751
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  752        adev =3D devm_kza=
lloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  753        if (!adev)
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  754                return -E=
NOMEM;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  755
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  756        adev->dev =3D &pd=
ev->dev;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  757
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  758        adev->regs =3D de=
vm_platform_ioremap_resource(pdev, 0);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  759        if (IS_ERR(adev->=
regs))
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  760                return PT=
R_ERR(adev->regs);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  761
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  762        adev->irq =3D pla=
tform_get_irq(pdev, 0);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  763        if (adev->irq < 0=
)
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  764                return ad=
ev->irq;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  765
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  766        ret =3D of_proper=
ty_read_u32(pdev->dev.of_node, "qcom,ee", &adev->ee);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  767        if (ret) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  768                dev_err(a=
dev->dev, "Execution environment unspecified\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  769                return re=
t;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  770        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  771
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  772        adev->core_clk =
=3D devm_clk_get(adev->dev, "core");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  773        if (IS_ERR(adev->=
core_clk))
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  774                return PT=
R_ERR(adev->core_clk);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  775
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  776        adev->iface_clk =
=3D devm_clk_get(adev->dev, "iface");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  777        if (IS_ERR(adev->=
iface_clk))
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  778                return PT=
R_ERR(adev->iface_clk);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  779
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  780        adev->clk_reset =
=3D devm_reset_control_get_exclusive(&pdev->dev, "clk");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  781        if (IS_ERR(adev->=
clk_reset)) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  782                dev_err(a=
dev->dev, "failed to get ADM0 reset\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  783                return PT=
R_ERR(adev->clk_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  784        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  785
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  786        adev->c0_reset =
=3D devm_reset_control_get_exclusive(&pdev->dev, "c0");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  787        if (IS_ERR(adev->=
c0_reset)) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  788                dev_err(a=
dev->dev, "failed to get ADM0 C0 reset\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  789                return PT=
R_ERR(adev->c0_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  790        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  791
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  792        adev->c1_reset =
=3D devm_reset_control_get_exclusive(&pdev->dev, "c1");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  793        if (IS_ERR(adev->=
c1_reset)) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  794                dev_err(a=
dev->dev, "failed to get ADM0 C1 reset\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  795                return PT=
R_ERR(adev->c1_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  796        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  797
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  798        adev->c2_reset =
=3D devm_reset_control_get_exclusive(&pdev->dev, "c2");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  799        if (IS_ERR(adev->=
c2_reset)) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  800                dev_err(a=
dev->dev, "failed to get ADM0 C2 reset\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  801                return PT=
R_ERR(adev->c2_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  802        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  803
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  804        ret =3D clk_prepa=
re_enable(adev->core_clk);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  805        if (ret) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  806                dev_err(a=
dev->dev, "failed to prepare/enable core clock\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  807                return re=
t;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  808        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  809
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  810        ret =3D clk_prepa=
re_enable(adev->iface_clk);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  811        if (ret) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  812                dev_err(a=
dev->dev, "failed to prepare/enable iface clock\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  813                goto err_=
disable_core_clk;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  814        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  815
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  816        reset_control_ass=
ert(adev->clk_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  817        reset_control_ass=
ert(adev->c0_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  818        reset_control_ass=
ert(adev->c1_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  819        reset_control_ass=
ert(adev->c2_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  820
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  821        udelay(2);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  822
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  823        reset_control_dea=
ssert(adev->clk_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  824        reset_control_dea=
ssert(adev->c0_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  825        reset_control_dea=
ssert(adev->c1_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  826        reset_control_dea=
ssert(adev->c2_reset);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  827
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  828        adev->channels =
=3D devm_kcalloc(adev->dev, ADM_MAX_CHANNELS,
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  829                         =
             sizeof(*adev->channels), GFP_KERNEL);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  830
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  831        if (!adev->channe=
ls) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  832                ret =3D -=
ENOMEM;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  833                goto err_=
disable_clks;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  834        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  835
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  836        /* allocate and i=
nitialize channels */
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  837        INIT_LIST_HEAD(&a=
dev->common.channels);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  838
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  839        for (i =3D 0; i <=
 ADM_MAX_CHANNELS; i++)
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  840                adm_chann=
el_init(adev, &adev->channels[i], i);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  841
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  842        /* reset CRCIs */
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  843        for (i =3D 0; i <=
 16; i++)
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  844                writel(AD=
M_CRCI_CTL_RST, adev->regs +
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  845                        A=
DM_CRCI_CTL(i, adev->ee));
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  846
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  847        /* configure clie=
nt interfaces */
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14 @848        writel(ADM_CI_RAN=
GE_START(0x40) | ADM_CI_RANGE_END(0xb0) |
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  849               ADM_CI_BUR=
ST_8_WORDS, adev->regs + ADM_CI_CONF(0));
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  850        writel(ADM_CI_RAN=
GE_START(0x2a) | ADM_CI_RANGE_END(0x2c) |
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  851               ADM_CI_BUR=
ST_8_WORDS, adev->regs + ADM_CI_CONF(1));
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  852        writel(ADM_CI_RAN=
GE_START(0x12) | ADM_CI_RANGE_END(0x28) |
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  853               ADM_CI_BUR=
ST_8_WORDS, adev->regs + ADM_CI_CONF(2));
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  854        writel(ADM_GP_CTL=
_LP_EN | ADM_GP_CTL_LP_CNT(0xf),
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  855               adev->regs=
 + ADM_GP_CTL);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  856
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  857        ret =3D devm_requ=
est_irq(adev->dev, adev->irq, adm_dma_irq,
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  858                         =
      0, "adm_dma", adev);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  859        if (ret)
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  860                goto err_=
disable_clks;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  861
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  862        platform_set_drvd=
ata(pdev, adev);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  863
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  864        adev->common.dev =
=3D adev->dev;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  865        adev->common.dev-=
>dma_parms =3D &adev->dma_parms;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  866
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  867        /* set capabiliti=
es */
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  868        dma_cap_zero(adev=
->common.cap_mask);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  869        dma_cap_set(DMA_S=
LAVE, adev->common.cap_mask);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  870        dma_cap_set(DMA_P=
RIVATE, adev->common.cap_mask);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  871
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  872        /* initialize dma=
engine apis */
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  873        adev->common.dire=
ctions =3D BIT(DMA_DEV_TO_MEM | DMA_MEM_TO_DEV);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  874        adev->common.resi=
due_granularity =3D DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  875        adev->common.src_=
addr_widths =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  876        adev->common.dst_=
addr_widths =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  877        adev->common.devi=
ce_free_chan_resources =3D adm_free_chan;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  878        adev->common.devi=
ce_prep_slave_sg =3D adm_prep_slave_sg;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  879        adev->common.devi=
ce_issue_pending =3D adm_issue_pending;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  880        adev->common.devi=
ce_tx_status =3D adm_tx_status;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  881        adev->common.devi=
ce_terminate_all =3D adm_terminate_all;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  882        adev->common.devi=
ce_config =3D adm_slave_config;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  883
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  884        ret =3D dma_async=
_device_register(&adev->common);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  885        if (ret) {
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  886                dev_err(a=
dev->dev, "failed to register dma async device\n");
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  887                goto err_=
disable_clks;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  888        }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  889
> 03de6b273805b3 Arnd Bergmann     2021-11-22  890        ret =3D of_dma_co=
ntroller_register(pdev->dev.of_node, adm_dma_xlate,
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  891                         =
                &adev->common);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  892        if (ret)
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  893                goto err_=
unregister_dma;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  894
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  895        return 0;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  896
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  897  err_unregister_dma:
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  898        dma_async_device_=
unregister(&adev->common);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  899  err_disable_clks:
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  900        clk_disable_unpre=
pare(adev->iface_clk);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  901  err_disable_core_clk:
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  902        clk_disable_unpre=
pare(adev->core_clk);
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  903
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  904        return ret;
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  905  }
> 5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  906
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

