Return-Path: <dmaengine+bounces-8235-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45576D1B0F1
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 20:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49427303C106
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 19:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0436A01B;
	Tue, 13 Jan 2026 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2h7NdYZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3235B143
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332710; cv=none; b=sqXOb2oNIW8Ry0HKyXEAA6e+WD6uiIl7/ecI3cAqS08e2DAyomewKmathzp9ZD9rLQqkJ0TjNMS30P4vs2HshUVt2Yc8qMbHAdaVtL4v+ou0VHlGn2Rolv3brBg8gOE76QgN99csg+mwiR3Ckhz/UX0qTu878MUNYFn+Dx0d0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332710; c=relaxed/simple;
	bh=p1QU92yh7J3nKIOvCV3DBsIuLtNpk8bnzgF83kmPK1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+2rMSDOYyy4HvnGlkkWk1DSLtkgHqaensJGgkjXxSeMKlP9P1Gdrz5WhxGCgI0OQ8qiypcf7JAnmXpfEMZn0YV06gOEF+FlWJJPshXVHwdIXNH+UbrCm0tAt6hFkCFTpl09h8EtXP07W5yQh7pGdI3P5JcJF8vIyBM0q6yD8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2h7NdYZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so6297418a91.1
        for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768332708; x=1768937508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz3d4wcwfG6auEnj5mgq+YAyioefyslevMqfwDmUqc8=;
        b=X2h7NdYZmNoH9Fqm6uLFmYPO9hVHxx8xPFUdRZcmduA2Xn8vjCkXQp6uJdHqgFaDUt
         6cIMm4HfIA67jenbSsgCC6xEchUpPHDgrZh5yfNjgA2o4EsUKjjDQc0Afq0s/puD5eE/
         6vQxeqdOMSTs31MorybCBXLgjhDVE7OYG6JURiyvQUwOuvIPuaDV2hycO5XrJmZhgQ6k
         YiVTEdQzJFpWH0nlHJwlu+nOGW2LeZ/w1+yY48Qk4WeKl70PchX+8oB4SUogsFNgbek4
         JT2HDKhRaAPRiMFtnb09RU7NMJPm/A7yHF29nZMrB/5/xpvmh+tCdtdj0/v0lVTIfkXw
         h76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332708; x=1768937508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sz3d4wcwfG6auEnj5mgq+YAyioefyslevMqfwDmUqc8=;
        b=WYtxnFg9r1YEKRbyOXmXHzdVRfJk4nqifEyDrVeYDjGclTaESo6A6v0SBThriax40y
         jqBS9Pe8eprTGpFZQxn5MDRpPcXOa93QtS6YHkgp4cXtQ1hwK5SQozhxC/biHWJ/Jf7c
         vUbXJ/nROPus7LCeMaJhAFC7XLMsJHFNRGat7lnGmf763YTQZXcBC4rigUqBrhE7bmMn
         +oWf/c1K5nIhjftiXW2tEFNfvb8aEasy/S+KpIpne4KDMSRAgiKLzQgGj9mR63PMDATN
         X0+y5kqmVhIHszGVc998UsZa23HOn57uELU2s/jKWdvfI3VJ/yOI2N5Ci0hyjB5wN9AC
         p5bw==
X-Forwarded-Encrypted: i=1; AJvYcCVzyAPnFtDvc54ILg7kZgbeNo8trgNd47FILvsbpEtWIY0EW0ALHxP9s0ldbyGSSejfE91Pc3rPT+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+gMa3q7pxCIrkZNdnSoCl1o1EbG85s8cr+d8PrXGR0ECjQk0
	IRBkkZc009TNKf3WRKk6g0Oacttv2poLNwOrA9u2s6v/ehGxBF7Xq2/K/TQHUw5ybUic/fOoGp3
	AKxQOrX9Cs+CO2lrEe+p4Apvxju0bgUE=
X-Gm-Gg: AY/fxX6CrPFgtY5nd74RoT5CbP2qWRm6CwBQsuUflTo8wfCXoK8q+1rqdAjSTigYffg
	93Dqet66ErrmFnNswyYaHYRLpFz5tPhDeKvhP9Dm7W39hqK4dvr6xaDbKdW3KOFQTPCZ1hljzVk
	Jc6hMPg3FiwwY3m51FZiymjRebs77qrnoSMRzs61QWTPRG7aWGd0Msx7NHb4kkOhWG70rqeslkk
	JjDVCGIn1OQ5zc7kT0eLZtvVntAYp4QerLguhKmvIPyxv7c26KVakkYI0YgyNXu+y+QpoVSNVK8
	/hS8ppWf2fOTPtbRnkZK2OiRPKHf3tAN/w9Uidw=
