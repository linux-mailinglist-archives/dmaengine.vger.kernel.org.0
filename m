Return-Path: <dmaengine+bounces-3445-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB419AD0C9
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8127F281447
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EF21D0943;
	Wed, 23 Oct 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="mBhD5Z2i"
X-Original-To: dmaengine@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E31CDFA7;
	Wed, 23 Oct 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700934; cv=none; b=SQMC0TuUwjqVnNHzfMtYIBtS0I6lf0es32nuJbgCWALvWMm4VK8FYr8dt/CM9ylh/+Kwd2HdqKallVaoPsHs70zH13bqjozl8P3i0G3s+hxExny86gURHlHXwRnxRL2d/VjTsnOK6HOniIlXj+1rlh1KC8pyvez3dhQLjncXv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700934; c=relaxed/simple;
	bh=ImGCMCLcj/skCiYbANA7Nn2kAh541W4YFyorni/4W34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+y91WcOkYhHbSmdH2D9tRbYrdWM8GalV3s3Fol55u2mAO2sP17Yn+OMROlMZNM+h8LsqGfoRU/eY8Ulvxz1802AL/5TW/xYSz2r3b/wBXAgnryV4rpcdY4Z0du5cIMJ1BAFqQw0sJ9Qcb/vkRSziB0XCSKkgSkUs7HQHNRtr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=mBhD5Z2i; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E875424F55;
	Wed, 23 Oct 2024 18:23:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LM4QKJJ_KumL; Wed, 23 Oct 2024 18:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1729700603; bh=ImGCMCLcj/skCiYbANA7Nn2kAh541W4YFyorni/4W34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mBhD5Z2iVFfmKpdSW/evjvBUJawTiTTumRRO/Q+FtBNYlc+tp3mwM4tCBMcXP/Hvh
	 5l+8+NeYW5sllWZuLhhLWUGokX3pZNdf9ZZWbb+vKUjjDiu3AXuHz5BGJa8Lw/Wc4Z
	 4mTOtkQR9Xc2DESVrl5IcQ3Oo/Z1IPJjJERSmoIu5Rhk2RZ+Izzf3gqLT9EdPE8y8k
	 nvFCD8bkddNgrha80K6ja47euJ3Pp9jmZhFiOIAuOzrNXQuKQch1CWQsu3Uqta8WG4
	 AYKkovqFgO11xipB9v5pp7TPiGHCF36nhchbDp1B0i8owc4T+PmVTKNXgM9BASQ/Sx
	 qygChoYVCzn9A==
Date: Wed, 23 Oct 2024 16:22:58 +0000
From: Yao Zi <ziyao@disroot.org>
To: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
	gregkh@linuxfoundation.org, wangyuli@uniontech.com,
	torvalds@linux-foundation.org
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org, dushistov@mail.ru,
	fancer.lancer@gmail.com, geert@linux-m68k.org,
	hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
	ntb@lists.linux.dev, patches@lists.linux.dev,
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru,
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
Message-ID: <Zxki4gooqoZfPoqD@pineapple>
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023080935.2945-2-kexybiscuit@aosc.io>

On Wed, Oct 23, 2024 at 04:09:34PM +0800, Kexy Biscuit wrote:
> Are the "compliance requirements" documented on docs.kernel.org? Who are
> responsible for them? Are all that are responsible employees of
> The Linux Foundation, which is regulated by the U.S. legislature?

These should be answered publicly, but IMHO too emotional to be included
in commit message.

As a newcoming contributor, I work on some ARM SoCs unpaid. It's really
a neat thing to write useful stuff for others, but this sort of removal
is weakening my and definitely others' trust to maintainers: people's
rights to maintain stuff written by themselves got removed silencely.
It doesn't sound like a good sign to me.

We need an explanation. The patch except the last paragraph looks good
to me.

Reviewed-by: Yao Zi <ziyao@disroot.org>

