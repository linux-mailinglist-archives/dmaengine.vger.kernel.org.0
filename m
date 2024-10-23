Return-Path: <dmaengine+bounces-3422-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180C9AC17D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 10:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502021C2127D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFBD15852E;
	Wed, 23 Oct 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="ymUA7U2g"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B515746E;
	Wed, 23 Oct 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671976; cv=none; b=ZIpOuTqxY1xY2kbNSeWTT6sgQAXeyDNSvGwk1CZjOt4ltEWLOXVN5Fb3Pjl1Ax4yiFQjMMtykUhKzm4gRxzmxKHgoMG3/4ikZRhIsxWE0Is/enKSh8Qh9e9gma/ZoQ0ljoO9cmrVdJreFZgaciIPT7QHVwgZd4pO7xXoRyw3TwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671976; c=relaxed/simple;
	bh=3IJxynij3iV8P5vDgPCGIgHicDhSoCTbzTZ2CMUqVNo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nq+/8hjZOIg4M5ejeYlDIIVxSBiCqNMaAOSADqkGexstan/YUDruRjOt0etmsLEssFG/08RLGQvZVUzpfHHK2wwVj+WTuf+oJ0zj5UUD8NwUNz6nWOV1dQoZayVUttBgFTPUv52n7Nff50tD5ijtOCiu6Ga6AXSx12np3kHO4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=ymUA7U2g; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 6F54720056;
	Wed, 23 Oct 2024 08:26:13 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id D42DA3E8E3;
	Wed, 23 Oct 2024 10:26:03 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id ECDC240071;
	Wed, 23 Oct 2024 08:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1729671961; bh=3IJxynij3iV8P5vDgPCGIgHicDhSoCTbzTZ2CMUqVNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ymUA7U2gTBz+Vd/OJ5ZZtxcNrrxh00VAGv/QpZuFHB6Z3cDCMc+882elOcoJ68pUR
	 CfsVTJ9GlTT5JVTNgGt2cHIhDHv/D4dYcHzQt2j1XOAnl/Yj6hVTmJ98bgdt9WjYci
	 e2CZXP/ddqBkRZ7uSUXEGX7KS91FknvE+WCJcjT0=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0D5F04127C;
	Wed, 23 Oct 2024 08:26:01 +0000 (UTC)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 16:26:00 +0800
From: Mingcong Bai <jeffbai@aosc.io>
To: WangYuli <wangyuli@uniontech.com>
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev, nikita@trvn.ru,
 ink@jurassic.park.msu.ru, shc_work@mail.ru, richard.henderson@linaro.org,
 mattst88@gmail.com, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, fancer.lancer@gmail.com,
 linux-hwmon@vger.kernel.org, dmaengine@vger.kernel.org, xeb@mail.ru,
 netdev@vger.kernel.org, s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
 serjk@netup.ru, aospan@netup.ru, linux-media@vger.kernel.org,
 ddrokosov@sberdevices.ru, linux-iio@vger.kernel.org, v.georgiev@metrotek.ru,
 linux-mips@vger.kernel.org, ntb@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, dushistov@mail.ru,
 manivannan.sadhasivam@linaro.org, conor.dooley@microchip.com,
 linux-fpga@vger.kernel.org, tsbogend@alpha.franken.de,
 hoan@os.amperecomputing.com, geert@linux-m68k.org,
 wsa+renesas@sang-engineering.com
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
In-Reply-To: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
References: <2024101835-tiptop-blip-09ed@gregkh>
 <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
 <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
Message-ID: <444fa53bdfdee75522a1af41655a99b0@aosc.io>
X-Sender: jeffbai@aosc.io
Organization: Anthon Open Source Community
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: ECDC240071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,mail.ru];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,trvn.ru,jurassic.park.msu.ru,mail.ru,linaro.org,gmail.com,vger.kernel.org,lists.infradead.org,omp.ru,netup.ru,sberdevices.ru,metrotek.ru,microchip.com,alpha.franken.de,os.amperecomputing.com,linux-m68k.org,sang-engineering.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[]

No, no, no. Nuh, uh.

Greg has unfortunately decided to respond in private over a matter that 
by no means should be glossed over. Here below is our conversation:

---

Greetings,

在 2024-10-23 15:55，Greg KH 写道：

> On Wed, Oct 23, 2024 at 03:32:50PM +0800, Mingcong Bai wrote:
> 
>> Greetings all,
> 
> <offlist>

Request declined. Your response is now public knowledge (and hey, if 
this is not by your will, my apologies). Again, this matter requires 
public response.

> 在 2024-10-23 14:30，WangYuli 写道： Although this commit has been merged, 
> it's still important to know the
> specific reason (or even an example) that triggered this change for
> everyone here, right?
> 
> And those maintainers who have been removed should be notified.
> Seconded.

Sorry, but that's not how this is allowed to work.  Please contact your
company lawyers if you have any questions about this.  And this only
affects maintainers, as you aren't listed in the MAINTAINERS file, there
should not be any issue, but again, contact your company if you have any
questions as they know what is going on.

Just *wink* if you were compelled into this.

> thanks,
> 
> greg k-h

Best Regards,
Mingcong Bai

