Return-Path: <dmaengine+bounces-10876-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N4PEvpcFGqPMwcAu9opvQ
	(envelope-from <dmaengine+bounces-10876-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:30:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A64085CBBC1
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B6D8300D173
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234C3EBF15;
	Mon, 25 May 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDMizhPw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB933859DC;
	Mon, 25 May 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719327; cv=none; b=TozRAIe73Y94yYwfd5l93XPUcS96HN3s8rfA/V15Zf6V3INZfwas3/5dP3uML1aj6/eYqztTR2+Bmt+add48Ys5IZ4XjPt2amyxmmLRGuM88hymo/O+KRAK1/pGBvk/qxivJWZRxAGt8U6bZO1EOozXQVsf4l8LamSBP1M3pWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719327; c=relaxed/simple;
	bh=6cb6z2BBZRQJ7bnscG0pV7ki/3VvomBAR+MXNL+zNi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neECjLS4+NfxqZBQT+GlW+JxgxZdTNcefy+eXJjFAXSC+tvUQfaqopFpGtZxisBPXdM7MK4UeqC/EajxTq76yW5RrL5/AVF9kgk/vWFAMrW4ke6vbc/RWotizMS1TxZRakJOm4PD1xbHgWgZnHb9ROzC/8Ec9ekONMx9whoLjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDMizhPw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED79D1F000E9;
	Mon, 25 May 2026 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779719326;
	bh=Gc8TIeAOC4qdMwFacD5GmDdKx0GJXpEWvPVgjCfPElw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDMizhPwX0xZzS0fH+xUwBftFY6sa12bt5uSBmGojFP4irF9V6vpdUvbPEnAWKn/r
	 9XhKPl2ahdJofwQsrW2L+m4SK6rTYIN2SUYSFr+2I/IlTnMmmh9z6bXnLCf9Sbs8Jo
	 eC/ksxNRPEoUzXFg1pado0o7Lwdutvw4esnSRt6/aRC50UINhTrHErVuCrqxh7o3kI
	 //zGPX0gI48jnu+d4HCln3KwbWQ+cSXKBCFQultWv/zUxTP06eEzvul65vGT6Xpdl6
	 VzhZsZ/c1ySzIvgzNEVkxyCv2VwnXKznBE2d84MzFZK08bXTXKKZkazZgI+L8Y9GfA
	 izBxEdV9jQZVw==
Date: Mon, 25 May 2026 09:28:43 -0500
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
Message-ID: <20260525142843.GA2018@quark>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark>
 <c1697372-54ec-4f57-85d9-ad375ff1a44d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1697372-54ec-4f57-85d9-ad375ff1a44d@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10876-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A64085CBBC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:10:10AM +0530, Kuldeep Singh wrote:
> > It sounds like you don't actually have an answer to my questions, then.
> > 
> > Performance tests (e.g.
> > https://lore.kernel.org/r/20250615031807.GA81869@sol/) have clearly
> > shown that this driver is an order of magnitude slower than the CPU.
> > 
> > This driver has historically been quite harmful.  People were using it
> > accidentally and encountering very bad performance, as well as bugs such
> > as crashes and filesystem hangs.  We fixed that by lowering its
> > cra_priority.  But for the same reason, even when enabled on a platform,
> > it's not actually used.  Linux would be better without this driver.
> >
> 
> +Bartosz, Gaurav, Neeraj
> 
> Hi Eric,
> 
> GPCE is relevant in terms of providing hardware security.
> There are multiple usecases coming up for example to handle DRM/secure
> buffer usecases to improve overall throughput for secure content.
> 
> Regarding performance, it's currently slower compared to arm CE but
> provides an edge by giving hardware security which is considered more
> secure.
> 
> Btw, there's been performance improvement with new targets and we are
> expecting to achieve far more better performance with new SoCs family.
> Pakala:    GPCE - 550MBps, ARMv8 - 8GBps
> Kaanapali: GPCE - 3GBps,   ARMv8 - 10GBps
> 
> Please note, there's almost 5x improvement in kaanapali compared to
> pakala. Though overall is still slower compared to arm but as mentioned,
> expecting better performance with hardware improvements as we progress.
> 
> Also, currently qce driver exhibit stability issues and that's what we
> are putting effort in stabilizing the software on immediate basis.
> 
> There's parallel effort ongoing by Bartosz to introduce baseline for
> secure buffer usecases.
> https://lore.kernel.org/lkml/20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com/
> There's active development ongoing and i believe lowering cra_priority
> for qce is fine as of now and can scale values once qce becomes
> performance efficient.
> 
> Please share your thoughts. Thanks!

ARMv8 Crypto Extensions are "hardware" as well, just in the CPU.  They
provide constant-time execution, for example.

Granted, they don't protect from power analysis and electromagnetic
emanation attacks.  Does QCE actually provide those protections, though?

Either way, it doesn't really matter in this case.  There are multiple
aspects to security, and before even considering these advanced
protections, the basics of security need to be absolutely solid.  That
is, the driver needs to always compute the crypto algorithms correctly,
and it needs to be completely robust when fuzzed by unprivileged
userspace (because it can accessed in that way).

Yet, this driver "exhibits stability issues", fails the self-tests, and
doesn't even have exclusive access to the hardware!  These are all
security bugs.  That very much defeats the claimed point.  (Plus, due to
the performance issues no one wants to use it in Linux anyway.)

As for "decrypting into secure buffers": if added that would be a new
feature, separate from the driver's current features.  It's not even
supported by the crypto API.  So regardless of whether this would be a
useful feature or not (it's unclear it would be), using it as an
argument that the current features of the driver are useful is nonsense.

As for performance getting higher over time, it's still irrelevant when
it's still much slower than the CPU, especially in practical conditions.
Yet, somehow this driver is documented as an "accelerator":

        config CRYPTO_DEV_QCE                                                            
            tristate "Qualcomm crypto engine accelerator"

The CPU is just much a better approach performance-wise.  It has no
overhead in setting up DMA, waking/notifying the hardware, and context
switching.  The CPU has a lot of room to improve too, via further
optimizations to hardware and the ISA, and in some cases software
optimizations such as interleaving.  We've already seen this play out on
x86_64, where Vector AES boosted the AES throughput by a further 2-4x
from its already-super-fast performance.

- Eric

