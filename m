Return-Path: <dmaengine+bounces-3451-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593509AD4D5
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 21:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1159D283C5B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ECF78C9C;
	Wed, 23 Oct 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=typeblog.net header.i=@typeblog.net header.b="WTSpmHeH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.typeblog.net (mail.typeblog.net [88.151.33.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A01D6DBB;
	Wed, 23 Oct 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.151.33.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711730; cv=none; b=cK16JeMN+kxcV3InFvc+cMvGS/1oyKNcX0Invtso1hDV5konXegfsJpuwOEWZWln8feXeN2fPKvZG5jIhp2BXImJ6Qquy3lXlWyRJ5mUZipFlsYuGON/xK4JN0HXzdOwzmSW4nGS3fFEVqA2CZoMP91Nv2C5hqOn9/TFTEC/luE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711730; c=relaxed/simple;
	bh=3TAmGrKOJGn5dy2fAvz4k2a76CeFGX9NiP5bEi+nbS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MceiWx2g54nFoqMD4FKapjT+1NUSoIl9pOu3KaQjyMgvPal6Uwbfnv60rFjPVT/zS0cLph6OYX5MQGyySyjh4ZsUI6fSlC64CTqgmA/7v+IP3CwWZaPG/ZG8iW5yCT6M8/fSRDi3LlV2t/2Slkw6fOpiP3GL9KJq2Kcq20uBXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=typeblog.net; spf=pass smtp.mailfrom=typeblog.net; dkim=pass (2048-bit key) header.d=typeblog.net header.i=@typeblog.net header.b=WTSpmHeH; arc=none smtp.client-ip=88.151.33.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=typeblog.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=typeblog.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51D29CFB625;
	Wed, 23 Oct 2024 21:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=typeblog.net;
	s=mailcow; t=1729711726;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RFgD/PA6YCmmlcKT63VAf3BqQtGq/9YYTOqYLD13kKs=;
	b=WTSpmHeHFoorJSU5dDnO4UKeYbz9QIFRiTGe32I7QJxlaTMH3dqAWSWCcGS7yMNUS/aesy
	V7fXYhJ2unN0UILIgstBlJaPvXFbF/2SsQX3zpb27NV1d545LXdAEvfWYG5N2ZV6CQ15zh
	t6C6DP8MAhA31hcH/BzXj4JNc2Q3JkYm/J/dzCSo3BQcbMAypfzp5C+P1OkUx6r5cjPeT2
	gtyIWW3G2nW6411D0X7f7wT9ehdOKHaUcVCqcSoJvU1Pwd6n9ZFj1G7iPdg3kfg0KcIVO+
	w6ihoFf+W+phMSBpbpVmlNrz0OJAiwermEEJEWdN3tCHYvoymOAyVTVkJ4it/A==
Message-ID: <80c25e27-0d90-428d-b206-6252d411daaa@typeblog.net>
Date: Wed, 23 Oct 2024 15:28:35 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>,
 jeffbai@aosc.io, gregkh@linuxfoundation.org, wangyuli@uniontech.com,
 aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
 mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
 ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org,
 s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
 <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
 <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Content-Language: en-US
From: Peter Cai <peter@typeblog.net>
In-Reply-To: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

> I'm also not going to start discussing legal issues with random
> internet people who I seriously suspect are paid actors and/or have
> been riled up by them.
> 
>                Linus

This has never been a legal discussion, but a procedural transparency 
discussion. You could simply say "our lawyer didn't ok this", and that's 
perfectly fine. No one is going to argue against that.

Your action up until now is also exactly what a hypothetical paid actor 
would have wanted to see happening -- it's not helping **understanding** 
but rather only extending argument on what would have been a quick response.

Calling everyone "paid actors" don't help. If you have more than 1 
minute to waste, I am under my most regularly-used internet handle to 
respond to you. So has the person who sent the original "revert" patch.

Running a quick grep on the other mailing lists and their commits may 
also have helped answer that.

Thanks,
Peter.


