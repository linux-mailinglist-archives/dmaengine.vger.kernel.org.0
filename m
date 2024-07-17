Return-Path: <dmaengine+bounces-2715-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79962933C75
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0217EB22195
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B9626CB;
	Wed, 17 Jul 2024 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="C4t13W4F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F41CF9B;
	Wed, 17 Jul 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216760; cv=none; b=QyMptGwSmCFLRpJe7PSaxuvh7esAgI1LyuqPpjAAYS/N5OxN3FZErAVhj0q4QeXfgGcz8sDGtxcEj/XC/UTH8TdX8XeqTbTSqPL5nJZDS6ArCPJTjsHDdhstcJJ6fcM7+i5HT+A7Y24dgQbBcE07UfzAB5KJbPgESQqxxf9YQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216760; c=relaxed/simple;
	bh=t7pkr2E2x/75EXmEid50m62y6nPnbmM1h0/nrzdKurQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=U1+VhQXizbPP7FnH002L5DNh0faNEnFZ8AZ/6y+S6egdvfX9Vnw9utdQtUx/l+YqxZyvIRnMwVBuVVXWAidTU+zjrV+mUW96NlyMxF0OqzPTEE5Ylj+K6RxyX8Xm4pvSQv2N67050rejvnft0CxiyRm0dGZgrV/VvPlqRs/Py78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=C4t13W4F; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721216734; x=1721821534; i=markus.elfring@web.de;
	bh=t7pkr2E2x/75EXmEid50m62y6nPnbmM1h0/nrzdKurQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C4t13W4Fu6ws2wU85jw2nIxtC94rdJxVoPAsHt2pQTDeWLbA1SsoedWlNaMS9D+2
	 pF5EI2h5RPsLbuiAHy8OArQKHC3gmpzQKqBEQ5NVHlPtzrBUn16TqQypEFUNzNGOY
	 bI4/1GBeJK/rDQymv+2LWfda0SAM9e0mLf1A1ygMCUHkYCX0usMw+C2Bsz6UGVv6b
	 zi3uWbW/jIXi0Y2teIT86D8EUZxXGayKBagT++nG0jNGNTWy2h8C2f6+vRZDyDJCK
	 IakI7jJsjw31Bp7OwEa57VHziXvLVzLp6Q0n8+ckX2QxB8hKfD2B1qpAJ/69qjIFb
	 BP1hcx8f3ypwXSWhpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav2X-1rw4vN0HYB-00and9; Wed, 17
 Jul 2024 13:45:34 +0200
Message-ID: <a41053b4-b42d-4aca-a8dd-c9f4c901e5dc@web.de>
Date: Wed, 17 Jul 2024 13:45:24 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ni <nichen@iscas.ac.cn>, dmaengine@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240717072706.1821584-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: pl330: Handle the return value of pl330_resume
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240717072706.1821584-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SZOHsoaTwzLA6lcKSK7a9T6LhVIzkC9qErv78GxyZeKrDIHnF2v
 l+513wVf0q0EpZDatUubvIx1Y3LLJn/UZwZ00O9gUDsOrmupbtBiik/1NQFaHrpam/SPsvE
 VHek5Y5wTd2z0nN5tgDcpumB4xnpKl19i8wDHi9Vjc1T49GucQSuXZlQfoof09ZWFXYzmDV
 UJoNHhhjeJhSV7HqCHbzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oNO2ujE1DoY=;cDSJg3rAYzJd7r6tokUN5uxxIvz
 eXXUXHHg/8FYJ9DtjM70qCNi3Rq4yjMUh3uhk/kWGiJe3DQPbXe27Kzu3Y7chDMSUJfZvUSBq
 p4zwbG/DrcZBe/PWtYrnVyunDcr4Xl+UFsWjB7W/n0R94sjF7mDSi//3BzTLUy10bjyNPZx42
 FGD1Y5ZgP8wxqbnpF4qe+lSR+iGlIFl0EByQycKc9vRhEmACZgjoaCTSjcmXku3tA1Vajnmml
 Cf0nRF95N716ogV0YDIuSri8w9krXa67P0NSGlpiLbYTRsCjaeYoXi95uPOXxQj2c+++FGHrm
 CI/2s3LIhqFa491lZ5AfnWumbpHz21nL5pzUuCzn0T4IiGmWQvfzwgfzjopE0l/BevM4fLXE0
 dm1LIO9lfwHuhzMP5tpN09mp+ULRFGSa0+dAXiZNo82bFxDDCGms1SoutxR37LgG03lHMhMko
 Cg8ayE1m6eEGxZ+A6vr1X37hXChITsObW0LdYZZhhB0yPXMQJ6JAiEUCiVw38/2oZqV5U3Udq
 IrZQglbWsmhFjNCEafO2yJwp34UY7tXkhkQ1TNfIRw5A9cBse03VgPfwLyQ/gF9TtMIQ0nTQJ
 7wn5SvGe+VJhaHsNGN82WjQIR8/B2kgGEA2C0TT/+m7kNd6WtqoSy1ino0/GoLa/YaFmn3xi5
 V82YIDKLh89sOS64QlqcbBhQ4dbKBv1nh4oQytR/DrielLJCgXYgODrPVQviuJIo9Lu6WzX62
 J5FsGoyqF6ocRBdNIwoiZEP67pHXB0+AKg30e0Nex2rDcsyWAam+MB4zB9NLGyGY27GCNXK0W
 GLWKxmMRUelIeOLctPUDGuhQ==

> As pm_runtime_force_resume() can return error numbers, it should be
> better to check the return value and deal with the exception.

Please improve such a change description with an imperative wording.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10#n94


How do you think about to use a summary phrase like =E2=80=9CReturn value =
from
a pm_runtime_force_resume() call in pl330_resume()=E2=80=9D?

Regards,
Markus

