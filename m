Return-Path: <dmaengine+bounces-2694-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259AF930E63
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 09:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467941C21013
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2024 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43813B580;
	Mon, 15 Jul 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Mg0+ZpU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eotl3kMq"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACA4C9A;
	Mon, 15 Jul 2024 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721026843; cv=none; b=DqNEQ+7Z1g6aHeu2wc9+Fbg2xtzo6HVcvs9wKBFQuJMT5UbhWwYu3VZW9roTCFOQxMQX8hfiifWbw1+57bYxXgj3qw+sik05CChoMrbUGcJyi5NRk6X3duTGuv1EwDqr/uFEkXB87q3al5hRkTb3Jia7FtZhNacx0DPxvwY2TJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721026843; c=relaxed/simple;
	bh=l7GZ2gPkO34+k+8ASxE1jMvE5omSYiSss8FhtVBDznk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ni+NShZTxncv/5x6+vEdCLLONd3zK5D7fWlz7BLKZ0cAygrGE6Si/pBqbHKkOSSB0kuzf67EjQP3ZfDjpbncpheJbzH7RHskTfhkkLfuHgHomeyfd+0FbYlP5jt+duzABbHMv20hh/VFKrIC+moyVMWgFKhUuDeNtYqh4SMlUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Mg0+ZpU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eotl3kMq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id B91E81388DE7;
	Mon, 15 Jul 2024 03:00:40 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Mon, 15 Jul 2024 03:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721026840;
	 x=1721113240; bh=ChojkAX+i4Qp70UrJjFUh3pj/D7HmhsPYjxWPA6xENs=; b=
	Mg0+ZpU+JhwSwrzMx9FTztDKAjagitjtmrxJyoPGlN59gRkV+yj/f+1DtxxvmkO/
	kOq27EBOeMpf39DxNSg2frDGgUXuIdDk6/QescCj0ye72KIkFgZPHA4wF2PnL9xr
	tHNWQkaFlETLe5q0hHwGalKgVzOGJDoX10w49ADqPfFoe6UsvGwBIoOs7q6LZGaY
	2+TbmETr+6Aw5sPt4kAykNEuHPp99F4Vp3PuFhvZMDaatAhzu+ghKTcdwCpbk85W
	Blv7gfSPVydUj8+HAfes2zFnCi84xjQsisrBfpB5PEQPBs9ZHSXFwdBecT41WQtA
	nWqhBgH9M4pHePnE8puyvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721026840; x=
	1721113240; bh=ChojkAX+i4Qp70UrJjFUh3pj/D7HmhsPYjxWPA6xENs=; b=E
	otl3kMqPrINtQXWNeZw2CfTnC9AdnMtYl6bCIppW3TcXsPavLCHPw1UFly6L2uO6
	pWWl0NHvMTo9w/DWa47qsJ8/AVPPRZeShYgQSKMn3auV02zVbjwJRi+xVF0wopd5
	X28xtSQIZ4JiYgd2x8qtc4zhyTCgEiOatt4o6pc1Vu7AQoiSzKblEHbQKDK8MgIY
	ItlppRJk1i+CpxgFvPClblSYgJLoZCNOcYUjNeJXEj3h470LSMYSf6bDLEWapD6v
	Rm4r8vRv1mdEeXmfJs6WF0NrtyouoHEJjxnXeTHX651tIJ3CFOuZ/kmpbZTyQMBA
	fryR/Syqhvs6NcJqeVY2Q==
X-ME-Sender: <xms:F8mUZkLaNU50OWgTDILgxqexhY9psCLRioIa2AWFqL46ZaO-Rm1YCg>
    <xme:F8mUZkJW02dhT_vjmqUBU8iUJkjUTENwNk_KlWDeFKKF02kbjEDsH8VKCmnuUVFQC
    sETGXNPC-aJwUZ9KCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeekleevffehtdeigfekfefhffdtudffvdeuvedtffet
    heeuiefhgfetleekleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
    rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:F8mUZktes8w_960q2FNwzkMKFL1y6mywqv5VasrKfroTJ4oxgub0ag>
    <xmx:F8mUZhb0HYv5Yl_lALCiDiGXILCvmEFaugEELelLNfzeLhUc6EPmUw>
    <xmx:F8mUZrZ1mHmeGgkOC9iOgLE58IpvOQBOqlT0r1PFbPTjC3EueudPgA>
    <xmx:F8mUZtA-Wpiuybv0-Syzgfve1pw10VRmqjia_43i8tJtdjn2Qa0OnA>
    <xmx:GMmUZpClPRiwZC6jS_zN6BQoeZhkjOdiZ30vZrTPqUMVl0Go89xzy1mw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6998B36A0074; Mon, 15 Jul 2024 03:00:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1a53515-068a-4f70-87a9-44b77d02d1d5@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
 <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
 <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
 <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
