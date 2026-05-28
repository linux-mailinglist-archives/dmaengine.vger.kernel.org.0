Return-Path: <dmaengine+bounces-11017-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GWGKhOBGGpPkggAu9opvQ
	(envelope-from <dmaengine+bounces-11017-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 19:53:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4A5F5EF6
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1318F3002D26
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A53FFAA1;
	Thu, 28 May 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3RWVWIS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DEE3B4EA3;
	Thu, 28 May 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990739; cv=none; b=YV16JzzaUva8nU4sKujD8dREU/CPRuAmtHGawruBXKX/ZHejg9BbRoSDJzIv9lUllrH5od925gCMhqqi33F7I1xDAmByUWOGJgozDcHuAvI1w/Qs5KnKz7mcSRq4t0N9fkzXEMgksaZfM9BIs8zvMIDfbEkeqrfv2FyoKy4ocWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990739; c=relaxed/simple;
	bh=/WevIpPK3SaYeqJ1HmkSOi3MW+1TONCBYE4elIAounc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uryyft7CQ06RkVxxB0fGhZWEsNNbJ6sdpBFoAjAAilF9b3J8QWNjeVVdh1/NOZPgMNjY51FfGCQSUFEnfYJXtKN4mMZZIZmBJVCTKXEevuoTq0jqnBxoS0Xz0oKJ3S7HVbSKzsVRWl6lBx0uFwl0sM5kI4jMcWX1Ig2YG50KRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3RWVWIS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB45B1F000E9;
	Thu, 28 May 2026 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779990736;
	bh=wA+h2LHJqTGA0QJnfQ0FCObieUhoPZ0RdKo+Y/z5Xyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h3RWVWIS+mWdQxZ5uz+s4obm8+Xaok4BxvqhGUauCmCTRepK6hIMUzS7G3R6gcT+Q
	 9VOU+EiIiKShxPH++HQ8NedDIZl4IJYwy6tzFmD+HKQ74yPcphUdWbIxzQ8pA4u8C5
	 LKrsQryP6HyEOU8VYRp6OQJP16pQiuqlz5UCVA4xB1+VT5Jk+R5Hggtr2RB8zY3whg
	 R5Ch+8C+k5x8dbdmUSIhV8uKjSqaMc3efUjj9xVGZ5SbV+I3DIwDJDQLf0cnsSg+zA
	 gMhjZjCOKcgsFrtiTy9ODdBazicvw5YEJ0NMueTgWpcBfzpipKY8ZcbvDPGSwJZ7vd
	 H6+eDYAfggBmA==
Date: Thu, 28 May 2026 17:52:14 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
	Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
Message-ID: <20260528175214.GA3936298@google.com>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark>
 <c1697372-54ec-4f57-85d9-ad375ff1a44d@oss.qualcomm.com>
 <20260525142843.GA2018@quark>
 <e49c4a45-6455-47f3-a91f-c32c1a0b99be@oss.qualcomm.com>
 <CAMRc=MfC6CEwOXYttsav3mwqyJ2F4sburBj+zNJ25qMoweyL-Q@mail.gmail.com>
 <lj7geczhthury476ilkjym2k5fblo5pqroefsbdfgh5jcf7zy2@qrss5xc7umn3>
 <CAMRc=Me6cqasdBknbAjUZ5BqcpERYwV+NvseRJp4P0aTSYAMUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Me6cqasdBknbAjUZ5BqcpERYwV+NvseRJp4P0aTSYAMUw@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11017-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B1E4A5F5EF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:13:47AM -0400, Bartosz Golaszewski wrote:
> On Thu, 28 May 2026 15:50:10 +0200, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> said:
> > On Thu, May 28, 2026 at 09:13:23AM -0400, Bartosz Golaszewski wrote:
> >> On Thu, 28 May 2026 13:54:51 +0200, Kuldeep Singh
> >> <kuldeep.singh@oss.qualcomm.com> said:
> >> >>> +Bartosz, Gaurav, Neeraj
> >>
> >> I know about the self-tests etc., I will address them next.
> >
> > My 2c, the self-tests would be more important, as they are fixes. Doing
> > the crypto in a wrong way is a bad idea...
> >
> 
> Then let that be "in parallel". :)

The race conditions between Linux and other environments (modem, TEE,
etc) are of course about correctness as well, even though the self-tests
don't expose race condition bugs.  The self-tests have always just done
a few serialized tests.  That's sufficient for CPU-based code, but not
for offload drivers, which need to be stress-tested to find the
concurrency bugs that occur during actual use.

Is there a plan to improve the tests to do stress testing as well?

It's kind of odd that they don't do that yet.  But it makes sense: the
CPU-based code doesn't need it, while the offload driver authors have
never cared enough about correctness and test coverage to add it.

I still don't really see a path forward here, given the track record and
poor performance numbers.  This approach just doesn't work.

- Eric

