Return-Path: <dmaengine+bounces-2469-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56889111DA
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 21:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98210281F56
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C51B47BA;
	Thu, 20 Jun 2024 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/sj23vs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FC1B143E;
	Thu, 20 Jun 2024 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910716; cv=none; b=aVZYRfcMG9OgvCwt5GFfLb5J/pTIIpDYoUwHy6OiNRMBJwQ2HP+BOT28fS43eSJur80Zs2PTIqSrQLqL9xibi3w45AQGM8juWJMygvznaNeYiRlA/IhTfvvRoab7Z0oSGtAh34kB0dKmBKqABm1jhXBqSjBKDKY002B4ykSS9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910716; c=relaxed/simple;
	bh=PHJYBUwMx9MsppvbS5e3PTjqE/Je4d+7DMUX9BJflTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZx2+cvLTOvMmNAF/kVNA/WQucTBKuTqATNzb68hSc7DspyejSB5BR+a0U+A2w/HCE60PSTm6ew7dVBERqmr5CvoF+7XB/FhBNy3QKjqt/MkFmYfPmm+PxzYOql0InXN/SG/iGd++b4pRlAws9oZRJFwF8d3XCqQU7sscsFaYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/sj23vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D48AC2BD10;
	Thu, 20 Jun 2024 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718910716;
	bh=PHJYBUwMx9MsppvbS5e3PTjqE/Je4d+7DMUX9BJflTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n/sj23vsn1PWHoed17H0pABW4prh3E3LTezhve35uy3Sdmj0kFptQMqKyozm16g+A
	 6idpJFvmOkQcOxtMGifHN0Pid1fCKQ1JyJXgushJhM4smjPvwB++4/IN0gjt1EtlWK
	 JL/D1flZA/51Zf9CyXqQ+u9fz6+2AR9z2eaKb3JVawSD6YzNa1uqFYngRGgXnfUQoG
	 9AULJwTpjghTEH3Y+h3oruJow/Oz5QdkaLVXbx0lHzAF1PYckOuQR+XIqQfgKhDy0C
	 jTQF3ZVVzpd2cQKtt1BsWvPNzKm1hs4AgZHAVA8QBMxe7ZtWzr3RHMx5topRAqDciC
	 XqS187DxFpadw==
Date: Thu, 20 Jun 2024 20:11:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jonathan Corbet
 <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v12 0/7] iio: new DMABUF based API v12
Message-ID: <20240620201150.72c11599@jic23-huawei>
In-Reply-To: <ZnRW2axOg7gtKzz0@matsya>
References: <20240620122726.41232-1-paul@crapouillou.net>
	<ZnRW2axOg7gtKzz0@matsya>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 21:50:41 +0530
Vinod Koul <vkoul@kernel.org> wrote:

> On 20-06-24, 14:27, Paul Cercueil wrote:
> > Hi Jonathan, =20
>=20
> Hey Jonathan,
>=20
> Assuming we are fine with this series, how would you like to proceed.
> Would you be fine with me picking the dmaengine bits and providing a
> signed tag for you to pull?
>=20

Hi Vinod,

Yes. That will work nicely.
=46rom my side it all looks good.

Thanks,

Jonathan



