Return-Path: <dmaengine+bounces-9740-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDiwJrOsymkx/AUAu9opvQ
	(envelope-from <dmaengine+bounces-9740-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 19:02:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EA35F282
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DDD43007677
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E63364E84;
	Mon, 30 Mar 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvNtpSz5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BF1CF8B
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889877; cv=pass; b=K/BZAHaYthVtsTQ85jwCTzBC2groZNPBk3mM6kSBJHCX/VpCPNK4dcPdq5u1jy/lpgblW4ZLrWxRTDaRkUAO9RQMECMorXLrx4sglfiIlF8Gy88mS1bxqxv0JXM2gmwwFyfnVyV4CkZdPAsOnlGmrvhGgtkPPaQW8ZdRhsZZS28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889877; c=relaxed/simple;
	bh=eCXkDmAc8RDIf0Hj89pPrTHwfCsUA4W3GaNmjS7W2cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUJfg/X5eLtsiD2GIryZ4fiBMdTYLMJwZkyFXD3BnV1P8d/KN46cKAlgSBJNOR0uhkJM0KSJgZFvot6Z0WLifw63a70BUQtdft6Be/AY701dk+hGVB+nXDWa4piLPcIiakeVjopiuEgXLuyya1J5AOVzVubEW4jx+iKwdUZLhMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvNtpSz5; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40438e0cba6so2956980fac.1
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 09:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774889875; cv=none;
        d=google.com; s=arc-20240605;
        b=OP4lmTv4Bj2lUTROqPH6ORMgRFrUT5CGyfVQt2ozwk1T+jd0oyCyvqONPxTw94FyAK
         OsQWYQIJ6Tz3c74oj7CXRbcE7Yxqj0fkDhGYqABWjVZx/R4wjzqaHmOArY+AmOB+clVP
         5ZleQ+G3ma3Ax/7LVkQC/NBGV4dz29ztPPS1AFKwI+A6dr3NSV4qrtxyjr2iUdaRUA9n
         WGUWwNGmsauRjqxEd+BgsPLpx8Jj68yuiuXu7WOZrH1g1e/6WSON545K0LSjHaKHCopk
         M7wMszS1hLk5x3hUZnEn6/Z268+C6Z1lSg0jdELI6TVirq1xlZHxk375jKyDn+9SYzPv
         tJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=of4C+eH8cS387u/eeOafigpXqamx/OKZaEqc/QdQ64Y=;
        fh=6Ca8GSr0FPQH5bmj9eZUHhG6rJOnMnx2Q+kUqBpYUU0=;
        b=W2BV7eUMryYtSz4TlBPa/VeryEl9fy9u1ySOHMtXSraw4/LwCb1noH/ZbNyxa64vdQ
         XK+9rjMN/LKj+zERNuE5MIQhLFs1PCbeZo+UWiEkR6V2iSXOc2NfGBCPtEl0bSxytuug
         D7qoIcqA1SfZQQzH/wseZupE7VTdGSRg/Zk9wmRZDhr/CyTkB4ecc7SRjNMzS9Mpy90t
         JZnDVXdGWv2aqNTPLGWrnow/vhbu+B9WSPZxUslvH34XTut9gc/DXTTgH6gszpBs0Wtg
         44saY/7Z1/4Tfd1+GWUqH2IQRTBF1R+SqoIzlLSIONYVqkUTMZQ+veTfEowdAbKILsVc
         +JnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774889875; x=1775494675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of4C+eH8cS387u/eeOafigpXqamx/OKZaEqc/QdQ64Y=;
        b=YvNtpSz5iJJgW0Us90EHiSPHZBa3bwo6SFUbhBlh4nk2YAjATBG387+u6Qy99ee6h2
         4xfIIEsUKSDi/tjkScyOh7+NfqLrVxDiLGcJzJi71+A6kS8xJsDE/Y9LTsMX4y7FiWPh
         /SvmjUaN6p1U/rT4CtJfXCFuOTEiOITTptA3uEIlh/+jb4g4HVzdi4nAj4f8FY44nNAu
         0oDa9PqGksQmgS15lyWW86VYD+K4ctfq/7ulHD4SzTFsMTZgurl81zmGu85COhn8kBQT
         DEFcKx+3vMCt0atQyeqErUkPa9CS5PcfkIxCmS2ht9VhPwuVKr+E95BWGWOfS5y6vOAX
         SigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889875; x=1775494675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=of4C+eH8cS387u/eeOafigpXqamx/OKZaEqc/QdQ64Y=;
        b=sB3eT73OiMYIW3oq8cMRX3ykTeHczIavm7uI3WkGfp5W9acHfEOgHQlS27FxFHrNr7
         K3WGpA/APpuiLihOzmoZzYZHfrH0zNg/EvbY2x/5fm2Tc11i6b1JAy9UBwS7AwfN/Waa
         V5K1buw3aKB7g8esGR5cYPSnXTeTOSXLD5w9hquLSrZHRB2B6MlW828t9Dimpd6EyBt6
         IzdofChaGb3Ce9FZCXm5S4XCt5Aok6ikFJ9jwRZ1qo5nE5qCSXPUu2u9ff+goIXhOsO9
         y/7dhmhZPoEBjwXTC9XNEl5AeRS+SGJFVV6AQHEb7WuHJBGR+cHch00Edyyhtw+HTejv
         d9xg==
X-Forwarded-Encrypted: i=1; AJvYcCVsJiQklybVjJ0RHFtznbtRFSX5cUtSSDGFya/SVlhD52A7FEUjsM6ZB2esViO1zTCaX/UyQ9rsfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu60ydO9E5+gKYqcqV0S+sjdwsmteVyJB1tZW/wePSMJgUrS8D
	0E+GUeo7C6fkg5oySdKMjOA+kJ8hrVlBboTHMZrHk78+nFiuMQo/9x2tsQqoHnK4Nfs2A9ja3Ud
	f8BHgtzgqFwF7dErIlIzFSol4J3JPaXh58n9u7jA=
X-Gm-Gg: ATEYQzylcBzZL/Z0iJxAh83DqtNOm53vpVqTgLQ+Qjkky7p6nMkPyJuTvN/KjLMmhDM
	KaW+HvNEJMnViW9Tv5EpVWpWqH6GJlbIZT2v9hweqtXvFADcyw5cXZrwwCzHuuLrs0salYF24ow
	w8F4ljUmklSyXXqOcw0EkcGsZzQ15wNp+EkZ5ghcIypbftpQrtNwnMu/mKkBcH6HxcrV9YoYW5i
	5/hG6HKCAOklYH4G4k3sWGh9ba+R8VF1JrymaFMMVwiIGTL2cATZxXMZaOwUXQrg9dW5HntpOew
	qwYi21+7kb7UlZwZP7ttJ/j3PGVtK2Rj0ntdUQ==
X-Received: by 2002:a05:6871:5285:b0:41c:616:5317 with SMTP id
 586e51a60fabf-41cec35c9a1mr7345033fac.39.1774889875360; Mon, 30 Mar 2026
 09:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318164803.14351-1-devnexen@gmail.com> <acqkrL7CYbr0WmHf@lizhi-Precision-Tower-5810>
In-Reply-To: <acqkrL7CYbr0WmHf@lizhi-Precision-Tower-5810>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 30 Mar 2026 17:57:44 +0100
X-Gm-Features: AQROBzDb9ng3qLwDrSBZnWW36TwR9wbowNfFkvpd5I4v3GwUMHHj13TgxcXfMoo
Message-ID: <CA+XhMqyn_jTgQMpMT9n958qm=1m1bFG+hNjCeqm6eaGqRwU7+A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: loongson: loongson2-apb: fix broken bus width
 validation in ls2x_dmac_detect_burst()
To: Frank Li <Frank.li@nxp.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Yingkun Meng <mengyingkun@loongson.cn>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9740-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E37EA35F282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, 30 Mar 2026 at 17:28, Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Mar 18, 2026 at 04:48:03PM +0000, David Carlier wrote:
> > The bus width validation check in ls2x_dmac_detect_burst() compares raw
> > enum dma_slave_buswidth values (e.g. 4, 8) directly against
> > LDMA_SLAVE_BUSWIDTHS, which is a BIT()-encoded bitmask
> > (BIT(4) | BIT(8) =3D 0x110). Since 4 & 0x110 =3D=3D 0 and 8 & 0x110 =3D=
=3D 0,
> > the condition is always false for valid bus widths, making the
> > validation dead code.
> >
> > Additionally, the logic was inverted: it rejected configurations where
> > both widths matched valid values, rather than rejecting when neither
> > width is supported.
> >
> > Fix by wrapping the enum values with BIT() before masking (matching the
> > pattern used in sun6i-dma.c) and inverting the logic to reject when
> > neither width is supported by the hardware.
> >
> > Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson =
LS2X APB DMA controller")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  drivers/dma/loongson/loongson2-apb-dma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loo=
ngson/loongson2-apb-dma.c
> > index aceb069e71fc..102c01f993ef 100644
> > --- a/drivers/dma/loongson/loongson2-apb-dma.c
> > +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> > @@ -220,8 +220,8 @@ static size_t ls2x_dmac_detect_burst(struct ls2x_dm=
a_chan *lchan)
> >       u32 maxburst, buswidth;
> >
> >       /* Reject definitely invalid configurations */
> > -     if ((lchan->sconfig.src_addr_width & LDMA_SLAVE_BUSWIDTHS) &&
> > -         (lchan->sconfig.dst_addr_width & LDMA_SLAVE_BUSWIDTHS))
> > +     if (!(BIT(lchan->sconfig.src_addr_width) & LDMA_SLAVE_BUSWIDTHS) =
&&
> > +         !(BIT(lchan->sconfig.dst_addr_width) & LDMA_SLAVE_BUSWIDTHS))
>
> src_addr_width is enum dma_slave_buswidth, which allow
> DMA_SLAVE_BUSWIDTH_128_BYTES =3D 128,
>
> BIT(128) will overflow.

Thanks for the review Frank. You're right that BIT() would overflow
for DMA_SLAVE_BUSWIDTH_128_BYTES. While this driver only supports
4-byte and 8-byte widths
  today, relying on BIT() for buswidth validation is fragile. I'll
send a v2 that avoids BIT() altogether =E2=80=94 would a direct comparison
against the supported widths work
  for you, or do you have a preferred pattern in mind?

>
> Frank
>
> >               return 0;
> >
> >       if (lchan->sconfig.direction =3D=3D DMA_MEM_TO_DEV) {
> > --
> > 2.53.0
> >