X-Received: by 2002:a17:90b:3943:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-351091277cdmr187617a91.18.1768332708236; Tue, 13 Jan 2026
 11:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108080332.2341725-1-allen.lkml@gmail.com>
 <20260108080332.2341725-2-allen.lkml@gmail.com> <6342bd3d-6023-4780-b3b9-96af7d2a4814@app.fastmail.com>
 <CAOMdWSLX07i_-NjUB6TTXbWVmeFLSNoaTBhvOs0WX6Ad=A6PDA@mail.gmail.com>
 <7a557097-5dca-4c44-a48f-21dfa2659abc@app.fastmail.com> <CAOMdWSJ7ut3n-nryTYSyPD37YwN7UqyZ1VcgZ9nmBcRF_jxH=w@mail.gmail.com>
 <b309e54a-b3b6-49f9-af85-2df5ffbe13bf@app.fastmail.com>
In-Reply-To: <b309e54a-b3b6-49f9-af85-2df5ffbe13bf@app.fastmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 13 Jan 2026 11:31:35 -0800
X-Gm-Features: AZwV_Qid2n1EE1YuYEKuvh6LN5Pff0aaxhd7GLCcdeIwvJjpvNlqC7BIYp2VgNY
Message-ID: <CAOMdWSLVk136RzEyiN76zqk65VLwYms0hCDi5Kww9FQppie12A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >> >   A hardirq callback path feels like a larger API change, so I=E2=80=
=99d
> >> > prefer to handle that as a separate follow=E2=80=91up (e.g. explicit=
 hardirq
> >> >  callback/flag + user migration where safe). Thoughts?
> >>
> >> Yes, definitely keep that separate. I still think that this is
> >> what we want eventually for a bigger improvement, but your
> >> patch seems valuable on its own as well.
> >>
> >
> > Thanks for the detailed feedback. I=E2=80=99ll respin along these lines=
:
> >
> >   - Split the series into two patches: (1) introduce the per=E2=80=91ch=
annel BH API,
> >     (2) switch the vchan implementation over to the WQ_BH backend if we=
 decide
> >     to keep that step. This should make the progression clearer.
> >
> >   - The dmaengine_*_bh_wq() helpers will be made static; only dma_chan_=
*_bh()
> >     stays exported.
>
> Sounds good, yes.
>
> >   - I won=E2=80=99t try to move the other per=E2=80=91driver tasklets o=
nto the shared queue in
> >     this series. That feels like a separate discussion, and the right c=
ontext
> >     (hardirq/threaded/workqueue) may vary by driver.
>
> I'm not sure we are talking about the same thing here. I do think we shou=
ld
> try to have all the callbacks in each dmaengine driver go through the sam=
e
> per-channel deferral mechanism. What I meant to say is that all the taskl=
ets
> that are not used for the client callbacks should be separate from those,
> e.g. the pl330_dotask() handler is used for unexpected events unrelated
> to a channel.

Hi Arnd,

Thanks for clarifying, I understand now. Yes, the intent will be to have
all per=E2=80=91channel client callbacks go through the shared per=E2=80=91=
channel deferral
mechanism (dma_chan_*_bh), while keeping any non=E2=80=91callback tasklets/=
work
separate (e.g. pl330_dotask() for unexpected events).

I=E2=80=99ll keep WQ_BH and the per=E2=80=91channel API as the common callb=
ack path, and in
follow=E2=80=91on patches I=E2=80=99ll start converting driver callback pat=
hs to use it.

Thanks,
Allen


>
> >   - I=E2=80=99ll keep the hardirq callback path separate. For that foll=
ow=E2=80=91up, I can plan
> >     to add an explicit =E2=80=9Chardirq safe=E2=80=9D request bit (e.g.=
 a new dma_ctrl_flags)
> >     and update vchan_cookie_complete() to invoke the callback directly =
when
> >     requested; otherwise it stays on the tasklet path.
> >
> >   If you=E2=80=99d prefer I drop the WQ_BH conversion entirely for now =
and keep only the
> >   tasklet=E2=80=91based per=E2=80=91channel API, I can do that too.
>
> No, I think that part is fine.
>
>      Arnd



--=20
       - Allen

