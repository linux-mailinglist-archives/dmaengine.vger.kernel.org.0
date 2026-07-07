Return-Path: <dmaengine+bounces-12085-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CwWHONB+TWqG1AEAu9opvQ
	(envelope-from <dmaengine+bounces-12085-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 00:33:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 709857201C6
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 00:33:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n93krCgB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12085-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12085-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3AD2301A102
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 22:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396723368B6;
	Tue,  7 Jul 2026 22:33:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B344305674;
	Tue,  7 Jul 2026 22:33:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463628; cv=none; b=fYmRu0KlsJ1Y8wj9NXow2YeHd3Mnm/p2pB/RwXbEEx/mEH9SRObsQUpLYM6jAzrnibBGTY8DBgevHRux911AeyZRhaBaf/aC7gq2gj+xNmj/uZiqse5YDJ3O/iJd/Cpd06UgQPcmpZcttFcypi3DbU+Zy84FVET2+9uhtkU91ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463628; c=relaxed/simple;
	bh=A/cPWjlCTqppjiC3r6VqPzErIepco3ZsCNc/8MIetrc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qq9iLoOoJFPIWyyFSZy+n1aXfUPp4qAF+auUvzeEuDPt2moTSwbSeGObrWJCgCzfZ0j/KyxYI3HDC5B4zpNSwgXiD2QWLYDSPmz3TeOs04JHlLnK6KZ3T6Y63q0ux+hzeuf+KJfc65Yt2jEFskOeaT5fekNnKaZuP/PbTIxyzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n93krCgB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890C91F000E9;
	Tue,  7 Jul 2026 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783463626;
	bh=g+LifxB+QsWGTZ7oP/yAFMI7T4DiYAnNEVFq+VdDCEc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=n93krCgB88v/aBiOsZEMyU4ZGcw0wiSNi1Xv0QFB3RBrFyXe1vKRk64g1feEOYRfa
	 F89ZkaAOyJl7k5/BaLTnUbglWyC5vxcFVyYyVUuKJnLGaP9lu28YiPPShltJgbVNAF
	 XTnUeiISDtBtvFueySOyWCXpm/+crf1mJKyfELxVAdTRWMcs9t3QlNo2FcNBY7uez1
	 Pv1pMH7ongRdUdYaPfgm8uE0Fi4zz6oVf621Y/4+H+suAiYhe+KvUWJnO2tuvUfeIc
	 n99MprjDSeHcUxhSlSRewDotmrlptPFEJzdupVyTHuaRQQJn6v5YCOYGuCbr0twc1D
	 q9cvJjJpRU3GA==
Date: Tue, 07 Jul 2026 17:33:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, Frank Li <Frank.Li@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, daniel.baluta@gmail.com, 
 goledhruva@gmail.com, linux-kernel@vger.kernel.org, simona.toaca@nxp.com, 
 m-chawdhry@ti.com, devicetree@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
In-Reply-To: <20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com>
References: <20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com>
Message-Id: <178346362587.299900.10175616533527803058.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: ti,dma-crossbar: Convert to DT
 schema
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vigneshr@ti.com,m:conor+dt@kernel.org,m:krzk+dt@kernel.org,m:peter.ujfalusi@gmail.com,m:daniel.baluta@gmail.com,m:goledhruva@gmail.com,m:linux-kernel@vger.kernel.org,m:simona.toaca@nxp.com,m:m-chawdhry@ti.com,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:j.bhargav.u@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:peterujfalusi@gmail.com,m:danielbaluta@gmail.com,m:jbhargavu@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12085-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,ti.com,gmail.com,nxp.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 709857201C6


On Wed, 08 Jul 2026 02:59:01 +0530, Bhargav Joshi wrote:
> Convert Texas Instruments DMA Crossbar from text to DT schema
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../bindings/dma/ti,dra7-dma-crossbar.yaml         | 105 +++++++++++++++++++++
>  .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  68 -------------
>  2 files changed, 105 insertions(+), 68 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.example.dtb: /example-0/dma-controller@4a056000: failed to match any schema with compatible: ['ti,omap4430-sdma']

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
MAINTAINERS: Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


