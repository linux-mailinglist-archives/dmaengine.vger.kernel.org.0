Return-Path: <dmaengine+bounces-7744-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2ACC6C08
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 10:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19B5E301A9F3
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9633FE35;
	Wed, 17 Dec 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bKwcow/G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AC33FE20
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962316; cv=none; b=eG1cfNXLT5woSe5cYdsGZx26dURYqDXABxgXb3jsRz8rdMimCGraMrk82Tek5pubbiR34SnIJ0eEXOHepGVKLjkiYYZcy/bNhZwFh+tj/R0uvvjhHiK7LkeJ9mwjSdr4NEDF4hozjBQ223S68SNeyDV9jY90j8Wl5HLEovuv/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962316; c=relaxed/simple;
	bh=GHbESA3QlV3haQkQOJZ8bZoHaa5uRTi8+BzXSTQsGjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PBqq4LKPSJiFiJmXse9OeIqIFiw7sBygb8Kj93ZXeOq80deFJ5Ri5Y2PEEyedJnidSCQffv6IuVVG5wlpf3sFyFJv9e9OcAzKNj803JHgH9tKeWoRu6nvxMGMc/5SP/m70yc0KM0OqlNBBI4Bh/Uo7Z6ljNj9hbXgyQiL6j8/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bKwcow/G; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7EF361A2220;
	Wed, 17 Dec 2025 09:05:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 519596072F;
	Wed, 17 Dec 2025 09:05:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12B4F1195037F;
	Wed, 17 Dec 2025 10:05:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765962308; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GHbESA3QlV3haQkQOJZ8bZoHaa5uRTi8+BzXSTQsGjA=;
	b=bKwcow/G81HEIlux3eTJybrhghyIqgaCcr2jgNjxkKuF4KTI1HNgwBFjGq1PKp2wzZLwLm
	7tX1k1w8lCjRquaRmpAtqbKCnbb0PFq/EgEVKllVzztsvBxpAi5GGEHRUNXOiSZ6d+74YV
	PUPJioNzDFh/0fDXGnaHuOk8BBJGSIYBXqRvO4vahksFUIJYxM9yVy8C6Cxi9YN8qiaZ5D
	azIGb2tPKmY04I4lDH1tGPZI9oVgwpxdsC/1CAyt1OKAJ6XB4OFk33h3q8PY08QrGDd389
	obJbZtAOljVIoQho84kqkJG4zPnzoNty6b3tSCiPUujLssEd3/HGeRjhKN2JiQ==
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
In-Reply-To: <f1948d54-2e27-44ca-8509-ca16f9b792fd@kernel.org> (Dinh Nguyen's
	message of "Tue, 16 Dec 2025 21:22:09 -0600")
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
	<e1aae851-4031-4b5c-a807-7a61ecfe6af1@kernel.org>
	<877bumsv3q.fsf@bootlin.com>
	<f1948d54-2e27-44ca-8509-ca16f9b792fd@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 17 Dec 2025 10:05:02 +0100
Message-ID: <871pktscld.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Dinh,

>>> Applied!
>> Have you applied all 3 patches? If yes, where? It happened during the
>> merge window but I see nothing in v6.19-rc1. I was about to take the mtd
>> binding patch, but if you took it already that's fine, I'll mark this
>> series as already applied.
>>=20
>
> Yes, I took all 3 and staging it in my tree for v6.20.

Noted. If you happen to rebase your own tree you can add my

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

on the mtd binding patch. Otherwise, well, too late.

Thanks!
Miqu=C3=A8l

