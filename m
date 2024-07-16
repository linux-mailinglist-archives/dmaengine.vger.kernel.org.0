Return-Path: <dmaengine+bounces-2702-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3221932738
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF931C21967
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2024 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63919AD57;
	Tue, 16 Jul 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WBVwwIMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvlrSBVZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4B1448ED;
	Tue, 16 Jul 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135572; cv=none; b=ow8YNo8rSP5Jmo/r3qpwEDW3sBt9DT87I8g6UQ3pee0JTz4ZM5I5RlTGTEnLPofPYn4u0bWtGY9iRa3sJEQBaDD7o+aZ0FdItfKyMKVYrl8aO9Ze2RL/UWEeazywg/NlKTagcZq32NpCxU8ansXKVOsX/0n4zW5MNWarrDz+Swc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135572; c=relaxed/simple;
	bh=0pbFXYblsR3UKbqkbGTRgs8/Y3F6rLYSgnaif3v3QMM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=l8bxk1AUky3Ti0QeZB+2YuT4AGxjvj6lVDVJxxUVcdgMB+g4VyDULxF16kyUZBoFrVN7hVBR64S8YvYDya650WLwp/54Dnv/hm1bLm2DxYUa6HjRfdwnSTnC2zeZf9VykwRjGadIe82kKlara/D1Wl0NGkOUeXVr0k4DfOKk9lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=WBVwwIMD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvlrSBVZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BF6001148052;
	Tue, 16 Jul 2024 09:12:49 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 16 Jul 2024 09:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721135569;
	 x=1721221969; bh=0pbFXYblsR3UKbqkbGTRgs8/Y3F6rLYSgnaif3v3QMM=; b=
	WBVwwIMD8tfmGCPF0098lIEiTE+lQYK4hC0bV/URb6+ohG5p+AQ1eI4nY6BMPLKr
	ckk0uSHS+yLi44MBR1sCmmxGVqzhee59pJKePiHQ0wqo/3W1bjbFkqWulCPX4IfU
	AacUYIvfVmcQ2e376BxGYhkPTQ0wJw8hFJk4YyEqh00pH3sCVKoZEW4u9TTpqMCx
	gb4dgsUKDS9HAkHcvALJRjilyodm+P6WdcGSM+AsU4qGDc3aLcEvt8ubLOdRMQCr
	I3gOJhc+uIdWE3pfPCFmo9RPR+e1K7evdgxf0gJJBqtultJid0nw8KnIyJVzaSvH
	pdsLiR8sYWnm6/6IyTxGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721135569; x=
	1721221969; bh=0pbFXYblsR3UKbqkbGTRgs8/Y3F6rLYSgnaif3v3QMM=; b=F
	vlrSBVZIGhGDXGNDw5PI7qM4IJ15Ynh5BGogtppzPYkp6plzboubmx7niHEOQq6l
	jBcvzxCjQIbLIyDqwqBhYJB1+Y1tnrh6WYfaFVhoba3XnbDui8IPD0puOmz5etNt
	kF5BiMNmZ0EHrMIZziygj7fVaX71wlu39QrBZngFXhG9xvV5+mcO3+uuxb5kNi7r
	fPV+l0D0djsjum52q2rk906yQxJawKw1DGUqPLNCx6fKSXli2ThF/3+PYmWvqxrM
	QRvWEPVC/4I2Bqw/pa7EiXoJM9W1d3vukQiDTKD5RPVRI26qmzx4Qv7PkYxophvl
	VkvH5rz2PLO/Y9tQrktlA==
X-ME-Sender: <xms:0HGWZo4snpg3QYahBK24C7MCseiNHexn5Ke8SWQVcHfF3XErDenqng>
    <xme:0HGWZp6oPpbtTJX2PjsCUJI_-DCSh7ZRbKIyTOJ54I9gijXEXjN6g-uMopQDGDjvw
    HaxJKNpyVcgDg4LUG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:0HGWZncXNLHTnkXFVkCGAToKSPvwpH8A4nU_Ko6pdvGXwCFcq1hxCg>
    <xmx:0HGWZtJT2lhgG2fAGM9c5cw4mJL8IzJSXi7vvao2H2jTO0LFIq0hfw>
    <xmx:0HGWZsIgIJoPOkNzsM0-JHB2rXHRkT6dSibQIiXEoI32devFnUnpDg>
    <xmx:0HGWZuza2mzzUmnbay7_yAwVsKHTwoGUq7f4vO3ytYI3TJLIodpFog>
    <xmx:0XGWZqyAzUqnw-VT3wXadzDIeKiTs-UHlYFdLVZRBG9WMkW6eKOIOD5L>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7B5F736A0075; Tue, 16 Jul 2024 09:12:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <54d9edd5-377e-4d9a-956f-8f2ba49d4295@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H5cDiwAWBgXx8fBohZMocfup3rbe-XjDjEzsLAUB+1BUQ@mail.gmail.com>
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
 <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
 <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
 <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
 <b1a53515-068a-4f70-87a9-44b77d02d1d5@app.fastmail.com>
 <CAAhV-H5cDiwAWBgXx8fBohZMocfup3rbe-XjDjEzsLAUB+1BUQ@mail.gmail.com>
Date: Tue, 16 Jul 2024 21:10:07 +0800
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



=E5=9C=A82024=E5=B9=B47=E6=9C=8816=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=885:40=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Jul 15, 2024 at 3:00=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
>>
>>
>>
>> =E5=9C=A82024=E5=B9=B47=E6=9C=8815=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=882:39=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
>> [...]
>> >
>> >> You said that you've accepted my suggestion, which means you recog=
nize
>> >> 'loongson' as the better name for the drivers.
>> > No, I don't think so, this is just a compromise to keep consistency.
>>
>> Folks, can we settle on this topic?
>>
>> Is this naming really important? As long as people can read actual ch=
ip name from
>> kernel code & documents, I think both are acceptable.
>>
>> I suggest let this patch go as is. And if anyone want to unify the na=
ming, they can
>> propose a treewide patch.
> Renaming still breaks config files.

This is trival with treewide sed :-)

Thanks
- Jiaxun

--=20
- Jiaxun

