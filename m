Return-Path: <dmaengine+bounces-12226-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cN+IFbuyT2rQmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12226-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:39:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1747325F7
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:39:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12226-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12226-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A88F73100C1B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217063815D4;
	Thu,  9 Jul 2026 14:31:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9F3815D6
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607486; cv=none; b=pJqblt2/11KajSrou0rskL75oTyjsDf4EdaIT6k0Xr24BZ15BMbUbgP2r3w7cVTA7QITcrCOAZqYhl1IM9aAd5l0eCjY5DuejfIS3NhATyHgQayhnsUWBp/pz1osTN+UVhgTZCgUGiU6RXGcoEVk1d+RTm4Ez5x01yPvZiVZpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607486; c=relaxed/simple;
	bh=8kX0FxT0c0XdEm99OaTtiONMqj8y3+3JEEfwwNtjEIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+LxINW6yip0nwxAxtauoXdko6zKnU6FgXaubFYFBzuwmLQTFVIbgnK0XdVQKU7/mxqGj8Mk75dHgdVAeIgRQ7+PzCfl1b4OpdVLr/hWX6KOHZjawfcCpznurenBrIbg8oOKVEQj4bSdpHVc3FVnq6OWlFzseqPxqG6y9/1usM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97017a60b06so204409241.2
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 07:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607483; x=1784212283;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uMFlY6GWwnqihfhDQTAp9fBt5hzNfjez3iYyxDfqESc=;
        b=b/iUYfHkUPj+IEgeCWLaXHuOlLHR5UCWk7huy5Qm3DEioIxW4PusM0E9v1dWv8A8Vw
         Y7pDsyKDYAy4o2BV2EDFWHO6+DBB39YFZzufcE0EFjwUJA9lT7dGVzNCFOZuPz0LnKr6
         Zw7nGknVwpN7osLeTD74qQGOhmZjf6oPuCW1x+wmKl0bqIqX5DDnDFs6UIAHldOspRiO
         +IBcwveyEwqL3xRFFt43Q75wlCTtzCGbaSFhjJSKYixuEqnLVi6F+2DeU4zJRVqjL0u5
         dmRTgNc3pVQ4hr6CxEE6WLb7Y5JLyhHc+TzBOACxFht1p8JTmAHiVGehpoZlK9OlmMzw
         x7+w==
X-Forwarded-Encrypted: i=1; AHgh+Rpi7WgO4VrWy86we0bcXVYO3vzG69K5sAVb8EYGS4FXxqPCUfbUG6I+8nBmw6sdu0XGK6PBslZxXfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNcaFQdb87Nfs/mQVuaPpQnQAOU4rZIpWbKaPsL2HCAZf5LQ6
	FBJxfmQHUuRHhN0Cj2GXhhuoY3acDAwmHBsn16xRWXwTv6gYt+BREj28uxMeUhIHLSw=
X-Gm-Gg: AfdE7cnyhW+2TfYROo119pyAUUGG6VHbfmGiE1WBGaNv2+166KD7Yc2hg6gQpivSATC
	E64a/JQ4JmlngB3jIzR/pzAs4HC/SnSiS+V+PMolKGDAH3b7vduOus6+zu76n+IG92UjmtXzFhv
	W1DVZfxTzrGjCIX4ywAcDlEcjPEzTr1rbB5XLgSN0N56hHMZzAG/c9fle4zz+3DHykvR3CukKuE
	6UQy7wOOcUrQWpN6BDlAMnUR2dsJ4x0GSH1h10doRUCa7EkO0SNLcnoplrwgVAizNmyPSRqIuNO
	/APCVaEBRRlWboZbLT1Ko40Tmjpscalq2XxDd7mVUoqdUo0uY+bO9Kc2Kw3hqPRbwUgXNy3fcop
	IHG2DZCjdGel4XFelb8RzsCAE6koELdYyS8Bbj/pHnevyAatv6pSoFjo5vHnVGUPnIaWm3n5yUU
	vGvRLxWfjwFyf63T9I9DXvf0lHg34sqHkldtfTRuDxp3w7fbfgO4Enmg==
X-Received: by 2002:a05:6102:5a91:b0:738:9abd:9eba with SMTP id ada2fe7eead31-744dfc58600mr4219532137.4.1783607483259;
        Thu, 09 Jul 2026 07:31:23 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm3834297137.0.2026.07.09.07.31.20
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 07:31:20 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso373357e0c.2
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 07:31:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq79rV0Pl6XWLy6QJZa8Eq+0dsp0O67Abo0PttqhQ+kOJdsRXkCM4TPBsYDrVM8mWEJnSVb+daF4Fs=@vger.kernel.org
X-Received: by 2002:a05:6122:a0d:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5bf75a96090mr4253746e0c.0.1783607480364; Thu, 09 Jul 2026
 07:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709135846.97972-1-panchuang@vivo.com> <20260709135846.97972-13-panchuang@vivo.com>
In-Reply-To: <20260709135846.97972-13-panchuang@vivo.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 16:31:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUk-tVPwLUGnGt6vn8gihqg9xRsiSjJS0PV7iKnza9ppw@mail.gmail.com>
X-Gm-Features: AUfX_mzXIK_TQIUx9iyy1gZwmGbh-sXZWJSxhYiQ1ODxPdg6ExKlF9tIg1KNIS8
Message-ID: <CAMuHMdUk-tVPwLUGnGt6vn8gihqg9xRsiSjJS0PV7iKnza9ppw@mail.gmail.com>
Subject: Re: [PATCH 12/26] dmaengine: sh-rcar-dmac: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Kees Cook <kees@kernel.org>, 
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, 
	"open list:ARM/RISC-V/RENESAS ARCHITECTURE" <linux-renesas-soc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12226-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:magnus.damm@gmail.com,m:kees@kernel.org,m:dmaengine@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vivo.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF1747325F7

On Thu, 9 Jul 2026 at 15:59, Pan Chuang <panchuang@vivo.com> wrote:
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err() and dev_err_probe() calls that previously printed generic
> messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

