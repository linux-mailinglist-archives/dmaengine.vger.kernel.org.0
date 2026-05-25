Return-Path: <dmaengine+bounces-10879-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GfQLhpqFGoTNQcAu9opvQ
	(envelope-from <dmaengine+bounces-10879-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 17:26:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDCA5CC3DB
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A866130067A7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047CE3F4118;
	Mon, 25 May 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETJnT1Pn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C032B107;
	Mon, 25 May 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722775; cv=none; b=PdRxBs2Dcvd/o4p01cIotspNA70ZzMnVUNiOPl2VLuSlyPXXDOctPmhjz6uoa3rE2rGXVcrx08xBa2zSBkSj+T//FCulVasMyyBKC06VnVWZD9Z9tX0I1u1ESfTb126Q487/1wDLSnUDA7xZb5LmDGU00i1cTy/uJ1qZx9dgWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722775; c=relaxed/simple;
	bh=RfcMM+1Ul1TH6o3SyNkodcSPyLfrfonQGF9fF1wOB2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NABw89P/QV/by9T0tEgOYW4gyPaZ3nj5Rrm1Jm3PgyLMTmufP2BaYruJZxiEekPU0VsnJ7V5sVEcS0uiWnXMYOISvZxfBmfZQgQ1uooKknXwowZ6LILadN8YNBqiYa7tawPUzBhE9UfkpZR5/J3GPwG6s1vaiCK1k4DfRCFvhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETJnT1Pn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C5B1F000E9;
	Mon, 25 May 2026 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722774;
	bh=fMUe6rHhr5mw4H4Gp29XCyqFGgOSultc4Wo1eFJ9vMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ETJnT1PnKGCa4aTIfPr9o/NcH3g0HfaCkon7m+kBUe0LdVeEOTyu1sdmfXdDTgF1Z
	 qejbctwH4buPjePVwT5glKjN83ZxQ7Unk3/7KCAEJqutSs+TFKD+shQHG7lP03+aJY
	 6FqwhMEzXEqS78RMW25/4GItalC4KxH6CRgAF8FCTq3wyy4NIOrgv526M1XaEkPYsG
	 6F7iW4TsLSCDN8Y8Wy2pxlLVNrjXK+XtnA7Ls7AQ0Yljvqv+fDetJ90OkGVGdOwaKp
	 CcQm/24Qr4p0RGCuQIQfV70MgVRlfJ/wPyfeo4ZagRKzMkd7Er5DdguX2noWFbkcDO
	 Sj3Wk5UHZPs6g==
Date: Mon, 25 May 2026 10:26:11 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Thara Gopinath <thara.gopinath@gmail.com>,
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
	Bartosz Golaszewski <brgl@kernel.org>,
	Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
	Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
Message-ID: <20260525152611.GD2018@quark>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark>
 <c1697372-54ec-4f57-85d9-ad375ff1a44d@oss.qualcomm.com>
 <20260525142843.GA2018@quark>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525142843.GA2018@quark>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10879-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nist.gov:url]
X-Rspamd-Queue-Id: 5BDCA5CC3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 09:28:43AM -0500, Eric Biggers wrote:
> ARMv8 Crypto Extensions are "hardware" as well, just in the CPU.  They
> provide constant-time execution, for example.
> 
> Granted, they don't protect from power analysis and electromagnetic
> emanation attacks.  Does QCE actually provide those protections, though?
> 
> Either way, it doesn't really matter in this case.  There are multiple
> aspects to security, and before even considering these advanced
> protections, the basics of security need to be absolutely solid.  That
> is, the driver needs to always compute the crypto algorithms correctly,
> and it needs to be completely robust when fuzzed by unprivileged
> userspace (because it can accessed in that way).

Looks like these protections are not even present either.  From
https://csrc.nist.gov/CSRC/media/projects/cryptographic-module-validation-program/documents/security-policies/140sp5077.pdf :

    > The Qualcomm Crypto Engine Core does not support any non-invasive
    > security techniques. Therefore, this section is not applicable.
    [...]
    > The Qualcomm Crypto Engine Core does not implement security
    > mechanisms to mitigate other attacks.

- Eric

