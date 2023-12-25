Return-Path: <dmaengine+bounces-656-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53481DFA9
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 11:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF5B1F21EE5
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E722E401;
	Mon, 25 Dec 2023 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AqR1cWYt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D41D683;
	Mon, 25 Dec 2023 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499511; x=1704104311; i=markus.elfring@web.de;
	bh=HUXBB4x97jqAAp/XJdLxZnTbCwGahqmDUfoq0o7TY0Y=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=AqR1cWYtd7+eKcVdEjj1jDRU90bU3sIoJYTdsYIuRUHa05DCoczn9hKRkw35Sd9n
	 aV8azjz4esk7zxbfKkfzLsweIPy6Qph8ZtGvVNZhTjtB1r15Dczg9C60qNG1V+51Y
	 POG+U6YcjzhEOVyzx3BebImbfBjg6JfGuBOvdWmZ8j6sfbyEZz477gA1v1DB8dMLe
	 7r5cfIdT4rGRWcrbW2vwYkTeeAUoZaQx79m80HJXbeIkVuNmazK8UakCL0xuyZSb7
	 XOIpdxXRmdBYAQU4VRnVWl+vtbKytqFtpvpDYaAF31y5C0OorWpuZzDgOhRzSHcvg
	 wWuzCg6+vbxJVBSnEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2ggd-1rGt5s2LFf-0040rC; Mon, 25
 Dec 2023 11:18:31 +0100
Message-ID: <4b7b5eed-d00e-43ea-afb6-1f563fb2577c@web.de>
Date: Mon, 25 Dec 2023 11:18:30 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] dmaengine: timb_dma: Return directly after a failed
 kzalloc() in td_alloc_init_desc()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
In-Reply-To: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kzWqifzdC9upknspVDEsGqa/iK/LiQ+tcH1RpaEvLdJZMpNhh8m
 Ys3H+MVK7Ztd9cpyz3ZRXbetOfAcRVo9gGT610atXbS+5HOqpzQGP5DnFvMwwD5u6hGRd43
 cJWIpvazYhfCVaSo0wYwQVMyf6y5Vj7iFNG1UxATRmzUMKUKQBIRgr+/uUh3IyJEk54a6fr
 UouIH+E8jv+jvI/c31o3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5WXMyCpU9ac=;VbG3CJm/62DrSyXNdzthHO8TcpT
 1/uF+efGVkVTZz2xgTh5sY0R6uotfXQmiFkdOgVyajsiF+N+eIpvGq+NM0Oblg5N42D3JPXJw
 G8qveNjhgONtQUfwxRGkj3FoxPFP0IcY/9DKhwTZnVZm6TF5RS6K/rzKLdhJE8gjq2zPiYnUV
 Hsp/D31XyTekbDwyLI2/PpiIfadDn8h78MJeM/6H8fhF0l1ZPEuJjgZ37J9nDPOlIWnIFKOXV
 1jz2dbJgkHOKlpIYC0Yclg5rBAMb2RF+td8Q55B32MP6vaVdmsciELyDPmOPapizkp6My3xeS
 MhaRjvCPIx8UJV6iX1wx7V3VQ6CbSNKHo5HL4WaIUAlMprgkMwKBSsV6QIiW75gqEggWma/xE
 HuSewG2EsF5XXtL4hgefQUp0VZTAlYjZ2SjGKlYfnBMapMVeMXd28mktGq84vXoeXTXTE1hmk
 6zNVaEQFiRjBNP+0/ROnI0RZcukdBO7MGDFNaUXuWFwHFXGcUv2crddDd0XHifljTLhp8mA9p
 vu2pp7tcSHbX11EpkQ9ELuQ26wiApMbj3uwJyWd6vpyjqakbgjnrCM6zS1Umw+6Q0NIVRne9y
 gDJGsC/javSUel4AmlNnnuV+Kdhd25qiluARVGS+zw46nLWEyfrxsFFwalmR/SIayFLv1l5Bi
 bYy02+KYi6oQOCaWLcsbPJpUusCn7jMyvBaxA65kvsqLqxb1wYcMeT/xstXng3HbW36iYWotn
 kkIa8miKrk0X4LfSPnYnTeqqfOQFyHZwlNLj2ba1vyYhju5BpBtrjfeZ4u7C7dcvhJlvJMAJR
 sTdY6TNNnxbMl7gbYnNZnzfH4OC8f14PLMpY7WtkEIUkMqTQOtnlZnn67bjwD1357BNZw0CrN
 71IWRzpxX1Y/jm7kBI9vwbSwH8sFKO6ehNJr2kSvnsILHmFsKAD0z4ODF6SRyaKZp06UA4wo/
 vAVJ9Q==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 10:40:12 +0100

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning.

2. Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with th=
is refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/timb_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 7410025605e0..abcab0b1ad3b 100644
=2D-- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -327,7 +327,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)

 	td_desc =3D kzalloc(sizeof(struct timb_dma_desc), GFP_KERNEL);
 	if (!td_desc)
-		goto out;
+		return NULL;

 	td_desc->desc_list_len =3D td_chan->desc_elems * TIMB_DMA_DESC_SIZE;

@@ -352,7 +352,6 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)
 err:
 	kfree(td_desc->desc_list);
 	kfree(td_desc);
-out:
 	return NULL;

 }
=2D-
2.43.0


