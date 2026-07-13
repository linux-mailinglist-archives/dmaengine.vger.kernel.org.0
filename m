Return-Path: <dmaengine+bounces-12437-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nXU1Gb0/VWpDmAAAu9opvQ
	(envelope-from <dmaengine+bounces-12437-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:42:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67A74ED4B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:42:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="U/3eATsc";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12437-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12437-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55FED3013476
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32C357D1A;
	Mon, 13 Jul 2026 19:42:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8B1DED5B;
	Mon, 13 Jul 2026 19:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971768; cv=none; b=grjMT19w6HghzZgVytFcUpg3EiJT3+S9z0Le5RGo9Ci9WYNSAUKDDgIy3yYLD+fLXmWs0NVp9IAA8weu7y4Fg33NAFmGfo7WtZFb89HXUklQEgGgYlQkCd6BcCBnOiIijNgwYiei0qAi+5Lom6A6RlUpKPv2IQfJ5zkTpY9vNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971768; c=relaxed/simple;
	bh=/vYHS96BW+9vTUzU2bvVGFdcdxyli4EPs943INPCeHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VKHmjOjvw9tyajmQDEwrSOoImjfBnkAncEwyJHQFbR5RWZogdDhxFinmB5xgGpaIPm5c6+eWLWTylO+RJYsX9ay87xGnq/GI8+x/eCmHnzzYpE8kzewwhQqtezwFdJ2QE7Su19hY74Hu3Mojf9w0i5YTdoVSIv7Glg0INUF2XWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/3eATsc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67CA1F000E9;
	Mon, 13 Jul 2026 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971767;
	bh=elXTeEAGkdpcwI97nGR5SmwcDg8hTQbyL2nyh9ZsNes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/3eATsc6K98u3BI2GdPqvZTII1yKFse+0pC1Wjbq9ca3r6uUFl2jhUCl1c2xzdw4
	 x7T5+hTAfPoXKJAkSaQOo0dGo0gGlnpAJn4MLcb+A8eCAAc4BgqulRI3vHS9E66o1D
	 7kFRq3gZ8anUeqvnenxdaTG2kDjXUX7AaEguZTBWxHWFcQvV5gVhiYLvBTJOUOwgtF
	 +oE7xV1wSMeEV5q6D02dt+8mMqcpz+dBHwqM1dsiTTyET8ppnjWfCKDyyzHG9SYsZU
	 QiaXErvvtPPM6fhE0N3EFhCuoKYE6TVypleojjSvdmCnBVRh66+gaRfPUNrDm/dx2b
	 aE5y8ZSwM3CxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/11] arm64: dts: qcom: shikra: Enable CDSP, LPAICP
 and MPSS on EVK boards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Komal Bajaj" <komal.bajaj@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260714-shikra-dt-m1-v6-7-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
 <20260714-shikra-dt-m1-v6-7-bee265d3499b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 19:42:46 +0000
Message-Id: <20260713194246.A67CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12437-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC67A74ED4B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The MPSS firmware path for the IQS EVK board incorrectly uses th=
e CQS board's firmware directory due to a likely copy-paste error.
--

--- Patch [7]: [PATCH v6 07/11] arm64: dts: qcom: shikra: Enable CDSP, LPAI=
CP and MPSS on EVK boards ---
commit c0f88c4032c0357d309d8548cec707d24e9ad614
Author: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

arm64: dts: qcom: shikra: Enable CDSP, LPAICP and MPSS on EVK boards

This commit enables the CDSP, LPAICP, and MPSS remote processors for the
Qualcomm Shikra CQM, CQS, and IQS EVK boards.

[ ... ]

> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boo=
t/dts/qcom/shikra-iqs-evk.dts
> index 3003a47bd7594..727809430fd15 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
[ ... ]
> +&remoteproc_mpss {
> +	firmware-name =3D "qcom/shikra/cqs/qdsp6sw.mbn";

[Severity: Medium]
Does this firmware path incorrectly point to the cqs directory instead of i=
qs
for the IQS EVK board? It looks like this might cause the modem remoteproc =
on
the IQS board to load the wrong firmware intended for the CQS board.

> +
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-shikra-dt-=
m1-v6-0-bee265d3499b@oss.qualcomm.com?part=3D7

