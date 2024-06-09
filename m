Return-Path: <dmaengine+bounces-2328-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF1F90172A
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EFE1C2094C
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315994655F;
	Sun,  9 Jun 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jLMYUMld"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65BE4C62B;
	Sun,  9 Jun 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717953667; cv=none; b=pSd+95aSLyFtJiOaImid/vlkVszxwgEN6vJOlpiVIEl/Jb7KEi0FXiGWzGVG4/a8TOCh2A9ZrQcdPLaF70tlQoOESaKHm0iqJ577JWq3qtUMvrAATsxiAEN/Re8g44IAow28HdDOHpwT9eedsfOOUnA4O6A6rQXGEYaP8SadcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717953667; c=relaxed/simple;
	bh=Zs1W8pC83XX1hDj1WyEV0AXwD52Awo2YD1YE0xZh4UM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=K5qbwzTEIrahzZaQphakNyMWvLTvK06RrtYm/3vkaqH2rBzQZwM93ULREe0xCOx5P0mm4vSzOYY9gH1Rvx0eflyXSgRNYNi2IHbaLGnE28MJCePSqxrDeBeaUDlk3RM/gO61rBwMPM0PUXDyZ2pCcHH9W3nwq1qLa6HuEeozWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jLMYUMld; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717953650; x=1718558450; i=markus.elfring@web.de;
	bh=b4jf5lDj9legoz2GCZlODnFd4cAUlAidXLo/q9mPb/w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jLMYUMldrihjj/bnAzszgj2SnLjP3apqvdXj1JjqXcSqKJwzeaoZ7KYHCT60QbKB
	 eDAaomgZKII2CnR6b2vGfA1aYNsuPYeOmfOPdXBS7+o+MlobSmeVOCsmbVzK8wINc
	 KM1WzaMfVHAblGYXiymtNfbyTuT1R+D7aZBxh4s7DX5nrItCVjL+aqCZW29CIJO1t
	 dD573IGHuS+cuhEbEFdcX2q4ty69VG2wxerpwPwqLJUYSk0rDrltt3AQ/2vfr/Xr1
	 zq/vddyq0TCa9lC1v5Lwif43t3ufBx/ALXqtsRgwr1VkUM3McRGZ+EOko5ib/Pqae
	 SrXA+YsU0GP5UUbQ1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1sOdtb0fgH-00t4pM; Sun, 09
 Jun 2024 19:20:50 +0200
Message-ID: <0e439d73-aff5-4d56-9a3c-b29867132db1@web.de>
Date: Sun, 9 Jun 2024 19:20:49 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
 dmaengine@vger.kernel.org, Stefan Roese <sr@denx.de>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eric Schwarz <eas@sw-optimization.com>
References: <20240608213216.25087-2-olivierdautricourt@gmail.com>
Subject: Re: [PATCH v2 2/3] dmaengine: altera-msgdma: cleanup after completing
 all descriptors
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240608213216.25087-2-olivierdautricourt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:te0zbBEFbcvuffv4IYrun6KWo0i0bkiQe6hOs6HZKvcel58CIHD
 Hj4k/c/KZmxwQOBVbym9XAkiYbzBjqJqxj3XzqTpMTbJWXnEkkk9D9sClpKaL62GBMZuUTG
 D7G/sn25W3cyqkJVZKkVtWhbIB84g+K1oOX+yuULaERx2BHBCp3IE2BNTLEr6y5zdMK2Awn
 dBCrBjcWzEMa66jkJRtFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XHO2VXyCijQ=;+c1+GZAFfFDrt40CmF4XbfgW8K7
 yFFK9uB+m7yA5H2E9sJvFhR9HSRjmw2HqXizcWHDL7PcNakVjlplu8cHSAax7jMiMVST6z+dA
 Q7xNB4ebOwFeIT5Z4Kh7eaEI69PFaTTO2rXnY1fREA0p/cQXR+T9gjv+GAJjXfbOEmur//eWa
 ndt3RFAV3Uh5F1jBtUqqlZZwKTqtxbgZiA6dXe9zmSQDV0DwzLGaQWYQW8SRj9egiXR1PFPBM
 yvjKg+HhedT0v2JObiGUxTXSb5VBdxprazcKVbcbWPdIPpnxaDH3dCjoT7NsD0MRdmgXLnmQO
 pmm3X0XNcThSTKl32ugGo1rlAjADqEmwHX/ZjEoYvD9lRFoja2HEkupJzRmerj7ZmPOaLVZ7J
 hTL6TJeDcL+OMjyoXP5jea1PlB/PWDHjIrLKAkKyx/opNab7jEa6BMKIDCeHzgE+tEFhY2R2G
 53/BXFPfiXDU4YiNmoRVmvqmgrkmuqJLeP7NyO3DFuF6low/blvEZPkFErDXjqGaSSZCbifgf
 38Fa9EtluFhIBj5fyFsYxP1RI0wLpBb8piP1ENB2qoZztKJPbzCizqaHukJF6dSnQF5Qd3Y9m
 N7IUmmpNTZaX9tIpOR5PGq0so98niVFj+FS4khquxNCh3QGnm/9LazzGDPnBwT0nS80skBYtN
 HCyltxF+NH9tRK7+n40eskXtXD4NFr9QLD9OxfjzNW03JLX0jh2J9TkNWHgApcuIgayMQbWTG
 Ir36Ws4vTQ5UNiwNwTvFtvvjcFkys6iL1QtTG94gB9ih2xg7Y1bWzFzOJSjhSDes4kGh3dv49
 xWGcV3xHXZm4rooISoTZW7Zie67F6bAUlZmxIMMBTy0Fk=

=E2=80=A6
> This fixes a Sparse warning because we first take the lock in
> msgdma_tasklet.
=E2=80=A6

Can the tag =E2=80=9CFixes=E2=80=9D become relevant for the proposed chang=
e?


=E2=80=A6
> +++ b/drivers/dma/altera-msgdma.c
> @@ -585,6 +585,8 @@ static void msgdma_chan_desc_cleanup(struct msgdma_d=
evice *mdev)
>  	struct msgdma_sw_desc *desc, *next;
>  	unsigned long irqflags;
>
> +	spin_lock_irqsave(&mdev->lock, irqflags);
> +
>  	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
>  		struct dmaengine_desc_callback cb;
>
> @@ -600,6 +602,8 @@ static void msgdma_chan_desc_cleanup(struct msgdma_d=
evice *mdev)
>  		/* Run any dependencies, then free the descriptor */
>  		msgdma_free_descriptor(mdev, desc);
>  	}
> +
> +	spin_unlock_irqrestore(&mdev->lock, irqflags);
>  }
=E2=80=A6

Would you become interested to apply the guard =E2=80=9Cspinlock_irqsave=
=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc2/source/include/linux/spinlock.h=
#L574

Regards,
Markus

