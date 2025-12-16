Return-Path: <dmaengine+bounces-7647-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26ECC1975
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E645303B64A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F81534B1A3;
	Tue, 16 Dec 2025 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="raQjYvy5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578C3446CF;
	Tue, 16 Dec 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872787; cv=none; b=g1catiRSKNAPvNmgd/K+2ExytljD6pQ43bEywXBVj5EqG2STNFFO6LTvU33yojVFIr712o1gyiklJ222lfMRhWGZlcwLeITsmuvzp/yVvYAl1HHP7hZSzRnfXBdEfSDCgcLgmhiNbzFFwvqT5Ih2WorvIpzGBJKTrDeB96Uk7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872787; c=relaxed/simple;
	bh=U31Std80+hAqNaEEA7XIqhz+Jgwt8jOJjCv994SGRc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hjzIcGeTswrIEME/ONx8yn6oX8SdHeViSZOeIPAlL68P90os+IN7f6wEF/L1Lpn1dJ2jq6YUzYTbSdHb5xQJC3Sv+y627a/y7MD8S5qwMVaxL1V4dQ0ttcCz9BaKIG/lHFTYBEfwcHZg7mRQhUa7dktLvF4E+b6Sfq+at7TM9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=raQjYvy5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6A7544E41C1D;
	Tue, 16 Dec 2025 08:13:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C6FB6071C;
	Tue, 16 Dec 2025 08:13:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B01FD11942FC6;
	Tue, 16 Dec 2025 09:12:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765872782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JS1bp9q60tJiFItdPRAoiXuaPpXIH1pa1HICS/H8bUA=;
	b=raQjYvy53gwIQeiS5Wd+n2/uEO1J/BSlmgAkiDDnXGjbT6Dv/Uafg4DvoJax4X2XSHJVvh
	23d+pUM4UONdYJ44TL7evqyYgc4+7yrEZL1ftIAGjqdWicFI9QfEfCpYCy1AMNmO2trjku
	gCuF77hevou9PUv8B7Nq7V3xcPtrqlkA+MxylYYajGbh7c7Y8DlwumRsPInLESpTL5jmw7
	vtX80/+CHfYkuolMu7JedClVt5bPbpyDSsOW0ED9+XaDjV8kqxfbSe1U8N71d39i9jrtWm
	mNn5v3xwQaOedwT0Zf6N97D+SzPhb1nHRJZ8w+5btFGfRuKJPXonc5v1pOHFZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Eugeniy Paltsev
 <Eugeniy.Paltsev@synopsys.com>,  Vinod Koul <vkoul@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
  dmaengine@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add dma-coherent property
In-Reply-To: <e1aae851-4031-4b5c-a807-7a61ecfe6af1@kernel.org> (Dinh Nguyen's
	message of "Mon, 8 Dec 2025 20:31:58 -0600")
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
	<e1aae851-4031-4b5c-a807-7a61ecfe6af1@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 16 Dec 2025 09:12:57 +0100
Message-ID: <877bumsv3q.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> Khairul Anuar Romli (3):
>>    dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent property
>>    dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
>>    arm64: dts: socfpga: agilex5: Add dma-coherent property
>>   Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
>>   Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml      | 2 ++
>>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi              | 3 +++
>>   3 files changed, 7 insertions(+)
>>=20
>
> Applied!

Have you applied all 3 patches? If yes, where? It happened during the
merge window but I see nothing in v6.19-rc1. I was about to take the mtd
binding patch, but if you took it already that's fine, I'll mark this
series as already applied.

Thanks,
Miqu=C3=A8l

