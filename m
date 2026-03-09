Return-Path: <dmaengine+bounces-9348-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG/EMHPLrmnEIwIAu9opvQ
	(envelope-from <dmaengine+bounces-9348-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 14:30:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DCC239C36
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17BAF3010719
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DAB3BD622;
	Mon,  9 Mar 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVrn1Py+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206743C1967
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063006; cv=none; b=ZrO8UQf1gNuY/XTO1pxxyN06cMasIO/h0QKO4j9dSFTtY/noO+CBWuRs7JuFfM1fa3o0pHKK4bnLGWQ61HtjKzUkDdtO6f8wyM5nctw2zKDHwYJ71aL6Pbl+7khj47QnMwgS5K9No6H16NpVXQIFcCA/PgyswVTluWXVHasa8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063006; c=relaxed/simple;
	bh=PpfVwCq097ZFsJXcMKCNeDb8p8B+H4cRYTHSk7JIN/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nv2iGt8q6WmSizN1uXn4fj9Hh8PNDfApVPfdXQ7OsJrac0hdV1G8RXDU9HoFEmcTZv2rerEZ5tQR1NXT+0XcG8NCXAhFYSf9IuxcZf0tm3Ay1fcoVka3Qats4HHPX8gGI9MH4pkTvYMrn90lRcY29Oow7L9hi0zHCJuIHqY0G3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVrn1Py+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48529c325f0so19508765e9.0
        for <dmaengine@vger.kernel.org>; Mon, 09 Mar 2026 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773063003; x=1773667803; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpfVwCq097ZFsJXcMKCNeDb8p8B+H4cRYTHSk7JIN/g=;
        b=QVrn1Py+c2CpFw2CatiLXdvI8aaeEpL/g2nROlPV9y9RXtX5FMendTw3xMd/Cacypd
         rVt24uu6FMorjFBUKfJnKYHALEb0LjVHFRHC8bgNqKHmEjNC7lKGwPuw05D7nXATbrk0
         vf6O55vV/hiYZn+AkUxiow6DdJ3L0qjJpEe2ELHYZ+/2LHL7hFOAeT/zOfkiyOBASqq2
         Ui8l0VenfvLnojrdmHN2/V2YqY+KFu+fiJ5YEwZVqbyobpLjawtk9WQzf1Wkblnl5M73
         bh8Jl/qxbZe71hDg5QUK3Ehqt+SY1hJ2awQL9G4PNPAKB2bcscBrjy28Z+4+x/1U8C5M
         Ekhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063003; x=1773667803;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpfVwCq097ZFsJXcMKCNeDb8p8B+H4cRYTHSk7JIN/g=;
        b=jake5V/h1fMI9Ny0Xo6XoAoJ1ZbGFji/EuAlSQsLyfg/KFPOqillUV9ZFmX3igJagU
         pnMnqJSjTuk1DWIkQiqo01Gxmbr5Is9zwfFYRSOQDZgCvKfybUlFMPoUH+GnToeJw3F/
         ROfAE/EqF57KYEUNz68D4KgluIhJPGi8Sfa9l2dSa55YCmT958qjdmgSzBc/trKOB94I
         M90uzYUVICqK/I2lAWOf0Q8e+m3UmmQrCWf6U5wozH1h+D0C9Fe6654zm9aapkOt7z7b
         aB3nQiNvB1N/NpiyW9c58ey962UwPm2X3fx7aCK3MPdykIr1g/MGvv80EyEIWl5MKMVL
         RMqA==
X-Forwarded-Encrypted: i=1; AJvYcCXvu21ami6fFkGgCrqBe0JQl0mhzjq49Od4PEktFQsFdHUt+O0yuPdFymAqyJm40TxLPifFNMKcqsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH22NvlUXGOjvzstyuJpiOZYvaAnk9D9GiQT1FU3az+s78WJfK
	XGobh18khTSzZW/2bjxBp+73pPxLQdFj22p8qRzsp969k29QBIb7wIXX
X-Gm-Gg: ATEYQzxbf0081YfeM7hfhVy1Dj3fDXkoB4L04RdbqbLsaqcxQWtozuZrJRw6DPUs1IB
	PDygz+JuLt8BWAeM9TanUdTizpcaPd0dL/uljqAJMoGGW3f313xipihuntLEyQgKFgivmMHR8M1
	oUVcYgE0ysyrSMTz2vk80OY8zAgjBbenq5NpULAb5NzIqJjEZdp2+SKR8CkDn3q/pgUaJZ3WkiJ
	iuR8PXJqYxpteqHNtNikqP2sdp12wqqhmY0Po39PZ/seYxLwOdFreEoFd26Z/rLErm+RLEtiUSv
	CD13CsiCXHy2fu0UvDu/pAdHBC6q1G0Db1HgRN0a+pzbQCNyTZk5sBwLBJmq12HJGAg+2HmI41x
	Y4Yvy5sEPBIGuU9ZJhOIyvzEBjI149x8MrZCOoiUxbPcQJ2dfykuZA0RDtAyuLOBtcZ8sb3QoGM
	errd2WCgBEONXMULF8A8z6KO1qC4v+nMg=
X-Received: by 2002:a05:600d:6443:10b0:485:3bc7:a21c with SMTP id 5b1f17b1804b1-4853bc7b45dmr35528455e9.24.1773063003096;
        Mon, 09 Mar 2026 06:30:03 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853fcb6b92sm28637455e9.3.2026.03.09.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:30:02 -0700 (PDT)
Message-ID: <c4e7e6f071ce0e7dfdd624b3b31077e2b0f4e454.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] dmaengine: dma-axi-dmac: Add cyclic transfer
 support and graceful termination
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Mar 2026 13:30:48 +0000
In-Reply-To: <177304239096.87946.15531982345548560058.b4-ty@kernel.org>
References: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
	 <177304239096.87946.15531982345548560058.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D8DCC239C36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9348-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.885];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 08:46 +0100, Vinod Koul wrote:
