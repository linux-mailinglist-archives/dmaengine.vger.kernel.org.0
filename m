Return-Path: <dmaengine+bounces-12169-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2U2XNnJ9T2o4iAIAu9opvQ
	(envelope-from <dmaengine+bounces-12169-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:52:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E40972FE50
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:52:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="er7/5bzj";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12169-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12169-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59DEF30B859E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE91405C32;
	Thu,  9 Jul 2026 10:32:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B10405C21
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 10:32:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593159; cv=none; b=W525orke9Okp8XpDaOeD62oQ0qEr2Kmz5QhDY6waWn5fDcu8ge5Fcgu45ksLhqcQolx8egtXGKJQpOvte7jotjli1un2sG+pIbgk65aXtBTwXTe4U+TYChNpv+ij7NXEMRF0LeLl9uxV7+mqH6JXzd0cKnGdJa+5xsSjNlnEff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593159; c=relaxed/simple;
	bh=hhoTDi4cE8nBlTydhCg8xgeJgn85ch/Nua+FrdtzYVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAUJcBzKzWKsSjaiCBL/CG2t99FF1IEckCXvzISDR7ND1gcthGMIsMnFgGjAfhG1lWcRmYCSfzq0yR4dEECJxZpujs2ysgKLZgIZ38kJNUDOAdgG1E9Fcwyu84Q3SHUVR3jlQrpDXOIQTJyIDq8FB1wUmuTuGWl7X9I+hbSwx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er7/5bzj; arc=none smtp.client-ip=209.85.210.47
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso1022720a34.3
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783593157; x=1784197957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tnOfuF8AUfrsPAGPhFNYnroM0tYE5o0tbrD/pBbOhls=;
        b=er7/5bzjHqGgCZregc1XNr2SmRmE5gg8klgEaQFFKAunGBrXTY6kX+oYm+oVcx/+Mv
         dXRXr2sI7ivAkC95jSdJdIitHyQdmI6NxorW67KMWDb9Qepe0tzH9Uf8o2ggUGhsqDX1
         ySqL8lYfdaPenf/PlYDXbNm6WnIsL9e3SvA5oYQ7oMjZkvF0xL+QLt0ZczMqZD9RFCp5
         8u6Lkgh5cUcCxKjp5xKnOJJqh4boOtekVceIgHkaenx50VUlvAgfsATbHZjdu8gruCUu
         kiRrAQ0+fDkkrbQdG9TUtHg6VA320M7hlL+JCGPJEYQYgXnrB7Oa6slOisaU8Fcs72oc
         0yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593157; x=1784197957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnOfuF8AUfrsPAGPhFNYnroM0tYE5o0tbrD/pBbOhls=;
        b=YbDDLuJVyHeWYBcg7Ye8+ZZ14Ffmfm5FXzQ+euFGqkfvKgKXI6w+zAZjhoxLdRowx9
         iQqksknoVplrGFa+ZwLO4aNZMW6enfdXjBBQ9EebEQjarVKv9BFCsbmulAa3N04GTPZt
         OBJPMa+3r0GBFh5mOzoVHizGaLmKodoCeV7OwGKZNDIHfnbY0vFdFMrRjTkISJibZ4gc
         S4JYq+jsIIFcjgwnB2suNDBAfbMhAwGE7FVvhGQlf9avpla6QRfD2PLHVhWfPEmfOtvz
         Z6p/Uuz0QhlyF3xfANVWsX+mUJ+kCMpTLWsJWiNZzOTy5Bqc6cQp1UMN+aizDQa7Box/
         ePyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IKQtoj7iFXXlMf61QVACwzOGmrOoRJXk1jILBLGHwLDgC6MjLXSqy/itqBtu9qiFtOO/RZjXQBNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLiRyPrhuTGqmyWhsX8D3SH2iJW84S3wrRYjWssogqUKijysqb
	BK1xV4pDVVyvq2D92WsbW1nr8/Sk+fcPTgqEJPMufalMU79BxqJPHScY
X-Gm-Gg: AfdE7cnIRS26nvTPxM32M36hagLKXTApc83zN3VM4idYzFJJonLbC4HaR4HsdhdpCgu
	WQeD6NC5DhcWXzPHgeCmtxvoSPvKvSM6dOaJHETOgOHY+yM9IsEl6GQ8RCDttb8gG2R2hnh4YzW
	a1svppEEg3AXaITQxfzQQJkff+6+KhMz0JftOrzauCgq8I6TuGnu+OYZwV+rAtYu/poj0nCW9UA
	ELX05dlT1WaLFegXhwz+mwLXwWG0amAcirLzlclq9Iymv8trLekUCsB1ENziVQsXOCle2THIVGy
	R0g7h338KlqzoXDzH9PuKshkuwhrAkK7NQRhv6z7VucT3c0RBgZIfwiXndzocWo9BkTx2j81MtP
	+ppZozPwaMaXOJOXOR4z0JAL+zfxkYa1JJT3qV8HYSXv9G7lX+6FXggS1okgUMJTWAf9iBHPt9X
	Wp0AMnlnsFGkrDxpU=
X-Received: by 2002:a05:6830:6609:b0:7e9:e9a0:9a8b with SMTP id 46e09a7af769-7ebcff5f37fmr5352948a34.16.1783593157222;
        Thu, 09 Jul 2026 03:32:37 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae1ddb8sm3865286a34.6.2026.07.09.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:32:35 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:32:29 +0300
From: Dan Carpenter <error27@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	christian.taedcke-oss@weidmueller.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <ak94vVkvQEocJuSI@stanley.mountain>
References: <20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12169-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:christian.taedcke-oss@weidmueller.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E40972FE50

On Thu, Jul 02, 2026 at 05:28:03PM +0200, Christian Taedcke via B4 Relay wrote:
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc..bcfab62a71d7 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,14 +1374,12 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs == num_channels + 1) {
>  			struct nbpf_channel *chan;
>  
> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> -			     i++, chan++) {
> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] == eirq)
> -					i++;
> -				if (i >= ARRAY_SIZE(irqbuf))
> -					return -EINVAL;
> +					continue;
>  				chan->irq = irqbuf[i];
> +				chan++;

If we don't hit the continue then this could still corrupt memory.

regards,
dan carpenter


