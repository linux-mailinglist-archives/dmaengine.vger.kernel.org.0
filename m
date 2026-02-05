Return-Path: <dmaengine+bounces-8757-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AcsGWmUhGl73gMAu9opvQ
	(envelope-from <dmaengine+bounces-8757-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 14:00:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E746EF2E96
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59F193006031
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605E3D3D1E;
	Thu,  5 Feb 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Zex0tIZa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960B3BFE36
	for <dmaengine@vger.kernel.org>; Thu,  5 Feb 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296419; cv=none; b=K1xw2FrLoI60+qJVdZ+2ZXrmwb8fR1iXLgBgsHvqpXtffty/cqwJCggvtr+++fTUKuwDjuH8T+O9N/9dk7i36E9F/iIk3f4/KOu5N94KGh/AZBOsnRTgccMceM6F90CXZb16piPtNbTE+IJ7om5CAOgRF1EPoXqhxmYCM8Az6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296419; c=relaxed/simple;
	bh=zVLkl+/sqMBqN0whpK4INw4Nr04WKy1mfq1u+orpKVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hO1/foTd2BWyaC04ga8lM5ost1XXxqaOkMuR/Co7OEjfIoyMTlebu1n2ps8tS5IOf272Iq/UcOoF/XGjnhbHLVEkK9IJ+gFc98B1Tr6LAQYTSDb1+HygBY0PBiEFZ1Ttgsq3QqxU8d4c1J49xTEoX8+zZCt9zxIrQtWKVRMnqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Zex0tIZa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480142406b3so7546565e9.1
        for <dmaengine@vger.kernel.org>; Thu, 05 Feb 2026 05:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1770296417; x=1770901217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ea5Wau3tyaotoVdTXU1AX44w/mbst5DuRTitl7uLstw=;
        b=Zex0tIZaf0eYh2XxCRHg0JzIXxrn/5miK3N5RCpp+1ixG+oGgJz2IY/DYkGpyGx883
         t2CFJiuHt7H/YB2jfHd/KhuS88PkQwIGKV4Td4vO7Ck/rAyRJ4nlGSuZjIslSBNxTHKm
         FqQ+DvC9VEw+mp7OBhH6bIdtoj9djYMvRFYLfUBzj4MDYCc/t8JmFpiYor04SFxTB/k+
         D2hZ1vL7mJr6WeNar4yv/uO7oo3iAZWwicgspO7rywAQp8nTYxadLDhnucTS8rPnFguX
         w6/En+8OEOtpJudMwSXnzcgR05GygH2KuttHYze6Npu2U+ayk84aQUMz4VIZedj2896X
         2ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296417; x=1770901217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea5Wau3tyaotoVdTXU1AX44w/mbst5DuRTitl7uLstw=;
        b=fuFMAvh48GhBCYqrxEyH/k+S0K7aYR3Euh/BmgD/6hhFRfQHVJAeTvJHmnqaFD/rtr
         mUOROcz7FQokndxdnd8JLVGnBcBvSI6AFJnY4bCGiSl37aMT/ZO36I63NQU+fSP1ciEv
         MKjGRvoJAsCyKSEud99y2CixvAOuisyMnmHNuWy2G5VM1ktK84i24CFF4y2MkZN4EHP1
         PBAQt3BLVlLSh9g2XW9sL+8690mJhNp+CS56h7kM6PzBUfo9qXzmgQjHCINV18BmOtac
         HTYr0Jh3HPhgntJtRzTxG74ia1bdesad4Q1jmzUJ+oNXJ0VcH226U2y+QxLgSPsw/6nE
         5u1A==
X-Gm-Message-State: AOJu0YwbFXaQqxQ+I5DLxcpDeZXvA9G4DkCgQygg4fvdi1oFze/cBB5w
	56kIXU9LOIwR/TcI9pReiPYLeOYINjwT4hixsyYJneMjOfjWVIYLmLx6BiQqccEmVeo=
X-Gm-Gg: AZuq6aIpn6e2BnOAF6Yk1qtSoIuMEmv+9sBmzyt3R0mlMNW/F/97w/JSRgjC++w5+p3
	4PlQhkFpxqCVUJSqy1b4/ajwk8LcATx56YpkvXhclF1lOWhbRMbAcCj1Bl9G2d1juuEUagNPfbW
	ju9iyM8k7uGpRnlirWWRKOTIgC7dyg8JyPHzpqMFACwatXBtBBQezZeFnQzlRkH7krD3VgOmIEV
	PbawfyZ74rhCspyjTpIEoUGcCVkiiRlALWVrn6OQhjkdQDkEbdNEoxXd9HFXGEIl30LxqxaQ/ez
	h1Nl0AfqfpIxJSKA/sHYcUvOCOIRzpERuT28ncF8Qt7F5TIXXWa/HqhAugpUCsIk2Q8O7vKE+t9
	ftYbyIsRf+qGfJ7Jb5sRl9vYzpy6UsCqJw7AKHnudyF/gAkw/EWE3w9Zhunzm4Hii34nbqCGqgk
	ClOnw1TtTVkwp3wlsouChYZTUbmV7rVQ==
X-Received: by 2002:a05:600c:c3db:10b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-4830e991dccmr65465125e9.29.1770296416641;
        Thu, 05 Feb 2026 05:00:16 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm72255075e9.0.2026.02.05.05.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 05:00:16 -0800 (PST)
Message-ID: <7f0305f6-ae2d-4069-b53a-d2a81e75d164@tuxon.dev>
Date: Thu, 5 Feb 2026 15:00:13 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz"
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
 <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev>
 <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ad752abc-275b-43ca-aec3-188c1a69c50b@tuxon.dev>
 <TY3PR01MB113460006A458AB2F8B96542C8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346C8AD27554E40EC5746E38693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346C8AD27554E40EC5746E38693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8757-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:dkim]
X-Rspamd-Queue-Id: E746EF2E96
X-Rspamd-Action: no action

Hi, Biju,

On 1/26/26 17:28, Biju Das wrote:
> Hi All,
> 
>> -----Original Message-----
>> From: Biju Das
>> Sent: 26 January 2026 13:12
>> Subject: RE: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
>>

[ ... ]

>>
>> For s2idle issue on RZ/G3L is DMA device is in asserted state, not forwarding any IRQ to cpu for
>> wakeup.
>>
>> For S2RAM issue on RZ/G3L is during suspend hardware turns DMAACLK off/ Asserted state. Clock framwork
>> is not turning On DMAACLK as it critical clk.
>>
>> Can you please check your TF-A for the second case? First case, RZ/G3S may ok for reset assert state,
>> it can forward IRQs to CPU.
> 
> Just to summarize, currently there are 2 differences identified between RZ/G3S and RZ/G3L:
> 
> SoC differences for s2idle:
> 
> RZ/G3S: Can wake the system if the DMA device is in the assert state
> 
> RZ/G3L: Cannot wake the system if the DMA device is in the assert state.
> 
> 
> TF-A differences for s2ram:
> 
> RZ/G3S: TF_A turns on DMA_ACLK during boot/resume.
> 
> RZ/G3L: TF_A does not handle DMA_ACLK during boot/resume.

I'm seeing at [1] you are addressing these differences in the clock/reset 
drivers. With that, are you still considering this patch is breaking your system?

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20260130143456.256813-1-biju.das.jz@bp.renesas.com

