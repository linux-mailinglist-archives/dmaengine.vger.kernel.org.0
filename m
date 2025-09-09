Return-Path: <dmaengine+bounces-6429-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5644B4A283
	for <lists+dmaengine@lfdr.de>; Tue,  9 Sep 2025 08:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EAD174B2F
	for <lists+dmaengine@lfdr.de>; Tue,  9 Sep 2025 06:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08AC303A01;
	Tue,  9 Sep 2025 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VpK8+SAN"
X-Original-To: dmaengine@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A45303C80;
	Tue,  9 Sep 2025 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400197; cv=none; b=nQE0hXuaZllikmIE6MmcjPgmZc/j3UYCbRWEkJNdzPF6lbnngoXj3yNhDK1cGS18Nar+Ekz6ahqH7WMPUOa7TF3D0JoEOoMfqR91gV08S1VzXyfDM/MojxtuXsfE5zLD504Vo3mOvZDNrJcXt0ndmYa9oCR2s42S6Si7bL03/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400197; c=relaxed/simple;
	bh=vS71RVSJfyTjhLdRTAdPukbbtQ0EaMHbtNJD2RRA6QU=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=nLD0+mrovBoEMZt3kyEHKB0moWSoC2b7n/RBYSOLkV3oBfsjABC6z2vcm6jn//kJa6dzWypNnmzY7Rm1yEr36TdpgxcqXtjYKCAOhAe1hb+fzCsnJIJsCO105UdqDalnZ1rvuhcJ7JOCdldP49YZKPaUyzVqBlltc7+6gu/1sTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VpK8+SAN; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757400190;
	bh=6kXml5sxL5FgHFGnvzVrZnUmyeRp7OyAQ/g5lY07K1o=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=VpK8+SANVwQEv5fQfLEtkD0kRVRAqzDJi7Bn8GS1c4SUZYZuBHR0D7F1zIzpTwCnZ
	 pVl6y+ZDEuKj37HuGEgW2dzDVfy3j0nkDRETwUhQJ0nRbVIn0E0vx8K2Wyk91s9T0X
	 5rXqGgu4H8OEccvqAlhiQbFVpJy9V4i1PRpPWXXw=
Received: from smtpclient.apple ([14.22.11.171])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 9348F241; Tue, 09 Sep 2025 14:36:52 +0800
X-QQ-mid: xmsmtpt1757399812te48gzjec
Message-ID: <tencent_0DDFF70B944AC1B7CE9AC20A22D8DA3C4609@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND4NQ6su2bkHyOQz/K5BaRiBzsbhGv1dDvbM+5/vdI/qKIqFh6Bcs
	 U6xc6sfCRnJf5D8cMk6JwwwxnFVyLapQkP7e5uAA714+XZghiEIc1tMah0CQAj9H/tDX5VH1Vx1n
	 gs1qeamg3C9PjHNFI9lVeNq5fab71lZ/j9E7MqfWyocYVUikEplrrslJ5gvOfcNZOCrNR08vHbHs
	 FoyXf5mY/xwgkH2gKZY1oCVWvqCJ5D5H6VP6dVv5WPTyNgnf+Wr9toIWRTsc2R2XSOdpDXcHk/9w
	 UaonWze70r/FgcWUHI6rqftWKUk0dZMaY4B9lweWnfkIKcqrBPQbkKx0kXW4X/qBNSaapib8vAD/
	 gPpvvlWlgDcoWXAyolYTtNnQU8MUVVFQUgrSSVqzi4vWQ6wm4CZpULWlNroCQceS5z180j6xddD9
	 /7LhE5KSS5ns/mBUPig/4B21Mm5WP4vR8isb8FMW8hxo4tAxMfoWugYRxJUtKpNmT/k/aPDGMx1e
	 1bF7dU1bGsH4wNV2qdlAHL8WbhfAve06Sy0fKlfzzhCEBjmV/y29cqfSvtR4CVjICg8Kthl8g8IG
	 BVHpMxClSpG2aIrJ+++djTsolaZl1IpQkMREW7N0eJpCLqpgcT9rgvqyPS9324p2SChwstfZ26Rg
	 jGP2MrwFSFnOR9bPq2s21BRK19zZSFsQZOhAJS6KdukCE1nPf2LqMn6Thy/9Esqh2h/7hOf01Y26
	 P9MAHNKiJO5QQxQSL7676ZCYhnQW0+su92MNx6IXAQlUmIUHjFENxrRwvPPxjErTr2cU6J2CQwZs
	 38NZFBGsUfVc7IDA1pRDnjw+ywhVPzPLHOz0gK8+UD3YfCuHDoom+XSxCEJeuCfcpi5Pd0/oX2r+
	 la0TOediFO3wXEyPGSGhGsFtS4DKx6Ur5jKUNo/rbIIk5OqWfUjlnJ6o6vXdI7LtYmmG6xe7lr0t
	 KmgpcADswoNPkFTKzJoAv9ll5bOdo2OIusU0K43Y7/Y+2nyyTMfRMAqlNSDhdDr4BCENUDpWliu6
	 shHeVZtDrGXdinJs82
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
From: =?utf-8?B?5p2O5YWL5pav?= <conleylee@foxmail.com>
In-Reply-To: <20250908132615.6a2507ed@kernel.org>
Date: Tue, 9 Sep 2025 14:36:42 +0800
Cc: vkoul@kernel.org,
 davem@davemloft.net,
 wens@csie.org,
 mripard@kernel.org,
 netdev@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <97C888E4-C860-494C-9199-F8A3B9A6046D@foxmail.com>
References: <20250904072446.5563130d@kernel.org>
 <tencent_D434891410B0717BB0BDCB1434969E6EB50A@qq.com>
 <20250908132615.6a2507ed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)

Thank you for the suggestion. I've reviewed the documentation, and =
setting the reuse flag while reusing descriptors might be a good =
optimization. I'll make the changes and run some tests. If everything =
works well, I'll submit a new patch.

> 2025=E5=B9=B49=E6=9C=889=E6=97=A5 04:26=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun,  7 Sep 2025 19:29:30 +0800 Conley Lee wrote:
>> In the current implementation of the sun4i-emac driver, when using =
DMA to
>> receive data packets, the descriptor for the current DMA request is =
not
>> released in the rx_done_callback.
>=20
> I wish you elaborated more on the reuse flag not being set :\
>=20
>> Fix this by properly releasing the descriptor.
>>=20
>> Fixes: 47869e82c8b8 ("sun4i-emac.c: add dma support")
>> Signed-off-by: Conley Lee <conleylee@foxmail.com>
>=20
> Hi Vinod, could you TAL? Is this fix legit or there's something wrong
> with how the DMA engine API is used on this platform?
> =
https://lore.kernel.org/all/tencent_D434891410B0717BB0BDCB1434969E6EB50A@q=
q.com/