Date: Mon, 15 Jul 2024 15:00:19 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@kernel.org>,
 "Kelvin Cheung" <keguang.zhang@gmail.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Conor Dooley" <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B47=E6=9C=8815=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=882:39=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
>> You said that you've accepted my suggestion, which means you recognize
>> 'loongson' as the better name for the drivers.
> No, I don't think so, this is just a compromise to keep consistency.

Folks, can we settle on this topic?

Is this naming really important? As long as people can read actual chip =
name from
kernel code & documents, I think both are acceptable.

I suggest let this patch go as is. And if anyone want to unify the namin=
g, they can
propose a treewide patch.

Otherwise, we are going nowhere.

Thanks
-  Jiaxun

>
>
>
> Huacai
>
>> Moreover, Loongson1 and Loongson2 belong to different SoC series.
>> To be honest, I can't see why Loongson1 APB DMA should give up this
>> intuitive and comprehensible naming.
>> Thanks for your review!
>> >
>> > Huacai
>> >
>> > On Thu, Jul 11, 2024 at 6:57=E2=80=AFPM Keguang Zhang via B4 Relay
>> > <devnull+keguang.zhang.gmail.com@kernel.org> wrote:
>> > >
>> > > Add the driver and dt-binding document for Loongson1 APB DMA.
>> > >
>> > > ---
>> > > Changes in v9:
>> > > - Fix all the errors and warnings when building with W=3D1 and C=3D1
>> > > - Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8=
-0-f9992d257250@gmail.com
>> > >
>> > > Changes in v8:
>> > > - Change 'interrupts' property to an items list
>> > > - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7=
-0-37db58608de5@gmail.com
>> > >
>> > > Changes in v7:
>> > > - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Hu=
acai Chen)
>> > > - Update the title and description part accordingly
>> > > - Rename the file to loongson,ls1b-apbdma.yaml
>> > > - Add a compatible string for LS1A
>> > > - Delete minItems of 'interrupts'
>> > > - Change patterns of 'interrupt-names' to const
>> > > - Rename the file to loongson1-apb-dma.c to keep the consistency
>> > > - Update Kconfig and Makefile accordingly
>> > > - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6=
-0-90de2c3cc928@gmail.com
>> > >
>> > > Changes in v6:
>> > > - Change the compatible to the fallback
>> > > - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
>> > > - as well as .device_pause and .device_resume.
>> > > - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
>> > > - into one page to save memory
>> > > - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
>> > > - Drop dma_slave_config structure
>> > > - Use .remove_new instead of .remove
>> > > - Use KBUILD_MODNAME for the driver name
>> > > - Improve the debug information
>> > > - Some minor fixes
>> > >
>> > > Changes in v5:
>> > > - Add the dt-binding document
>> > > - Add DT support
>> > > - Use DT information instead of platform data
>> > > - Use chan_id of struct dma_chan instead of own id
>> > > - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
>> > > - Update the author information to my official name
>> > >
>> > > Changes in v4:
>> > > - Use dma_slave_map to find the proper channel.
>> > > - Explicitly call devm_request_irq() and tasklet_kill().
>> > > - Fix namespace issue.
>> > > - Some minor fixes and cleanups.
>> > >
>> > > Changes in v3:
>> > > - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
>> > >
>> > > Changes in v2:
>> > > - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
>> > > - and rearrange it in alphabetical order in Kconfig and Makefile.
>> > > - Fix comment style.
>> > >
>> > > ---
>> > > Keguang Zhang (2):
>> > >       dt-bindings: dma: Add Loongson-1 APB DMA
>> > >       dmaengine: Loongson1: Add Loongson-1 APB DMA driver
>> > >
>> > >  .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
>> > >  drivers/dma/Kconfig                                |   9 +
>> > >  drivers/dma/Makefile                               |   1 +
>> > >  drivers/dma/loongson1-apb-dma.c                    | 665 +++++++=
++++++++++++++
>> > >  4 files changed, 742 insertions(+)
>> > > ---
>> > > base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
>> > > change-id: 20231120-loongson1-dma-163afe5708b9
>> > >
>> > > Best regards,
>> > > --
>> > > Keguang Zhang <keguang.zhang@gmail.com>
>> > >
>> > >
>> > >
>>
>>
>>
>> --
>> Best regards,
>>
>> Keguang Zhang

--=20
- Jiaxun

