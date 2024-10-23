Return-Path: <dmaengine+bounces-3419-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B839AC053
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8679B2403D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F2154BFF;
	Wed, 23 Oct 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="SvSqZDdq"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CC154BEC;
	Wed, 23 Oct 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668790; cv=none; b=myYjNxo6ZwvDoLSBVIKFz9/LTLpi/665O5AldBLMM+rVsMQ67XxUbwv2/3JFcbm3CPZx0DuX8DkHtyT4ElU285gSemaJEQCcSqLptKZfXirdl7DucEKvRmx0nHn2X3K3ETuph+RX3+npPTe373iJNR2e4QpH6GkJIz3iC7ixJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668790; c=relaxed/simple;
	bh=xEo0swbVCdrGjVdei/ZvZa4U5Cg1mfinNBvemiRZC+8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Wdl4/A3S1BPrftLGY3W44hPwg3meYg/fQAtQkoUX5/baLV58koXx87wOwXZniApTP+vbVo206zKGSA1d7K4+7vB9WUvKqlIgX8NqbhfFcmOUUUuafJTZo1KYq398PnbOeHoZtyASl9hgdnQ1mziT9yHIy4ymCpfU0PBQ/Ul6Zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=SvSqZDdq; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 4DC6A26761;
	Wed, 23 Oct 2024 07:33:01 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 4B4033E9D6;
	Wed, 23 Oct 2024 07:32:53 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id F1FA140071;
	Wed, 23 Oct 2024 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1729668771; bh=xEo0swbVCdrGjVdei/ZvZa4U5Cg1mfinNBvemiRZC+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SvSqZDdqa/ICtW2R15erWVPbVyfE4hGMXwFYFIIFJULUy5Gsz/e9Obz0kKMRpZuuP
	 qWt7ccWb2aX9Jr1l6fU1NnihUmbwmhhq3BEauxQRazcsa4UFnWWMyVWO4yVj3b5/HO
	 +QksPHbpOl9qNeYXOjk0WVaL2Xvcd3NvmI8bkKZM=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 457BE407D9;
	Wed, 23 Oct 2024 07:32:51 +0000 (UTC)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 15:32:50 +0800
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
In-Reply-To: <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
References: <2024101835-tiptop-blip-09ed@gregkh>
 <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
Message-ID: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
X-Sender: jeffbai@aosc.io
Organization: Anthon Open Source Community
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: F1FA140071
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

Greetings all,

在 2024-10-23 14:30，WangYuli 写道：
> Although this commit has been merged, it's still important to know the 
> specific reason (or even an example) that triggered this change for 
> everyone here, right?
> 
> And those maintainers who have been removed should be notified.

Seconded.

> It should be CC'd everyone who might need to be aware of this change, 
> including the removed maintainers, other maintainers on the subsystem, 
> and the subsystem's mailing list.
> 
> To ensure transparency.

This patch is one such instance where we find ourselves questioning the 
legitimacy and indeed, the feasibility, of an international, open, and 
open source project. Vagueness breeds distrust.

It's not difficult to deduce what the "various compliance requirements" 
are and I'm sure Greg is aware of this. The Linux Foundation, if 
interested in continuing their governance role over the Linux kernel, 
should be ready to explain themselves over this decision. Greg and 
Linus, I'm not sure if I'm ready to believe that this is supposed to be 
a political show - but if this is the case, please leave the ground for 
the Foundation - they should be the one responsible and receiving the 
scrutiny (or insult, as I'm sure many - myself included - find this 
patch insulting).

So I repeat - call the decision-makers out and ask for their 
explanation.

Best Regards,
Mingcong Bai

