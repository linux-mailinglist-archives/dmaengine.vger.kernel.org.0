Return-Path: <dmaengine+bounces-9216-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL7RFMvUpmnHWgAAu9opvQ
	(envelope-from <dmaengine+bounces-9216-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:32:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637A1EF76D
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39A8130F5F89
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A232ED2E;
	Tue,  3 Mar 2026 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTWDAzb+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2226290;
	Tue,  3 Mar 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540726; cv=none; b=PylW7MlLRrt8+sU4NPlbf/rVsa3CmBU0+SND7Vyf/1UG5G5o/YxF+PkbQ4KeD7u+55h79btH1a9CXKQplHf58fQAGefMWIjiIPbETq+G9G/P2dyBYB7CFN7VGVwPl7WvWVHBCWgDy7iVH3H2CvlONu4ZrMcCYpcO26c6bOnnbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540726; c=relaxed/simple;
	bh=PMRj5DiSswBZ8JVrsipRFhfuchmIihjwmxajOk6pHbw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kjSvl+1wkdujtHXTnofs0SMlhwWjXzBCA0n8P5T8lXtB3BV2TrDwVGYFFjHoDeQTJCJgEIW0t0N/qw4hPrhvtCYJ99A48YZ36FFzXC5MuzvcpHyO14s0pwIjtyAvW9jDaF1Gom5PrKLaaujYORkWYQDOrMuyyPpclNQZH2qfRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTWDAzb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7ED3C116C6;
	Tue,  3 Mar 2026 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772540725;
	bh=PMRj5DiSswBZ8JVrsipRFhfuchmIihjwmxajOk6pHbw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZTWDAzb+/P8CzulAf42UDvYWYVyJd5+bDiRNCpPvorVKah2N7fRz+Asb4x3VBhi+g
	 mokUu6XdDAQU81CHLNEBOR+n8viBMki10DeI2+UUaQIRZDDgdZdiI1J41lFvqEkiUV
	 vsEjirkZl0KszBWcq87ElLWmGQesvCmN453S7G4Z5cI7MSGngLrGXLer1WOqqKbIqh
	 FWTu03BRat2meYBLqKKdR30arHL1qzla19uiZm155BxSilONtO3ZP0HIBwl1VtMW2f
	 3K4iYV+lU/WYhN5PZq5d1XT8HapPNkQIk5Z5i3p3KJ52Djl5IPiBqc7SXp0oC69V5j
	 iE+6/zbk8LFaw==
Date: Tue, 03 Mar 2026 06:25:24 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: git@amd.com, devicetree@vger.kernel.org, radhey.shyam.pandey@amd.com, 
 Frank.Li@kernel.org, dmaengine@vger.kernel.org, michal.simek@amd.com, 
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 vkoul@kernel.org, linux-arm-kernel@lists.infradead.org
To: Abin Joseph <abin.joseph@amd.com>
In-Reply-To: <20260303114125.899850-1-abin.joseph@amd.com>
References: <20260303114125.899850-1-abin.joseph@amd.com>
Message-Id: <177254072483.2832550.13260823015526158791.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: dma: xlnx,axi-dma: Convert to DT
 schema
X-Rspamd-Queue-Id: 1637A1EF76D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9216-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,devicetree.org:url]
X-Rspamd-Action: no action


On Tue, 03 Mar 2026 17:11:24 +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA.
> No changes to existing binding description.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
> 
> v3:
> -> Update the subject heading
> -> Remove examples for cdma and mcdma
> -> Fix the syntax issue for the clocks
> -> Squash the interrupt use case for axistream
> connected cases.
> -> Reorder the list as per the writing bindings
> 
> v2:
> -> Add examples for each compatible
> -> Remove the note added
> -> Use 'enum' rather than 'anyOf' and 'const'
> -> Wrap 80 char per line for descriptions
> -> Add dma-controller yaml reference
> -> Add -| for paragraph separation
> ->Remove labels from the examples
> 
> ---
>  .../bindings/dma/xilinx/xilinx_dma.txt        | 111 -------
>  .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 301 ++++++++++++++++++
>  2 files changed, 301 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml: allOf:1:then:properties:clock-names: {'items': [{'const': 's_axi_lite_aclk'}, {'const': 'm_axi_mm2s_aclk'}, {'const': 'm_axi_s2mm_aclk'}, {'const': 'm_axis_mm2s_aclk'}, {'const': 's_axis_s2mm_aclk'}], 'minItems': 1, 'maxItems': 5} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml: allOf:3:then:properties:clock-names: {'items': [{'const': 's_axi_lite_aclk'}, {'const': 'm_axi_mm2s_aclk'}, {'const': 'm_axi_s2mm_aclk'}, {'const': 'm_axi_sg_aclk'}], 'minItems': 1, 'maxItems': 4} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260303114125.899850-1-abin.joseph@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


