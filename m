Return-Path: <dmaengine+bounces-12102-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AbO6FdrgTWrt/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12102-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:32:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E1721D07
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:32:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ee8ZL9+N;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12102-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12102-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E0C930069B0
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF4378D72;
	Wed,  8 Jul 2026 05:32:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C4298CA3;
	Wed,  8 Jul 2026 05:32:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488723; cv=none; b=VkZO7pH8SrOVD4oqi1zoaVGALHuhO+Z/aKPRcHg0BRuoTheU459/FHrnRtig+t1v8p0DEkcOTCdfps+vHDtY9rxZAEP+A2NREp/2+6bhIF+D5Ya2+VkfDPlCfUMjzFJXqknFnVul6Z4IfYVn449YPuApqi0p5EXgXqkCZBfOQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488723; c=relaxed/simple;
	bh=suCyaLNtkSkSj+wPF8kJXv2b1PBa0LEYs4oXRtgZuMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgMbb51eImSdk4zja5HPjo+0z7g/NDOgNzUg4B9eVXOPmvlEe3JuZCpht7lV+eZazQkXB8IIYBU/Ol1OilXSUv/S4t0ic/3lrO2hHZ1xzBx891Nf1zZ3vP8XOsD8VGDRQ62/lpSvli49/dIcH/6RpeeDa1BlKjnPv7J54eNT8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee8ZL9+N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAF41F000E9;
	Wed,  8 Jul 2026 05:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783488721;
	bh=HmHng1EUvQQbmmsFZMPVlT46VgCksNt2K4J1gg9ZxeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ee8ZL9+N6dfuqqGQgUXcMz1Et52GVsoAL/+kSlqTw/MmgLFob/wdteUsQFoD6Bcha
	 kg1R4VfWOe9l7J+SiFQslhqQpEv3z2l/NdbdZVafGGkGoT0on10ER58HufwB6dFOrQ
	 jNU7azyWRI0EWcATBMZmrm/KLqAFEtUVRNH2OKnTXO0IolhU7oJhM2RrRM0BFvkJXu
	 9Mpg7vWtLXxR7ucHCsgzFjYyAU4K8VYDE3Rn11dn0GFQPlwpQZGNhAGH63jt0NGqPY
	 pttgOc7C7pxw2zEDRM3RUTVOTfuSF4wMOPBw6sMYz1LM2W70ltXs0gSuDAsacp8ixz
	 gnKuGlMrTP29w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for
 multi-owner I2C transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh Kumar Savaliya" <mukesh.savaliya@oss.qualcomm.com>
Cc: vkoul@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 05:32:00 +0000
Message-Id: <20260708053201.3FAF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12102-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mukesh.savaliya@oss.qualcomm.com,m:vkoul@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,qualcomm.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 546E1721D07

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Setting TRE_FLAGS_IEOB on Lock/Unlock TREs causes multiple com=
pletion events per descriptor, corrupting the vchan queue.
- [High] Dangling CHAIN flag on the final DMA TRE for I2C Read transfers.
- [High] Asymmetric Lock/Unlock TRE generation causes the RX channel to per=
manently lock.
- [High] Insufficient DMA transfer ring space check leads to partial TRE en=
queue and hardware lockup.
- [High] Missing CHAIN bit on GO TRE before Unlock TRE.
--

