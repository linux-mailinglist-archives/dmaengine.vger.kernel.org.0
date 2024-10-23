Return-Path: <dmaengine+bounces-3427-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CEA9AC6D4
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 11:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65B91C2135F
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3189519AA46;
	Wed, 23 Oct 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="R40Q7z4T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C915CD52;
	Wed, 23 Oct 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676372; cv=none; b=jMunbkB9M3yVMX4yANDkS7T4/7XFGus0pUElH2dgcPvo0A4wOexuf9Q+AvMMclQOXvcKo6n83cNeY9VolvIUmnXS6oS7aOxcsrPhG5DAotWgEb56jxtlu3qf0V5fV+Y5UmyaQdRvVjeA36lrcOKLpfqIe/mrAQmiXY2xL/xm7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676372; c=relaxed/simple;
	bh=QF/jaXhx5/NNBI1uZEY/Y3g3zYWwoUvRzmIALicrljo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jhrz7CfSAHOLUI4ha7U2jRLmJIkuxV/xyvQtLaWWlLwofTPn1RdTQQpSN5oAd3TpSONgxWjaAv0qbSsOzHjo3jlECmto4c5ioiXJ/BwCrIiVSboBs/DCuAmSGx+zq0CZKw+5LQNAJu2kYxQM4jjN4e/xfcUK/qoMHKE2ck3W0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=R40Q7z4T; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729676311;
	bh=QF/jaXhx5/NNBI1uZEY/Y3g3zYWwoUvRzmIALicrljo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=R40Q7z4TMR6QysGPZMc4BsJPggQ2G7NA6xxgCc8xYKIrVGdIekOK+YyxzZJV44Qb6
	 6wE3J6JlTjNnqlCSerK98GXlzf2nti+I0xOZk0QgmWxSzBbzLQgajKugioJ1lQFOYz
	 XNjXcolt2BULS2oYGQDMxfmvuQiwnX82qRGJFq08=
X-QQ-mid: bizesmtp77t1729676302tfw4pc5r
X-QQ-Originating-IP: j4Uoxci2RtnVTGsTNP/gQfdQgd0owTwx3inBP/hx8jA=
Received: from [10.20.53.22] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Oct 2024 17:38:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17180917475525741311
Message-ID: <1E6A0B26DC871B50+d97424c4-29ab-4bb2-b1df-8f04f8b865ca@uniontech.com>
Date: Wed, 23 Oct 2024 17:38:17 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
To: Mingcong Bai <jeffbai@aosc.io>
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
 wsa+renesas@sang-engineering.com, mchehab+huawei@kernel.org,
 xiangxia.m.yue@gmail.com
References: <2024101835-tiptop-blip-09ed@gregkh>
 <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
 <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <444fa53bdfdee75522a1af41655a99b0@aosc.io>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <444fa53bdfdee75522a1af41655a99b0@aosc.io>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------r97sG9xHlL94zbsyZpdQWneg"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MytpMCCBBwXiQTqlzmOtOiyKab7iKEOcUkdUwE8xo/3sPqfa9mFgZUhc
	Noq9QcWvF48dcyyZs5jQuZnRxTzb5hdxuTHzS5XAx04gxp3xjyvngFJJt1WMnvf2yzehGW/
	43VRC83KkH2eJUSqMbo/HLmM0OwuOiWD9G3u5gQvwXckFqjpdV+k5RVjt3RY8zVmTJ/C0A6
	Mj+yM1xtGD5htv+e2yypFAJhaNYSXb1/KWgFuDV2qAdVq6j3nu43Cnj8iv8zczmLvwvIPNG
	7lGr5jtSyzsYc0NzTqJHJrHB0DXKw3+UaMdb3CM4EfdVe6tsD5CJHELkRoi/6/IGVxHoup1
	JMlkh6BP2HC/6h/WsNu4BM2iwqZldIBauy9j0wgV17oZYTcLOFGrK9NRRx3UoN8eDZagguV
	D3oUWyUVazNi91biWQuVsDGKPuqe+oSrpQKBUmGAew3PJKJiebtVsCX6fBn6Wj0dtv3Zv8g
	XyzXLFUzpsdRWF5DYRdFpJRPElP74dfISscIubZeELPEBL39gdcKjd3LGInYV0Qr/U4cyhx
	tOPqM0h2RJW9cgH0owXZw+I/asYSDoScQMJHAq7mTzOAuX7/jdOCJQPgsfqvcpQWpC/ns0C
	5bLIq1PGfsnLHGbwHDPBjY+xGSkNVSFePoxbWJMHVi944WFW9CmiM5DXSvuQMDrwFa7PjlG
	RJ9nXLn48icA1n1aA+gWzjq694AMasDxw2juG+7xmFcCyIg0kcBU+HHASPLCKSeD39zoZwR
	RpsN0tk5wzDFT95owLon7WLvKGLxsbns3tvq8jrAkrdbZfSAS27YQjA3K/hQAthR24NN5zj
	dICIT4okBYWbhDlSOtgMzdgrD/bE+qUddLqZR7hAvozxHyQVIwae/ZzCxqK+3ylTmN/LGp7
	s+wV0Yoc4hxtn3mb0Axrw0nqfJQEl/XxcQvFp1TPubID73njPotKM4GzJHPfZQ6e0xcafi1
	mLNHveRIRsxVlKxqUbDfibDVCf3GMlNMGF7m1jJaUpg6u44Ld0vL6/i6Dk5pXKb+vC5HTa8
	OSzKDtPg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------r97sG9xHlL94zbsyZpdQWneg
