Return-Path: <dmaengine+bounces-7242-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD35C687F6
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 10:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D54EAE56
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3832FFFB3;
	Tue, 18 Nov 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vz1Jc0at"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15B2FBE15;
	Tue, 18 Nov 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457694; cv=none; b=sk7Er79f6ZgJoGDbBmpA84FfCILpdafCmDjYjGxPSM/BVzxgVTc2YSnUqcRs1HPUl2tcUey8SYtAfkMgBT/JbRB+r0dQ1U9BLtQRFvU/5COeGhOz41qyHlpPy+/O7d9WnhlXUYdaJcMG+0x7F9z/l+syfqqF8BbKrtk3RhgGw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457694; c=relaxed/simple;
	bh=pw6InKVn77MYmI/6SyWOGZzhKwLWJdj7Un75QeGELa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P23ZF2Z3vjkYP7erl6OI8Khmkpz0DwlPVBOxc1093WAUMnJc3iLKJuAVrfjVfhNfqVzjD77W5N95JAvxcMMBa+CCaIk0Z+Fw7VtdlRnNR427pKOy34cpcspCtbkLCwQ4rXgbemlI9CndsRRHyLOijTF2hrTv+f7TLMJGcv0sGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vz1Jc0at; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2F899C0F560;
	Tue, 18 Nov 2025 09:13:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4029A606FE;
	Tue, 18 Nov 2025 09:13:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EABD810370C29;
	Tue, 18 Nov 2025 10:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763457208; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XhuyhJllFm95ww/oufEX2VBqQR/eTEzY1I3HIzztG/w=;
	b=vz1Jc0atdB8/+3UeJ2+ToL/QhwDgLXeFw7MI9/QXNelbKf17ZQeMGFlraQaujHVco269Fp
	hIFazW5x+Ilaz0sn0Mm7NrTwPDzTeOlPlATuIlns6GMOQB8mQFIy3XfLiM0vVCWvcNS2fJ
	x3jaUI50BHL+Xcfayq/Mf0jikpICFeMsud64+etUAu+sj5u3wvE98HFSmm5Y8y9W74nZmz
	sTEkjj8u/NfDyj0e3gU9kLRbqGgJ/CEfGuMJp7WMbZg7YXCLS+xUCEDoULHC/STAfHIfPi
	vL6bCx/SJP97WexlXuyrHK0/6Ygu0yfie0vAuq3ap75p8vO+Ew4GYvv4mLtw5g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johan Hovold <johan@kernel.org>,  Vinod Koul <vkoul@kernel.org>,
  Ludovic Desroches <ludovic.desroches@microchip.com>,  Viresh Kumar
 <vireshk@kernel.org>,  Vinicius Costa Gomes <vinicius.gomes@intel.com>,
  Dave Jiang <dave.jiang@intel.com>,  Vladimir Zapolskiy <vz@mleia.com>,
  Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,  =?utf-8?Q?Am=C3=A9li?=
 =?utf-8?Q?e?= Delaunay
 <amelie.delaunay@foss.st.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Peter Ujfalusi
 <peter.ujfalusi@gmail.com>,  dmaengine@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH 04/15] dmaengine: dw: dmamux: fix OF node leak on route
 allocation failure
In-Reply-To: <aRtV69UcldVcYiKR@black.igk.intel.com> (Andy Shevchenko's message
	of "Mon, 17 Nov 2025 18:05:47 +0100")
References: <20251117161258.10679-1-johan@kernel.org>
	<20251117161258.10679-6-johan@kernel.org>
	<aRtV69UcldVcYiKR@black.igk.intel.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 18 Nov 2025 10:13:21 +0100
Message-ID: <87jyznitzi.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Andy,

On 17/11/2025 at 18:05:47 +01, Andy Shevchenko <andriy.shevchenko@linux.int=
el.com> wrote:

> On Mon, Nov 17, 2025 at 05:12:47PM +0100, Johan Hovold wrote:
>> Make sure to drop the reference taken to the DMA master OF node also on
>> late route allocation failures.
>
> ...
>
>> +put_dma_spec_np:
>> +	of_node_put(dma_spec->np);
>
> Can we use __free() instead?

I probably haven't followed closely enough, but I don't understand how
__free() is best than of_node_put() in front of of_parse_phandle()?
Especially since the doc clearly states

           "Return: The device_node pointer with refcount incremented.
           Use of_node_put() on it when done."

> (Just in case you are going to question the appearance of cleanup.h and t=
he
>  respective class in of.h, it's available in the closest stable, i.e.
>  v6.1.108 onwards).

I don't believe including a recent header is a good practice for stable
inclusion anyway. I would recommend to let the commit as it is and in a
follow-up patch, maybe, we can move to a newer API if we want. This way
history between stable and mailine versions is easier to compare.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

