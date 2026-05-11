Return-Path: <dmaengine+bounces-10299-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF6mElAmAmpooQEAu9opvQ
	(envelope-from <dmaengine+bounces-10299-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 20:56:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AB514BF4
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 20:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541DB302A2FD
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58D4C9008;
	Mon, 11 May 2026 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsXWUjby"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A64C9019
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525760; cv=none; b=eO3tZWBsearE4+kcS2B/y6xVsPF6F59ltx2dM/+N+97q/UlV/PJ3IBKKU8WFfwbrIXAYVWR8R99/tlUFXvUebpu5nPnUnA6OKHP+oxtvH5PD4N7LoPlOM1x+jAAR+QeQ7ZneR4/JydXa8MNEFfj3W2n/tGuxyr61q2k98Rw2rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525760; c=relaxed/simple;
	bh=zIB79Xk6boPPhMmzQH/JqpB68ofRCBiWIY7ln6Jka+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ST3jdktf93y/8BrWkWq8XtAEDV1sSHqCvE2sleiw3w185pLUENJjqJrw04CbWtPCE+0oOwGPDSUlVcY5rWdgP01P6Dujuzj39uunfUqWBTeSFxZAvgvqVMynCbFe67HhREJKO6tccBaPrr5+dzKEfzRI1nMe/Ya6qYvTELrTbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsXWUjby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9837BC2BD01
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778525760;
	bh=zIB79Xk6boPPhMmzQH/JqpB68ofRCBiWIY7ln6Jka+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gsXWUjbyow7NEAQM0X0NALFGmQpalpbS9xBt2Q8RvtDLJbAfXJJkychRH7mExvXH3
	 wLvWHyJefAS26wLfKstTSKg4fpYzXUzP9z8dBvpeunIG7OR8L+kw39IhzmarZrdw/h
	 btm81FfGDWtRy7mD9/ufgpqgi4b5BojlFQrrwerXbOl2YVC1Ogd4soD3R18nrQrEhG
	 nDr0emt/gHeMqaLpCF0fBYUdU7KS4/fQWh/w8yFK16D23lmWQHLQ/HbuI5h5SUrqtG
	 w7slVsBwfjrHsBXY80jeoLoXsCFsndGoqWJdNItHUlKljlND4E3ff8s1IBMBD4kXtw
	 okmwUrKGPyRTw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a88db610ccso5430541e87.2
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 11:56:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9WJjD2PJpwPqWJhI2+pPjD8U97NOiY8cQ1OHtdnNStIpyV86ngQ2NWmt1eTK6Zo67SYTpbiqHxT0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjlRM4/dkGY3TEPkKVpTxbdo2GxWG1DmCi+NYL+rHb1OskT/f
	7z+St6IH1qov2YZDQJWOOZryWfj7bYyGvF/EmB/XSSuRrAunZR5OhCjsg1q5nkoNL2Kpa6rQTUh
	luPeQVaOOOaoSTX6pIpJy1UVPlPKsHWk=
X-Received: by 2002:a05:6512:3ba4:b0:5a8:63e0:cd92 with SMTP id
 2adb3069b0e04-5a8b709be01mr3083162e87.33.1778525758018; Mon, 11 May 2026
 11:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511165942.2774868-1-robh@kernel.org>
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 20:55:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLkmoN3iY=d5TgkLswgEt4Dgx_j3BAJPX-ASL+VnF_EzHw@mail.gmail.com>
X-Gm-Features: AVHnY4LWa20oUaE1F0JxYrIcNTXFA3pQESxY2XotgaPrY2W88xHdQsN2xv93t9I
Message-ID: <CAD++jLkmoN3iY=d5TgkLswgEt4Dgx_j3BAJPX-ASL+VnF_EzHw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Consolidate "sram" property definition
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
	Akhil P Oommen <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Vinod Koul <vkoul@kernel.org>, 
	Nas Chung <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mirela Rabulea <mirela.rabulea@nxp.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Heiko Stuebner <heiko@sntech.de>, 
	Hugues Fruchet <hugues.fruchet@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Parvathi Pudi <parvathi@couthit.com>, Mohan Reddy Putluru <pmohan@couthit.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michal Simek <michal.simek@amd.com>, 
	Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, "Andrew F. Davis" <afd@ti.com>, 
	Hussain Khaja <basharath@couthit.com>, Suman Anna <s-anna@ti.com>, 
	Ben Levinsky <ben.levinsky@amd.com>, Tanmay Shah <tanmay.shah@amd.com>, 
	Erwan Leray <erwan.leray@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Roger Quadros <rogerq@ti.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, dmaengine@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B81AB514BF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,chipsnmedia.com,collabora.com,vanguardiasur.com.ar,sntech.de,foss.st.com,lunn.ch,davemloft.net,google.com,redhat.com,ti.com,couthit.com,linaro.org,baylibre.com,googlemail.com,amd.com,nbd.name,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10299-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[79];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 6:59=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> The "sram" property has become a de facto standard property, so create a
> common schema for it and drop all the duplicated definitions.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

I like it.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

