Return-Path: <dmaengine+bounces-11047-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MqsN4G+GmpA8AgAu9opvQ
	(envelope-from <dmaengine+bounces-11047-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 12:40:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB660C2F8
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 12:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D1A8303A685
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B023A59A8;
	Sat, 30 May 2026 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyuIxUIo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654493451A6;
	Sat, 30 May 2026 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137596; cv=none; b=Cl4jZ1GU+YOn38KhW5w857Gy1Dla67rsM+qPkxskWvnSGq16R9HfW4aE0xYFJfu/I5O6PRDX77EGH+eSCKPmwLUnHS0550mfYzXkP7B+ppmDRedM/OwtPzg9FgPGftM6bhya2w7qwi5EYBkODF55JiKdi2RWUDbTpvcswLatJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137596; c=relaxed/simple;
	bh=bvX+5/EHDb2E4TM3oDNEENftks1JXuPee/Yx7K7moS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R048jC19syx/uohg8E48fS3v3mvixXLZVE6UyRoJskrD1/aFS1UF1EN+5Ibm/t4Oz4EfzeC8ClY3kWrr03ftqupz3ZDv5oS1xBOJMplyLMkFYK5GxzXi0dlC7TME0xnk2yHyv91c061AA/NdTtAGyjLGn3uRF18iOAcotv1Hd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyuIxUIo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E401F00898;
	Sat, 30 May 2026 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780137593;
	bh=bvX+5/EHDb2E4TM3oDNEENftks1JXuPee/Yx7K7moS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YyuIxUIokMM8XDlrO0hwKH0AkWm7eJOhPt6XO8bdEeyUtWKgrz9bOBbgkYF+CPS0j
	 qb494VaPM+t3IaLgk//VQKCaXV6YrwZvf+UfY18xNxjAjFGC3nT+ySSh7pX8Z04dgF
	 z+55x2y/Igt8BffDsUiCb/L1mxzUPU03q/0ng3AO0mrlDu2rhgksOAbuodnO9jOHZ0
	 4PpOx/NHPutvet3axdSVcedmOvUrwfs+tcYS0Ge+IMGSeL8r+j0MC7mUAUhOESaqHR
	 iqUJXm+UQbJSWCNh/U/Y/VKXxDzwI/PMJ06+lnE92sdaial2+JQSUGq4UPvTic0eRi
	 GlljQKh5GbgmA==
Date: Sat, 30 May 2026 12:39:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>, 
	Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
Message-ID: <20260530-spiffy-glittering-quail-dff199@quoll>
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
 <20260521-shikra_crypto_changse-v1-4-0154cc9cc0de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521-shikra_crypto_changse-v1-4-0154cc9cc0de@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-11047-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,oss.qualcomm.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CCBB660C2F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 06:47:11PM +0530, Kuldeep Singh wrote:
> Shikra bam dma engine support 7 iommu entries and not 6.
> Increase maxItems property for iommus to pass dtbs_check errors.

What errors? There is no Shikra in upstream so how could we have errors?

Best regards,
Krzysztof


