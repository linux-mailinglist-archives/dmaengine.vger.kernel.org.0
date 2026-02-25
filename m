Return-Path: <dmaengine+bounces-9120-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jWLJGOGOn2kicwQAu9opvQ
	(envelope-from <dmaengine+bounces-9120-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 01:08:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91419F488
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 01:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8977130095E7
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA601D6AA;
	Thu, 26 Feb 2026 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwAv5b0L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDED18C2C
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064476; cv=none; b=Kfzdl5q/BAfyMINlHLLq+IJu3ExL677X9aAIlRC4UVVyX+84DXahWhrAdSaJeyebP+FosdcPbfE0+J9W4ZO1mJwqLXsrypeSQlOkW99/MtHWs5Dm2LCb16zTwwwMWeWiATPs8nXJ8Sutx+u4RMUrAbOIGeE4Zcu7GpDOHEkI6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064476; c=relaxed/simple;
	bh=bPNWxJ0PsKswuNugUux6ENRUt7NN3n0Zwy2e/5d8BA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlU1nXK8fiBSsvd+OilXmeqFZIPotvf6JxYlVPygMMZhN9WKhmJHr6M/yHYgXb+eLlqbGQrswR2KhrIBz1RSNrLxeq0k/wgmtLnVJBoFt3xQl4V1MxXj6DRTLjMnjpey4JcXn1GF781aDbJZ9xyeh1zB7gO63CFri5neAHT93uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwAv5b0L; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5f5418c40daso1322039137.0
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 16:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772064474; x=1772669274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vrInnbX0KCc1ynABnNky7B7FYswXUG4HFiI8RLfvys=;
        b=cwAv5b0LHn/ODNtrZvLEf1NP7ehKxwLl79G6yZ6weO0V8ZjMocA2/uKcc/9AhRassS
         fs0WR0EIAvtqKUETA7nnO7utfR2Db+80FL972txfWEOFEP4GJycVad/0c1krzZt9+sfC
         y8vXI7Sx05quEPfmADq5j6xJGfJQQ2w01vqaDrlrB3G/5lIiMMCxTdqWHX7Npmii1dT1
         G5XDJriPaWIV6DoNCd/LTRi2zfTTUrP/EIA0Z2d+a6Z6lt1UbkfamQuvOpvc5QYjmiVa
         pB9pp9miFSy3UlUivqb6CPEHWd6I0e1GqYntl2K2QIh8pn9WKtScv/66JQtSjtR7utCx
         TaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772064474; x=1772669274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+vrInnbX0KCc1ynABnNky7B7FYswXUG4HFiI8RLfvys=;
        b=KPjDjSWXIOt6LL85Z0lkTeZPZOAbi5ZXobeg7A20r4gNmyde3UIYy3ICVtejLrsj8f
         xh0QT2tIRFDt3pcOrWMqbnzq1Iw51Jo9NVcvouUUX/zKapPLMTtcfQH++d5L8WIeK+lx
         74fwBYHi3u6Kl5TebhL9R6jE/z/G6OzU98k4gX6obbCct0YrfjTuit5HdgObxJE5wOjv
         C/m2YOmHADvmkYXUHH8u+OCOVKQ/YhWfbQH5JP/5LYwqfib8swGsTvY+QFkUJw3SBcK1
         M9bxKiyWPUDTatQACLEwdhQeb1sbIYqEus/XClAM9JkOP1ew7155hbKUPOPKlaYqmM6Y
         Z8zw==
X-Gm-Message-State: AOJu0YxSXu0xdPeIHTsC2JDchqdGZ0q4lEMETFEjqpKQ2Bjygrk/SAbw
	J8ONA3aqk69PdIZU3oTNdOOFe4pMv/sUiY/Pd0Fmoa6dFsTy/zkbugpIK84cD03Q
X-Gm-Gg: ATEYQzy7jXI44/U8gK9+CwLmNuRTwO25w5dlQ9s8ho+sNCzZ/ZJcrXAvV1mddKMLbVv
	14b+pv87AfTF0n8eWqHfJSaRW4u8qLrIQxe1Dexy6PRvjkxm+YQW247wV9RmLM6L76us9+gA0/U
	NbL3jXrQq4hqJavfacBRjRAkpsh8hKCpTTZzKw3RBr6N+M/ZoL8RMp46pfUxkSahkKZiikuR+AR
	eCsgZllToDFU1FJjPs1bQX1ZsdI2Iozw1NzCtLdN0ZSV/rslcFSzXXbWZ6XfyayumRrTUVGqUWj
	Zm0ryHuOGpAKAeIE22oD3CBROpxajavHg6REBiGWD6rd6zZtDkTArvnYvP/w85fEPMR5gbXZJnK
	OLovfFalvwki1zB9GyIohbCbFFx+5F1mU7mgzD4CTFxEjH9U82UWP02Gqpp+RzrlDFXmSHq6t+r
	I=
X-Received: by 2002:a05:6a00:2d1d:b0:824:3ef6:a815 with SMTP id d2e1a72fcca58-82739767b3emr516796b3a.8.1772058091345;
        Wed, 25 Feb 2026 14:21:31 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d544ffsm290363b3a.12.2026.02.25.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:21:31 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Ze Huang <huangze@whut.edu.cn>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v4 0/3] riscv: sophgo: allow DMA multiplexer set channel number for DMA controller
Date: Thu, 26 Feb 2026 06:21:07 +0800
Message-ID: <177205806122.119215.17895713731232514155.b4-ty@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225104042.1138901-1-inochiama@gmail.com>
References: <20260225104042.1138901-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9120-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D91419F488
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 18:40:38 +0800, Inochi Amaoto wrote:
> As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> the SoC provides a dma multiplexer to reuse the DMA channel. However,
> the dma multiplexer also controlls the DMA interrupt multiplexer, which
> means that the dma multiplexer needs to know the channel number.
> 
> Change the DMA phandle args parsing logic so it can use handshake
> number as channel number if necessary.
> 
> [...]

Applied to dt/riscv, thanks!

[3/3] riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel number for DMA controller
      https://github.com/sophgo/linux/commit/7b159ed9c81cf7e0d0b75666e6548ceface2e1b5

Thanks,
Inochi


