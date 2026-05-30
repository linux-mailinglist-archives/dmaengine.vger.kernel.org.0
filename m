Return-Path: <dmaengine+bounces-11042-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLJLCvxSGmpE3AgAu9opvQ
	(envelope-from <dmaengine+bounces-11042-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 05:01:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311060B045
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 05:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5C39301FD7C
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 03:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F29221540;
	Sat, 30 May 2026 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbJv/1BT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21C175A66
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110071; cv=pass; b=WDw8IbJmmaTMrbK/e2LON5CkTXbAYEuJAozi+d1SfCM7PtfBJvqdZoAgm8sNdGsLsQK5JP5G7jIS2FOn9Qyo39hmSrIvsCaoEiF113Kp7+Ep1Yz3Ci29+ur8buAOVV80nR7CPslAZ5xwHKotYrOeDwzKy9d2JRGcOvM04fwlrY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110071; c=relaxed/simple;
	bh=0/Fe2qVwaVDAS/yawKEtBBGMo9kRrZCxGn3LskzENWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9u6LzzVEGa8RPJkDi4CGs6UjIAIxw/7Oxhzy8XbbXFf6a/OBK3TFc49cvh3fM/E4MjfQGuJhVoaZRxPPQ5eWAyMIXJMwCesG37VCS9oAZaB0Yw76D2HAZNV+OSZNTIGK/bt3k4Y8Krd+UEc+FS2aCuvGqrEFj0cLez+woaKShA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbJv/1BT; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso22508624a12.1
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 20:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780110068; cv=none;
        d=google.com; s=arc-20240605;
        b=dMU7XMKxkvRGv86EaEh8QIil/KrhTWlwCn3VxwgfCxFYOG8QLFYI/FqxvnXooGXw2h
         Mxed6opYgRQWvVrEtBUTZ9aB8QN70wxk8z1yzW+PHIZdutnthZFrgSbPKogZ16cffIX8
         ya6JBzobIn0Fsz5Hva5q6uD/tZPMYmu9l198N22ybZ2JJ12a4ip2LgW/Cd1SRQ08nt1V
         dY2OskQvMoVZwfYiRJZ/J3+7Fr3RFKNDVfDwXcP5nfOwMpdaJnbwfthLVhq7p3Nj9IXd
         5bkVmSpHkLFoWgi9klicXi6KctSG9sM/1JLSu/8f17hUfnLyFz412iZSmOy/WXNX2xB0
         lJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNik6uGAIKHeAdY2s59qweB5n544vrvz8Tr1bg759no=;
        fh=uxg1DeTlxIcX7SJmPf4a6bXzgnn12tX7jZn0ymPupr4=;
        b=bQz400hdWZMu/juQXDo+yqVSpmyX+D1WOHcZ7N2Xw5R7fGTLk6kJthY7jSbnUIGeId
         AmEH29YvE3Fvzxh5LzG86gixMt6Nit46PzcYdGgLIL+CcnVRH06AzHbyoI/RbbAF2mVD
         GKGAmdE+Yu5DqTIr3NPCvsD+OKIDAtd33T5DNrPs+ER0j2je0dP6Ei9plcy2IFZCZo+r
         5FU2wJynUBRrUnH9kmi7YXyY+t6lYyp3UcSHt9FLI/WU7jkUhsjcVnvccohefQd0IMzN
         Gzn/hExBT7dUAo7+B+rgbeS66Yz8dDWDbksDRf0IAugcfLKPzSddz216b1el87GGnF/B
         +gUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780110068; x=1780714868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNik6uGAIKHeAdY2s59qweB5n544vrvz8Tr1bg759no=;
        b=gbJv/1BTyMQaGTo6KDvnZi9K0g7ZFuwwZ9rF59DFHx2ShLiJo7ZhBbyio5smRaD0Qv
         w9FRhobqDuoimOl7+wY+vmVqKAsWVu1Ib9oG7Q04IccuyqvHS2XeNLHIZMU9fVoRuxee
         7sY7IpEl8ZQjSmKAj4OYaD2BFB5e07Abpz7UVe+EOgVnAjqAMcmq3qc7g4X0KsuRe4Fe
         e86m22rh8TEHgmTTfaMDusDfE5A0yfh5jGrXrvFRrey9+w1b0D6Ar3ci7jlThOtCOTd1
         ozL/xHa/ZjnP533WQsn4qr9a/jDM5vNaem9phHMA8DMhvFCtE8/4t5w5k38Gy8SlmCDB
         gjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780110068; x=1780714868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNik6uGAIKHeAdY2s59qweB5n544vrvz8Tr1bg759no=;
        b=JVIHuAxIpTcm2d9jBHhJbfL6ocLc5P0OyobQjKwLN0EIbDQ7/LbCrtTTCE2DmplnQH
         AfwUyV1BDE92UAKBv9u0LVrqhLEDdi6cZhhh42VLTXxBYlqaZCcPPI+JwlGf4MaFjUNn
         ky8s1o1eNQmqDH+lTmh/YflB/wB1KMSZM1eDXe3ra1TzKjZWpw7Pr82fRUDK1O8M3Mkt
         jsynWhTgaJBolGT5tP/f9yoR8Hz8j1pQbgNXsB9bPGz52l+QQ54C/BG4a+FroysVLUoj
         4jRbC8xmuJ+mCNsOlAQXXVmBExlkmEd6q1Ewg2rAFNGFoy2xUsXePXZJjjPYQJNMCD8x
         TJgw==
X-Gm-Message-State: AOJu0YzZskOfQdQSa4ywphFQDy5cCDd3htiIwtWUeyMn7AeTfe1ujLEF
	iWebMtOT4rU+xzcJq9XdFLK3cW6KVvG+oqjwXM0Dke10JjEqFhXN/eUBZvHzh7oPpapC0o4cgZV
	QUMf9+tyGeBLh4sv8x4uiWHmj32XPwW2akgjK
X-Gm-Gg: Acq92OEacpK0NSPONa9nfh3dll3G2Sq82FcGcsi17oxC2FF1CgQwVkFzWdveIyplVDa
	j01RhkXICeRc776tRMbZ0BvzM4MQdK0SP1UBUDHEk6o+DKy0UFqNN4RraFLXHkXj0PbWIZKotJR
	6yGKgMFRd0tFkmDV+mb9HfPcktMDGWhPMhLFLLUvAsTdms1gDYpClTLo44wrP0AziKhKX4GvMMs
	vdk3n0ySdVKOqKoROewXxc/RcxHc5tPT7n8AMBthlZgzEisPk7r09uMHuk3d7bUpGs+zKr+3jgk
	char8k+G6mbA0ErMblQ9eJdkboT9HMFCyyg2gSjW2lo7apfg4R1m10/GpKLEoyUS1jFpZV8LYpO
	ntGqg8ABThE4g8Aof2Pdg67aMkhy0Xn6ErUIyvYoih2DX3CPAMBTthzZmEbrK1tWh5c69
X-Received: by 2002:a50:8dc6:0:b0:683:5589:4317 with SMTP id
 4fb4d7f45d1cf-68c8ac28472mr904246a12.11.1780110067674; Fri, 29 May 2026
 20:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530012554.68605-1-rosenp@gmail.com> <20260530021906.99C2B1F00893@smtp.kernel.org>
In-Reply-To: <20260530021906.99C2B1F00893@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 29 May 2026 20:00:56 -0700
X-Gm-Features: AVHnY4JNVns_ZxjiSOnWuc4Z-pDuYeBnG71JcGa9-SbbhXeIRhWVpkBkr3kz80s
Message-ID: <CAKxU2N_vB9sTyY4dfeA=3TcJcRzskBA=ZcZ1fkP4tE_LQRFC9g@mail.gmail.com>
Subject: Re: [PATCHv2] dma: bestcomm: gen_bd: split struct bcom_psc_params
 from array definition
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11042-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 9311060B045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 7:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Inadequate or missing bounds checking on `psc_num` can lead to o=
ut-of-bounds array access in `bcom_psc_params`.
> --
>
> commit c24864efcf21b2526be68d727e70076f6cee258c
> Author: Rosen Penev <rosenp@gmail.com>
>
> dma: bestcomm: gen_bd: split struct bcom_psc_params from array definition
>
> This commit splits the bcom_psc_params struct definition from its array
> declaration to resolve kernel-doc parser warnings. It also adds missing
> members and marks the lookup table as const so it can be moved to read
> only memory.
>
> > diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_b=
d.c
> > index 8a24a5cbc2633..61b5746e1a972 100644
> > --- a/drivers/dma/bestcomm/gen_bd.c
> > +++ b/drivers/dma/bestcomm/gen_bd.c
> > @@ -254,17 +254,23 @@ EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
>
> [ ... ]
>
> > -static struct bcom_psc_params {
> > +struct bcom_psc_params {
> >       int rx_initiator;
> >       int rx_ipr;
> >       int tx_initiator;
> >       int tx_ipr;
> > -} bcom_psc_params[] =3D {
> > +};
> > +
> > +static const struct bcom_psc_params bcom_psc_params[] =3D {
>
> [Severity: High]
> This is a pre-existing issue, but does this fixed-size array expose an
> out-of-bounds access?
>
> The array strictly contains 6 elements (indices 0 through 5). However,
> bcom_psc_gen_bd_rx_init() checks the psc_num index against
> MPC52xx_PSC_MAXNUM:
>
> drivers/dma/bestcomm/gen_bd.c:bcom_psc_gen_bd_rx_init() {
>         if (psc_num >=3D MPC52xx_PSC_MAXNUM)
>                 return NULL;
>
>         ...
>         bcom_psc_params[psc_num].rx_initiator,
>         ...
> }
>
> If CONFIG_PPC_MPC512x is enabled, MPC52xx_PSC_MAXNUM can be 12, allowing =
an
> index up to 11 to access the 6-element bcom_psc_params[].
>
> Additionally, bcom_psc_gen_bd_tx_init() appears to perform no bounds chec=
king
> on psc_num at all before indexing this array. Callers like
> mpc5200_audio_dma_create() can pass an unvalidated cell-index from the
> device tree directly into these functions.
>
> Can a malformed device tree trigger out-of-bounds memory reads here, lead=
ing
> to out-of-bounds MMIO writes when using the read garbage as the initiator
> and ipr?
Fixed in different patch.
>
> >       [0] =3D {
> >               .rx_initiator =3D BCOM_INITIATOR_PSC1_RX,
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530012554.68=
605-1-rosenp@gmail.com?part=3D1

