Return-Path: <dmaengine+bounces-10561-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDrTF5qgDGq8jwUAu9opvQ
	(envelope-from <dmaengine+bounces-10561-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:40:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD3058337F
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A40300B454
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB87034389B;
	Tue, 19 May 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBpq7XtV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B9343881;
	Tue, 19 May 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212439; cv=none; b=e1n1venWHh1NxWm2L3AvCbTC/RAVwJ5xRGRYVi1XfJIGGMA0pS/Q9po3hWxt+fi4Rkp7bETpWvc3sJDfowndCpnXxVPAm4w6Yuabwff4TGBK+bR0ZpSwt6kAaIepjf+qxdUXXDONUe9Yxsk+LHOIDPu6uPRVcXX0CWPXpiOsQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212439; c=relaxed/simple;
	bh=ARAUPA1AYI+OwnVMt2qhFJL2b62SmwNauKS4UyfqLr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WOmWEow1JLfp6C2NiX7q5oxL11NVsRrIThEZUpffjHOWUlPioqHt9TolY1MlxXwQ+F4+ZZijBCOOwlu3yw/XMc4QhPvDJW9GtG0yFzQTGfzVTdyK+3PrqpgQ+kabdaq+qZNrFeba9pnzZwSRQ/+P4Ae3kfgOEhmTDfkAKUS3rps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBpq7XtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBC1C2BCB3;
	Tue, 19 May 2026 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212439;
	bh=ARAUPA1AYI+OwnVMt2qhFJL2b62SmwNauKS4UyfqLr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aBpq7XtVeMTFogYD5FUTLCV2lbhU9guBM7lP2/6nFe5EElxVWi94GDJz7JNF4sGDy
	 5X3dle6STma/1L/QrktJJxEFs0TKMfdnuEXszoIKu4YetaGStR/8VTjOHbc1nsS4kj
	 PjGfdmJ4vtC1RQb8kQeY/jGSDsnC9Wu9NoSjzp94fCfR+x+o36LtJv8A18dgIAVjiZ
	 9IqMA7gTaXKlIB5tDgBrQXWVG5R8PPaCWd3X2pFUV6noBmXgSUf8/yy77gLcpKaEe5
	 NvlUpZ1bnZw4bu11zI0jw1Ju+yiLI9C31hoB7SCY0A3F7dX16LxtNsrnTnjrFehthW
	 xLMZTAibbx7MQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>, 
 Arun Neelakantam <aneelaka@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/3] Add support for qcrypto in kaanapali
Message-Id: <177921243425.339411.752990764749090242.b4-ty@kernel.org>
Date: Tue, 19 May 2026 23:10:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10561-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BBD3058337F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


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

[1/3] dt-bindings: dma: qcom,bam-dma: Document BAM v2.0.0 compatible
      commit: dfd9538e78f57705e6c656d3ff5660ae7137789c
[2/3] dmaengine: qcom: bam_dma: Add support for BAM v2.0.0
      commit: 3331fc194b129582fa21cb3a7e5cc68aaac1081f

Best regards,
-- 
~Vinod



