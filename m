Return-Path: <dmaengine+bounces-5766-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0ABB02BE6
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE24163799
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D02857F9;
	Sat, 12 Jul 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LGHKUZYf"
X-Original-To: dmaengine@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FA278768;
	Sat, 12 Jul 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752337688; cv=none; b=gzd0CzT9t02qySCLGDd94VDOuAYCPOXIrgzyoEkYHSLEDqjCfz/nMHFiuGvT2mSufREjNjKIsQFaGKVcYgiPJViAMdQsjGkI2bC/1cW5wV6MRBrjl2NbjSadjQqkNh6GBOon/0WSYeEiIfynOV1cmBFF+KivPuIhw1nRa+c2L2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752337688; c=relaxed/simple;
	bh=zShYQvLlzDshUKKlZg1x1TOtfC/ez1gpBFtv+Tsd8e8=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=dZEfrvK2jL2VsYmlbsEm1ULPp+lG1xlarG0Xw3G7c8KbxALRPXWXJBm6XjqWhmiMJUdVVn2sNIPMNifMt8ZyV3zvyR4LvXOvM2acZWHzzgNVB8MB23D+ShUZKTsWUHx8Gnex54Ewo0kTiFHN+TwAIPyQVs8ZMG0IU0FXDXqNWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=LGHKUZYf; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752337674;
	bh=nr1V0epckhRFNIAskc+SB3bvY8ZpoSKvj9saTw6BZ8g=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=LGHKUZYfQD43gvXhxwpSfTEwjJkYQc2J1oPMS8Xosu6ev1BwUfsHQHnS5PQ1tvvOS
	 nKPBGlh3q+4ZTfbpFcbtO47d5vJLVyAEMyw3YTTLovmPhR9+PYiiX659m9fAdCrstj
	 nn9qoJzvg0CZgGoaGylBvbjlz0te/DOdLks3hTdY=
Received: from smtpclient.apple ([36.110.163.70])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 6F2020E8; Sun, 13 Jul 2025 00:27:50 +0800
X-QQ-mid: xmsmtpt1752337670tj4zzscnw
Message-ID: <tencent_F796C219AAAF44C38D59EDDB560958888706@qq.com>
X-QQ-XMAILINFO: NEGqkzgyFYqO0FYFVu/yc6yh9bWxl9ihuMmJtegKHU/BW9ZmNLaPdVeAToGmOK
	 dqJXy6Nj7d5li+9HIyqpCEtrgixybNtXEx5p/FiNWPUcD9aGduLYZRnbD0oMs396dt4a6Ve9p3C1
	 JeFxHpM9jcooNiXsWAI7PDELthYU2ujfGz84gMkL479PfJfw/wJveibHhyGZwPKVjh6hAwYW/23W
	 7W+Nnbyaj2ZYpQiXy0Mrrmt7bTH1PeGNe96N8eTC5TH2Zc1B3iSlnEeTowamKFkaxqqXeGefI8Fx
	 28dmMrn+gSbaaV9HBtC2ukFTRazCrFvJchCXEzMBlagBYOPBWGsLPHAEEA6a0E6NyiwskLlU1KGU
	 5P6+sT7GkfPlF0spB081Sdf+2AY5E68AXayfPyY+86A42Hal70GbkkPpn3/x5nsL8SHVkvo+E8vp
	 6BbGQSi6EQfwKaoKFc0YJ4qKbaby2i5eYkCFT6pdHkMbhj8+Xw0Yc+8aTJKjAPBRIqkbkHoIc8iG
	 K1YHNikEHKGkwMA3AYj7lSvZOzyW5ghApxVitA6EXlEJwtlElciAlUd4tmCQfhPQz834uYMu1l1J
	 C6KT7ZdbW32IZPjYn81KjMyhkkMnZgZBrAGTBYhl0oTe971tcw8T8Gp6ImiZMPsGiMcIVCmXZt6j
	 1EOh9tLivWU0P1bahLeEszKghy4XRpKPxM3PEKGHLKbUr6h7typAPMdXRyUdkDuf9gM7/iaEwz0x
	 IS7kuJROyIM/ZfMtFBlbVGSotrzLRxbQRzsuYwMNecXvPjeu+cwGZoWThCPjCiAFfca5gkYUeQhZ
	 kZ+rJ9mz6l/W9GxcUq8Sh+CAW/yNsYbqxTgDlrNoEL5ct+xM7qQuRFR6n9NaDjwUbZYyVXXXo2r7
	 W+gs3rN9iV13ZFYxIlmurKbdKj/u3w9s5LIfgQdgvNQIGQkgU2yXnjFOSnehQND9Spqb3ouSXVBa
	 tz8t1QR+C6Nksz/H0NIEswzUMgGWYAwC9ovz9k2wlQnnJu1MdhBwGElsgPxJzq3wCJR3dgcZ6EJt
	 YHAJPxa2beF18t163w3oQlrvVxc4UMdBp7vZqFPVAQQvFi0JHIXltlKum4fXDMXOUYfReQI89hmC
	 bAgnRF
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] dmaengine: rcar-dmac: Fix PM usage counter imbalance
From: Zhang Shurong <zhang_shurong@foxmail.com>
In-Reply-To: <CAMuHMdUhZqLCkLWtFTaCq67=Nb0O0_XLSWeyweMiNp25XArfKA@mail.gmail.com>
Date: Sun, 13 Jul 2025 00:27:39 +0800
Cc: vkoul@kernel.org,
 magnus.damm@gmail.com,
 robin.murphy@arm.com,
 ulf.hansson@linaro.org,
 kuninori.morimoto.gx@renesas.com,
 u.kleine-koenig@baylibre.com,
 dmaengine@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <2F2D2C10-F245-472B-A764-AFDA86F1AA66@foxmail.com>
