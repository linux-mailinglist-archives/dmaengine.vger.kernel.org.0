Return-Path: <dmaengine+bounces-11733-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UM27Bql8OWrFuQcAu9opvQ
	(envelope-from <dmaengine+bounces-11733-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 20:19:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF56B1C2E
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 20:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="W/QrQ8Gs";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11733-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11733-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21E98300E151
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A963446B9;
	Mon, 22 Jun 2026 18:19:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3933EAF9;
	Mon, 22 Jun 2026 18:19:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152353; cv=none; b=EQXkeN3onOy9/fldx1D6yD7Ghq8bMXuvPyvBJcrw6EfweuyqhQte+iwb9hcqWkLn/h5/dcclFRX0DKDEjgNnajtr0k0kvOqhy7ogJ8YQCbKw5tiboy1Y3ZF9M7YkM9u72nqGH03KAqXt7tRSEjUcCgGk1Ri1yJQZnd4a6cCC3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152353; c=relaxed/simple;
	bh=aKPfzKSh4kE5bd0323tvQMZuR4CGMJhZvfCO//1dm0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oomhXPD5hBMTzyl6BYtrupE0mXfzVTz7jorrTJnhhYJ0fc+UlebG1Ec6B2AaajwTbVsh9btEFeiYXhzd3z07b6ZtvQ5WiMDgbuHW7r3WXESrbL19WMgVUO8d3M7+ioDlMmQ6vggFPVZdhkMjeDmm05mRU40467JOVf6j74UQ8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/QrQ8Gs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D82D1F000E9;
	Mon, 22 Jun 2026 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782152351;
	bh=XKlqJDn41xHqxzBssntuIwLv2qXiV/8MEgFKl/31tuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W/QrQ8GsogW7QyIXylJn27vxjfhXkXzLQahuKRQQthlkDvW6mIkGRGFoQ3mHpnOnl
	 8pFOXS8rAz6Jrdna6Qq63quSFnPeujpT2upF4iIggQQzxNQI+4WstblsTliuE06/qc
	 JX1JWmRjRYM04WCNoQ6KG1nkuD8+1QNZVKGWaugrzWjklmz1z22Je/LyjALcT4QCUr
	 Pz9PlT7YLynMWhP56ut9YH2jYvUTpBknBf38PhpAQ79ppC8mHtlUERsmrGQO0b+cYD
	 MavyY5UKyd3nqs0WZMYVxHixpTJhwL19J36iDFNmuT27gjIU6lyx9iWpEer3nu6+21
	 iZqorFo426LSg==
Date: Mon, 22 Jun 2026 18:19:09 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
	Harshal Dev <harshal.dev@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] Shikra: Add DT support for ice, rng and qce
Message-ID: <20260622181909.GA1250822@google.com>
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
 <53b1fa61-9692-42fd-a295-98bbeacbcd9a@oss.qualcomm.com>
 <20260619164506.GA3223@sol>
 <CAMRc=MdJJRPBeNtAUr82b4zv7vLjrRQ76Q3bJHQYEigaE2Hqog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdJJRPBeNtAUr82b4zv7vLjrRQ76Q3bJHQYEigaE2Hqog@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11733-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:vkoul@kernel.org,m:thara.gopinath@gmail.com,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:harshal.dev@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,oss.qualcomm.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31EF56B1C2E

On Mon, Jun 22, 2026 at 04:25:12AM -0400, Bartosz Golaszewski wrote:
> On Fri, 19 Jun 2026 18:45:06 +0200, Eric Biggers <ebiggers@kernel.org> said:
> > On Fri, Jun 19, 2026 at 02:13:28PM +0530, Kuldeep Singh wrote:
> >> On 21-05-2026 18:47, Kuldeep Singh wrote:
> >> > This patchseries attempt to enable sdhc-ice, rng and qce on shikra
> >> > platform similar to other platforms.
> >> >
> >> > Previously, the 3 dt-bindigs/DT changes were sent as individual series
> >> > and with feedback received, clubbed them together as all belong to same
> >> > crypto subsystem.
> >> >
> >> > Here's link to old patchsets.
> >> > QCE: https://lore.kernel.org/lkml/20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com/
> >>
> >> Hi Eric,
> >>
> >> As selftests issues for QCE are now fixed[1], so shikra series should be
> >> good to proceed? as your concerns[2] are now addressed.
> >> I am waiting for merge window to end and will send next rev post that.
> >>
> >> [1]
> >> https://lore.kernel.org/linux-arm-msm/20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com/
> >> [2] https://lore.kernel.org/lkml/20260522024912.GC5937@quark/
> >
> > If you think that then it sounds like you need to read what I actually
> > said.  The fixes are appreciated but don't change the big picture.
> >
> > - Eric
> >
> 
> Eric,
> 
> I mentioned it in another thread[1]. This series is not adding any new features
> to the QCE driver, it describes the hardware. The SoC *does have* this IP and
> no matter the state of the support in the kernel, there's nothing wrong in
> extending the existing bindings and adding new dts nodes.
> 
> Thanks,
> Bartosz

It enables the driver on a new platform.  So it very much has a real
effect.  It's not just adding a hardware description without a user.

- Eric