>=20
> On Tue, 03 Mar 2026 10:24:59 +0000, Nuno S=C3=A1 wrote:
> > This series adds support for cyclic transfers in the .device_prep_perip=
heral_dma_vec()
> > callback and implements graceful termination of cyclic transfers using =
the
> > DMA_PREP_LOAD_EOT flag. Using DMA_PREP_REPEAT and DMA_PREP_LOAD_EOT is
> > based on the discussion in [1].
> >=20
> > Currently, the only way to stop a cyclic transfer is through brute forc=
e using
> > .device_terminate_all(), which terminates all pending transfers. This s=
eries
> > introduces a mechanism to gracefully terminate individual cyclic transf=
ers when
> > a new transfer flagged with DMA_PREP_LOAD_EOT is queued.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/5] dmaengine: Document cyclic transfer for dmaengine_prep_peripheral_d=
ma_vec()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 5f88899ec7531e1680b1003f32584d7da5=
922902
> [2/5] dmaengine: dma-axi-dmac: Add cyclic transfers in .device_prep_perip=
heral_dma_vec()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: ac85913ab71e0de9827b7f8f7fccb9f209=
43c02f
> [3/5] dmaengine: dma-axi-dmac: Add helper for getting next desc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: c60990ba1fb2a6c1ff2789e610aa130f30=
47a2ff
> [4/5] dmaengine: dma-axi-dmac: Gracefully terminate SW cyclic transfers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: ca3bf200dea50fada92ec371e9e294b18a=
589676
> [5/5] dmaengine: dma-axi-dmac: Gracefully terminate HW cyclic transfers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: f1d201e7e4e7646e55ce4946f0adec4b03=
5ffb4b
>=20
> Best regards,

Hi Vinod,

Thanks for applying the patches. Since I have you here and if you have 5 mi=
n I would like to
ask you for some clarifications. It seems there's a bit of a confusion rega=
rding src_addr_widths
and dst_addr_widths. For instance the docs say the following:

" bit mask of src addr widths the channel supports.
Width is specified in bytes, e.g. for a channel supporting
a width of 4 the mask should have BIT(4) set."

And I suspect that BIT(4) is leading into some confusion. Like, if I have a=
 width of 4, then my
mask should look like 0x04 and not 0x20, right? Like the code in [1] looks =
suspicious to me... And
it seems that pattern is followed in a lot of other places. If I look at [2=
], then it looks more
with what I would expect.

Like, if the correct way is 1), then it means that 64bytes is not really po=
ssible right now given
that BIT(64) is UB and that looks a bit limitating and odd to me. That and =
given that the AXI_DMAC
might also suffer from a, possible bug, made me want to clarify this.

Thanks!
- Nuno S=C3=A1

[1]: https://elixir.bootlin.com/linux/v7.0-rc2/source/drivers/dma/tegra210-=
adma.c#L1166
[2]: https://elixir.bootlin.com/linux/v7.0-rc2/source/drivers/dma/sh/rcar-d=
mac.c#L1841

