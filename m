Return-Path: <dmaengine+bounces-8501-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBGiEQBPd2n0dwEAu9opvQ
	(envelope-from <dmaengine+bounces-8501-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:24:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0B879BB
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE3AC3027B6C
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30DE33290E;
	Mon, 26 Jan 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iDXqxZ7M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764E3314CB;
	Mon, 26 Jan 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426570; cv=none; b=is0kbqGUgi/kfCJhB+jQtkJXP++Eot53Tm/h0fDZFtv2hhf/mJL7rBft5Szt5yU2i4zlVMHc5Sd4krP0myZydYOUGFJVAYxbPB0ya/YClgC4WFZiemGhpcq+Q5pN1V7zTvg5Qj1IXFp7U5VxwWJAhQmVEwhAOCOvJh65uYK3x1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426570; c=relaxed/simple;
	bh=wYIe4wIA/pPmJ9tDeaxqP2zxlNKsuUr1m76MhtHhp8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=b6OlB5P5XsDtLsecjm9pQVyf9DWZnP6QPl54yDhPlDRkdXEyodCWL6mcR7YlEUn/wFNUzVsmg4vCCF2EU4FRiu7f3bpCV18NNtkJzJxZhEo0MF2jUHHPkiUgbzRQANfWZho6tJOWb7wKT/pbfKs64yqOuYrimQ8ALgbaNIFzso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iDXqxZ7M; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769426558; x=1770031358; i=markus.elfring@web.de;
	bh=wYIe4wIA/pPmJ9tDeaxqP2zxlNKsuUr1m76MhtHhp8c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iDXqxZ7M/vFhKMyxfd4xfWMXsibmiZzKa5gRy2lG+UT2W/Xm0yABgjSfXI0o68u+
	 7KED+EVtxMFNLSmCniXuDFTP8nmtxf9APbUY+UYSY96nzLyZg+bsXEsCxNfVpynAR
	 FNI6QTf/fWgdRJpIBpXbYU1hDrl4J/f2b+i0UM23sexoFB19ivpdqv3jebQpxY5ch
	 nZGr9oDX5S2S7hV1JYFXscKder3H0q2ncN1+33U9NaN3u3fryGKciLliQppopxCWX
	 TRBTokFFY6SaDuWzI2/d7CgH2fOh96KwF49OHSFTEf4KhyEIKXjYUBIAusopDzZSR
	 BWII5LLmraZ45gCz4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.253]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1vyhl346zU-011wf4; Mon, 26
 Jan 2026 12:22:38 +0100
