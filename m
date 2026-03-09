Return-Path: <dmaengine+bounces-9346-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JgmHgCzrmkSHwIAu9opvQ
	(envelope-from <dmaengine+bounces-9346-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:46:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0D2381FC
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF33D3019837
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1B3A4F58;
	Mon,  9 Mar 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W36W4/zC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21F3A4525;
	Mon,  9 Mar 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056763; cv=none; b=Zq1rvIgZLQDbMXjs5ehsItxWO7FSwZ2GZVJzZvyZGiLO0kGK7gBH1P2U1U3sw4kCCZbAaebMxkxTNO93OGCEEs1UQh9FsARA0tZnStCQlC5WnnHj9AT2QKX2rR2a408YGiWXrKf0OM+ty2DR64JaeVEMOCiq7wf1F7bW61xUD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056763; c=relaxed/simple;
	bh=4GHo3rpAhoh7Ez68qCniCSzBJN6YciwSNLek4y7NmYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WrluL0cUpewtxz5uqHD/AFCZZwvoKF2x4wlzrAyTsRGBP7uk0gVO20ielvP4U870RaQ8cmDBbnTq/QDS3ICEY9ge4xym2s6pUWlksVINfXD0s5R+WVsk6f95Z+8Bmc2s8AL/EsAL050YtkUGIHEngzUfNuty2x+QA1SLMWigEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W36W4/zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECDCC4CEF7;
	Mon,  9 Mar 2026 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773056762;
	bh=4GHo3rpAhoh7Ez68qCniCSzBJN6YciwSNLek4y7NmYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W36W4/zCIY1OQLpUddYgQSvcv7rfjtlmRVHyJWDp1qi5vJ8n96Owl8g6LzSuwZmv3
	 k52gqUlkRvZUAu4nUfC0r1UID4i87J/PMR49y7ivSYsBB1e6g/VADx63uaCGWE0KtO
	 Sa3ZGFnXiAMFTj/m5/UI9sjUs7uWanwN7NQ9JIOj+BLMVePRpwUfjHxKMuDr3sWORO
	 6+CUY6XP2qt2372Oe3MKYdbXJASTo0PbmoXI4v0NSGIzN1M/2FIqEeHc+JmPHkygeO
	 YAyApKuiWuDCXiWEeVEiPN/75ySCyF40zTrBDcSG/1kr20/u2AsE71oUvWhn02XKCF
	 Autm9PxLwOCxA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Jindong Yue <jindong.yue@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
Subject: Re: [PATCH v3 00/13] dmaegnine: freescale-dmas: small improvement
Message-Id: <177305675929.117444.10373471649910063885.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 12:45:59 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 1BD0D2381FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9346-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.917];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Wed, 25 Feb 2026 16:41:36 -0500, Frank Li wrote:
> Add managed API devm_of_dma_controller_register().
> 
> simple mxs-dma code and add build as module support.
> Use dev_err_probe() simple freescale dmaengines.
> 
> 

Applied, thanks!

[01/13] dmaengine: of_dma: Add devm_of_dma_controller_register()
        commit: 3a005126c9d7f30093627a6f329656c358e16b3a
[02/13] dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()
        commit: ab2bf6d4c0a0152907b18d25c1b118ea5ea779df
[03/13] dmaengine: mxs-dma: Use local dev variable in probe()
        commit: 96857a90982c2a461520fadc55dda3b8051e8d96
[04/13] dmaengine: mxs-dma: Use dev_err_probe() to simplify code
        commit: 4a5b0a728d665b3b7b08fb5bf6b2f69c995e30ec
[05/13] dmaengine: mxs-dma: Use managed API devm_of_dma_controller_register()
        commit: d11544c674b64beb9948724ba27187238c52b079
[06/13] dmaengine: mxs-dma: Add module license and description
        commit: e1b712c9352cf74285973462ced8d60ed7a9183c
[07/13] dmaengine: mxs-dma: Turn MXS_DMA as tristate
        commit: 67adf1f6643d75e33509900a2cb35db3a31f0410
[08/13] dmaengine: imx-sdma: Use devm_clk_get_prepared() to simplify code
        commit: 5daee52d7cc87415367fa0051a80998cccbab920
[09/13] dmaengine: imx-sdma: Use managed API to simplify code
        commit: 8982cb214a7f29db7d28058a3b4697f436af34d2
[10/13] dmaengine: imx-sdma: Use dev_err_probe() to simplify code
        commit: 917edfa57783352cd491cd5759a04d7b60de1714
[11/13] dmaengine: fsl-edma: Use managed API dmaenginem_async_device_register()
        commit: 4035726a6b724ff0f04b4f1429c7b1a935fc2e76
[12/13] dmaengine: fsl-edma: Use dev_err_probe() to simplify code
        commit: 804e18f7da6d29cff7ed4e004bcc05658f51d737
[13/13] dmaengine: fsl-qdma: Use dev_err_probe() to simplify code
        commit: 2438deea9ff82940ebfce67e232d558199ab8a6e

Best regards,
-- 
~Vinod



