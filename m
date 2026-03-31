Return-Path: <dmaengine+bounces-9749-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEN8OSpMy2l8FgYAu9opvQ
	(envelope-from <dmaengine+bounces-9749-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 06:23:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C3363DE8
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 06:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B982730475A6
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 04:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA762D061C;
	Tue, 31 Mar 2026 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxep4wGE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C928313D
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 04:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774930976; cv=pass; b=A3XLJfiRo1PuKZX25Nb3KKd2uzROJsuxeawVOyq+vTvIytTstICSNLkZXgIOb61wzGr2VsAKQv6owCRvblcy1WpOmLtWlPRAttqjmxzc7CzgoPTXQJRe5/WVpPeNheN1btMvcBZ7P/FVtnttcnNml5gWGukDpigCWG7+WPYcgbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774930976; c=relaxed/simple;
	bh=NSqB6sbdhcQ3OnW4/F5YY5A0GRRZ8UXAuVbykHUcyjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlox2UuZmOLcdh7XVdv9myFFd1fws6u1ggvE7T6yy6CdI4b8uXAPHlOp641kFXWI2rV+yOkNXaOB/D/5ADeU8N495UqBAs+FqbvFIGpMrHHM9vZkkMYzXQt9pI1+b2NUXITpD1P3meG2rkDeoY7Q+G+C1w5yi6AHiTBXqSlrwtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxep4wGE; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso712165566b.3
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 21:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774930972; cv=none;
        d=google.com; s=arc-20240605;
        b=a6zmjDEHY4qJqUGRN6IMJROnFIlxLu9Ie63NY3PJR3wuIBb6A0xZa3DVj/0lyBeew6
         zXxKOZoUxqFbGhMdStz0mc7brcrtRuo/pPhkH+sK0kdE8iYcddMsAJ+HNrRVZy0LzUCG
         v8I6uUmCm31KiAP18esKRn/eYOb6O2P8c0LfhYt4n6Bk5zvMR4kIH9Eiqib6PrlQHDgP
         8yBF3oZicRjN6jqTlbc5Np4FOwI69yaTXwJxgLLs6N6Sx8c2FGFHSEASCrPmV1zWvgP3
         nK/WixC6zviOvdkE3XmNUAeuabe0Lc5trx0KuN6ujNNLqOnG1Gh5SUqKB/m/CVJFIVKA
         XLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dXMSM2eRLyjTHWR++MkZjcaDX6p6EgNMKstE4GWfn0=;
        fh=22r3XkhgFXYlo01h1jYb+ZSltnvR0YVp6gSI4ip4x/I=;
        b=SJABxNSdQnOQ6AFVMqoFJ+fA5r/HkW66bhNfKZh6wrMDo3qOvwHCkYOOO2phvy9T8v
         k4s14JsFFtr36n1OurbBNcKmpbztqvifZhOlSq+K4zMf3Ad+04qfRLjV66ykYG6lst4/
         6oKJVPx8OwCl35ua7nLs84+GEatsnQQKn9CiEi+78qlH7JFZYPWtXEUXCoBSj2fdMvp7
         qFXmCtsSqmopRP737kmUHRSbFVZOktBbD9Zl0rqh5/ufqjBYyI/bV6SpWWccOKGR0pCh
         +/1WRWMyyoC1XrseyDqG/A6/8pQSS50477QOpvNRfTplXhYzKHDrA9qnUokETiZVJWzn
         Hdig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774930972; x=1775535772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dXMSM2eRLyjTHWR++MkZjcaDX6p6EgNMKstE4GWfn0=;
        b=Kxep4wGEVMlcYWlgs34n92jydYrio2/dUzGnqCTn3lPzs8lwy9bUzEKV9Yeho3Jwp2
         BdMJfm89Z734D276GcZVWr+PG2GKQMr3kjWee9JzmsECM/STe8GvW7LWeVuRA4MZFlgU
         thlSFT+iSu/ja0nm+xyOjfD2D5/oiCE66kayUHCBhskcfNsnqBjoV2pkZHqi6MLfagoM
         astSTrUeXUAVjA5QIlyAxdC9z26zd9Pq1Yf9a1s3ZYyOSSIqohJfwP4zCf8mIPe5YCPJ
         o5XpnaOUX1/eiq5Yl1sfTEvA/enL6idQ4fBI/6SdV4wI2z6aTVOPnMRDwCQON6AoY6Yd
         rDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774930972; x=1775535772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dXMSM2eRLyjTHWR++MkZjcaDX6p6EgNMKstE4GWfn0=;
        b=VBgYaQHURsCkXhDwuyzp8AWjlQTKGOguOl6MCx/isdFdyMVt5HHB4xkW+WqpDtd3NN
         2hj6NSvDq2bM8+M6mPVf1fu48RLdyvhe28OyWCML31p966xEjgd/mJ9+8S1U8v7dr4Vi
         H8VJXG/oboQTy81fGhyKRk9C/IMeMFfXtLvfAk2irn6g+hHHvzYjoueFlFAq/Hk2xscG
         xpI57b5bIhY3uVOXHEzgg0KVal5UVPbhQEslshMk50E/Hint5iy+S4rAen+ZcWCOveo7
         9/7p36NnL6kFVzd6NYzmY4QmTfEYdeZcBQ4gwFuJ4+EB3ATpJAvQ0payVnG8BFMVBmZ4
         LyAQ==
X-Gm-Message-State: AOJu0YwRGWUdZ0Bkg6MBgmjGmpB9L/LMfgAHTZkORxWJ5KM/mLbqVdkI
	uHnWAtpsPvYpCdfpeo+MZ7bPlUYGOa/gPm63t+B3dwc8COAKo05rLhakiGoXpaX3vOJ5hjqEExq
	6pGzv+taoXaFC51/uigLvsI8rXx0kwEE=
X-Gm-Gg: ATEYQzxKPzgX3d29QtKRXEIj3VBc0DG8u+irZqBa5XIxHrkmJEchF0xHsVa9GRoIjAW
	BKBycPWi4Z/Aex4ya4Gvt/470SWnJ1onQiGn79deNkCU/ZY/ufKIOSQC4CSk4DEJP0vFOIR/EDX
	B5+GnmicJ+Wo/fDS6fZOpDAiigb9Fi4q8kfGFEP4UnTEmIHttIXO0u2rL7qecTYLnoevweZ329H
	5dPpxjkrrye2jHScLl4pnuQrdDOg2+zD7SVNCO0c1pWWT0s4jM+coyUA2dMPmg6lleOy1EDcX8L
	bHaDd7+L0QlXhp9w43rDBu+KexqOLqrP1i6+3S29n72G5PE89Qr+I7Y7YmsggILIF0icOWARzwU
	X9NH/YT0=
X-Received: by 2002:a17:906:9c94:b0:b98:cb6:e896 with SMTP id
 a640c23a62f3a-b9b50909b02mr876341866b.38.1774930972041; Mon, 30 Mar 2026
 21:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330204357.4476-1-rosenp@gmail.com>
In-Reply-To: <20260330204357.4476-1-rosenp@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 31 Mar 2026 07:22:15 +0300
X-Gm-Features: AQROBzBYmALAt9uHQ7w40EAQW2oCr6D7chgmGfIIFE_J3Ha6PyD-WduaTORBDdA
Message-ID: <CAHp75Vc41xfSKq+4GTac17JNa7L+_5WNY_1EVOxYTkHEeym65w@mail.gmail.com>
Subject: Re: [PATCHv3] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9749-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC9C3363DE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:44=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Simplifies allocations by using a flexible array member in this struct.
>
> Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> this single usage.
>
> Add __counted_by to get extra runtime analysis. Assign counting variable
> after allocation as required by __counted_by.
>
> Apply the exact same treatment to struct hsu_dma and devm_kzalloc().
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v3: update description.
>  v2: address review comments.

Wait a bit, I still get it unclear. Let's continue the discussion in v2.

--=20
With Best Regards,
Andy Shevchenko