Message-ID: <118afb07-2dd4-457d-a3fc-d89c93473dbe@web.de>
Date: Mon, 26 Jan 2026 12:22:36 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] dmaengine: dw-axi-dmac: Remove not useful void
 return function statements
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260126103652.5033-1-karom.9560@gmail.com>
 <20260126103652.5033-4-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20260126103652.5033-4-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Ob1JTiRQXvzixwRSxlTReFrv9HwJlV1D6nXP2zxZ14pzXDMO0f
 cCirB3VL7vHJ+ojSb79owNl2VmKAW0zy1y+fI4Lre7yQCKm9o3u1S+08VBXV5APHLAueV4g
 kG3Gd5gHkuFRqfrErDPnlugOglSiSgYKLEdKMXYcbwAIopwaua0Lxa9ZZOweNHvI3Sx/1n0
 ldd33OQ0M7ORSvuuLFiOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KekWmWcrWWY=;NUcjlT5fAEh5efXl+jYiefkuYVS
 GVhNQTh6ruMflZIqDQPvDUhauOVfG3GV9zZLXVhP4pJ2pGlpwGQTeLt6+KyEWyuf/CEGMFkRP
 bhuJHLrHAaouIbimXXXVciyeAQG8tZwjw3qF+a3TsgeuGhTpMOczReCX671a8X0ryQJ9apA5H
 ldm4D0iH0YBubBHUWFM04fjneZB3PR4Jcy9ymkEZ+l6n37syMuO9mYVnPNztBuIj2cRf52iCq
 Wgd1rXHvRSePstqPRIhCKzsdqbCVISPs1heIw1hXS8+5zVPDTEkQ0PLtzNJ9EQ5QvCtWT4n/+
 ma2ju+eRtqbySFl1on4VcRxpaP7rxfxNdeSunbhs2WyTQhTV0HcW4oD4zGiFxjxAaGHjNN01n
 m7bChvRD0zGotlmKBKDOthyrLYJgfkPZGmb8vokAhe2xskbWZBhA3hFe5oO8/Wsxf7d6fnmCK
 tmR9OlB2k48pZXYUsY775vAhcTePR9aVdBDhOwkTJPLcfuXvgLhP4uMhTX6Rk797HRHZ++G5T
 3Tg1Zfi4iXviz1uB6y7W7DfAMS9/nEf6+5jd3agYbJg1kwC3EqNZPD2rCcf2QjNattCmrvtcY
 dBZKx+g+lW10rBCVYkw5JLZgz0NVkH+d9PIuKGLJ2DE+E3SgnTq232RXRk+pmo4K6mnsIEJST
 LCV6wNpMdE+PyP5jlE1VKzvi6g6agrwmCB/cIBUvr3iN8Zs8+7VNF/srVsXdYIZCyZFBNSXMp
 Ja+OEKBV8GJpmWwU0blsuPO/14gbJVUoSCn3VsON7MA4yxD/3xtghWoW6ZjDGvKxTDrhCYidP
 kBB7LqOX92PZzva0Vw6jHpXRYDi2hFGhq4H2vlCdYwoQyldx0nvn22+VL25gcdYu2ENk5WfJI
 w0KbXwvt7dDBEll4acRZIjttWLMQx+n3b80GV8QqelYtChVTP6A0GS8EKE37usblMJb+0dz1W
 u3RluH5s82S5eF0BNyvUWhnoTAAP+iKOsnQSIWl2JIk1vrQlnmAzzxFUb8TJrrBSUKtF0ORkO
 HPqoumXBfk2UJXAFD/I9LjdP6DNSrYTvtZHA/oWfKFEydzWXu0Vx9dkL2evYvWfIL55wCZKP7
 klzOJ7P47IRbIGnxN2DAqUa000397shVWtBvO0VVp3p7qPtP2vfDXZBpa6zrTF6e26ToUwQp8
 +Du43tKmajuttR37ixG8oVxJlzpECyFEs70WFQt8J+50n+Jk5tf9hJZUVHDMJbXVs1j6qDxNC
 QdrdwfqZNvVaOcV2K/qJNSYpMkqJwZ13CXTcShweFH8Fwb4HI8YdgBDiOfCXkYCUuHrGlzZTQ
 uGqixUQHgrUpLvoT3blnG14R5vCR4xiQ5pOm6YhXVl/RbmFt/bba70Bo+9cVxEdhtHIJ2loSa
 Uecmuf410Ad4pm7F/kbQlS99OwKA7qM/m4h4UDuE02ouQwnr0KFPneE9VIwKSdIsBArk749M1
 bfrVtmPP31uaJYKYaDGGjrHJqnrZOzXsG2gW+2Ede1+k0mshTU/8T6iGZk+XUpTY0SMl8m3Y5
 h2opuLwpc83G2unqbQYZvi0JvzoETkn0mCM7UJgNdmhtUxCrfpyvzGRF5jMdoMnif9ik+7zZN
 IVzeIOoH+5aUtKR4N9GgN5Pwy5ubAnNkXaH/IVp8WWktaQyV5UImfhjj18p4LJplxHL0PN4RF
 GF710tGet1MkCHOyloqgXgU56Yj4qExzHp+gE/OBPV/TXLDKBdr0EG2908GTWHO0cCj1GyQG5
 xXiIkJ2lVSzFhKD19eBzQr/+/y/ftqZG3FZW46IjH7kTv79hmErg8v9ImkOOpmXEXU+aBDPf8
 mLXmjnhuytmuZO+CxpmpAdluafBcwwEfdxdLO/ZG1wjUxigE34jT26u+qYcJfY08Lg1Ggsl7T
 gPHzMTKzSpUH6YQzm9YEJ//0NS2R/pg70911i+bJF5d19LdyKYVE56D38K21UNWochS79fZ/k
 koB5NtZVKyxbS8MvqjDcVCshO1fsBPKNGcK80ROsGde2hrb56E/6iOHsA2h1hlWqukf2f96Ys
 JjyXnosq6ChgAggxDKfR3fwbcQOrevbEeNZwgOJwXWP+7Gkg5OlzPWSWJFiYXuKq20egULF16
 wMjW+HPGVMPLdp1V8TldBthLycWeg9JO/USOiA8hA4fAs011DkkfuRQ3DlSvgHpTISNT0hOpp
 s0C+Ucd36IySnIa68qG0Odw1CdlGAJEPbcPeZFQB1yFErEbV3zMz2bt0rfHv0uWhAe8CNDMRj
 sGFoqycdfRVm2TdP+03ZfSVrTQszZ0xz/tLRNKJ8WXgNk+zXZBII+7ysDADyu7aoKW/RSDKjT
 3P08lAnpKWszvyJ3wIymay1kMR4yj1w0lYry6zdRgOZiJUjbNf2xK8jjqMclCCD0vRZAbnfVU
 BTlTGja0TZynYeAh0Dqw1zl9m253LS0iK6kaVTVg1n+KfZN7Hokh6wk96sQE0M3bMHMFoO+sX
 73fkDh/aNDyK4bbbqXgni1dSFJgoLbw3bfplsaNYNgbksuOPsdLw0wrloPRm4pN9wT/F0SxOR
 vR4UgjUrAUt2U2eMFeSilN4i3csDckwfupUR8YvOrihEkKVfnzVgmjd/3+npMCSRXCDtb7Q+5
 3U7aTaCJZ9+3XUaue1aDhMCt8xvv39eTBCjKEdeGQ7UIhE+Y0V6lQ0fbYMS1xOkmMxuoefing
 fqQFpVaQPvYukqxYFI9C8dgQkwuIMsFArrJktNfrG4HO1wCLynhHJpDgYisgwW8IIGGsJ1OT0
 2AgbdbsvKJFTeOdD4dQipGEJeJhlzEVT/8xRuA5VCuC7PUcbnTysFNG9C6oYDJdZJ/q2RznOK
 ELxvw2bINuEBfonWcegIHSLUDHeFOmENERPzCN01adfX15Y4HPExhvGB0PBMoCTq64/Qhk+go
 gzsk0AVEydBRmPzb7/NnW+4zrt+qXwtZZSIIni2Xw907MyFZLA3tunCvEVkibUGk5WgEFZMn5
 +Lu4ZnNeYf+NuEKtq5y5H7JdpXlh1G35PXt7kqR13WuBxHSvBipbJ2AK/0l4JmpplOL+JETdp
 Ynt153NfIp6iKgwrTHhFFkoJUi6w6soORSIIx7k/BUaQdHAUtjnYw0Ob99U9xhGIkriUEDXKP
 muZ76YtfHBqv9Rz71tQvNtHHZ47dIbBzKvM825JLhqzLPwYmqCrWyGHrhf6N6veI93MqsoHHK
 J+3xhJZDHOxB5/LIgCg1ApXLfWe8KrSDFmlx23ymfOWFkIuxFX9o1gFRtocW+RRAlzQLjVKwk
 GieoJpiVVNl5QXlw1b9saXUy0wYdZg6/PfZ0E/VDhJRLsGgzv5jejIrJQOMgPLFnFXZD5dSL7
 +J3P5zaWGZgqYTjx0xRTPW2q3Q/44mZ5JRsRvdUn9hIIrJwB7EJSXH3g/xPydzhnt+bNTlQSI
 E0SxtNj3cqXg2rZZrO+QimoEStKcXqI+HH7DDpOD82KAObNltMKsf/5aIgWCPMo+lEHj1fYvM
 ZskjszN0xPz1fxS2vqm5EVKVyjW+GELbtVrSrPLERvvpBbvwtQ6Kfe2YhurQUIFLjiWzKaugg
 5Zm1z5vdqx33HaB8Q7PZzRlIe2VPjcZhBDZaJkxAAwC2v1s6euf3S8Mtq4YS6xrq2WofdBPZ4
 65eplFkyAQ7LjJKIrFm4PUOrPFzpQuOfVsnMZl0F/wAe5Qe1kaz47rFl8ygCU9JjyDXrRyEXE
 DaD22CxWzSfBE14nGxWd2XFnwf+LMDdOo6aEPiYv8hUNFyc3QP4GtkrbL/Kv7wskkPJ1PTU7w
 XeGF4A6aiD7VGMkYRa3IWoodqsYNwvDBXVzlnwDZfy/VvLoatNm4uVme03SWSEjU/woTvHRRC
 jMF+pz/cL+eStUSOtSt1l559crWt9KdPdmSbBUGRJG0jd0tFrgYktpFvYn3qm910WLf3P7RrU
 tU7vKhZzc+VXMlhvFjnlb7i8zScYFm0C1dasIN3RH3MB+ymwlM+MtCcE3pMMdiVF+uQPFibXQ
 EYAOb+YFQsIvgJkgteOrobOe5j+557NFODieV80R2akSoIuHMfmSlAjGreZWtPmWRDIDNyTu/
 ucRd15hUeHFHSVeycfJG0EN3SuEULDUwv07Z3SfOI5x5iXauOG2eAFrbsFnRI9vWWE+2SBZQ0
 jym6faYGfpDPamD9bsl669GXlm9OxkSBI2Zw0LPR4PQoRQvqV/VmrInOP6VBj/LeJurP4jVql
 Ki3v8X1QHQ0OGlbmHIdBv/x6qs4KicDwRp7ybbiWjjAiKT7EgVk035+t3geSyu1XgCFw6Ocze
 /cOSBeW9v7d1uoWWwyzfLhy2Bq06rAi2Q0VDwS5iByXm7jct98n4GxzPxyP1iCRv4/o9TLrGu
 8sXveus43dD+l+CqCBvxRzVGMAeKfiUvaqyb7/GmhIZVxAyJVBryrSVbCrI0RLKFGd3E4X5es
 VzYGtkI+UOUkL00QsqnT9tkKpsPRVs70iknu5HzRikm1WJTy25cGmEeWil44d80xoqwuZMzPA
 ZWfpcvtacgSjIsE94HMV0o1UaMfBW8TAf5FiXNp+07Dzh0kmiE3lMtJJUeFJrvBBTeeTYHlRi
 8ty6HtessMwREG6vUOI5OX3n4903dj6Vbyu9jif7MT+NXC71C8qXh09UvN3Rn5p05hk93OOqy
 5BViMtCREAiQ4aE/RLKjOCeK9XJtcztXwlOnNSvrPOsVdHPtSSKODxL6osT7T5KrMg/9rgEvp
 QJmhvM/UstJVgjlR3tbVpxVM904KmFk4O6w8zZQo4eI4K+IBzarKrFNB/toReP+Sa4ACf+j/O
 Qnxi6VvFWMNtnQTBrVrU+/pdtGQ2vYdrCZdaPU4jDagxR1dh8HPhL7WlNA3exgucBUTQGa1tM
 YK7v7N+Dhvp9aeB891WQrmWc8oFTjdtE9LpFKvsoHc+bT90aCSrgiubO33k/j+gffbnuAmKob
 NMf+HAPCjJtXiDw7I9xYD+DXhFlxXIeYZx1FFKGeytXIsvRKKuNyLUS/cOhiHgJf60/xT7inT
 RkWEx7wieUGlRqHqCOLlzwIIBMJQ6F8ZgUVtKFF8Yy6a53N24m2Qo483FFk+/nAtpt68PYXX+
 0ysfQAPi3Z56hurtTxl0YEoegqclw0OpviLtWfbXNGO2f4Jja7dMStwH9cKZEud2m6k9g5lsY
 QoKQHN2qt5iZT6CNoe/B38W2cSHz6b71Gid1a6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8501-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,synopsys.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 92B0B879BB
X-Rspamd-Action: no action

> Remove an unnecessary `return` statement from a

Would such information be also appropriate for a summary phrase?


=E2=80=A6
> semantic. This unnecessary return were detected with the help of the
> checkpatch.pl analysis tool with --strict --file option.

How do you think about to mention a =E2=80=9Cwarning=E2=80=9D better in th=
e change description?

Would it be nicer to put such a hint into another paragraph?

Regards,
Markus

