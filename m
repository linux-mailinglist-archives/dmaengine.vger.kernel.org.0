Return-Path: <dmaengine+bounces-9903-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHCFN+XH1GlbxQcAu9opvQ
	(envelope-from <dmaengine+bounces-9903-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 11:01:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 981513ABAE3
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 11:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5A93301469D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7F939B963;
	Tue,  7 Apr 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSPYSd+p"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5F39B960
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552400; cv=pass; b=mPNyguQchi87l1o+RIZ+lRdmxj5tge7KGaMO0Ef7/b7cxI0VvIvMpr1+Z67xjQ4HrLaRNtLhsXMkpDPlakaa51N9WiJGl/3ENpwCVfGNwHoLDB95K+YYPndnSMAVaptei9qLJnCKuUaEukZTk76HZLZf2tdxmUEii0obN95CrxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552400; c=relaxed/simple;
	bh=25yQAIFt7Ha3kKfsPY3wnNdVrSBPt9Jwl6avN4mv/d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGh6MFLGWkn6epICAdbNOg3MK1l19s+/PMkpr3SjXR1vAXyilCTtab0777GQDBZRfWn++VutVINwVcgLgjpBN7VFFAz3BypXIxKxz+JbroUC4Ydy2h8oY6gwUvuJxhWrePKtydilteLWo0I+1+hUh8xPle14lJ4xkdIthOgbMc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSPYSd+p; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76b6f9a50eso1556565a12.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 01:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775552398; cv=none;
        d=google.com; s=arc-20240605;
        b=KIbkX1TwARp9uKAm9aQZ1D6Dq8MDErcvQClEFV7pO0Z7SKsWcANcxgBHll3I/KxybR
         ykhaBdJFovZW2xiZVY1QUB9ShM3ikR/tIEAFMPndBKdK2gC5D+ayzJV7Vooo2CxRT70R
         invEl8m4Pe7B9deTRidJsShjN7LdDUcKoFT7g5xQQqOZ0Rr7BwN91ueb1LwmLRjv84ix
         xGfRjH/7wbim0oagRqROlPEIaYLMSmj+LLh2Tch0nWXo1iHczXFxiL1JsvlcgB9h4MHE
         FVvmvlh9bWqgyBlQLnaeZbifz/AZt2t2tQE7qEKI4sB9hmcnWa8ZFsHKMthkqWKnXc2R
         6rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1FUUrHlD4/8A6iagGC51ep+aqzKDjd9WvkYuFmV48gE=;
        fh=Yi7eOTghzdFG6NJHz2mOre4oisJTUWlw8bmfmczhWBg=;
        b=hgTUgLx9X69xqAshevbzjbayLioF274BZhsOCRFFVgyjgxNXyvn6Cjy6kYLuJJURh4
         oT4n6d4Ce6owu5iEa6u/xxh7SXqcmgxkDh88r7cJGByfeBrqv3J5fDRHlFQNON/R5vdi
         BnVwBM9Kd8nTp9TEQdGerQwjCQz91ffvF7NySP8VF9iR0tXFuM/KipN7npPHddHW4X7A
         ZS660Y5S/fVDFpDaF5sP2HNs4KLtgaoJdojNIYWPDlCilsALKGtjJNaTzCqDhFu/kJ88
         AS5pHM/VlEZTZI9mH02qDt1fTFpk9fhRabQOZz8vNSoMXgErCK629Hnldqfn8Gb93n8S
         rKbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775552398; x=1776157198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FUUrHlD4/8A6iagGC51ep+aqzKDjd9WvkYuFmV48gE=;
        b=JSPYSd+pcRXWDsYkKf+4M1tFdnhlvASOo9s2gTAC3FExMhwNmgPaafzqIJhsTdyLWN
         F0zTa/7ZnYWfQYuyiNVBA/JguUrrVzpmxeHtL5J6584tPAjsuIKIF8MAlNFrVBuMlkXA
         DawJRETIbPSdUITAVhU3lNfr6QwzrXQtsUwkxtNuYXj0JkowYJrBLq8fmdwg6D5zOk/p
         OYNcFDFnkCV6/4rLagPtjcLdBU0GhwLjSDIT/m/r2q2I5IkupnrHmieSjugOO0pCbi1l
         ioeO8eIAMefFzATb5sM+SPDRU/zqcH05IKacUGTgp7ekfgJ/gYF7KWqqb44Ngw387nyp
         dUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775552398; x=1776157198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1FUUrHlD4/8A6iagGC51ep+aqzKDjd9WvkYuFmV48gE=;
        b=VugknSwYgcZ8kqYY4G5t2ZoyWKaszrKRr1Rd6K6+oRMV2VLbDM7UGuDnoBbmHyn/j4
         TGwk7Y+jxlo840XzTewIYqmG1G/g/+r7YtpbT/IeEjhh7GYvWPbHS0VuFBF+Pi6dcmpD
         6N+7+765a4BlVx1ob5CP+u8RJ8aUMUf9edIinQ61GRR3w84XWIZkBtxLe6XS+f34o9p3
         4tUw7U4t/yoA30TLMb1czEpbtLCp2dSADr5kh++o1TX5OgClnufkoiXUM6Y6kKtdmIH2
         zOuxSvPlUXPVoe/Q550kx+fTWtemZowW925EmBdOW5q2V+ORGTstR+M0no6Bmgaugzyf
         Fs1A==
X-Forwarded-Encrypted: i=1; AJvYcCUNunxSdwRf8rAim0oNvsx9Zmm0HwfCxOHHstU3D56UIRjg2JMtQ1cYqR1M/OqOOOJgEgR/LvuIaYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8m9cLVFfjXhsaJWGNAMPF76e73rZjPpX+XIxlfdi0E+HRgL9
	Y/3y+8LFQ1dP+mcRzoIOuGH5zMlJl2b6v8ly8jLttI5YuGlZ2VBM0CnMllaeYecdpw2mAjZpF2T
	wVSJzedWe1+QvM+YcfXON2IxUrMSGe5g=
X-Gm-Gg: AeBDiesnO4vFWwdT2dHI5k8j1vz8tyycmSk8dWIOKiLytzFoZWHdpRVMXwShGNcrh5a
	1iePDFgSDGVf1993ms4fKZag2/l1bLwbqtLd9pfL66Tw6kxSp/rmOYRO7XibL16eZikUHMNDv4z
	FLhWrmssdbgiledJUXWwaAxTZlSBrBUHs6yUMLxmk3hvx2c4f6PoK00w9368B36cvweM8qPHcaY
	SdefdGtMTH6eHg0SKPhUhdCOChDr7uxw1i5TfEqrTmw9RmBJ6JLUV0MUiBDiwoda7JWgAzGhknH
	G3372m8=
X-Received: by 2002:a05:6a20:7d9c:b0:39b:f750:a6f5 with SMTP id
 adf61e73a8af0-39f2f096af1mr16119897637.51.1775552398252; Tue, 07 Apr 2026
 01:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407032755.2758049-1-shengjiu.wang@nxp.com> <6r7ih7wz7xn44c7c2ukohy3fgp3tpo222jh7ocxacccrvywz3i@mddoznil6way>
In-Reply-To: <6r7ih7wz7xn44c7c2ukohy3fgp3tpo222jh7ocxacccrvywz3i@mddoznil6way>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 7 Apr 2026 16:59:46 +0800
X-Gm-Features: AQROBzBBoCuAnujBQ031UhhobhyiC_USVqwzk7ad0Ee4NBRI7paALb3klLHUGi8
Message-ID: <CAA+D8AONNCbbH_GLgc80+ac_ozbLUpYv5HWG3VsOYaYeSoEh8w@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: imx-sdma: Refine spba bus searching in probe
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, Frank.Li@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	dmaengine@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9903-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[infradead.org:query timed out,nxp.com:query timed out,pengutronix.de:query timed out];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shengjiuwang@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:url,infradead.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 981513ABAE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 4:31=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.d=
e> wrote:
>
> On 26-04-07, Shengjiu Wang wrote:
> > There are multi spba-busses for i.MX8M* platforms, if only search for
> > the first spba-bus in DT, the found spba-bus may not the real bus of
> > audio devices, which cause issue for sdma p2p case, as the sdma p2p
> > script presently does not deal with the transactions involving two devi=
ces
> > connected to the AIPS bus.
> >
> > Search the SDMA parent node first, which should be the AIPS bus, then
> > search the child node whose compatible string is spba-bus under that AI=
PS
> > bus for the above multi spba-busses case.
>
> Sorry but I've to NACK this, I already fixed it in a more robust way by
> checking the consumer sdma node.
>

I think you refer to this one:
https://lists.infradead.org/pipermail/linux-arm-kernel/2025-September/10618=
24.html

I tested it,  but there is an issue. I replied to that thread, not
sure you received my message.

> +static int sdma_config_spba_slave(struct dma_chan *chan)
> +{
> +       struct sdma_channel *sdmac =3D to_sdma_chan(chan);
> +       struct device_node *spba_bus;
> +       struct resource spba_res;
> +       int ret;
> +
> +       spba_bus =3D of_get_parent(chan->slave->of_node);
With asrc p2p case, the chan is requested by __dma_request_channel(),
that the chan->slave =3D NULL, Then there will be a kernel dump here.

That's the reason I sent this fix.  But if you can fix the above
issue, I am ok to drop
my fix.  or could you review my fix?, which is simpler.

Best regards
Shengjiu Wang

> Regards,
>   Marco
>
>
> > Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device support=
")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - add fixes tag
> > - use __free(device_node) for auto release.
> >
> >  drivers/dma/imx-sdma.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 3d527883776b..36368835a845 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -2364,7 +2364,9 @@ static int sdma_probe(struct platform_device *pde=
v)
> >                       return dev_err_probe(&pdev->dev, ret,
> >                                            "failed to register controll=
er\n");
> >
> > -             spba_bus =3D of_find_compatible_node(NULL, NULL, "fsl,spb=
a-bus");
> > +             struct device_node *sdma_parent_np __free(device_node) =
=3D of_get_parent(np);
> > +
> > +             spba_bus =3D of_get_compatible_child(sdma_parent_np, "fsl=
,spba-bus");
> >               ret =3D of_address_to_resource(spba_bus, 0, &spba_res);
> >               if (!ret) {
> >                       sdma->spba_start_addr =3D spba_res.start;
> > --
> > 2.34.1
> >
> >
> >
>
> --
> #gernperDu
> #CallMeByMyFirstName
>
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    =
|
>

