Return-Path: <dmaengine+bounces-3561-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6979AF47E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 23:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8651F224BA
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0721832A;
	Thu, 24 Oct 2024 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="JvCI2bpf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C862178E9;
	Thu, 24 Oct 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804341; cv=none; b=NEzwkx2PCM7PmjcwXpipaKAsF2AMXLCCFacgKSWbJ2JBA+KC2Af/0n+ZpYjlFBzH0TVwuNvBXTH9bEqVSG4CAfgpFFXZVEcpZ2ofL2Y3P8J9yqlVWQR5zz7FZcH1Hm6KyQ8LCkulDwxZt21/CdAsS3REHMBJhxY/ElGK9T4TrJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804341; c=relaxed/simple;
	bh=YFSCR7IfY9tTJHnomR8IWpjA3ksgmVsEmuV7YWqhDac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAz074Jej2xpDozq+lxHweZgbI/KAwMmgJ7+9U1eeZdBLDu8ICdqG2b65PEs2nqNFcH40vxrbCg/I1XX/pAaFG5OMjesHHaUn7qTjsD5GdHhjucjCZ6fNeDgC9pshnAnS5ijijDsVy6ZLcFlA4v4O+2sVTRxeeSwEEmSvyleSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=JvCI2bpf; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 7D26B1CE86E68;
	Fri, 25 Oct 2024 00:01:25 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9oq4DAnOWm9h; Fri, 25 Oct 2024 00:01:25 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 291291CEA7786;
	Fri, 25 Oct 2024 00:01:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 291291CEA7786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1729803685;
	bh=YFSCR7IfY9tTJHnomR8IWpjA3ksgmVsEmuV7YWqhDac=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=JvCI2bpfYn6dddRZiFpXBEzWeMaIIIutw82nrEpFKELoHPE6QGlusc8ot6Pz2qsRl
	 xgHZlg0ZN4qSjNTvX61QWUAB7GUVXTPMjDh1akMWR7Bv4mMuo14u26B5xrIwAhP7XR
	 Zhx7eK353znte05A8c+mxDcOLCydBtTG2ls2w5c9/Mo4C87hbpDNzyXbRsAchC7Ks5
	 XLwSg/4N1t2FVpz/nBcGXLz3qFrQp8PdasmrTypM0817oCh9kImIJI7nLBMD++8mIh
	 k/jBTljV5jxoD21CpoJ1X8V5EyMSn2YqMYMoH55SN7eGLDRMqD3tW7zwRTBXHwT4Xf
	 C3mBvJUzpSmNA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DcLkSC7j36Ww; Fri, 25 Oct 2024 00:01:25 +0300 (MSK)
Received: from hp-xfce (unknown [89.189.111.209])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 21D671CE86E68;
	Fri, 25 Oct 2024 00:01:24 +0300 (MSK)
Received: from localhost (hp-xfce [local])
	by hp-xfce (OpenSMTPD) with ESMTPA id eeebd703;
	Thu, 24 Oct 2024 21:01:23 +0000 (UTC)
From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	patches@lists.linux.dev,
	peter@typeblog.net,
	richard.henderson@linaro.org,
	s.shtylyov@omp.ru,
	serjk@netup.ru,
	shc_work@mail.ru,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru,
	m.novosyolov@rosalinux.ru
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various compliance requirements."
Date: Fri, 25 Oct 2024 00:01:20 +0300
Message-Id: <20241024210120.4126-1-m.novosyolov@rosalinux.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
References: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable

Linus, Greg,

First of all thanks to you for taking by far not the most harmful actions=
 to achieve what your lawyers very kindly asked you to do.

Unfortunately, already a lot of highly qualified people have started thin=
king that you acted very badly. Of course, there are questions like why r=
emoved maintainers were not properly notified and did not receive any add=
itional explanations, but, to my mind, it is useless to try to find 100% =
justice -- it is not possible. Overton windows has been opened a bit more=
.

Usually the first contribution is much harder to make then the following =
ones. A big problem here is that now many people even will not try to con=
tribute to the Linux kernel and other open source projects: their pride f=
or themselves, their homeland, their colleagues has been severely hurt (w=
e are ready to fight for all that).

It is not clear what to do with this problem. Any ideas?

I am sure that people from any country and of any nationality will have s=
imilar feelings if you act with them or their colleagues in a similar way=
.

Thanks to people who were not afraid to say something against this action=
. Chinese, Latin American, African and other people probably understand t=
hat they may be the next ones to be dropped from maintainers. Hope that w=
e will not have to form another Linux kernel upstream one day...

I am sorry that you have to read a lot of text from people who you call t=
rolls -- it is hard to keep calm.

You know, you have really made it much harder to motivate people to contr=
ibute into the kernel. There is such problem among developers of hardware=
 that they do not feel comfortable enough to show their code, for example=
 because they think that it is not perfect. Let=E2=80=99s take Baikal Ele=
ctronics. They do publish their kernel code, but in a form of tarballs wi=
thout git. They slowly, but constantly worked on contributing support of =
their hardware into the upstream kernel, fixing not Baikal-related bugs b=
y the way. One day someone told them that =E2=80=9Cwe are not comfortable=
 with accepting your patches=E2=80=9D. And they stopped their work on ups=
tream. Now that man has been removed from maintainers of previously contr=
ibuted code (code for not Russian hardware, by the way).

What do I suggest to do? Well, I don=E2=80=99t know, but I do not see dir=
ect legal reasons why doing this was required and why patches from Baikal=
 could not be accepted (the fact that I do not see does not mean that the=
y do not exist, but please show them). Politicians and activists can be s=
hown a finger in some places, by both developers and lawyers, at least to=
 prevent them from being too ambitious, when they decide to break somethi=
ng working next time... But maybe I do not know something about truly dem=
ocratic regimes :-)

Thanks for reading.

