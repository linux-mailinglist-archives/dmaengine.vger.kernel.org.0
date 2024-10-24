Return-Path: <dmaengine+bounces-3461-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036839ADDA6
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0491C20617
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E519E98B;
	Thu, 24 Oct 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="dHW1x1n0"
X-Original-To: dmaengine@vger.kernel.org
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4A16726E;
	Thu, 24 Oct 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755071; cv=none; b=rUKZg6AYrV32I+dG+RF4jSsPB+7COTBwiRO+45XoNvKkdXXHuW9i7T24yebRSd3zvi3uDIJoXbspuQOeeWkWY3/HCu3t8sFrKRQKQPL30dL2qZHTRPMToeJ95XtY6IL8mlekDoN0UMEBV2S0UR8EWxP2Nxv+qu/Czk08kHwjBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755071; c=relaxed/simple;
	bh=0og/Lc+FOv201w81B5yra/V4GJ7tcC9gsrNBemtGhFs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JDXNKYzCZVY6ZwdrWOKpaqSu4/RimPVkKItBb3cC1Yk2nrJ0UwTDjDLy+tsNl/C4+i1DTydR1vGktcmq7bVu2tZGqcxj4HPvCjm20atSuewVJjQ0T+0mo7vpcf4pfybmnocrwZSixnxeRz+4ut11lfTH4/lPNFI10saC7M39C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=dHW1x1n0; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=7bmf93KccZco1vkeephdnqfRykS8tBowUwbPty2fku8=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1729753926; v=1; x=1730185926;
 b=dHW1x1n0wG8iytTW0EtHnAKJ8f/nOq6kGNnSckz5fjAWcpJ28byWz0l9i0Y6P6HFyHUjVHVi
 YPyOz4J7jlvpfuD+XWmq7sx+9KIg8cpk8q4N307s6vpqIrEckYupyow4Vg/6tHxdLgx0qTW56kM
 B7yLaTLwNE2lq4wIEr8BQiDTeIiIV7x38//B1pkUd7b4JVQMgdu0oii1iXQKN4mf/FaQkNvu1W9
 VUcKxpttvs7rqGfpHb835X5NWaCWQA/RhAL4nOpyvocEl1wZU9isPtmKu9rktyE84W0qgWV9deE
 5EGdlnrEeQgg/75GzH4IXgpYK54ZtoSI+k9tHRrXQAYVw==
Received: by wiki.archlinuxcn.org (envelope-sender
 <integral@archlinuxcn.org>) with ESMTPS id 5251ddab; Thu, 24 Oct 2024
 15:12:06 +0800
Message-ID: <1ca0a261-c3f1-4cb5-ada4-8125ec22cdf6@archlinuxcn.org>
Date: Thu, 24 Oct 2024 15:11:51 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, gregkh@linuxfoundation.org,
 hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, jeffbai@aosc.io,
 kexybiscuit@aosc.io, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, mattst88@gmail.com,
 netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev,
 patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru,
 serjk@netup.ru, shc_work@mail.ru, torvic9@mailbox.org,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, wangyuli@uniontech.com,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
Content-Language: en-US
From: Integral <integral@archlinuxcn.org>
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linus Torvalds,


We are not paid actors. Most of us here are just common kernel

developers or Linux users expressing our own opinions about the

removal commit.


I can fully understand your disapproval of Russian aggression. However,

the true responsibility for the war lies with the ruler, not these innocent

developers, right? Removing them from the MAINTAINERS file neither

really assists Ukraine nor cripples Russia. Those who are removed are just

developers, not politicians or soldiers. On the contrary, this silent 
removal

will damage our trust in the transparency of kernel development.



