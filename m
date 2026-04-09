Return-Path: <dmaengine+bounces-9945-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAY2EGPI12k/TAgAu9opvQ
	(envelope-from <dmaengine+bounces-9945-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Apr 2026 17:40:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A23093CCDDD
	for <lists+dmaengine@lfdr.de>; Thu, 09 Apr 2026 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86014302D0A4
	for <lists+dmaengine@lfdr.de>; Thu,  9 Apr 2026 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E83DEFFE;
	Thu,  9 Apr 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UOdYSeYx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858D3DA7E2
	for <dmaengine@vger.kernel.org>; Thu,  9 Apr 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749095; cv=none; b=nT+VVSeOqVlzRhDCg5MBCT4xzdN+Jd7LPmoQsQr+VrhTNicww2vfsYW6/559DZRUWRjDZHDWekpME8W+3JaSwhpBFonaCdnVqO59useHdlGmaXDlW/jAEqHTp2K7wDrUTxudupe3RC6e74yH3MnBL7bcMPt34pDGgb4r+s/LbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749095; c=relaxed/simple;
	bh=PqPVYuoHcB9VbWWRLwQgWRPkMClKIoD5tzzfx+rg4LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=squINQOMhjZWuaLMfxWuZjsLpHdNzNHyC5meJ8gyz8Ip1WXeZ3X67uToAQaMjeptwySPC5SVL8CqRpq1J+CjXnyaDLTAjRvdYM0DNlqhHssrWfD3f+x2NwbVztOgiht9X47F8sIbVcKaUrwDJppXb8FPbD7vx2IQe6Jv5ovk3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UOdYSeYx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c280322e0so125909066b.0
        for <dmaengine@vger.kernel.org>; Thu, 09 Apr 2026 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775749092; x=1776353892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=umW1IQdOAOPjgPj9z57AnteG7vvMbaLS+TiyzZ/vV5U=;
        b=UOdYSeYxBkrY4xXeHsU2BtzwnnUs8iRhJnp8SsbNVNMj9b4Mzkq/kF4accTlBr2y0u
         YCBni/Jp5wq2IGej+vSZOSS7d/7aTKNlbzYird9r46gLLDZrzZINeHbQZOhPSF0crYcU
         aJ5u0wLqw8Y4fesAnL+vAiIKCh5xzvJ+3CvP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749092; x=1776353892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umW1IQdOAOPjgPj9z57AnteG7vvMbaLS+TiyzZ/vV5U=;
        b=SyT5pAqnbuMXgK0BlutNZU6QLsC0GghxCRNJ7TH+PcdyDjTSb/CcrzgycneaMul2iN
         xBBnpToIjrvFFNiTIhGie1KCXRVLgGH/MkZopBq7XBMxfnE7gcqEhw7URTvuXuAZvqxQ
         +sJsnIwebZZAkeFWNSiqCbkHQiaFAIdxDcYuJBC9yHxSkJJQzkRAHxTHzu2ESAmyhzzN
         DLPU/c2Rd+IMRyq2imtEjeufiAnjJTYVPJrFZXTmbnx8LxwxdMxIJMEnwyXGH7cUeTeF
         4BdWThTvh7NaDmpP8vNbNMHNqmcBlvhbjq9cooJOQ9kYNDmPfSMT3FyFgX3FyTeUjtWB
         I9cg==
X-Forwarded-Encrypted: i=1; AJvYcCX8WATv75oY88P7hkxUwlVcto1pMb+kycFpb/yBWnhqpWz1n5gUkklCR+XDEDo2SuRmEn1xyYzqn1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CP9PDsU5SICQqDvtz2+9RqULq6JDu82iGUavb8gr7bn8pGXe
	Dy2h2EfhmT2r6ndLEivMc4lQhJmgs/0Pf5PKfDvcw+vnye4oMYuhakSxKB+UxBJkkIIhgenFOtB
	lsAXEgfc=
X-Gm-Gg: AeBDiesGMVeOvZLooMJdtqPxCAKGegQCXHgZBKuKCW9eoWp04h2n593nGiyasqJ3+Xt
	8dNWsW+n5bY8VeJxMyA4umH35RRBb+MUaExC1SVE4Ufnb7P2+7mNaR/jcc0Ukkq2JljXx+UkNHC
	0xw5y7xFUoQjv+4/62DR/cOvmBSq3MvivJqW4GnXgD67khzaJY3WxNhpyXG1yQ3AZbE9mOGxqtg
	cRXuIZOVTuIEW/sethqSm5BQspeym0IwAcNtRXsj9vTAUWu1GcKd6/bsQwNx02Ew/COZycl8aVW
	plG1aWmueeuNbAYiwVf6BllgwoMEbbdoLwD/oe27rsKxY/ZeUz/okauw/WNmHPR3ZbY74UwvcHu
	bV3nhHPu27Dk/Bfei8r7JZCE2WiRzPZMYiknMKK/PiaKboTghXkljO6R0DSpPkbmIE2b3eYnB7T
	xpi4/I+RzSH+NRJHlUHArQxDT7Q3gGTSYGWMXx3j5PqhxtO1U6ntfSsDziO2Q1cGDNdd70I8ET
X-Received: by 2002:a17:907:bac1:b0:b97:1d24:bfd1 with SMTP id a640c23a62f3a-b9c672fd90fmr1172139866b.13.1775749091913;
        Thu, 09 Apr 2026 08:38:11 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c54casm3079166b.29.2026.04.09.08.38.10
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:38:10 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b982b0889d8so142682766b.2
        for <dmaengine@vger.kernel.org>; Thu, 09 Apr 2026 08:38:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFSopaD04Pk+lsJeYldhmIPQa8vLyN8Q2cOywz73ZmIHhjO8uvb0pG/ioFjagZAv1QSa8/8Mq7YDY=@vger.kernel.org
X-Received: by 2002:a17:907:6d0c:b0:b9c:94a3:317d with SMTP id
 a640c23a62f3a-b9c94a3345fmr1104212166b.37.1775749090683; Thu, 09 Apr 2026
 08:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk> <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk> <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
 <3a1d0520-3402-47b2-9d7b-4e14a3cd07a4@arm.com> <adayAMR_dEA6W5vW@shell.armlinux.org.uk>
 <adeaiSAnkaggqPsA@willie-the-truck>
In-Reply-To: <adeaiSAnkaggqPsA@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Apr 2026 08:37:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
X-Gm-Features: AQROBzBMqgTUhWghYpRNIZDpsOWA443UoVRzdGjObC6SoT9V2ssj-2Muj4chrOs
Message-ID: <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: Will Deacon <will@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Robin Murphy <robin.murphy@arm.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-ext4@vger.kernel.org, dmaengine@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9945-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A23093CCDDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 at 05:24, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Apr 08, 2026 at 08:52:32PM +0100, Russell King (Oracle) wrote:
> > What's the status on the iommu fix? Is it merged into mainline yet?
> > If it isn't already, that means net-next remains unbootable going
> > into the merge window without manually carrying the fix locally.
>
> I'll pick it up for 7.0 in the iommu tree.

... and now it's in my tree.

               Linus

