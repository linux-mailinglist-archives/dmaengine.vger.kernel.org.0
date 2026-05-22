Return-Path: <dmaengine+bounces-10718-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LVOKOMQEGrJTAYAu9opvQ
	(envelope-from <dmaengine+bounces-10718-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:16:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2137B5B068C
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64E783025C5D
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FA34752F;
	Fri, 22 May 2026 08:16:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967F2C032C
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437782; cv=none; b=fxIbplm3nSXRQRggfV6lugdeU60/uQgo0q3+Orlx8ZHw2tB18LdWdzCxWNp+3Ib4UNUc6gzETkJCt10tpS9gIADrDL6SagadH0k49u65PHZDRv0HSDb8o7VdOh0HsoxLDLutgJ6h3lYeGDsIy0ZrauD+fy69V0UKKSa5Wvk4Rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437782; c=relaxed/simple;
	bh=Dst/cEN9INcj1DtpT9Fle7dMJehPxMPRYGLV60t38N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5okS1xcxdFgHZIy0FH2zJfFLRUdZ2/Rc00T0D6ChUeF919dVJFdTkGuv0hG8r8ktrAC3+7uLysYLj95h6L5uBS7lXs+HiP/Am17IxohPy1XaLQkR2k5ZELFmQ/9kJD8UNSrR9Ho+/77dISsZdtF5PoDdasBB16KE5lRiLYer70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-95695190911so1821504241.2
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 01:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779437780; x=1780042580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCdaajXZ3y6/6Pkvxr8ZTKSYuFSegVssO+Xm6lrWkzk=;
        b=dFm2X59cUjweLDkkYMRwtmX33kuuXl2GqWHiVNbOl+q/6V6NDcAq+ZE1wXwNYCLIwM
         zpcaLeZ7OtdjffLlwSPuCoo7SsoJmjL1y5xgKvFUQnjVtYJR7j8uPYMZ0hhCsa0EPehA
         luOUpVya8vE+pL9xIbWyDcvu11oFZFhGBQCCp6GuUqnBWgvE172aTKMyCZz86vqgkv09
         Fv1JNVei+86bVHRvd7jpzVoE+AF5SI6jN5/EF3VFRb2hJ8zsR0Kxdf1GwRA3PWUkplnh
         ZDdjoVk3X1d6fCk2ruRxQiNZTOxmgBxQikMQ7x0JHObstacswG88I4FK8iIhQFdWJpcr
         RWTw==
X-Forwarded-Encrypted: i=1; AFNElJ/760NLG5lhp5GF8fLXihW9TFJlqT3E7D2taONyvHaP6K1huF2fyD9qZ/2B6zMnXgHiyRc0ssMSvKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+dMiXWK8itAUGxPnbmjc1K8hMp3pE+Y14s0c8ovRgdTKkQ8xt
	P1ulyu6XsYtsV3fMXuZPC+yvm/cdl7b2Mh9+XfbK1AakBhqKJb4THptMtTMGZ//J
X-Gm-Gg: Acq92OHvRAKv6qYm1NtqUysBIxrzlDpqd6wq1trTV82CUEnr4v1zroX7Tt+kmyLpBtY
	G+lipwNrum1an2HKR5Jd3KeVFeNtJJ6ab7KA4ENz/uYZxv7vbZDWChCjGgzTM+T36c7x0L2Sp3H
	fm8mcgxgBk2IDZ5hKNoEiKhlu311Hr+2PZmGMe/Ii/ZhYEhFEUWEIPYr+ClOs1bYsq/1eLHTWUk
	1gA4RjcOzMlx2c6ZN76StZDlzS4clug8/iQH2F7qolOw9JBpa2COomfUeiR8WhbKILF7ATD0Aqc
	CY2LRP5mU469MZTDepuESN0UjrXNzviXM4kIY6DTHe6krniD9Qix1oykgUCbDQY13PGmufTqLQ7
	yIaSDJc/4DNa5WD/Nlag/BdG/xCpfPwCQHOz7RdFYE1ItTLHVL/vYM/ZnTwsqLmi7c2f4bVpsEf
	7GvvrXtQTsJSpOJmZpaVO/rnuCdaJEGlSJS8J4lk5bZjvPw/CCTzqVehSFjG1/
X-Received: by 2002:a05:6102:32d5:b0:631:3740:7d61 with SMTP id ada2fe7eead31-67c8a07640emr997346137.17.1779437779788;
        Fri, 22 May 2026 01:16:19 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-961738430e3sm802803241.5.2026.05.22.01.16.19
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 01:16:19 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95699e8e26aso2321837241.0
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 01:16:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/sbz5mIrxh5LZqrHEroi0YAbFlFVUiVkMmlZGhrxhZOARsMt4tQBFQVv/Eg98TeCAqeeINyrkPcfs=@vger.kernel.org
X-Received: by 2002:a05:6102:94d:b0:60f:ac13:c99 with SMTP id
 ada2fe7eead31-67c9085f3femr895129137.29.1779437779393; Fri, 22 May 2026
 01:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521144755.3476353-1-maoyixie.tju@gmail.com> <20260521144755.3476353-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260521144755.3476353-3-maoyixie.tju@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 10:16:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUOrE0ouHo5759k8ULpFPBS=gyqd7A_k-RTnSSk+MPGvQ@mail.gmail.com>
X-Gm-Features: AVHnY4LybiMpxYrUpMtQaHmizecfTGaYtZxZVu1CJQ_a2hFyOdeR3Oe_IQNE-Es
Message-ID: <CAMuHMdUOrE0ouHo5759k8ULpFPBS=gyqd7A_k-RTnSSk+MPGvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: rz-dmac: fix dead empty check in rz_dmac_chan_get_residue()
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10718-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2137B5B068C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Maoyi,

On Thu, 21 May 2026 at 16:48, Maoyi Xie <maoyixie.tju@gmail.com> wrote:
> rz_dmac_chan_get_residue() reads channel->ld_active with
> list_first_entry() and then tests the returned pointer against
> NULL. list_first_entry() never returns NULL. On an empty list it
> returns container_of(&channel->ld_active, struct rz_dmac_desc,
> node), an aliased pointer derived from the list head. The "return
> 0" shortcut is dead code.
>
> If ld_active is ever empty here, current_desc points at
> &channel->ld_active. The subsequent cookie and status processing
> then reads bogus values from the head's neighbouring memory.
>
> ld_active can be empty when a residue query races with descriptor
> completion on another path. The author intent was clear from the
> existing comment on the next-following check, which already
> acknowledges that the descriptor "could now be complete". The
> empty case is the limit of that race.
>
> Use list_first_entry_or_null() so the empty case returns NULL and
> the existing "return 0" path runs.
>
> The same shape has been cleaned up elsewhere, for example in
> commit fbb8bc408027 ("net: qed: Remove redundant NULL checks after list_first_entry()"),
> commit c708d3fad421 ("crypto: atmel - use list_first_entry_or_null to simplify find_dev"),
> and commit 10379171f346 ("ksmbd: use list_first_entry_or_null for opinfo_get_list()").
> This site was missed by those cleanups.
>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Thanks for your patch!

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>         u32 crla, crtb, i;
>
>         /* Get current processing virtual descriptor */
> -       current_desc = list_first_entry(&channel->ld_active,
> -                                       struct rz_dmac_desc, node);
> +       current_desc = list_first_entry_or_null(&channel->ld_active,
> +                                               struct rz_dmac_desc, node);
>         if (!current_desc)
>                 return 0;
>

Note that proposed "[PATCH v5 09/17] dmaengine: sh: rz-dmac: Use
virt-dma APIs for channel descriptor processing" would remove this code.
https://lore.kernel.org/20260512121219.216159-10-claudiu.beznea.uj@bp.renesas.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

