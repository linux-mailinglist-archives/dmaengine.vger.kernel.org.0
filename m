Return-Path: <dmaengine+bounces-9154-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BnqLn8Noml9ygQAu9opvQ
	(envelope-from <dmaengine+bounces-9154-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 22:32:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD991BE302
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 22:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 283D9300E243
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 21:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC093815F3;
	Fri, 27 Feb 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLFhazWs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BC2BE02A
	for <dmaengine@vger.kernel.org>; Fri, 27 Feb 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227965; cv=none; b=Cr9aktneJuaDXJC/wXWh777c92ZDAsaxJZ3VSWaYKxftcLsl65F+6RfwINae07omKmzsmAl21bq5uWzFJGW2mvqFeHvUprsXg5kN7QWBHk86dExCbZUVJ42g0de9kFoI5WdcIpgVbkzjZfOoyj7iMut/VdOAQohWdJbdQeIv5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227965; c=relaxed/simple;
	bh=nUceLnwnFGOsiCx6d1TbU2VXshva5vgl3jAvcmBpNIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvTJ0lrrajyEBcPecJp+rA8OZwYDou58rh5Ck18o4CHGGNVsdm6Cx+SHF8xcYFxXSp5koKk0BrVyftxHjfw8hAhFe2Wx7mXAar/SODPpeQRdlD27LJVa1kpPu53DQUW9DLyJhZtUUNuzc3qFiQqSJ1yueXAXJKxuuZ+R+4Q7NAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLFhazWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194B3C19423
	for <dmaengine@vger.kernel.org>; Fri, 27 Feb 2026 21:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227965;
	bh=nUceLnwnFGOsiCx6d1TbU2VXshva5vgl3jAvcmBpNIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hLFhazWswPxRoY1uNYl+xF4riy8lYbk4qBIUfzMROq+UlcfqZcSnzMZfzfTctqa1d
	 iF4+3ANW/DJC5aVyvbvWLURQH6/K7Ri75vgUtWOmA2IyMvuIgF+sFSEijR/omqTtkP
	 dPn6xUC/5KEx6kgp6LQbIbtewqgjLmkrkh72OoBVlKHcyuAkT/3ZhwZ/wI9xERPAoi
	 60cUEbvVMBXMN8fBK/lb4BwIYKEAF1453JSTJfjO+Xl9i32VFsmmi+8I2gLeF0y213
	 qq9maYtdeJZB2IxQTBdU7gnYjjb4jpyQdKbDLaQnI4ZtjzqBFGQad65bc96E1/t0aY
	 ZbfGBErPmEEKQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-389e268a9b4so34497471fa.2
        for <dmaengine@vger.kernel.org>; Fri, 27 Feb 2026 13:32:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXK3yYjdkbjdOOAzgLzdIS9vXn2/zS9jBeFP64SDqNsRGyowNHzHVXqMnDdftn0JdQcQmpQNjyu4iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymG6060bD197giHUutYzgqJbgNI7eonb670d7rFe/iehw2Nbcr
	qi/W10ZM4kZLcCFzwNg4ds6MlMLJPUp3iDK+aUMX8dUkldkEiDigWatKbp2geU8zM30veZFLr6Q
	v4aAnM7rGRjtdcjdvW2CKtu5VT8N64pltzageGhTB6g==
X-Received: by 2002:a2e:b8d3:0:b0:389:fae2:10c1 with SMTP id
 38308e7fff4ca-389ff109ba2mr23520851fa.7.1772227963739; Fri, 27 Feb 2026
 13:32:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman> <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman> <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman> <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
 <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
 <CAMRc=MevcsQ+sWsERQzod-a9A+F8feoLnbBXSkZrUk4zBPYCSQ@mail.gmail.com>
 <xuiiqsrj63rtg4onuu2vmohwu2b2sd3so5uzakdzuucmwqaufn@7xwecs4apayt> <aZ7GS5W1VNNB2fLi@vaman>
In-Reply-To: <aZ7GS5W1VNNB2fLi@vaman>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 27 Feb 2026 22:32:31 +0100
X-Gmail-Original-Message-ID: <CAMRc=McD3k87-UpZ3q2eqEpVSCRgEVWc0XB+oRUZKM5rxMG=qA@mail.gmail.com>
X-Gm-Features: AaiRm50yWEXHhLWXdj2Xm8-0PdwLOxwgr2acGIXsoFD28WkZgbQ2Gyt_0YXUMAc
Message-ID: <CAMRc=McD3k87-UpZ3q2eqEpVSCRgEVWc0XB+oRUZKM5rxMG=qA@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
To: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9154-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,vger.kernel.org,linaro.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DD991BE302
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:52=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrot=
e:
>
> > > >
> > > > Sorry for jumping late. But I disagree with the argument that the c=
lient drivers
> > > > have to set the LOCK/UNLOCK bit. These bits are specific to BAM DMA=
 IP for
> > > > serializing the command descriptors from multiple entities. So DMA =
clients like
> > > > Crypto/NAND have no business in setting this flag. It is the job of=
 the BAM
> > > > dmaengine driver to set/unset it at the start and end of the descri=
ptor chain.
> > > >
> > >
> > > But what if a given client does not need locking? We don't want to en=
able it
> > > for everyone - as I explained before.
> > >
> >
> > That's not going to hurt. AFAIK, enabling locking wouldn't cause any no=
table
> > performance overhead.
>
> I was always skeptical on this one. I had never seen why locking should
> be pushed to clients. As Bjorn said it leads to more mess than worth it.
> Thanks Mnai
>

[snip]

> >
> > > >> > Reg Dmitry question above, this is dma hw capability, how will c=
lient
> > > >> > know if it has to lock on older rev of hardware or not...?
> > > >> >
> > > >> > > Also: only the crypto engine needs it for now, not all the oth=
er users
> > > >> > > of the BAM engine.
> > > >> >
> > > >>
> > > >> Trying to set the lock/unlock bits will make
> > > >> dmaengine_desc_attach_metadata() fail if HW does not support it.
> > > >>
> > > >
> > > > The BAM dmaengine driver *must* know based on the IP version whethe=
r it supports
> > > > the LOCK/UNLOCK bits or not, not the client drivers. How can the cl=
ient drivers
> > > > know about the BAM DMA IP capability?
>
> Lock bits are on the BAM DMA IP or client? Can we not add this
> capability to BAM driver and lock for IPs that support
>

Lock bits are in the BAM command descriptors. We do in fact already
expose the layout of BAM command elements to consumers.

> >
> > > How do
> > > you handle the case where we need to lock the BAM, send an arbitrary =
number
> > > of descriptors from the client and then unlock it? How can the BAM kn=
ow *when*
> > > to lock/unlock?
> > >
> >
> > BAM driver has to perform lock during issue_pending() and unlock while =
reporting
> > the completion using vchan_cookie_complete().
>
> Sounds good to me, thanks Mani
>

This sounds great in theory but submitting new descriptors while
you're starting the engines proves to be quite tricky. :(

Over the course of this week, I tried really hard to make this happen.
The fact that we have two descriptor chains - one with data and one
with command descriptors - prepared with two separate calls to
dmaengine_prep_slave_sg(), but which we want to wrap with a
lock/unlock means we'll most likely really need to find a way to
insert the dummy command descriptors the moment we want to flush the
queue. Though that also means that the consumers need to adjust - for
instance: they need to submit both the data and command descriptors
*before* calling dmaengine_issue_pending(). So there goes not
involving the clients in the locking logic.

I will give it another try on Monday, but there's also another
problem. The lock/unlock bits need to be attached to *real* command
descriptors. So we need an actual "dummy" register write. The HPG
evens says this is the way to do it and I verified that passing 0 in
addr and size fields of a command descriptor will result in an smmu
fault. In the current approach, we do a harmles write into the VERSION
register of the QCE. But the address of that register is not known to
the BAM driver. How do I tell the BAM driver which address to write
to? There's struct dma_slave_config that has dst_addr and src_addr
fields that could be reused but that's probably not really their
function.

Bart

