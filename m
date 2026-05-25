Return-Path: <dmaengine+bounces-10877-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPlELSthFGqgMwcAu9opvQ
	(envelope-from <dmaengine+bounces-10877-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:48:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDF65CBE51
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3938A3018BE0
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD73815DF;
	Mon, 25 May 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL8/cH4P"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008F234973;
	Mon, 25 May 2026 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720366; cv=none; b=EfOT72bISm5if64F8D7Uqb64Ae7evom4Wgpiv4OSEdIobwladWLyfuLr2JCmf6FqGIcop6Fv3THkv3oiMGkuRJmdVpzx3QB2EdXPBDZd0v3P6xtjEdmobQUng3dPOay3HEe2BAn388ZkM4vCYgI5cSRWYklCb19XX9xmTbvoqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720366; c=relaxed/simple;
	bh=Sm/M0HjNFqZ1eSv2mluixAU5gbpbTuKQVxvbD4heq34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8qJmlixAyZIhrJbyc8L1FbpBQupxLcfl5ak3bcyvO6W7rn0gy94g4qOATpRW6ID1+kmXsWlo09s3FvdvcuktHrL/Vw7G1bqctde92asEv6AAv8Fw0NsRFhZ5PnBGYMokBZLQakWW60fnJdp3P1DD/2L/TwbtZqCLgjzyUGWePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL8/cH4P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E6E1F000E9;
	Mon, 25 May 2026 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779720355;
	bh=b9cI/KWD1rPxgUtFYBlVXpvnvZIRUxCSpvplhBdA22Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WL8/cH4P0gQ4bK41WN3FQmt/rz8FKNyik/pgMg7a8N1rzS70MgmkTSVgY9xeCBdb0
	 HMiGu7DpFtxriPL6C1TwNeFCWus75GlgT1oGcOP/R6vhuc2/MyAD3GzStGXeZNk/lv
	 uSOmuY92V6oJVkILucV9zPRLNdsJewP1oeh2v7x/1NYQbciCxz20ufDuhLYPKUmHlB
	 6MdbJ48NW5QRynCPgSvU/n0a/kCfgep+PQPGwPl1EujUqi36qi4PObfImdOWSlq8jI
	 ITydO2EtGK8DCrOiSPfWHupY1PbXzgmu9AeFZzCY3uD7Y9L+jrCHpzvNltCEJ5UP7x
	 eACWUMxtzyPNg==
Date: Mon, 25 May 2026 09:45:52 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
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
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
Message-ID: <20260525144552.GB2018@quark>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark>
 <s5u3vlc3r2blg5hniwuqizazooldebr42n7hr2f4jw2ybbq3oe@cdmrv2etrmj2>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5u3vlc3r2blg5hniwuqizazooldebr42n7hr2f4jw2ybbq3oe@cdmrv2etrmj2>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10877-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4DDF65CBE51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:07:49PM +0300, Dmitry Baryshkov wrote:
> Are other harware crypto drivers faster or slower than the CPU
> implementation? What about the CAAM (sorry, it's just the driver that I
> worked with few years ago). Or Xilinx? My guess would be that for the
> most of the modern ARM64 hardware the NEON implementation is faster than
> the "hw IP" one.

Yes, QCE is hardly unique here.  It's just the one we're discussing now.

> My assumtion has always been that we support crypto IP
> for the sake of security (i.e. making sure that the key can't be found
> in the cleartext in memory dumps or that it's impossible to tamper with
> the hash values before singing/verification). From this point of view,
> using priorities is expected and logical: most of the users will need a
> quickest implementation. Some users will need to use protected keys or
> other hw-only features.
> 
> Note, I'm not commenting on the driver being buggy. If the issues are
> not fixed in a timely manner, it should be marked with 'depends on
> BROKEN' and further removed if the issues contine to be non-fixed.

Only a few drivers support protected keys ("paes", "phmac"); QCE is
*not* one of them.  There are also no explicit users of protected keys
in the kernel, so even if supported by the driver, it's almost never
used in practice in Linux.  The only way this feature could potentially
be used in Linux is if one of these drivers is present *and* userspace
explicitly chooses to use it with one of the few kernel features that
might implicitly support it, e.g. dm-crypt.  AFAIK that's extremely
rare, and at least in Linux it's really just a checkbox feature.

(HW-wrapped inline crypto keys do get used, but those don't use the
crypto API or these drivers at all.)

As for making it "impossible to tamper with the hash values before
signing/verification", these drivers don't provide anything there.

- Eric

