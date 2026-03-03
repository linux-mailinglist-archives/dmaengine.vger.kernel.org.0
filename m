Return-Path: <dmaengine+bounces-9223-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHPNER5Ap2kNgAAAu9opvQ
	(envelope-from <dmaengine+bounces-9223-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 21:10:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A901F6A3A
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 21:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51D93302CB3C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9806370D67;
	Tue,  3 Mar 2026 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="CILbhsme"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C073537E7;
	Tue,  3 Mar 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568602; cv=none; b=ahLS8VZhDOc5Mki7i06s/XqpdO/bRt62ctnnYj0R8o1CXXcYeU9Nwh7W5NzOx84EQLent84achhEv/zjWWUNjKwAVK5xXfGuQ0nvj+02I9Xx063BWsYq7/1ouuhVEDKYiTFJ4q9GJm44rHENr+jfauNkTDtJwMXx7Pe3CA3BZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568602; c=relaxed/simple;
	bh=kiy9EK6I7sLRV/XGZuMPMLkA2NId8iErItKdLFoKoLA=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:Mime-Version:
	 References:In-Reply-To; b=BZR+3pB2SDkfSyY0HE8UNuOuC1i0dtIFqUwEkQBl5feAFP/CrKM60OQQF0ZvtJ8O8YSn6gEi0YUU2PCYfxzRUq2WLkRaQ6OaD1o1RprNgkpm9gG5brQTrcxbhmK1nmE2UY0km1d76baEb3+WsP/XldMn9PV01x4WRtnyAK3OlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=CILbhsme; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:
	Content-Transfer-Encoding:Mime-Version:Cc:Subject:To:From:Message-Id:Date:
	Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MnOXMsr1fKvJfoafP+MS2vYMgdNG+pMu/17zAvxaCpw=; b=CILbhsmeqwjJEoq8Q7ud+gNqVv
	uQVBjs0cGHsIjDTowq18EWbXz/YG/e//te/WwiHgxO16dURU1y9UR0fxT7jVArub9DaMTjO1Ed8vU
	XVOOT4kvNxtqRDoVOiXpAu8P2C+BYqD+/LyDH6TLVhBj7EdLc2Pc8s+yzdp2Itq2IqzOFy5oF9R/P
	pzHiR8fr3nbTE3vEbWMDtvZu/Aw7Jykylpgfsd/whQz7z/1rGkf/CjZRlGbPO8Uoz6speGQetaMBN
	YhRTEXsXHfJRspo28UHnllVOHup6/eRJ3ftufu7PgIeMprDrqVImVLeJzqDPYEwfKGFYg9Ikmq5ie
	QcjXobig==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vxW3p-0003Vp-1y;
	Tue, 03 Mar 2026 21:09:41 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vxW3o-000JEC-2E;
	Tue, 03 Mar 2026 21:09:40 +0100
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 20:09:37 +0000
Message-Id: <DGTF4AVSQZBJ.184UEIYAHWGMW@folker-schwesinger.de>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Rahul Navale" <rahulnavale04@gmail.com>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
Cc: "Rahul Navale" <rahul.navale@ifm.com>, <dmaengine@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
 <suraj.gupta2@amd.com>, <thomas.gessler@brueckmann-gmbh.de>,
 <radhey.shyam.pandey@amd.com>, <tomi.valkeinen@ideasonboard.com>,
 <marex@nabladev.com>, <marex@denx.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260302072433.5091-1-rahulnavale04@gmail.com>
In-Reply-To: <20260302072433.5091-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27929/Tue Mar  3 08:24:19 2026)
X-Rspamd-Queue-Id: E2A901F6A3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9223-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon Mar 2, 2026 at 8:24 AM CET, Rahul Navale wrote:
>
> DT for the audio AXI DMA is below. We indeed have two distinct
> AXI DMA devices, each instantiated with a single fixed-direction channel:
>
>   axi_dma0: MM2S-only (playback / DMA_MEM_TO_DEV)
>   axi_dma1: S2MM-only (capture  / DMA_DEV_TO_MEM)

