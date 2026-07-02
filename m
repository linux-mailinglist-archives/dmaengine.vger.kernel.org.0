Return-Path: <dmaengine+bounces-11983-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TAVjFFKMRmp1YQsAu9opvQ
	(envelope-from <dmaengine+bounces-11983-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:05:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9E6F9E5A
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DK9u0G4L;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11983-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11983-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFEEE306AD11
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D0733EB1A;
	Thu,  2 Jul 2026 15:58:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5833E367;
	Thu,  2 Jul 2026 15:58:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007932; cv=none; b=nT1Imk+v5RH8s1SZo5bSPtwq6ICCYO1kd3oYWyHNSJG8FB0KWChiRJlrcWWelRNnB/eGwAW6g7YoVjWPt+vJID5vNb1oM+TksLgynOMpf6SSK7MVGWoIrI245a88rN4naqCoBeY77WqBYrFfYWbYKExhwe+JIYximGOWNMha4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007932; c=relaxed/simple;
	bh=ktOLSkM4QNGp+BofIWyIQCjC61aNq1Rwowp/RLsjqi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ud0LjxXEro0MsCAPzgsBwntKkt4yWWbV/4Tt5de3Ns4tsMHF/Lx+iChM7MREztLquk10hwuESdCbKhTWDsmvrXPNFIBBw+06zV02NNQu6VkiwDaAJ8rVsrGXRCXsfY5uZ1HLYQnnS204+WaAEoEoMSA7AhGYkuhkQOlU6P3849E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK9u0G4L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3781F000E9;
	Thu,  2 Jul 2026 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007931;
	bh=zhi0CQ2SoxC+BtbxZrczEoNYIRXLtoEisvqq87+Gc9k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DK9u0G4LxdYDzdX7KkEQJo31HVW1qTC+azJx6ZptlLjsMCkWOxw4Tx13f8SPHH4i2
	 yhld5Nfc84pApxj9+Y/Hz7Tag38LNF3vI25DAsFAsl9eb0OjRYCP5apo3AwtMt2Wih
	 3VB768MIygVZLuoNM3nFeei5+59xXKGB2fq6auEYyenYWR5MNrmQjKVpE5A/divVAq
	 CaJ6QmeFrtToBe6sgcYXatnaTbmZVop5PC9owa2r6Wt3dDiIVQp6PkbQOXTOCOhFgi
	 yNw1XC5AHRo4Fycmdb5a0lSZNx/af4PFZV9aXQbheeRWuZuW6EC9z/NQQU9pNMAKVr
	 WAoKp6ONmhzjQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, absahu@codeaurora.org, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Lakshmi Sowjanya D <lakshmi.d@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260615060908.1263171-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260615060908.1263171-1-varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v7] dmaengine: qcom: bam_dma: Fix command element mask
 field for BAM v1.6.0+
Message-Id: <178300792825.748656.1093234634497578365.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:28:48 +0530
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11983-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:absahu@codeaurora.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:varadarajan.narayanan@oss.qualcomm.com,m:md.alam@oss.qualcomm.com,m:lakshmi.d@oss.qualcomm.com,m:Frank.Li@nxp.com,m:dmitry.baryshkov@oss.qualcomm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAA9E6F9E5A


On Mon, 15 Jun 2026 11:39:08 +0530, Varadarajan Narayanan wrote:
> BAM version 1.6.0 and later changed the behavior of the mask field in
> command elements for read operations.
> 
> In older BAM versions, or prior implementation assumptions, the mask
> field was effectively ignored for read commands. However, starting from
> BAM v1.6.0, the mask field for read commands is repurposed to carry the
> upper 4 bits of the destination address, enabling support for 36-bit
> addressing. For write commands, the mask field continues to function as
> a traditional write mask.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
      commit: 867621ba203027338b525af6729719c544135336

Best regards,
-- 
~Vinod