--- Patch [2]: [PATCH v8 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs fo=
r multi-owner I2C transfers ---
commit cc47faf2611d1c6105d08f28b502e364ce9bde15
Author: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: dmaengine: qcom: gpi: Add lock/unlock TREs for multi-owner I2C tra=
nsfers

This commit adds support for emitting GPI hardware lock and unlock TREs to
serialize access to a shared QUP-based I2C controller. It simplifies the
client interface with a lock_action selector and increases the maximum TRE
count to accommodate the newly added elements.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af6..1e70d2adfdff0 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -518,7 +527,7 @@ struct gpii {
>  	bool ieob_set;
>  };
> =20
> -#define MAX_TRE 3
> +#define MAX_TRE 5
> =20
>  struct gpi_desc {
>  	struct virt_dma_desc vd;

[Severity: High]
Since the maximum number of TREs has increased, does gpi_prep_slave_sg()
also need to be updated to account for the new elements?

It appears gpi_prep_slave_sg() still hardcodes the maximum required TRE
slots to 3:

gpi_prep_slave_sg() {
        ...
        nr_tre =3D 3;
        ...
        nr =3D gpi_ring_num_elements_avail(ch_ring);
        if (nr < nr_tre) {
        ...
}

If the ring only has 3 slots available but 5 TREs are generated, could this
cause gpi_queue_xfer() to silently drop the extra TREs and dispatch a
truncated chain to the hardware?

> [ ... ]
> @@ -1625,12 +1634,27 @@ static int gpi_create_i2c_tre(struct gchan *chan,=
 struct gpi_desc *desc,
>  			      unsigned long flags)
>  {
>  	struct gpi_i2c_config *i2c =3D chan->config;
> +	enum gpi_lock_action lock_action =3D i2c->lock_action;
>  	struct device *dev =3D chan->gpii->gpi_dev->dev;
>  	unsigned int tre_idx =3D 0;
>  	dma_addr_t address;
>  	struct gpi_tre *tre;
>  	unsigned int i;
> =20
> +	/* Optional lock TRE before transfer */
> +	if (lock_action =3D=3D GPI_LOCK_ACQUIRE) {
> +		tre =3D &desc->tre[tre_idx];
> +		tre_idx++;
> +
> +		tre->dword[0] =3D 0;
> +		tre->dword[1] =3D 0;
> +		tre->dword[2] =3D 0;
> +		tre->dword[3] =3D u32_encode_bits(1, TRE_LOCK);
> +		tre->dword[3] |=3D u32_encode_bits(1, TRE_FLAGS_IEOB);

[Severity: Critical]
Could setting the Interrupt on End of Block (IEOB) flag here on the LOCK
TRE cause multiple completion events to fire for a single descriptor?

The DMA TRE also sets the IEOT flag later in this function. If both events
are generated, gpi_process_xfer_compl_event() might call vchan_next_desc()
multiple times, popping unrelated descriptors from the queue and potentially
causing premature completions or use-after-free conditions.

[Severity: High]
Will this logic cause the RX channel to acquire a lock that it never
releases?

For an I2C read transfer, lock_action =3D=3D GPI_LOCK_ACQUIRE unconditional=
ly
appends a LOCK TRE to the descriptor for both the TX and RX channels.
However, the logic later in this function explicitly suppresses the UNLOCK
TRE when i2c->op !=3D I2C_READ. Is it possible the RX channel sequencer gets
permanently locked this way?

> +		tre->dword[3] |=3D u32_encode_bits(0, TRE_MINOR_TYPE);
> +		tre->dword[3] |=3D u32_encode_bits(3, TRE_MAJOR_TYPE);
> +	}
> +
> [ ... ]
> @@ -1690,6 +1714,24 @@ static int gpi_create_i2c_tre(struct gchan *chan, =
struct gpi_desc *desc,
> =20
>  		if (!(flags & DMA_PREP_INTERRUPT))
>  			tre->dword[3] |=3D u32_encode_bits(1, TRE_FLAGS_BEI);
> +
> +		/* If multi-owner and this is the release boundary, chain it */
> +		if (i2c->lock_action =3D=3D GPI_LOCK_RELEASE)
> +			tre->dword[3] |=3D u32_encode_bits(1, TRE_FLAGS_CHAIN);
> +	}
> +
> +	/* Optional unlock TRE after transfer */
> +	if (lock_action =3D=3D GPI_LOCK_RELEASE && i2c->op !=3D I2C_READ) {
> +		tre =3D &desc->tre[tre_idx];
> +		tre_idx++;

[Severity: High]
Can this sequence leave a dangling CHAIN flag on the final DMA TRE?

When preparing an I2C read transfer with GPI_LOCK_RELEASE, the DMA block
unconditionally sets the CHAIN flag on the DMA TRE. However, the UNLOCK TRE
is explicitly skipped here because of the (i2c->op !=3D I2C_READ) condition.

Could this cause the hardware DMA sequencer to fetch an out-of-bounds or
stale TRE since it expects another descriptor to follow?

[Severity: High]
When configuring the TX channel for a multi-message read transfer, does
the GO TRE need the CHAIN bit instead of the LINK bit if an UNLOCK TRE
is going to follow it?

If multi_msg is true, earlier code in gpi_create_i2c_tre() sets
TRE_FLAGS_LINK on the GO TRE. Since the DMA TRE is skipped for TX channels
during reads, the next TRE appended will be this UNLOCK TRE. Without the
CHAIN bit on the GO TRE, might the hardware sequencer halt before processing
the UNLOCK TRE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708051023.2872=
304-1-mukesh.savaliya@oss.qualcomm.com?part=3D2

