Return-Path: <dmaengine+bounces-10440-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEVJKl7dBGoMQAIAu9opvQ
	(envelope-from <dmaengine+bounces-10440-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:21:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFAA53A700
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2977A300D473
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D753AC0CB;
	Wed, 13 May 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWZXrEpO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D330F7F7;
	Wed, 13 May 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703676; cv=none; b=pVJsT0md80tSV9hql+lQcQcdovUqhrr4GCtQqcccyXyz2Z1aSIjtXHNGqzyOYteiwmXbZUHRZoPdrx1FVaGFeBoHrC2rrK2AsmVAQIR5CsQTBjkYlfcvZj5DCA4HZytlSkwLvx7CGAJBJkFO9KjIVLb38Gj6EZqf5DUWbWTYdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703676; c=relaxed/simple;
	bh=tdRb6uTF26YxJafhOlxG2RkhZSnSyrlLFAf4EcUzkcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QhukJAmvInU/5rbDsp/n04wO4XEQ54JggrHJTpVqFMemdXJcpWdwjXYG+i04B+qjSzR8cNUFuXzw22t9PmY7x7w5gXr2oqlVpy73EQgv40fYmzWc3ijXiIRNO8sRqwNP+1koxcNOvsGibKu9XFpDM3L+b32fim9RfSIqc4Eonmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWZXrEpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B748AC19425;
	Wed, 13 May 2026 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778703676;
	bh=tdRb6uTF26YxJafhOlxG2RkhZSnSyrlLFAf4EcUzkcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aWZXrEpO+kmajpTnUTyUMRgurh4imzjJW8Ny/s2noG9yHQA4zQGPs3+sTusFeKCNV
	 HOW7TrbzaYFqXZphoG0uznTjp0o+z8yVIlzd+0tDX2e9SOP6/sCp5RJ37wWDJ4hmXA
	 qlCV9RDV0vFrqO0tecuX+8Zsu/4yROQ9gKg2oeMPbuhRQFI+kbWNGhnJmGiJGNvUVk
	 rG19GKfAOf2MsdvP6VNcL8ol+GQpEduom4sUsqQ1STDY+HeWHpEUpQxItW30sBuV6C
	 3RI05/loxLedndcFVcLh5U4g7lJ+ov9A0juL53s6W32QhLyVngJrmBnWEu1aYn4fPG
	 3N3sdd928Cy6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/23] dmaengine: sdxi: Generic descriptor
 manipulation helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-16-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-16-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:21:14 +0000
Message-Id: <20260513202115.B748AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0FFAA53A700
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10440-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Data race and TOCTOU race in descriptor ownership validation defea=
ts the safety check.
- [Medium] Severe performance degradation due to Read-Modify-Write (RMW) on=
 Write-Combining (WC) DMA memory.
--

commit 54eb4223ce2b3ad6354bf153f2d7fc8aa53474e0
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Generic descriptor manipulation helpers

Introduce small helper functions for manipulating certain common properties
of descriptors after their operation-specific encoding has been performed b=
ut
before they are submitted.

> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> new file mode 100644
> index 0000000000000..c0f01b1be726d
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor.h
[ ... ]
> +static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, boo=
l expected)
> +{
> +	u8 vl =3D FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
> +
> +	WARN_RATELIMIT(vl !=3D expected, "expected vl=3D%u but got %u\n", expec=
ted, vl);
> +}

The descriptor ring is often mapped as DMA coherent memory, which on many
architectures is Write-Combining or uncached. Does reading desc->opcode
here and in the calling functions trigger synchronous, non-posted PCIe read=
s?

If these helpers are called directly on the DMA ring, this read-modify-write
pattern might cause multiple PCIe reads per descriptor and artificially cap
the DMA engine's throughput. Is there a way to redesign the API to avoid
reading from the ring, perhaps by returning the modified opcode or passing
it as state?

[ ... ]

> +static inline void sdxi_desc_set_fence(struct sdxi_desc *desc)
> +{
> +	u32 opcode =3D le32_to_cpu(desc->opcode);
> +
> +	sdxi_desc_vl_expect(desc, 0);

Can this double-read sequence lead to a time-of-check to time-of-use race?

If the driver erroneously calls this helper on an active descriptor (vl=3D1=
),
the first read of desc->opcode into the local opcode variable fetches vl=3D=
1.
If the hardware then completes the operation and writes vl=3D0 to desc->opc=
ode
in memory, the second read inside sdxi_desc_vl_expect() fetches vl=3D0.

The validation check would then succeed, bypassing the WARN_RATELIMIT safety
net. The helper then writes back the stale local opcode (which still has
vl=3D1) to memory, silently re-submitting the completed descriptor.

Could desc->opcode be read exactly once using READ_ONCE(), and that local
value passed into sdxi_desc_vl_expect() to avoid this race?

> +	FIELD_MODIFY(SDXI_DSC_FE, &opcode, 1);
> +	desc->opcode =3D cpu_to_le32(opcode);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D16

