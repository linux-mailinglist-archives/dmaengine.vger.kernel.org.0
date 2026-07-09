Return-Path: <dmaengine+bounces-12230-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tiFfHF6zT2rymwIAu9opvQ
	(envelope-from <dmaengine+bounces-12230-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:42:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D09DD73266F
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:42:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12230-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12230-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B4323013B5E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0EF3358C4;
	Thu,  9 Jul 2026 14:33:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD9331A44
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:33:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607625; cv=none; b=Smj0CrYoqyyUFfbLcO0vqGOxMpWQZpfVTWSeF7EXUub7zRR2+u33SCxOcwp9ImJeqgyZ7s+S7Sb5tCwjoPUmo+D8BaKyGyNlsQn0ISZmeg4RR+37IT+zVlKrGm+yDMBKAcQbK3C1rts2nHdMWSh4Wt5M7gLqz1jybZRVsG6VyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607625; c=relaxed/simple;
	bh=52tgpH+Z1a9S0z6t5Qyj7HKJS0ESuKxF1fqudav0Z/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG7WcW+jxdlW+F6hKp/ZL0jSMhV5T9Cg2SHsWSIslbPr0my6G+BHfwPE8vnhKQp48OUgGIVtgQO6X7OAKpxOGsmCHSoLC3zsRv+BIzM/R336b0c8eZu+h9SG6aoht932GtwQyBcNAjnkDDcf2eGoMb63DmmjX9L6dxvyDOVTn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso374879e0c.2
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 07:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607623; x=1784212423;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p0gYPHzCOk2+JZvKIzVf9cs2Spr4yjYFEvG5gFPu2qo=;
        b=rMlZRH6jsBFoWgk455EvvybMJAWgG0zdbtvlKjIQSTjFglcjiAnLNTKijjQHqvn52P
         Z8LPezKwn4odscuDXhy1B7I9WI4XlT+tiJsA/0PstM47iddpHIh2gZnP8bH41L3wVAW2
         vUiGfYhreJKn+4zQ0IuRtByriKGWSe5zHlwgeUg/WtoTvahnA93GXmMctQ8Pai6s3b7s
         BflAu4nU8Gx0cIhzRTtOuVvp+7SThRcrAXrt/LQylMjwf/hCSpMSfM6dxplKgsEyPCVO
         cgQhhtF5rtAFlgLogmsXOd0KwgO4m61QDiOPGX/u6qK8mHaAR32dD5sjyErmKrWG9JZH
         swAA==
X-Forwarded-Encrypted: i=1; AHgh+RpoxDHgQaVURBtbW13DfJouAZBqrv5/R8i7+bzdEiHVb4HvRJNOqqNTotUpcF5AVsiHMpVgqvLizn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHjnCyYMJRLBbVe2LCEd6oFk5eoYPi9WtnJj3nrDoZHhtLFYH
	XLJqSxIAYVl7eum/rW0NXUq9Hp/HPPbeinhJ+TQlYezQbkIHGC8cnfTsWv6yenxL5K8=
X-Gm-Gg: AfdE7clKCrYWBlKdvEjtvJdZirnL3EheTj2CaL9gfgfqFP51v1iVO24H5pGClWbkxxc
	YtOlk4k4/qSoVynYk6GCcZmCSber4Al4PAZoTmr2jHSsnnZKK8jM2GfkSoNc/RydBZLJS9TXpuB
	jfLnWr/T0nUEPkMFkG5qkSi9iRc9nCMQfd/YYT01JGvnzxKC/poTMi4UxdkQ+2OBv42miRelpOC
	dHwDnK6YTeaeCm14mxpz4XEYZs9tp5AhOXrSc/XWNffOgNxlzWBaS6sgO/8slK19o2vEdGERFvQ
	8VxmEjwrRr/8q/FWIOZGSdwUoQGagO8P/RC0J3QACinilynUuRuNFUQt2+QiWHUfl3Z6E5v1xIB
	On49ovsXVVSFf80+VU0+YVBrwQg7h8Ysv877dIs1Gr15HLbxY1+5e0v9qxnjz9Rk1JND6mPfyhF
	UbLyYUYmI6xucVW8L8rC6UgcIxjChSS9BGWK5nUj9i59l3Rs7/Pw==
X-Received: by 2002:a05:6102:292b:b0:738:3525:4403 with SMTP id ada2fe7eead31-744dfe5c18bmr4458434137.16.1783607623486;
        Thu, 09 Jul 2026 07:33:43 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6a90d0csm3669349137.4.2026.07.09.07.33.40
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 07:33:41 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7380954d1c6so349667137.3
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 07:33:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqwg0jizujT6Y4SMZ2iuHBzOxWm3FVEwawjQVtsSlKs874qbISoFFQNulgRmIWd8yjB9HH8OA0hW9s=@vger.kernel.org
X-Received: by 2002:a05:6102:508e:b0:738:cdc6:f59a with SMTP id
 ada2fe7eead31-744dfcb90dbmr4065152137.9.1783607618941; Thu, 09 Jul 2026
 07:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709135846.97972-1-panchuang@vivo.com> <20260709135846.97972-16-panchuang@vivo.com>
In-Reply-To: <20260709135846.97972-16-panchuang@vivo.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 16:33:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvei4x+otb1bhZxZ9GawJKFU06XvF5-VKk3_+1QTw4qQ@mail.gmail.com>
X-Gm-Features: AUfX_myaWx9oQ4R7o304wDL4suATclpv-_2ItoZ9snvglhuigoVRkB7r0WaPTok
Message-ID: <CAMuHMdXvei4x+otb1bhZxZ9GawJKFU06XvF5-VKk3_+1QTw4qQ@mail.gmail.com>
Subject: Re: [PATCH 15/26] dmaengine: sh-usb-dmac: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12230-lists,dmaengine=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,glider.be:email,vivo.com:email,vger.kernel.org:from_smtp,linux-m68k.org:from_mime,linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D09DD73266F

On Thu, 9 Jul 2026 at 15:59, Pan Chuang <panchuang@vivo.com> wrote:
> The devm_request_irq() now automatically logs detailed error messages on
> failure. This eliminates the need for driver-specific dev_err() and
> dev_err_probe() calls that previously printed generic messages.
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

