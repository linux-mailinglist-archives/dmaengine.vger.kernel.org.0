Return-Path: <dmaengine+bounces-5981-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5FB20790
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 13:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B895D7A4FC1
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D702D239A;
	Mon, 11 Aug 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq8e8r+8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAD2D2384;
	Mon, 11 Aug 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911547; cv=none; b=iKy0I29tuEGglwM+0WsmZxDv0Xz3lsQ4P/fp/iE3xXT+Axs7BRgmmQNFc6hSfuAfB7xKaA6RJBear2b9RbX6F8cMzyfuxoxjVp4sCP0Z2BzD8KBKll8uBus0YFIkaaV4xluHPGyWceQfUIaIhbl9bx+Z859BIUQY/3oKV0RFSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911547; c=relaxed/simple;
	bh=NgePnk0hLdVGUUUrtFrVTlawhLnViXhvjfSGPny4ssY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGy6154TBLnYuNwpMy6vKEukplU9D3oWFk8SRCSeMVHcprmWxk6il6z2p6AbFnXV5I4U+eG1UcPk6mKin0fTBKl7CntDC2a7uPjlY3jygCt2tkPv6SPZ2EOgRLYmlgb02KB3pxwce+DGmxDcFJ2FKWayWZwzAUHj5m4BhLJycwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq8e8r+8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so35566315e9.0;
        Mon, 11 Aug 2025 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754911544; x=1755516344; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NgePnk0hLdVGUUUrtFrVTlawhLnViXhvjfSGPny4ssY=;
        b=hq8e8r+86djxyw/XMeqVavBTjkwk1WFpbAZ8H0bJbLwR5VMg0sy5axpePYMdv2iQbz
         xQqilRv2EjlFR+0GukynVpFAJy/edSqepEVWpZDWPmnAFsZxvSIqeLZZNGghLbVvW+Qj
         Y57d6GEZ7YHEFPChGlB/J5xlxGe88WPkNYl965iPJIUdDo9YuBMkxHeQXqAPm1hpt23b
         V1RyJuq5Qnw35HHeGiNYOWTDejD3i2StJ+v68oPRFcDkrukK5LyqDS0RcMXeosq5AGCO
         QAyAL4Qhi3M+SYP70oXWr86oyqKa2roe3HCcp2VPptkgsZzU0Vv+fVy5pGziRFVs6YMc
         QCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911544; x=1755516344;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgePnk0hLdVGUUUrtFrVTlawhLnViXhvjfSGPny4ssY=;
        b=YuUfOPkaK0jh95mC4Ltu8SC8eChsc9lOJbefHKpbg69hm25Ty8L/5UEO5hr4HwQZ/8
         8KL7ZDhpFXvnK8yNZkAHb6/rNH8RLL6Vtt5/7fPgKjymrOTadDnp5nn58kHlPN/4wexd
         AgrhxTQJ8QXGT7oWE1Sh594w7zi2YKlia2WVJCQm9YW3y+zVaD6u5eR2ex/vDlet5Ylo
         Wgx3rNuN2MyenGGvQttT6MwVVkL5imPfJ50VkFkW0vBlwZ+k3KDveOsOZVuv2PTTvqff
         nkEBtxXw77EUhs/b/3BPsb+57ui5yX7rBULcL5Zjox1ohbImc6p695CKxwquvF6etnDt
         iX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4bSegN8lXkjc+gd1z65SaLBhS2Vv2saTBXeDcjZSJ0HQhJJM6VQR78gN/YDMp4CMVS8X9DsuelIHlyBw450T7@vger.kernel.org, AJvYcCWX9Q0/khsY/PF1WVnJIFmgwMDRi6Q4C1WdCYNRNFE1xi2i4G5jpPhObGGwcNQBZ8D/UH7Z+wDF5bQ=@vger.kernel.org, AJvYcCWq1PUQHFzYKxUR9pxgltp5ZhOmMAgOQ/wCuYwzNLvvd42H4RRzi13WdhTqdEGemL0n99XLJSoNZ+NE1Jwo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1ipwHIycgaXS23o4bZxZB5oKuyPlfw/w7rb/33npgrUKqAfo
	y1isv2YX5awe8clQwSKuebESzSPePU9T42rfQ/MnoKM8G9Y0/HIyzJHz