Content-Type: multipart/mixed; boundary="------------JzXTUjOcl4RCqRode5kxglom";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Mingcong Bai <jeffbai@aosc.io>
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
 wsa+renesas@sang-engineering.com, mchehab+huawei@kernel.org,
 xiangxia.m.yue@gmail.com
Message-ID: <d97424c4-29ab-4bb2-b1df-8f04f8b865ca@uniontech.com>
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
References: <2024101835-tiptop-blip-09ed@gregkh>
 <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
 <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <444fa53bdfdee75522a1af41655a99b0@aosc.io>
In-Reply-To: <444fa53bdfdee75522a1af41655a99b0@aosc.io>

--------------JzXTUjOcl4RCqRode5kxglom
Content-Type: multipart/mixed; boundary="------------scTKQpIAgv93yoqxUNnHojEI"

--------------scTKQpIAgv93yoqxUNnHojEI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGFoYSwgSSByZWNlaXZlZCBhIHNpbWlsYXIgb2ZmLWxpc3QgcmVwbHkuDQoNCkkgZGVlcGx5
IHN5bXBhdGhpemUgd2l0aCBHcmVnLWtoJ3Mgc2l0dWF0aW9uIGFuZCBoaXMgdW5zcG9rZW4g
DQpkaWZmaWN1bHRpZXMsIGFsdGhvdWdoIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgdGhlIE1B
SU5UQUlORVJTIGZpbGUsIGFzIA0KcGFydCBvZiB0aGUga2VybmVsIGNvZGUsIHNob3VsZCBi
ZSBvZmYtbGltaXRzIHRvIG5vbi1tYWludGFpbmVyIA0KZGV2ZWxvcGVycywgZXNwZWNpYWxs
eSB3aGVuIHRoaXMgY2xlYXJseSBpc24ndCBqdXN0IGFib3V0ICdtb2RpZnlpbmcgdGhlIA0K
TUFJTlRBSU5FUlMgZmlsZS4nDQoNCklmIGFueSBMaW51eCBkZXZlbG9wZXIgdGFjaXRseSBh
cHByb3ZlcyBvZiB0aGlzLCB0aGV5J3JlIGVzc2VudGlhbGx5IA0KZ2l2aW5nIGEgZ3JlZW4g
bGlnaHQgdG8gc29tZSBzaGFkeSBwb2xpdGljYWwgYWN0b3JzIGZyb20gYSBjZXJ0YWluIA0K
Y291bnRyeSB0byBjb2VyY2UgcGVvcGxlIGludG8gYmV0cmF5aW5nIGl0J3MgY29uc3RpdHV0
aW9uLg0KDQpUaGF0J3MgYWJzdXJkLiBBZ2FpbiwgbXkgaGVhcnQgZ29lcyBvdXQgdG8gYWxs
IChpbmNsdWRpbmcgR3JlZy1raCkgdGhhdCANCmFmZmVjdGVkIGJ5IHRoaXMuDQoNCkkgbWVh
biBubyBvZmZlbnNlIHRvIGFueW9uZSwgYnV0IHRoaXMgYWN0aW9uIHdpbGwgY29tcGxldGVs
eSBkZXN0cm95IHRoZSANCnRydXN0IHRoYXQgZGV2ZWxvcGVycyB3b3JsZHdpZGUgaGF2ZSBp
biB0aGUgTGludXgga2VybmVsIHByb2plY3QgYW5kIHRoZSANCmVudGlyZSBMaW51eCBGb3Vu
ZGF0aW9uLCBhbmQgdGhlIHBvbGl0aWNpYW5zIGZvcmNpbmcgeW91IHRvIGRvIHRoaXMgDQpj
bGVhcmx5IGRvbid0IGNhcmUgYWJvdXQgdGhhdC4NCg0KVG8gYXZvaWQgYmVjb21pbmcgcGF3
bnMgaW4gYSBwb2xpdGljYWwgZ2FtZSBhbmQgdG8gcHJldmVudCBhbGllbmF0aW5nIA0KYWxs
IHRoZSBkZXZlbG9wZXJzIHdobyBoYXZlIGNvbnRyaWJ1dGVkIHRvIHRoZSBMaW51eCBrZXJu
ZWwsIEkgc2luY2VyZWx5IA0Kc3VnZ2VzdCB0aGF0IHlvdSBtYWludGFpbmVycyByZXZlcnQg
dGhpcyBjb21taXQgYW5kIHByb21pc2Ugbm90IHRvIGRvIA0Kc29tZXRoaW5nIGxpa2UgdGhp
cyBhZ2Fpbi4NCg0KQW5kIEkgdXJnZSBldmVyeW9uZSB3aG8gYWdyZWVzIHRoYXQgdGhpcyBp
cyB1bnJlYXNvbmFibGUgdG8gcmVwbHkgdG8gDQoiW1BBVENIXSBSZXZlcnQgIk1BSU5UQUlO
RVJTOiBSZW1vdmUgc29tZSBlbnRyaWVzIGR1ZSB0byB2YXJpb3VzIA0KY29tcGxpYW5jZSBy
ZXF1aXJlbWVudHMuIiB3aXRoIHRoZWlyIG93biAiUmV2aWV3ZWQtYnkiLg0KDQpSZW1lbWJl
cjogV2hhdCBzZXRzIGh1bWFucyBhcGFydCBmcm9tIGFuaW1hbHMgaXMgb3VyIHVuZHlpbmcg
c3Bpcml0IG9mIA0KcmVzaXN0YW5jZS4gV2UgY2Fubm90IGJlIGRvbWVzdGljYXRlZCBvciB0
YW1lZCBieSBvdGhlcnMuDQoNCkZpbmFsbHksIEknZCBsaWtlIHRvIHNoYXJlIGEgcXVvdGUg
ZnJvbSBOb3JzZSBteXRob2xvZ3k6IE9ubHkgd2FycmlvcnMgDQp3aG8gZGllIGluIGJhdHRs
ZSBhcmUgd29ydGh5IG9mIGVudGVyaW5nIFZhbGhhbGxhLg0KDQotLSANCldhbmdZdWxpDQo=

--------------scTKQpIAgv93yoqxUNnHojEI
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------scTKQpIAgv93yoqxUNnHojEI--

--------------JzXTUjOcl4RCqRode5kxglom--

--------------r97sG9xHlL94zbsyZpdQWneg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZxjECQUDAAAAAAAKCRDF2h8wRvQL7kjt
APwI7fd1226UgOd7cRVAf8ZOTwbN8jQ1fJQ8MgqEad3U9wD9EIMXUDfMpotDS9T8MXgx3FH68pyV
elWfHTzpUpxMGw4=
=Mkes
-----END PGP SIGNATURE-----

--------------r97sG9xHlL94zbsyZpdQWneg--

