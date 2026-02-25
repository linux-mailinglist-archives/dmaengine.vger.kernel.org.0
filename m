Return-Path: <dmaengine+bounces-9079-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD84HzLcnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9079-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:25:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260B1966EF
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72A8730440C9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F65393DE7;
	Wed, 25 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkiNzdh4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E13939CE;
	Wed, 25 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018659; cv=none; b=RDMPLfd6yHsOR9FzdiX5A4n5dfyB2ifQFFwa6BPMQELP4Mvho8ZRBxmLg5+6QAt5d+FRzzU3696eiG4ltaEC3CVq1KrBdVTpRHc8XL+GIdMrg3M5Nnq/V8iMHpVO0UKOSPtl2LRRJ9/5CDXtFg4IApAJflTZNydA9gv44sOclAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018659; c=relaxed/simple;
	bh=mWAOa2Ep2Ez6ZEQGoQgZ/mO6Dbm5GWbW6wlc1/rnqYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bPD2aA7dGVqHK8xA9hx7Dwb7LyOdp18Xgc5n+5zJucqoDSMuC+Ue0tDbCQV6zsYO2QGNpOmEaDBIB5fH8aA+TLX8cfFcviM4Y3Rf2zV8AeSWUZ1erVr5Qp5eHaSTvePQXcaUifd9w6nlxyHbz1eVV9VtiF8ck+cZ0+3cAKac5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkiNzdh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E602C19423;
	Wed, 25 Feb 2026 11:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018659;
	bh=mWAOa2Ep2Ez6ZEQGoQgZ/mO6Dbm5GWbW6wlc1/rnqYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pkiNzdh4i3pYqn3YgxJfAcdpYDiClD2dq1EsaazuRHFNg6Rx1tnWrw+H3mVLpjGyf
	 YipqqWM0jRWxnqfgRCrgKgp+R3bHzPDJm+F3dVJlolGnyM4ysI9unZ1rmk3fa8CpT/
	 1BUnhe8XNVmvPBYBUBRYeu0Z0Pyqn46Yj3D7mltxHCUiJfA3DWYmPP6m1ckdicBsSh
	 cqJAl9H2avs9CgSvfDF9MR4MCHMFWz6guPK0TZK5pnFlTF1chukcF0V5t1wzLypmAm
	 zX3GjZwpWRrQPQn2Xk56AtOiXeg6c2a6XJ2kOIbRMN4Br7E5d71f3PEHuCLqCE74xz
	 Y0/5Jkzu0Dqfw==
From: Vinod Koul <vkoul@kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, Yixun Lan <dlan@kernel.org>
In-Reply-To: <20260120013706.436742-1-inochiama@gmail.com>
References: <20260120013706.436742-1-inochiama@gmail.com>
Subject: Re: (subset) [PATCH v3 0/3] riscv: sophgo: allow DMA multiplexer
 set channel number for DMA controller
Message-Id: <177201865381.93331.6104381063514168222.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:54:13 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9079-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7260B1966EF
X-Rspamd-Action: no action


On Tue, 20 Jan 2026 09:37:02 +0800, Inochi Amaoto wrote:
> As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> the SoC provides a dma multiplexer to reuse the DMA channel. However,
> the dma multiplexer also controlls the DMA interrupt multiplexer, which
> means that the dma multiplexer needs to know the channel number.
> 
> Change the DMA phandle args parsing logic so it can use handshake
> number as channel number if necessary.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
      commit: 5eda5f42d2fee87127b568206a9fcc07a2f6eab6
[2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
      commit: 02a380ea7ed2d737a42693d7957ec8c33a92d9fd

Best regards,
-- 
~Vinod



