Return-Path: <dmaengine+bounces-11444-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DpTGCPtNKmrUmgMAu9opvQ
	(envelope-from <dmaengine+bounces-11444-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:56:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EC66ED53
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LpIYlfu2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11444-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11444-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6A331F9368
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C4309EF4;
	Thu, 11 Jun 2026 05:51:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9A3546E2;
	Thu, 11 Jun 2026 05:51:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157101; cv=none; b=rWQmbVXdtsHxNcdKLh9vanNiLI631TxsmHcfEuy31tl/ejQk/dE2P1r5hSnGUbL/CeHJG4vkcAYKB+y28RYAcdp8Z/eXguxro6UPgBBdKMcRR1Hxtq3R0QLZDxKXSeeN4WnY67iBpD9POVrPZBPdSG+WWCjyOa/jeYjYOBfiyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157101; c=relaxed/simple;
	bh=xsWaDXJ2Lijvj/b35Oc3lpumaiAMqzwqLojdbybEV7A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qYkvu8sgKAWU759jR8GdYBfgsm6w/c1337Yt77h2iccF+E6Cj1hu3GDsbYsjDtRegkxlY51Pc39SFdxhBzSJLlhPl+zYXg42q71FlqpB5ZAXPZrJ9Z2hMV+JNDoCJmmRRs1nTOjoSCdPK+7VfKUsZBHVSgeBY9w56dJKOVC82NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpIYlfu2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA86F1F00893;
	Thu, 11 Jun 2026 05:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157098;
	bh=iMYY/GPoBfGBXP9b6MNvaXHdnKeIm9TXRCLui0kx+4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LpIYlfu2G9TUbsfHA6m9Q26CCVs2dwNwVvvgv3hs6X2BW11dyLrHv6Cofu3G+MBIm
	 xb80Z6Wspnc6JJotWNHRih1Uch+3nXYfWOR0J2fyY4OC7TYZYOxED4xKodc0FdKcee
	 VDKz7o7y8ddSfxQ7kw+HykCbFVSXYuFMQXu+LQJE4ayydmcxweA/FmPVqTdlF61B7R
	 XqbvkeZaW+sBscAatwCc2DSJ0G+wfAyrlp/tXsFOd2m3FsDN8l3RcPKRMPkK7yyKaB
	 CqEJsVIbIIRGy5lzGXlXEDT0Ju16XI1lRaghVezIKdrP+GenHqOuRLhPBKkWR1CIXO
	 lT+6FVak91C5Q==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: =Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20260423173602.92503-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260423173602.92503-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dmaengine: qcom: Unify user-visible "Qualcomm" name
Message-Id: <178115709637.468137.5781172438800883837.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 11:21:36 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11444-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:andersson@kernel.org,m:konradybcio@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 963EC66ED53


On Thu, 23 Apr 2026 19:36:03 +0200, Krzysztof Kozlowski wrote:
> Various names for Qualcomm as a company are used in user-visible config
> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> "Qualcomm" so it will be easier for users to identify the options when
> for example running menuconfig.
> 
> 

Applied, thanks!

[1/1] dmaengine: qcom: Unify user-visible "Qualcomm" name
      commit: 29d0b2696d4602d36d91dc68a2a5a022ca485a5f

Best regards,
-- 
~Vinod



