Return-Path: <dmaengine+bounces-2748-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CA793E451
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jul 2024 11:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE45D1F216C6
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jul 2024 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CAF1BF37;
	Sun, 28 Jul 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vzEeJJFr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866951877;
	Sun, 28 Jul 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722159651; cv=none; b=rtWCR5MnRnXILJ5U2Mq8bP4230QIJOJ/M5mi5QmC02zRRiu22JAya5SQpo3vvUEuFAhfYrurUv2XMfvlW0uiHoVimrhBcs95Mav/dTMKx+DsDwkiwcIskRtpJAly5+GIJcIMIZQmWj/VPdLiOFYjbJHCWDisnQmKnIdSIPH7XUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722159651; c=relaxed/simple;
	bh=EXcK3Bit/zJbF5FFNhIJyAliX82cCKj798f/pZPgAlU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WZvws+t0E1rcKeeaR/2nxBFfo56HofJCe41gbxVa3ghmL0oYtCkJfAO7MgJWSCy8ZYyvDM2eV/uis1WnHYQEzhABRc4xeZBm80wxsKMURbnqD+eM0oDqqphbS9eX0/jESJ0xykV6b0p0XfdcjqHT+1qNW85pmNfKLkB6ct1uLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vzEeJJFr; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722159627; x=1722764427; i=markus.elfring@web.de;
	bh=+pIgS+e9JSh9ALc2y7z8EVfK9KqYIRU+dVlJTa5wImw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vzEeJJFrdYO0Z7gepnNEXWUPldetGOb/5WUqQXGlktmQ+JA3BCV3dkRn0CRE+Hn/
	 fMtD7/P9/Hgr5nmtgAeOsi8kSIM6a1kp5vvdGYtkDj0zJ+4RflGoo0l64evijOtfy
	 MF/bUuizkPxRX1gOJg5yCms7/kVEbDJybXo1L/k2YZsa/ED1TGEAb+EdhHyeYKRLy
	 6jnhRoS+twghHdyE65mS8dwo4iE1xyVMuIwkKoAfxlpBUem33KRg8DxUWDJ2hIfJ0
	 1rkjnz2wO8Va1gEzFL7FTcJ7MMfCnz4pnw959KoJ6HdMrmZUnij9EOcM4sId46E2C
	 gEAAHhouJDoF6O1AHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1shBUI0aBd-00NJfD; Sun, 28
 Jul 2024 11:40:27 +0200
Message-ID: <624be618-1a1a-422c-85e9-be3e1d182adf@web.de>
Date: Sun, 28 Jul 2024 11:40:12 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keguang Zhang <keguang.zhang@gmail.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240726-loongson1-dma-v10-2-31bf095a6fa6@gmail.com>
Subject: Re: [PATCH v10 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA
 driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240726-loongson1-dma-v10-2-31bf095a6fa6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vKdYf3+VVL8lUjs0NnYPuuZGf0jwH3HnMk4HXP2F2E/BhGMrNLA
 rMxItCDPm2VSc86myDMzMtR48kNQ/unwWe2yQ6liTiPtq3kwtw9dDLAluTD/u0zIp1E/Azd
 NPJ17efnNhN8am2AvwntAb8ynndyGPeU18yFYkixb/Eb2j5XWOyELAQfEnhLCR4P8ImpVWl
 N2CX8Knw4QOhJbxZBMBmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vdhynPY24B8=;islEhC1vUb9Jjgtp5vF+hzhTZOD
 c0L/a/RL8NqzHjJL92VzYimNs62q6Ugsoj1kuloXNtvHnGxb6S25fRcOlVCF9cpheV7IX5IE1
 jJ5ETAxg4C9zrVRXRhlliIjsOISOnNxZDUAqiYdTPLogkR6xBu+m+fSF9gb2bHxOm20OV4zVU
 OvrWl3W/gPP9ywWUK3RIYCfTjjlvLKmt4VJb2+sOcm5DB+C3Chu7uRJcTCquMUndT9XCHAj/N
 0MLvPM9MWHX4Fbc4R6aw2K+ElLj5pkufKW+5Q96Br3S9dUCe37aH/vFYbnmp0+xM6eS/gkYWL
 6CNLwhB0WfwPNDtak7OAnPsqhaT13xjJoWeKy8aGTZI7Bs8hgITlLvMT2VEQD3VbZrdal6jd9
 tAUpnkcrHiYwSYPheJZZWldHMAqSlQUTn158tsW5Q5XS0o2CFB0PJdQRsk+LUzKQV8/0HCrLA
 JxGCu6Wd4Wcr/eTdSiZjCz/fcgSR2KI2CgUaeLyZ7IjYFjHXEkF4eeVuSOAhRQAno7fIqfXI8
 m6xp3woy7iamU24g5G6OmonJ/KSJoC1R9OP0i8GXyKSWzz3P50hTHI0shVCxn8A3d2WkCKCHk
 bsEQbrTIwwTmOxnOgOsvpj1t0Y4ivUQ6Ugvg7Ld0Ssw0g10cViRZ8KOEKqzHffMy2QD/8p3fK
 o6w/CjtRvRcq1SB7cGIygFMDaspt7rmZ/n93+NRI0B6BqUruRZ6V2oj1MY+9TGjCcic+GGB0I
 dlswdtO6rnNK4vsaJXaqxw4jH5Ez7fIX3qqLWbYkac30rU6Fc5gWfsBUwlkBETZi0ydl98pO2
 fZObadqMfnnO6wKOoXnKJXp/f3ObripWYbJVnF6vSKTNU=

> This patch adds =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10#n94


=E2=80=A6
> +++ b/drivers/dma/loongson1-apb-dma.c
> @@ -0,0 +1,675 @@
=E2=80=A6
> +static int ls1x_dma_resume(struct dma_chan *dchan)
> +{
=E2=80=A6
> +	spin_lock_irqsave(&chan->vchan.lock, flags);
> +	ret =3D ls1x_dma_start(chan, &chan->curr_lli->phys);
> +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +
> +	return ret;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irqsave)(&chan->vchan.lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/spinlock.h#L=
574

Regards,
Markus

