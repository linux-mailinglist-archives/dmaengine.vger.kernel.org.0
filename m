Return-Path: <dmaengine+bounces-11032-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBN0DYbDGWqyywgAu9opvQ
	(envelope-from <dmaengine+bounces-11032-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 18:49:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B87605F0B
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 18:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A778336F7C0
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA93E8C70;
	Fri, 29 May 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8f1vukR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D13E63B6
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070309; cv=none; b=IXIdhub4m/YUmPr+wjuiGZ2FuqezPb2QGJ8YikCEpnmpE038uwtqmdVSJj/nuhx3FhaASSxu28Di1xTTQeZZL2yOY5sMsztje6URv0OJeRc5F+9Tkkk7v6Jg8Xchr+DaNsjI/csbJlhPvacadnHjRcymh4JpNqsUuRVdqd+47PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070309; c=relaxed/simple;
	bh=9BCS56pVRryY7pWjuzmcS8K36R35NfR88+/6XLLhN6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgqMt8aCNNHcGzKGXpmQ32XX2AqUOqtjibtWXiAkHfs2UiPZAUQAN+PO/vWrOWoXxgLBohM6lTHSAMWvbKCYCHt8ZwMtlkoFZkOfJOxIANAg5PQD+zoITnWGoWw6EHTcLr1X7U/n6EGhhAf1EtzQgzgc3ZsH9tU6FQcn5apJv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8f1vukR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80C71F0089A
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070307;
	bh=9q8bnA8Cybs5JYtZeRk2lM9ckb6ZQxrxMyz/lWzwvTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f8f1vukRXm2JaBuOVOpUOQL2X3ZlNpT56Iz+2q7JNuPD2soJM//pQ3y/ju6QggUIZ
	 BK08E0l/6K8XC2i4eKRk0SXjOFBzCM4clWhSUXBce0C0IWV43ZqHbc5K0O0Exk9/UZ
	 zrNf4smbjCdUQSmo3eGjuqIhY7lmSPVbT+sve+SGAQS3ItuZ7X6VBy9M4AT52z0z6F
	 WG38IKlzQV3GNvxfVuwfo6hnUfNnaiJYQVv8PbuliRAEkynA53BI+xnG5hq6qUX98k
	 cIZIHjJTCq5Em+xF/fZ53VDN6shmm09CMyrKhV/geYLdk7enLpFT+EJmvwyAMp68yU
	 s7G9lkS7mxuIw==
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1353c2f35cfso7458147c88.1
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 08:58:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+f9X7i4rVqW5N3NA48cBOWHN8B+jsUBCzAmBXZvTR3h9KtTjO+7OhUeUy7o6RRjKDyurwseTXZRKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpW8nS92iEuaWRWf2EVdC12cRG6xZdSyL4y7+GQkEHvrm/lG1
	bu7gFfmTlMRgDddOUQJ1B50/CzHVmd65F4BTv+D8bHhQqhsOIxaFj0dh8pgQVrq0317T0dlALIU
	LYM9eMIxOU3WP5xdQIRSFIf6/xBtMQlAaAGXZbVugbA==
X-Received: by 2002:a05:7022:6299:b0:135:dc3d:ab50 with SMTP id
 a92af1059eb24-137d4242f26mr125225c88.29.1780070307047; Fri, 29 May 2026
 08:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com> <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark> <c1697372-54ec-4f57-85d9-ad375ff1a44d@oss.qualcomm.com>
 <20260525142843.GA2018@quark> <e49c4a45-6455-47f3-a91f-c32c1a0b99be@oss.qualcomm.com>
 <CAMRc=MfC6CEwOXYttsav3mwqyJ2F4sburBj+zNJ25qMoweyL-Q@mail.gmail.com>
 <lj7geczhthury476ilkjym2k5fblo5pqroefsbdfgh5jcf7zy2@qrss5xc7umn3>
 <CAMRc=Me6cqasdBknbAjUZ5BqcpERYwV+NvseRJp4P0aTSYAMUw@mail.gmail.com> <20260528175214.GA3936298@google.com>
In-Reply-To: <20260528175214.GA3936298@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 29 May 2026 17:58:12 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfY-tmMCdw9FVBgfkX-FvB5Nx2X06S023GhASenSCQSNA@mail.gmail.com>
X-Gm-Features: AVHnY4LP_t91eok9MEp4yvSeZMeVRFiXKE_WmFYVgc-of5NzGm-5x7t-ox5gugo
Message-ID: <CAMRc=MfY-tmMCdw9FVBgfkX-FvB5Nx2X06S023GhASenSCQSNA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>, 
	Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11032-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 88B87605F0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 7:52=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Thu, May 28, 2026 at 11:13:47AM -0400, Bartosz Golaszewski wrote:
> > On Thu, 28 May 2026 15:50:10 +0200, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> said:
> > > On Thu, May 28, 2026 at 09:13:23AM -0400, Bartosz Golaszewski wrote:
> > >> On Thu, 28 May 2026 13:54:51 +0200, Kuldeep Singh
> > >> <kuldeep.singh@oss.qualcomm.com> said:
> > >> >>> +Bartosz, Gaurav, Neeraj
> > >>
> > >> I know about the self-tests etc., I will address them next.
> > >
> > > My 2c, the self-tests would be more important, as they are fixes. Doi=
ng
> > > the crypto in a wrong way is a bad idea...
> > >
> >
> > Then let that be "in parallel". :)
>
> The race conditions between Linux and other environments (modem, TEE,
> etc) are of course about correctness as well, even though the self-tests
> don't expose race condition bugs.  The self-tests have always just done
> a few serialized tests.  That's sufficient for CPU-based code, but not
> for offload drivers, which need to be stress-tested to find the
> concurrency bugs that occur during actual use.
>
> Is there a plan to improve the tests to do stress testing as well?
>

I'm not sure if we can easily implement linux-only tests using
multiple execution environments. I will look into it and come back
with an answer.

> It's kind of odd that they don't do that yet.  But it makes sense: the
> CPU-based code doesn't need it, while the offload driver authors have
> never cared enough about correctness and test coverage to add it.
>
> I still don't really see a path forward here, given the track record and
> poor performance numbers.  This approach just doesn't work.
>

Sorry but I'm not sure what your point is. What this series does is:
it documents the compatible for the crypto engine that very much *does
exist* on the SoC and describes how it's wired up as a real HW
component in devicetree. Whatever the state of the driver is, it's not
grounds for NAKing HW description. The IP *is* there, we're allowed to
describe it in DTS.

Qualcomm wants to use this IP and I will keep on improving it. I think
that - given the BAM locking series is at v19 now and has been
initially posted in 2023 - I've a proven track record of not
abandoning it. :)

I'm away next week but will look into self-tests the week after. This
series - once fixed - should go upstream independently.

Bart

