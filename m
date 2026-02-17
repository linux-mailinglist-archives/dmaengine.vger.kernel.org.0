Return-Path: <dmaengine+bounces-8932-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DVyONe1lGlbGgIAu9opvQ
	(envelope-from <dmaengine+bounces-8932-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:39:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202D14F3F9
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9ACC303717E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE5374179;
	Tue, 17 Feb 2026 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdaoN8ZP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A8374172;
	Tue, 17 Feb 2026 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353516; cv=none; b=R0n7DV1pVuEi32DgaKVfUWMxcnOs7vUEM0pFxkCCaaFOXe8qeXYUz3aHbPqjt/IPaP7RHK8xw9NSmow0ax9AtXCFjvb7TTHQ8FIQI1EguAtfBHxw0MeIcDjF3tm5AYrldQOLDjRAFwDnLCFf4tq5pmjwNHbRnu9IXSBigZtAYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353516; c=relaxed/simple;
	bh=AYuxvwWhaYeh+vB7UiqzVAiMuX4Y0gt1B0SePHmkRR4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mIXB7r5lvL/FirUsGuIzjazIw/Er5saJtz/5CKT9gR3ismVpn8NUfQCkYf1ctyrXqF3ec6g1Vu1xF34d3NdeDcuHVhMFWJBhH3eoetV16ymo5qhioFB91aRGGFnQpnNvXBdhRQST0NQGX+5+RoTcw1nrDaAGROJO/iyEjCCq8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdaoN8ZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DBFC2BC87;
	Tue, 17 Feb 2026 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771353515;
	bh=AYuxvwWhaYeh+vB7UiqzVAiMuX4Y0gt1B0SePHmkRR4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YdaoN8ZPFu99IdiYk6foIezePV7w5agyRs8v4Puqh/mt91+0wFzuHxPv+wrC0c8og
	 GUFyTdRk5ByWZKnv7l1Wm3koo8kw58WWMfE+EVumEztOd5IpKNj3OlSFZuRdOw8Lfj
	 9Bvmxd0o19oeJCtvSLOkde5DpXA8X5eO/yMyy1xVUk9YWFtXMfuquhbObI7FfORDsJ
	 pV3lhAuDplrhsnCApV6wgPZM2KSYLRq70/eo3/bUCOX7K5dqH7YiTSWcxw67K6glbi
	 8zmdEzFLBG13cj70zUxjqplmiUMXA2qsW1ca8JAJr4mK64kYriRUOMEDGhb4kMaxb5
	 V2ubX/tC4B1kA==
Date: Tue, 17 Feb 2026 12:38:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-tegra@vger.kernel.org, thierry.reding@gmail.com, vkoul@kernel.org, 
 p.zabel@pengutronix.de, dmaengine@vger.kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, jonathanh@nvidia.com, Frank.Li@kernel.org, 
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org
To: Akhil R <akhilrajeev@nvidia.com>
In-Reply-To: <20260217173457.18628-3-akhilrajeev@nvidia.com>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-3-akhilrajeev@nvidia.com>
Message-Id: <177135351368.3689181.14732835775232393327.robh@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make
 reset optional
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,pengutronix.de,nvidia.com];
	TAGGED_FROM(0.00)[bounces-8932-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 5202D14F3F9
X-Rspamd-Action: no action


On Tue, 17 Feb 2026 23:04:51 +0530, Akhil R wrote:
> In Tegra264 and Tegra234, GPCDMA reset control is not exposed to Linux
> and is handled by BPMP. In Tegra234 BPMP supported a dummy reset which
> just return success on reset without doing an actual reset. This as well
> is not supported in Tegra264 BPMP. Therefore mark 'reset' and 'reset-names'
> property as required only for devices prior to Tegra234.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml: allOf:1: 'then' is a dependency of 'if'
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml: allOf:1:if: 'if' is a dependency of 'then'
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260217173457.18628-3-akhilrajeev@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


