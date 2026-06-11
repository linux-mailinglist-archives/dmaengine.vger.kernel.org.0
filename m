Return-Path: <dmaengine+bounces-11470-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yj3bLereKmoLygMAu9opvQ
	(envelope-from <dmaengine+bounces-11470-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 18:14:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F966735BF
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 18:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KbxslGAq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11470-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11470-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0DA4301CFA0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942503FFAD1;
	Thu, 11 Jun 2026 16:08:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728F395AEE
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 16:08:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194127; cv=pass; b=p61DgLfXr3IUOQPy2jPwNDSieqBQ4QbkGBF+K6OJzmbJQOdDkrTRXxyd6BIEzzQpoU55/eqctHfdexkp5nRXRv+2aBe0n7QZLN+8po5AxiRYwnRz08ZREp5dNyYmmMooBFueWJgd0uk0h+LcfpbyClCXz1YdiJ6WFhAFyztrrAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194127; c=relaxed/simple;
	bh=sj2FS3py+P6ghioGl4/Lb8GGlbT9xXdYa6q6BQWvjtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asa8iYPNjx7ti5iIQQefJRSZEUZWgXtMU9ownZ3RwT4N+/IGLNFyHmKONPjwQTSVYBIHEwmDT9KRfw7t0XOshPe4odEDgutv0Ye0mijsiG/MLp8Ko6hL/LfbAK1qX9W/WM95htGhHDNSspAdbmvRidxoeLGXn9zyc9PoPdS5OIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbxslGAq; arc=pass smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-beeba001887so1102156966b.3
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 09:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781194125; cv=none;
        d=google.com; s=arc-20240605;
        b=SxGYq4LjwmTSnVqyxJ5atPb++epvB8DGPzwlWu5p33EvQAzCM+TPiJ6VHD8Rc4dRd4
         bJHbI17KWTLD8hasOzIJqrRePuTL2CoxE4ttWp7V3AsxoDzd0p7hi5XLykcd500aNnzi
         toPbKBl143eDB4gYPZM5hy/6aYgw09kPf2ukmlWgVYBkC/3xrxM41TJ1/TxuPQuBbUir
         hX/NscNiAYfqu+ApPev9u5RwqtO+EGWRRb8Crn1IEgjZpWP+uAqqQJHdiOA9Dzv6ssd9
         DpAmIzEOXkGguqHrYIXztvWn+VSGHKo2ZbpUYqPaYyDkCzzOHNWThqOLUzCmtcW6dqs7
         TuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0BPhvT50VQuK2+y7zbXq9J0IJLvfRaU5Y2kOZciKetk=;
        fh=l5LZZo9YWyjS1zxvGAPeYoaETgB2nj09bwSH/d4QCy4=;
        b=S0BQNbQbjYZTRsKVy2/3pa+Y5MMTeQ9jalM3nnCL0MZoxjQLojSQWnG9Et/49OnpWH
         0MaRux6K+Dvr0hFCloz5CeT3Mimqpk9Hk3LS6wfon5dYElPFQvuHYHL1RSzwyK1/x0vn
         sFoZAMhQLwdxwb9ADsWF1GqD49i3oU+NLOKv5UtN3IB+GgepNJ9mNOBXAoHaVGxYBlpm
         Pk0skvMdvjHSzA5gdFWPpPWlB5gTQvShl5g3nkHE6svl04Hivww6y98ImJhJxBe0n2bi
         4BHPm3CwOAQe0D0dxKmC3pv0jFg8n2/XwGdbpaRxfJb9E16/uNuq6cpY5RK/4JfpScrZ
         rNKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194125; x=1781798925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BPhvT50VQuK2+y7zbXq9J0IJLvfRaU5Y2kOZciKetk=;
        b=KbxslGAqvVqI38ZEGyS/OWPpQmlzBw1AZn8N0H4cV3F1VTB3VA17uJvBErHQb67aIe
         2KuesUkfJj2iZN1RGQdUB94+4CF4NM5vXYpoMFtPkxT/G9qVHdrP3L/64IbBLR8XkXVa
         rQjgolUM7pdsBimnDr7Jn/hktpLikVjWIdmr1/EG9PrAInnoItRX7cX9RIAfpVf0YcJd
         ZMkau//ZRPY/VIle54sY3TIdYqK7ihP8/wX29lca+7ow25uBZoIJ2ZN9SDJQlCTvKMot
         1WpCrlN3P826qlGn/8mnmQsCMxQ9C4lLyI5het6dG42zPht1IP1oZr2Q3e+UINrGcJYA
         VXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194125; x=1781798925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0BPhvT50VQuK2+y7zbXq9J0IJLvfRaU5Y2kOZciKetk=;
        b=YCCKS4xPy74GdrHjX2vmuJyt/3UksaLgdicBUDIUY/KrWSYPbQ0ZGSge+QDwyxdC5f
         Fz9mRh4oADhbpKWPLdfZBqe2xkj6jtlvq+Qby2MCwyPeWLJrozCWsB8pcNQLFkizUAkb
         Zz1PEiLStJPy8L/QNeqD96kG40W0joMWAlQ2Z3AWmPNdw7FAzp8GV7VToeGruJbIh2Q4
         dT+/0x/72CV1jJ/cxXBW395MuntlU8YRpYQ/UsehZHbhZ+nH5/ckf6h8II46aTUonHmh
         3czJ7iqUn10/xl9EqpSVwUYfSsUDVb02clSErSmTCSva09BIJaPAqRb4Oph1KFGLYXLd
         iVTA==
X-Gm-Message-State: AOJu0YzkhwI62vLVWZX5ELQw7z5WHp4NjFfXng4Hy1AfQd2UzvZ5N5Dt
	VRmO4zRfxxNi8kdzhkact4pWLj5Oa5+8Ms6X4YAOkVXfxUfdIFFMs6pbwo5v3MdWMEM5CzmeAF2
	9uHzcB0WdaZMiInQgTcJRHEQkNPcBwGBhmw==
X-Gm-Gg: Acq92OHUUoxCPE+Dy1b3/qZqLmaXxxwK128wvAAthXaE/Y2GjpsXZXdiCgTUc97skEP
	zWOvubslZBonCGgWMApw7trgc37Q6h47Y2LuTVtcoy4bwhAvRDLFHVOxqcauX9V72VFR4ZR2I56
	0WhCgYbfV9qwRkQq6G34MqZxMfNqxnm6VLp/RTDGXgTBkbUMmC54JQcdUiBbmSe9vG3NT1oL0uI
	J8KyKsyn1WnEBQdr1venaeyxhhyTYhC9rk6QLSgIrJvgz0SCO7rWVYsGzhz5AYeLTcmXZk3dd8i
	zRTP8jIpq96maY3t0Wnu0mtfwIn7ievz7xD4MTn8dT4Yi5SZpSnPPNCsFiG+5Dd04WR3AH5NCdI
	EZvgF5XoUC6GpN7Yfmt3kbuLWo2Zz7FFL1umPhoyJGMUVuPiK+Z25NG98
X-Received: by 2002:a17:907:1dd8:b0:bec:f0bb:66f5 with SMTP id
 a640c23a62f3a-bfc87c0cb2bmr131123066b.30.1781194124409; Thu, 11 Jun 2026
 09:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611035245.13439-1-rosenp@gmail.com> <20260611035245.13439-12-rosenp@gmail.com>
 <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810>
In-Reply-To: <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 11 Jun 2026 09:08:32 -0700
X-Gm-Features: AVVi8Cd07wPKVB64G5JpfGCeLGfe3Dlz_RdVLBiqMrIH7Js6qZaJUTS5GxMh3qw
Message-ID: <CAKxU2N9QNMo9u0s_MfYG8qfiWsHqwuB9ax_qbf6gbxA0syOiaw@mail.gmail.com>
Subject: Re: [PATCHv4 11/15] dmaengine: fsldma: convert channel allocation to devm_kzalloc()
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11470-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zh-kernel.org,gmail.com,google.com,lists.ozlabs.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09F966735BF

On Thu, Jun 11, 2026 at 8:36=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Wed, Jun 10, 2026 at 08:52:41PM -0700, Rosen Penev wrote:
> > Convert fsl_dma_chan_probe from kzalloc_obj() to devm_kzalloc(), tying
> > the channel lifetime to the parent DMA device. Remove kfree(chan) in bo=
th
> > the probe error path and the remove function.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> If use flexible array, needn't allocate channel
Not sure what you mean. A regular array avoids that as well.
>
> Frank
>
> >  drivers/dma/fsldma.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > index e4a3315a7d9d..0df09789187d 100644
> > --- a/drivers/dma/fsldma.c
> > +++ b/drivers/dma/fsldma.c
> > @@ -1114,11 +1114,9 @@ static int fsl_dma_chan_probe(struct fsldma_devi=
ce *fdev,
> >       int err;
> >
> >       /* alloc channel */
> > -     chan =3D kzalloc_obj(*chan);
> > -     if (!chan) {
> > -             err =3D -ENOMEM;
> > -             goto out_return;
> > -     }
> > +     chan =3D devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> > +     if (!chan)
> > +             return -ENOMEM;
> >
> >       /* ioremap registers for use */
> >       chan->regs =3D of_iomap(node, 0);
> > @@ -1200,9 +1198,6 @@ static int fsl_dma_chan_probe(struct fsldma_devic=
e *fdev,
> >
> >  out_iounmap_regs:
> >       iounmap(chan->regs);
> > -out_free_chan:
> > -     kfree(chan);
> > -out_return:
> >       return err;
> >  }
> >
> > @@ -1215,7 +1210,6 @@ static void fsl_dma_chan_remove(struct fsldma_cha=
n *chan)
> >       tasklet_kill(&chan->tasklet);
> >       list_del(&chan->common.device_node);
> >       iounmap(chan->regs);
> > -     kfree(chan);
> >  }
> >
> >  static void fsldma_device_release(struct dma_device *dma_dev);
> > --
> > 2.54.0
> >

