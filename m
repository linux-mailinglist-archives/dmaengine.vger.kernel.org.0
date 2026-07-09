Return-Path: <dmaengine+bounces-12228-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ta3MOfCyT2remwIAu9opvQ
	(envelope-from <dmaengine+bounces-12228-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:40:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A4F732624
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:40:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12228-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12228-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D0033072824
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7D8331EDB;
	Thu,  9 Jul 2026 14:33:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F02334695
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607581; cv=none; b=FHGTUh7gqqWbHpizVRyqYFKUqvrA5ly9WKlRUv7Ed7KmHFVUki2BjeSdiehDMBX7pn/9IKyVv58qKW1eFInKhw6LYNpyyvIPs1OZwHe7YouTHYZ2RzSKPqPM5OpeNTFbmnULtFhkC98jwhcBaY9DeJntsEMHJebhuybrpyLdlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607581; c=relaxed/simple;
	bh=4e6S3buX9tHz34skulac1BE1E4xsPZ2vcWh+YB8nd1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tofK6p9HTqAHjr9m+eb69uUOtN0R2A7Rr/YtY3IgWMIKMQKyaCu8pJDAh4nwWBkijv7Tyz+oeV2mk702UOdLzm3pIujlN7WwH4Uwz1moVmJnAR5WTerMo6ZC6ssjmoH/AmVxqDx1ItfU2WPyqoQMg5SJ9Q1tf+OVB80/H2Fq0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-966d4748ad5so630685241.3
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 07:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607579; x=1784212379;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9TsPZDpzdYomEeV6URKjJG4JoPB+LXiKVJ0uWCnI2HA=;
        b=TgLuGz1IKmOYAhev29yISm2shojrjme5Xobt3I/6S9m8MFsPVjUxy7YL4l+bRUNZ6c
         MEFlH7tiSHlDc21raAbT+T5v5ExY2uyoIFa55IrWTzsdh8Nu1Yhbfo4gp+rE1w/QKlLN
         XJqHaLrhHAGwCLaazvKdzDoQAZLlDEZMCFMa19d7cOo4lcA/CtDSimW+CJwghLz6+Ffw
         ePIh1sLnCZxdkxBbfY7nGrMcmkmAcxv8Q2by5CqoQBkBhPT+iQN0lUE4iiFc5XmMVrTo
         XNqUWDf6uCtX05E2C0E+HxFZ60fjGF/Ldzy3b6AUpK6OLLqbZ3GRmMm3jHjZ7/6/iMlo
         30TQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHAaOXporik1sPED53sj/kUYzq5z5uKyUdHotux77rBvsJUNmP+jzkCsga2Zii6swsOKLM2xrM4ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyFsBGGiz8dhW4prw0tP7UGH1Ujc1FEadG+Mr+pM9X6Cr0qXs
	ncYcawjVd4F18dI2iSMDOvnZD8pNzgp3u0wAsweU2nwvjGgp2t8gJZr1SAFgeOmvIaM=
X-Gm-Gg: AfdE7cnK3S0kDJUuZy5cCrXkHSehX7JpqUbjFdG99fbVK+u2rjw4PYaw2PoYU1UxfS4
	3ySjV0erY9ABwLAtcITOpGccqGeOOZ1zFYznLNQ9pXsiW//P8oqbupbXTAuK6tz9uuE6mgvn3bU
	Y29Npzakf+2WR9hTIoPJnxSvF85sgLqZkcHjOIfRzcNi7x2n+iRq2VkvzdOXFSLI0BA3waSmayP
	axqMeKuXdkNzSMW3TynvDbO8LvlgiBKR8zL2e9o/JoeerLOswdTkGt8IEFTk9G+xA62WmrXd6dg
	bk0Yl10REEEheOWeDMyrgd31A7gM0CpcBRi1ILWPM5zHCsZq/hdIG3ZzMS+02BYT+u13Ir2RYm3
	flZFeXDcz1VobI733nk47eEHbQfi+zRFN8+kGEittGT4exL7/Fl1wAG8xd9w8s49rObfApoTrRc
	wpUYAAKLJi9JlL4hWg98owlPdKNE71Rj67FF9DIhG/b8RL7qY7MQ==
X-Received: by 2002:a05:6102:1622:b0:738:9d06:2a1e with SMTP id ada2fe7eead31-744dfe6b4e2mr4324209137.8.1783607579352;
        Thu, 09 Jul 2026 07:32:59 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed2c94ba7sm3131235241.4.2026.07.09.07.32.56
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 07:32:56 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-966d4748ad5so630635241.3
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 07:32:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro1ki5sEKjrmEG+QgSbsxK+bre7wOZKBDLeoLd2IPSZDo432Sm2HcKF8xuCGlbH3YPM8z5b4v7BrDw=@vger.kernel.org
X-Received: by 2002:a05:6102:c47:b0:739:d787:bed with SMTP id
 ada2fe7eead31-744dfdf18c8mr4765287137.5.1783607576432; Thu, 09 Jul 2026
 07:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709135846.97972-1-panchuang@vivo.com> <20260709135846.97972-14-panchuang@vivo.com>
In-Reply-To: <20260709135846.97972-14-panchuang@vivo.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 16:32:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVYrz+DX2anzzz=tSVOsAsOXucWC=739enSrL8dTkRVg@mail.gmail.com>
X-Gm-Features: AUfX_mxOEHj_kI8yJnHfJQeZj91udetbzorKSQKSh_rYMM2dOhrIt6shCaR01TE
Message-ID: <CAMuHMdVVYrz+DX2anzzz=tSVOsAsOXucWC=739enSrL8dTkRVg@mail.gmail.com>
Subject: Re: [PATCH 13/26] dmaengine: sh-rz-dmac: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, 
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12228-lists,dmaengine=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:biju.das.jz@bp.renesas.com,m:cosmin-gabriel.tanislav.xa@renesas.com,m:john.madieu.xa@bp.renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,glider.be:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68A4F732624

On Thu, 9 Jul 2026 at 15:59, Pan Chuang <panchuang@vivo.com> wrote:
> The devm_request_threaded_irq() and devm_request_irq now automatically
> logs detailed error messages on failure. This eliminates the need for
> driver-specific dev_err() and dev_err_probe() calls that previously
> printed generic messages.
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

