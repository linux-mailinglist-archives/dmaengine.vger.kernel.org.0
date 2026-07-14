Return-Path: <dmaengine+bounces-12524-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id klacNxS9VmrBAgEAu9opvQ
	(envelope-from <dmaengine+bounces-12524-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 00:49:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91861759458
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 00:49:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hq7tWWJi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12524-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12524-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 688F5303E2BD
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A970423EA9;
	Tue, 14 Jul 2026 22:49:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE125CC57;
	Tue, 14 Jul 2026 22:49:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069384; cv=none; b=C/VcBV8ug9dVvVFANQXLxPgxV3jcOsKuMuf6PEVQFgQSW5lp7YSVFh88eXyf56P04GxiE/IcOB9HGd5W2dxi/MWkks3ayiq/AtHa0jZ7Fo/w02ibbpFjse8NyIwJ7AgXvTR/H0co4vgpwYDGga/hKgK0LmzuDlFk4gvA6HWAcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069384; c=relaxed/simple;
	bh=GIhijpG2E6Yu8UVi3EtyTNDMQS+0eaChPrFTlN5MqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBCqcfuAToU16EN8v6ZLsAAJId4+YhhHcSthA9UvO2Tj28VbFyBrEhssfZEIODN0AA07BLhkTFwlSZCmbhNdLKf+PyQijnzNFnpqffh04gHk4qnqjLkk4BNmXnigUIZsJGhuzEv0On0rDQ7HuwU2lognVYEQGkjV68YjkcceAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq7tWWJi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6EC1F000E9;
	Tue, 14 Jul 2026 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784069382;
	bh=PJr3xdYo5O85I5lwR0CL/86n0qwagbLxFzej3nisPIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hq7tWWJiyRpVUu0HieOgsngJMw/gTdsmLAn5xy0xztl4JNb0PvlKlQGODIT4SwXdh
	 7D5Ma/KZfAzIEDM9oTGtVkL5fglMB8B186bYLv65uY1gRcMIhYU9ocjkLWbo+XqS7R
	 I/mi6OKEmTIP33GPMDFaZ7wJsdTDM4iPyLUwODMMtWbRtCQI1oS2pO6APxpn0D/bsu
	 04yQyL19SBwAQFDGDcDkgBPsqsUxt+nmY6qjBk0fXQbUwPueNloWAHERlerhA4ESUZ
	 CAMRXMK21Ly7MqVsgCMd1wTiMuw0bVSGt5d+Fe3NeF4PXUA+c2bdFFNqKZRJ891yvz
	 cCBr/dRVJBUxA==
Date: Tue, 14 Jul 2026 17:49:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Frank Li <Frank.Li@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 01/11] dt-bindings: interconnect: qcom-bwmon: Add
 Shikra cpu-bwmon compatible
Message-ID: <178406933124.3270615.16874673383126107695.robh@kernel.org>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
 <20260714-shikra-dt-m1-v6-1-bee265d3499b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-shikra-dt-m1-v6-1-bee265d3499b@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12524-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:sayantan.chakraborty@oss.qualcomm.com,m:vkoul@kernel.org,m:konradybcio@kernel.org,m:krzk+dt@kernel.org,m:linux-kernel@vger.kernel.org,m:djakov@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:andersson@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91861759458


On Tue, 14 Jul 2026 01:06:50 +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
> bandwidth monitor. Shikra has a BWMONv5 for CPU.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, since I picked up the Eliza changes.

Rob