X-Gm-Gg: ASbGncstOngCz9AGvnBCoF6ldQ82WNkID7l7jsMcUEDFWfW0c4jwveNQOXI0aWquFRz
	4EHuJw9+C8fPsGqjFVn9r07+/dFWPscjUZlD1pYuKbjFMKOE2WM6VuE4psTWNhxfLZv7riqawlY
	P7NDQKsqwA2meE62/LhVkZuoWmOMryuDcgPsK4WJc5eBCUI1nQx/f5N17KESJlWOSdSzgglw45X
	nWSyK6cREWLr/YzeF7eYLDserlU1MmzWjz0jmUoBpt0RUHhmB/0eX1P0xTwlLCvf0+hZ/mdIxXl
	Z0/wpEvg4nM5ITbJEKhEEW3/IXrlIJEyNYjW3pwsSS8dWSwjum0IbmNzmvHeEzwGdFd2hTipVQh
	4J42bIt1DT/D9ZRoUmbf662BnI72u
X-Google-Smtp-Source: AGHT+IHSxp2B07az7oN9FfcLYv4lIj5E+U0D5ash/1IVsd31eIgjnPZdWpQi8wJdM7zPVntTf/aKpw==
X-Received: by 2002:a05:600c:1988:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-459f4f0f55bmr95543565e9.22.1754911543827;
        Mon, 11 Aug 2025 04:25:43 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459db3048bdsm348584445e9.29.2025.08.11.04.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:25:43 -0700 (PDT)
Message-ID: <83538ab0-e3be-4aa1-a9cc-5e02e2c59fac@gmail.com>
Date: Mon, 11 Aug 2025 12:25:04 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Fix dereference on uninitialized pointer
 conf_dev
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811095836.1642093-1-colin.i.king@gmail.com>
 <aJnC8CLkQLnY-ZPr@stanley.mountain>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <aJnC8CLkQLnY-ZPr@stanley.mountain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dN4j5xfCY6JZsp59VBZrhgaP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dN4j5xfCY6JZsp59VBZrhgaP
Content-Type: multipart/mixed; boundary="------------y07EvnLqW1C0GsSZgbS1VsJl";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <83538ab0-e3be-4aa1-a9cc-5e02e2c59fac@gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: Fix dereference on uninitialized pointer
 conf_dev
References: <20250811095836.1642093-1-colin.i.king@gmail.com>
 <aJnC8CLkQLnY-ZPr@stanley.mountain>
In-Reply-To: <aJnC8CLkQLnY-ZPr@stanley.mountain>

--------------y07EvnLqW1C0GsSZgbS1VsJl
Content-Type: multipart/mixed; boundary="------------uOV6YRjH6sJELz8ztSHfmhua"

