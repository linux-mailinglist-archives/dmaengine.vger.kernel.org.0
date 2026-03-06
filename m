Return-Path: <dmaengine+bounces-9290-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CpFDvWuqmmLVQEAu9opvQ
	(envelope-from <dmaengine+bounces-9290-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 11:39:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB3121EF74
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 11:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E35183035E02
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2333DEE5;
	Fri,  6 Mar 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="nhT7pXqI"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148A2DAFA2;
	Fri,  6 Mar 2026 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793527; cv=none; b=AB1iGgXrtpJ1YEy2EXft70vb5pqaV+qCchr9/Ao87p3ixCC+zeMllW9fDfSLP5YU5/68uAHdfo4ZLlMCBr6NjwkOFuQorK6bLTVJ2AdBKQvIOvFBqQAn5hQ292ytsryDqtFcu4lR0dydmtQXV5o6PZlglyp8ZBzA0iW+L5V4cV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793527; c=relaxed/simple;
	bh=+KDJnxaYkI4yWmEtLm9V0GHAGLcBaKvn9Oo48gt1u0M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=QMRQo2neutMQYF/p6hiwictGJjKCTolwJgqHdCB9ovuwYOFYfdjijh/hr/tS+An4a/iLB7MYBVslKYRa9elnAm/zqNivW49mtSMd3u5cgJSS/oxjp457gAFo2bjqyA9Yl7LRvghKdruA5u75XHOebqJfygtA7RW8FIVWjW0xHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=nhT7pXqI; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PMeqslybOW2+duB8kifg1EmjsYpVV4hNMJZj7+LPARk=; b=nhT7pXqIwmwxJXg0QLonxKGqUU
	npmPA235Is2wPVPlOIdqFKf5XSWqb5alein90piHyDWJ+Ec1PBLg/ATbUdB8khnPd+dCZtd1vhxir
	SLoLo0bhqWgpwEpMEY5xKqvhhZ8k5aSrRIDSgLJkj1gSInYoUU7EL6ZQWFGW8w3cfx+JArOkoVqwp
	K8Loniurp8W1MPhoe0A7hI/6qzJEV0WqIDuOCwfHu7ksEjI8try4cSXTqrIVN+d5JNLgu+8pvVaK0
	cFxwRxaJ7/dclXct7HlHh2vSAzOdkisBPRzWXS6yiWi08RoI2CYk8c9+FRY+uxRnsE4KGguqpKCEW
	Ak9m6kkw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vySZc-000PyD-18;
	Fri, 06 Mar 2026 11:38:24 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vySZb-000NTP-22;
	Fri, 06 Mar 2026 11:38:23 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 10:38:19 +0000
Message-Id: <DGVMUIOJEVMP.175UQQKV32PR4@folker-schwesinger.de>
Cc: "Rahul Navale" <rahul.navale@ifm.com>, <dmaengine@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
 <suraj.gupta2@amd.com>, <thomas.gessler@brueckmann-gmbh.de>,
 <radhey.shyam.pandey@amd.com>, <tomi.valkeinen@ideasonboard.com>,
 <marex@nabladev.com>, <marex@denx.de>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Rahul Navale" <rahulnavale04@gmail.com>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260305112705.6862-1-rahulnavale04@gmail.com>
In-Reply-To: <20260305112705.6862-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27932/Fri Mar  6 08:24:27 2026)
X-Rspamd-Queue-Id: DCB3121EF74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9290-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu Mar 5, 2026 at 12:27 PM CET, Rahul Navale wrote:
> From: Rahul Navale <rahul.navale@ifm.com>
>
>>Could you confirm that the DMA IP core in your PL design operates in=20
>>scatter Gather mode?
>
> Yes, We confirmed that our DMA IP core in the PL design are configured=20
> for Scatter-Gather mode.

Thanks for confirming, this disproves the last theory. Please undo the
latest Xilinx DMA patch I sent.
To get some more data, could you apply the following patch (keep RFC
patch and debug stuff) and rerun with 7e01511443c3 a) applied and b)
reverted and post logs for both cases:

dmesg|grep ptr_res

<--8<-->
diff --git i/sound/soc/soc-generic-dmaengine-pcm.c w/sound/soc/soc-generic-=
dmaengine-pcm.c
index a63e942fdc0b..4635b199d020 100644
--- i/sound/soc/soc-generic-dmaengine-pcm.c
+++ w/sound/soc/soc-generic-dmaengine-pcm.c
@@ -280,11 +280,16 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 	struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm *pcm =3D soc_component_to_pcm(component);
+	snd_pcm_uframes_t ptr =3D 0;

-	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
-		return snd_dmaengine_pcm_pointer_no_residue(substream);
-	else
-		return snd_dmaengine_pcm_pointer(substream);
+	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE) {
+		ptr =3D snd_dmaengine_pcm_pointer_no_residue(substream);
+		printk("ptr_res_no: ptr =3D 0x%08lx\n", ptr);
+	} else {
+		ptr =3D snd_dmaengine_pcm_pointer(substream);
+		printk("ptr_res: ptr =3D 0x%08lx\n", ptr);
+	}
+	return ptr;
 }

 static int dmaengine_copy(struct snd_soc_component *component,
<-->8-->


