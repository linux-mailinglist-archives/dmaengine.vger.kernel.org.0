Return-Path: <dmaengine+bounces-11513-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gTiHKnixL2pnEgUAu9opvQ
	(envelope-from <dmaengine+bounces-11513-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 10:02:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0EA684614
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 10:02:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Tc0j3Zp/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11513-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11513-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A4433006787
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26743BED33;
	Mon, 15 Jun 2026 08:01:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF243C09FE
	for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 08:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510518; cv=none; b=k7CvqdneW6F/36/sCvUoWAVfqiOQAkKsQIyjTVyQ9TAYQ4xxC03EuajAuwZdrYJHW9Ir8yxQrKJA0pfuVbMScxWKJkBC8XvnvOC2YzJtBw0jochZM0H2LmmJLYRVE7D95taGzZq4al4nYBPLoRjvODGdbq2mNdv3M4gFSNvxLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510518; c=relaxed/simple;
	bh=dYd01TaLWp+b1weWv03OfjwDWGyIew+KlNl179rn/70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ib5WUpXnUfX4OSZoQ9S0CNXnwxuox587A48Rq90fKImz8bp1tBF5bcYxmzh0JY3wFIfi4PrmmZ7i5FyuFwfaYnBCQ9c303Gzddnh/W1eKi4wf93LLgYb8G26FgsdO7OOMaIrXO2Ak1PjivP3zmgxW7n+/uM9Vw0ytdcB6qYtEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc0j3Zp/; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8589498839so1167566a12.2
        for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781510517; x=1782115317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYd01TaLWp+b1weWv03OfjwDWGyIew+KlNl179rn/70=;
        b=Tc0j3Zp/eCEhhTbHRrzP0hZvcivE0V2YNTMUURGaK6u0ZcoMdof62qQZcbFMXR9yjB
         +Ce9s5qrx0OkKBzFGHjQfHcsU4uiKNu9j73u2fjzB+dEt2TUKUYbe7MaXsUEKom+73XZ
         m4dfDWl7rfe2FMJoQ/ktEcQFgGXSH+IhoPn52/QU6pSryVv/xTeP8monETKOaCoC0R6u
         jQm/piHyB2/LqKrS8uXNa9rklLEgaR6u2gSb9+FvOfmuMccHHBIWJ4d4yuFwvauBJ1ac
         PfpIL9dTkJQCwgc+9Z5hK3zCwUs5xO1K8d2Ruky0IYAkCOU6Ze98w0HreM04ZXXPjqK0
         GX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781510517; x=1782115317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYd01TaLWp+b1weWv03OfjwDWGyIew+KlNl179rn/70=;
        b=LEKWb93zTLc5eb1/GOTNByM8wCbLmLni0lxktMPAUFJ1l4FNdC8dO/F1HZgSmfsU4Y
         srtcMA540P1Nfi3cY8Uzzblv69gSdSP2EZ/s7BFyBWLE3HLzBjGNMc8etGXKazdVKX6w
         r/Ujl0UzB3TxAD5ufhjAy1GZZeUUrSjt4QGme6W+x0d1G7PQEbfDkUvceK8Vanjh5ktZ
         bfSoLZjOSJUcO4doIDL9IRueTjL5B/dJ6ptMltodmK9A5MP8OMdPK5hWKg+tWyFrdRBN
         dLie+EyIlGWiUOWIoJL4yT6km9Iiq1IjT05BF7MXnmwlVyZqg8SEsxqHNRNWFvlWTFkg
         GzCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Krr61KAZNndfsfDZZjCg+HLTaVO6HR/zC27teXa6N6ezBMy4+ndvad0RWKbONYkLoT54Dhr8YeZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqOvsZs1F9rDK1bosY1CsVwum10j90C/Z6NINT7vdDxp7dam8
	WSljKtiwJ4/ajRBp/WAJqGh1UqILYhgeR1P44u/lzncylFZWBa/N2oQm
X-Gm-Gg: Acq92OF3kULwGA+pxfmCH1w4hWLjjHOt/JmoKIHGxEvgQoNg0AQgt0VXiPmZyJ0hp9d
	cpGa5SrOfL+fwpZmFuGU0tLEGcwZ1oY7ZSHvexjFxZf/odZ5FLoQeNbp4fxZUzhjVVxh68yQk7s
	8zKMQ6IhJmSETwVj9oflQJQllK6bLurvX2Cqz11+Zmt39dqTEfe5lRDaK+zjeUkuSzo9UzhNS88
	hg9kU1a1oo3isM5TYK2CsRbSJwfQWcw0XVQyJ2sOqVBw5Yz7hl3vJ6gr1SNgY0O4UiwUEgYiZew
	pByHf21Wa0DkC/vkbQX/jUcE1wHVLuCFKo8RgnfCOA9OwFiOBg3fZCAYGSGZ6bI+wos4Ctpe9N0
	AsjDmgDtV7WtVW9rQX7GP3B8R24zRCp2Dduzo0lehJbqX44l9pq4Smilc8LPKiR3rgtgJmQY=
X-Received: by 2002:a05:6a00:984:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-844e1596c86mr10840924b3a.0.1781510516767;
        Mon, 15 Jun 2026 01:01:56 -0700 (PDT)
Received: from localhost ([2a12:a305:4::302d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b055095sm10890663b3a.57.2026.06.15.01.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:01:56 -0700 (PDT)
Date: Mon, 15 Jun 2026 04:01:43 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Yixun Lan <dlan@kernel.org>, Guodong Xu <guodong@riscstar.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] dmaengine: mmp_pdma: fix wrong extended DRCMR base for
 SpacemiT K3
Message-ID: <4wo2ylvv2v2kmec4vzycgide3orx2zwjzdjunfm23t6pclknbl@pqtb7lw2parx>
References: <20260615-k3-pdma-fix-drcmr-base-v1-1-ee1af124199f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615-k3-pdma-fix-drcmr-base-v1-1-ee1af124199f@linux.spacemit.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11513-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:troy.mitchell@linux.spacemit.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dlan@kernel.org,m:guodong@riscstar.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,spacemit.com:url,spacemit.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E0EA684614

Hi Troy,

Thanks for the patch.

On 2026-06-15 10:53, Troy Mitchell wrote:
>K3 PDMA shares the same DRCMR layout as K1, where the extended DRCMR

K1 never touches DMA request numbers higher than 45. It's not K1 who needs
the extended DRCMR. PXAxx needs them.

>base address is 0x1100. Commit 6587b8661a0b ("dmaengine: mmp_pdma: add
>SpacemiT K3 support") incorrectly defined DRCMR_EXT_BASE_K3 as 0x1000,

The SpacemiT K3 datasheet still 'incorrectly' carries the base 0x1000.
Refer to [1], Section 16.1.4.6 DMA Connectivity & Assignments
which still states 0x1000 as the base:

0x1004 Request for SSP0 TxReq 0xD4040000
0x1008 Request for SSP0 RxReq 0xD4040000

I would recommend you double check with the SpacemiT team to make sure.
It's better SpacemiT can fix both the online document and downloadable PDF
as well.

[1]: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3/k3_docs/k3_usermanual/16_peripherals/dma.md

>causing all DRCMR accesses for channels >= 64 to be off by 0x100.
>
>Drop the bogus DRCMR_EXT_BASE_K3 macro and reuse DRCMR_EXT_BASE_DEFAULT
>for the K3 ops.

>
>Fixes: 6587b8661a0b ("dmaengine: mmp_pdma: add SpacemiT K3 support")
>Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>---
>This is a minimal fix for the wrong DRCMR_EXT_BASE_K3 value introduced
>by commit 6587b8661a0b ("dmaengine: mmp_pdma: add SpacemiT K3 support").
>K3 PDMA shares the same extended DRCMR base (0x1100) as K1, so the K3
>ops now reuses DRCMR_EXT_BASE_DEFAULT.

Before we flip it, could you please confirm your source fo truth:
did you confirm 0x1100 on k3 silicon with a real DMA transaction,
or from the datasheet? It would help if you could share your
test setup.

BR,
Guodong Xu

>Best regards,
>--
>Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
>
>_______________________________________________
>linux-riscv mailing list
>linux-riscv@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-riscv

