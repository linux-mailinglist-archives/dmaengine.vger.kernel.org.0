Return-Path: <dmaengine+bounces-10533-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPTENVVIDGoMdAUAu9opvQ
	(envelope-from <dmaengine+bounces-10533-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:24:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822B57D855
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 902093072285
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EBC48AE11;
	Tue, 19 May 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B5233921
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188882; cv=pass; b=ZU45qYTPAq2wjhiaA8mtSBBqrPMmn/zoeNonJeyiBAdsz8oV14QrVukVPtlggW7y6esSoDsCefkix1DCnj6/1wQ9Cnz+cde+cVfxojv52wGqmfTiMaEclrbzAG/KrqNLNJNP0CefrHbe8lzgHeGQZ/9Z+zfii2sb160szreLaSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188882; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJx5MlhHfBSkXLWTKL7ijyMk0UCVz0wXrZhLAdoS5GvW96IM8hwpNRp/yloWdxYYVNxq2ksSQ5daxuGt+MJL5Z2IR5zemuz3IsB6101k31Q39pFxVqT4UJNG91Q+z/fDmxRhMau7OUWxqCDbmtbXL5Z09chLOtDkyhdhoL188P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f24905306dso284651eec.2
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=NQDUzRnSJgPoiIkBtVHOOH7JJ23p7B6BnBpRt4CRMDXS3ehT/5sf7sjrO45mI6yZBu
         X7CLUe9JYhVyGiJuEny+w10OCPgtv0Ptvzpk3KcixdHAZjRtUeZazvqXnPBp/r40KoOp
         E1sGhZyu+QAimsK6mrffvtEHXCGu1Y4Xp+kgx8UeOyNNT6zXH+EF8Hm4kaUWcwZKeA5C
         vIH8E+fOmeKJ0fK9dnvn9yGdDrtHLvDUD0THICDsBWnbVw5R0SY/aQ5XleMW8GexQmw9
         89HKfcl5xwv3UtY1p9w8wfpoOAljHpZHpaiCu+ZrXd8pGXdR3Rzq8aVh78JrTgpipsDZ
         0UbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=qKuGn9gPc/FH0Sjmx1A23wIBSQFlYaK7wD0frxok1e0=;
        b=VyOqYvvwk5DAKzErkG1918kNa/4pl7eGkCK5FlsUoVZc7SDBqjLin5zJM8DOTZfubb
         FA9ciC9SkIeAWhjpsVcJgfs5UdFdD4c8tqZlhfM6TCDDQG9HnmIAlVgWoua984BTJ9bj
         4WAg9DC25iQfLUR9DXtZW5ybvbA7QEgnwx0ONh92HqyrMx959IMQya5ggfTwi/l94D/k
         V6m+GJj+bpqeHjcbkHSqbZD2c2xjXU87LTtf2VCyu2D407hVtxycDhTeW/PskeNCKUDm
         8FHUeeOuRfoBrpVlLyXqd+0tZNs2209vjJ3CXAZfflzK1UkQ/mZngHLLIGnx3Dt1ysU9
         Kl1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=Lz2FTTqp9KtAaJ6AmSDz6d+yFGtPZ+99+PVOGem8Kvb3tNQLh69vxkkPPED5nejJd/
         CoxsX7QXKRcgiL/FA0ahMfby4Z1R7T0QXLTJ+iunSx9qLo0XsQJs1RY26C1Yug4rffhv
         Trzmbie2Md6QOSTaQhkBa9PVnWSVjbapt8hON/y072U/uDr/lWS+TuNYQ1SZz2h41wp6
         6Z+CLMQxZQ8bjL16CtRhYl4tvrOs0cQN4TtZOj12R3l8O5FuMbOyldeCeROjuyHYO2vs
         A32kO2u5t3x+ioLzEhTXw/h5dGq0zXzONL1M/Qa6bDNRorvBtx1vyh4PvxB7T38pK4Hq
         9gTw==
X-Forwarded-Encrypted: i=1; AFNElJ9ISXEVoBddE4ezBLlVTZHZuzl/Ab2T5RaOb4PYeUYMqZxhum0OUHGy3xHChS/MOTuud+HexvidI8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+8VKmxGKCS1gSMSG9KokEURLe08qYDtPiLBwyRbl2sLHPjQq
	UOvr5zVmmIHQECgbPu4rLs9QrhzXopQu7+0qo0qEvbcReXxVbKjrtHPTFWmXSwedxP8VmCElGbh
	gbGT8IvnH7hmugdgXGzpH1/rEbvheVO9Jy7aSyHI=
X-Gm-Gg: Acq92OFLlIUEG9q6Xcwiyi1NxRSXrHNiqmtHAgn7UL2QUkhPzE182YYR0PP1QnuOxT0
	KPfSH8VKHtIOIJKhuNnJLje0bvOIZgow9cm/Re1TqS3sVATfoLxlhallRB4ogNIT+Cf76wQ7DF6
	OekTgdhmT9DaPKe3cp4uW2iQcVusUTW+4lwLs0/tN2J13yHqRH4tydJbHLwETI+OwqaCyCOfMUw
	fjAiAjKGoRVUUFe2Qbo2W0hg9nqEpO0EiOWOCC7ksCkUBoFTbMhMxlSPs2lnt3/xQrWRHn0oU6F
	y5AyvQxD/fE0DlZ0KgLjdwqJb9C6erfyWX8+HbcpqT0Al+hljhoPQ0SrwCUaweT6iyEO8GVs0wS
	nSBw7bhXmb0v24N7LN66y8/8=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10533-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sang-engineering.com,infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens-energy.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0822B57D855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel

