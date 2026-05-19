Return-Path: <dmaengine+bounces-10530-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMWjAKsxDGrdZAUAu9opvQ
	(envelope-from <dmaengine+bounces-10530-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 11:47:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 713DE57B949
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 11:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC2A030426A5
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD015451062;
	Tue, 19 May 2026 09:43:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485713FB042
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183824; cv=none; b=LDhMh7zmUl8uF7bkVf9eG/eWLu/+zCcfXuY+HM7EIS2nH8BhC7U8L+RaaanNUP7bYo6suW5RzT9Y2Lcn68+sPmshxHlMB4b6nI2RwbHXM+WBwb5iymQwnUIxdgoXXjzB+EwJY7+G+Uh+7eFn7gYfXYaQH/D3cqgC01vXrD3fB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183824; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jupIhEGwoCvn3N4tUyK7Zbi+4qKLt8mF8P4Iw2RZOuYh2Ytvae7sxUtQZ2a0msTAUDXeWccxxpRIHCqxjUzvunOPcDr7XByY2Vcee0N19K4i78M+EjnzeRDWprBSxUo9trw+mrxnuNTmqxVKpkpyURMTu5W2zGG30oOwz/TrqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-577500ac0e4so881146e0c.0
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 02:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183822; x=1779788622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=hZnthfEAQYkxJp3DoAfhN80lQfc84Ill6nMc8oKV6eMBpZ3kcTzcgtyk4g9jOWqFLh
         eeJ+vXoOFFnjXy5An3SHGGhj/og943wIpos5fLrVFlQH2VzKPz3kO5QNbm3ur5FvMZ2h
         T8N+skQ/aLilLhUHOfEh+Csog+dyOcIpVKdpT5d3m5LDafJlxvx2Bqx1rjyZ90JwD4Ll
         kiAAeuJ4lJbuUj+BNt+rkj3QqlH5vSIM7zRfxyAPng1rvdg1aMh/xNX5okftHWUGncBs
         mNv2Ay2GjkLiJKfpdt8ibhJSnM971gUuAHj0sjGctq3Z5FefzLyTrRu/hYyXT3Z14TdQ
         Flhw==
X-Forwarded-Encrypted: i=1; AFNElJ+BTuJZow6qscEsfk7rECd2C4Cue4qeGt9RsbVSgSSawbcnIW6f78WjUpnmqxzENRfuTOVHnaxS/qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SMcctY+5nq9p1bx/ZqdoDwbRbpScwsjwT8avJh1x4ULpVA2b
	jIqPRcSWf0SdItzgCiDwEtSZ8RgXPJZYXpHjVYv4JfEwOMcnCUth39pSUDIDRopV
X-Gm-Gg: Acq92OExf5d8xtomyEN4ovxiwDgrT4a6YOJG9KBXcJwJEfszwNevIDhGp3C2XnG/h1a
	SCCmvHFOY1cg9ssHje1LFB7zSduY7OZyqDbtZC/D2INjDiwhzbAzumJpTyU27t5kXIGVlpZ3pCE
	5EtYkdjOBEOWLGZn5OE36EluXvC8XoyqhABU3HdX+DsWnlYS+gtJO+kE7Ouy+sN9P48+y7WTPXN
	fY2l/C5+7d//uAGTvW+3naA7ofGWnkjJ8QgAAsya7k7ldsVrDV3kdVFg20PG3Up+fp/PESM9DGy
	NTfFKU43M4O3FxY78axIQicjpdBXudAUbrzw4hL+7UDpjOM0WVSk0v5630biRjiiBCVj2uitUTG
	rrY4N7sBLAWvAyL0ayJYoTyvfwsAYHQy3Fax24yjOSrWrw0Vb5AbjUA0Jt29R0KCtjCpq/ziJA9
	vs7/xoeQPVakCRM39MBtIw6yznKV8RG1cwWl40rHt0d76Ev1tGm1luDs1oOmTzSINJIPOkWtr/Y
	UfnPacpqimsuQ==
X-Received: by 2002:a05:6122:2a02:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-5760be71006mr9072645e0c.4.1779183822170;
        Tue, 19 May 2026 02:43:42 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f58f7a9sm8046386e0c.3.2026.05.19.02.43.41
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:43:42 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a857578a8so1121426e0c.3
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 02:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+B5w8wStUVas8DF5BmaTneOpWNBTho2z1ygXVNNU7j8hKgUF+wdcXxKGIgfrTbH1DicHbqo+tuq7w=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10530-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,infradead.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 713DE57B949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

