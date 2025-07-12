Return-Path: <dmaengine+bounces-5767-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B8B02BF0
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBC21C24848
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11275275B12;
	Sat, 12 Jul 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VbuuhThp"
X-Original-To: dmaengine@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AA1990D8;
	Sat, 12 Jul 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752338145; cv=none; b=A0Zmen1wrUQvn9zazKWlZiLwGDIRMrQFQGzXawXIikx14VjRcUfjbBVrUV7TyG5SHQR6lBzOSRlRBYnE0stI95+bUNgLoXkzAXsf9Wi9t5SvDjv7azunEp+jOZKRVsWJcPVC1uOXCPbGPm64QCW22P4eAjRyAQFWLnWS+rGm+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752338145; c=relaxed/simple;
	bh=zShYQvLlzDshUKKlZg1x1TOtfC/ez1gpBFtv+Tsd8e8=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=t7zQu+6X4f5ByAPO0aWFD8SLFA6XsJDQobwHNUKzHeg6CnJP6S9UygL2HUSKIdm2IkH9aHzau9gnd4Zuf4ONVqOAl4i+QMVjj3vrZ3luImKsGNtOadjJnmcr9GzbwT+RWzUIlCFrICvU+J0nXMWiZc/8Od+eH7ayPjNtyX6b1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VbuuhThp; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752338134;
	bh=nr1V0epckhRFNIAskc+SB3bvY8ZpoSKvj9saTw6BZ8g=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=VbuuhThpEqaKfaB/Y0rgHlNn+7Q8uuuSMj0YFYV6DFmARpZPoWHqKH5jSJxFiqMcX
	 Ko1rjkmgJayCB4ps/yuJ+/Ta/BULd3hVJeDMwpK3c/MTS5R+qLvHAUkxRX9/JfiKAZ
	 QTAqCMuYXu+HcQ/jEhiVbfrJNYgfDgqYc+RiVlFs=
Received: from smtpclient.apple ([36.110.163.70])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 6CBA1414; Sun, 13 Jul 2025 00:27:11 +0800
X-QQ-mid: xmsmtpt1752337631t25gi2nz6
Message-ID: <tencent_46CEE34541085543C2F266B716704B068C05@qq.com>
X-QQ-XMAILINFO: N7yy7KMU5LaP6OLJ+d0WF7yjZUW9OFJDM5HxSH22N8d4ODGPatjOe+l6morWxM
	 A8K1fNpnsa1iOQRaNkdXi2l53UjHyS+3CRzptN9i80fuU640stP/k/Qcb2rgqKBDQC2A8dxWLEaZ
	 1P06O0lGvui51fEppNKcyIFKm6xlTXl+14W2vnbca25dVjkQPqXqHdd96UVoAtNFB/lr0YbueiCq
	 VqP0PiiSq0hTaSMaMlVN03vy4yfhGMr1OGmqp3QN7i0TROs7fy6sRQUq0+y3pJLZ+Uphq7BxMtjf
	 J3PdpTF2WPlKeAQUXoN3ressS4NJmBG7RCt9dMuqUoy7eT1TdvMio6zL0qKcGQy8zhRw9lfk5wL3
	 EYfyuF77B94LTTNSIR7WqtynbaEmFXF/VQVf8wKPFRPdtGsy7Irgw0EiuoLBhxL2jQQH2r5LzWOj
	 6yeKffvPUdrRIChB1RzyraESV+Ae4UDxcLOw2+ublKkkKMvAPRFXB1F/Bj/ezsf50xib9J9T75tL
	 fiFOQBFss+P2hNtqE22SPuPgEgqR05k+VCQ5Fba6b6m3liwT5wGdn3vGFX2FMItlXrnnru/WifaL
	 egZTQWYTZwoZnkTKCuUzCru6DOLrZgjaT/7TlL82jRIgKPGpRUkzUE2S9uWAuSxg40sS4crBhs93
	 lsh53Au96M+oeWxrqKxANbQxhZM4PJecQQh2VhnYsQsSMwGdR7xqP7+dT97KzsNqCZbnh/eTdCC9
	 x7OtamkPz2rj8RaCRgamzU6rUToOLUqm6gz92d5PkGZXuDixmFSyEj1iOYMmN4ZRnX6jncMIRAy7
	 R3uUvniuQPWOLJg/jFE9+Xd43ZlR0f31chtDOct6mOPZ6XYBdLUxmWSyQ+1L/sVZjFK++3XYaO+S
	 KDE9QxE51paCys/b5/v4K+rrKcA13nGmKJ6T7FJnQfyKVTHy7ugxTObjxbl6UJ3wuRiAMKYvFUnf
	 WX1frKYUIu9F9MRDAOPxmxzaNibVXOfyTyAwKaG+hDlUqLuaeCuFspMsbtYYmVfkQxHFHMxZMgIQ
	 IIQkYmew==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Date: Sun, 13 Jul 2025 00:27:01 +0800
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
X-OQ-MSGID: <8D37010A-D3D2-42C6-868B-35AAAB5885F6@foxmail.com>
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



