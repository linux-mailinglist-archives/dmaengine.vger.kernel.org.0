Return-Path: <dmaengine+bounces-10863-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IpDFc4rFGraKQcAu9opvQ
	(envelope-from <dmaengine+bounces-10863-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:00:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96115C98B1
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629C93013878
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF13537CE;
	Mon, 25 May 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/if9Mq8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71ED305664;
	Mon, 25 May 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706827; cv=none; b=trpea7UGtk8gi7AtvKjSgs2Vn8sIw0j2ycWukaoB7+VksaXviuWmFD8ULoPeWa8iN/A9DcM4C425uXaS1YQXsDZ8oHGqGOOAmC8MIXPO6MCuCX7dN8HxxjiOWh8Q6sDLoR5YWbnE7t7Mq7fDJsblrm6SFPemdFP9YHf636/+mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706827; c=relaxed/simple;
	bh=9fO42m13Y+bTIv6JtDGor1y/+un63WzVmdLOttikl8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W+r19jCNn4eD/IAteBiSu+jCeUUVh9P1OsBoS+q77VDOUg0Y1NcIWobucfG8wlpgxQesB3Y0htfh4cyXPQORdMYs61O3AE/Sc5W2hAj6HDgug9KXUZSLlNdScVMgCSFB+fKcXu/A6hpyKf+1gWH08cbAnGSjNTHz2AdTDlaPPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/if9Mq8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A6A1F00A3A;
	Mon, 25 May 2026 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779706826;
	bh=57r+jJp3UJIEesFoQJ1jmjc92WpqOyR0vcVIjhhpBnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n/if9Mq8Tu0wMHHjNCgmRTZB6IGg7DDShROE6yGtdZwIe1NkNExnkpxo7uMj6IpVN
	 mAGw5PLAaK+w/OKFfM0oDYb5RFhpNox4XlAhBrE8SU/5CMK1aeNgGAOYYtOGv5a/Sr
	 7m/SKiMKeSKAyQKUG1MxewsGYDj05maxc3CRdXrYPX2tDjIPuY73tgzGGM7Ia0U2ir
	 6nhlzoSkcANTR4Wsm2zTtego3pZfmzWOCwwg3AYO8D/m1tXOq09of/Yg55e2PwkLof
	 4F5thXcokqUKTu/reSFNifW6dLcbYgj8aW5tlRUJoswpbAHhqxmirBToUa7NRQGK0R
	 UBEvJnOA7stag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets
 property for ZDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Golla Nagendra" <nagendra.golla@amd.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org, robh@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260525105042.2249542-2-nagendra.golla@amd.com>
References: <20260525105042.2249542-2-nagendra.golla@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 11:00:25 +0000
Message-Id: <20260525110025.E5A6A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10863-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: B96115C98B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `resets` property is added globally without conditional cons=
traints, allowing it to pass validation on older SoCs that do not support i=
t in hardware.
--

commit 832c482914e7639cb1a410d061bf9d631b41ae68
Author: Jay Buddhabhatti <jay.buddhabhatti@amd.com>

dt-bindings: dma: xilinx: Add optional resets property for ZDMA

This commit adds an optional resets property for ZDMA on newer SoCs like
Versal Gen2 and Versal-Net. Older SoCs do not have a reset line provision.

> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma=
-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.=
0.yaml
> index 2da86037ad79e..dff16763e11b9 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.ya=
ml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.ya=
ml
> @@ -56,6 +56,9 @@ properties:
>    iommus:
>      maxItems: 1
> =20
> +  resets:
> +    maxItems: 1
> +

[Severity: Medium]
The commit message notes that older SoCs do not support this reset line.
Since the resets property is added to the top-level properties block, will
this allow device trees for older hardware to erroneously define a reset li=
ne
and silently pass validation?

Should this be guarded by an allOf conditional block restricting the resets
property to the newer hardware compatible strings?

>    power-domains:
>      maxItems: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525105042.2249=
542-1-nagendra.golla@amd.com?part=3D1

