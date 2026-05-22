Return-Path: <dmaengine+bounces-10714-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id abQGGzDED2p5PgYAu9opvQ
	(envelope-from <dmaengine+bounces-10714-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 04:49:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C028A5AE253
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 04:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 977C4302BBF3
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92629AB1A;
	Fri, 22 May 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxjXGqF0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3117C203;
	Fri, 22 May 2026 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418157; cv=none; b=XSXWDHHxgDk8BrCSXZFrWSfH359ArKAbIheM3ZZ6b+NRf4tQtfClktDKBecys0+qfLciY3hFuGup4D3LKxgIxnG9z4tUyBMQ97HlpEFRRbQSzln3iFp3Mv0eAJLX2A6vK+VFUbFW+On1uvp3uJPQQGqCh0P1LDcgFKQsY8PHX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418157; c=relaxed/simple;
	bh=D5IeiSDjugFZkn9oVzBYaOh7lDTbyPXK3WT8ekIrXGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxUmT5dr8xtHk8787tpSjBkpGmPtfO4qm7hZQlPBnlxYF532YUASSBoeVUXbN5DH5yecBxxPVRHNlciAJgS9WQQDdkB8qzUYU/WTDrMR1BmkqoGvsflWuGqcFZdkdiH4pY7euS2+PPgzyhNZOnTT6XfxZSkODS5dKNX6sV+VNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxjXGqF0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE71F000E9;
	Fri, 22 May 2026 02:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418155;
	bh=wJP22E17iBj58Uahxubvv9bXvoAsoKOzmX0UJr70Oes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LxjXGqF02gmrQMXYUKSfx0Ahu9Qo4unz2eZiLS5foXC13a7sMwNg4NzBWfzhn/9A9
	 ZMCBmzOnAlIZf4RpIOUNRzwIdnNTid78nJzovMGIozK5a9MlASMY2XHxA8207eqSSH
	 bh0CIL1Ij3ols761ddpKsSN2rHGT5cgKyYP3D59USl0iHNUzp9JISgHI2q/ypbCIiL
	 bZIKbW9l8oHIQZY5oDsdlapATf2qKO2s8OIUfgSw0zYNNZQyW+lRO67cyzXITUM8Sl
	 pElanEJ1eFvd8W5G3aZfOmjnsZagn37CUrvZy+YST7pkQZZhpkfux9g69vjEAyNFxk
	 ryJg7ad40Y6mg==
Date: Thu, 21 May 2026 21:49:12 -0500
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
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
Message-ID: <20260522024912.GC5937@quark>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10714-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: C028A5AE253
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:21:41PM +0530, Kuldeep Singh wrote:
> On 15-05-2026 01:17, Eric Biggers wrote:
> > On Fri, May 15, 2026 at 12:53:35AM +0530, Kuldeep Singh wrote:
> >> Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
> >> Shikra bam dma supports 7 iommus so update dt-bindings accordingly.
> >>
> >> The patchset depends on below. There's recursive dependency so referred
> >> to base DT patch here.
> >> - https://lore.kernel.org/all/20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com/
> >>
> >> Validations:
> >> - make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
> >> - make ARCH=arm64 qcom/shikra-cqs-evk.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> >> - cryptobam and crypto driver probe
> >> - kcapi test
> >>
> >> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> > 
> > What specific kernel features would this be useful for, and what
> > specific performance improvements are you seeing with those features?
> 
> I hope you mean 7 iommu entries.
> 
> Please note, shikra is an old platform and differs with latest platforms
> like kaanapali in terms of iommus#.
> Kaanapali is optimised(in terms of iommus#) as same pipe index/sid i.e
> 4/5 can be used for general purpose or for any other usecase like
> DRM/HDCP etc.
> Whereas for shikra, there's dedicated iommu entry for each usecase and
> same pipe index/sid cannot be used for other usecases.
> 
> The performance will be be effectively similar.

It sounds like you don't actually have an answer to my questions, then.

Performance tests (e.g.
https://lore.kernel.org/r/20250615031807.GA81869@sol/) have clearly
shown that this driver is an order of magnitude slower than the CPU.

This driver has historically been quite harmful.  People were using it
accidentally and encountering very bad performance, as well as bugs such
as crashes and filesystem hangs.  We fixed that by lowering its
cra_priority.  But for the same reason, even when enabled on a platform,
it's not actually used.  Linux would be better without this driver.

We seem to be seeing the usual drivers/crypto/ pattern here: this crypto
offload driver is being pushed by the hardware manufacturer, with no
awareness of the fact that it's actually useless in Linux.

I've had enough of this.  Please consider this series:

    Nacked-by: Eric Biggers <ebiggers@kernel.org>

FWIW: the approaches that are actually used and work well in Linux are
ICE and the CPU-accelerated crypto.

- Eric

