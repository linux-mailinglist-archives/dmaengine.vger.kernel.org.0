Return-Path: <dmaengine+bounces-11403-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F86NOTo/KWraSwMAu9opvQ
	(envelope-from <dmaengine+bounces-11403-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:40:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A566668615
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:40:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ndepELuE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11403-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11403-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72CA331AACC4
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6FF3F0763;
	Wed, 10 Jun 2026 10:35:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E23F23BE;
	Wed, 10 Jun 2026 10:35:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087705; cv=none; b=EAt6Dkc3wc5P5p+6ZGvQ99F/cgSZzbcvomGjk7arVLRHp4peKEvRhWwh43ULDmEvAfQw3Fc6o+We41Zap4pWLw5CkgrLfr3DNhj1wv3x3R1vjiqo4clxRLlEI/UKrNGMB3gwgoJHA4941wkeM8tceql9lNtOYEi/xurjVhW22aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087705; c=relaxed/simple;
	bh=PLk6E/1F4XKbP8E1C/TyTqMlBWSE19MdrRg66+4D9+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/omqguN6vR3HCN94ukln0vtJvlV2+iC12hrHxBct/aTlIRwVTp8xL+xvQkOwLCgq/obxvFagA13z0+HbXgSPFY2ApSpF1sSZg8302j9BXH8/5r0SN6NIbI0Rr2xQIlghoIhfDRJBM1mWy6rtkiebL5OhBRTTDas3doyZn9FaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndepELuE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CB61F00893;
	Wed, 10 Jun 2026 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781087703;
	bh=SeOChWWJdDACbt30MITEXDeeuwEhEpNLmKLuGmA/Y00=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ndepELuEHqpBhPWtk8+T7QxUJ/uN2VgyVfUAVl2V9Zb/LNq6RP2LD3ONqBPSEjEXI
	 jnYfrHRi13CVP4wJ6xun3OwQQUWYbycmBQAoxf/smG2TUYJBls8vSjSG3sIhi02W4m
	 wUO4iGhLgI/bJUnpe4xiXKjzUzbPQHHE2ud14jni5qk5Ijb415qETMK5xA3gqGqEKa
	 OXtCPQeX0hEod8qm3A+3Uluqxq9qVULJt2Xi8DdJXl7OlYuFIcvFEkCydh203mzHZU
	 +ysCQ5FPR90Rlj6xyJ0uUuYFXKCrofECdXpn9A45dpdglf0mTxLeWfxlPHulf71UWk
	 cLEgCQ2w+Mpdg==
From: Thierry Reding <thierry.reding@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akhil R <akhilrajeev@nvidia.com>
Subject: Re: (subset) [PATCH v6 00/10] Add GPCDMA support in Tegra264
Date: Wed, 10 Jun 2026 12:34:57 +0200
Message-ID: <178108768743.3388678.911465959943818936.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260331102303.33181-1-akhilrajeev@nvidia.com>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:thierry.reding@gmail.com,m:jonathanh@nvidia.com,m:ldewangan@nvidia.com,m:p.zabel@pengutronix.de,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:akhilrajeev@nvidia.com,m:krzk@kernel.org,m:conor@kernel.org,m:thierryreding@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[thierry.reding@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11403-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A566668615

From: Thierry Reding <treding@nvidia.com>


On Tue, 31 Mar 2026 15:52:53 +0530, Akhil R wrote:
> This series adds support for GPCDMA in Tegra264 with additional
> support for separate stream ID for each channel. Tegra264 GPCDMA
> controller has changes in the register offsets and uses 41-bit
> addressing for memory. Add changes in the tegra186-gpc-dma driver
> to support these.
> 
> v5->v6:
> - Replace dev_err() with dev_err_probe() in the probe function for fixed
>   return values also.
> v4->v5:
> - Use dev_err_probe() when returning error from the probe function.
> - Remove tegra194 and tegra234 compatible from the reset 'if' condition
>   in the bindings as suggested in v2 (which I missed).
> v3->v4:
> - Split device tree changes to two patches.
> - Reordered patches to have fixes first.
> - Added fixes tag to dt-bindings and device tree changes.
> v2->v3:
> - Add description for iommu-map property and update commit descriptions.
> - Use enum for compatible string instead of const.
> - Remove unused registers from struct tegra_dma_channel_regs.
> - Use devm_of_dma_controller_register() to register the DMA controller.
> - Remove return value check for mask setting in the driver as the bitmask
>   value is always greater than 32.
> v1->v2:
> - Fix dt_bindings_check warnings
> - Drop fallback compatible "nvidia,tegra186-gpcdma" from Tegra264 DT
> - Use dma_addr_t for sg_req src/dst fields and drop separate high_add
>   variable and check for the addr_bits only when programming the
>   registers.
> - Update address width to 39 bits for Tegra234 and before since the SMMU
>   supports only up to 39 bits till Tegra234.
> - Add a patch to do managed DMA controller registration.
> - Describe the second iteration in the probe.
> - Update commit descriptions.
> 
> [...]

Applied, thanks!

[02/10] arm64: tegra: Remove fallback compatible for GPCDMA
        commit: ee7863e43228a3143398dc5bbb943c9a735a8fca
[10/10] arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
        commit: d2bca791d5a6c00ed24e92fa71f829553b1b1674

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

