Return-Path: <dmaengine+bounces-1175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF386BCFE
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3195E1F25157
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EED22612;
	Thu, 29 Feb 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Rl5bViV4"
X-Original-To: dmaengine@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9900171AA
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167779; cv=none; b=Nf+2QfVXc/tcYDA6MobfratA0SjdUOZJ1h5I7Y9ySbvgweZA3iiErnoxe110jo8t1mIfdLegEFM59sNfdkmIS0gSM7Qo50QCqrKgrACJHZHarmrNHCP8YxbqQb1L417pSF5Cd73W8hXHt79gqfla8mS9i6LS1VsWVVlYleoHSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167779; c=relaxed/simple;
	bh=eJy7526b/+zGVIKSV9uSj1O67nrOJUqsliwJDm6XgBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q65u3wqoXPKKABAMQD7F3sCLFH8+1GBSX77Hd3ZYIptd1D/w7+1jt8CeJ7Kzvzd1e4h6OGxJZaL1S52T6VbBVKybl625HbSD5Pkz6N8WinacYI/XdqHPe3b+NscWrYROIQN+pCfyXCeL5mR38lIR7/7mwgzxEfNo7a/W+cOEU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Rl5bViV4; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id fTFCr4dkPs4yTfUc6riOaA; Thu, 29 Feb 2024 00:49:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fUc4rFGgwe1rDfUc5rtQL1; Thu, 29 Feb 2024 00:49:29 +0000
X-Authority-Analysis: v=2.4 cv=TvrghiXh c=1 sm=1 tr=0 ts=65dfd499
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10
 a=fHn5IWyn-i4c8q1BtbYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zjlg/tH38rkBMLvt/9bxLn+QRmwhVCWKNt+AkXN6Nec=; b=Rl5bViV4SrEtyy1Y3IFyKLvsG9
	NoXIGdPO99YzGOuke1rEDMsjndNpL3tNMskf8gDdDzZDq99nndWo7lajWsZPuNaH0Mf12xnJvFpiP
	CPIrNtDA0iIPqLxqfBqs2bBl6s8JWqDhqMsfTwu193K08NAwcfyqBPf45tmEmrrrzSYtoLfxvVXip
	kUpIXchdNxJxiFOmFzeeF1wmZTmXI8MNa66yskG1TQVtFIz9Gu6cdUOJy1WEzbIC7P30QQsrTD+Ws
	/jO3qhhf+nJrs6IxdAkWj/ZCBfRv5sp9A9ZGNWe3A3JMZkqlA2S7KnXjf4w+bKLtPcaKUGrh5YaKB
	8Iq1SE7A==;
Received: from [201.172.172.225] (port=57006 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rfUc3-00272c-2T;
	Wed, 28 Feb 2024 18:49:27 -0600
Message-ID: <653bbfe8-1b35-4f5e-b89d-9e374c64e46b@embeddedor.com>
Date: Wed, 28 Feb 2024 18:49:25 -0600
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
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202402281554.C1CEEF744@keescook>
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
X-Exim-ID: 1rfUc3-00272c-2T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:57006
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBolf4+BXRkiiCBgwb+KmASosVKxAFsXETBtc6NiFp/xWI7VVYOkt9jHFyfz31XcjoJLFUgTX6Jk5M67QvlC5fynPSHvMsGnx+vLNqMHauDciRUacEiZ
 GwYqmN0UZ+XCO+omPgA2560Nwh2MMtYqDnu4vaOL/NrUUDWJDEKaGzn2epvHyaaxDyDWFLjU0Rj3IEByh0orNuOtKjihMB5yaEQ=



On 2/28/24 18:01, Kees Cook wrote:
> On Wed, Feb 28, 2024 at 02:41:48PM -0800, Jakub Kicinski wrote:
>> On Wed, 28 Feb 2024 13:46:10 -0800 Kees Cook wrote:
>>> I really don't like hiding these trailing allocations from the compiler.
>>> Why can't something like this be done (totally untested):
>>>
>>>
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 118c40258d07..dae6df4fb177 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -2475,6 +2475,8 @@ struct net_device {
>>>   	/** @page_pools: page pools created for this netdevice */
>>>   	struct hlist_head	page_pools;
>>>   #endif
>>> +	u32			priv_size;
>>> +	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
>>
>> I like, FWIW, please submit! :)
> 
> So, I found several cases where struct net_device is included in the
> middle of another structure, which makes my proposal more awkward. But I
> also don't understand why it's in the _middle_. Shouldn't it always be
> at the beginning (with priv stuff following it?)
> Quick search and examined manually: git grep 'struct net_device [a-z0-9_]*;'
> 
> struct rtw89_dev
> struct ath10k
> etc.
> 
> Some even have two included (?)
> 
> But I still like the idea -- Gustavo has been solving these cases with
> having two structs, e.g.:
> 
> struct net_device {
> 	...unchanged...
> };
> 
> struct net_device_alloc {
> 	struct net_device	dev;
> 	u32			priv_size;
> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
> };
> 
> And internals can use struct net_device_alloc...

Yep, we should really consider going with the above, otherwise we would
have to do something like the following, to avoid having the flexible-array
member nested in the middle of other structs:

struct net_device {
	struct_group_tagged(net_device_hdr, hdr,
		...
		u32			priv_size;
	);
	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
}

We are grouping together the members in `struct net_device`, except the
flexible-array member, into a tagged `struct net_device_hdr`. This allows
us to exclude the flex array from its inclusion in any other struct
that contains `struct net_device` as a member without having to create
a completely separate struct definition.

And let's take as example `struct hfi1_netdev_rx`, where `struct net_device` is
included in the beginning:

drivers/infiniband/hw/hfi1/netdev.h:
struct hfi1_netdev_rx {

-	struct net_device rx_napi;
+       struct net_device_hdr rx_napi;


         struct hfi1_devdata *dd;
         struct hfi1_netdev_rxq *rxq;
         int num_rx_q;
         int rmt_start;
         struct xarray dev_tbl;
         /* count of enabled napi polls */
         atomic_t enabled;
         /* count of netdevs on top */
         atomic_t netdevs;
};

Of course we would also have to update the code that access `struct net_device`
members through `rx_napi` in `struct hfi1_netdev_rx`.

I'm currently working on the above solution for all the cases where having two
separate structs is not currently feasible. And with that we are looking to enable
`-Wflex-array-member-not-at-end`

So, if we can prevent this from the beginning it'd be really great. :)

--
Gustavo

