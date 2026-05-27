Return-Path: <dmaengine+bounces-10982-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMOVM4dUF2oPBQgAu9opvQ
	(envelope-from <dmaengine+bounces-10982-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 22:31:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325555EA155
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 22:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24DA3004239
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518553BC69C;
	Wed, 27 May 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMQSo2IT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9737DE9F
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913583; cv=pass; b=Ud/j5FbcuSXrBw5bWvhnH0g5D4/7s9h72q1EiMjMS41+ABu+v6z4HQsXh1+iDONNNnvsM2zuV1/5zAF4CtGfoWDfmWAG6bms7s9t7YflYHdZEjq78DJrSltmueDuIMjiJDHJlf/xa9WUsb9GDpmhYhiamYf8MMFA/pEbdF7KQuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913583; c=relaxed/simple;
	bh=9ilHRorBZ0X912H/r1Yu6Y2Ie94pH6kkbR3ZPjwq1D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SluJdFyQYW+pYkcXSa2un6P93h92VyKInqC0ic6lTbrAmXG3UKlLjf+g6t1W7oAN14NAYm0kabIAPOWJxSGmpWR4wHT3JvssNbw2ftM8oiHxylGjLkWca5OI67j7MUqXH0Ja43BYHVVN55r2l0Bh6PUJKiiCps09qISpkgB3Y80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMQSo2IT; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so4216579a12.2
        for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 13:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779913580; cv=none;
        d=google.com; s=arc-20240605;
        b=auyoSgbiDKIk41sUONgJ5hIb7eXtpm0FMCmQQ6gwtoovx51c69h/TYs/FfEoiIQL15
         YEB8Q7ADtitoMDLj6ALn8KiF5pqxJj0hGAdHPWNktta6XuSsBp07vGk2xxb4DunAI4sG
         OSNQp9nSLLTQdvWlWyj3p6QYeyeLVNZm08ecw444kB5Z/RWm4lV4so00xHuVKSxUhCp0
         YzmNOY//WJXdnHCaMZMIR6Zten2pRJRnjHvdW45sN5665WnywI0FVoA0kEvYC7lMJU4E
         f0vJ0bjeJo572kPizneRmqY9XOo0NVzU8O9OVUIX110iEBqr/8SUkIyiusQ0SlSNyvSw
         yGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lLf0B2lXTuAagcE2zAxmwrn1wv9oh/0KxMyx/SOt+9U=;
        fh=zKrfkZsN7O1Pvp0opFn3+s+6VsFXWLa8TohRq11Kzco=;
        b=ImwE8pwdsWtix6cdHq9GjH+9rnralidR6A8xiqMIhDxM38zTzBSJtnKmrht4+wDqyX
         lHQSGNkEUSvj3cjOcbttn/bdQ1HvOJDgLfWyA5MAklKmgV2OtQoRtZRjI7AEsRMJwQeG
         fcchu3ZZRDnOu3hWc14y5vXbcLH7+9nWVES5uHMBHK1glgJidR8vCJ9pDUFY/exkrS3D
         IqPqpY436oK2w964rZqvFz/xeRIur6uDXcKzq1w9VLGmzgoeB2XHTPpmnrHh3kKz4bJz
         tV1Ksrq0wFGwAsyo00fAfh+WQWalWj+izS3tzCVS4BdaXHsORXIBq1ZcYbVWvYDnk2QD
         oqIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779913580; x=1780518380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLf0B2lXTuAagcE2zAxmwrn1wv9oh/0KxMyx/SOt+9U=;
        b=HMQSo2ITncBtHBHkEM0FOOUZLxye8hbScJgr1AIm5Jns/UXyOAwWaa/K8hX+lcTOb3
         gXGGq2XA7fnfj9C4fTWDW+tF6K8YzTN2b0qhdpT99uMjDOIip+R/d0e0rUmZjC50b4LL
         H4Ea1E/GJBzDBvpVg7Uxy1082G5y3Y6Oz0RvN9b4/llTAJdCdgX6+qpnz+tIselwfASI
         MzLm/czT10tbUraPpUcwW6z4UCweyyH+IdzMV5X4KMCXT/voz4YAOZOPY7lyDza1RRn0
         c/sWsbQtruwAMwjXZ9LBVxvwDkZPSt95vIQZ+u5DfY1MdR7ncFrYuK3A6SwDDGZWvYBy
         SyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913580; x=1780518380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLf0B2lXTuAagcE2zAxmwrn1wv9oh/0KxMyx/SOt+9U=;
        b=UwrycIib2fdhZCPxjPfNDkF5hHRKbabgEJDRqiAbGO38mfUJOjsRHFJ2QFXxqcAg4f
         IXIfQ+nS9lhrPf1SMArlVCxh529Ik7Zd+7wY7HW2ylL1tHnBvNFNBK9dl+r+HqLMWUKb
         9NoYi5IvkobTnTKyN0MFEe2SzfFZCdrz+6JZu0NSqh/tXibIztFxEyMHwCb0pjkagGkq
         czCZhuCMDIDhbauPL+GZxKUW+wURX4ySsiGCBK2DDv4lF6KGTjuu9QjcRlDv5AUgrMCj
         kkLF0haZy+LBDtyuc/Uxzu2Ods5Fm/j0GhfW0NCEUpBJOUE1tzXPDdxei5S4S901J6AE
         8k4g==
X-Gm-Message-State: AOJu0Ywb0ECrYegp6JWSCixAtV/v029E8ahh//Xr4uhlwUP9xdZt2lxg
	FbcBgqFV8/ww4YalRcMiHYdUQfuUvln2m1suEhzRL3d12NUp9ub3GLgubAlXZQOcnSzabvOpzNa
	7bHqYGRnYysQmfqVPe49HLUHoxXUGMvo=
X-Gm-Gg: Acq92OGxGI3N/00Ig27PMICjWbenDaFnw6LRb9fRfGq02UivglF7wL1d/pNJuqJT8Y1
	SvzhxXlwsqXCWsVTepUj2Nw9edL6ZzrphZHMzAJlQ3KfRILszhYobpcx8UPU0RtQNVKa4HjYP4n
	fJutzDhI78jKbhp2f2rQpInugcExTAl9d1VhOspXUsmFEMe2/kwz8m28K2pEJ8Vx7cRZFb59jFf
	F5BURHZG7d73HvAcswPWyK+xpwRYeVAdAvhxRYkCRT3mkuvS1zgu2pTUrynz9IaMEdqUxOzZJsY
	6n0XryULIza9GbaV1AIWpEKJBIdjcWGyTpWiW2T6UBdnBrPuIYtgiKKRQJP3eHsnfi+uKF1EvJu
	HxmAvff8v+I5ewpGPCTpA5zzXmJhagwnncmzmv5kD8YFPTSt1HyOGlzZKiw0KA+btkmOl
X-Received: by 2002:a05:6402:34cd:b0:687:50e8:eb0d with SMTP id
 4fb4d7f45d1cf-6889cc31c6cmr13916705a12.18.1779913580018; Wed, 27 May 2026
 13:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526201552.13376-1-rosenp@gmail.com> <CAD++jL=W-gcheTLgfJvFU4CBeHkxQ5gcwbzQA10PNE0eP0=nxw@mail.gmail.com>
In-Reply-To: <CAD++jL=W-gcheTLgfJvFU4CBeHkxQ5gcwbzQA10PNE0eP0=nxw@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 27 May 2026 13:26:08 -0700
X-Gm-Features: AVHnY4JA7Bib_4ETy4nwVSnN4xa4_8TtiQ4AHOQlz8ur560fNiVMHeOEctwVadk
Message-ID: <CAKxU2N_UzRaaG7GU4G2utRiNcdWTL6GCQuYWnhXd_jOHAiMOFw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: turn d40_base phy_chans into a
 flexible array
To: Linus Walleij <linusw@kernel.org>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, 
	"moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10982-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 325555EA155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 3:14=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Hi Rosen,
>
> thanks for your patch!
>
> On Tue, May 26, 2026 at 10:16=E2=80=AFPM Rosen Penev <rosenp@gmail.com> w=
rote:
>
> > Convert the separately-offset phy_chans pointer to a C99 flexible array
> > member at the end of struct d40_base, and switch the allocation to
> > struct_size(). The log_chans and memcpy_chans slots continue to live
> > in the same allocation immediately after phy_chans, indexed via
> > base->log_chans. This removes the hand-rolled pointer fixup that
> > recomputed phy_chans from base + ALIGN(sizeof(struct d40_base), 4).
> >
> > Assisted-by: Claude:Opus-4.7
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> OK!
>
> Please add
>
> unsigned int num_phy_chans
>
> > +       struct d40_chan                  phy_chans[];
>
> and
>
> phy_chans[] __counted_by(num_phy_chans);
Not possible here. The allocation allocates space for both phy_chans
and log_chans. To do this I would need to split up allocations into
two. Not a fan of that as two kfrees and two allocs would be needed.
>
>
> > -       base =3D devm_kzalloc(dev,
> > -               ALIGN(sizeof(struct d40_base), 4) +
> > -               (num_phy_chans + num_log_chans + num_memcpy_chans) *
> > -               sizeof(struct d40_chan), GFP_KERNEL);
> > +       alloc_size =3D struct_size(base, phy_chans, num_phy_chans);
> > +       alloc_size +=3D sizeof(*base->log_chans) * (num_log_chans + num=
_memcpy_chans);
> > +       base =3D devm_kzalloc(dev, alloc_size, GFP_KERNEL);
>
> Please describe exactly how the ALIGN(sizeof(struct d40_base), 4) require=
ment
> is met by the new code?
Will do.
>
> The phy_chans will be read by hardware which depends on this specific
> alignment otherwise the data will be corrupted.
>
> Yours,
> Linus Walleij