References: <tencent_71CC9630D88A8792C2396A8844DCCD5C6D06@qq.com>
 <CAMuHMdUhZqLCkLWtFTaCq67=Nb0O0_XLSWeyweMiNp25XArfKA@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Geert,
Thank you for reviewing my patch and providing the Reviewed-by tag.=20
I appreciate you pointing this out. Testing these fixes comprehensively =
has been challenging=20
as QEMU doesn't support the Renesas R-Car SoC, which makes it difficult =
to verify the complete
behavior of the driver.
I'll continue working on addressing the memory leak issue where the =
function doesn't free previously
allocated memory on failure.
Thanks again for your thorough review.
Best regards,
Zhang Shurong

> On Jul 2, 2025, at 18:18, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>=20
> Hi Zhang,
>=20
> On Sun, 29 Jun 2025 at 17:57, Zhang Shurong =
<zhang_shurong@foxmail.com> wrote:
>> pm_runtime_get_sync will increment pm usage counter
>> even it failed. Forgetting to putting operation will
>> result in reference leak here. We fix it by replacing
>> it with pm_runtime_resume_and_get to keep usage counter
>> balanced.
>>=20
>> Fixes: 87244fe5abdf ("dmaengine: rcar-dmac: Add Renesas R-Car Gen2 =
DMA Controller (DMAC) driver")
>> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
>=20
> Thanks for your patch!
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
>> --- a/drivers/dma/sh/rcar-dmac.c
>> +++ b/drivers/dma/sh/rcar-dmac.c
>> @@ -1068,7 +1068,7 @@ static int =
rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
>>        if (ret < 0)
>>                return -ENOMEM;
>>=20
>> -       return pm_runtime_get_sync(chan->device->dev);
>> +       return pm_runtime_resume_and_get(chan->device->dev);
>=20
> Note that there are other issues with this function: in case of =
failure,
> none of the memory allocated before is freed.  Probably the original
> author assumed none of this can really fail.
>=20
>> }
>>=20
>> static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
>=20
> Gr{oetje,eeting}s,
>=20
>                        Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org
>=20
> In personal conversations with technical people, I call myself a =
hacker. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                -- Linus Torvalds



