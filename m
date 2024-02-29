Return-Path: <dmaengine+bounces-1178-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EE86BE0C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 02:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295B51F2AFC1
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9E364D6;
	Thu, 29 Feb 2024 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="BWLInSMj"
X-Original-To: dmaengine@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD92364C7
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168609; cv=none; b=ReQbatAEMk6OjJxqQPdt2twWDlPxVU6KgFmYzShnvO40UzLMS9P2G3lge2f7UN55yfYZj58jFH4YtztAADTsDwme0FUkvc7qeAsp5YDsD+NwthMeN1eScxe7e1E+5S4NlbbCiJOjZJdcMtwRIwASKqgDS6R7IDVxlDfik/Qjl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168609; c=relaxed/simple;
	bh=aFMYAjr2Kwl3Bq7QOoD1HkmCDlg/qynNYcIWlH3skcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9PWNwAzFnj8XyDhIAW+d4aQODhlu5DmIsQMdxAHioHwZOeX3DjLKoMwSplE99gUCF2Z5l4bef6uaP/Op4OkJW0sDLqAtB443Nat1qwppFIJnoBpzMKtFqgoXvEhHYDTvAjNyYbYmm4U6lR3bv5C7NCF90yVAEd825arw3rat5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=BWLInSMj; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id fUaGr50DMs4yTfUpariU81; Thu, 29 Feb 2024 01:03:26 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fUpZrdd7YiF49fUpZrigVd; Thu, 29 Feb 2024 01:03:26 +0000
X-Authority-Analysis: v=2.4 cv=f8VOBvyM c=1 sm=1 tr=0 ts=65dfd7de
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10
 a=geO6l3TllUDVLW6gesMA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KBOTTqsdtZgwVhU0ouDC8P1Pw8ERk6YxtzTNZWn5OtE=; b=BWLInSMjsxRqyUlKy1+ZZI/0mw
	rChvfHJHA7IhUbQR20kcbnULtGDxOtyDM4WwAAlnZj+p16hPezaj5k+oL2pEX1dL7IYxGdtAScO59
	+n+HA2/lhE38EZ98aFuE3k5gC1b+9KmX+5OAvV6dr2kq3Ny0tcGu+mzsGOYoZkCcuh1OQw6CbsdJn
	hIGPJj3EfmQmA5HNFKJdpMw7PMNx2Qm2EUik3O+fqQbY9HJlfRcxiBl3ia62+9U48Z5hdDpPQwlFx
	Eup+wtSYRzz89/gG5NiWhg+oI4n6WArW/Teq8lImknBwSiEG4YuUQa6P0dtBE/XAn8tNk5r6CuYh4
	4x1bwyKQ==;
Received: from [201.172.172.225] (port=35524 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rfUpX-002Jt3-2S;
	Wed, 28 Feb 2024 19:03:24 -0600
Message-ID: <49f55b02-ce21-40ac-a4cc-02894cd5eb8f@embeddedor.com>
Date: Wed, 28 Feb 2024 19:03:12 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook> <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
 <653bbfe8-1b35-4f5e-b89d-9e374c64e46b@embeddedor.com>
 <20240228165730.3171d76c@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240228165730.3171d76c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rfUpX-002Jt3-2S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:35524
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE8sFbGTIlEhku8bOc+rcvw5X6nYzpy4hc5IMI11GAv5VZM98MO9uOV/qrMU7RuyG7lzAFDqF8e/2NoP+vUrY7uv+C4JzqLZjFdQksWdUoLt4C+fPsb+
 sLOIZybbzUTvzP+yjOMI4CXovwYfwYEizI4WbwOEZ5ulkg5TkT6XTRI4FwzpSi/O5aGtsTQ6ejOLl1NDEfQjFtpkInHYO66P6GA=



On 2/28/24 18:57, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 18:49:25 -0600 Gustavo A. R. Silva wrote:
>> struct net_device {
>> 	struct_group_tagged(net_device_hdr, hdr,
>> 		...
>> 		u32			priv_size;
>> 	);
>> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
>> }
> 
> No, no, that's not happening.

Thanks, one less flex-struct to change. :)



