Return-Path: <dmaengine+bounces-12062-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UbPjDJtxTGqmkgEAu9opvQ
	(envelope-from <dmaengine+bounces-12062-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 05:25:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACCC7170D2
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 05:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=na1b5nWy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12062-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12062-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97B93080B30
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5FD3955FB;
	Tue,  7 Jul 2026 03:21:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DC3546F7;
	Tue,  7 Jul 2026 03:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394516; cv=none; b=Pz1CRiyowAkEwj8l1Em0fiqKMiIFrc17rA6V7g5yuS/X2aCER7BVTaYih2S1YKwbxYC2XldFr2AtVpabjVYsgCGOL1Wceby9zKCYmf8bSCN77Y5qOtoEpncmnE5eVYrJ7Jiz0ovesfIhHoysC44wgZtR0nV0ulqtgpFfx+kjAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394516; c=relaxed/simple;
	bh=kh4IibeM4fF1k0dFcf6mYXDxT+Z6Ghu5JoYeDgn/yoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/5BZ7Lt3haZiwVIMl9b7JV5I3ETQzK6mn7NhXJroFN4aeU0J2hyXvaa8pqGHsHnWq96zpA+7BUk92WO0cCri9ykk08nHzimcV9zJ5+OFSZ6XtPqoZ/btbzqSc8tcwaawVs3XziAltPiAqDszC1/xxKIFVIp4AyF+lkU+fA2RTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na1b5nWy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867761F00ACF;
	Tue,  7 Jul 2026 03:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783394515;
	bh=NAxBnsOhCNMohiZgxhYyA4/g1a6bYnN0z8VGa2lwoaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=na1b5nWylh+Y/YWMECNJk7FdvTkBOlMNo4bZAPwmvhkf5xb8Zs6XZ2ZhltP3nf4ja
	 CpUHNvutWD9U2A804/ad9lag9Aho8QrBZGp4H1+kCcy2ftPiK0DuNK8AGT7MXgNLxv
	 M9pFvVrzBV2LPcH/mDo0w1A3xyTvyIgF6EtBv68IGPulC70Tf3YqkghGcfxwqqINZN
	 2JBepXwHVyiU3qqpFghlF3Ieaa7EjIszvuMLM9FSFkSw66bLWZJJyMqZFM1c071cLY
	 +GOQxNaUwsWLxR0rfifjU8jtj68UM6HqYVDlR2+Ar2RWtD0XZAlr765K6BLBQ8MFdp
	 +exwwSVmaVrgg==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>,
	Arun Neelakantam <aneelaka@qti.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/3] Add support for qcrypto in kaanapali
Date: Mon,  6 Jul 2026 22:21:29 -0500
Message-ID: <178339449909.1938770.8933738266142836969.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:agross@kernel.org,m:konradybcio@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:aneelaka@qti.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andersson@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-12062-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ACCC7170D2


On Thu, 14 May 2026 00:22:19 +0530, Kuldeep Singh wrote:
> Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
> Validations:
> - make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
> - make ARCH=arm64 qcom/kaanapali-mtp.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> - cryptobam and crypto driver probe
> - kcapi test
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: kaanapali: Add qcrypto node support
      commit: 0a4015962f8115bdca3c0c4d0420f2ff85409194

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