No surprises here, good.

> Debug results with your RFC patch kept, but 7e01511443c3 reverted:
> - Audio playback works (aplay plays normally)
> - No xilinx_dma_device_caps printk output at all:
> # dmesg | grep xilinx_dma_device_caps
> <no output>

From that observation we can conclude that in your good case
dma_get_slave_caps() returns early with -ENXIO [1] while in your bad
case it runs entirely returning 0.

So I think it's reasonable to assume that either (1) the change in
return value of dma_get_slave_caps() causes different behaviour in the
callers (possibly [2][3]; needs verification) or that (2) dma_slave_caps
*caps, whose fields now get populated in dma_get_slave_caps() cause
different behavior in downstream users of said caps.

For the next debugging step I suggest that we focus on (2) but also on
getting some insight into the callers. Could you please reapply
7e01511443c3, keep the RFC patch in place and additionally apply the
below patch?=20

This will exercise your bad case, print the differences for caps, and
also print the call stacks for all calls to dma_get_slave_caps().

Then, please extract & post the relevant dmesg logs.

<-->8-->

diff --git i/drivers/dma/dmaengine.c w/drivers/dma/dmaengine.c
index ca13cd39330b..710da870b8e9 100644
--- i/drivers/dma/dmaengine.c
+++ w/drivers/dma/dmaengine.c
@@ -570,6 +570,27 @@ void dma_issue_pending_all(void)
 }
 EXPORT_SYMBOL(dma_issue_pending_all);

+static void dma_slave_caps_printk(const struct dma_slave_caps *caps)
+{
+   if (!caps) {
+       printk("dma_slave_caps: (nil)\n");
+       return;
+   }
+
+   printk("dma_slave_caps:\n");
+   printk("  src_addr_widths    =3D 0x%08x\n", caps->src_addr_widths);
+   printk("  dst_addr_widths    =3D 0x%08x\n", caps->dst_addr_widths);
+   printk("  directions         =3D 0x%08x\n", caps->directions);
+   printk("  min_burst          =3D 0x%08x\n", caps->min_burst);
+   printk("  max_burst          =3D 0x%08x\n", caps->max_burst);
+   printk("  max_sg_burst       =3D 0x%08x\n", caps->max_sg_burst);
+   printk("  cmd_pause          =3D 0x%02x\n", (u8)caps->cmd_pause);
+   printk("  cmd_resume         =3D 0x%02x\n", (u8)caps->cmd_resume);
+   printk("  cmd_terminate      =3D 0x%02x\n", (u8)caps->cmd_terminate);
+   printk("  residue_granularity=3D 0x%08x\n", (u32)caps->residue_granular=
ity);
+   printk("  descriptor_reuse   =3D 0x%02x\n", (u8)caps->descriptor_reuse)=
;
+}
+
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 {
    struct dma_device *device;
@@ -584,6 +605,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dm=
a_slave_caps *caps)
          test_bit(DMA_CYCLIC, device->cap_mask.bits)))
        return -ENXIO;

+   dma_slave_caps_printk(caps);
+
    /*
     * Check whether it reports it uses the generic slave
     * capabilities, if not, that means it doesn't support any
@@ -614,6 +637,11 @@ int dma_get_slave_caps(struct dma_chan *chan, struct d=
ma_slave_caps *caps)
    if (device->device_caps)
        device->device_caps(chan, caps);

+   dma_slave_caps_printk(caps);
+   printk("<stack>\n");
+   dump_stack();
+   printk("</stack>\n");
+
    return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);

<--8<-->

[1]: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/dma/dmaengine.=
c#L593
[2]: https://elixir.bootlin.com/linux/v6.19.3/source/sound/core/pcm_dmaengi=
ne.c#L421
[3]: https://elixir.bootlin.com/linux/v6.19.3/source/sound/soc/soc-generic-=
dmaengine-pcm.c#L206

