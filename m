Return-Path: <dmaengine+bounces-6436-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16298B51459
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A4A172DDB
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827B3126DA;
	Wed, 10 Sep 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UKcOtrWe"
X-Original-To: dmaengine@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2925782A;
	Wed, 10 Sep 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501252; cv=none; b=PVLnzzEmOWvjvX5DvxfyaDNk172iglCXGExODEKZ4yW6FNprUXzP5QXSgHClXEkZZVvs/maJ8sysHR+PiM3Qh9XlM3dkaalyOo7lUcWQWFFQ0Rp5H9EL/JGDQ8rr1J/gCtcnUK5Rk9zbZgtbsVUZHVQV1wqeDQZ3WBFc9xBoo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501252; c=relaxed/simple;
	bh=vuDuae618+G9GIUKKhfT2gpIoatwCsXfX9KM+fgvIWg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov4ZXYDN/PhDtUArlh2We80Foi4xxEOArdeQj6yRywKJxI7tguffcw3GRYTadfnvOeTpS0hC9AmNATzBnRxVNa7V7rlfJegIUJY39igiIvSEunkUojgZKtRccD1Hoh3kF9xGyM0p59DgHeJIQcbQ9hfniZjwqxwtfndApQiq97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UKcOtrWe; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757500940;
	bh=2g9SqMhLUUY5OWEkbJI62B9o1oK6Cw9puvU0A/SCA4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UKcOtrWeRpFVvSeF5GCNO133+5B6ZvqaXNXzV45vA3lJvkzVtzFWbiWnBOx/AezUZ
	 kMIyisSIVdUV0F9VZd6S67kmAx80S1MS+KqDzlYF4m9ffw9tfsvqdJiJN4J6aJUgqU
	 L2qBiOjvH1drJje0rA5tTn5QaYJ6SETm0WwqSVw0=
Received: from localhost ([112.94.75.165])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id A929FED7; Wed, 10 Sep 2025 18:42:18 +0800
X-QQ-mid: xmsmtpt1757500938tef4mg7kx
Message-ID: <tencent_7731B6630F8BF7EC0292D2F3ADAEA6F70207@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJ0OGUSKzaot3PkSIPfgVcLkJCNRpHiuJ/wDe1agEPYkkDgLl2Hi
	 VOLH3oLeXitQpuBvQSjVDLTenk7gOXKMWl5lIUdIurYWrfPcJfqoxIlMbwDa0NCVvD/fpfwctQ4W
	 dlK9X4VxXrG7MZypC2CsplwMvnT0QSoTIRbDK/PMKORm4o/XfhIUQzRmmgh1p6zV9KMUBUDDlxxe
	 7QiAGhORxfs6JdFSuF1CK/yMvtm3LKEeWHFAOkrOtx+/pQlaQ1KvAkMrnnQ0kofZ+7DM+METOhsF
	 J0A1iiFDrnSTAK6HqAfofrs00ucqqsMDGFwHyxDy58hE0EC4s2DjhkNvLFOWC+i7EVgr5krq/Xsw
	 jkbCVMlOSlPDeoU/ld01iXgQz+A8thbNZNMkJUeN4HQpFsLa2AMOet7cnlAmmr+EIFlGZseu13OX
	 p3EX36p5+2qlaV2ZSSqSjj5lxzQRmefkqiQTjai6y80FGFidMEQsOnwil/dqtAoA5lg9Btk/mgSr
	 IzLe9cdt2rPWbMaB36jw75vSDnopXHJTlmmyAHKei+sQgpdV/E/ZCvWG+stiNU5e0h+6EmsXn23S
	 xl6rZr63f7g/xOceAsyUYfcnG/qW7YR3qcT0dqdHS+BK5ZWJGOmKG+wa+RTDypNQrsjutbM3DC0v
	 CIZi00R9lMW3QWiloZRV1r5MM3JkInK9GunpWu+qwMnHMsb/tBCqS+3U9IfWSMMROzRHWEJPdYLX
	 gsj0D3vQ4jaYVaAUGpvKNwl9rW8zP3F30rm6CoHC06oNSDol+pZKrCf7gAu+8LCzZ03K+GrXoHk5
	 uFcVtNUdpTenn9iFEjhgpP9nvOTWOHyNxxeqjTDhgqaR0V+sMwduna4mUAeKmLzyfwCX1SLkZ98Y
	 jwyV3LptUlbJY901E7btNys4ibMQqCqYb0x42NGAwncT97apaNR8dB5BltdiakC2+Ks5Em5Siobs
	 Fr7wWd2LPZgHgdvQMwvFosqJk5CsFqEnf+SEGw9lEVTd8xbCkqnC5GHvpJ+CgYdSTNCuzSJsRerA
	 cL9uGeROqA7nvG09ZHTetWJgw1ONKke/Z2AYJAxw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Date: Wed, 10 Sep 2025 18:42:18 +0800
From: Conley Lee <conleylee@foxmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: vkoul@kernel.org, davem@davemloft.net, wens@csie.org,
	mripard@kernel.org, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
X-OQ-MSGID: <20250910104218.GA1760035@ubuntu-server>
References: <20250904072446.5563130d@kernel.org>
 <tencent_D434891410B0717BB0BDCB1434969E6EB50A@qq.com>
 <20250908132615.6a2507ed@kernel.org>
 <tencent_0DDFF70B944AC1B7CE9AC20A22D8DA3C4609@qq.com>
 <20250909181547.0782840f@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909181547.0782840f@kernel.org>

On 09/09/25 at 06:15下午, Jakub Kicinski wrote:
> Date: Tue, 9 Sep 2025 18:15:47 -0700
> From: Jakub Kicinski <kuba@kernel.org>
> To: 李克斯 <conleylee@foxmail.com>
> Cc: vkoul@kernel.org, davem@davemloft.net, wens@csie.org,
>  mripard@kernel.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org,
>  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
> 
> On Tue, 9 Sep 2025 14:36:42 +0800 李克斯 wrote:
> > Thank you for the suggestion. I've reviewed the documentation, and
> > setting the reuse flag while reusing descriptors might be a good
> > optimization. I'll make the changes and run some tests. If everything
> > works well, I'll submit a new patch.
> 
> To be clear if you're saying the driver is buggy and can crash right
> now we need to fix it first and then optimize it later, as separate
> commits. So that LTS kernels can backport the fix.
> 
> The questions I'm asking are because I don't understand whether the
> upstream kernel is buggy and how exactly..

After carefully reviewing the documentation and how other drivers use
dmaengine, I think that if the reuse flag is not set for the descriptor,
manual release is unnecessary. Therefore, the current driver implementation
does not contain a bug. This fix patch was a mistake.

Thank you for your thorough review.


