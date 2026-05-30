Return-Path: <dmaengine+bounces-11048-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHj/OpbFGmpw8QgAu9opvQ
	(envelope-from <dmaengine+bounces-11048-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 13:10:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276D60C603
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 13:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FBEE301992A
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59B3A8FE6;
	Sat, 30 May 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/bAeuen"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5839EB40;
	Sat, 30 May 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139381; cv=none; b=PcCTxArCxPQSoA0asoBHjX9gRCDpA95iCCi8A6R321sePPd1PtLDXLHO4C6KKxKXoget53KJtEYtYrluS8pycTTgushpXYJegdtdh50U7E/oHcpQc6fPuYimWxutgB1PW13arMaitYPR4FiwSEdJXNzQUiQnToEAr7y3YXu6fyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139381; c=relaxed/simple;
	bh=Vlwon5u2oiTDS53ovAjwBS/qKgfSz+57xCHGO3Fxdbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD4FMOjeGid/6KvoEW3452Xy8DaZbnyMg3kxJmlM1ZsJwqRT5VAb6vS86DfKwE3JjnJ5d9tP9k3c4CIqsWu/IsEhFPoxkyP0m3h9+ir7e1ZFKY2OfTGV2VR7OlSxeb02TQf5Tks5iW78Rmc8hv6WXAeA1tTIpLuaS2md1oYUSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/bAeuen; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55E41F00893;
	Sat, 30 May 2026 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780139380;
	bh=5aXXuRhylaVf92kUxKA8WtfE3uEAV0IJ9mgQEG98+0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b/bAeueniwQU0VV9xExTfq2r1Q68+vkd9XSFioNmaaeA7eDseE1J+/JRiY+6inYNX
	 O9nF9lcH2Pf5jyx0JwuM75LafHTawDFX0lpocb7jgoKBbbJqR9kbzMQTMEt7600iOk
	 8uwqfdxE8Az61vA95EeUevkiQ+JIxJ8hukXsAinvcEdWuP6EHGGHwdZK35POIpFePu
	 OIA+Xfn+Mq/SU8WFfHjCsZ1O52HXCdtYvliTDHoZoHJDy0Tvl4y9HC/sen3vuOptfG
	 6ItoUNZzQSQs/C83G1lCdo5mJ1g4wJKNaKaYg1UmXs/6WJPbHxM6buJm0vDJBjUQsc
	 dXz5q3lkRBhLA==
Date: Sat, 30 May 2026 13:09:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: Re: [PATCH 06/16] arm64: dts: qcom: shikra: Add EPSS L3 interconnect
 provider node
Message-ID: <20260530-inscrutable-magnetic-hyrax-bc3fee@quoll>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-6-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-6-f51a9838dbaa@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11048-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,f42d000:email]
X-Rspamd-Queue-Id: 5276D60C603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:19:10AM +0530, Komal Bajaj wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Add Epoch Subsystem (EPSS) L3 interconnect provider node for Shikra SoC.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index 238772f064ec..ebdb4bc15d76 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/clock/qcom,rpmcc.h>
>  #include <dt-bindings/clock/qcom,shikra-gcc.h>
>  #include <dt-bindings/interconnect/qcom,icc.h>
> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/interconnect/qcom,rpm-icc.h>
>  #include <dt-bindings/interconnect/qcom,shikra.h>
> @@ -1833,6 +1834,14 @@ frame@f42d000 {
>  			};
>  		};
>  
> +		epss_l3: interconnect@fd90000 {
> +			compatible = "qcom,shikra-epss-l3";
> +			reg = <0x0 0x0fd90000 0x0 0x1000>;
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
> +			clock-names = "xo", "alternate";
> +			#interconnect-cells = <1>;

That's not a separate commit. Where is the consumer of this?

Don't split commits one-per-node.

Best regards,
Krzysztof


