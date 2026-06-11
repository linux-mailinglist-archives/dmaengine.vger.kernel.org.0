Return-Path: <dmaengine+bounces-11471-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K4qOLnPpKmogzQMAu9opvQ
	(envelope-from <dmaengine+bounces-11471-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 18:59:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB515673CBD
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 18:59:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NuOHX2zK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11471-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11471-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 733F930634B7
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB17F9E8;
	Thu, 11 Jun 2026 16:30:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03188220F49
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 16:30:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195449; cv=pass; b=IqJpFm3+2PNzHESsKYwVFTrqD/vzPngS9QJ8QV6yhB1ub7S1kGFeHnsCZgycXeKG1SBiQZbyAGmjv0Dw/4qcDwx+uvJTRz3SYMNflzIDZ89kUsa5cM1J4wKR67+LGx6cQlwbZXLvwcYXjfpgAhoOb4/DNsT7Jc66azST0DAhNmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195449; c=relaxed/simple;
	bh=2nbyxf80S/ptMFRJyba8LgNgyq0oU2BmImEh657hN2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blUxFmibzUxjlm82cN7EeMawgdjuymN9aRPX5quktr3sD58WEtztSqlqcNfZfjULpPpn+GacObhSX+2nO98fph10Kl4N3EGRbT1SVjlsNq4pGvI1RJ/+lRwF+4eygO7V/FqAZiXeGXb7ZwD6WuWQVAFb61Y1qRV3MeHXZgIQRtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuOHX2zK; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so38018a12.2
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 09:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781195446; cv=none;
        d=google.com; s=arc-20240605;
        b=NgTnubWyLA29kjM0bkWcKJNBsAIge5Fu+hW7clQMJgOiloYAJbaE+4HVqN0Dg5aLER
         xGSefKQtAZ0BcaUTmNvGGzp/ysEBBrjdVGxE9LFGs4orcMcftcZ1EbYWITPL9V4Z6ol3
         qGciVdvxumD698hjx9HGRQFoKrh3BBEc//3/VsBGFcFX74qUveqep9sy9+LCq6mUzAxh
         qZkNMo4jMKqLBgkyPBRTh1A2UY3A8Tnpmk16n3WWO0zgOFrY9CKX58gfBd+nSy8eMqrn
         QZnQPF04wU1VPu+IswAZlBE/dB07GAZpDDuxyUpXdhBkow0vxyqJqGljBN/EWFlKDKIQ
         ZpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iheKOWFdtwPumeqiSxQOmmhC5dJ1TWCtS8vJVMwePJg=;
        fh=l5LZZo9YWyjS1zxvGAPeYoaETgB2nj09bwSH/d4QCy4=;
        b=UfZx+UJdfNnVjEBDZH+Oollbhocg1BVpzDLqTf/v/fAze9q8iuf8gkraHz6raFCDCg
         idV2Mp7GZcsRbG3lXUfBMfcEm4VIiFngLooMPj4og8yW+g/yJBi4JaD+akqOeRcG5a+k
         xn8g2y+RvGa34FHeox15rpScAT3gv3iJjfu50ztUa+rAea3DgM/5P+hRsWqOtUn2zD9B
         zxxvbrrb36q1ILAJui6yBG3drNwGkQLP/bX1fIwrEzOZysWulS+/5pSnQiOqrnVeQyZ+
         Htq1cOe/tLY9WCdQfnyJov8eZZtCRrivtH68fQqDUunuwPHVGTzmEsdOqfqAR6i/KlY8
         eCtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195446; x=1781800246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iheKOWFdtwPumeqiSxQOmmhC5dJ1TWCtS8vJVMwePJg=;
        b=NuOHX2zKhBuRtoXsC5lv8I/wxqDnr/UmB8CUmJZ0tMswaAhPAauUhteFgWDYSACFdd
         1gOpHczpYpc2NLz0PEZt6gh1UNKSmZIzBJG8HTffixiZ6I+P6yNt41C6s5u1fbSceRE2
         rj2e9RyWPGRb99Z1CXZ2bt9Q87HmmdgohUgLgBEu7BqExTNKgbkavko3xoW3mRetRszv
         nuaAtUSMlSg9GfLtbg+FDfwvdYoswiXg6Avbe1o7XSspwYZqpZ12YiTXK3IRoYidF3Eb
         NLZ52rWlKna76u03+2RfFgEZahfjT9+/vfAX/C/r9mezRGaKY1fg+IdbZ5u+0hMHEbjJ
         oMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195446; x=1781800246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iheKOWFdtwPumeqiSxQOmmhC5dJ1TWCtS8vJVMwePJg=;
        b=l11fnq/MN3w/bLCYSuqLTi4D7STz4cJEh2/8yecEOOCIH7u4DQwi3o9T10hUL2SF3W
         kL7VbGlxO3FmfrhwP/zZ0TyrNW74O5kQAEBZxIXdSuhZMU+pNssanOL2Oah1E1nICUb3
         4GLsklp6KAArrzkkGG/SyKEkto54dKdkRnoncAVZEOoUOhNymmB9pB2bR2Th0FIa/qLf
         qY9oiG3ZDFjnDy9dBYsxA2rVhmwqHcvxOtpl9qiIW32JKqLYjotP8NK3IQ9HEs1+0dM6
         z6oEZttRO2PeSGatYQeyCLs98GIAKPbbGEF+ZQhYE7ArtfE5oTt4tlaFBkTVcyvSsPFu
         uEBg==
X-Gm-Message-State: AOJu0YykPPBbFNJq/rJcv1dm6eUt3xTGMyHkZOecEblQavty08A+mcSX
	Hm7Nk+QyE0tuwum54OfhHKNY6HDpjX8OpEmUZjrr6TkO1aVCiKe9rOVPJVFEJlHIc0A9IurGzNt
	S5kZ1Q2a71pm4F9553rstH5XxkOaBvus=
X-Gm-Gg: Acq92OGZs4+BusS9YieOU/oe0QkEAoPMOw/fyKTfuxEGtaJ7BN4pxlM+8n6i2zYTnHA
	76gMXnMK7K6Oo07ytljLDvYEDHiIoLaT68APbE+BFEBPu+pcoG0S4XRwg1CcmJJ97Mw0AwI4b6Q
	+1Un5zjZapvClvMkNk/ltrTRo7EZJ4FOoz58gMtxSHf3G52h9SS3uoxfIDtvlezLaMB2JvYU6It
	ufwLhQfTkQvVhUDSWSL76ylqWX6fbCuFkTK4TxpsVDQhC0XMJg0LEzuW4RtjrLDoCcysGpiga4f
	z9PxduMUHy24Q/0kD3zQl+STOoZ2jn2pPJaNOlUSHv5jH1c80hPBEs1TVtNZE1+wYr3ffFAXK1t
	13N+f8GnL7gJAaYjfGPhORJHYbvVhIRG3THfbrWzLY06dnTJwVN3L2ONQbHHuxnw+Z3Y=
X-Received: by 2002:a05:6402:1948:b0:687:819:545a with SMTP id
 4fb4d7f45d1cf-6930e438b2emr1819681a12.25.1781195446025; Thu, 11 Jun 2026
 09:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611035245.13439-1-rosenp@gmail.com> <20260611035245.13439-3-rosenp@gmail.com>
 <airSHmdtCg5yWn0X@lizhi-Precision-Tower-5810>
In-Reply-To: <airSHmdtCg5yWn0X@lizhi-Precision-Tower-5810>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 11 Jun 2026 09:30:34 -0700
X-Gm-Features: AVVi8CeqeKhQJh1oE_uJdumUn9r0WFmAfFwWPafkU5F8prKElzOIcB4MnkuaMOg
Message-ID: <CAKxU2N9bMeuOKBDOXB=bFFkiNTZh-ZQFE6CSC5FZ_p6ygo9zZw@mail.gmail.com>
Subject: Re: [PATCHv4 02/15] dmaengine: fsldma: drop desc_lock before invoking
 client callback
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11471-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB515673CBD

On Thu, Jun 11, 2026 at 8:20=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Wed, Jun 10, 2026 at 08:52:32PM -0700, Rosen Penev wrote:
> > fsldma_run_tx_complete_actions() calls dmaengine_desc_get_callback_invo=
ke()
> > while still holding chan->desc_lock.  If the client submits a new
> > transaction from their completion callback, fsl_dma_tx_submit()
> > tries to acquire the same non-recursive spinlock, causing a
> > self-deadlock.
> >
> > Fix by extracting the callback info under the lock, removing the
> > descriptor from ld_running, dropping the lock, then invoking the
> > callback and running dependencies outside the lock.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/dma/fsldma.c | 108 ++++++++++++++++++++++---------------------
> >  1 file changed, 55 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > index 0e2f84862261..455d21d738de 100644
> > --- a/drivers/dma/fsldma.c
> > +++ b/drivers/dma/fsldma.c
> > @@ -496,16 +496,19 @@ static void fsldma_clean_completed_descriptor(str=
uct fsldma_chan *chan)
> >  }
> >
> >  /**
> > - * fsldma_run_tx_complete_actions - cleanup a single link descriptor
> > + * fsldma_run_tx_complete_actions - unmap and extract callback from a =
descriptor
> >   * @chan: Freescale DMA channel
> > - * @desc: descriptor to cleanup and free
> > + * @desc: descriptor to process
> >   * @cookie: Freescale DMA transaction identifier
> > + * @cb: returned callback information
> >   *
> > - * This function is used on a descriptor which has been executed by th=
e DMA
> > - * controller. It will run any callbacks, submit any dependencies.
> > + * Unmap the descriptor if it has been submitted and extract its callb=
ack
> > + * into @cb.  The caller must invoke the callback and run dependencies
> > + * after releasing chan->desc_lock.
> >   */
> >  static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan =
*chan,
> > -             struct fsl_desc_sw *desc, dma_cookie_t cookie)
> > +             struct fsl_desc_sw *desc, dma_cookie_t cookie,
> > +             struct dmaengine_desc_callback *cb)
> >  {
> >       struct dma_async_tx_descriptor *txd =3D &desc->async_tx;
> >       dma_cookie_t ret =3D cookie;
> > @@ -514,49 +517,14 @@ static dma_cookie_t fsldma_run_tx_complete_action=
s(struct fsldma_chan *chan,
> >
> >       if (txd->cookie > 0) {
> >               ret =3D txd->cookie;
> > -
> >               dma_descriptor_unmap(txd);
> > -             /* Run the link descriptor callback function */
> > -             dmaengine_desc_get_callback_invoke(txd, NULL);
> >       }
> >
> > -     /* Run any dependencies */
> > -     dma_run_dependencies(txd);
> > +     dmaengine_desc_get_callback(txd, cb);
> >
> >       return ret;
> >  }
> >
> > -/**
> > - * fsldma_clean_running_descriptor - move the completed descriptor fro=
m
> > - * ld_running to ld_completed
> > - * @chan: Freescale DMA channel
> > - * @desc: the descriptor which is completed
> > - *
> > - * Free the descriptor directly if acked by async_tx api, or move it t=
o
> > - * queue ld_completed.
> > - */
> > -static void fsldma_clean_running_descriptor(struct fsldma_chan *chan,
> > -             struct fsl_desc_sw *desc)
> > -{
> > -     /* Remove from the list of transactions */
> > -     list_del(&desc->node);
> > -
> > -     /*
> > -      * the client is allowed to attach dependent operations
> > -      * until 'ack' is set
> > -      */
> > -     if (!async_tx_test_ack(&desc->async_tx)) {
> > -             /*
> > -              * Move this descriptor to the list of descriptors which =
is
> > -              * completed, but still awaiting the 'ack' bit to be set.
> > -              */
> > -             list_add_tail(&desc->node, &chan->ld_completed);
> > -             return;
> > -     }
> > -
> > -     dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
> > -}
> > -
> >  /**
> >   * fsl_chan_xfer_ld_queue - transfer any pending transactions
> >   * @chan : Freescale DMA channel
> > @@ -635,22 +603,23 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_=
chan *chan)
> >   */
> >  static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
> >  {
> > -     struct fsl_desc_sw *desc, *_desc;
> > +     struct fsl_desc_sw *desc;
> >       dma_cookie_t cookie =3D 0;
> >       dma_addr_t curr_phys =3D get_cdar(chan);
> >       int seen_current =3D 0;
> >
> >       fsldma_clean_completed_descriptor(chan);
> >
> > -     /* Run the callback for each descriptor, in order */
> > -     list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
> > -             /*
> > -              * do not advance past the current descriptor loaded into=
 the
> > -              * hardware channel, subsequent descriptors are either in
> > -              * process or have not been submitted
> > -              */
> > -             if (seen_current)
> > -                     break;
> > +     /*
> > +      * Take descriptors one at a time from the front of the running
> > +      * queue.  We re-read the list each iteration so that we don't
> > +      * chase a stale next pointer across the lock-drop below.
> > +      */
> > +     while (!seen_current && !list_empty(&chan->ld_running)) {
> > +             struct dmaengine_desc_callback cb;
> > +
> > +             desc =3D list_first_entry(&chan->ld_running,
> > +                                     struct fsl_desc_sw, node);
> >
> >               /*
> >                * stop the search if we reach the current descriptor and=
 the
> > @@ -662,9 +631,42 @@ static void fsldma_cleanup_descriptors(struct fsld=
ma_chan *chan)
> >                               break;
> >               }
> >
> > -             cookie =3D fsldma_run_tx_complete_actions(chan, desc, coo=
kie);
> > +             cookie =3D fsldma_run_tx_complete_actions(chan, desc, coo=
kie, &cb);
> >
> > -             fsldma_clean_running_descriptor(chan, desc);
> > +             /*
> > +              * Remove from the running list before dropping the lock =
so
> > +              * that terminate_all cannot free this descriptor while w=
e
> > +              * call into the client below.
> > +              */
> > +             list_del(&desc->node);
> > +
> > +             /*
> > +              * Prevent dma_run_dependencies() from calling
> > +              * fsl_chan_xfer_ld_queue() while we are not holding the
> > +              * lock.  That would splice pending descriptors into
> > +              * ld_running before they have been completed by hardware=
.
> > +              * fsl_chan_xfer_ld_queue at the end of this function wil=
l
> > +              * re-evaluate the situation.
> > +              */
> > +             chan->idle =3D false;
> > +
> > +             /*
> > +              * Drop the lock before invoking the client callback, sin=
ce
> > +              * the DMAengine API explicitly allows clients to submit =
new
> > +              * transactions from their completion callback.  Otherwis=
e
> > +              * we self-deadlock on chan->desc_lock.
> > +              */
> > +             spin_unlock(&chan->desc_lock);
> > +             dmaengine_desc_callback_invoke(&cb, NULL);
> > +             dma_run_dependencies(&desc->async_tx);
> > +             spin_lock(&chan->desc_lock);
>
> Not sure if you have hardware to test it. This change is quite big. Gener=
ally,
> keep desc_lock and move these complete queue,  defer to tasklet or workqu=
eue
> run callback in in complete queue by hold complete queue's lock.
I do not. And because it is quite big, I will drop it.
>
> > +
> > +             chan->idle =3D true;
> > +
> > +             if (!async_tx_test_ack(&desc->async_tx))
> > +                     list_add_tail(&desc->node, &chan->ld_completed);
> > +             else
> > +                     dma_pool_free(chan->desc_pool, desc, desc->async_=
tx.phys);
>
> desc already removed from list, needn't hold desc_lock, you can move it
> just before spin_lock()
>
> You should use difference lock for ld_completed.
>
> Frank
>
> >       }
> >
> >       /*
> > --
> > 2.54.0
> >

