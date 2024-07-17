Return-Path: <dmaengine+bounces-2719-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565CA933E43
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E7C281F43
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD817FAC3;
	Wed, 17 Jul 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="R9BkCuK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qy7CO/Wf"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38F2D61B;
	Wed, 17 Jul 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226027; cv=none; b=kUONse85Stt/2WcX6TdKYadFSrjYNVGgWUpLvz7w6WsY7PYRzEgIHrhN8n4Gu5Nl/9VvYwWFqyCg7NeLjv5GsQsRM5oGq96K/ZL3n/QGP8niKiOGJb+Q2IFab3oMkbudyrLH4Ec7++PIjdesX2FRUKZaynViCU0aE0tEHimadp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226027; c=relaxed/simple;
	bh=5nbCBW4oJ/ogJooKQCfqvSA1sAQdk3JiwN9/HrQmGuI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=I6SZMQHxBC5p1Eooh8Pac5q9Cn5EqNKqBdDRK8KTd3dJu5C3fjz3yENxH8vhsk1k459GxFYtHhM/rYj05ww5h95OsixvCyDT5dztQFVoViA07/PeE01ZDw9cRdDPt5hd27soliEh5q8UyNhTtk0CBsRGXrmxwsGYts15p3KNuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=R9BkCuK+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qy7CO/Wf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D7749114010F;
	Wed, 17 Jul 2024 10:20:23 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 17 Jul 2024 10:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721226023;
	 x=1721312423; bh=5nbCBW4oJ/ogJooKQCfqvSA1sAQdk3JiwN9/HrQmGuI=; b=
	R9BkCuK+4L4Yhj3OD+PedvswLbb/7Zkt+bFvvGNfk723OwEUliYLbrfqEyM3fDV9
	N0W8+7CR4kwY7tv4VRh8FT5km9NZQ8LNGnSmj0PTUyv0yBsnTAN82OIsks7gtmZl
	cebaAVLHeeDZ8TAv+13S4HrbVelLCKN3OD5OHui4I2xJzpqhu+rlKUrORDvoHJKB
	hSUspxBvJAEidKIZpCCBgJOywHJqR145nO17Mt2GUIyTN69KY+WMDnFM0AMUHIMO
	IPXuWxsV/ziPkG8lUWrI8nHywgLKXu103xICKh0jiBmVIkQRkarZ6UWx+BnbcmY2
	4U2bflb/aiLUhig/vwWcTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226023; x=
	1721312423; bh=5nbCBW4oJ/ogJooKQCfqvSA1sAQdk3JiwN9/HrQmGuI=; b=q
	y7CO/WfBsjp4/g8CZYUK+FXGkHu7vtx3keyVj1U+OF9ykGcNjrzDmGnpqQ5SDUvD
	6jsm6Qhi2WxM0NoVO9SPsuOi1MDfV7Oq6GQNvHj7zOGb4lERi+SKffqObY7w+GEc
	j6NiWyer6h6nYIhoEwLgVXoIQePRYC53jgggoIB/7vm2S/J0553KyygiTN51Ieft
	dByOBG+nG5jCTvdJ6ZCJaYFVsoCrZEvJYJIAvmP67PKbn7FcBgvxYT5LSQv8uHUT
	VkP4b+bwOUC8Dai2HltIZMmbUjsMoKnhn4o+pB6C01T2D5rxnmY73rEYOcC7QBZa
	OTNz3UW8yOGQmN2bl106g==
X-ME-Sender: <xms:JtOXZvGoX87VSPXAZB-G1U7qMIFXP3yiPHdlFgTrybljkWFf__-5Ig>
    <xme:JtOXZsWQpdR0VcAhv3aq7_Ie3W1PzAI1xCzHQ0wGYUTpGBawRlizV1i4Sj4mjUuHY
    N6jGODhy7Y5e2tR4_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:JtOXZhL6i40ovn7u1_v48LVlJCc1R8m3r1TdQ4IyscPC42xGn2PUDA>
    <xmx:JtOXZtERwXDoFpjbCdvvfxcYUjTpo-UrL4IBco6jvJxyKwE4wqfuzw>
    <xmx:JtOXZlUgJl-dfCMOEb244sBAj3Ko4f7PMlmQTwbdx87IfXIT77VOyg>
    <xmx:JtOXZoO-iskq-pt_8s7U4VaYhavCWIwA6ifKthfHLOZ7fFXiKIrX5Q>
    <xmx:J9OXZgN4qfO0mRFpyA0wkax7bM-iybfVAFsadqQAxknCeSs0EUj6Z-DK>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8E52E36A0074; Wed, 17 Jul 2024 10:20:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <84d2591b-4336-453f-bcb2-a7c47df0574c@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H6aaAu=0eyEp8am8A+SSj53+CGp7DrCYCxkNZScBd74BQ@mail.gmail.com>
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
 <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
 <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
 <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
 <b1a53515-068a-4f70-87a9-44b77d02d1d5@app.fastmail.com>
 <CAAhV-H5cDiwAWBgXx8fBohZMocfup3rbe-XjDjEzsLAUB+1BUQ@mail.gmail.com>
 <54d9edd5-377e-4d9a-956f-8f2ba49d4295@app.fastmail.com>
 <CAAhV-H6aaAu=0eyEp8am8A+SSj53+CGp7DrCYCxkNZScBd74BQ@mail.gmail.com>
Date: Wed, 17 Jul 2024 22:20:01 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Kelvin Cheung" <keguang.zhang@gmail.com>,
 "Vinod Koul" <vkoul@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Conor Dooley" <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B47=E6=9C=8817=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=889:06=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Jul 16, 2024 at 9:12=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
>>
>>
>>
>> =E5=9C=A82024=E5=B9=B47=E6=9C=8816=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=885:40=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
>> > On Mon, Jul 15, 2024 at 3:00=E2=80=AFPM Jiaxun Yang <jiaxun.yang@fl=
ygoat.com> wrote:
>> >>
>> >>
>> >>
>> >> =E5=9C=A82024=E5=B9=B47=E6=9C=8815=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=
=8B=E5=8D=882:39=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
>> >> [...]
>> >> >
>> >> >> You said that you've accepted my suggestion, which means you re=
cognize
>> >> >> 'loongson' as the better name for the drivers.
>> >> > No, I don't think so, this is just a compromise to keep consiste=
ncy.
>> >>
>> >> Folks, can we settle on this topic?
>> >>
>> >> Is this naming really important? As long as people can read actual=
 chip name from
>> >> kernel code & documents, I think both are acceptable.
>> >>
>> >> I suggest let this patch go as is. And if anyone want to unify the=
 naming, they can
>> >> propose a treewide patch.
>> > Renaming still breaks config files.
>>
>> This is trival with treewide sed :-)
> Please read the commit message of b8d3349803ba34afda429e87a837fd95a ca=
refully.

We don't have 114 defconfigs don't we?

Those symbols are not frequently specified by down stream users either.

I think Keguang had tried his best on resolving all reasonable comments.

Naming is a matter of preference after all, I think we should give Kegua=
ng some respect
here.

Thanks
- Jiaxun

>
> Huacai
>
>>
>> Thanks
>> - Jiaxun
>>
>> --
>> - Jiaxun

--=20
- Jiaxun