--------------uOV6YRjH6sJELz8ztSHfmhua
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMDgvMjAyNSAxMToxNiwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gT24gTW9uLCBB
dWcgMTEsIDIwMjUgYXQgMTA6NTg6MzZBTSArMDEwMCwgQ29saW4gSWFuIEtpbmcgd3JvdGU6
DQo+PiBDdXJyZW50bHkgaWYgdGhlIGFsbG9jYXRpb24gZm9yIHdxIGZhaWxzIG9uIHRoZSBp
bml0aWFsIGl0ZXJhdGlvbiBpbg0KPj4gdGhlIHNldHVwIGxvb3AgdGhlIGVycm9yIGV4aXQg
cGF0aCB0byBlcnIgd2lsbCBjYWxsIHB1dF9kZXZpY2Ugb24NCj4+IGFuIHVuaW5pdGlhbGl6
ZWQgcG9pbnRlciBjb25mX2Rldi4gRml4IHRoaXMgYnkgaW5pdGlhbGl6aW5nIGNvbmZfZGV2
DQo+PiB0byBOVUxMLCBub3RlIHRoYXQgcHV0X2RldmljZSB3aWxsIGlnbm9yZSBhIE5VTEwg
ZGV2aWNlIHBvaW50ZXIgc28gbm8NCj4+IG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBpc3N1
ZXMgb2NjdXIgb24gdGhpcyBjYWxsLg0KPj4NCj4+IEZpeGVzOiAzZmQyZjRiYzAxMGMgKCJk
bWFlbmdpbmU6IGlkeGQ6IGZpeCBtZW1vcnkgbGVhayBpbiBlcnJvciBoYW5kbGluZyBwYXRo
IG9mIGlkeGRfc2V0dXBfd3FzIikNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4g
S2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPiANCj4gTm8uICBUaGlz
IGlzbid0IHRoZSByaWdodCBmaXguICBJIGJhc2ljYWxseSB3cm90ZSBvdXQgdGhlIGNvcnJl
Y3QgZml4DQo+IGluIG15IGJ1ZyByZXBvcnQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9hRFF0M19yWmpYLVZ1SEpXQHN0YW5sZXkubW91bnRhaW4vDQo+IFNodWFpIFh1ZSBz
ZW50IGEgZml4IGFzIHdlbGwgYnV0IHRoYXQgcGF0Y2ggd2Fzbid0IHJpZ2h0IGVpdGhlciBi
dXQgSQ0KPiBkaWRuJ3QgcmV2aWV3IGl0IHVudGlsIG5vdy4NCj4gDQo+IEl0J3MgZWFzaWVz
dCBpZiBJIHNlbmQgdGhlIGZpeCBhbmQgZ2l2ZSB5b3UgUmVwb3J0ZWQtYnkgY3JlZGl0Lg0K
PiANCj4gcmVnYXJkcywNCj4gZGFuIGNhcnBlbnRlcg0KPiANCg0KVGhhbmtzIERhbiwgYWx3
YXlzIGFwcHJlY2lhdGUgeW91ciBpbnB1dCB0byB0aGVzZSBpc3N1ZXMuDQoNCkNvbGluDQo=

--------------uOV6YRjH6sJELz8ztSHfmhua
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------uOV6YRjH6sJELz8ztSHfmhua--

--------------y07EvnLqW1C0GsSZgbS1VsJl--

--------------dN4j5xfCY6JZsp59VBZrhgaP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmiZ0xAFAwAAAAAACgkQaMKH38aoAiYG
4xAAlJJEjsNJs6lOcTB+wKqaJg2P7GWdntIeWJuzC9EXfkgOvL/yIolCe+1uoZFWA5IT6BznPNSO
Ctl+Hnk5gShfPZgijsuu10yu3231vS3gQKhmFojbyliDGkUPWGHWirX/qKEDjZOA6ufopQdba2Rg
KXHWDw8bnbl2sNYKSR3QtEfCNbQCGqSb3nSIJzCHcE2UlzIHPmgAO11n34sg2OB9CY74u3Djscga
REBTn1gQafyJWTL9WOeUUC8g4xf0x8o0zCDi5i88WosYt0MyljHkKDBfkdzxQ4mLBcuWOic3ZzNh
nFYwtMGM2nEfqa3cQCfXo+GfJNDEEdxmnFH3Mbe2ZcBduyaFbw9oV2KO83/7dcyHgeo+HJEaWAsN
5ff5DCWe55DAliKgwlOCua592N2HvVdaZP6nCRHHV3NvTdi/MuC9DDgENK7SpxNJ/DvhNp4ODxN6
lKPS3ZfspDoP3G2iMRtbKLKE5nuktDv9UcgC1/qlbYmu9O8w/AHhPT5htHlezgrt7JiPFS2LJHIw
HbI+op18vVtE3kpJWhS3FbE/MMHKCPMUHUDw2pz7d9XdBej3ISaJCWjGMy+tnzMu5sk+EHAIBmBp
up0hIOmADLjNE7ZtIWRC/KkQ8jw8kGODIaG4yUPqgUhmPMMgyIYeKcrR1BaDOrn+FhwJt1cKUbDS
n2w=
=/d5L
-----END PGP SIGNATURE-----

--------------dN4j5xfCY6JZsp59VBZrhgaP--

