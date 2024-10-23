Return-Path: <dmaengine+bounces-3431-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CB9AC7C2
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76B31F26DDB
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DA1A4E9E;
	Wed, 23 Oct 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="t7k4LGPo"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA71A3BA1;
	Wed, 23 Oct 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678976; cv=none; b=pQYrBwjn5QnirAWMYmZePS+4qd1IDBmCr/xmamUKswKwAzp4QuJBJXXPHJzOhNiD4KB2YQDxP+TsIHgt8vbYH2kiFxhM5gxBbkSWIfUWxyT6q/L9vrSytOAD8KWQqyjFtocsv1mtEMlmN9eWXG9WZ+DwvI4UJR7Cos38hZ0xIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678976; c=relaxed/simple;
	bh=tsV4mDXWEcA6DLH5KJpY3Kl/VfFbOy479A1uRTvdzKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=NZfrvbfyerfSnruzQH0d1O0d0suVRfuNdpRqyHP0hH9HhrryFd7FtsmMJ9+1n4joWY9XZOhL/Am5MHlohfCSSaYS2bub/2unGLbHrf0ZtudN7e4GSmhVW+QkF9X4QIRW6MrqVYvF88t2iW0t5w2sJK0NzRTVCEnrN5GZYDl63p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=t7k4LGPo; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:201c:0:640:301d:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 097A3608FA;
	Wed, 23 Oct 2024 13:22:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eMQs7b6EhOs0-jQPVzoFY;
	Wed, 23 Oct 2024 13:22:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1729678962; bh=tsV4mDXWEcA6DLH5KJpY3Kl/VfFbOy479A1uRTvdzKU=;
	h=Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=t7k4LGPoi65xE+z+AyehS9q8r89CXR7Mahn1RgGwF5jkOr2zChOBX6LaMSc69iGGo
	 c9wFIgt2Jz5KDz7InYlVuOcoIwtZU1PBJCnuMRos50Ek+XKT94BieQ2j2LqjBKOo/b
	 BUaIjLBQDWdundy9pVqYWKTblnoIwciT/qShI9Dc=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <5605e699c215c86440972f7fe3e544816c699c15.camel@maquefel.me>
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: gregkh@linuxfoundation.org
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
 geert@linux-m68k.org, gregkh@linuxfoundation.org,
 hoan@os.amperecomputing.com,  ink@jurassic.park.msu.ru,
 linux-alpha@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-fpga@vger.kernel.org,  linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org,  linux-ide@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org,  linux-renesas-soc@vger.kernel.org,
 linux-spi@vger.kernel.org,  manivannan.sadhasivam@linaro.org, Matt Turner
 <mattst88@gmail.com>,  netdev@vger.kernel.org, nikita@trvn.ru,
 ntb@lists.linux.dev,  patches@lists.linux.dev,
 richard.henderson@linaro.org, s.shtylyov@omp.ru,  serjk@netup.ru,
 shc_work@mail.ru, tsbogend@alpha.franken.de,  v.georgiev@metrotek.ru,
 wangyuli@uniontech.com, wsa+renesas@sang-engineering.com,  xeb@mail.ru
Date: Wed, 23 Oct 2024 13:22:45 +0300
In-Reply-To: <2024101835-tiptop-blip-09ed@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>>Remove some entries due to various compliance requirements. They can
come back in the future if sufficient documentation is provided.

Greg,

Among the all possiblities you had, you've chosen the most disgusting
and shady way of doing this, with no attempt at least moving them to
CREDITS - the thing they rightfully deserve for their efforts.

As a person with M entries i deeply disrespect the removal and whe way
it was done.

